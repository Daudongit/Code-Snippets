<?php

    //serialize and unserialize array
 file_put_contents(
     'path/to/save/file.php',
     serialize($array_data)
);
$unserialize = unserialize(
    file_get_contents('path/to/save/file.php')
);

//export array
file_put_contents(
    'path/to/save/file.php',
    '<?php return '.var_export( $array_data, true ).";\n"
);

$data = file_get_contents('path/to/save/file.php');