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
	$num = $result->numColumns();
	$arr = array();
	for ($i = 0; $i < $num; $i++) {
		array_push($arr, $result->columnName($i));
	}
	foreach ($arr as $val) {
		echo "$val ";
	}
	echo '<br/>';
	while ($row = $result->fetchArray(SQLITE3_ASSOC)){
		foreach ($row as $rvalue) {
			echo $rvalue . " ";
		}
		echo '<br/>';
	}
	unset($db);
	echo "<br/> The last query was: $query";
}
?>
