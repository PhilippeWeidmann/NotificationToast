
# NotificationToast

A view that tries to replicate iOS default toast message view.
| Title  | Icon | Subtitle |
| ------------- | ------------- | ------------- |
| ![Title](./Screenshots/title.png)  | ![Icon](./Screenshots/icon.png) | ![Subtitle](./Screenshots/subtitle.png) |

# Usage
Add this lib to your project using SPM or Cocoapods.

To get the simple "Apple look" you only have to do this:
```swift
import NotificationToast

let toast = ToastView(title: "Safari pasted from Notes")
toast.show()
```
The view also includes many optional customizable properties:
```swift
let toast = ToastView(
    title: "Airpods Pro",
    titleFont: .systemFont(ofSize: 13, weight: .regular),
    subtitle: "Connected",
    subtitleFont: .systemFont(ofSize: 11, weight: .light),
    icon: UIImage(systemName: "airpodspro"),
    iconSpacing: 16,
    position: .bottom,
    onTap: { print("Tapped!") }
)
toast.show()
```
You can present the view with a haptic feedback at the same time (`nil` by default) :
```swift
toast.show(haptic: .success)
```

# Contribute
As this is my first 'UI' package I'm sure it can be greatly improved, PR are welcome 😊

