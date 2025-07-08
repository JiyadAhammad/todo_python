from fastapi import FastAPI
from fastapi.responses import JSONResponse
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

all_todo: list[TodoModel] = []


@app.post("/create_todo")
def addNewTodo(body: TodoModel):

    if not body.id:
        if not body.id:
            return JSONResponse(
                status_code=400,
                content={
                    "status": False,
                    "message": "Id is required.",
                },
            )
    elif not body.title:
        return JSONResponse(
            status_code=400,
            content={
                "status": False,
                "message": "Title is required.",
            },
        )
    elif not body.descrption:
        return JSONResponse(
            status_code=400,
            content={
                "status": False,
                "message": "Description is required.",
            },
        )
    else:
        for todo in all_todo:
            if todo.id == body.id:
                return JSONResponse(
                    status_code=400,
                    content={
                        "status": False,
                        "message": "Todo with this ID already exists",
                    },
                )
        all_todo.append(body)
        print(all_todo)
        return {
            "status": True,
            "message": "Todo Created Sucesfullty",
            "data": {
                "id": body.id,
                "title": body.title,
                "descrption": body.descrption,
            },
        }


@app.get("/get_all_todo")
def get_all_todo():
    try:
        active_todos = [todo for todo in all_todo if todo.is_active]
        return {
            "status": True,
            "message": "Todo Retrieve Sucesfullty",
            "data": active_todos,
        }
    except:
        print("An exception occurred")


@app.put("/update_todo")
def modify_todo(body: TodoModel):
    try:
        if not body.id:
            if not body.id:
                return JSONResponse(
                    status_code=400,
                    content={
                        "status": False,
                        "message": "Id is required.",
                    },
                )
        elif not body.title:
            return JSONResponse(
                status_code=400,
                content={
                    "status": False,
                    "message": "Title is required.",
                },
            )
        elif not body.descrption:
            return JSONResponse(
                status_code=400,
                content={
                    "status": False,
                    "message": "Description is required.",
                },
            )
        else:

            for i, item in enumerate(all_todo):
                if item.id == body.id:
                    all_todo[i] = body
                    return {
                        "status": True,
                        "message": "Todo Updated Sucesfullty",
                        "data": {
                            "id": body.id,
                            "title": body.title,
                            "descrption": body.descrption,
                        },
                    }
            return JSONResponse(
                status_code=400,
                content={
                    "status": False,
                    "message": "No result Found",
                },
            )

    except:
        print("An exception occurred ")


@app.delete("/delete_todo/{id}")
def delete_todo(id: str):
    if not id:
        return JSONResponse(
            status_code=400,
            content={
                "status": False,
                "message": "Please Provide Todo id",
            },
        )
    for i, item in enumerate(all_todo):
        if item.id == id:
            all_todo[i].is_active = False
            return {
                "status": True,
                "message": "Todo item Deleted Sucesfullty",
            }
    return JSONResponse(
        status_code=400,
        content={
            "status": False,
            "message": "No result Found",
        },
    )
