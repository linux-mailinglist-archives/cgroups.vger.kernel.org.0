Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7107BA106
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbjJEOmx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbjJEOhE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:37:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A6C4F6D8;
        Thu,  5 Oct 2023 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514572; x=1728050572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HmZw8UIBU51lgqrQvjpgt3S0cqiqF3vDVQ7R4VUUYmc=;
  b=GtqPP0S6bHe+ZHqQ794nfPZhEAMfWfVui9GPrq7BD2tIwn5vYezCXGKs
   nuj5I0UwfHd5gzi+uyj2w4PBrX97nclMtO2HPLg527pM3hU4yKd0/fOLx
   jd/r0NyPlRcFPKTJEygpj9pibwPopIJE7PGurmsM3n9ReP8QwZWi9iOcI
   yzSREGURjHkrH1GDzQKBbkglP1HmXmP7wovaYof0fh2hv/2Z0dlplSNBW
   f8xMjBA03uHxkLlnKgg+wm93Jc6LuU82iss5MQ6n4/uj7IQlD/rtDCTia
   9thnahu7QAT9VBnAM3L5b6bZxG5HyA+VK6BijunLAP7OQdUQnEpTbu3i6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="382347485"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382347485"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="755425299"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755425299"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 05:24:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 05:24:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 05:24:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 05:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OacT7HCnORtYTtqAEOVSji8yr2tU94MxRPZBb/j2SKxGU/P/N3bRdt6vRW8Zy0DTwrJBbCHxgEEP/lveVg41VZstd3v2v3yE7X/hUoynRVdTURzRgA2ONdQbi+tzfHej7vx39f+0niphq+L0Wjsdj2PguNlXTLVI0jcIjV9iqhejowaEYeP++tC5OSibhERgcEUTBnmxTvPWqzFVlpHh4io5nQJeKg4BEpaNb1V2qTt5zcJmtPTNaK4QEu4qIqj4Q7a6Eeg4qZW2aoQL/fES7dTC/GXOWDMW0BPM+/xOL7Q6AhkA9gsrQToCHN4OWyXkRtn0NAmN0MoLsCTgm2r3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmZw8UIBU51lgqrQvjpgt3S0cqiqF3vDVQ7R4VUUYmc=;
 b=jm5Y4iX6n9v1K1dJplncU7yBkNwzqM8rmfW2PfKpXKkoDc4iJseS/z+mcGB8oXwVK+xx36MUlFOvZxFvm95PTdgh2QMbu6qTHdWAEdHdzPNx8r9ZbAK/yzU4K0TqC3qnZ0k7hgN+/r6/yDCQU2uIUeOx3Xc4lTVBQeykwtrvaZUZbrsvbOlg4NbTR6xJhYjqiWIa1jrS4+bIc7Ko9X16P7npYUPm2GBskX6TP52MUGaW8oSaP27YrXaAsU3uMoJB3mYK2M9ugymHqRWZBadBQjGg+p0KPnXHwPIeWLHTVJJatel3vP9poCoXbwRv3ewbLFxtAq6cc1LVTXH4WSpt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 5 Oct
 2023 12:24:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 12:24:12 +0000
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
Subject: Re: [PATCH v5 13/18] x86/sgx: Expose sgx_reclaim_pages() for use by
 EPC cgroup
Thread-Topic: [PATCH v5 13/18] x86/sgx: Expose sgx_reclaim_pages() for use by
 EPC cgroup
Thread-Index: AQHZ7csijtHESmbqeky3jjE6y2bmv7A7MhWA
Date:   Thu, 5 Oct 2023 12:24:12 +0000
Message-ID: <a03cf29a5ff35b9467470a0cd38e4096820eab8d.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-14-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-14-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB5052:EE_
x-ms-office365-filtering-correlation-id: 7271b53a-f262-43e2-d6d7-08dbc59dfb96
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b3EKe59sXGlhq7U6lCwcdGJcrsDcHZ/QfF5yw+bjhZbB5m0/cDK4DHBkIZ1ec8J+SihKQb0/j82kGwSQ2DWEXUZaJ79pA0PuZLveZCnP+gPoxRcAfWG4EI4Sh1Xs9iR7/Ae/Z9Y+UNmTawbDv2Nl83YZ3rIEnmwdbMj17LdY7ctb6GZ/Cf9Lwa4UE+aMo6JlYPxagWvDtWxLOM9ZIhUya/AD668b1qTbZeUdh1oIgfjsgVGT6O8uv0BohHLdweTYSGEj9K8ilRHYZo6FR9gJ85NLwTukaR9jNQY4ULeBCUwYnFQhdSDdw+KerTMQA8STiUh3p6hVEtOHiceBj432HJiL4WhahflrR4GDFqaw59oxipMPn+iJFAhn0/RJSQRkWRuS7TZtG5QNrnhzkn31EN03T7wpxKArT0AdJUaTVwUeWCjMUPUXc3HV9o6jB8XIMrAZskkgSSNBznbBqMFbMcRTZKzHKnzY8wUOffR0kKhT4+ezkMkdsNuk3nVgql7DcSoTbU9lZdA9xaf5ciq2f3modBRZWRBnlNGnClUTnI4cXWy+mjNCuCNNxikXYRwlg60uS1XMwFkt7HL4PiqPxxfcjcjXxojVDTtnBiv7RAhpdug+a6oYTURQZxx17mtfPvXHJaRnUc5mzxooJ7xEow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8676002)(8936002)(76116006)(91956017)(4326008)(110136005)(2906002)(478600001)(66946007)(66446008)(66556008)(316002)(5660300002)(54906003)(41300700001)(64756008)(7416002)(66476007)(6506007)(26005)(6486002)(6512007)(38070700005)(71200400001)(2616005)(83380400001)(122000001)(921005)(36756003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmFlUDRadkJacm1qMWpJTG9tSXU1MllnM1J1QWdCQ1BvM2FYeTVoS3dVRzZI?=
 =?utf-8?B?eE9EUWh5MFI5bStxWXUzZnZtV1NrcUZxd3pDUkU5MTFMemVxcjNhcUxkWkcw?=
 =?utf-8?B?RFRhNW5idGRKVGU4bTVEOWlyQ25jQW9rdmhBWFBuVndWZUdrV05sYnIrczFJ?=
 =?utf-8?B?dC9WRERYbkxLTHM3SXBPRE41cDhHbEhHZ2FETS9KOXhJNWVHZUM5ZUdyMFAy?=
 =?utf-8?B?YklHdldLUGw5cXkvSlFzc0lhN3c1Y0hMQ0dzWW01aGNOcUR1NExBMSttT0Ny?=
 =?utf-8?B?RStiSGVyRUs2dVZVRnFrTTl5ZFE3NklLRU5kbEF3aEdDWXk4RlR0anlMVzRX?=
 =?utf-8?B?MVVLNEh6Z0tCY0QzdGJmZ2hEaWMrQ09GOEFqVk5kWkZzK1IwcjVPMENkVldQ?=
 =?utf-8?B?VjFpSjNxYitOdE42eGsvMmUrWFlVQy9WT0ZxRWVHVXJISHhleGtRL1BaRkVH?=
 =?utf-8?B?dFlUaDFlOFRvT203RVk1MUYwaDljUHlmdS9vTkwweWRTVDFhbGs0WG5xeUUy?=
 =?utf-8?B?NU9WVzJVWFVmKzNqSTV2WHFzYjZ5ZGRrNnM0aUdPZklRZXJRejhIRUg1Qjg3?=
 =?utf-8?B?Y01taVVzUWdmU0ZldWN6d1ZKUStQRXVoZkZ5Y0NUT0xmZWlaZFIzWnE3ZmRv?=
 =?utf-8?B?Y3FqSmxEVTFISFBNcVFycVNqOVZwb29BMHpFVFNSWHpaZmk5TFBua29ieis5?=
 =?utf-8?B?S3h1VitaRjl2VHhIMzhjeXVFdGlkN1VMMGloc2Z2ZTVrallRTTlCdlJpZW1I?=
 =?utf-8?B?WDRPQnJSeXpHNHlvaVl3Rm9QRFMxSXdHMzFpY1B3Sk5vYkw3enNZWlA3c2pz?=
 =?utf-8?B?elFvbGpIcFZHekpjQTlBTkRxSlFPTTNrcS9iVjZqMVdxb0NENWVDRVNjR015?=
 =?utf-8?B?VWdXVWpNTTFSNFpYQUNtOVBCUW4rYXQyWVVPT0ovWEtiQ1EreWY3UUNoVGRH?=
 =?utf-8?B?cVJVeTlTdnV2RGxtZW1WSHdJaE4vRlpyb3dLeGNhS2pFdGg4dVRGclQ0T3Ba?=
 =?utf-8?B?NzU1Nk8wZmhsa3RDNDlKVnRBelRyNi90OU5zemMzalpFUzQwTlcvOGl1Myts?=
 =?utf-8?B?WVJiWEp4K3FyRWV2blNxbGczRTliZ1poQUJyMHZSREtXYjRucmlINXBWMysr?=
 =?utf-8?B?b1pENVY0eGhQS0tLbWRFZngvTW1LNml3eDBjOHdxSTM2RjhiR1ZKUDYxV2c3?=
 =?utf-8?B?RmdPZ0hVWEJEaUZvRFRHckozcDByODF4Skp0Z25tL3V1cWtEWlZDQnRYd2Ft?=
 =?utf-8?B?SlZlVlk3QXl1Q01pdXV6MkdqZmVUUW1kRzV5WHA4Y1ZpVHIvU0ZIQ05tM0dG?=
 =?utf-8?B?UnMxL0ZyY016dXQyaktIUmVnNDF1N2xRQmhmNVBsdGNlNUlackdsUE01U1ps?=
 =?utf-8?B?ZGRQaTlkS1ZOd3YyazFrV01kaWRRV1dNTGROMm13L3kxNXdzdnQreVY5U1Z6?=
 =?utf-8?B?RGJ4OTNvRkxEbmVZVnZmdThRQ3I5YXBXT09hdTRaNjEzWENxaUpxenRGRTNt?=
 =?utf-8?B?RHpkUlpia2hQdy9rcmRBM0ZYc1R5bTBWcklvc3R2U1libThzOXZuRTBQV3Zh?=
 =?utf-8?B?Q3RZWXhHU3RmZlJ6SXlRT2NzZEcyMmtwN1ExYk5DRjg2TVVaanFzOER4MGFE?=
 =?utf-8?B?NVZaV2cwUzJzTGU1VUYrbktzNDZDdE9qQWhOVnp3RmhiL0VYSHcrandpVEw3?=
 =?utf-8?B?MTBmRzhZclVKckR4aTBkdU8xWTd4ZHdKRmRtaTMzNmVSTXNYeVFsdkxzUEt5?=
 =?utf-8?B?NTI0a2NON0VYQlRFV1R5UzNtN2VmV1NlNldMMlliVnhNVzROdVJZbkNsdnJD?=
 =?utf-8?B?TU9RRkxNUHE2cys4NFNaZnVFTEJFZytEY2dIMXE1RnBuMk13Nm4rbE1DUEUr?=
 =?utf-8?B?ZWVIaFRsV0pqUDdvVjRUdjJGaDV0bmx6MElJcFAzdlhGUWNBS2plNHpuUGNz?=
 =?utf-8?B?a2YzZVhrNzMvQjdvaDVXTFlER2pjUHJjR3AwNWIwMDZSRTByTkxMVVcvb0x1?=
 =?utf-8?B?bGtRNTBBV2tVK2ZISzhIUE5jRE1WUExIM2N4NlNZdm1QdkRjTVArSCtMSjZY?=
 =?utf-8?B?ZXdnaHpZMytScC9vb1h6d0tUVGlwTmRRV20wQ0l1MHVIeHI4bEJpdmFyKytr?=
 =?utf-8?B?emxycU0zUzlVTDdEUFpsTDJpWnVpcm4vRkhaMnNXYmQxTzd1T1gya1RCYUFh?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC23393368451746BA10BF293EEA5F5B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7271b53a-f262-43e2-d6d7-08dbc59dfb96
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 12:24:12.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WA8xLGgn+nHse5jhYqqZQngwsYcSmF9V7Uwzu/M3bgI/2ARQ5YF7M1fJDKJkvbbRVGcBIAiQZ210dL4gRGqmgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBBZGp1c3QgYW5kIGV4cG9zZSB0aGUgdG9wLWxldmVsIHJlY2xhaW0gZnVuY3Rp
b24gYXMNCj4gc2d4X3JlY2xhaW1fZXBjX3BhZ2VzKCkgZm9yIHVzZSBieSB0aGUgdXBjb21pbmcg
RVBDIGNncm91cCwgd2hpY2ggd2lsbA0KPiBpbml0aWF0ZSByZWNsYWltIHRvIGVuZm9yY2UgdGhl
IG1heCBsaW1pdC4NCj4gDQo+IE1ha2UgdGhlc2UgYWRqdXN0bWVudHMgdG8gdGhlIGZ1bmN0aW9u
IHNpZ25hdHVyZS4NCj4gDQo+IDEpIFRvIHRha2UgYSBwYXJhbWV0ZXIgdGhhdCBzcGVjaWZpZXMg
dGhlIG51bWJlciBvZiBwYWdlcyB0byBzY2FuIGZvcg0KPiByZWNsYWltaW5nLiBEZWZpbmUgYSBt
YXggdmFsdWUgb2YgMzIsIGJ1dCBzY2FuIDE2IGluIHRoZSBjYXNlIGZvciB0aGUNCj4gZ2xvYmFs
IHJlY2xhaW1lciAoa3NneGQpLiBUaGUgRVBDIGNncm91cCB3aWxsIHVzZSBpdCB0byBzcGVjaWZ5
IGENCj4gZGVzaXJlZCBudW1iZXIgb2YgcGFnZXMgdG8gYmUgcmVjbGFpbWVkIHVwIHRvIHRoZSBt
YXggdmFsdWUgb2YgMzIuDQo+IA0KPiAyKSBUbyB0YWtlIGEgZmxhZyB0byBmb3JjZSByZWNsYWlt
aW5nIGEgcGFnZSByZWdhcmRsZXNzIG9mIGl0cyBhZ2UuICBUaGUNCj4gRVBDIGNncm91cCB3aWxs
IHVzZSB0aGUgZmxhZyB0byBlbmZvcmNlIGl0cyBsaW1pdHMgYnkgZHJhaW5pbmcgdGhlDQo+IHJl
Y2xhaW1hYmxlIGxpc3RzIGJlZm9yZSByZXNvcnRpbmcgdG8gb3RoZXIgbWVhc3VyZXMsIGUuZy4g
Zm9yY2VmdWxseQ0KPiBraWxsIGVuY2xhdmVzLg0KPiANCj4gMykgUmV0dXJuIHRoZSBudW1iZXIg
b2YgcmVjbGFpbWVkIHBhZ2VzLiBUaGUgRVBDIGNncm91cCB3aWxsIHVzZSB0aGUNCj4gcmVzdWx0
IHRvIHRyYWNrIHJlY2xhaW1pbmcgcHJvZ3Jlc3MgYW5kIGVzY2FsYXRlIHRvIGEgbW9yZSBmb3Jj
ZWZ1bA0KPiByZWNsYWltaW5nIG1vZGUsIGUuZy4sIGNhbGxpbmcgdGhpcyBmdW5jdGlvbiB3aXRo
IHRoZSBmbGFnIHRvIGlnbm9yZSBhZ2UNCj4gb2YgcGFnZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0K
PiBDby1kZXZlbG9wZWQtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4
LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS3Jpc3RlbiBDYXJsc29uIEFjY2FyZGkgPGty
aXN0ZW5AbGludXguaW50ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEhhaXRhbyBIdWFuZyA8
aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFpdGFvIEh1
YW5nIDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiBDYzogU2VhbiBDaHJpc3RvcGhl
cnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBWNDoNCj4gLSBDb21iaW5lZCB0aGUg
MyBwYXRjaGVzIHRoYXQgbWFkZSB0aGUgaW5kaXZpZHVhbCBjaGFuZ2VzIHRvIHRoZQ0KPiBmdW5j
dGlvbiBzaWduYXR1cmUuDQo+IC0gUmVtb3ZlZCAnaGlnaCcgbGltaXQgaW4gY29tbWl0IG1lc3Nh
Z2UuDQo+IC0tLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jIHwgMzEgKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvc2d4
LmggIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWlu
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMNCj4gaW5kZXggM2I4NzVhYjRkY2Qw
Li40ZTFhM2UwMzhkYjUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21h
aW4uYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMNCj4gQEAgLTE4LDYg
KzE4LDExIEBADQo+ICAjaW5jbHVkZSAiZW5jbC5oIg0KPiAgI2luY2x1ZGUgImVuY2xzLmgiDQo+
ICANCj4gKy8qDQo+ICsgKiBNYXhpbXVtIG51bWJlciBvZiBwYWdlcyB0byBzY2FuIGZvciByZWNs
YWltaW5nLg0KPiArICovDQo+ICsjZGVmaW5lIFNHWF9OUl9UT19TQ0FOX01BWAkzMg0KPiArDQo+
ICBzdHJ1Y3Qgc2d4X2VwY19zZWN0aW9uIHNneF9lcGNfc2VjdGlvbnNbU0dYX01BWF9FUENfU0VD
VElPTlNdOw0KPiAgc3RhdGljIGludCBzZ3hfbnJfZXBjX3NlY3Rpb25zOw0KPiAgc3RhdGljIHN0
cnVjdCB0YXNrX3N0cnVjdCAqa3NneGRfdHNrOw0KPiBAQCAtMjc5LDcgKzI4NCwxMSBAQCBzdGF0
aWMgdm9pZCBzZ3hfcmVjbGFpbWVyX3dyaXRlKHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKmVwY19wYWdl
LA0KPiAgCW11dGV4X3VubG9jaygmZW5jbC0+bG9jayk7DQo+ICB9DQo+ICANCj4gLS8qDQo+ICsv
KioNCj4gKyAqIHNneF9yZWNsYWltX2VwY19wYWdlcygpIC0gUmVjbGFpbSBFUEMgcGFnZXMgZnJv
bSB0aGUgY29uc3VtZXJzDQo+ICsgKiBAbnJfdG9fc2NhbjoJCSBOdW1iZXIgb2YgRVBDIHBhZ2Vz
IHRvIHNjYW4gZm9yIHJlY2xhaW0NCj4gKyAqIEBpZ25vcmVfYWdlOgkJIFJlY2xhaW0gYSBwYWdl
IGV2ZW4gaWYgaXQgaXMgeW91bmcNCj4gKyAqDQo+ICAgKiBUYWtlIGEgZml4ZWQgbnVtYmVyIG9m
IHBhZ2VzIGZyb20gdGhlIGhlYWQgb2YgdGhlIGFjdGl2ZSBwYWdlIHBvb2wgYW5kDQo+ICAgKiBy
ZWNsYWltIHRoZW0gdG8gdGhlIGVuY2xhdmUncyBwcml2YXRlIHNobWVtIGZpbGVzLiBTa2lwIHRo
ZSBwYWdlcywgd2hpY2ggaGF2ZQ0KPiAgICogYmVlbiBhY2Nlc3NlZCBzaW5jZSB0aGUgbGFzdCBz
Y2FuLiBNb3ZlIHRob3NlIHBhZ2VzIHRvIHRoZSB0YWlsIG9mIGFjdGl2ZQ0KPiBAQCAtMjkyLDE1
ICszMDEsMTQgQEAgc3RhdGljIHZvaWQgc2d4X3JlY2xhaW1lcl93cml0ZShzdHJ1Y3Qgc2d4X2Vw
Y19wYWdlICplcGNfcGFnZSwNCj4gICAqIHByb2JsZW1hdGljIGFzIGl0IHdvdWxkIGluY3JlYXNl
IHRoZSBsb2NrIGNvbnRlbnRpb24gdG9vIG11Y2gsIHdoaWNoIHdvdWxkDQo+ICAgKiBoYWx0IGZv
cndhcmQgcHJvZ3Jlc3MuDQo+ICAgKi8NCj4gLXN0YXRpYyB2b2lkIHNneF9yZWNsYWltX3BhZ2Vz
KHZvaWQpDQo+ICtzaXplX3Qgc2d4X3JlY2xhaW1fZXBjX3BhZ2VzKHNpemVfdCBucl90b19zY2Fu
LCBib29sIGlnbm9yZV9hZ2UpDQoNCidzaXplX3QnIGxvb2tzIG9kZC4gIEFueSByZWFzb24gdG8g
dXNlIGl0Pw0KDQpHaXZlbiB5b3Ugb25seSBzY2FuIDMyIGF0IG1heGltdW0sIHNlZW1zICdpbnQn
IGlzIGdvb2QgZW5vdWdoPw0KDQo+ICB7DQo+IC0Jc3RydWN0IHNneF9iYWNraW5nIGJhY2tpbmdb
U0dYX05SX1RPX1NDQU5dOw0KPiArCXN0cnVjdCBzZ3hfYmFja2luZyBiYWNraW5nW1NHWF9OUl9U
T19TQ0FOX01BWF07DQo+ICAJc3RydWN0IHNneF9lcGNfcGFnZSAqZXBjX3BhZ2UsICp0bXA7DQo+
ICAJc3RydWN0IHNneF9lbmNsX3BhZ2UgKmVuY2xfcGFnZTsNCj4gIAlwZ29mZl90IHBhZ2VfaW5k
ZXg7DQo+ICAJTElTVF9IRUFEKGlzbyk7DQo+IC0JaW50IHJldDsNCj4gLQlpbnQgaTsNCj4gKwlz
aXplX3QgcmV0LCBpOw0KPiAgDQo+ICAJc3Bpbl9sb2NrKCZzZ3hfZ2xvYmFsX2xydS5sb2NrKTsN
Cj4gIAlmb3IgKGkgPSAwOyBpIDwgU0dYX05SX1RPX1NDQU47IGkrKykgew0KDQpUaGUgZnVuY3Rp
b24gY29tbWVudCBzYXlzIA0KDQoJKiBAbnJfdG9fc2NhbjoJCSBOdW1iZXIgb2YgRVBDIHBhZ2Vz
IHRvIHNjYW4gZm9yIHJlY2xhaW0NCg0KQnV0IEkgZG9uJ3Qgc2VlIGl0IGlzIGV2ZW4gdXNlZCwg
aWYgbXkgZXllIGlzbid0IGRlY2VpdmluZyBtZT8NCgkNCj4gQEAgLTMyNiwxMyArMzM0LDE0IEBA
IHN0YXRpYyB2b2lkIHNneF9yZWNsYWltX3BhZ2VzKHZvaWQpDQo+ICAJc3Bpbl91bmxvY2soJnNn
eF9nbG9iYWxfbHJ1LmxvY2spOw0KPiAgDQo+ICAJaWYgKGxpc3RfZW1wdHkoJmlzbykpDQo+IC0J
CXJldHVybjsNCj4gKwkJcmV0dXJuIDA7DQo+ICANCj4gIAlpID0gMDsNCj4gIAlsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmUoZXBjX3BhZ2UsIHRtcCwgJmlzbywgbGlzdCkgew0KPiAgCQllbmNsX3Bh
Z2UgPSBlcGNfcGFnZS0+ZW5jbF9wYWdlOw0KPiAgDQo+IC0JCWlmICghc2d4X3JlY2xhaW1lcl9h
Z2UoZXBjX3BhZ2UpKQ0KPiArCQlpZiAoaSA9PSBTR1hfTlJfVE9fU0NBTl9NQVggfHwNCg0KaSA9
PSBucl90b19zY2FuPw0KDQpBbmQgc2hvdWxkIHdlIGhhdmUgYQ0KDQoJaWYgKG5yX3RvX3NjYW4g
PCBTR1hfTlJfVE9fU0NBTl9NQVgpDQoJCXJldHVybiAwOw0KDQphdCB0aGUgdmVyeSBiZWdpbm5p
bmcgb2YgdGhpcyBmdW5jdGlvbj8NCg0KPiArCQkgICAgKCFpZ25vcmVfYWdlICYmICFzZ3hfcmVj
bGFpbWVyX2FnZShlcGNfcGFnZSkpKQ0KPiAgCQkJZ290byBza2lwOw0KPiAgDQo+ICAJCXBhZ2Vf
aW5kZXggPSBQRk5fRE9XTihlbmNsX3BhZ2UtPmRlc2MgLSBlbmNsX3BhZ2UtPmVuY2wtPmJhc2Up
Ow0KPiBAQCAtMzcxLDYgKzM4MCw4IEBAIHN0YXRpYyB2b2lkIHNneF9yZWNsYWltX3BhZ2VzKHZv
aWQpDQo+ICANCj4gIAkJc2d4X2ZyZWVfZXBjX3BhZ2UoZXBjX3BhZ2UpOw0KPiAgCX0NCj4gKw0K
PiArCXJldHVybiBpOw0KPiAgfQ0KPiAgDQoNCkkgZm91bmQgdGhpcyBmdW5jdGlvbiBhIGxpdHRs
ZSBiaXQgb2RkLCBnaXZlbiB0aGUgbWl4aW5nIG9mICducl90b19zY2FuJywNClNHWF9OUl9UT19T
Q0FOIGFuZCBTR1hfTlJfVE9fU0NBTl9NQVguDQoNCkZyb20gdGhlIGNoYW5nZWxvZzoNCg0KCTEp
IFRvIHRha2UgYSBwYXJhbWV0ZXIgdGhhdCBzcGVjaWZpZXMgdGhlIG51bWJlciBvZiBwYWdlcyB0
byBzY2FuIGZvcg0KCXJlY2xhaW1pbmcuIERlZmluZSBhIG1heCB2YWx1ZSBvZiAzMiwgYnV0IHNj
YW4gMTYgaW4gdGhlIGNhc2UgZm9yIHRoZQ0KCWdsb2JhbCByZWNsYWltZXIgKGtzZ3hkKS4gDQoN
Ckl0IGFwcGVhcnMgd2Ugd2FudCB0byBtYWtlIHRoaXMgZnVuY3Rpb24gdG8gc2NhbiBAbnJfdG9f
c2NhbiBmb3IgY2dyb3VwLCBidXQNCnN0aWxsIHdhbnQgdG8gc2NhbiBhIGZpeGVkIHZhbHVlIGZv
ciBrc2d4ZCwgd2hpY2ggaXMgU0dYX05SX1RPX1NDQU4uICBBbmQNCkBucl90b19zY2FuIGNhbiBi
ZSBsYXJnZXIgdGhhbiBTR1hfTlJfVE9fU0NBTiBidXQgc21hbGxlciB0aGFuDQpTR1hfTlJfVE9f
U0NBTl9NQVguDQoNClB1dHRpbmcgYmVoaW5kIHRoZSBteXN0ZXJ5IG9mIHdoeSBhYm92ZSBpcyBu
ZWVkZWQsIHRvIGFjaGlldmUgaXQsIGlzIGl0IG1vcmUNCmNsZWFyIGlmIHdlIGRvIGJlbG93Pw0K
DQppbnQgX19zZ3hfcmVjbGFpbV9lcGNfcGFnZXMoaW50IG5yX3RvX3NjYW4sIGJvb2wgaWdub3Jl
X2FnZSkNCnsNCglzdHJ1Y3Qgc2d4X2JhY2tpbmcgYmFja2luZ1tTR1hfTlJfVE9fU0NBTl9NQVhd
Ow0KCS4uLg0KDQoJaWYgKG5yX3RvX3NjYW4gPiBTR1hfTlJfVE9fU0NBTl9NQVgpDQoJCXJldHVy
biAwOw0KDQoJZm9yIChpID0gMDsgaSA8IG5yX3RvX3NjYW47IGkrKykgew0KCQkuLi4NCgl9DQoN
CglyZXR1cm4gcmVjbGFpbWVkOw0KfQ0KDQovKiBUaGlzIGlzIGZvciBrc2d4ZCgpICovDQppbnQg
c2d4X3JlY2xhaW1fZXBjX3BhZ2Uodm9pZCkNCnsNCglyZXR1cm4gX19zZ3hfcmVjbGFpbV9lcGNf
cGFnZXMoU0dYX05SX1RPX1NDQU4sIGZhbHNlKTsNCn0NCg0KRVBDIGNncm91cCBjYWxscyBfX3Nn
eF9yZWNsYWltX2VwY19wYWdlcygpIGRpcmVjdGx5LCBvciBpbnRyb2R1Y2UgYW5vdGhlcg0Kd3Jh
cHBlci4NCg0KDQoNCg0KDQo=
