({
    updateDraggedFeature : function(component, event, helper,featureId,status) {
        
        var action = component.get("c.UpdateMoscow");
        action.setParams({ featureID : featureId,Status : status});
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                component.set('v.moscowWrapper',response.getReturnValue()); 
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        
        $A.enqueueAction(action);
    }
})