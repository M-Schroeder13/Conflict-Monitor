FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create data directory
RUN mkdir -p data

# Expose ports
EXPOSE 8501 3000

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DAGSTER_HOME=/app

# Default command
CMD ["dagster", "dev", "-h", "0.0.0.0"]
