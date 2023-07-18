 
-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `desc` varchar(255) NOT NULL,
  `consumable` tinyint(1) NOT NULL,
  `metabolismrank` int(3) NOT NULL,
  `solidorliquid` tinyint(1) NOT NULL,
  `medical` tinyint(1) NOT NULL,
  `alcohol` tinyint(1) NOT NULL,
  `valuerank` int(3) NOT NULL,
  `propname` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `metadata`, `desc`, `consumable`, `metabolismrank`, `solidorliquid`, `medical`, `alcohol`, `valuerank`) VALUES
('Alcohol_Alaskan_Gin', 'Alcohol_Alaskan_Gin', 50, 1, 'item_standard', 1, NULL, '{}', 'Alcohol_Alaskan_Gin', 1, 1, 0, 0, 1, 1),
('Consumable_Apple_Cinnamon_Pie', 'Consumable_Apple_Cinnamon_Pie', 50, 1, 'item_standard', 1, NULL, '{}', 'Consumable_Apple_Cinnamon_Pie', 1, 1, 1, 0, 0, 1),
('Consumable_Raspberry_Juice', 'Consumable_Raspberry_Juice', 50, 1, 'item_standard', 1, NULL, '{}', 'Consumable_Raspberry_Juice', 1, 3, 0, 0, 0, 1),
('Consumable_Raspberry_Water', 'Consumable_Raspberry_Water', 50, 1, 'item_standard', 1, NULL, '{}', 'Consumable_Raspberry_Water', 1, 1, 0, 0, 0, 1),
('Consumable_Roasted_Duck', 'Consumable_Roasted_Duck', 50, 1, 'item_standard', 1, NULL, '{}', 'Consumable_Roasted_Duck', 1, 1, 1, 0, 0, 1),
('Consumable_Water', 'Consumable_Water', 50, 1, 'item_standard', 1, NULL, '{}', 'Consumable_Water', 1, 2, 0, 0, 0, 1),
('Consumable_Whole_Milk', 'Consumable_Whole_Milk', 50, 1, 'item_standard', 1, NULL, '{}', 'Consumable_Whole_Milk', 1, 1, 0, 0, 0, 1),
('Medical_Penicilin_Presc', 'Medical_Penicilin_Presc', 50, 1, 'item_standard', 1, NULL, '{}', 'Medical_Penicilin_Presc', 0, 0, 0, 1, 0, 1),
('Ressource_Clay', 'Ressource_Clay', 50, 1, 'item_standard', 1, NULL, '{}', 'Ressource_Clay', 0, 0, 0, 0, 0, 1);
('Seed_Hemp', 'Seed_Hemp', 50, 1, 'item_standard', 1, NULL, '{}', 'Seed_Hemp', 0, 0, 0, 0, 0, 1),
('Supply_Amethyst_Gold_Ring', 'Supply_Amethyst_Gold_Ring', 50, 1, 'item_standard', 1, NULL, '{}', 'Supply_Amethyst_Gold_Ring', 0, 0, 0, 0, 0, 3),
('Tools_Clean_Bucket', 'Tools_Clean_Bucket', 50, 1, 'item_standard', 1, NULL, '{}', 'Tools_Clean_Bucket', 0, 0, 0, 0, 0, 1),
('Tool_Empty_Bucket', 'Tool_Empty_Bucket', 50, 1, 'item_standard', 1, NULL, '{}', 'Tool_Empty_Bucket', 0, 0, 0, 0, 0, 1);
 
ALTER TABLE `items`
  ADD PRIMARY KEY (`item`) USING BTREE,
  ADD UNIQUE KEY `id` (`id`);
 
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;
 