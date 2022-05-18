import Foundation
import Loooot

/**
 This class is used to manage api calls.
 */
public class ProtoClientManager: ProtoHttpManagerDelegate {
    public static var shared: ProtoHttpManagerDelegate! { get { return ProtoClientManager() } }
    
    private let httpMethodPost = "POST"
    private let httpMethodGet = "GET"
    private let applicationPROTOBUFF = "application/x-protobuf; charset=UTF-8"
    private let httpHeaderField = "Content-Type"
    private let statusCodeJson = "StatusCode"
    private let successJson = "Success"
    private let dataJson = "Data"
    
    private let urlSession: URLSession!
    private let emptyParameters = [String: String]()
    private var termsAndConditionsUrl = ""
    private var faqUrl = ""
    
    private func getWebApiUrl() -> String {
        return LooootConfig.webApiProductionUrl
    }
    
    private init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 120
        sessionConfig.timeoutIntervalForResource = 120
        urlSession = URLSession(configuration: sessionConfig)
    }
    
    public func getTermsAndConditionsUrl() -> String {
        if !termsAndConditionsUrl.isEmpty {
            return termsAndConditionsUrl
        }
        let url = "\(LooootConfig.webProductionUrl)\(EndPoint.downloadTerms)?\(StringConstants.clientId)=\(BaseLooootManager.sharedInstance.getClientId())&\(StringConstants.languageId)=\(BaseLooootManager.sharedInstance.getCurrentLanguageId())"
        print(url)
        return url
    }
    
    public func getFAQUrl() -> String {
        if !faqUrl.isEmpty {
            return faqUrl
        }
        return "\(LooootConfig.webProductionUrl)\(EndPoint.faq)?\(StringConstants.clientId)=\(BaseLooootManager.sharedInstance.getClientId())&\(StringConstants.languageId)=\(BaseLooootManager.sharedInstance.getCurrentLanguageId())"
    }
    
    public func resetTermsAndConditionsAndFAQUrl() {
        termsAndConditionsUrl = ""
        faqUrl = ""
    }

    public func getClients(_ term: String, completion: @escaping (Array<ClientModel>?, Bool) -> Void) {
        let parameters = [
            StringConstants.term: term
        ]
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getClients, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do
            {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                    return
                }
                let protoModel = try GetLanguagesResponseProto.init(serializedData: data!)

                if protoModel.response.success
                {
                    var languages = Array<ClientModel>()
                    for protoLanguage in protoModel.data {
                        let language = ClientModel(id: protoLanguage.id, name: protoLanguage.name)
                        languages.append(language)
                    }
                    
                    DispatchQueue.main.async {
                        completion(languages, true)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    /**
     This method is used to return available languages of the app based on the default client id, which is LooootClientIdEnum.default.
     
     - parameters:
        - completion: The block to execute once the request has finished.
        - data: The data of type Array? of LanguageModel returned by the api call.
        - isSuccessful: True if the api call has ended successfully, false otherwise.
     */
    public func getLanguagesByClient(completion: @escaping (_ data: Array<LanguageModel>?, _ isSuccessful: Bool) -> Void) {
        getLanguagesByClient(clientId: LooootClientIdEnum.default, completion: completion)
    }
    
    /**
     This method is used to return available languages of the app based on the clientId.
     
     - parameters:
        - clientId: The client id based on which available languages will be returned.
        - completion: The block to execute once the request has finished.
        - data: The data of type Array? of LanguageModel returned by the api call.
        - isSuccessful: True if the api call has ended successfully, false otherwise.
     */
    public func getLanguagesByClient(clientId: LooootClientIdEnum, completion: @escaping (_ data: Array<LanguageModel>?, _ isSuccessful: Bool) -> Void) {
        let parameters = [
            StringConstants.clientId: String(clientId.rawValue)
        ]
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getLanguagesByClient, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do
            {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                    return
                }
                let protoModel = try GetLanguagesResponseProto.init(serializedData: data!)

                if protoModel.response.success
                {
                    var languages = Array<LanguageModel>()
                    for protoLanguage in protoModel.data {
                        let language = LanguageModel(id: protoLanguage.id, name: protoLanguage.name, iso2: protoLanguage.iso2)
                        languages.append(language)
                    }
                    
                    DispatchQueue.main.async {
                        completion(languages, true)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func setTermsAndConditionsUrl(url: String) {
        termsAndConditionsUrl = url
    }
    
    public func initializeLooootManager(playerIdentifier: String, clientId: Int64, completion: @escaping (_ data: InitResponse?, _ isSuccessful: Bool) -> Void) {
        let parameters = [
            StringConstants.languageId: String(LooootManager.shared.getCurrentLanguageId()),
            StringConstants.playerIdentifier: playerIdentifier,
            StringConstants.clientId: String(clientId)
        ]

        let url = generateQueryUrl(apiEndpoint: EndPoint.initializeLooootManager, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            do
               {
              
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        self.getRequestTime(endpoint: EndPoint.initializeLooootManager, time: startRequest, success: false)
                        completion(nil, false)
                    }
                    return
                }
                let protoModel = try InitModelResponse.init(serializedData: data!)
                if protoModel.response.success {

                    var minifiedTokenList = Array<CampaignMinified>()
                    for miniCampaignPtoto in protoModel.data.campaignList {
                        let miniTokenTmp = CampaignMinified(id: miniCampaignPtoto.id, name: miniCampaignPtoto.name, proximity: Int(miniCampaignPtoto.proximity))
                        minifiedTokenList.append(miniTokenTmp)
                    }

                    let initResponse = InitResponse()
                    initResponse.playerId = protoModel.data.userID
                    initResponse.campaignMinifiedList = minifiedTokenList
                    initResponse.isDebug = protoModel.data.isDebug
                    initResponse.offsetXGetMarkers = Int(protoModel.data.offsetX)
                    initResponse.offsetYGetMarkers = Int(protoModel.data.offsetY)
                    initResponse.maxTokensDisplayed = Int(protoModel.data.take)
                    initResponse.defaultTimeUpdate = Int(protoModel.data.defaultTimeUpdate)
                    initResponse.shouldGetTokensAfterClaim = protoModel.data.shouldGetTokensAfterClaim
                    initResponse.disableAR = protoModel.data.disableAr
                    initResponse.allowMockLocation = protoModel.data.allowMockLocation
                    initResponse.signalRUrl = protoModel.data.urlSignalR


                    DispatchQueue.main.async {
                        completion(initResponse, true)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion(nil, false)
                }
               }
            catch _
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }

            }
        }
        task.resume()
    }

    public func startSession(currentTime: String, completion: @escaping (_ data: StartSessionResponse?, _ isSuccessful: Bool) -> Void) {
        var startSessionModelProto = StartSessionModelProto()
        startSessionModelProto.clientID = BaseLooootManager.sharedInstance.getClientId()
        startSessionModelProto.playerID = BaseLooootManager.sharedInstance.getPlayerId()
        startSessionModelProto.campaignIDList = BaseLooootManager.sharedInstance.getCampaignIdList()
        startSessionModelProto.latitude = BaseLooootManager.sharedInstance.getCurrentLatitude()!
        startSessionModelProto.longitude = BaseLooootManager.sharedInstance.getCurrentLongitude()!
        startSessionModelProto.currentTime = currentTime
        let data:Data = try! startSessionModelProto.serializedData()

        let url = generateQueryUrl(apiEndpoint: EndPoint.startSession, parameters: emptyParameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodPost, body: data)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            do
            {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.startSession, time: startRequest, success: false)
                    }
                    return
                }
                let val = try StartSessionResponseProto.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.startSession, time: startRequest, success: val.response.success)

                let webApiResponse = WebResponse<StartSessionResponse>()
                webApiResponse.setStatusCode(statusCode: Int(val.response.statusCode))
                webApiResponse.setSuccess(success: val.response.success)

                if webApiResponse.isSuccessful() {

                    let session = StartSessionResponse(sessionId: val.data.sessionID)
                    webApiResponse.setData(data: session)

                    DispatchQueue.main.async {
                        completion(webApiResponse.getData(), true)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
    
    public func endSession(currentTime: String) {
        var endSessionModelProto = EndSessionModelProto()
        endSessionModelProto.playerID = BaseLooootManager.sharedInstance.getPlayerId()
        endSessionModelProto.sessionID = Int64(BaseLooootManager.sharedInstance.getSessionId()!)
        endSessionModelProto.currentTime = currentTime
        let data:Data = try! endSessionModelProto.serializedData()

        let url = generateQueryUrl(apiEndpoint: EndPoint.startSession, parameters: emptyParameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodPost, body: data)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) {(data, response, error) in
            
            self.getRequestTime(endpoint: EndPoint.startSession, time: startRequest, success: true)

        }
        task.resume()
    }
    
    public func getCampaigns(completion: @escaping (Array<Campaign>?, Bool) -> Void) {
        let parameters = [
            StringConstants.languageId: String(LooootManager.shared.getCurrentLanguageId()),
            StringConstants.playerId: BaseLooootManager.sharedInstance.getPlayerId().description,
            StringConstants.clientId: String(BaseLooootManager.sharedInstance.getClientId()),
            StringConstants.playerIdentifier: BaseLooootManager.sharedInstance.getPlayerIdentifier()
        ]
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getCampaigns, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do
            {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.getCampaigns, time: startRequest, success: false)
                    }
                    return
                }
                let protoModel = try GetCampaignsResponse.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.getCampaigns, time: startRequest, success: protoModel.response.success)

                if protoModel.response.success {

                    let df = DateFormatter()
                    df.dateFormat = StringConstants.ISODateFormat
                    var campaigns = Array<Campaign>()
                    for campaignProto in protoModel.data {
                        let tmpCampaign = Campaign()
                        tmpCampaign.setId(id: campaignProto.id)
                        tmpCampaign.setName(name: campaignProto.name)
                        tmpCampaign.setProximity(proximity: Int(campaignProto.proximity))
                        tmpCampaign.setRemainingRewards(remainingRewards: Int(campaignProto.tokensAvailable))
                        let endDate = df.date(from: campaignProto.endDate)
                        if endDate != nil {
                            tmpCampaign.setEndDate(endDate: endDate!)
                        }
                        let startDate = df.date(from: campaignProto.startDate)
                        if endDate != nil {
                            tmpCampaign.setStartDate(startDate: startDate!)
                        }
                        campaigns.append(tmpCampaign)
                    }

                    DispatchQueue.main.async {
                        completion(campaigns, true)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func getTokensMinifiedList(campaignId: Int64, completion: @escaping (Array<RewardTypeList>?, Bool) -> Void) {
        let parameters = [
            StringConstants.languageId: String(LooootManager.shared.getCurrentLanguageId()),
            StringConstants.campaignId: campaignId.description
        ]
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getTokenTypeByCampaign, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do
            {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.getTokenTypeByCampaign, time: startRequest, success: false)

                    }
                    return
                }
                let protoModel = try GetTkTyByCampaignResponseProto.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.getTokenTypeByCampaign, time: startRequest, success: protoModel.response.success)

                if protoModel.response.success
                {
                    var tokens = Array<RewardTypeList>()
                    for protoToken in protoModel.dataList {
                        let tok = RewardTypeList(
                            id: protoToken.id,
                            name: protoToken.name,
                            name2: protoToken.name2,
                            campaignNames: protoToken.campaignNames,
                            rewardImageUrl: protoToken.tokenImageURL,
                            rewardType: Int(protoToken.rewardType))
                        tokens.append(tok)
                    }
                    
                    DispatchQueue.main.async {
                        completion(tokens, true)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func getTokensByLocation(completion: @escaping (Array<MapReward>?, Bool) -> Void) {
        let df = DateFormatter()
        df.dateFormat = StringConstants.ISODateFormat
        let currentTimeAsISO = df.string(from: Date())
        
        var protoPost = GetTokensModelProto()
        protoPost.latitude = BaseLooootManager.sharedInstance.getCurrentLatitude()!
        protoPost.longitude = BaseLooootManager.sharedInstance.getCurrentLongitude()!
        protoPost.playerID = BaseLooootManager.sharedInstance.getPlayerId()
        protoPost.campaignIDList = BaseLooootManager.sharedInstance.getCampaignIdList()
        protoPost.latestUpdate = currentTimeAsISO
        protoPost.sessionID = BaseLooootManager.sharedInstance.getSessionId()!
        protoPost.languageID = LooootManager.shared.getCurrentLanguageId()
        let data:Data = try! protoPost.serializedData()
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getTokensByLocation, parameters: emptyParameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodPost, body: data)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            do
            {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.getTokensByLocation, time: startRequest, success: false)

                    }
                    return
                }
                let protoModel = try GetTokensByLocationResponse.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.getTokensByLocation, time: startRequest, success: protoModel.response.success)

                if(protoModel.response.success)
                {
                    var mapTokenList = Array<MapReward>()
                    for mapTokenType in protoModel.dataList {
                        for minimisedMapToken in mapTokenType.minifiedTokenList {
                            let mapToken = MapReward(
                                id: minimisedMapToken.id,
                                groupId: minimisedMapToken.groupID,
                                campaignId: mapTokenType.campaignID,
                                rewardTypeId: mapTokenType.id, //maybe here
                                latitude: minimisedMapToken.latitude,
                                longitude: minimisedMapToken.longitude,
                                name: mapTokenType.name,
                                name2: mapTokenType.name2,
                                imageUrl: mapTokenType.imageURL)
                            mapTokenList.append(mapToken)
                        }
                    }
                
                    DispatchQueue.main.async {
                        completion(mapTokenList, true)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    public func getAllTokens(completion: @escaping (Array<RewardTypeList>?, Bool) -> Void) {
        var protoPost = GetAllTokensModelProto()
        protoPost.userID = BaseLooootManager.sharedInstance.getPlayerId()
        protoPost.campaignIDList = BaseLooootManager.sharedInstance.getCampaignIdList()
        protoPost.languageID = LooootManager.shared.getCurrentLanguageId()
        let data:Data = try! protoPost.serializedData()
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getTokens, parameters: emptyParameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodPost, body: data)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            do
            {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.getTokens, time: startRequest, success: false)

                    }
                    return
                }
                let protoModel = try GetTokensResponseProto.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.getTokens, time: startRequest, success: protoModel.response.success)

                if(protoModel.response.success)
                {
                    var list = Array<RewardTypeList>()
                    for item in protoModel.dataList
                    {
                        let tmpReward = RewardTypeList()
                        tmpReward.setRewardType(rewardType: Int(item.rewardType))
                        tmpReward.setId(id: item.id)
                        tmpReward.setRewardImageUrl(rewardImageUrl: item.tokenImageURL)
                        tmpReward.setCampaignNames(campaignNames: item.campaignNames)
                        tmpReward.setName(name: item.name)
                        tmpReward.setName2(name2: item.name2)
                        list.append(tmpReward)
                    }
                    
                    DispatchQueue.main.async {
                        completion(list, true)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    public func getTokenTypeById(tokenTypeId: Int64, completion: @escaping (RewardTypeDetails?, Bool) -> Void) {
        let parameters = [
            StringConstants.languageId: String(LooootManager.shared.getCurrentLanguageId()),
            StringConstants.tokenTypeId: tokenTypeId.description
        ]
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getTokenTypeById, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do{
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.getTokenTypeById, time: startRequest, success: false)

                    }
                    return
                }
                let postModel = try GetTkTyByIdResponseProto.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.getTokenTypeById, time: startRequest, success: postModel.response.success)

                if postModel.response.success
                {
                    let item = postModel.data
                    let rewardTypeDetails = RewardTypeDetails()
                    rewardTypeDetails.setId(id: item.id)
                    rewardTypeDetails.setName(name: item.name)
                    rewardTypeDetails.setName2(name2: item.name2)
                    rewardTypeDetails.setMessage(message: item.message)
                    rewardTypeDetails.setImageUrl(imageUrl: item.imageURL)
                    rewardTypeDetails.setRedeemType(redeemType: Int(item.redeemType))
                    rewardTypeDetails.setPromotionImageUrl(promotionImageUrl: item.promotionImageURL)
                    rewardTypeDetails.setQrContent(qrContent: item.qrContent)
                    rewardTypeDetails.setStatus(status: Int(item.status))
                    rewardTypeDetails.setRedemptionRules(redemptionRules: item.redemtionRules)
                    rewardTypeDetails.setCouponDisplayType(couponDisplayType: Int(item.couponDisplayType))
                    rewardTypeDetails.setCouponBarcodeType(couponBarcodeType: Int(item.couponBarcodeType))
                    
                    DispatchQueue.main.async {
                        completion(rewardTypeDetails, true)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                
            }catch let error
            {
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func claimToken(reward: MapReward, proximity: Int, claimedAt: String, lat: Double, lng: Double, completion: @escaping (WebResponse<RewardClaimResponse>?, Bool) -> Void) {
        var model = ClaimModelProto()
        model.clientID = BaseLooootManager.sharedInstance.getClientId()
        model.tokenID = reward.getId()
        model.userID =  BaseLooootManager.sharedInstance.getPlayerId()
        model.campaignID = reward.getCampaignId()
        model.playerLatitude = lat
        model.playerLongitude = lng
        model.tokenLatitude = reward.getLatitude()
        model.tokenLongitude = reward.getLongitude()
        model.claimedAt = claimedAt
        model.campaignProximity = Int32(proximity)
        model.tokenTypeID = reward.getRewardTypeId()
        model.sessionID = BaseLooootManager.sharedInstance.getSessionId()!
        model.groupID = reward.getGroupId()
        model.languageID = LooootManager.shared.getCurrentLanguageId()
        let data:Data = try! model.serializedData()
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.claimToken, parameters: emptyParameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodPost, body: data)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            do{
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.claimToken, time: startRequest, success: false)

                    }
                    return
                }
                let protoModel = try ClaimResponse.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.claimToken, time: startRequest, success: protoModel.response.success)

                let webApiResponse = WebResponse<RewardClaimResponse>()
                webApiResponse.setStatusCode(statusCode: Int(protoModel.response.statusCode))
                webApiResponse.setSuccess(success: protoModel.response.success)
                
                if protoModel.response.success {
                    let rewardClaimResponse = RewardClaimResponse()
                    rewardClaimResponse.setMessage(message: protoModel.data.message)
                    rewardClaimResponse.setRedeemType(redeemType: Int(protoModel.data.redeemType))
                    rewardClaimResponse.setRuleLimitMessage(ruleLimitMessage: protoModel.data.ruleLimitMessage)
                    rewardClaimResponse.setQrContent(qrContent: protoModel.data.qrContent)
                    let df = DateFormatter()
                    df.dateFormat = StringConstants.ISODateFormat
                    
                    var expirationDate: Date? = nil
                    expirationDate = df.date(from: protoModel.data.expirationDate)
                    if expirationDate != nil {
                        rewardClaimResponse.setExpirationDate(expirationDate: expirationDate!)
                    }
                    
                    webApiResponse.setData(data: rewardClaimResponse)

                    DispatchQueue.main.async {
                        completion(webApiResponse, true)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                
            } catch let error
            {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func redeemToken(tokenId: Int64, redeemedAt: String, completion: @escaping (RewardTypeDetails?, Bool) -> Void) {
        let parameters = [
            StringConstants.languageId: String(LooootManager.shared.getCurrentLanguageId()),
            StringConstants.userId: BaseLooootManager.sharedInstance.getPlayerId().description,
            StringConstants.tokenId: tokenId.description,
            StringConstants.redeemedAt: redeemedAt
        ]
    
        let url = generateQueryUrl(apiEndpoint: EndPoint.redeemToken, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            do {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.redeemToken, time: startRequest, success: false)

                    }
                    return
                }
                let protoModel = try RedeemResponseProto.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.redeemToken, time: startRequest, success: protoModel.response.success)
                if protoModel.response.success {
                    let item = protoModel.data
                    let reward = RewardTypeDetails()
                    reward.setId(id: Int64(item.id))
                    reward.setName(name: item.name)
                    reward.setName2(name2: item.name2)
                    reward.setMessage(message: item.message)
                    reward.setImageUrl(imageUrl: item.imageURL)
                    reward.setRedeemType(redeemType: Int(item.redeemType))
                    reward.setPromotionImageUrl(promotionImageUrl: item.promotionImageURL)
                    reward.setQrContent(qrContent: item.qrContent)
                    reward.setStatus(status: Int(item.status))
                  
                    DispatchQueue.main.async {
                        completion(reward, true)
                    }
                    return
                }
           
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func getWallet(completion: @escaping (Array<WalletList>?, Bool) -> Void) {
        let parameters = [
            StringConstants.languageId: String(LooootManager.shared.getCurrentLanguageId()),
            StringConstants.userId: BaseLooootManager.sharedInstance.getPlayerId().description,
            StringConstants.clientId: String(BaseLooootManager.sharedInstance.getClientId())
        ]
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getWallet, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.getWallet, time: startRequest, success: false)

                    }
                    return
                }
                let protoModel = try GetWalletResponseProto.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.getWallet, time: startRequest, success: protoModel.response.success)
                if protoModel.response.success{
                    let df = DateFormatter()
                    df.dateFormat = StringConstants.ISODateFormat
                    
                    var walletTokens = Array<WalletList>()
                    for item in protoModel.dataList {
                        let tmpWallet = WalletList(id: item.id, name: item.name, name2: item.name2, rewardImageUrl: item.imageURL, rewardType: Int(item.rewardType), mapRewardId: item.mapTokenID, expirationDate: Date.init(), campaignName: item.campaignName, qrContent: item.qrContent)
                        let expirationDate = df.date(from: item.expirationDate)
                        if expirationDate != nil {
                            tmpWallet.setExpirationDate(expirationDate: expirationDate!)
                        }
                        walletTokens.append(tmpWallet)
                    }

                    DispatchQueue.main.async {
                        completion(walletTokens, true)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func getNextAd(adImageId: Int64, completion: @escaping (Ad?, Bool) -> Void) {
        let parameters = [
            StringConstants.languageId: String(LooootManager.shared.getCurrentLanguageId()),
            StringConstants.userId: BaseLooootManager.sharedInstance.getPlayerId().description,
            StringConstants.clientId: String(BaseLooootManager.sharedInstance.getClientId()),
            StringConstants.lastAdImageId: adImageId.description
        ]
        
        let url = generateQueryUrl(apiEndpoint: EndPoint.getNextAd, parameters: parameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodGet)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
           
            do {
                if(data == nil)
                {
                    DispatchQueue.main.async {
                        completion(nil, false)
                        self.getRequestTime(endpoint: EndPoint.getNextAd, time: startRequest, success: false)

                    }
                    return
                }
                let protoModel = try GetNextAdImageResponseProto.init(serializedData: data!)
                self.getRequestTime(endpoint: EndPoint.getNextAd, time: startRequest, success: protoModel.response.success)
                if protoModel.response.success {
                    
                    let item = protoModel.data
                    let ad = Ad()
                    ad.setAdId(adId: item.adID)
                    ad.setImageId(imageId: item.imageID)
                    ad.setImageUrl(imageUrl: item.imageURL)
                    ad.setType(type: Int(item.type))
                    ad.setRedirectLink(redirectLink: item.redirectLink)
                    ad.setDisplayTime(displayTime: Int(item.displayTime))
                    ad.setShowTime(showTime: Int(item.showTime))
                    ad.setBackgroundColor(backgroundColor: item.backgroundColor)

                    DispatchQueue.main.async {
                        completion(ad, true)
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func adShown(adDisplayedModel: AdDisplayedModel) {
        var adDisplayProto = AdDisplayedModelProto()
        adDisplayProto.adID = adDisplayedModel.getAdId()
        adDisplayProto.currentTime = adDisplayedModel.getCurrentISOTime()
        adDisplayProto.playerID = adDisplayedModel.getPlayerId()
        adDisplayProto.languageID = LooootManager.shared.getCurrentLanguageId()
        
        let data:Data = try! adDisplayProto.serializedData()
        let url = generateQueryUrl(apiEndpoint: EndPoint.adShown, parameters: emptyParameters)
        let urlRequest = createURLRequest(url: url, method: httpMethodPost, body: data)
        let startRequest = Date()
        let task = urlSession.dataTask(with: urlRequest) {
                (data, response, error) in
                    self.getRequestTime(endpoint: EndPoint.adShown, time: startRequest, success: true)
               }
        task.resume()
    }
    
    public func adTapped(adDisplayedModel: AdDisplayedModel) {
        var adDisplayProto = AdDisplayedModelProto()
        adDisplayProto.adID = adDisplayedModel.getAdId()
        adDisplayProto.currentTime = adDisplayedModel.getCurrentISOTime()
        adDisplayProto.playerID = adDisplayedModel.getPlayerId()
        
        let data:Data = try! adDisplayProto.serializedData()
        let url = generateQueryUrl(apiEndpoint: EndPoint.adTapped, parameters: emptyParameters)
        
        let urlRequest = createURLRequest(url: url, method: httpMethodPost, body: data)
        let task = urlSession.dataTask(with: urlRequest) {
                (data, response, error) in
//            self.getRequestTime(endpoint: EndPoint.adTapped, time: startRequest)
               }
        task.resume()
    }
    
    private func getRequestTime(endpoint:String, time:Date, success:Bool) {
        if !BaseLooootManager.sharedInstance.isDebugMode() {
            return
        }
        let executionTime = Date().timeIntervalSince(time)
        let time  =  executionTime.description
        DispatchQueue.main.async {
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.view.showAutoDismissAlertWithOneButton(title: " \(endpoint) ", message: "Executed in \n \(time) \n with Success: \n \(success)", buttonTitle: "Ok")
                // topController should now be your topmost view controller
            }
        }
    }
    
    private func generateQueryUrl(apiEndpoint: String, parameters: Dictionary<String, String>) -> String {
        var url = getWebApiUrl()
        url.append(apiEndpoint)
        url.append(generateQueryParameters(parameters: parameters))
        return url
    }
    
    private func generateQueryParameters(parameters: Dictionary<String, String>) -> String {
        if parameters.isEmpty {
            return ""
        }
        
        var count = 0
        var str = ""
        for (key, value) in parameters {
            if count == 0 {
                str.append("?")
            }
            else {
                if count != parameters.count {
                    str.append("&")
                }
            }
            str.append(key)
            str.append("=")
            str.append(value)
            count += 1
        }
        
        return str
    }
    
    private func createURLRequest(url: String, method: String, body: Data? = nil) -> URLRequest{
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method
        urlRequest.setValue(applicationPROTOBUFF, forHTTPHeaderField: httpHeaderField)
        urlRequest.httpBody = body
        return urlRequest
    }
    
    private func tryGetDictionary(data: Data?, error: Error?) -> NSDictionary? {
        if error != nil {
            return nil
        }
        guard let data = data else {
            return nil
        }
        let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
        return dictionary
    }
}
