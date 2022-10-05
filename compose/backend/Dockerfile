FROM python:3.9.6-alpine3.14

# Add main directory
WORKDIR /app

# Add source code
COPY . .

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Run the app
CMD ["python", "app.py"]
