# Stage 1: Build Stage
FROM python:3.11.3-slim AS build

WORKDIR /app

# Copy the requirements.txt file from the flask_app folder
COPY flask_app/requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code and model files
COPY flask_app /app/
COPY models/vectorizer.pkl  /app/models/vectorizer.pkl

# Download only the necessary NLTK data
RUN python -m nltk.downloader stopwords wordnet

# Download only the necessary spacy data
# RUN python -m spacy download en_core_web_sm

# Stage2. Final stage
FROM python:3.11.3-slim AS final

WORKDIR /app

# Copy installed dependencies (Fix for missing gunicorn)
COPY --from=build /usr/local /usr/local

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Expose the application port
EXPOSE 5000

# Set the command to run the application
CMD [ "gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]