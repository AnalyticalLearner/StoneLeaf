# StoneLeaf Directory Structure Creator - PowerShell Version

$structure = @{
    "10" = @{
        Name = "health_and_safety"
        Subs = @(
            "01.first_aid",
            "02.field_medicine",
            "03.mental_health"
        )
    }
    "20" = @{
        Name = "food_and_water"
        Subs = @(
            "01.recipes",
            "02.preservation",
            "03.nutrition"
        )
    }
    "30" = @{
        Name = "farming_and_domestic_skills"
        Subs = @(
            "01.gardening",
            "02.livestock",
            "03.homekeeping"
        )
    }
    "40" = @{
        Name = "hunting_fishing_foraging"
        Subs = @(
            "01.trapping",
            "02.fishing",
            "03.foraging"
        )
    }
    "50" = @{
        Name = "education"
        Subs = @(
            "01.primary_k6",
            "02.secondary_7_12",
            "03.teaching_guides"
        )
    }
    "60" = @{
        Name = "communication_and_technology"
        Subs = @(
            "01.radio",
            "02.encryption",
            "03.offline_tools"
        )
    }
    "70" = @{
        Name = "history_and_government"
        Subs = @(
            "01.us_history",
            "02.world_history",
            "03.founding_documents"
        )
    }
    "80" = @{
        Name = "reference"
        Subs = @(
            "01.dictionaries",
            "02.encyclopedias",
            "03.field_guides"
        )
    }
    "90" = @{
        Name = "faith_and_philosophy"
        Subs = @(
            "01.scripture",
            "02.commentaries",
            "03.ethics"
        )
    }
}

foreach ($code in $structure.Keys) {
    $category = $structure[$code]
    $topLevel = "$code.$($category.Name)"
    New-Item -Path $topLevel -ItemType Directory -Force | Out-Null

    foreach ($sub in $category.Subs) {
        $subPath = Join-Path $topLevel "$code.$sub"
        New-Item -Path $subPath -ItemType Directory -Force | Out-Null
    }
}
