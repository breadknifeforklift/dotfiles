{
  description = "A flake";

  outputs = { self }: {

    templates = {

     mytemplate = {
        path = ./mytemplate;
        description = "Impermanent flake";
      };

    };

    defaultTemplate = self.templates.mytemplate;

  };
}