Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA4C7B0286
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjI0LOt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjI0LOt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 07:14:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA5F3;
        Wed, 27 Sep 2023 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695813288; x=1727349288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R1BUOXwJwbBgTPSzU+BHfR9CdgMeTZcHK5ZJUICJptk=;
  b=d4IsCW33IHEsXM1T0oplCPbaKpL92w5/oUMouvkcC+j6CkSMGv7tuyRH
   v9vpqS/2TwPUix4BLocASLzHIbu1hojry54nt+F6CN/pUbGlVOsXW5FB0
   e22f9b1lg5DwBEoug88rCBFMWmmt97IP+TUy5QlDHh6OL8I/KlY042FNL
   cHh2K2hs0fGkj0Eyr7RMEWJx9iwKtuLd3CLRjf96fS0PriBi5j+hhp9dI
   TuY2XPcY24OqsACc6c28UwY2epVA4l38vjvtr9g4Yo11cAyEdCxwTx13A
   FeDbyRWf99QtOtPBTpSg8eUyEVG6S8QZXxhEg7h+1enH705Fi++kmtBX8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380670571"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="380670571"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 04:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752537787"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752537787"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 04:14:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 04:14:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 04:14:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 04:14:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 04:14:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H73hFQRMJXpkgPnHfKfJ9EuBm3eP1YuSswPKtIt4n6JGGrpLAqoUtka7IhUZ6jCLjq5F81Y9ojRxNDriU8IC2e7tRaPtL5M/uDd7vxUwz5ZTPg4VlMXFyHi0JnocY66v9Gwx3S0oeV7oF/fj2J7vuujohUt4nxKEfbkbYNOqGwRrAinBdzgt/eOfIYU3AuccJoZz8xJHw2qmgRhTy7Q8VjdM/plOKF1KWZ77aeQgIBUeE8IzDHUEPGBi75GotVk8JlhEyS+B3yPUlrW3ODGZ2WXsYdpGpIwqXD6tgy5r89yJDRzhVpWW07FsuMgLZzW4xVD5pjmwLX2k9xhzTXGx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1BUOXwJwbBgTPSzU+BHfR9CdgMeTZcHK5ZJUICJptk=;
 b=dU4ZNPo8KY8gJyNlSeCSU7FnqWjZu9axu/ahYIbnQljcGobpZTLAkMblkZRtEmHpq2kqC40HUpLuU0bkMek0SjmP1iChJ9+tViK+a8NliOiZGAplH6IXVBgXjD0C1YoJjdQ+42btIWEWYXEUvak6wP8e/b6NrzeL9zpcSY7t0WCzRqC4QhYBXiAXKGNkONAA5BTl81JMqqBOnxLGZ1wYoXmwfHCWk3830m1guSGLoAtMXpC0RiP71tfZrhHbB6QDIXlDm2131Mey/P1kl7J4MCVuNSf3K5tYsmAPUQBsj5iY0iBdJ393tHrpaxfJD1+9zdBogCl0yPrGrpFJzseLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 11:14:20 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 11:14:20 +0000
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
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Topic: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Index: AQHZ7cscCwFKzsfMlUe7K1500sBqu7Aui+oA
Date:   Wed, 27 Sep 2023 11:14:20 +0000
Message-ID: <46fecb95ae2c4cd156ad7bda99522214fcfe5774.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-10-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-10-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5615:EE_
x-ms-office365-filtering-correlation-id: 3b293937-a2b4-4304-9b4d-08dbbf4ae56d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BA8CbZCYnaGao72h1vLIm7myFyd52kVQJbom777pfBDQ5XWJRgRtj9zs8s83L5UMQa3RA7NT53d77yyBIU8X1ENH5kSMgv1cJRq5BoEhjCR3GFulWodGAe3angpplFz3k3STLGQiTS4NaR5wG+i1UYmj6XM8Eaf1t7JhzJDzOMUdIonbD6VBTKu09uoQzJ3MllsPac7fGa8Dw3hDygRfLdg36aAsx+RoTNUInqrALRZ3lHEwYpji5dAJm1T2FFGMdwZHxPFYvk3kzDyj7SUy+TDMQWnaSPpCaxbEYfzeyY4HWQmuDt4aqnqAD7cxlDjNOcplxg05lrdIrXYPspZ18sPkerAD7QggMrT97jXDPAgZFWQEVEu136H1OW2Q9MH6MIvkCYvP1O+i3jffFoaHbllRE2AIAg6TjuiUPV8W8qirJPvmxGjT9dC9fK1F9OgymrWjjtIH+wsULXYi/BTWclKRM6NLeIYkhkSCxd+2//sDbZkFP6/L6bV8IxRhMOJCz05j931/7ZlFyEa1ukx7R+q5gJM/QFQldfzEWwTtfikYLSaPXCbiWMNE7RLREjMfJ+zRrLx06a1ylv7dy+C4Xx3kzgo7blpp60KeFh26ljjNYMDkEhZe1TAZ8LT+CaMVFdVEU693NZAhG3bbfLMmsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(5660300002)(316002)(8936002)(4326008)(41300700001)(8676002)(110136005)(91956017)(66476007)(54906003)(66446008)(64756008)(66556008)(7416002)(76116006)(66946007)(2906002)(6506007)(6512007)(2616005)(71200400001)(36756003)(6486002)(478600001)(921005)(38070700005)(26005)(82960400001)(86362001)(38100700002)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWhIeU5JY2ZWc0swMXFzekgwQnZzdC91UlExMHBkTHR3K3U1eHpUNlpmaWFP?=
 =?utf-8?B?TWt6RzNHL0xpQlB6N0FSa21zMFQ4dk1ZVWRXYkJ2M0drUy9RZXlld1ZNRUlO?=
 =?utf-8?B?TFM0NjRXcHB4SWhZZVEycHh6WHhlc21TZUo5aHZDamtOSEt1Um9iUDBDKzF2?=
 =?utf-8?B?cWs2cjhKWTdZQkd2U0s2c0RZU1ZrNlFnMmlMYTJ6T2RQUWREQkNGTk0ycXpG?=
 =?utf-8?B?elNCWi9kbDJtc1NSYzdRZis5OENTc083Q2hhajV4L0dCaU5rQ0RZU045RUVy?=
 =?utf-8?B?a2Y3SGxzTjlXd3ZnMHFmWVhCT01rK05KVDVMQnBUejQvZDRQMW9acE4ya1lN?=
 =?utf-8?B?M1FVT29ITUNtN0dpV3ZYaHhQTzNBMWhoNUJYREx2ME42NVI0alhZL2JCM3FY?=
 =?utf-8?B?dzRYUHpJNU95NXFNdytBWFBaSmVXdkJpTTZKZHpMSGdvRi9WYXV2UklHaEIy?=
 =?utf-8?B?V3RnektibHlxelRCSkhKREUwazhtREl1c0h3MWFXZW1vQnJHV3FZSmpyTnlE?=
 =?utf-8?B?VDhBekVHSE1HM3ArUTZhTjQ1N09BR2N6MktsSWNNenFuNzZXOXNKWG51QW52?=
 =?utf-8?B?RFppc0E0UG5INUJvbFlrUC9pT2h5WHFBYmNjN2h0L2xldElCTHVrQS9BRXlN?=
 =?utf-8?B?eWg3ZDNwOWo5UzhtYWtVcm5MdjlJakRSOGFlT3lJalpoMjlYMGFMaTRScGEr?=
 =?utf-8?B?UEV3RDhET08wTmRNUmZFM0VrZjNoUGRKRTZSajZva0I5cnV2NWlGVFQ3K012?=
 =?utf-8?B?N1lFQ0JDYmRyKy9PTVNicXU0VEhnMVlMSHlvZGp1TWZha1lDQUtjWXVIQTM4?=
 =?utf-8?B?dDRjdUR4bnpLOFhxOW8vZkI2STI2UmlCRFpNUllrRHZJTzZYNm96cGR5Zkpv?=
 =?utf-8?B?MldvY0VPcXJuSk4wbnFuL05SYUJNMjdrQ3BPenB3UFc3aGMvN2EzejFkbHBx?=
 =?utf-8?B?cTM4QVNzK0M3VE9udDlWendGTzVVMEh1VjdYQTJRaGdkR01BNlFHSFJQaTF4?=
 =?utf-8?B?ZGExaE5iTGloMkZ2cUR6YytuRjhrdkl0aElUbjZ6djU3RFhVV1E2Zi9xcXp6?=
 =?utf-8?B?ZTh1VWgrRGNhSVN0YVZRRGhrVFZ3L0cvZEZCQlBCZ2RiaUNjbW4ycllYSHc4?=
 =?utf-8?B?VVV2TzhxWmRnT0RyTUhKYm9BSm54TmJ2RmdzRVNxWmxuZUdWTFhrdGozd3pJ?=
 =?utf-8?B?M0lZM2ZrNXdQblliMldkSFZwdWVJVkttZDFQVE5sdkJoZjNoWFBoREF4MmJX?=
 =?utf-8?B?S2hqQTRNNW85UGdONk9oeU1oSHUvR2FMMzZJVXZkdEV6dFJzTm84S1Jka2pR?=
 =?utf-8?B?MlFLRlJtVWp5T1d0TmljSU1NOUhFQnR6UWhIL1BrQkc1KzFKMmJQN05rVEx0?=
 =?utf-8?B?bkl6bHh2S1JWUThLZTF2STlRREZHdG1lQjVQdzB5bGwyRlhPR1BvNzcwSUl3?=
 =?utf-8?B?cUtla0Vnc2d3MS9pb0QxY3VQRUgzZ0JhNjlsQzVNK1RmK2N1QlVaY0hvMWp5?=
 =?utf-8?B?N3g0Yk9WSGZHZ3d5a0toVUQzdWprVGp6RXJ4M0JXeUxkeXNML1RsTVpLbmFX?=
 =?utf-8?B?R0o2SUFlQ3FycjgyNno5cklVMzJwak4yZzlyMWpwYU1JRGFnVWp6RzJoU2gy?=
 =?utf-8?B?TCtFZyt6YVJoMTQrK2VkTmp2K21hd1VoZk5xZ3JBL3kvR1EweGYvMHd5dWNG?=
 =?utf-8?B?N1FjbzFJbit6d0tuL0V1NHNMcDZVeEJFNWwyaVdPS0IrUFJrWWFmcml5VUYw?=
 =?utf-8?B?c3RhbGVONTBoZTk3STJGdXpJbUYraDJiOG5zOXhiWmNOVEN5NHBncmtqZ1Zk?=
 =?utf-8?B?RjN6a1RIeU1Lbmdqa3YyVWVESytVR2RvK21iRGZDTVF3c0lCYno4L1NEelRy?=
 =?utf-8?B?Uzhza2F0YTR1ZFlKaUdsZ1VvUnE0WXdlMkoybEpiREJHenZuRElPVkw4RWc4?=
 =?utf-8?B?VnFQenFNVnNBNUNsa3EvOWlHV3hkRzhlWlBGV2szbUVQVkJaVnJROERQeHB0?=
 =?utf-8?B?WnRaa3c2K1lPUFhPb1luN240VGNMRlNNV0oxUDA1MjV4cFU3R2dmSWRjcmk3?=
 =?utf-8?B?M3JkMFlWdWV5NzRFWXh6Nmp5N3pMQzFtdzdRb3dVaFI3cGxLZzNoQkh2NmhW?=
 =?utf-8?B?VTdYc1FrNDVSMUU5Zy8zZk1oUnAyWis1azczYnZmYUFUaUpkMlFFMUlUaEs2?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CEE23F646E3CD4592E0C529E743BFE4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b293937-a2b4-4304-9b4d-08dbbf4ae56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 11:14:20.0703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJcmJp35ULDQSTQTXBRP7rNEe6NAP+Vy0SGdDwYMH5ruLdmkg23/Sg+1bS8u8aKYQRONjGi5jqUc3sYqlYF2vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBJbiBhIGxhdGVyIHBhdGNoLCB3aGVuIGEgY2dyb3VwIGhhcyBleGNlZWRlZCB0
aGUgbWF4IGNhcGFjaXR5IGZvciBFUEMNCj4gcGFnZXMsIGl0IG1heSBuZWVkIHRvIGlkZW50aWZ5
IGFuZCBPT00ga2lsbCBhIGxlc3MgYWN0aXZlIGVuY2xhdmUgdG8NCj4gbWFrZSByb29tIGZvciBv
dGhlciBlbmNsYXZlcyB3aXRoaW4gdGhlIHNhbWUgZ3JvdXAuIFN1Y2ggYSB2aWN0aW0NCj4gZW5j
bGF2ZSB3b3VsZCBoYXZlIG5vIGFjdGl2ZSBwYWdlcyBvdGhlciB0aGFuIHRoZSB1bnJlY2xhaW1h
YmxlIFZlcnNpb24NCj4gQXJyYXkgKFZBKSBhbmQgU0VDUyBwYWdlcy4gIFRoZXJlZm9yZSwgdGhl
IGNncm91cCBuZWVkcyBleGFtaW5lIGl0cw0KPiB1bnJlY2xhaW1hYmxlIHBhZ2UgbGlzdCwgYW5k
IGZpbmRpbmcgYW4gZW5jbGF2ZSBnaXZlbiBhIFNFQ1MgcGFnZSBvciBhDQo+IFZBIHBhZ2UuIFRo
aXMgd2lsbCByZXF1aXJlIGEgYmFja3BvaW50ZXIgZnJvbSBhIHBhZ2UgdG8gYW4gZW5jbGF2ZSwN
Cj4gd2hpY2ggaXMgbm90IGF2YWlsYWJsZSBmb3IgVkEgcGFnZXMuDQo+IA0KPiBCZWNhdXNlIHN0
cnVjdCBzZ3hfZXBjX3BhZ2UgaW5zdGFuY2VzIG9mIFZBIHBhZ2VzIGFyZSBub3Qgb3duZWQgYnkg
YW4NCj4gc2d4X2VuY2xfcGFnZSBpbnN0YW5jZSwgbWFyayB0aGVpciBvd25lciBhcyBzZ3hfZW5j
bDogcGFzcyB0aGUgc3RydWN0DQo+IHNneF9lbmNsIG9mIHRoZSBlbmNsYXZlIGFsbG9jYXRpbmcg
dGhlIFZBIHBhZ2UgdG8gc2d4X2FsbG9jX2VwY19wYWdlKCksDQo+IHdoaWNoIHdpbGwgc3RvcmUg
dGhpcyB2YWx1ZSBpbiB0aGUgb3duZXIgZmllbGQgb2YgdGhlIHN0cnVjdA0KPiBzZ3hfZXBjX3Bh
Z2UuICBJbiBhIGxhdGVyIHBhdGNoLCBWQSBwYWdlcyB3aWxsIGJlIHBsYWNlZCBpbiBhbg0KPiB1
bnJlY2xhaW1hYmxlIHF1ZXVlIHRoYXQgY2FuIGJlIGV4YW1pbmVkIGJ5IHRoZSBjZ3JvdXAgdG8g
c2VsZWN0IHRoZSBPT00NCj4ga2lsbGVkIGVuY2xhdmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
ZWFuIENocmlzdG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiBD
by1kZXZlbG9wZWQtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS3Jpc3RlbiBDYXJsc29uIEFjY2FyZGkgPGtyaXN0
ZW5AbGludXguaW50ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEhhaXRhbyBIdWFuZyA8aGFp
dGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFpdGFvIEh1YW5n
IDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiBDYzogU2VhbiBDaHJpc3RvcGhlcnNv
biA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KDQpbLi4uXQ0KDQo+IEBAIC01NjIsNyArNTYyLDcg
QEAgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4X2FsbG9jX2VwY19wYWdlKHZvaWQgKm93bmVyLCBi
b29sIHJlY2xhaW0pDQo+ICAJZm9yICggOyA7ICkgew0KPiAgCQlwYWdlID0gX19zZ3hfYWxsb2Nf
ZXBjX3BhZ2UoKTsNCj4gIAkJaWYgKCFJU19FUlIocGFnZSkpIHsNCj4gLQkJCXBhZ2UtPm93bmVy
ID0gb3duZXI7DQo+ICsJCQlwYWdlLT5lbmNsX3BhZ2UgPSBvd25lcjsNCg0KTG9va3MgdXNpbmcg
J2VuY2xfcGFnZScgaXMgYXJiaXRyYXJ5Lg0KDQpBbHNvIGFjdHVhbGx5IGZvciB2aXJ0dWFsIEVQ
QyBwYWdlIHRoZSBvd25lciBpcyBzZXQgdG8gdGhlICdzZ3hfdmVwYycgaW5zdGFuY2UuDQoNCj4g
IAkJCWJyZWFrOw0KPiAgCQl9DQo+ICANCj4gQEAgLTYwNyw3ICs2MDcsNyBAQCB2b2lkIHNneF9m
cmVlX2VwY19wYWdlKHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKnBhZ2UpDQo+ICANCj4gIAlzcGluX2xv
Y2soJm5vZGUtPmxvY2spOw0KPiAgDQo+IC0JcGFnZS0+b3duZXIgPSBOVUxMOw0KPiArCXBhZ2Ut
PmVuY2xfcGFnZSA9IE5VTEw7DQoNCkRpdHRvLg0KDQo+ICAJaWYgKHBhZ2UtPnBvaXNvbikNCj4g
IAkJbGlzdF9hZGQoJnBhZ2UtPmxpc3QsICZub2RlLT5zZ3hfcG9pc29uX3BhZ2VfbGlzdCk7DQo+
ICAJZWxzZQ0KPiBAQCAtNjQyLDcgKzY0Miw3IEBAIHN0YXRpYyBib29sIF9faW5pdCBzZ3hfc2V0
dXBfZXBjX3NlY3Rpb24odTY0IHBoeXNfYWRkciwgdTY0IHNpemUsDQo+ICAJZm9yIChpID0gMDsg
aSA8IG5yX3BhZ2VzOyBpKyspIHsNCj4gIAkJc2VjdGlvbi0+cGFnZXNbaV0uc2VjdGlvbiA9IGlu
ZGV4Ow0KPiAgCQlzZWN0aW9uLT5wYWdlc1tpXS5mbGFncyA9IDA7DQo+IC0JCXNlY3Rpb24tPnBh
Z2VzW2ldLm93bmVyID0gTlVMTDsNCj4gKwkJc2VjdGlvbi0+cGFnZXNbaV0uZW5jbF9wYWdlID0g
TlVMTDsNCj4gIAkJc2VjdGlvbi0+cGFnZXNbaV0ucG9pc29uID0gMDsNCj4gIAkJbGlzdF9hZGRf
dGFpbCgmc2VjdGlvbi0+cGFnZXNbaV0ubGlzdCwgJnNneF9kaXJ0eV9wYWdlX2xpc3QpOw0KPiAg
CX0NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oIGIvYXJjaC94
ODYva2VybmVsL2NwdS9zZ3gvc2d4LmgNCj4gaW5kZXggNzY0Y2VjMjNmNGU1Li41MTEwZGQ0MzNi
ODAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oDQo+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oDQo+IEBAIC02OCw3ICs2OCwxMiBAQCBzdHJ1
Y3Qgc2d4X2VwY19wYWdlIHsNCj4gIAl1bnNpZ25lZCBpbnQgc2VjdGlvbjsNCj4gIAl1MTYgZmxh
Z3M7DQo+ICAJdTE2IHBvaXNvbjsNCj4gLQlzdHJ1Y3Qgc2d4X2VuY2xfcGFnZSAqb3duZXI7DQo+
ICsNCj4gKwkvKiBQb3NzaWJsZSBvd25lciB0eXBlcyAqLw0KPiArCXVuaW9uIHsNCj4gKwkJc3Ry
dWN0IHNneF9lbmNsX3BhZ2UgKmVuY2xfcGFnZTsNCj4gKwkJc3RydWN0IHNneF9lbmNsICplbmNs
Ow0KPiArCX07DQoNClNhZGx5IGZvciB2aXJ0dWFsIEVQQyBwYWdlIHRoZSBvd25lciBpcyBzZXQg
dG8gdGhlICdzZ3hfdmVwYycgaW5zdGFuY2UgaXQNCmJlbG9uZ3MgdG8uDQoNCkdpdmVuIGhvdyBz
Z3hfe2FsbG9jfGZyZWV9X2VwY19wYWdlKCkgYXJiaXRyYXJpbHkgdXNlcyBlbmNsX3BhZ2UsIHBl
cmhhcHMgd2UNCnNob3VsZCBkbyBiZWxvdz8NCg0KCXVuaW9uIHsNCgkJc3RydWN0IHNneF9lbmNs
X3BhZ2UgKmVuY2xfcGFnZTsNCgkJc3RydWN0IHNneF9lbmNsICplbmNsOw0KCQlzdHJ1Y3Qgc2d4
X3ZlcGMgKnZlcGM7DQoJCXZvaWQgKm93bmVyOw0KCX07DQoNCkFuZCBpbiBzZ3hfe2FsbG9jfGZy
ZWV9X2VwY19wYWdlKCkgd2UgY2FuIHVzZSAnb3duZXInIGluc3RlYWQuDQoNCg0KDQo=
