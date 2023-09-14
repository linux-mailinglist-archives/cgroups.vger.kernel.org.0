Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38B7A1039
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 00:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjINWAF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINWAE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 18:00:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA711BFA;
        Thu, 14 Sep 2023 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694728800; x=1726264800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LOuMN8tvenUpesB4CO60gSHHSVAvvLc4YgSsri/qM34=;
  b=GEv/ywbYCzbiy90gAqJgSeeyC27wsONt7lflzCk5uVFl35FwcDm4fZSk
   2iY9Nzy/IZSwtZoVQbkUL0c+ALVPWZhbGF8OOXxaC2WroWHZziU2S/ag6
   xCBUm3i8s9lQtHyw8Rc5z+E1gBPdFWOdgQ2akdvpSGvVYIpLr6nqATMwn
   wDZZf0WSrVHs8x099BZRppBmMBgNpfOVsBUbbwkXKoonSiv4AiPxqcPmD
   t4bmSSKvFf2mS4EPiQtoWUu/mRC7RPc8wTmjurNpqKUl+367l14ypBcDo
   AyMpZtvqpq45JhlqnBDLuhdjLbJnv8oYVQTrIfRnxFAedOIncS9mRWHq/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443134928"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="443134928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 14:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774045843"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="774045843"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 14:58:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 14:58:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 14:58:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 14:58:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 14:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6+kXAs73MXNZ12CdJwDJjXPZTf89OqKMruZT9SNxIdhTKxEfrtlUSsqriubA4NyySArGl99V32cJRg2YV40OzxHlIjnwhsKatbmtuPPp/aRkrKbrXLqNiXYT4ky3QxwYQJ1udZ43O3MTU3CU7gsYndWOaX+6Gy9XDfWvkQP5sDfUHM/Fx12iLTL9q8BHWxe3wH0FFcMnERDzy5/uYJsO/UFYsWF+8alRtG7/SLWvSDoEOhD0BQhq/zUwyJg8x309vpEYkSU+6fg6KK64pkD1Zup6tniXAJVo7YLcUCnYBe2H1f4r79Il0Ed6nwy/zukVH7YzAetnM19674wm3LSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOuMN8tvenUpesB4CO60gSHHSVAvvLc4YgSsri/qM34=;
 b=NGqTWiDwI5ocS5HgtuNY+DJVG2j94fRaPuAoAdzp3NXaGUen4R4tcpwoJ6AhiUZo3VB7uMI/b2+95+d8mLHGLfElix8SkWOBKk60P2byMiCPlpfMRpCByEjXyn5z8Q946PyuD2v92PSXgCNo0R5EiT3IRUekUd4mWu1H2jEHmBKFxyJ02Rac8u3xCWQHyTZxg4x4pglp3vvf1tRC2A79joTgkWn70waiNhL1tEVQxo87DG3GnlhllDUN9gnIHRnLqvLQd5SahAe0ZwLMG5D0OtbqBekpTq4AdnIP4VK5ShAz/pKCHOdjuzrk8XPT7A05/JxWOsZ9nUps8v6EdicWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 21:58:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 21:58:19 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhang, Bo" <zhanb@microsoft.com>
Subject: Re: [PATCH v4 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate
 LRU lists
Thread-Topic: [PATCH v4 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate
 LRU lists
Thread-Index: AQHZ5fiVZxBqcFwEwk2nCHykoP0dm7AaIUsAgABffICAAGBoAA==
Date:   Thu, 14 Sep 2023 21:58:18 +0000
Message-ID: <df65414f2bb7a1a791ff8d7864640e34e52a8ef2.camel@intel.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
         <20230913040635.28815-4-haitao.huang@linux.intel.com>
         <851f9b3043732c17cd8f86a77ccee0b7c6caa22f.camel@intel.com>
         <7c418047-dd0b-76e9-dcfd-f00c76eeae46@intel.com>
In-Reply-To: <7c418047-dd0b-76e9-dcfd-f00c76eeae46@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN0PR11MB5964:EE_
x-ms-office365-filtering-correlation-id: 1d2eac85-b35f-4929-6420-08dbb56db48a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5VpmPyOdPbjweRUJNWAh1Vx73yu721XFE+R2AgyY3EiJaAOvV9Mnw/rEB30TBg2ZrttyVTZuaFlZXagsH5hHDio0uZRs7Imz2+9f+cD1duF23THrOHIdecrN8O3ZUZltnvYsnsLQiu+a0p5HVaBTwjCktL5TGIV0/iTvroPhoAGCJc1Xe7gUJBloq8KdtDc3OKIBBG3D+KblCMj5ZhU1GXcCT/N8ry94Yl9FneZB+gggff2qmFjCnVVTyM4RKknIDtM1ZalpFd8FadMJTtNisBsvSjoGf4ANcB3HcT2otyXg2tkEPoQJR/a7xYL8H/AHZ3r9kKy0JUR07mkdtKnqYt3MpRofEK76byOIaDvgbPyyhuZzuHZF0T6y1dKPf589O8Ol6eIgv5nFfhphOEnnMZVXGpa3dm5iyVgG0lUKjRclAzgrwAA71OmNVpeNheD6AQUWFyuBNbjY9IUkHQ+DuH95dknmNdRxhWdJG9m2JxOXJ7vGdxd6FLR5IFTExQ8DWJPEFSQRrE3rnzcU7NgCyxHG445hXZCadD/m4RiFPfgwIsrAlbANcKf427RmO/Zehsb1knbXyZE3OptrBq35jfh2GkHEvcpf75lhaHKM8YvnptTYWMPWBjPlhK6rdlG47jpyThzVfEWA421cVa7/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(110136005)(4326008)(921005)(122000001)(6486002)(6506007)(71200400001)(66446008)(36756003)(86362001)(38070700005)(38100700002)(83380400001)(82960400001)(2616005)(41300700001)(26005)(4744005)(5660300002)(6512007)(66946007)(478600001)(53546011)(8676002)(2906002)(64756008)(91956017)(8936002)(316002)(7416002)(66476007)(66556008)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlVCMDZqdEN6ajNsMytiWjFxNXdCSnVmV0wydkVJY2trME1OMVNRTnk3Z3Nn?=
 =?utf-8?B?c05GblVYbnJLajkyZng3TytkZ1NSMzhXWUpwU0RHUXZ4T1h2NENaNlhuZXBL?=
 =?utf-8?B?VE9QRUtzTldJdEhteWZnOWMwR1ZMclArVFFFSFpldG1tMTdSckpleXhIbksz?=
 =?utf-8?B?SDY3cEFsWmxGdHQ4eUsvY04xRGVOdnF0WkJlOGUzWTdhbENuZEdwdjJlWWVC?=
 =?utf-8?B?dGlEMExFZFpBejdnU3FNZEpYMStOQkgrdGFLQnRKVVlWNTBPV3lSU1F0NGpK?=
 =?utf-8?B?OWpmUEU0QlNMQTNIeUtaVHZSMzVpalRzelVBeG5JZU9jNERVTy9ZZEVXR2tW?=
 =?utf-8?B?aG85K25laDJlWElGK1c0MTQ4QThSTFB1SVhRQkRYL2NjeFA1am5rOXp5d2Rm?=
 =?utf-8?B?eTJWZURHUlptdk9KbnBGWDZRc2kzeC91OFlqRFQ3Z0ZNa1kwOGxRdG1TY1NZ?=
 =?utf-8?B?L244OXkwUFJDVTFTSTNrWnNVU0RVTlNjemU0SzBmVUJoUFprSy9zdXlzWUdo?=
 =?utf-8?B?U3pVNWppZno3TE9nRDhUSUlQQUJpcEhMNlBmdUs5dkh2L3krcU83elJJZEF6?=
 =?utf-8?B?ZVRkd1BoZWk1NzVtZUVCUHZoNUZicURJQmxhemJPSFhXczYxZXp5V01leG45?=
 =?utf-8?B?NktubERMWU5UOW1BZU9ldG9CVm9ZZXd3d09uMDNxblhEZ3lUL3FGYVNWbzVZ?=
 =?utf-8?B?ZjNqejk4bloxL1pZeENLd0xsLzhQMnZMSkc4RXZJdWR5eUdKTjdmNEJ6Syt4?=
 =?utf-8?B?R3JsTVBPZGFPZ2hkUW9WUkZyWmF3eTZMYUQ2NDNpcHgvZk1VUjMrc1JWdVl4?=
 =?utf-8?B?cEFHVHczYllpSkk2UXlFcjIva1dCWGxVemtOOGJaeng2QmdhN1ZBN2tKT2NS?=
 =?utf-8?B?dEcybDc2NnZZUUo0c1VOdHlOTGZGTFYrSXUvSndYeGZCTTRhM0Y3MzRONDlF?=
 =?utf-8?B?ZmlnQnA2Z2dYRlJ3ZC8zSVRJVDVXNkhZZzhzdUo0YndIelJkYmE3d2xyOTFC?=
 =?utf-8?B?WnFoazNRazlhNzJCbWJHc09JbFVVN0UvUHpCSk5XaVRJM3M4aW5iaEd3Y3Yw?=
 =?utf-8?B?ZS9LVWt0c1VBbWJObzNnZkFxTC9ldlI1NGpxcTZBMXNxeHhzNXNHYU80dUdF?=
 =?utf-8?B?dGZXQ1lkT3MwSWpjbTlhc3NTTkxjb3g4UkNPU1JLcUhrcHQwQXZrNEEvTGg2?=
 =?utf-8?B?aVltZExOVXlYZWpnRnpoU214TE5hZUJ5OER5STkxaUZxSmpKK2l3MS9RZjAx?=
 =?utf-8?B?Um5mWkF5VFRTR0h4UFZVMkJwQ3FvMmdtK01PWXVkQU04eUVlbitEL0ttQUlB?=
 =?utf-8?B?UHV0eDgvSlIxMnN2ZzZHblpUR0M2K2xXeS9VUU5IS2lIT2wzcGw2dFhmMG1o?=
 =?utf-8?B?cTREZ2lray9YOFpXa3VINkE2QkJpWlZLVVJXMmZtZ0l1WUlydzMzT25yb0dB?=
 =?utf-8?B?YWhqTDZCSmJreW53VTJTQ0RWenVsNGhDSnRXaHpjVHBGeWtXR0xZakdxRVA1?=
 =?utf-8?B?YlRMTCtWaHRCK1RwZXYveExOek51RXNZWE9CZmRYN1pFb0RuM1Vad1Ivc3FQ?=
 =?utf-8?B?clJqMERBZnNSZ1YxMGowQllGcEZ3SDlseG9odUFjQVdIaWpEYmVrQkNselZn?=
 =?utf-8?B?THNwTUZhQ0tvaEFnV0lMN0FqSmQ3ZFh2NG44NXdTayswUEJDSnpvcFVORm9p?=
 =?utf-8?B?RlVKMDJSVXR3NVpnWm9FU0dHdnY5cHlVNVd3TnViMk9EU1hBU0lYM25WVFow?=
 =?utf-8?B?SHVyUzFQWmQwVXBGTEVTV1E5WC93Qmtwdzk0M2ZwbHY0YlBOTkZZWmhrUDFK?=
 =?utf-8?B?Z25WSmt5SGM2aUZ3MXJDVkdmelZzT1J5OStzOGxUMVZxcmplV09qaEhkQjVT?=
 =?utf-8?B?QzRPYnN6UXJ2aGY4ZTBhcWxuZjN6Vk9YY1dhRG42UE9rdFhHMXdvb1doeDN3?=
 =?utf-8?B?WnUzSzE4bWZOTXlPTVNha0ZwS2d3MFU3UldqQnJUd0VKSmVOb29GTnVFQkpW?=
 =?utf-8?B?Q3RhQWVPU3BSellqTGtHSjl3RjFRODVWdXNCVm55VEx3M1NoZWNERXZLY2R5?=
 =?utf-8?B?ekYwdGVzSEw4WEMxZHZkMmRPalpxcUxQTWVtT0gxNlJWWkx2cVlVa05mQ0t1?=
 =?utf-8?B?VEtIbHVaNElkWWQ2TXF1QUZrWXBCYU5sb2h0QXZ0RHYrdHE4bkx5ZWtiaElL?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B483E859C0629F4286D87420B111C526@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2eac85-b35f-4929-6420-08dbb56db48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 21:58:18.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qENJmD1Odat8kVbbX4dmevGwdBjanSiPms3r6VOSJ/TpN3bEPr59VE7lPaeKJwHCLhHJETu103ekIDVae9yH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDA5OjEzIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8xNC8yMyAwMzozMSwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IENjOiBT
ZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gPiBZb3UgZG9uJ3QgbmVl
ZCAnQ2M6JyBTZWFuIGlmIHRoZSBwYXRjaCBoYXMgU2VhbidzIFNvQi4NCj4gDQo+IEl0IGlzIGEg
U29CIGZvciBTZWFuJ3MgQGludGVsIGFkZHJlc3MgYW5kIGNjJ3MgaGlzIEBnb29nbGUgYWRkcmVz
cy4NCj4gDQo+IEl0IGlzIGZpbmUuDQoNCk9vcHMgSSBkaWRuJ3Qgbm90aWNlIHRoZSBlbWFpbCBk
aWZmZXJlbmNlLiAgVGhhbmtzIGZvciBwb2ludGluZyBvdXQhDQo=
