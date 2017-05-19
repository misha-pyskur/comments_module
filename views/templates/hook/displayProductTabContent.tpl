
    <h3 id="mishacomments_block_heading" class="page-product-heading" {if isset($new_comment_posted)} data-scroll="true" {/if}>
    {l s='Product Comments' mod='mishacomments'}
    </h3>
    <div class="container">
        <div class="rte">
            {foreach from=$comments item=comment}
            <div class="mishacomments-comment">
                <div class="row">
                    <div class="col-md-1">
                        <p>{$comment.firstname} {$comment.lastname|substr:0:1}.</p>
                        <img src="https://secure.gravatar.com/avatar/07cb79c13e8d1443997d9af8ab6498c6"
                             class="pull-left img-thumbnail mishacomments-avatar" />
                    </div>
                    <div class="col-md-10">
                        <input value="{$comment.grade}" type="number" class="grade" />
                        <div><i class="glyphicon glyphicon-comment"></i>
                            <strong>{l s='Comment' mod='mishacomments'} #{$comment.id_mishacomments_comment}:</strong> {$comment.comment}
                        </div>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
    </div>
    <div class="rte">
        {assign var=params value=[
            'module_action' => 'list',
            'product_rewrite' => $product->link_rewrite,
            'id_product' => $smarty.get.id_product,
            'page' => 1
        ]}
        <a href="{$link->getModuleLink('mishacomments', 'comments', $params)}">
            {l s='All Comments' mod='mishacomments'}
        </a>
    </div>
    <div class="rte">
        <h3>Add new comment</h3>
        {if $enable_grades eq 1 OR $enable_comments eq 1}
        <form action="" method="post" id="comment-form">
            {if $enable_grades eq 1}
            <div class="form-group">
                <label for="firstname_field">{l s='First Name' mod='mishacomments'}</label>
                <div class="row">
                    <div class="col-xs-4">
                        <input name="firstname" id="firstname_field" class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="lastname_field">{l s='Last Name' mod='mishacomments'}</label>
                <div class="row">
                    <div class="col-xs-4">
                        <input name="lastname" id="lastname_field" class="form-control" type="text">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="email_field">{l s='Email' mod='mishacomments'}</label>
                <div class="row">
                    <div class="col-xs-4">
                        <input name="email" id="email_field" class="form-control" type="email">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="grade_field">{l s='Grade' mod='mishacomments'}</label>
                <div class="row">
                    <div class="col-xs-4">
                        <input id="grade_field" name="grade" value="0" type="number">
                    </div>
                </div>
            </div>
            {/if}
            {if $enable_comments eq 1}
            <div class="form-group">
                <label for="comment_field">{l s='Comment' mod='mishacomments'}</label>
                <textarea id="comment_field" name="comment" class="form-control"></textarea>
            </div>
            {/if}
            <div class="submit">
                <button type="submit" name="mishacomments_comment_submit" class="button btn btn-default button-medium"><span>Send <i class="icon-chevron-right right"></i></span></button>
            </div>
        </form>
        {/if}
    </div>