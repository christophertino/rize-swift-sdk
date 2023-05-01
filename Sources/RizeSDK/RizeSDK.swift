//
// RizeSDK Package Init
//
// Copyright 2023-Present Rize Money, Inc. All rights reserved.
//

import Foundation

/// RizeSDK is the top-level client containing all APIs and configurations
public struct RizeSDK {
	internal private(set) static var config: RizeConfig?
	internal var adjustments: Adjustments
	internal var auth: Auth
	internal var cardArtworks: CardArtworks
	internal var complianceWorkflows: ComplianceWorkflows
	internal var custodialAccounts: CustodialAccounts
	internal var custodialPartners: CustodialPartners
	internal var customerProducts: CustomerProducts
	internal var customers: Customers
	internal var debitCards: DebitCards
	internal var documents: Documents
	internal var evaluations: Evaluations
	internal var kycDocuments: KYCDocuments
	internal var pinwheelJobs: PinwheelJobs
	internal var pools: Pools
	internal var products: Products
	internal var sandboxes: Sandboxes
	internal var syntheticAccounts: SyntheticAccounts
	internal var transactions: Transactions
	internal var transfers: Transfers

	public init(config: RizeConfig) {
		RizeSDK.config = config

		Utils.logger("Creating client")

		// Initialize API Services
		self.adjustments = Adjustments()
		self.auth = Auth()
		self.cardArtworks = CardArtworks()
		self.complianceWorkflows = ComplianceWorkflows()
		self.custodialAccounts = CustodialAccounts()
		self.custodialPartners = CustodialPartners()
		self.customerProducts = CustomerProducts()
		self.customers = Customers()
		self.debitCards = DebitCards()
		self.documents = Documents()
		self.evaluations = Evaluations()
		self.kycDocuments = KYCDocuments()
		self.pinwheelJobs = PinwheelJobs()
		self.pools = Pools()
		self.products = Products()
		self.sandboxes = Sandboxes()
		self.syntheticAccounts = SyntheticAccounts()
		self.transactions = Transactions()
		self.transfers = Transfers()
	}
}
