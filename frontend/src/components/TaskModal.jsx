import { useState } from "react";
import useSWR from "swr";
import { api, fetcher } from "../utils/api";

export default function TaskCreateModal() {
  const [title, setTitle] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [description, setDescription] = useState("");
  const [status, setStatus] = useState(0)

  const { data } = useSWR("/categories", fetcher);
  const categories = data?.categories || [];

  const handleCreate = async (e) => {
    e.preventDefault();
    try {
      await api.post("/tasks",{task: {title: title, category_id: categoryId, description: description, status: status}});
      setTitle("");
      setCategoryId("");
      setDescription("");
      setStatus(0);
      document.getElementById("task_modal").close();
    } catch(error) {
      console.error(error);
      alert("登録に失敗しました")
    }
  };

  return (
    <>
      <button className="btn btn-primary btn-ghost w-full" onClick={()=>document.getElementById("task_modal").showModal()}>作成</button>
      <dialog id="task_modal" className="modal">
        <div className="modal-box">
          <form onSubmit={handleCreate}>
            <label className="label">タイトル</label>
            <input type="text" className="input input-bordered w-full mb-2" value={title} onChange={(e) => setTitle(e.target.value)} required/>

            <label className="label">カテゴリ</label>
            <select className="select select-bordered w-full mb-4" value={categoryId} onChange={(e) => setCategoryId(e.target.value)} required>
              <option value="" disabled>カテゴリを選択</option>
              {categories.map((category) => (
                <option key={category.id} value={category.id}>
                  {category.name}
                </option>
              ))}
            </select>

            <label className="label">概要</label>
            <textarea className="textarea textarea-bordered w-full mb-4" value={description} onChange={(e) => setDescription(e.target.value)}>
            </textarea>

            <div className="modal-action mt-0">
              <button type="submit" className="btn btn-primary">登録</button>
              <button type="button" className="btn" onClick={() => document.getElementById("task_modal").close()}>キャンセル</button>
            </div>
          </form>
        </div>

        <form method="dialog" className="modal-backdrop">
          <button>close</button>
        </form>
      </dialog>
    </>
  );
}