<?php

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

$finder = Finder::create()
    ->in(__DIR__)
    ->name('*.php')
    ->notName('vendor/*');

return (new Config())
    ->setRules([
        '@PSR12' => true,
        'indentation_type' => true, // スペースを使用
        'binary_operator_spaces' => [
            'default' => 'single_space',
        ],
        'array_indentation' => true,
        'blank_line_after_namespace' => true,
        'blank_line_after_opening_tag' => true,
        // 他のルールを必要に応じて追加
    ])
    ->setIndent("  ") // 2スペースインデント
    ->setFinder($finder);

