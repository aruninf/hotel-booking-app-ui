import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.nudge.nudge"
            resValue(type = "string", name = "app_name", value = "Nudge")
        }
        create("di") {
            dimension = "flavor-type"
            applicationId = "com.nudge.nudge.di"
            resValue(type = "string", name = "app_name", value = "Nudge DI")
        }
        create("api") {
            dimension = "flavor-type"
            applicationId = "com.nudge.nudge.api"
            resValue(type = "string", name = "app_name", value = "Nudge API")
        }
    }
}