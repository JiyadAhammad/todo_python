from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic_model.todo_body import TodoModel


app = FastAPI()


# Add CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/create_todo")
def addNewTodo(body: TodoModel):

    return {
        "status": True,
        "message": "Todo Created Sucesfullty",
        "data": {
            "id": body.id,
            "title": body.title,
            "descrption": body.descrption,
        },
    }
