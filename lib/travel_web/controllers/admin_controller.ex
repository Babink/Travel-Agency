defmodule TravelWeb.AdminController do
    use TravelWeb , :controller


    import Ecto.Query

    alias TravelWeb.Images
    alias Travel.Repo
    alias TravelWeb.Book
    alias TravelWeb.User
    alias TravelWeb.Admins

    plug TravelWeb.Plugs.RequireAdmin when action in [:images , :images_post , :get_post , :get_detail, :delete_admin ]

    def images(conn , _params) do
        changeset = Images.changeset(%Images{} , %{})

        render conn , "post.html" , changeset: changeset
    end

    def images_post(conn , %{"images" => %{ "url" => firstUrl,
    "heading" => heading,
    "description" => description,
    "price" => price,
    "tags" => tags,
    "days" => days,
    "urlTwo" => urltwo,
    "urlThree" => urlthree,
    "urlFour" => urlFour
    }}) do 
        changeset = Images.changeset(%Images{} , %{ url: firstUrl ,
         heading: heading , 
         description: description , 
         price: price ,
         tags: tags , 
         days: days , 
         urltwo: urltwo , 
         urlthree: urlthree , 
         urlfour: urlFour
            })

        case Repo.insert(changeset) do
            {:ok , _cut} ->
                conn
                |> put_flash(:info , "Successfully inserted")
                |> redirect(to: Routes.admin_path(conn , :images))

            {:error , changeset} ->
                render conn , "post.html" , changeset: changeset
        end
    end

    def get_post(conn , _params) do
        books = Repo.all(Book)
        images = Repo.all(Images)
        users = Repo.all(User)

        return_val = Repo.all from b in Book,
                preload: [:images]

        Enum.each(return_val , fn(x) ->
            IO.puts"////////////////////////////////////////////" 
            IO.inspect(x.images.url)
        end)

        
        render conn , "get.html" , images: return_val , users: users
    end

    def get_detail(conn , %{"id" => params_id}) do

        return_val = from(b in Book , where: b.id == ^params_id)
                    |> Repo.all()
                    |> Repo.preload(:images)
                    |> Repo.preload(:user)                   

        render conn , "detail.html" , images: return_val
    end

    def login_admin(conn , _params) do
        changeset = Admins.changeset(%Admins{} , %{})

        render conn , "admin_login.html" , changeset: changeset
    end

    def post_admin(conn , %{"admins" => %{"username" => admin_username , "password" => admin_password}}) do
        get_admin = Repo.get_by!(Admins, username: admin_username)

        cond do
            get_admin.password == admin_password ->
                conn
                |> put_session(:admin , get_admin.id)
                |> redirect(to: Routes.admin_path(conn , :get_post))

            true ->
                "FASLE"
        end

    end

    def delete_admin(conn , _params) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: Routes.home_path(conn , :index))
    end
end



# <%= Enum.map(@images , fn (x) -> %>
#                 <div class="view-one-1">
#                     <img src="<%= x.images.url %>" class="view-img img-view" />
#                     <%= link "View Details" , to: Routes.admin_path(@conn , :get_detail , x.id) , class: "view-details" %> 
#                 </div>
#                 <div class="view-one-2">
#                     <img src="<%= x.images.url %>" class="view-img img-view" />
#                     <%= link "View Details" , to: Routes.admin_path(@conn , :get_detail , x.id) , class: "view-details" %> 
#                 </div>
#             <% end)