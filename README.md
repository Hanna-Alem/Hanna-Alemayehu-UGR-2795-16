Name: Hanna Alemayehu ID:UGR/2795/16

# Recipe Archive

A Flutter recipe archive, responsive cookbook application, featuring dynamic category filtering, a real-time search engine, and full day/night theme toggle functionality.

## Core Features

Smart Search Bar: Located directly in the top header, allowing users to filter recipes instantly by title keywords as they type.

Dual-View Theme Toggle: A one-tap adaptive engine that flips the entire interface seamlessly between a crisp Light Mode and an accessible Dark Mode.

Dynamic Sidebar Navigation: A vertical category menu running down the left panel that instantly filters cards by culinary groups (e.g., Seafood, Dessert, Japanese, Drinks, Chinese, Italian, and Fast Food).

##  Application Pages
1. Recipe List Screen (Dashboard)
The main hub of the application utilizes a split-screen structural layout:

Left Panel: A static vertical navigation bar hosting individual category filters alongside a master "All" selector. Clicking an option dynamically updates the main grid.

Right Panel: A responsive, two-column grid displaying compact recipe asset cards. Each card displays a high-positioned circular utensil avatar, the recipe title, a subtle category badge, and minimalist text actions for quick access.

Bottom Grid Actions: Built-in Edit and Delete text buttons are tightly bound into the bottom edge of every individual card for immediate, inline modification.

2. Recipe Detail Screen
When a user taps any card from the main grid, this screen provides an immersive, distraction-free reading experience:

Header Profile Banner: Displays a large circular utensil avatar alongside the recipe title, framed within an elegant, tinted mauve accent card block.

Ingredients Block: Renders required items cleanly inside a flat, neutral-gray background card to separate components visually.

Cooking Instructions Block: Spreads out sequential preparation steps using spacious text formatting for comfortable readability in the kitchen.

3. Recipe Form Screen (Add / Edit)
A centralized input system that handles both adding new recipes and modifying existing entries dynamically:

Includes input validation fields for the Recipe Title, Ingredients, and Cooking Instructions.

Features a built-in Dropdown Selector Form Block to assign a strict culinary category tag to the recipe.

Automatically splits and packs distinct ingredient text pools from step-by-step instruction lines back into the backend API dataset on submission.




## screenshots of the runnung flutter

the search bar
<img width="675" height="630" alt="search bar" src="https://github.com/user-attachments/assets/3d141194-88eb-46a8-95bf-a78c72239a7d" />
the recipe details screen
<img width="678" height="637" alt="recipe details screen" src="https://github.com/user-attachments/assets/b26c8e33-7202-47a4-8f86-61f767d9469f" />
light mode
<img width="681" height="634" alt="light mode home screen" src="https://github.com/user-attachments/assets/35489a12-f077-448b-97ee-888cf0adab85" />
the edit details screen
<img width="663" height="579" alt="edit screen" src="https://github.com/user-attachments/assets/73912e50-6d67-495a-8840-1579f99bc5b4" />
catagory filter
<img width="680" height="632" alt="desserts" src="https://github.com/user-attachments/assets/ac7a1981-3235-4c9e-a4d4-716f9d9b622f" />
dark mode
<img width="679" height="626" alt="dark mode" src="https://github.com/user-attachments/assets/846c543d-8101-49b5-b542-5274fbc6042d" />
add new recipe page
<img width="539" height="597" alt="add new recipe screen" src="https://github.com/user-attachments/assets/1c091dfc-9f62-49de-8e2c-1e7890fae715" />

