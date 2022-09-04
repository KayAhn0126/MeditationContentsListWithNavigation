# MeditationContentListWithNavigation

## 🍎 작동 화면

| 작동 화면 |
|:--------------------------------:|
| ![](https://i.imgur.com/dEHBLBM.gif) |


## 🍎 전반적 설명
- MeditationContentListViewController -> **presentingVC 역할**
- QuickFocusListViewController -> **presentedVC 역할**

## 🍎 MeditationContentListViewController에서 아이템을 클릭하는 코드
```swift
extension MeditationContentListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        print(">>> \(item.title)")
        
        let storyboard = UIStoryboard(name: "QuickFocus", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuickFocusListViewController") as! QuickFocusListViewController
        vc.title = item.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
```
- vc.title = item.title
    - 클릭한 아이템의 이름을 navigationController을 통해 띄우려는 QuickFocusListViewController의 타이틀로 적용하는 코드
- navigationController?.pushViewController(vc, animated: true)
    - navigationController는 자신만의 스택을 기준으로 push와 pop을 하는 구조. 현재 코드는 pushViewController를 통해 새로운 VC를 띄우는 상황.

## 🍎 각 VC의 title 크기 다르게 적용하기.
- 현재 작동 화면을 보게 되면 MeditationContentListViewController의 title은 큼지막하고, 네비게이션 컨트롤러로 띄운 QuickFocusListViewController의 타이틀은 조그마한것을 볼 수 있다.
- Navigation Controller에 Prefers Large Titles가 적용되면, 아래와 같이 presentingVC의 title과 presentedVC의 title 모두 Large Title로 적용된다.
- QuickFocusListViewController에서 view를 load하기 전에 아래와 같은 코드를 적용하면, 일반 크기의 title로 만들 수 있다.
```swift
self.navigationItem.largeTitleDisplayMode = .never
```
