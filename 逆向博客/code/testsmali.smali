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