<?php

namespace app\modules;

use app\models\Usuario;
use webvimark\modules\UserManagement\models\User;
use webvimark\modules\UserManagement\UserManagementModule;
use yii\widgets\Menu;
use yii\helpers\ArrayHelper;
use yii\helpers\Url;
use yii\helpers\Html;

/**
 * GhostMenuCustom module definition class
 */
class GhostMenuCustom extends Menu
{
    /**
     * @inheritdoc
     */
    public function init()
    {
        parent::init();

        $this->ensureVisibility($this->items);
    }

    /**
     * @param array $items
     *
     * @return bool
     */
    protected function ensureVisibility(&$items)
    {
        $allVisible = false;

        foreach ($items as &$item) {
            if (isset($item['url']) AND !in_array($item['url'], ['', '#']) AND !isset($item['visible'])) {
                $item['visible'] = User::canRoute($item['url']);
            }

            if (isset($item['items'])) {
                // If not children are visible - make invisible this node
                if (!$this->ensureVisibility($item['items']) AND !isset($item['visible'])) {
                    $item['visible'] = false;
                }
            }

            if (isset($item['label']) AND (!isset($item['visible']) OR $item['visible'] === true)) {
                $allVisible = true;
            }
        }

        return $allVisible;
    }

    public $options = ['class' => 'nav', 'id' => 'side-menu'];
    public $submenuTemplate = '<ul class="nav nav-{level}-level">{items}</ul>';
    public $linkTemplate = '<a href="{url}" class="waves-effect">{iconClass}<span class="hide-menu">{label}</span>{append}</a>';
    public $labelTemplate = '<li class="nav-small-cap m-t-0">--- {label}</li>';

    protected function renderItem($item)
    {
        if (isset($item['url'])) {
            $template = ArrayHelper::getValue($item, 'template', $this->linkTemplate);

            return strtr($template, [
                '{url}' => Html::encode(Url::to($item['url'])),
                '{append}' => isset($item['append']) ? $item['append'] : '',
                '{iconClass}' => isset($item['iconClass']) ? '<i class="fa-fw ' . $item['iconClass'] . '"></i>' : '',
                '{label}' => ($item['url'] === '#') ? $item['label'] . "<span class='fa arrow'></span>" : $item['label'],
            ]);
        } else {
            $template = ArrayHelper::getValue($item, 'template', $this->labelTemplate);

            return strtr($template, [
                '{label}' => $item['label'],
                '{iconClass}' => isset($item['iconClass']) ? '<i class="' . $item['iconClass'] . '"></i>' : '',
            ]);
        }
    }

    /**
     * Recursively renders the menu items (without the container tag).
     * @param array $items the menu items to be rendered recursively
     * @return string the rendering result
     */
    protected function renderItems($items)
    {
        $n = count($items);
        $lines = [];
        foreach ($items as $i => $item) {
            $options = array_merge($this->itemOptions, ArrayHelper::getValue($item, 'options', []));
            $tag = ArrayHelper::remove($options, 'tag', 'li');
            $class = [];
            if ($item['active']) {
                $class[] = $this->activeCssClass;
            }
            if ($i === 0 && $this->firstItemCssClass !== null) {
                $class[] = $this->firstItemCssClass;
            }
            if ($i === $n - 1 && $this->lastItemCssClass !== null) {
                $class[] = $this->lastItemCssClass;
            }
            Html::addCssClass($options, $class);

            $menu = $this->renderItem($item);
            if (!empty($item['items'])) {
                $submenuTemplate = ArrayHelper::getValue($item, 'submenuTemplate', $this->submenuTemplate);
                $menu .= strtr($submenuTemplate, [
                    '{level}' => $item['level'],
                    '{items}' => $this->renderItems($item['items']),
                ]);
            }
            $lines[] = Html::tag($tag, $menu, $options);
        }

        return implode("\n", $lines);
    }

    public static function gerenciaClientes(){
        return[
            'label' => 'Gerência de Entidades',
            'iconClass' => 'fa fa-group',
            'url' => '#',
            'level' => 'second',
            'items' => [
                [
                    'label' => 'Entidades',
                    'iconClass' => 'fa fa-group',
                    'url' => ['/cliente/index']
                ],
                [
                    'label' => 'Tipo Entidade',
                    'iconClass' =>  'fa fa-thumbs-up',
                    'url' => ['/tipo-cliente/index']
                ],
                [
                    'label' => 'Tipo Anexo',
                    'iconClass' =>  'fa fa-paperclip',
                    'url' => ['/tipo-anexo/index']
                ],
                [
                    'label' => 'Tipo Orgão',
                    'iconClass' =>  'fa fa-building',
                    'url' => ['/tipo-orgao/index']
                ],
                [
                    'label' => 'Cargo',
                    'iconClass' => 'fa fa-clipboard',
                    'url' => ['/cargo/index']
                ],
                [
                    'label' => 'Departamento',
                    'iconClass' => 'fa fa-map-marker',
                    'url' => ['/departamento/index']
                ],
                [
                    'label' => 'Tipo Telefone',
                    'iconClass' => 'fa fa-phone',
                    'url' => ['/tipo-telefone/index']
                ],
            ],

        ];
    }

    public static function gerenciaContratos(){
        return[
            'label' => 'Gerência de Contratos',
            'iconClass' => 'fa fa-folder',
            'url' => '#',
            'level' => 'second',
            'items' => [
                [
                    'label' => 'Contratos',
                    'iconClass' => 'fa fa-folder',
                    'url' => ['/contrato/index'],
                ],
                [
                    'label' => 'Modalidades',
                    'iconClass' => 'fa fa-cubes',
                    'url' => ['/modalidade/index'],
                ],
                [
                    'label' => 'Produtos',
                    'iconClass' => 'fa fa-check-square-o',
                    'url' => ['/produto/index'],
                ],
            ],
        ];
    }

    public static function gerenciaAtendimento(){
        return [
            'label' => 'Gerência de Atendimentos',
            'iconClass' => 'fa fa-phone',
            'url' => '#',
            'level' => 'second',
            'items' => [
                [
                    'label' => 'Atendimento',
                    'iconClass' => 'fa fa-phone',
                    'url' => ['/atendimento/index']
                ],
                [
                    'label' => 'Tipo Atendimento',
                    'iconClass' => 'fa fa-clipboard',
                    'url' => ['/tipo-atendimento/index']
                ],
                [
                    'label' => 'Tipo Ocorrência',
                    'iconClass' => 'fa fa-cubes',
                    'url' => ['/tipo-ocorrencia/index']
                ],

            ],
        ];
    }

    public static function gerenciaFinanceiro(){
        return [
            'label' => ' Gerência Administrativa/Financeira',
            'iconClass' => 'fa fa-money',
            'url' => '#',
            'level' => 'second',
            'items' => [
                [
                    'label' => ' Financeiro',
                    'iconClass' => 'fa fa-bank',
                    'url' => '#',
                    'level' => 'third',
                    'items' => [
                        [
                            'label' => 'Conta Orçamentaria',
                            'iconClass' => 'fa fa-suitcase',
                            'url' => ['/conta-orcamento/index']
                        ],
                        [
                            'label' => 'Tipo Documento',
                            'iconClass' => 'fa fa-folder-o',
                            'url' => ['/tipo-documento/index']
                        ],
                        [
                            'label' => 'Conta corrente',
                            'iconClass' => 'fa fa-dollar',
                            'url' => ['/conta/index']
                        ],
                        [
                            'label' => 'Banco',
                            'iconClass' => 'fa fa-bank',
                            'url' => ['/banco/index']
                        ],
                        [
                            'label' => 'Contas a Pagar',
                            'iconClass' => 'fa fa-long-arrow-left',
                            'url' => ['/financeiro/index']
                        ],
                        [
                            'label' => 'Contas a Receber',
                            'iconClass' => 'fa fa-long-arrow-right',
                            'url' => ['/financeiro/index-receber']
                        ],
                    ],
                ],
                [
                    'label' => 'Nota Fiscal',
                    'iconClass' => 'fa fa-dollar',
                    'url' => ['/nota-fiscal/index']
                ],
                [
                    'label' => ' Visita técnica',
                    'iconClass' => 'fa fa-car',
                    'url' => ['/visita-tecnica/index'],
                ],
                [
                    'label' => ' Orçamento',
                    'iconClass' => 'fa fa-money',
                    'url' => ['/orcamento-proposta/index'],
                ],
                [
                    'label' => ' Controle de versão',
                    'iconClass' => 'fa fa-code',
                    'url' => ['/controle-versao/index'],
                ],
            ],
        ];
    }

    public static function gerenciaUsuarios()
    {
        return
            [
                'label' => 'Gerência de Usuários',
                'iconClass' => 'fa fa-users',
                'url' => '#',
                'level' => 'second',
                'items' => [
                    [
                        'label' => UserManagementModule::t('back', 'Users'),
                        'iconClass' => 'fa fa-user-plus',
                        'url' => ['/user-management/user/index']
                    ],
                    [
                        'label' => UserManagementModule::t('back', 'Roles'),
                        'iconClass' => 'fa fa-shield',
                        'url' => ['/user-management/role/index']
                    ],
                    [
                        'label' => UserManagementModule::t('back', 'Permissions'),
                        'iconClass' => 'fa fa-thumbs-o-up',
                        'url' => ['/user-management/permission/index']
                    ],
                    [
                        'label' => UserManagementModule::t('back', 'Permission groups'),
                        'iconClass' => 'fa fa-share-alt',
                        'url' => ['/user-management/auth-item-group/index']],
                    [
                        'label' => UserManagementModule::t('back', 'Visit log'),
                        'iconClass' => 'fa fa-user-secret',
                        'url' => ['/user-management/user-visit-log/index']],
                ],
            ];
    }

    public static function gerenciaConta()
    {
        return
            [
                'label' => 'Gerência de conta',
                'iconClass' => 'fa fa-cogs',
                'url' => '#',
                'level' => 'second',
                'items' => [
                    [
                        'label' => 'Confirmar E-mail',
                        'iconClass' => 'fa fa-check',
                        'visible' => \Yii::$app->user->identity->email_confirmed === 0,
                        'url' => ['/auth/confirm-email']
                    ],
                    [
                        'label' => UserManagementModule::t('back', 'Change own password'),
                        'iconClass' => 'fa fa-key',
                        'url' => ['/user-management/auth/change-own-password']
                    ],
                    [
                        'label' => UserManagementModule::t('front', 'Change E-mail'),
                        'iconClass' => 'fa fa-envelope',
                        'url' => ['/user/change-own-email']
                    ],
                ],
            ];
    }

    public static function gerenciaParametrosGerais()
    {
        return
            [
                'label' => 'Parâmetros Gerais',
                'iconClass' => 'fa fa-globe',
                'url' => '#',
                'visible' => \Yii::$app->user->isSuperadmin,
                'level' => 'second',
                'items' => [
                            [
                                'label' => 'Entidades',
                                'iconClass' => 'fa fa-university',
                                'url' => ['/entidade/index']
                            ],
                            [
                                'label' => 'Log',
                                'iconClass' => 'fa fa-server',
                                'url' => ['/log/index']
                            ],
                            [
                                'label' => 'Requests API',
                                'iconClass' => 'fa fa-plus',
                                'url' => ['/requests/index']
                            ],
                        ],
            ];
    }



}
