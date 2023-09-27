Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F47B0210
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 12:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjI0Km0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 06:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjI0KmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 06:42:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F113A;
        Wed, 27 Sep 2023 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695811344; x=1727347344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/l334aow2LWAjOS++VlMh859QEuyf5y1Vf6qfUQXdWs=;
  b=j+8i/Hlkev/ZUkCXqxntWB26/53QfOBjY8wAmLguZgT/zZkzN2NHWRzG
   oEGf4H8gTxPRjR5lHZ5vmvki7Jw/paJNLMfVkNeFDySNYVUdPfIn40sMc
   J3a9taEPQ8B2n1bfZYFShWl3MGXqnO+ZFP6aTtm6WOVlt+s8/hGcMJR95
   dwIkXxLsP05Am5/nopumArAsMwqVw7Fn9zyh6eYAY5Hvx4f1uQ9LMesZN
   tNIvxt35TkntoUGKDQsG337BE1fZ9f1Qgn9NsDvmt2zUb2nXbm0vPwLbE
   exWPUVn1tJr9qBfmt5L1Ao/IXtAClfyEF6CR9ywz5udiwZjNf2kOtTOzO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445927453"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445927453"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="749159417"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="749159417"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 03:42:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:42:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:42:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 03:42:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 03:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMKBC/yPSwtSN1wiO6SZSXXZX4u2eCGqr7SJni4tnqUuUGmwxPPJAg1c78cHt9Fjl3hlbej5wBSUKLp/ey9QLT4WIklocObFV+juzFMym0n/RjE90nGiQLE3yReM2Pj6Z41G6uZh2X4kqz7gMdR+E4c19UCfAYWvll/dirvO4yoFeedkjdzcPNhq8ttDf6m0GAZfdAJai3w7whvh7e4j1xs1MQiCuo0Kp9QtVJyi4n+8t3i5xq3TvxwZWle4vQ2nhvu0OaKfaNiloR4xOw9+kQ5zZxcwrnzjb+k30ZH3DkYaColTWcij+UaBDydkFCl9CJe0JTFgTyknd39rva1Rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l334aow2LWAjOS++VlMh859QEuyf5y1Vf6qfUQXdWs=;
 b=GjDV4HTTSvBRkrPFizZ5hVXlIHMzg6aQI58piIulty7VMjyW8ci8xMya5p+rMiPtvi81Sdb1R/R7neACmybdooPmN9lnMhSjpcFQEnXXNTE9L5NaiyTuVpsDZa6+RIGyjJNz5/VWiB+cNJ7aeEDlKdN6iErhzAVN9QTT3XKP2QqlRqnwV/Yyw4FYguiDp4lL2f94sqkTxD8lvnFpFD1SAXq0KCS4RoKhRS0305eeosYWYzHlO8KR9XUZFJYaAk7/BHcaQjiDa/5PLL9cspmDNTAwSdhdYOux61J5bXiir0eE2cvHPvr8lakrMFGfu1OaTu65ik0Z6lJBmC6SYICprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7820.namprd11.prod.outlook.com (2603:10b6:610:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 10:42:16 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 10:42:16 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 07/18] x86/sgx: Introduce RECLAIM_IN_PROGRESS state
Thread-Topic: [PATCH v5 07/18] x86/sgx: Introduce RECLAIM_IN_PROGRESS state
Thread-Index: AQHZ7csW9OX1fYVQdEeS5cGRisacx7AugvaA
Date:   Wed, 27 Sep 2023 10:42:16 +0000
Message-ID: <4c88fc578d678ed1893f39bb2fb9b2b0e152f9b3.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-8-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-8-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB7820:EE_
x-ms-office365-filtering-correlation-id: cdac806c-298a-4617-fc9c-08dbbf466abe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JkWkWGPL68+xunvBLFJJUsdiQ55Qb3RxMXW7L6isDOPqsLtxBjDVjJEg/WY5mTowqjY4jadCwW43pk2K4MGNIOkZFAu9nsLir7bT14aONBuTctG4GtkEhiYuV1CKGuaA0Uo+57fBi+Dlt5m9bosBQN3CEr5Jhac33+KRp5z+CLcopToJoE6cS8NMVO6/Pk8Dlan++PqY02il7Hnjc1+P8dTc9qPzc6RV/xMsceI1Q0pcSFB5V+esUqCVZYINr3v1KPSYbZFLETdy4TcWS4HWqXLYKmY+rQPFqW8MVx0IbLZURvqoKKEjMuHskSH03p9rt+yXKhWVG9unx7R9QRvOvzNVMn4AUv5ZUDXKYfIT7Oe+k1gH2wtaE8MfmGCG2bhzYidpPKUjW/uEWh7huy/8c5FvDIMdnUNbEMxNAoqz8VfpkGH/R9Dwi/TeTRwyD4NZc8ge/UClUAoE6ElxNL9ZP2JFLpUeysfwdDj0eqMmL7ppeR3/xwp4JhoxHxvnME3llUG/JuYTTfkemSyJ33QwkQLfOYKpFufdZUg5YJOh6WNIEBRiEmn9shJP2Pkw7z14Pp5eqv8lh6LYMFwsCrmy3o0ZrsU8ROldWLosKvp7AI0E0Ih79ilMlJYLNQXzmdBqkBpANKfPug+kx7OrDw991w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(26005)(71200400001)(122000001)(6486002)(83380400001)(478600001)(2616005)(36756003)(921005)(86362001)(82960400001)(38070700005)(5660300002)(6506007)(38100700002)(6512007)(2906002)(8676002)(4326008)(41300700001)(316002)(54906003)(7416002)(91956017)(64756008)(66946007)(66446008)(66476007)(66556008)(76116006)(8936002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkcrSkdGOU9aNFdaYTlxL2JIN0RuMmhQcEl1TFZnMVoyN0pNeG5rdkhuSWJR?=
 =?utf-8?B?V0xqSVBob2JkZ1Vaa0NRVWI3ZTlWV1pyMllsQi9ENzU1Uk90TDdodFpYVDBK?=
 =?utf-8?B?VU94OXpRS2wyMGVWRm1xcElqOEhuYTRuNE1hTkc4NUw1d21aYWRINllGelJ5?=
 =?utf-8?B?YTArS0ZxSTBLbmNNWml0cXQ1MExadEIySmw0endhaFRORkllS0FxMC9pNEZ1?=
 =?utf-8?B?YlRKOVVCRkorUFR3dUN5bDUxcHJ1dkNTQWplS0pYSWFaRDFsWDBScmlDZlFT?=
 =?utf-8?B?MzZhYTM1SmJGR29nemJnMDBNV0dxTmJXTXNBd0xLRUlvNjdoNlZaUTZUTVhE?=
 =?utf-8?B?RmxNM1BRVEVHWFBCMGVlS3NMbTNsYTgrSVlXMGJYK3YvTzZuMFpGMnBWclNY?=
 =?utf-8?B?RGY1dndnbkIreGFuSitsWHJoTFh2QnloNStIU1ZSOHNvY0lvdlhWTWp5TGw4?=
 =?utf-8?B?b0s5Wm8yQUFKdnRZSlFNR2RtSHJEUlh6eFJmR1BxMlQzTm1FQnZFR1l4dkFJ?=
 =?utf-8?B?dEFIckQvMVdZZW9CUk1hZjBNZmtUMkdYTXEzelB2R05VWGFJV1QxWk4xQTdo?=
 =?utf-8?B?TXYydmtWdUNFaW5HK1lmT2g5WXAvRk9EOHpnL3lIa1Nmekk1RTBDeWVmdWJM?=
 =?utf-8?B?akVNeW1oQzB0bFRWellobzZQUDM3N0h0ai9ZTUxPdnFhL2U5UUZnOHg0Z0N2?=
 =?utf-8?B?MXBlRFcvVVBuTUsyaEpWWG5hekdBQzFOdmRHNmU0dnJ0dC94UkthRjZmOG1W?=
 =?utf-8?B?UlFZTWZCMVNFRFNtTktrT2NuV0k3YWNKYk5zMm83RHR6OUdEWUt1VmMrb0Jy?=
 =?utf-8?B?TXk4UE1RcEhoNWxRZEVwRGNNMXNCWHNYNXo0eVVLWXJSMlN0THZzZDhDNEdL?=
 =?utf-8?B?S0dKQ1YxWlpOZmRVeFg3WkxqNFJCRXJzM3lmbjFLRkxpUmU4ZDhGYklrNVlK?=
 =?utf-8?B?c3F6eE5JUW1qb09vVTl5VXVKM3NraUVGV2xLTTVJektFdUE1TFF6NElUcVVp?=
 =?utf-8?B?dXEwTmdmT0svNnI2M0J0Rjl4KzZka0tGOStvMHA5bitvQ0NMaDBwd3JqTHA3?=
 =?utf-8?B?V0lNNWlzY2NOSFhNNjE4bUtuQmM5eS9BMk1SMjB2M29YT0h1bC9VOE9jMVRp?=
 =?utf-8?B?Ri80NW0rRzl0QVB2U0h3dTRUQVdzSU1UUnU1VndRYjFrR3RVNC82MTc3elNF?=
 =?utf-8?B?LzBPaERLTUUrMllxRTMxRkt4UTJhR0kveVVyWFBiaytFdVQrUHNCYjQyejBa?=
 =?utf-8?B?V0U3YXJjajhiR1lRNGVZMkxIRDhmNVhuRUt3bGRSYWs3Unl4bU5iTEZjQjhm?=
 =?utf-8?B?dFJvckk4Y1JzeHRoUlZDTGtrMlBVWWhzKzFSWEZHMUROejI0MlErZ09JSG51?=
 =?utf-8?B?cDNzZEZCc29xdXE3d3J1WUV3ZUI1RVlYb2dKSi9KcllHZDJGRld4NEFQU3hz?=
 =?utf-8?B?cnBpc1pTR3RGWHNmM00xZ3dHVzMyZHIxb0JLWWNlMEJ0N3pxSjBFWkN2SW92?=
 =?utf-8?B?WWVqZVV5RHZaQnMzc3dQMnN2Z1JmZGRkdWxJVmZucWVJOHpyeklaWlMweVkw?=
 =?utf-8?B?cVRSTFhBK0FGZnZCdzc0WnNsK1JMOWR4OE9oTktTdXdwMVNlWCtsNEJMdGto?=
 =?utf-8?B?ZE5JWThzUFU3QlNjTlFrVGlQNWUzUUozT1pkOUZ1WDA3d0VVMiswMFFla2lz?=
 =?utf-8?B?SkJ2RkFoQWpYN09nalV3STBaRDF2QUZnSjdNWXFYTjBxM0hlNElmNURZTFMv?=
 =?utf-8?B?c0NrRUxwOXhJa2hHL1JWNTU2ZDVJU0liUlBMdDRwNnEzQ1lsSEpQWFpYVStE?=
 =?utf-8?B?VXNVWWEzZjhiaGRUTXZsTjNlUnRvYVREM2J0d1NJWjB0eUh1bmZiNFhrTVNK?=
 =?utf-8?B?RjNaQkZzSnF3aS9iekVYVUxScldkTlJOUTdvdlJDaW9DWHF6aVBZOFh1WmZW?=
 =?utf-8?B?c20vb2VEYXRLTlNldGZFS2s5cUV4OWtURDRzZWlYeGYxU2ttYnFtSEY3RzBW?=
 =?utf-8?B?cUtTN2hMTUVRcFZ3dVNRcm1GNXZJR0FLeEs2Sk5ITHdIei9jc1hKVFRrRXN6?=
 =?utf-8?B?R2RKdnZkbnFmZy9EZUkvQWlseTQ3R0p6bDZySVpQMTNJZkxwUXBnckJoa3B6?=
 =?utf-8?B?cmFianJOcW1vM3ZWZ3pwZU5IZ091NkVwQmlWSmhYckFrcXo2Qzk3ZlhTdS9U?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF4BB50EC78A15448AA9D41020A6530B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdac806c-298a-4617-fc9c-08dbbf466abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:42:16.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Li6w4UAbvnBR6BFdSDkJf7Ww5g4ek88D660CyWBzab+agjUKemXvkaDYP1jp/GXYCFqI5oS/HN7dUuhFltUUDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7820
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+IEBAIC0zMTIsMTMgKzMxMiwxNSBAQCBzdGF0aWMgdm9pZCBzZ3hfcmVjbGFpbV9wYWdlcyh2
b2lkKQ0KPiAgCQlsaXN0X2RlbF9pbml0KCZlcGNfcGFnZS0+bGlzdCk7DQo+ICAJCWVuY2xfcGFn
ZSA9IGVwY19wYWdlLT5vd25lcjsNCj4gIA0KPiAtCQlpZiAoa3JlZl9nZXRfdW5sZXNzX3plcm8o
JmVuY2xfcGFnZS0+ZW5jbC0+cmVmY291bnQpICE9IDApDQo+ICsJCWlmIChrcmVmX2dldF91bmxl
c3NfemVybygmZW5jbF9wYWdlLT5lbmNsLT5yZWZjb3VudCkgIT0gMCkgew0KPiArCQkJc2d4X2Vw
Y19wYWdlX3NldF9zdGF0ZShlcGNfcGFnZSwgU0dYX0VQQ19QQUdFX1JFQ0xBSU1fSU5fUFJPR1JF
U1MpOw0KPiAgCQkJY2h1bmtbY250KytdID0gZXBjX3BhZ2U7DQo+IC0JCWVsc2UNCj4gKwkJfSBl
bHNlIHsNCj4gIAkJCS8qIFRoZSBvd25lciBpcyBmcmVlaW5nIHRoZSBwYWdlLiBObyBuZWVkIHRv
IGFkZCB0aGUNCj4gIAkJCSAqIHBhZ2UgYmFjayB0byB0aGUgbGlzdCBvZiByZWNsYWltYWJsZSBw
YWdlcy4NCj4gIAkJCSAqLw0KDQpQbGVhc2UgdXNlIHByb3BlciBjb21tZW50IHN0eWxlOg0KDQpG
b3Igc2luZ2xlIGxpbmUgY29tbWVudDoNCg0KCS8qIC4uLiAqLw0KDQpGb3IgbXVsdGlwbGUgbGlu
ZXMgY29tbWVudDoNCg0KCS8qDQoJICogLi4uDQoJICovDQoJDQo+ICAJCQlzZ3hfZXBjX3BhZ2Vf
cmVzZXRfc3RhdGUoZXBjX3BhZ2UpOw0KPiArCQl9DQoNCk5pdDogdW5pbnRlbmRlZCBuZXcge30g
YXJvdW5kICdlbHNlJz8NCg0KPiAgCX0NCj4gIAlzcGluX3VubG9jaygmc2d4X2dsb2JhbF9scnUu
bG9jayk7DQo+ICANCj4gQEAgLTUyOCwxNiArNTMwLDEzIEBAIHZvaWQgc2d4X3JlY29yZF9lcGNf
cGFnZShzdHJ1Y3Qgc2d4X2VwY19wYWdlICpwYWdlLCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiAg
aW50IHNneF9kcm9wX2VwY19wYWdlKHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKnBhZ2UpDQo+ICB7DQo+
ICAJc3Bpbl9sb2NrKCZzZ3hfZ2xvYmFsX2xydS5sb2NrKTsNCj4gLQlpZiAoc2d4X2VwY19wYWdl
X3JlY2xhaW1hYmxlKHBhZ2UtPmZsYWdzKSkgew0KPiAtCQkvKiBUaGUgcGFnZSBpcyBiZWluZyBy
ZWNsYWltZWQuICovDQo+IC0JCWlmIChsaXN0X2VtcHR5KCZwYWdlLT5saXN0KSkgew0KPiAtCQkJ
c3Bpbl91bmxvY2soJnNneF9nbG9iYWxfbHJ1LmxvY2spOw0KPiAtCQkJcmV0dXJuIC1FQlVTWTsN
Cj4gLQkJfQ0KPiAtDQo+IC0JCWxpc3RfZGVsKCZwYWdlLT5saXN0KTsNCj4gLQkJc2d4X2VwY19w
YWdlX3Jlc2V0X3N0YXRlKHBhZ2UpOw0KPiArCWlmIChzZ3hfZXBjX3BhZ2VfcmVjbGFpbV9pbl9w
cm9ncmVzcyhwYWdlLT5mbGFncykpIHsNCj4gKwkJc3Bpbl91bmxvY2soJnNneF9nbG9iYWxfbHJ1
LmxvY2spOw0KPiArCQlyZXR1cm4gLUVCVVNZOw0KPiAgCX0NCj4gKw0KPiArCWxpc3RfZGVsKCZw
YWdlLT5saXN0KTsNCj4gKwlzZ3hfZXBjX3BhZ2VfcmVzZXRfc3RhdGUocGFnZSk7DQo+ICAJc3Bp
bl91bmxvY2soJnNneF9nbG9iYWxfbHJ1LmxvY2spOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9zZ3guaCBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvc2d4L3NneC5oDQo+IGluZGV4IDJmYWViNDBiMzQ1Zi4uNzY0Y2VjMjNmNGU1IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9zZ3guaA0KPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3NneC9zZ3guaA0KPiBAQCAtNDAsNiArNDAsOCBAQCBlbnVtIHNneF9lcGNf
cGFnZV9zdGF0ZSB7DQo+ICANCj4gIAkvKiBQYWdlIGlzIGluIHVzZSBhbmQgdHJhY2tlZCBpbiBh
IHJlY2xhaW1hYmxlIExSVSBsaXN0DQo+ICAJICogQmVjb21lcyBOT1RfVFJBQ0tFRCBhZnRlciBz
Z3hfZHJvcF9lcGMoKQ0KPiArCSAqIEJlY29tZXMgUkVDTEFJTV9JTl9QUk9HUkVTUyBpbiBzZ3hf
cmVjbGFpbV9wYWdlcygpIHdoZW4gaWRlbnRpZmllZA0KPiArCSAqIGZvciByZWNsYWltaW5nDQo+
ICAJICovDQo+ICAJU0dYX0VQQ19QQUdFX1JFQ0xBSU1BQkxFID0gMiwNCj4gIA0KPiBAQCAtNTAs
NiArNTIsMTQgQEAgZW51bSBzZ3hfZXBjX3BhZ2Vfc3RhdGUgew0KPiAgCSAqLw0KPiAgCVNHWF9F
UENfUEFHRV9VTlJFQ0xBSU1BQkxFID0gMywNCj4gIA0KPiArCS8qIFBhZ2UgaXMgYmVpbmcgcHJl
cGFyZWQgZm9yIHJlY2xhbWF0aW9uLCB0cmFja2VkIGluIGEgdGVtcG9yYXJ5DQo+ICsJICogaXNv
bGF0ZWQgbGlzdCBieSB0aGUgcmVjbGFpbWVyLg0KPiArCSAqIENoYW5nZXMgaW4gc2d4X3JlY2xh
aW1fcGFnZXMoKSBiYWNrIHRvIFJFQ0xBSU1BQkxFIGlmIHByZXBhcmF0aW9uDQo+ICsJICogZmFp
bHMgZm9yIGFueSByZWFzb24uDQo+ICsJICogQmVjb21lcyBOT1RfVFJBQ0tFRCBpZiByZWNsYWlt
ZWQgc3VjY2Vzc2Z1bGx5IGluIHNneF9yZWNsYWltX3BhZ2VzKCkNCj4gKwkgKiBhbmQgaW1tZWRp
YXRlbHkgc2d4X2ZyZWVfZXBjKCkgaXMgY2FsbGVkIHRvIG1ha2UgaXQgRlJFRS4NCj4gKwkgKi8N
Cg0KRGl0dG8gZm9yICB0aGUgY29tbWVudCBzdHlsZS4NCg0KQW5kIHBsZWFzZSB1c2UgYmxhbmsg
bGluZSB0byBzZXBhcmF0ZSBwYXJhZ3JhcGhzIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkuDQo=
