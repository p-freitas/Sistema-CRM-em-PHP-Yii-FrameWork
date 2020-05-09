<p>Novo erro enviado por usuário</p>
<?php if($user->username != 'superadmin') {?>
    <p>Nome do usuário: <?= $user->username?></p>
<?php }?>
<p>Usuário: <?=$user->username?></p>
<p>Mensagem: <br><?=$message?></p>

