import { useSWRConfig } from "swr";
import { api } from "../utils/api";

export default function TaskItem({task}) {
  const {mutate} = useSWRConfig();
  const isComplete = task.status === "completed";

  const taskChecked = async() => {
    const nextStatus = isComplete ? "incomplete" : "completed";

    try{
      await api.patch(`/tasks/${task.id}`, {
        task: { status: nextStatus}
      });
      mutate("/tasks");
    } catch (error) {
      alert("更新に失敗しました")
    }
  };

  const TaskDeleted = async() => {
    if (!window.confirm("このタスクを削除しますか？")) return;

    try {
      await api.delete(`/tasks/${task.id}`);
      mutate("/tasks")
    } catch(error) {
      alert ("削除に失敗しました");
    }
  };

  return (
    <div className="card border-2 border-gray-400 w-96 shadow-sm">
      <div className="card-body">
        <div className={isComplete ? "line-through text-gray-400" : ""}>
          <h2 className="card-title">{task.title}
            <span className="badge badge-outline">{task.category.name}</span>
          </h2>
          <p>{task.description}</p>
        </div>
        <div className="card-actions justify-end">
          <button className="btn btn-primary" onClick={taskChecked}>{isComplete ? "完了" : "未完了"}</button>
          <button className="btn btn-error" onClick={TaskDeleted}>削除</button>
        </div>
      </div>
    </div>
  );
}