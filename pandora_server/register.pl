#!/usr/bin/perl
use strict;
use warnings;
use utf8;

use lib '/usr/lib/perl5';

use PandoraFMS::Tools;
use PandoraFMS::DB;
use PandoraFMS::Core;
use PandoraFMS::Config;

my %conf;
$conf{"quiet"} = 0;
$conf{"verbosity"} = 1;
$conf{"daemon"}=0;
$conf{'PID'}="";
$conf{'pandora_path'} = '/etc/pandora/pandora_server.conf';

# Read config file
pandora_load_config (\%conf);

my $dbh = db_connect ('mysql', $conf{'dbname'}, $conf{'dbhost'}, $conf{'dbport'}, $conf{'dbuser'}, $conf{'dbpass'});

my $agent_id = get_agent_id($dbh, "pandora_agent");
if ($agent_id == -1) {
  $agent_id = pandora_create_agent(
    \%conf, $conf{servername}, "pandora_agent", "", 10, 0, 1, '', 300, $dbh
  );
}

my $module_id = get_db_value(
  $dbh,
  "SELECT id_agente_modulo FROM tagente_modulo WHERE id_agente = ? AND nombre = ?",
  $agent_id, safe_input('web 監視 (ポート)')
);
if (!defined($module_id)) {
  my $parameters = {
    id_agente => $agent_id,
    id_tipo_modulo => 9,
    nombre => safe_input('web 監視 (ポート)'),
    descripcion => safe_input('tcp://pandora_agent:3000/ への GET リクエストに対して 200 OK が返るかを監視'),
    module_interval => 300,
    tcp_port => 3000,
    tcp_send => safe_input("GET / HTTP/1.1^M^M"),
    tcp_rcv => safe_input("200 OK"),
    ip_target => 'pandora_agent',
    id_module_group => 0,
    flag => 0,
    id_modulo => 2,
    disabled_types_event => '{"going_unknown":1}',
  };
  $module_id = pandora_create_module_from_hash(\%conf, $parameters, $dbh);
}

my @plugins = (
  {
    name => 'web 監視プラグイン (curl)',
    description => '',
    execute => '/bin/sh',
    plugin_type => 0,
    parameters => '-c \'curl -sf --connect-timeout _field2_ "_field1_" > /dev/null && echo 1 || echo 0\'',
    macros => '{"1":{"macro":"_field1_","desc":"URL","help":"対象サイトの&#x20;URL","value":"","hide":""},"2":{"macro":"_field2_","desc":"タイムアウト","help":"タイムアウト値&#x20;&#x0d;&#x0a;&#40;pandora_server.conf&#x20;の&#x20;plugin_timeout&#x20;とプラグインの最大タイムアウトより小さくする必要があります。&#41;","value":"10","hide":""}}',
    module_name => 'web 監視 (curl)',
    module_description => 'http://pandora_agent:3000/ のレスポンスコードが正常かを監視',
    module_plugin_macros => '{"1":{"macro":"_field1_","desc":"URL","help":"対象サイトの&#x20;URL","value":"http://pandora_agent:3000/","hide":""},"2":{"macro":"_field2_","desc":"タイムアウト","help":"タイムアウト値&#x20;&#x0d;&#x0a;&#40;pandora_server.conf&#x20;の&#x20;plugin_timeout&#x20;とプラグインの最大タイムアウトより小さくする必要があります。&#41;","value":"10","hide":""}}',
  },
  {
    name => 'web 監視プラグイン (nagios)',
    description => '',
    execute => '/usr/lib64/nagios/plugins/check_http',
    plugin_type => 1,
    parameters => '-H "_field1_" -p _field2_ -u "_field3_" -t "_field4_" _field5_',
    macros => '{"1":{"macro":"_field1_","desc":"ホスト名","help":"対象&#x20;Web&#x20;サイトのホスト名","value":"","hide":""},"2":{"macro":"_field2_","desc":"ポート","help":"対象&#x20;Web&#x20;サイトのポート","value":"80","hide":""},"3":{"macro":"_field3_","desc":"パス","help":"対象&#x20;Web&#x20;サイトのパス","value":"/","hide":""},"4":{"macro":"_field4_","desc":"タイムアウト","help":"タイムアウト値&#x0d;&#x0a;&#40;pandora_server.conf&#x20;の&#x20;plugin_timeout&#x20;とプラグインの最大タイムアウトより小さくする必要があります。&#41;","value":"10","hide":""},"5":{"macro":"_field5_","desc":"その他のオプション","help":"check_http&#x20;に渡すオプション","value":"","hide":""}}',
    module_name => 'web 監視 (nagios)',
    module_description => 'http://pandora_agent:3000/ に対する応答を Nagios プラグインで監視',
    module_plugin_macros => '{"1":{"macro":"_field1_","desc":"ホスト名","help":"対象&#x20;Web&#x20;サイトのホスト名","value":"pandora_agent","hide":""},"2":{"macro":"_field2_","desc":"ポート","help":"対象&#x20;Web&#x20;サイトのポート","value":"3000","hide":""},"3":{"macro":"_field3_","desc":"パス","help":"対象&#x20;Web&#x20;サイトのパス","value":"/","hide":""},"4":{"macro":"_field4_","desc":"タイムアウト","help":"タイムアウト値&#x0d;&#x0a;&#40;pandora_server.conf&#x20;の&#x20;plugin_timeout&#x20;とプラグインの最大タイムアウトより小さくする必要があります。&#41;","value":"10","hide":""},"5":{"macro":"_field5_","desc":"その他のオプション","help":"check_http&#x20;に渡すオプション","value":"","hide":""}}',
  },
  {
    name => 'web 監視プラグイン (selenese-runner + chromedriver)',
    description => '',
    execute => '/opt/selenese/selenese-runner',
    plugin_type => 0,
    parameters => '--driver remote --remote-browser chrome --remote-url http://chromedriver:9515 --cli-args "--no-sandbox" "_field1_"',
    macros => '{"1":{"macro":"_field1_","desc":"テストケースファイル名","help":"","value":"","hide":""}}',
    module_name => 'web 監視 (selenese)',
    module_description => '/opt/testcase/testcase.html を実行して監視',
    module_plugin_macros => '{"1":{"macro":"_field1_","desc":"テストケースファイル名","help":"","value":"/opt/testcase/testcase.html","hide":""}}',
  },
);

for my $plugin (@plugins) {
  my $plugin_id = get_db_value(
    $dbh, "SELECT id FROM tplugin WHERE name = ?", safe_input($plugin->{name})
  );
  if (!defined($plugin_id)) {
    $plugin_id = db_insert($dbh, 'id',
      "INSERT INTO tplugin
        (name, description, max_timeout, max_retries, plugin_type,
         execute, parameters, macros)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      safe_input($plugin->{name}), safe_input($plugin->{description}), 15, 0, $plugin->{plugin_type},
      $plugin->{execute}, safe_input($plugin->{parameters}), $plugin->{macros}
    );
  }
  my $module_id = get_db_value(
    $dbh,
    "SELECT id_agente_modulo FROM tagente_modulo WHERE id_agente = ? AND nombre = ? AND id_plugin = ?",
    $agent_id, safe_input($plugin->{module_name}), $plugin_id
  );
  if (!defined($module_id)) {
    my $parameters = {
      id_agente => $agent_id,
      id_tipo_modulo => 2,
      nombre => safe_input($plugin->{module_name}),
      descripcion => safe_input($plugin->{module_description}),
      module_interval => 300,
      id_module_group => 0,
      flag => 0,
      id_modulo => 4,
      id_plugin => $plugin_id,
      macros => $plugin->{module_plugin_macros},
      disabled_types_event => '{"going_unknown":1}',
    };
    $module_id = pandora_create_module_from_hash(\%conf, $parameters, $dbh);
  }
}
exit 0;
