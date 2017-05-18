{if isset($confirmation)}
   <div class="alert alert-success">Configuration values is successfully saved.</div>
{/if}
<fieldset>
    <h2>Configure your shit</h2>
    <div class="panel">
        <div class="panel-heading">
            <legend><img src="../img/admin/cog.gif" width="16">Config</legend>
        </div>
        <form action="" method="post">
            <div class="form-group clearfix">
                <label class="col-lg-3">Enable grades: </label>
                <div class="col-lg-9">
                    <img src="../img/admin/enabled.gif" />
                    <input type="radio" id="enable_grades_1" name="enable_grades" value="1" {if ($enable_grades eq '1')}checked{/if}/>
                    <label class="t" for="enable_grades_1">Yes</label>
                    <img src="../img/admin/disabled.gif" />
                    <input type="radio" id="enables_grades_0" name="enable_grades" value="0" {if ($enable_grades eq '0')}checked{/if}/>
                    <label class="t" for="enables_grades_0">No</label>
                </div>
            </div>

            <div class="form-group clearfix">
                <div class="form-group clearfix">
                    <label class="col-lg-3">Enable comments: </label>
                    <div class="col-lg-9">
                        <img src="../img/admin/enabled.gif" />
                        <input type="radio" id="enable_comments_1" name="enable_comments" value="1" {if ($enable_comments eq '1')}checked{/if}/>
                        <label class="t" for="enable_comments_1">Yes</label>
                        <img src="../img/admin/disabled.gif" />
                        <input type="radio" id="enables_comments_0" name="enable_comments" value="0" {if ($enable_comments eq '0')}checked{/if}/>
                        <label class="t" for="enables_comments_0">No</label>
                    </div>
                </div>
            </div>

            <div class="panel-footer">
                <input class="btn btn-primary pull-right" type="submit"
                name="mishacomments_conf_form" value="Save" />
            </div>
        </form>
    </div>
</fieldset>