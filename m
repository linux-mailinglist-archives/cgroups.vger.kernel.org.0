Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7867BAB82
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjJEUiq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJEUip (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 16:38:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E595;
        Thu,  5 Oct 2023 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696538324; x=1728074324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A4XSxEO51p+KPp9DlceEYZf/c/74RAQzk6FawNcW8m4=;
  b=Zdv4mXFZGSbQycNo4gtdLZHK5/iv4NqQ7aUe8YX6frAjqFP+8XjEOQBL
   Myno8GkOIL4jMYPImZkhtqk49+DaJQpaCSHrkCQBtuZxcZpO66LGvDgK+
   smW6P4ESoNX9LXHWJpa4VafLC/c/fVfcUvVR7poWDc4Z0DNlR6ZGtE9IU
   R+p6J8T8dd6AcuiUMo2xVvjEERaBtzq1ZL+oWz28ViJ3dQDVNc74kbbYL
   t9nspzKOqCSJpNaZn09rWAOqc9uVycSUkGsSAlIM+d1lvcAgYJ/klnDlb
   RB5Dk5SDmpx10qEpxwZLisl6CzRIEs+sivNg132Oo9eITiZ9n4ur1DhPp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368688504"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368688504"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 13:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083165702"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083165702"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 13:38:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 13:38:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 13:38:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 13:38:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 13:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsJuRk3blNfgGhG4gcS5XMIGO03dQ78Dd8RV0GjGQcdRzAa0ahoeqtDALBLIL5YmAufGwqB7g2UoNHwfayRQbE04NYdp/YMH7l7t9+5QValtkYHXqkmZvLiuysaptF5R6HRAV2FzK6ivVu55qSdUiihE/8FRpwt5s5jbvqdYJAE17RVTiWES/6BRvnA0MON+w7BoraE6o1H3lTigVuP20307igMtG3yagbtWs42nX1jhqPw+OVN0Nrq+rO0O4hPEzsQrQaCRK+QVmKmA5LMEkXDZyec4OaGFp/bTZfUc6nbFTKsCFR2EJNjqYM39BddAHRS1ySutnM90VOHMjfbfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4XSxEO51p+KPp9DlceEYZf/c/74RAQzk6FawNcW8m4=;
 b=Anr2iBqsUcXIqEfk0ev/KOsR8HK8je1E4t+JT8ujhSYQJGQAUQNQu/SQbBkINM1EnvZ/4Y7Tf/NUd8g7pE6jWdeoPtiwfK/AFAEdVzC+vF7KgiffAz0RQpcOhCDwhQj7TqBN9lcnKZu90YaN2MEDki0jvvKfwbkPGfgeVa/++/pSujHGlriPVAqncsSwWauKjRpO5moWwSsmFjz82CoPQ8hXxVgdnrdBjJT1rUy2utyBvbqsKRlR+0V3KaZFxIa2XPu68VNcHK2o+TXjma7gn3r8qQgp278cIJjIYiJC+D7vRhq0J/is6n96dVzgwRWbIL+EmUbGsBZHNcVKXi+Zaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8211.namprd11.prod.outlook.com (2603:10b6:610:15f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 20:38:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 20:38:34 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
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
        "Mehta, Sohil" <sohil.mehta@intel.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhang, Bo" <zhanb@microsoft.com>
Subject: Re: [PATCH v5 15/18] x86/sgx: Prepare for multiple LRUs
Thread-Topic: [PATCH v5 15/18] x86/sgx: Prepare for multiple LRUs
Thread-Index: AQHZ7cskH0aU/ns4bkS7BrOr4Ie+NLA7M+4AgAB2KACAABIiAA==
Date:   Thu, 5 Oct 2023 20:38:34 +0000
Message-ID: <804bf873c7b838dc06929708b3b675784cbd8fc5.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-16-haitao.huang@linux.intel.com>
         <6f71642624812da126b900e94e76a72166d9aecd.camel@intel.com>
         <op.2ccwmcljwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2ccwmcljwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8211:EE_
x-ms-office365-filtering-correlation-id: 25d803a4-51f1-4c20-789c-08dbc5e30b93
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73wEj0p1QdhR5qq/N8e/UbM6NQw3DAs97A0RLy0KsYL15TkHzmy55oZDIirbVHnawbTI+IzuY5GKWEYNHl/G7LkkMv7uKx1TKpyTrA1L2JDWAVbXs27/ZEfXElUEICHBnzHbGHBYu6CGQ5sHg6lR/CDZDDjpnW8aqiWPttlFPMFteP9+oXcDtIAQBn46B9EUgWjRpE+VtPwoBPkwt3PrDKeDraDcGLr1Odnxfz+42l3mIx3nZBOGPvZW63wl/i9RkdcClItm43CN9h9qlBzR3vgWQf6OpLrzh64M+nnVC/RB0VzkUcwonIaduu2H5lhVTqKPKWZGgV7lty+mNqYA/9NYvvBQBBinGp3fYhoHqFt3UzSykiIlE/x82eTm9Z5J+UDYs2RxV77ZpHpku4D5Wc7xbZBJTGF1e18vcwj2zw+8W4N2KYG/1ACeIvBj6187QtyihA9n80Ar12pRQoi0jicXQjG0pXD4zD6hh6WgRyjgUafhEC/YE9ceVJbFHMBMhsv0qA/UDHXoVMxIf1jkhrkK7oPClh5onr8gMmNIssB+U8SbQGcohSeM2dd0kMJiDYX+DmMXOmmsPhNdP4hGSs/yMiCa54O83QUoOh4uD0j2S572Sd2X10JiULDLGiXSv/ICBgjLnh2AP5q7D+L/lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(86362001)(82960400001)(38100700002)(38070700005)(921005)(122000001)(478600001)(110136005)(66946007)(6636002)(91956017)(54906003)(7416002)(2906002)(5660300002)(64756008)(66446008)(66556008)(66476007)(36756003)(71200400001)(76116006)(6512007)(6486002)(8676002)(316002)(8936002)(6506007)(4326008)(41300700001)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU9qNWphUjhpRk5ad2VFTWlLVjVPMGpJM05jSkx1ZlA5d1IrZFBaTHFBZWo2?=
 =?utf-8?B?V0xJQmk3OEwzOWYxbU94bFBKRDh6U2Rib2NMTCtFS0w3Rk5BdVk4MitIRUFo?=
 =?utf-8?B?ZVlKb1dJWkpLVjVjOXVoUVJtY0lsaW0zNDBHeUk1Vm1CNVVLVGE0cG9wT3pj?=
 =?utf-8?B?Qk9sQTYvMnkxRDFVcnJrTXRPTElZM3NPNG0xaVY0ZmcxTWp6NG83eENFbzUv?=
 =?utf-8?B?WmZhNTVpVVd4UmhmUjhwam1vM3NDNm8xMVBTcnFmdDBoZmZkT21oVzJnZ0Zi?=
 =?utf-8?B?RGNtZ0pYeU1kQ3hUU3NJU3JOaGpSSEg4QmpnS3dCckZWNWFvTkVGNmNWTHl3?=
 =?utf-8?B?VkgwNXpyVXFkWWRoSmV5RjBwdkw2OG5tOEE4L1Q4NXI4emZHQytsYmtTanE3?=
 =?utf-8?B?L2tpcDlVbFh0aG45RXVxZWlUeEZua2ZaNndaR0M0cTFnVjJ1KzVhbnh2NHpl?=
 =?utf-8?B?Nm5KQWI3TGdZOE5pUDNXTm9YSWFmbFpzWDd2TXY4bkZaUmNmWjJjRXNHa3pt?=
 =?utf-8?B?Zk5RWWZjTU9NckcxbmZ3OTZ1ejdWTUlsbndJN3VHZUJHN2ZPR1c4VlVtckFk?=
 =?utf-8?B?VnlXenBDSjRpako2VElHMEU4QkhSaFU1MzEyaDBDNlBYZ29KMnJIZTE4TkR3?=
 =?utf-8?B?WmlpaDJMeUZOUmxjUUo0OU5KY1Fvd3h0NUhwR0NlMlNiM0hwNUExdi8yaUxV?=
 =?utf-8?B?MFVoOFJadFJ3V2lsUUZNVk5MdDV1c0E1WWhNcjQxelhNUm9FSEZjV3puV0I4?=
 =?utf-8?B?L1F1VnRsalBxdUVyUnpvZkh6ZmFtdkJKNHJJalMzRlZPM2Qra05KbXBKMk44?=
 =?utf-8?B?VmM3ci8xaHYxSENpWUJvRTF2WERGZzU3b0lJTHVjU1krV1FrZ2ZESkIyR0Zs?=
 =?utf-8?B?NmlubVZrQnEyaWJ4SDhRM0xxSUJMdzJldUVYOHNSY2dsMXN5ZUNnbmJPeElT?=
 =?utf-8?B?VVVudm1sVGllWDJVYlRpc2x1eWR6cFF6blQ5VklaZ2NlWHJiMlZlLzdhT2Ft?=
 =?utf-8?B?bFl1eGx0TVkyWUVGZXZOamdVTFRSQ0JHQVJoSk9KNlNhVm55SjBCVjVJUGMy?=
 =?utf-8?B?SFRUb09Xb3lPa3psLzkwR1BIMnJvMFBscDZRTGdkTzJ6UjRCMVF3QnNNZ2Ex?=
 =?utf-8?B?bDBtSDdqUTBaY2ErODl2ditSSWp1c2hCNEwyaWFWQlV4ZEJ6TWVqdFFNb2Nz?=
 =?utf-8?B?NXdVdDRta1F1elpBMjNTVGRDOHRjN2FDbkJzRk5CUFdtamNhb1h0YUpJTllk?=
 =?utf-8?B?RjJscEp3YktqZFprb3BnN1ZscWgrL1BOVUM5SU05K3NPWXB1cDN4NzRCQTcx?=
 =?utf-8?B?bmY0U2xUL09wR05OK2w2TW1yMG1ZZDZoZ245eHdxbE9WZGpoNEdDYVZMem95?=
 =?utf-8?B?dE9UQXdmd1NJOUJZR1gyKzFlVDY3OFdiSWRsSG01aUF3blNjUmNVM1BmdU9j?=
 =?utf-8?B?K1BNZWJUMTh2aWsxSU1lWHdSanVITU1Yby9SY0JMangwOWcxNVQ2U1drYkF2?=
 =?utf-8?B?ZmlZeEhjclFGb3ZsVXV6Mk1ydklLQjVEQnA3V1pMb0tvU1hnQkpXQ1VRN3Fs?=
 =?utf-8?B?U2M4WTBNZUI5SXlLSVNhYi85dDdwMGpQd1h4RTJ0bk1Yci9HQUw5RzQ1Y0ll?=
 =?utf-8?B?dnpXbURwbGpQaXV2TDhDbjBUU2Mvd1NvaUk1ckRWNFpBa0dHcEc3Nlc0YVRs?=
 =?utf-8?B?WTYxQXJIaEZScTIzU0ZubFVaQyt5Sk5sNURNVzR5THVCdVVGdTdheldkUVZF?=
 =?utf-8?B?c2ZXNGdDWHJJQVFEOGErV21iS21SRnpiOVlsaXJWMDVjZWsxQW41SHJ0Qkk2?=
 =?utf-8?B?M1pYZ1B3WmxtRjVJRFNLREtrbEFOMEpheDNtaDlQWVFObWQ3ZzUxbzZXWE5p?=
 =?utf-8?B?MUs1NzVva2xEMDNmTWRQak5zbFJuQnRFaEJJbWEvRnpsOW9sd1h4NDB6Ylhu?=
 =?utf-8?B?ZjRQM3NaOEd4bC96NmF1MkNUWTh3S1d6enJBVTYrOFlFc3JXYUtmQkU0aTBr?=
 =?utf-8?B?MmJ2SGVPT0txUFlDYmZqYWtRcjUwQVBuU1U5TDdnT2ZHdjVBS0hmS1paZzFx?=
 =?utf-8?B?cEhPOGlKYUo4M1VVMUl0MlRDYzBKVk9NelF5bXJYWEg5K0hhYVBqa1hmMnFE?=
 =?utf-8?B?V2VvaDZrQ1NBOGtsL1oxRDhDdy9nWHlXMVY0aHp6L3NEUXhxcWtwZlFVN3lv?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52158041E13C64EB403E4CAE718F265@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d803a4-51f1-4c20-789c-08dbc5e30b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 20:38:34.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ng7hh8y+APIPc2Ye7Ety00iKeEacdxlUzZcuFF6DIq/LMaOtnSj7sKLTxXx1dM/UGQE0W5cKQlz3stOAGpj0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8211
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDE0OjMzIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFRodSwgMDUgT2N0IDIwMjMgMDc6MzA6NDYgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBGcmksIDIwMjMtMDktMjIgYXQgMjA6MDYg
LTA3MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBz
Z3hfZXBjX2xydV9saXN0cyAqc2d4X2xydV9saXN0cyhzdHJ1Y3QgIA0KPiA+ID4gc2d4X2VwY19w
YWdlICplcGNfcGFnZSkNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiAmc2d4X2dsb2JhbF9scnU7
DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBzZ3hfY2FuX3Jl
Y2xhaW0odm9pZCkNCj4gPiA+ICt7DQo+ID4gPiArCXJldHVybiAhbGlzdF9lbXB0eSgmc2d4X2ds
b2JhbF9scnUucmVjbGFpbWFibGUpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiANCj4gPiBTaG91
bGRuJ3Qgc2d4X2Nhbl9yZWNsYWltKCkgYWxzbyB0YWtlIGEgJ3N0cnVjdCBzZ3hfZXBjX2xydV9s
aXN0cyAqJz8NCj4gPiANCj4gPiBJIHRob3VnaHQgd2UgYWxzbyBuZWVkIHRvIGNoZWNrIHdoZXRo
ZXIgYSBjZ3JvdXAncyBMUlUgbGlzdHMgY2FuIGJlICANCj4gPiByZWNsYWltZWQ/DQo+IA0KPiBU
aGlzIGlzIG9ubHkgdXNlZCB0byBjaGVjayBpZiBhbnkgcGFnZXMgcmVjbGFpbWFibGUgYXQgdGhl
IHRvcCBsZXZlbCBpbiAgDQo+IHRoaXMgZmlsZS4gTGF0ZXIgc2d4X2VwY19jZ3JvdXBfbHJ1X2Vt
cHR5KE5VTEwpIGlzIHVzZWQgaW4gdGhpcyBmdW5jdGlvbiAgDQo+IHRvIHJlY3Vyc2l2ZWx5IGNo
ZWNrIGFsbCBjZ3JvdXBzIHN0YXJ0aW5nIGZyb20gdGhlIHJvb3QuDQo+IA0KPiANCg0KVGhpcyBh
Z2FpbiBmYWxscyB0byB0aGUgImltcG9zc2libGUgdG8gcmV2aWV3IHVubGVzcyByZXZpZXcgYSBs
YXRlciBwYXRjaCBmaXJzdCINCmNhdGVnb3J5LiAgVGhpcyBwYXRjaCBzYXlzIG5vdGhpbmcgYWJv
dXQgc2d4X2Nhbl9yZWNsYWltKCkgd2lsbCBvbmx5IGJlIHVzZWQgYXQNCnRoZSB0b3AgbGV2ZWwu
ICBFdmVuIGlmIGl0IGRvZXMsIHdoeSBjYW5ub3QgaXQgdGFrZSBMUlUgbGlzdHMgYXMgaW5wdXQ/
DQoNCkFsbCB0aGlzIHBhdGNoIHNheXMgaXMgd2UgbmVlZCB0byBwcmVwYXJlIHRoZXNlIGZ1bmN0
aW9ucyB0byBzdWl0IG11bHRpcGxlIExSVQ0KbGlzdHMuDQoNCkJ0dywgd2h5IHNneF9yZWNsYWlt
X2VwY19wYWdlcygpIGRvZXNuJ3QgdGFrZSBMUlUgbGlzdHMgYXMgaW5wdXQgZWl0aGVyPyAgSXMg
aXQNCnBvc3NpYmxlIHRoYXQgaXQgY2FuIGJlIGNhbGxlZCBhY3Jvc3MgbXVsdGlwbGUgTFJVIGxp
c3RzLCBvciBhY3Jvc3MgZGlmZmVyZW50DQpsaXN0cyBpbiBvbmUgTFJVPw0KDQpXaHkgZG8gd2Ug
bmVlZCB0byBmaW5kIHNvbWUgcGFydGljdWxhciBMUlUgbGlzdHMgYnkgZ2l2ZW4gRVBDIHBhZ2U/
DQoNCitzdGF0aWMgaW5saW5lIHN0cnVjdCBzZ3hfZXBjX2xydV9saXN0cyAqc2d4X2xydV9saXN0
cyhzdHJ1Y3Qgc2d4X2VwY19wYWdlDQoqZXBjX3BhZ2UpDQorew0KKwlyZXR1cm4gJnNneF9nbG9i
YWxfbHJ1Ow0KK30NCisNCg0KTWF5YmUgaXQncyBjbGVhciBmb3Igb3RoZXIgcGVvcGxlLCBidXQg
dG8gbWUgaXQgc291bmRzIHNvbWUgbmVjZXNzYXJ5IGRlc2lnbg0KYmFja2dyb3VuZCBpcyBtaXNz
aW5nIGF0IGxlYXN0Lg0KDQpQbGVhc2UgdHJ5IGJlc3QgdG8gbWFrZSB0aGUgcGF0Y2ggc2VsZi1y
ZXZpZXdhYmxlIGJ5IGp1c3RpZnlpbmcgYWxsIG9mIHRob3NlLg0K
