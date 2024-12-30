struct PhotoDetail: Codable {
    let id: String
    let downloads: Stat
    let views: Stat
    let likes: Stat
    
    struct Stat: Codable {
        let total: Int
    }
}