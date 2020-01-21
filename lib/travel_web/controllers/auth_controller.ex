defmodule TravelWeb.AuthController do
    use TravelWeb , :controller

    alias TravelWeb.User
    alias Travel.Repo
    import Ecto.Query

def create_acc(conn , _params) do
    changeset = User.changeset(%User{} , %{})
    render conn , "signup.html" , changeset: changeset
end


def signup(conn , %{"user" => %{"name" => user_name , "email" => user_email , "password" => user_password}}) do
     if String.length(user_email) >= 5 && String.length(user_password) >= 5 && String.length(user_name) >= 2 do
        isEmailCorrect = String.contains?(user_email , ["@" , "gmail" , "com"])


        case isEmailCorrect do
            true ->
                user_password = Base.encode16(user_password)
                changeset = User.changeset(%User{} , %{name: user_name , email: user_email , password: user_password})
        
                case Repo.insert(changeset) do
                    {:ok , cut} -> 
                        conn
                        |> put_session(:user , cut.id)
                        |> put_flash(:info , "Successfully registered user")
                        |> redirect(to: Routes.home_path(conn , :index))
        
            
                    {:error , changeset} ->
                     put_flash(conn , :info , "Error while registering user")
                     render conn , "signup.html" , changeset: changeset  
            
                end 

            false ->
                conn
                |> put_flash(:info , "Please enter valid email address")
                |> redirect(to: Routes.auth_path(conn , :create_acc))
        end 
    else
        conn
        |> put_flash(:info , "Please fill the form first")
        |> redirect(to: Routes.auth_path(conn , :create_acc))
    end
end

def login_page(conn , _params) do
    changeset = User.changeset(%User{} , %{})

    render conn , "login.html" , changeset: changeset
end



def login(conn , %{"user" => %{ "email" => user_email , "password" => user_password }}) do
    if String.length(user_email) >= 5 && String.length(user_password) >= 5 do

        query = from i in User , where: i.email == ^user_email , select: i
        return_val = Repo.all(query)

        case length(return_val) do
            0 ->
                conn
                |> put_flash(:info , "Incorrect email address.")
                |> redirect(to: Routes.auth_path(conn , :login_page))
            
            1 -> 
                find_email = Repo.get_by!(User , email: user_email)
                {:ok , new_password} = Base.decode16(find_email.password)
                cond do
                    new_password == user_password ->
                        conn
                        |> put_session(:user , find_email.id)
                        |> put_flash(:info , "Successfully registered user")
                        |> redirect(to: Routes.home_path(conn , :index))
                    new_password != user_password ->
                        conn
                        |> put_flash(:info , "Password is incorrect")
                        |> redirect(to: Routes.auth_path(conn , :login_page))
                    end
        end
    else
        conn
        |> put_flash(:info , "Please enter required field")
        |> redirect(to: Routes.auth_path(conn , :login_page))
    end

    end


    def logout(conn , _params) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: Routes.home_path(conn , :index))
    end
end

