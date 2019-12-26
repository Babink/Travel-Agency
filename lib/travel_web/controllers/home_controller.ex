defmodule TravelWeb.HomeController do
    use TravelWeb , :controller

    alias TravelWeb.Images
    alias Travel.Repo
    alias TravelWeb.Book

    # plug TravelWeb.Plugs.RequireAuth when action in [:book]

    def index(conn , _params) do
        # changeset = Images.changeset(%Images{}, %{})
        urls = Repo.all(Images)
        render conn , "home.html" , images: urls
    end

    def book(conn , %{"id" => param_id}) do
        single_data = Repo.get(Images , param_id)
        changeset = Book.changeset(%Book{} , %{})

        users = conn.assigns[:user]
        render conn , "book.html" , mydata: single_data , changeset: changeset , user: users
    end

    def book_post(conn , %{"book" => %{"address" => address , "contact" => contact , "name" => name , "person" => person , "message" => message} , "id" => params_id}) do

        urls = Repo.get!(Images , params_id)
        changesets = conn.assigns[:user] 

        changeset =
            urls
            |> Ecto.build_assoc(:books)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:user , changesets)
            |> Book.changeset(%{ address: address , contact: contact , name: name , person: person , message: message })

        case Repo.insert(changeset) do
            {:ok , _cut} ->
                conn
                |> redirect(to: Routes.home_path(conn , :index))

            {:error , changeset} ->
                render conn , "book.html" , changeset: changeset , mydata: urls
        end
    end

    def park(conn , _params) do
        urls = Repo.all(Images)
        render conn , "park.html" , images: urls
    end

    def heritage(conn , %{"id" => params_id}) do
        urls = Repo.get!(Images, params_id)
        changeset = Book.changeset(%Book{} , %{})
        render conn , "heritage.html" , images: urls , changeset: changeset
    end

    def heritage_post(conn ,  %{"book" => %{"address" => address , "contact" => contact , "name" => name , "person" => person , "message" => message} , "id" => params_id}) do
        urls = Repo.get!(Images , params_id)
        changesets = conn.assigns[:user] 

        changeset =
            urls
            |> Ecto.build_assoc(:books)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:user , changesets)
            |> Book.changeset(%{ address: address , contact: contact , name: name , person: person , message: message })

            case Repo.insert(changeset) do
                {:ok , _cut} ->
                    conn
                    |> redirect(to: Routes.home_path(conn , :index))
    
                {:error , changeset} ->
                    render conn , "bhutan.html" , images: urls , changeset: changeset
            end

        # changeset = conn.assigns[:user]  
        #     |> Ecto.build_assoc(:books)
            
        
    end

    def bhutan(conn , %{"id" => params_id}) do
        changeset = Book.changeset(%Book{} , %{});
        
        urls = Repo.get!(Images , params_id)

        IO.puts "/////////////////////////////////////////"
        IO.inspect(urls)
        IO.puts "/////////////////////////////////////////"
        render conn , "bhutan.html" , images: urls , changeset: changeset
    end

    def bhutan_post(conn , %{"book" => %{"address" => address , "contact" => contact , "name" => name , "person" => person , "message" => message }, "id" => params_id}) do
        urls = Repo.get!(Images , params_id)

        changeset = conn.assigns[:user]  
            |> Ecto.build_assoc(:books)
            |> Book.changeset(%{ address: address , contact: contact , name: name , person: person , message: message })

        case Repo.insert(changeset) do
            {:ok , _cut} ->
                conn
                |> redirect(to: Routes.home_path(conn , :index))

            {:error , changeset} ->
                render conn , "bhutan.html" , images: urls , changeset: changeset
        end
    end

    def about(conn , _params) do
        render conn , "about.html"
    end

    def trek(conn , _params) do
        urls = Repo.all(Images)
        render conn , "trek.html" , images: urls
    end
end