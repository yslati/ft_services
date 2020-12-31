INSERT INTO `wordpress`.`wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES ('2', 'admin', MD5('admin'), 'admin', 'admin@1337.com', '', '2020-12-20 00:00:00', '', '0', 'admin');
INSERT INTO `wordpress`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '2', 'wp_capabilities', 'a:1:{s:13:"Administrator";s:1:"1";}');
INSERT INTO `wordpress`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '2', 'wp_user_level', '10');


INSERT INTO `wordpress`.`wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES ('3', 'user1', MD5('user1'), 'user1', 'user1@1337.com', '', '2020-12-20 00:00:00', '', '0', 'user1');
INSERT INTO `wordpress`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '3', 'wp_capabilities', 'a:1:{s:13:"Editor";s:1:"1";}');
INSERT INTO `wordpress`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '3', 'wp_user_level', '10');


INSERT INTO `wordpress`.`wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES ('4', 'user2', MD5('user2'), 'user2', 'user2@1337.com', '', '2020-12-20 00:00:00', '', '0', 'user2');
INSERT INTO `wordpress`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '4', 'wp_capabilities', 'a:1:{s:13:"Author";s:1:"1";}');
INSERT INTO `wordpress`.`wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, '4', 'wp_user_level', '10');