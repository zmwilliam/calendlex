defmodule CalendlexWeb.Admin.Components.Modal do
  use Phoenix.Component

  def content(assigns) do
    ~H"""
    <div class="fixed inset-0 z-20 overflow-y-auto"
      phx-window-keydown="close_modal"
      phx-key="escape">
      <div class="flex items-end justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
        <div class="fixed inset-0 bg-white bg-opacity-75 transition-opacity" aria-hidden="true"></div>
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
        <div class="inline-block overflow-hidden text-left align-bottom bg-white border border-gray-200 shadow-md rounded-md transform transition-all sm:my-8 sm:align-middle sm:max-w-md sm:w-full">
          <div class="p-6 mx-auto mb-2 bg-white">
            <header class="mb-6 text-center">
              <h3 class="mb-3 text-lg font-bold text-gray-900">
                <%= render_slot(@header) %>
              </h3>
            </header>

            <%= render_slot(@inner_block) %>

            <footer class="flex mt-6 gap-x-10">
              <%= render_slot(@footer) %>
            </footer>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def cancel_button(assigns) do
    ~H"""
    <button class="flex-1 px-4 py-2 border border-gray-800 rounded-full" phx-click="close_modal">
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  def confirm_button(assigns) do
    ~H"""
    <button class="flex-1 px-4 py-2 text-white bg-blue-600 rounded-full" phx-click={@event}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
