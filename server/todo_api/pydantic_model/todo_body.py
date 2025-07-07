from typing import Optional
from pydantic import BaseModel


class TodoModel(BaseModel):
    id: Optional[str] = None
    title: Optional[str] = None
    descrption: Optional[str] = None
    is_active: bool = True
