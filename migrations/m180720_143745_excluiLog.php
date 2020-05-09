<?php

use yii\db\Migration;

/**
 * Class m180720_143745_excluiLog
 */
class m180720_143745_excluiLog extends Migration
{
    public function up()
    {
        if (Yii::$app->db->getTableSchema('log', true) !== null) {
            $this->dropTable('log');
        }

        if (Yii::$app->db->getTableSchema('log_edicao', true) !== null) {
            $this->dropTable('log_edicao');
        }
    }
}
