<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Folha */
mb_internal_encoding('UTF-8');
?>
<div class="folha-view" id="impressao">
	<div class="row" id="impressao">
		<div class="col-md-12">
			<div class="panel">
				<div class="panel-body">
					<table class="table table-condensed" id="cabecalho">
						<thead>
							<tr>
								<th class="text-center" colspan="2"
								style="font-size: 18px; padding-top: 15px; font-weight: normal; line-height: normal;">                                
								<?php $title = ($model->mensagem == 'Salvo com sucesso' ? 'Salvo com sucesso' : 'Ocorreu um ou mais erros no(s) funcionário(s)') ?>
								<strong><?= $title ?> </strong><br><br>
							</th>
							<th class="data" style="vertical-align: top">
								<p class="text-right" style="font-size: 10px;">
									<?= date('d/m/Y - H:i:s') ?>
								</p>
							</th>
						</tr>
					</thead>                        
				</table>
				<?php if($title != 'Salvo com sucesso'){ ?>
					<?php $mensagens = explode(';', $model->mensagem); $i=0; $qt_msg = count($mensagens);?>
					<?php for($i=0; $i<$qt_msg; $i++){ ?>
					<table class="table table-condensed">
						<tbody>  
							<tr>
								<td><strong>Nome:</strong> <?= $mensagens[$i]; $i++; ?></td> 
							</tr>
							<tr>
								<td><strong>CPF:</strong> <?= $mensagens[$i] ?></td> 
							</tr>
							<th></th>
							<br><br>
						</tbody>
					</table>
					<?php } ?>
				<?php } ?>
			</div>
		</div>
	</div>
</div>
</div>