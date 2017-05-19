<h1>{l s='Comments' mod='mishacomments'} "{$product->name}"</h1>

{foreach from=$comments item=comment}
<div class="mishacomments-comment">
    <div class="col-md-2">
        <p>{$comment.firstname} {$comment.lastname|substr:0:1}.</p>
        <img src="https://secure.gravatar.com/avatar/07cb79c13e8d1443997d9af8ab6498c6"
             class="pull-left img-thumbnail mishacomments-avatar"/>
    </div>
    <div class="col-md-10">
        <input value="{$comment.grade}" type="number" class="grade"/>
        <div><i class="glyphicon glyphicon-comment"></i>
            <strong>{l s='Comment' mod='mishacomments'} #{$comment.id_mishacomments_comment}:</strong>
            {$comment.comment}
        </div>
    </div>
</div>
{/foreach}

<ul class="pagination">
    {for $count=1 to $num_of_pages}
        {assign var=params value=[
            'module_action' => 'list',
            'product_rewrite' => $product->link_rewrite,
            'id_product' => $smarty.get.id_product,
            'page' => $count
        ]}

        {if $page ne $count}
            <li>
                <a href="{$link->getModuleLink('mishacomments', 'comments', $params)}">
                    <span>{$count}</span>
                </a>
            </li>
        {else}
            <li class="active current">
                <span>{$count}</span>
            </li>
        {/if}
    {/for}
</ul>
