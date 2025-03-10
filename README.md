# Dinner Time Application

This application is hosted on a **DigitalOcean Droplet** and accessible at:

➡️ [freddy-dev.es](http://freddy-dev.es)

---

## 🚀 Tech Stack

- **Ruby version**: `2.7.7`
- **Rails version**: `7.1`
- **PostgreSQL version**: `12`

---

## ⚙️ Local Setup

### 1. Clone the Repository

```bash
git clone https://github.com/fgonzalezp/dinner-time.git
cd dinner_time
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Set Up Environment Variables

Create a `.env` file in the project root with the following content:

```env
DB_NAME=your_database_name
DB_USER=your_database_user
DB_PASSWORD=your_database_password
```

> ⚠️ **Note**: Replace the placeholder values with your actual database credentials.

### 4. Set Up the Database

Run the following commands to prepare the database:

```bash
rake db:create
rake db:migrate
rake db:seed
```

- `db:create`: Creates the development and test databases.
- `db:migrate`: Runs all database migrations.
- `db:seed`: Populates the database with initial seed data.

### 5. Run the Application

Start the Rails server with:

```bash
rails server
```

The application will be available at:

```
http://localhost:3000
```

---

## 🧪 Testing Use Cases

### Use Case 1: Find recipes containing one or more of the ingredients

1. Go to the root of the application.
2. Type in the search field the recipe ingredients, pressing enter after finishing typing each ingredient.
3. Click search.

### Use Case 2: Find recipes containing all ingredients

1. Go to the root of the application.
2. Type in the search field the recipe ingredients, pressing enter after finishing typing each ingredient.
3. Check **Only recipes containing all ingredients**.
4. Click search.

---

## ✅ Additional Notes

- Ensure **PostgreSQL** is installed and running on your local machine.
- If you're using a tool like `rbenv`, make sure Ruby `2.7.7` is correctly set.
- To manage environment variables securely, consider using the [`dotenv`](https://github.com/bkeepers/dotenv) gem.

