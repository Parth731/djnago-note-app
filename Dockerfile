FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements and install dependencies
COPY requirements.txt /app/backend
RUN pip install -r requirements.txt

# Copy the application code
COPY . /app/backend

# Expose the Django application port
EXPOSE 8000

# Run the Django development server
CMD ["python", "/app/backend/manage.py", "runserver", "0.0.0.0:8000"]
