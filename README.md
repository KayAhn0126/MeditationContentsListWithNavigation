# MeditationContentListWithNavigation

## 🍎 작동 화면

| 작동 화면 |
|:--------------------------------:|
| ![](https://i.imgur.com/dEHBLBM.gif) |


## 🍎 전반적 설명
- MeditationContentListViewController -> **presentingVC 역할**
- QuickFocusListViewController -> **presentedVC 역할**

## 🍎 MeditationContentListViewController에서 아이템을 클릭하는 코드 설명
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

## 🍎 UICollectionReusableView을 사용해 header 생성하기
- UICollectionReusableView을 이용해 각 Section의 header를 생성

|          스토리보드 내 위치          |              앱 내 위치              |
|:------------------------------------:|:------------------------------------:|
| ![](https://i.imgur.com/eibkfPL.png) | ![](https://i.imgur.com/KoSRkN1.png) |

- 먼저 QuickFocusListViewController의 viewDidLoad()메서드에서 header를 구성하는 코드를 보자.
```swift
override func viewDidLoad() {
        super.viewDidLoad()
        // Presentation
        ...
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuickFocusCollectionReusableView", for: indexPath) as? QuickFocusCollectionReusableView else { return nil }
            
            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)
            return header
        }
        
        // Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        ...
    }
```
- UICollectionReusableView도 cell을 구성하는 것처럼 구성해주면 된다.
- 아래는 Section의 computed property를 이용해 header에 원하는 문구를 넣는 과정.
```swift
let allSections = Section.allCases
// let allSections: [QuickFocusListViewController.Section]와 같다.

let section = allSections[indexPath.section]
// let section: QuickFocusListViewController.Section

header.configure(section.title)
// 아래의 코드 참조
```

```swift
class QuickFocusCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
```

## 🍎 header의 내용은 알맞게 넣어주었으니, header의 레이아웃도 잡아주자.
- cell의 레이아웃을 잡는곳에서 같이 잡아주기.
```swift
private func layout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    group.interItemSpacing = .fixed(10) // 😃
        
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20) // 😃
    section.interGroupSpacing = 20 // 😃
        
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)) // 😃
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top) // 😃
    section.boundarySupplementaryItems = [header] // 😃
        
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}
```
- 😃 표시 되어있는 코드 분석
```swift
group.interItemSpacing = .fixed(10)
```
- 그룹 내 아이템간 간격
```swift
section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
```
- Section 상하좌우 inset 설정
```swift
section.interGroupSpacing = 20
```
- Section 내 그룹간 간격

```swift
let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
```
- Section을 기준으로 가로 1배, 세로 50 고정

```swift
let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
```

- https://nsios.tistory.com/150 잘 정리 되어있으니 NSCollectionLayoutBoundarySupplementaryItem에 대해 알아보고 정리하기.
