<?php
/*
Plugin Name: Hello World Plugin
Description: A simple plugin to show WordPress scaffold is working.
Version: 1.0
Author: Your Name
*/

function hello_world_message() {
    echo "<p style='color: green;'>Hello World Plugin is active!</p>";
}
add_action('wp_footer', 'hello_world_message');
