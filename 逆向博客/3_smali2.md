# Crafting a Small Smali Program: Challenges and Lessons Learned

In my journey to learn Smali assembly, I decided to create a small program that integrates phone button input, touch screen input, keyboard output, and API calls. In this blog post, I will walk you through the design process, challenges, and solutions I encountered, the program operation flow, and the final outcome of this endeavor.

---

## Designing the program
* Objective: Develop a simple Android app using Smali code.

* Functionality:

   * Respond to physical button presses (e.g., volume up/down).

   * Accept touch input on the screen.

   * Display input data and results on the screen.

   * Utilize Android API for additional  functionality.

* Program Operation Flow:

   1. The program starts by creating the activity and rendering the UI.

   2. The user can then press the volume up or down button to trigger the corresponding event.
   
   3. The program captures the button event and updates the UI with the event data.
   
   4. The user can also touch the screen, which will be captured and rendered on the UI as well.
   
   5. The program calls an Android API method to display a toast message on the screen.

## Code

```smali
.class public Lcom/example/MyActivity;
.super Landroid/app/Activity;

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 2
    .prologue

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/view/Window;->requestFeature(I)Z

    invoke-virtual {p0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    new-instance v0, Lcom/example/MyView;

    invoke-direct {v0, p0}, Lcom/example/MyView;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 3

    const/16 v0, 0x25

    if-ne p1, v0, :cond_1

    const-string v0, "volume down pressed"

    goto :cond_2

    :cond_1
    const/16 v0, 0x24

    if-ne p1, v0, :cond_3

    const-string v0, "volume up pressed"

    :cond_2
    invoke-static {p0, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    const/4 v0, 0x1

    goto :cond_4

    :cond_3
    const/4 v0, 0x0

    :cond_4
    if-eqz v0, :cond_5

    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    :cond_5
    return v0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 3

    const/16 v0, 0x25

    if-ne p1, v0, :cond_1

    const-string v0, "volume down released"

    goto :cond_2

    :cond_1
    const/16 v0, 0x24

    if-ne p1, v0, :cond_3

    const-string v0, "volume up released"

    :cond_2
    invoke-static {p0, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    const/4 v0, 0x1

    goto :
:cond_3
const/4 v0, 0x0

:goto_0
if-eqz v0, :cond_1

invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyUp(ILandroid/view/KeyEvent;)Z

move-result v0

:cond_1
return v0
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
.registers 3
.param p1, "event" # Landroid/view/MotionEvent;
const/16 v2, 0x0

invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

move-result v0

and-int/lit8 v1, v0, 0xff

packed-switch v1, :pswitch_data_0

:cond_0
move v1, v0

:goto_0
return v1

:pswitch_0
const-string v1, "Touch down"

goto :goto_1

:pswitch_1
const-string v1, "Touch up"

goto :goto_1

:pswitch_2
const-string v1, "Touch move"

goto :goto_1

:goto_1
invoke-static {p0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;)Landroid/widget/Toast;

move-result-object v1

invoke-virtual {v1}, Landroid/widget/Toast;->show()V

const/4 v1, 0x1

goto :goto_0

:pswitch_data_0
.packed-switch 0x0
    :pswitch_0
    :pswitch_1
    :pswitch_2
.end packed-switch
.end method

.method public performClick()Z
.locals 3
invoke-super {p0}, Landroid/view/View;->performClick()Z

const-string v0, "Button clicked"

invoke-static {p0, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;)Landroid/widget/Toast;

move-result-object v0

invoke-virtual {v0}, Landroid/widget/Toast;->show()V

const/4 v0, 0x1

return v0
.end method
```
## Challenges and Lessons Learned

During the development of this Smali program, I encountered several challenges and learned some valuable lessons.

1. Smali is a low-level language, and the syntax can be cryptic and challenging to understand.

2. Decompiled APKs can help in understanding the mapping between Java and Smali.

3. Debugging Smali code is challenging, but the Smalidea plugin can help.

4. Smali does not have built-in methods for handling touch input, and we must create custom methods to capture and process touch events.

5. Smali's built-in methods for handling button input are limited, and we must create custom methods to capture and process button events.

## Final Outcome

After overcoming several hurdles and challenges, I was able to produce a working Smali program that can respond to button and touch input and utilize Android APIs. The program's final output is a simple Android app that displays input data and results on the screen.

---

In conclusion, my experience with Smali programming has been a steep learning curve, but it has been an enlightening journey. I have gained a deeper understanding of Android internals and programming concepts and have improved my programming skills in the process. I hope this blog post can help you in your Smali programming endeavors and inspire you to explore the vast possibilities of Smali programming.

