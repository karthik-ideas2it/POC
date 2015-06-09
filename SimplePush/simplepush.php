<?php
error_reporting(0);
// Put your device token here (without spaces):
$deviceToken = 'ce6363517aaa8c1912a0356683acde5a9fbaf2936bfd566e666c719de7f4f1ac';

// Put your alert message here:
$message = ($_POST['name'])?$_POST['name']:'Web Feed';
////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', '/Applications/XAMPP/xamppfiles/htdocs/SimplePush/ck.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', 'feed@123');
stream_context_set_option($ctx, 'ssl', 'cafile', 'entrust_2048_ca.cer');
// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.sandbox.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
	'alert' => $message,
	'sound' => 'default'
	);

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg);

if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);

?>
<html>

<body>
    <form name="Feeds" method="post" action="simplepush.php">
        Name :<input type="text" name="name" /> <br/><br/>
        Rights :<input type="text" name="rights"/><br/><br/>
        Description : <input type="text" name="Description"/><br/><br/>
         <input type="submit" name="Send Feed"/>
    </form>
    </body>
</html>