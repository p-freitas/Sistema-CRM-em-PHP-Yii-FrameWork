<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $name string */
/* @var $statusCode string */
/* @var $message string */
/* @var $exception Exception */

$this->title = 'Erro';
?>

<h2 class="headline text-info"><i class="fa fa-warning text-yellow"></i></h2>
<h2><?=Yii::t('app', $statusCode)?></h2>
<h3 class="text-uppercase"><?= nl2br(Html::encode($name)) ?> </h3>
	<h4><?=nl2br(Html::encode($message))?></h4>

<div class="error-page">   
            <p>
                The above error occurred while the Web server was processing your request.
                Please contact us if you think this is a server error. Thank you.
                Meanwhile, you may <a href='<?= Yii::$app->homeUrl ?>'>return to dashboard</a> or try using the search
                form.
            </p>
            <form class='search-form'>
                <div class='input-group'>
                    <input type="text" name="search" class='form-control' placeholder="Search"/>

                    <div class="input-group-btn">
                        <button type="submit" name="submit" class="btn btn-primary"><i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
