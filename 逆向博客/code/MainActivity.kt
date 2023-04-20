import android.content.Context
import android.os.Bundle
import android.view.View
import android.view.inputmethod.InputMethodManager
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*
import java.io.BufferedReader
import java.io.InputStreamReader

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Read username and password from file
        val inputStream = assets.open("1.txt")
        val bufferedReader = BufferedReader(InputStreamReader(inputStream))
        val username = bufferedReader.readLine()
        val password = bufferedReader.readLine()

        // Set focus change listener for username EditText
        usernameEditText.setOnFocusChangeListener { view, hasFocus ->
            if (hasFocus) {
                // Show keyboard
                val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                imm.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT)
                // Set default text for username EditText
                usernameEditText.setText(username)
                // Clear password EditText
                passwordEditText.setText("")
            }
        }

        // Set focus change listener for password EditText
        passwordEditText.setOnFocusChangeListener { view, hasFocus ->
            if (hasFocus) {
                // Show keyboard
                val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                imm.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT)
                // Set default text for password EditText
                passwordEditText.setText(password)
            }
        }

        // Set click listener for login button
        loginButton.setOnClickListener {
            // Check if username and password are correct
            if (usernameEditText.text.toString() == username && passwordEditText.text.toString() == password) {
                // Show second activity
                startActivity(SecondActivity.newIntent(this))
            }
        }
    }
}
