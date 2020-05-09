<?php

namespace app\components;

use frostealth\yii2\aws\s3\Service as BaseService;

class CustomS3Service extends BaseService
{
    public function setHttpOptions(array $options)
    {
        $this->clientConfig['http'] = $options;
    }
}