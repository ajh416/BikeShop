<html>
<head>
  <link rel="stylesheet" href="OutdoorShop.css">
</head>
<?php
$rand_hex = sprintf("#%06X", mt_rand(0, 0xFFFFFF));
echo "<body style=\"background-color:$rand_hex\">";
?>
<form name='form' method='post' action="OutdoorShop.php" class="inputbox">

Query: <input type="text" name="query" id="query" ><br/>

<input type="submit" name="submit" value="Submit">  

</form>

<div class="center">
<?php
if (isset($_POST['query']) && !empty($_POST['query']))
{
	$db = new SQLite3('OutdoorShop.sq3');
	$query = $_POST['query'];
	$result = $db->query($query);
	if ($result == null) {
		echo "The query didn't return a result set. Please try again.";
		return;
	}
	$arr = array();
	for ($i = 0; $i < $result->numColumns(); $i++) {
		array_push($arr, $result->columnName($i));
	}
	echo "<table>";
	echo "<tr>";
	foreach ($arr as $val) {
		echo "<th>$val</th>";
	}
	echo "</tr>";
	while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
		echo "<tr>";
		foreach ($row as $rvalue) { // calling a variable 'rvalue'...
			if ($rvalue == null)
				$rvalue = "null";
			echo "<td>$rvalue</td>";
		}
		echo "</tr>";
	}
	echo "</table>";
	unset($db);
	echo "<br/> The last query was: $query";
}
?>
</div>
</body>
</html>
