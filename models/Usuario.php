<?php

namespace app\models;
use app\behaviors\LogBehavior;
use webvimark\modules\UserManagement\models\rbacDB\Role;
use webvimark\modules\UserManagement\models\User as BaseUser;
use yii;
/**
 * @property integer $fk_entidade
 * @property Entidade $fkEntidade
 * @property int $status
 * @property string $nome_completo
 */
class Usuario extends BaseUser
{
    public $foto_url;
    public $role;

    public static $descStatus = [
        1 => "Ativo",
        0 => "Inativo",
        2 => "Banido"
    ];

    /**
     * @inheritdoc
     */
    public function rules()
    {
        $parents = parent::rules();
        $parents[1] = ['username', 'unique', 'targetAttribute' => ['username', 'fk_entidade']];

        return yii\helpers\ArrayHelper::merge($parents, [
            [['nome_completo'], 'required'],
            [['nome_completo'], 'string', 'max' => 100],
            [['status'], 'integer'],
            [['status'], 'default', 'value' => 1],
            [['foto'], 'string'],
            [['foto_url'], 'safe'],
            ['role', 'each', 'rule' => ['exist', 'skipOnError' => true, 'targetClass' => Role::className(), 'targetAttribute' => ['role' => 'name']]],
            [['foto_url'], 'file', 'extensions' => 'png, jpg, gif, jpeg'],
            ['fk_entidade', 'required', 'when' => function($model){return (Yii::$app->user->isSuperadmin && $model->superadmin == 0);}],
            ['fk_entidade', 'default', 'value' => Yii::$app->user->entidade, 'when' => function(){return !Yii::$app->user->isSuperadmin;}],
            [['fk_entidade'], 'integer'],
            [['fk_entidade'], 'exist', 'skipOnError' => true, 'targetClass' => Entidade::className(), 'targetAttribute' => ['fk_entidade' => 'id']],
        ]);
    }

    /**
     * @inheritdoc
     * @return \app\models\query\UsuarioQuery the active query used by this AR class.
     */
    public static function find()
    {
        return new \app\models\query\UsuarioQuery(get_called_class());
    }

    public function behaviors()
    {
        return yii\helpers\ArrayHelper::merge(parent::behaviors(), [
            LogBehavior::className(),
        ]);
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return yii\helpers\ArrayHelper::merge(parent::attributeLabels(), [
            'fk_entidade' => Yii::t('app', 'Entidade'),
            'status' => 'Status',
        ]);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getFkEntidade()
    {
        return $this->hasOne(Entidade::className(), ['id' => 'fk_entidade']);
    }

    /**
     * Finds user by username
     *
     * @param  string      $username
     * @param  integer     $entidade
     * @return static|null
     */
    public static function findByUsernameAndEntidade($username, $entidade)
    {
        if(!empty($entidade)){
            return static::findOne(['username' => $username, 'fk_entidade' => $entidade, 'status' => Usuario::STATUS_ACTIVE]);
        }else if(!empty($username)){
            $user = static::findOne(['username' => $username, 'status' => Usuario::STATUS_ACTIVE]);

            if(!empty($user) && $user->superadmin == 1)
                return $user;
            else
                return null;
        }else{
            return null;
        }
    }

    public function afterFind()
    {
        parent::afterFind();
        $this->role = $this->getRoles()->all();
    }
}