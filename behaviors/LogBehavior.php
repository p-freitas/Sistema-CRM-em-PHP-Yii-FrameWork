<?php

namespace app\behaviors;

use asinfotrack\yii2\audittrail\behaviors\AuditTrailBehavior;
use yii\db\ActiveRecord;

/**
 * Behavior which enables a model to be audited. Each modification (insert, update and delete)
 * will be logged with the changed field values.
 * To enable the behavior on a model simply add it to its behaviors. Further configuration is
 * possible. Check out this classes attributes to see what options there are.
 *
 * @author Pascal Mueller, AS infotrack AG
 * @link http://www.asinfotrack.ch
 * @license MIT
 */
class LogBehavior extends AuditTrailBehavior
{

    public $setFlash = true;

    public function events()
    {
        return [
            ActiveRecord::EVENT_AFTER_DELETE  => 'onAfterDelete',
            ActiveRecord::EVENT_AFTER_INSERT  => 'onAfterInsert',
            ActiveRecord::EVENT_AFTER_UPDATE  => 'onAfterUpdate',
            ActiveRecord::EVENT_BEFORE_DELETE => 'onBeforeDelete',
        ];
    }
    /**
     * Handler for before delete event
     */
    public function onBeforeDelete()
    {
        if (!$this->logDelete) return;
        $entry = $this->createPreparedAuditTrailEntry(self::AUDIT_TYPE_DELETE);
        foreach ($this->getRelevantDbAttributes() as $attrName) {
            $entry->addChange($attrName, $this->owner->{$attrName}, null);
        }


        static::saveEntry($entry);
    }

    public function onAfterInsert($event)
    {
        if($this->setFlash)
            \Yii::$app->session->setFlash('success', 'Salvo com sucesso.');
        return parent::onAfterInsert($event);
    }

    public function onAfterUpdate($event)
    {
        if($this->setFlash)
            \Yii::$app->session->setFlash('success', 'Atualizado com sucesso.');
        return parent::onAfterUpdate($event);
    }

    public function onAfterDelete(){
        if($this->setFlash)
            \Yii::$app->session->setFlash('success', 'Excluído com sucesso.');
    }
}
