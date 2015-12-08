module ApplicationHelper
  def bootstrap_key(key)
    {alert: "warning", notice: "success", error: "danger"}[key.to_sym]
  end
end
