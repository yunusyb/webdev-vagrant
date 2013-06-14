<html>
<head><title>Hello world</title></head>
<body>
<div>
<?php
echo $_SERVER['SERVER_NAME'] . ' - '. $_SERVER['SERVER_ADDR'] . ' - ' . date(DATE_RFC822);
?>
</div>
<a href="phpinfo.php">phpinfo</a>
</body>
</html>
