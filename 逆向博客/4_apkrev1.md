# Reverse Engineering an APK and Bypassing the Login Screen with Smali Assembly

In this blog post, we will explore the process of reverse engineering an Android APK file and bypassing the login screen using Smali Assembly. Smali is a low-level language that is used to write assembly code for the Dalvik Virtual Machine (DVM), which is the virtual machine used in Android. By analyzing and modifying the Smali code of an APK file, we can bypass security measures such as login screens and gain access to restricted features.

## Designing the target apk

```kotlin
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

```

## Decompiling the APK File

The first step in reverse engineering an APK file is to decompile it. This can be done using tools such as JADX, Apktool, or jadx-gui. In this example, we will use JADX to decompile the APK file. Once the APK file is decompiled, we can view the Smali code in the "smali" directory.

```
$ jadx -d extracted-app apk-file.apk
```

## Finding the Login Screen Code

In our example APK file, the login screen code is located in the MainActivity class. We can navigate to this class in the "smali" directory and find the code that controls the login functionality. In this case, the relevant code is in the onClick method of the loginButton.

```smali
.method public onClick(Landroid/view/View;)V
    .locals 3

    const/4 v0, 0x1

    iget-object v1, p0, Lcom/example/myapp/MainActivity;->usernameEditText:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/example/myapp/MainActivity;->passwordEditText:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "admin"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const-string v3, "password"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v1, :cond_1

    if-nez v2, :cond_1

    const/4 v0, 0x0

    :cond_1
    if-eqz v0, :cond_3

    const-string v0, "com.example.myapp.SecondActivity"

    invoke-static {p0, v0}, Lcom/example/myapp/MainActivity;->startActivity(Landroid/content/Context;Ljava/lang/String;)V

    :goto_0
    return

    :cond_3
    const-string v0, "Invalid username or password."

    invoke-static {p0, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0
```

## Modifying the Smali Code

To bypass the login screen, we need to modify the Smali code to skip the login functionality. In this case, we can simply remove the code that checks the username and password and always proceed to the next activity. This can be done by deleting the relevant Smali instructions in the onClick method.

```smali
.method public onClick(Landroid/view/View;)V
    .locals 0

    const-string v0, "com.example.myapp.SecondActivity"

    invoke-static {p0, v0}, Lcom/example/myapp/MainActivity;->startActivity(Landroid/content/Context;Ljava/lang/String;)V

    return
```

## Recompiling the APK File

After modifying the Smali code, we need to recompile the APK file. This can be done using tools such as Apktool or jadx-gui. In this example, we will use Apktool.

```
$ apktool b extracted-app -o new-apk-file.apk
```

## Installing the Modified APK File

Once the APK file is recompiled, we can sign it with a certificate in order to install it on an Android device.

```
$ jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore new-apk-file.apk alias_name
```

After signing the APK file, we can install it on an Android device or emulator. After installing the modified APK file, we can launch the app and bypass the login screen.

---

Conclusion: Reverse engineering an Android APK file and bypassing security measures such as login screens can be a useful technique for exploring the inner workings of an app and gaining access to restricted features. By analyzing and modifying the Smali code of an APK file, we can gain deeper insights into the app's behavior and security measures.