<html>
<head>
  <title>Hello world</title>
  <style>
    body {
      font: 13px Verdana, Helvetica, Arial, sans-serif;
    }
    .eb_event_list { 
      background: #f0f0f0; 
      width: 220px;
    }
    .eb_event_list_item {
      padding-bottom: 1em;
    }
    .eb_event_list_date {
      width: 100%;
      background: linear-gradient(to bottom, #838c8d 0%,#757374 100%);
      color: #fff;
      font-weight: bold;
      text-align: center;
      font-size: 16px;
      display: block;
      padding: 3px 0px 3px 0px;
    }
    .eb_event_list_time {
      float: right;
      padding: 3px;
    }
    .eb_event_list_title {
      text-decoration: none;
      font-weight: bold;
      display: block;
      padding: 3px;
    }
    .eb_event_list_location {
      display: block;
      font-size: 90%;
      color: #555;
      padding 3px;
    }
  </style>
</head>
<body>
<?php
include "Eventbrite.php";
$authentication_tokens = array( 'app_key' => 'VNNKF7UPUPDQCKL2KE');

$eb_client = new Eventbrite( $authentication_tokens );

try {
  $events = $eb_client->organizer_list_events(array('id'=>'4438534767'));
} catch ( Exception $e ) {
  $events = array();
}

$html = Eventbrite::eventList( $events, 'eventListRow');

print $html;
?>
</body>
</html>
