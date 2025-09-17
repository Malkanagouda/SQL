# 🎣: Clique Bait

## **Key learning points**
* Deal with marketing-related data, i.e data about users online behaviors, events and marketing campaigns
     🍪 
* Use `ORDER BY` within `STRING_AGG` to concatenate strings in the desired order
    * E.g, `STRING_AGG(column_1,',' ORDER BY column 2)`
* Use `MAX` with `CASE WHEN` to flag a column
* Thinking in **Funnel** to analyse customer behavior towards products
    * A product can be viewEd, then added to cart, and lastly purchased, all of which form a funnel
    * The further to the end of this funnel, the fewer product views are added to cart, and the fewer products in cart are actually purchased
