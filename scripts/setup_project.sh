#!/bin/bash

echo "Setting up Conflict Zone Monitor..."

# Check Python version
python_version=$(python3 --version 2>&1 | awk '{print $2}')
echo "Python version: $python_version"

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Create .env file
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cp .env.example .env
    echo "Please edit .env with your API keys"
fi

# Initialize database
echo "Initializing database..."
python config/init_database.py

# Create data directories
echo "Creating directories..."
mkdir -p data backups logs

echo "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .env with your API credentials"
echo "  2. Activate virtual environment: source venv/bin/activate"
echo "  3. Authenticate Telegram: python dlt_pipelines/telegram_auth.py"
echo "  4. Run first pipeline: python dlt_pipelines/acled_source.py"
echo "  5. Start dashboard: streamlit run dashboard/app.py"
