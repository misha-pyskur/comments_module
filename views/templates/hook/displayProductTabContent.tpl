<h3 id="mishacomments_block_heading" {if isset($new_comment_posted)} data-scroll="true" {/if}>
    {l s='Product Comments' mod='mishacomments'}
</h3>
<div class="rte">
    {foreach from=$comments item=comment}
        <table>
            <tr>
                <td>
                    <label class="control-label">Grade:</label>
                </td>
                <td><input class="grade_disabled" name="grade_disabled" value={$comment.grade} type="number"></td>
            </tr>
            <tr>
                <td>
                    <label for="comment" class="control-label">Comment:</label>
                </td>
                <td><p name="comment">{$comment.comment}</p></td>
            </tr>
        </table>
    {/foreach}
</div>
<h3>Add new comment</h3>
<div class="rte">
    {if $enable_grades eq 1 OR $enable_comments eq 1}
        <form action="" method="post" id="comment-form">
            {if $enable_grades eq 1}
                <div class="form-group">
                    <label for="grade">Grade:</label>
                    <div class="row">
                        <div class="col-xs-4">
                            <input id="grade_active" name="grade" value="0" type="number">
                        </div>
                    </div>
                </div>
            {/if}
            {if $enable_comments eq 1}
                <div class="form-group">
                    <label for="comment">Comment:</label>
                    <textarea name="comment" id="comment" class="form-control"></textarea>
                </div>
            {/if}
            <div class="submit">
                <button type="submit" name="mishacomments_comment_submit" class="button btn btn-default button-medium"><span>Send <i class="icon-chevron-right right"></i></span></button>
            </div>
        </form>
    {/if}
</div>