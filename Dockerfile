FROM python:3-slim
WORKDIR /app
RUN pip install --no-cache-dir -r requirements.txt
COPY ./giropops-senhas/ /app
EXPOSE 5000
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0"]
