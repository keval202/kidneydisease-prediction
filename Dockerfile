FROM python:3.10.19-slim

# Set environment variables for better performance
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

# Copy requirements first for Docker layer caching
COPY requirements.txt setup.py README.md ./
COPY src/ ./src/

# Install dependencies + install cnnClassifier package
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir -e .

# Copy the rest of the application
COPY . .

EXPOSE 8080
CMD ["python3", "app.py"]