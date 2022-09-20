({
    doInit : function(component, event, helper) {
        var projID = component.get("v.recordId");
        var action = component.get("c.getStatus");
        action.setParams({ "projectId" : projID});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS")
            {
                component.set('v.moscowWrapper',response.getReturnValue());
                //alert("From Server: "+ JSON.stringify(response.getReturnValue()));
            }
            else if(state === "INCOMPLETE")
            {
                // do something
            }
                else if(state ==="ERROR")
                {
                    var errors = response.getError();
                    if(errors)
                    {
                        if (errors[0] && errors[0].message)
                        {
                            console.log("Error message: "+error[0].message);
                        }
                        else
                        {
                            console.log("Unknown Error");
                        }
                    }
                }
        });
        $A.enqueueAction(action);
    },
    dragStart :function(component, event, helper) {
        //var datatrf = event.target.id+"-"+event.target.getAttribute('data-projid');
        //event.dataTransfer.setData('Text',datatrf);
        event.dataTransfer.setData('Text',event.target.id);
    },
    allowDrop :function(component, event, helper) {
        event.preventDefault();
    },
    onMustHaveDrop :function(component, event, helper) {
        helper.updateDraggedFeature(component, event, helper,
                                    event.dataTransfer.getData('Text',event.target.id),
                                    "M");
    },
    onShouldHaveDrop :function(component, event, helper) {
        
        //var arrName = event.dataTransfer.getData('Text',datatrf);
        //var nameArr = arrName.split('-');
        helper.updateDraggedFeature(component, event, helper,
                                    event.dataTransfer.getData('Text',event.target.id),
                                    "S");
    },
    onCouldHaveDrop :function(component, event, helper) {
        helper.updateDraggedFeature(component, event, helper,
                                    event.dataTransfer.getData('Text',event.target.id),
                                    "C");
    },
    onWontHaveDrop :function(component, event, helper) {
        helper.updateDraggedFeature(component, event, helper,
                                    event.dataTransfer.getData('Text',event.target.id),
                                    "W");
    },
    onTBDDrop :function(component, event, helper) {
        helper.updateDraggedFeature(component, event, helper,
                                    event.dataTransfer.getData('Text',event.target.id),
                                    "TBD");
    },
    openFeature :function(component, event, helper) {
        var urlId = event.target.id;
        if(urlId != "" && urlId != null && urlId != undefined){
            
            //Get base url
            var baseURL = window.location.origin;
            
            var urlval = baseURL + '/lightning/r/featureboard_Feature__c/'+ urlId +'/view?ws=%2Flightning%2Fr%2Ffeatureboard__Project__c%2F' + event.target.getAttribute('data-projid') + '%2Fview';
        	window.open(urlval, '_self'); //NS changed from _blank to _self in hopes of having fewer tabs loaded
        }
       
    }
    
})