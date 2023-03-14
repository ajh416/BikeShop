<html>
<head>
  <link rel="stylesheet" href="sqlite.css">
</head>
<body>
<form name='form' method='post' action="sqlite.php">

Query: <input type="text" name="query" id="query" ><br/>

<input type="submit" name="submit" value="Submit">  

</form>
<?php
if((isset($_POST['query'])) && !empty($_POST['query']))
{
	$db = new SQLite3('mydb.sq3');
	$query = $_POST['query'];
	$result = $db->query($query);
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
	while ($row = $result->fetchArray(SQLITE3_ASSOC)){
		echo "<tr>";
		foreach ($row as $rvalue) {
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

</body>
</html>
