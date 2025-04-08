# Use a compatible Python version
FROM python:3.8-slim

# Set working directory inside the container
WORKDIR /app

# Install required build tools for spaCy 2.3.5
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy dependencies and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Optional: Download spaCy model (if needed)
# RUN python -m spacy download en_core_web_sm

# Copy the rest of the app
COPY . .

# Expose Streamlit's default port
EXPOSE 8502

# Run the Streamlit app
CMD ["streamlit", "run", "app/app.py", "--server.port=8502", "--server.enableCORS=false"]