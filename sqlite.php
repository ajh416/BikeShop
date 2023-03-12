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
	while ($row = $result->fetchArray(SQLITE3_ASSOC)){
		foreach ($row as $rvalue) {
			//echo $row['eid'] . ': $' . $row['price'] . '<br/>';
			echo $rvalue . " ";
		}
		echo '<br/>';
	}
	unset($db);
	echo "Your query was: $query";
}
?>
