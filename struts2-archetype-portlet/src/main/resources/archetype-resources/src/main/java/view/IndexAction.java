package ${package}.view;

import org.apache.struts2.dispatcher.DefaultActionSupport;

/**
 *
 */
public class IndexAction extends DefaultActionSupport {
    private String name = "My Name";

    public String execute() {
        // Preform any logic here

        return SUCCESS;
    }

    public String getName() {
        return name;
    }
}
