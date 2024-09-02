-- A. Pizza Metrics

-- 1. How many pizzas were ordered?
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM customer_orders;

-- 2. How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM customer_orders;

-- 3. How many successful orders were delivered by each runner?
SELECT runner_id, COUNT(DISTINCT order_id) AS successful_orders
FROM runner_orders
WHERE cancellation = ''
GROUP BY runner_id;

-- 4. How many of each type of pizza was delivered?
SELECT p.pizza_name, COUNT(c.pizza_id) AS pizzas_delivered
FROM customer_orders c
JOIN pizza_names p ON c.pizza_id = p.pizza_id
GROUP BY p.pizza_name;

-- 5. How many Vegetarian and Meatlovers were ordered by each customer?
SELECT c.customer_id,
       SUM(CASE WHEN p.pizza_name = 'Meatlovers' THEN 1 ELSE 0 END) AS meatlovers_count,
       SUM(CASE WHEN p.pizza_name = 'Vegetarian' THEN 1 ELSE 0 END) AS vegetarian_count
FROM customer_orders c
JOIN pizza_names p ON c.pizza_id = p.pizza_id
GROUP BY c.customer_id;

-- 6. What was the maximum number of pizzas delivered in a single order?
SELECT order_id, COUNT(pizza_id) AS pizzas_in_order
FROM customer_orders
GROUP BY order_id
ORDER BY pizzas_in_order DESC
LIMIT 1;

-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT customer_id,
       COUNT(DISTINCT CASE WHEN exclusions <> '' OR extras <> '' THEN order_id END) AS pizzas_with_changes,
       COUNT(DISTINCT CASE WHEN exclusions = '' AND extras = '' THEN order_id END) AS pizzas_without_changes
FROM customer_orders
GROUP BY customer_id;

-- 8. How many pizzas were delivered that had both exclusions and extras?
SELECT COUNT(DISTINCT order_id) AS pizzas_with_both_exclusions_and_extras
FROM customer_orders
WHERE exclusions <> '' AND extras <> '';

-- 9. What was the total volume of pizzas ordered for each hour of the day?
SELECT HOUR(order_time) AS hour_of_day, COUNT(*) AS total_pizzas
FROM customer_orders
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- 10. What was the volume of orders for each day of the week?
SELECT DAYNAME(order_time) AS day_of_week, COUNT(*) AS total_orders
FROM customer_orders
GROUP BY day_of_week
ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- B. Runner and Customer Experience

-- 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT
    YEARWEEK(registration_date, 1) AS week,
    COUNT(runner_id) AS signups
FROM runners
GROUP BY YEARWEEK(registration_date, 1);

-- 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT
    runner_id,
    AVG(TIMESTAMPDIFF(MINUTE, pickup_time, NOW())) AS avg_pickup_time
FROM runner_orders
GROUP BY runner_id;

-- 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
SELECT
    num_pizzas,
    AVG(prep_time) AS avg_prep_time
FROM (
    SELECT
        co.order_id,
        COUNT(co.pizza_id) AS num_pizzas,
        AVG(TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time)) AS prep_time
    FROM customer_orders co
    JOIN runner_orders ro ON co.order_id = ro.order_id
    GROUP BY co.order_id
) AS order_prep
GROUP BY num_pizzas;



-- 4. What was the average distance travelled for each customer?
SELECT
    co.customer_id,
    AVG(COALESCE(CAST(REPLACE(ro.distance, ' km', '') AS DECIMAL), 0)) AS avg_distance
FROM runner_orders ro
JOIN customer_orders co ON ro.order_id = co.order_id
GROUP BY co.customer_id;



-- 5. What was the difference between the longest and shortest delivery times for all orders?
SELECT
    MAX(TIMESTAMPDIFF(MINUTE, pickup_time, NOW())) - MIN(TIMESTAMPDIFF(MINUTE, pickup_time, NOW())) AS delivery_time_range
FROM runner_orders;

-- 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT
    runner_id,
    AVG(COALESCE(CAST(REPLACE(distance, ' km', '') AS DECIMAL), 0) / (TIMESTAMPDIFF(MINUTE, pickup_time, NOW()) / 60)) AS avg_speed
FROM runner_orders
GROUP BY runner_id;

-- 7. What is the successful delivery percentage for each runner?
SELECT
    runner_id,
    (SUM(CASE WHEN cancellation = '' THEN 1 ELSE 0 END) / COUNT(order_id) * 100) AS successful_delivery_percentage
FROM runner_orders
GROUP BY runner_id;

-- Additional Questions

-- 8. Total number of orders made each day
SELECT
    DATE(order_time) AS order_date,
    COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY DATE(order_time);

-- 9. The average number of pizzas per order
SELECT
    AVG(pizza_count) AS avg_pizzas_per_order
FROM (
    SELECT
        order_id,
        COUNT(pizza_id) AS pizza_count
    FROM customer_orders
    GROUP BY order_id
) sub;

-- 10. Total distance covered by each runner
SELECT
    runner_id,
    SUM(COALESCE(CAST(REPLACE(distance, ' km', '') AS DECIMAL), 0)) AS total_distance
FROM runner_orders
GROUP BY runner_id;

-- 11. Average delivery duration for each runner
SELECT
    runner_id,
    AVG(TIMESTAMPDIFF(MINUTE, pickup_time, NOW())) AS avg_delivery_duration
FROM runner_orders
GROUP BY runner_id;

-- 12. Number of deliveries with cancellations per runner
SELECT
    runner_id,
    COUNT(order_id) AS cancelled_deliveries
FROM runner_orders
WHERE cancellation <> ''
GROUP BY runner_id;

-- 13. Number of successful deliveries per runner
SELECT
    runner_id,
    COUNT(order_id) AS successful_deliveries
FROM runner_orders
WHERE cancellation = ''
GROUP BY runner_id;

-- 14. Calculate the average time between order placement and pickup for each order in minute
SELECT
    ro.order_id,
    AVG(TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time)) AS avg_time_between_order_and_pickup
FROM runner_orders ro
JOIN customer_orders co ON ro.order_id = co.order_id
GROUP BY ro.order_id;


-- 15. Most common cancellation reason for deliveries
SELECT
    cancellation,
    COUNT(*) AS count
FROM runner_orders
WHERE cancellation <> ''
GROUP BY cancellation
ORDER BY count DESC;



-- C. Ingredient Optimisation

-- 1. What are the standard ingredients for each pizza?
SELECT
    pn.pizza_name,
    GROUP_CONCAT(pt.topping_name ORDER BY pt.topping_name SEPARATOR ', ') AS standard_ingredients
FROM pizza_names pn
JOIN pizza_recipes pr ON pn.pizza_id = pr.pizza_id
JOIN pizza_toppings pt ON FIND_IN_SET(pt.topping_id, pr.topping_id) > 0
GROUP BY pn.pizza_name;



-- 2. What was the most commonly added extra?
SELECT
    extras,
    COUNT(*) AS count
FROM customer_orders
WHERE extras IS NOT NULL AND extras <> ''
GROUP BY extras
ORDER BY count DESC
LIMIT 1;

-- 3. What was the most common exclusion?
SELECT
    exclusions,
    COUNT(*) AS count
FROM customer_orders
WHERE exclusions IS NOT NULL AND exclusions <> ''
GROUP BY exclusions
ORDER BY count DESC
LIMIT 1;

-- 4. Generate an order item for each record in the customer_orders table in the format of:
-- "Pizza Name - Exclude [Exclusions] - Extra [Extras]"
SELECT
    pn.pizza_name,
    CONCAT(
        pn.pizza_name,
        IFNULL(CONCAT(' - Exclude ', co.exclusions), ''),
        IFNULL(CONCAT(' - Extra ', co.extras), '')
    ) AS order_item
FROM customer_orders co
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id;

-- 5. Generate an alphabetically ordered comma separated ingredient list for each pizza order
-- and add a 2x in front of any relevant ingredients
-- Ensure to replace `topping_ids` with the actual column name in `pizza_recipes`
SELECT
    co.order_id,
    CONCAT(
        pn.pizza_name,
        ': ',
        GROUP_CONCAT(
            CASE
                -- Check if the topping is included in the order
                WHEN FIND_IN_SET(pt.topping_id, pr.topping_id) > 0 THEN
                    CONCAT('2x', pt.topping_name)
                ELSE
                    pt.topping_name
            END
            ORDER BY pt.topping_name
            SEPARATOR ', '
        )
    ) AS ingredient_list
FROM customer_orders co
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
JOIN pizza_recipes pr ON pn.pizza_id = pr.pizza_id
JOIN pizza_toppings pt ON FIND_IN_SET(pt.topping_id, pr.topping_id) > 0
GROUP BY co.order_id;


-- 6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
SELECT
    pt.topping_name,
    COUNT(*) AS quantity
FROM pizza_toppings pt
JOIN pizza_recipes pr ON pt.topping_id = pr.topping_id
JOIN customer_orders co ON FIND_IN_SET(pt.topping_id, pr.topping_id)
GROUP BY pt.topping_name
ORDER BY quantity DESC;

-- 7. What is the total number of unique pizzas ordered?
SELECT
    COUNT(DISTINCT pizza_id) AS total_unique_pizzas
FROM customer_orders;

-- 8. What was the most common pizza ordered?
SELECT
    pn.pizza_name,
    COUNT(*) AS order_count
FROM customer_orders co
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
GROUP BY pn.pizza_name
ORDER BY order_count DESC
LIMIT 1;

-- 9. What are the most popular toppings across all orders?
SELECT
    pt.topping_name,
    COUNT(*) AS topping_count
FROM pizza_toppings pt
JOIN pizza_recipes pr ON pt.topping_id = pr.topping_id
JOIN customer_orders co ON FIND_IN_SET(pt.topping_id, pr.topping_id)
GROUP BY pt.topping_name
ORDER BY topping_count DESC;

-- 10. What is the average number of toppings per pizza ordered?
SELECT
    AVG(num_toppings) AS avg_toppings
FROM (
    SELECT
        co.order_id,
        COUNT(pt.topping_id) AS num_toppings
    FROM customer_orders co
    JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
    JOIN pizza_recipes pr ON pn.pizza_id = pr.pizza_id
    JOIN pizza_toppings pt ON FIND_IN_SET(pt.topping_id, pr.topping_id)
    GROUP BY co.order_id
) AS toppings_per_pizza;

-- 11 . Calculate the total revenue including $1 for cheese if it is included in extras

SELECT
    SUM(
        CASE
            WHEN pn.pizza_name = 'Meat Lovers' THEN 12
            WHEN pn.pizza_name = 'Vegetarian' THEN 10
            ELSE 0
        END
        + (CASE WHEN co.extras LIKE '%Cheese%' THEN 1 ELSE 0 END)
    ) AS total_revenue
FROM customer_orders co
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id;

