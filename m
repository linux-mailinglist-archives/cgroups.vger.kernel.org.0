Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950197BA17F
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjJEOsi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbjJEOqD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:46:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C6B3D0D;
        Thu,  5 Oct 2023 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696516119; x=1728052119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BmPQ84Jn63g27TH/surJ86JQqIuHJR3PBw8kkugkJZU=;
  b=fsFp8XZmyPOMcldUhf2cLZQlmmfTl50xttgKwtqjaRNCtEPdiq1zcJqf
   7FgKWUMSBpUlnfJ/hr6rrjhDmVpS1QBn09l522zHfJbvr44GNueXUhUnl
   8fFZJgq5f5vAdZxQsfOJ+48shZV1H/1JiEZrvoy73oOtz0vy3Ytcn1e8a
   R0kPvdFYqmzHKkT3HKBAhq8xow/mp/SEVP5HIARXkpmFECPnmsCO1whVD
   7uZMHayVyU0D5qSYryU1XTVbPAChQpYTyuToTkkwXRXghrqZYbVq+Fh2q
   aona7zq+qmnGyVXsojUo/GyIQ3l7bjfaFhryPlSa6Ap27bi6DVsObIEAt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="449913258"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="449913258"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 23:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="728328494"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="728328494"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 23:49:18 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 23:49:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 23:49:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 23:49:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fbkst+LJXeWB3yVqtHA0ShXbo8/nhdaAm9m31viCZapIm+X/tuZoNs9ng5q5Za2jvxh27hB745IXxW/88YtE4ebJpgBA6hJdZ3hVtyN+X/rrcX4fmZ7YtjRihkCmHMMNZ/PKfTL66Fwmd/C3w65O4MQRzE8bYI3bXB06stOeLLMtrgnhGBh5FD5tV8a7Z9CWuDanygsUaczsiKh57qVsigY0RkTydKxG7wrCVE9InlcA4qGdg1hlC+msNEKgAtIUFFH9KPTfnHeQfMTOqNqRH3ND9mCHrGgFaB9YzqOk/LKqIKUJUs+/ZtUbG20VCmjtk1HWaShNsId89KOLqc+YVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmPQ84Jn63g27TH/surJ86JQqIuHJR3PBw8kkugkJZU=;
 b=Nu66XeGvlnNpy6DSPDVxNOwEG8/4A2JckbleZPtycJUxKXkiPVo74cgaOHoqCBjDzDznNk5UjYAQ5e1R4u7UWGAPxdREAqEz+0XJ545AgKzfauc12RFxK9G4w+VykGirT5TbwcGwzFOVB/Jddo7RYFdwO9YsHJzecIVSlZrG7aTVlYLd+t2R++oOFRnrOGSR6KZ4hOEwLVxSAV2bkOk8hTDShednEHRjV0oMAXNdz53boCFop5str6QJQcS0YemoI1e82tYlwOAfQ4VsRHsXGX/2uRWeG4OVYXRNpjSWcXnHgag+Zj5nyZ4MeX2jI6knqT7ZLnjzB5byjQe08wLylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 06:49:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 06:49:13 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Thread-Index: AQHZ7cscCwFKzsfMlUe7K1500sBqu7AukfYAgAkcyICAAOAtgIABPXaAgABnUQCAAHfdAIAAKOwA
Date:   Thu, 5 Oct 2023 06:49:13 +0000
Message-ID: <d49edf96a0ed2a4bcbf2c7f192c89b800c6791c5.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-10-haitao.huang@linux.intel.com>
         <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
         <op.2b77pp0wwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <0953e4fac90921ff53570e2e6ebd2689fc1cd8fa.camel@intel.com>
         <op.2capgplewjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <34ec0ef5fda43e4b08e1e8352e5198e9e8a783ca.camel@intel.com>
         <op.2cbqf0nkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2cbqf0nkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7050:EE_
x-ms-office365-filtering-correlation-id: 610077b8-ec1d-4a2f-ce05-08dbc56f2f9a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrZ2kJAl09Q4/PTd00Nv62QIycppBojPVjfGfdaEzGRmdOAuTwmxLj9JLIpWcZC1zb14M432OhEVkXvyOxK5d/Y6h6z8oU/FZ6IqG4qbJOO/YmEFEr+0PqGhEGsm7P1jLMKfFYK+BStvaaxZ57RmStDIr1A21R6u3Tq9y/9J9TtbvYzdFfewPF51YgJAY2eSbwbl1fZKlKsyMDaHchQvtqGJhSiB/qqrSgo7FyCUHtHuBNzMekU74RPBpMOwNcLETtAWzSl2Me2FKM8q6CWqJd3HJ45xYFq0Ncjrwjccdtj9QKsMvNbVOM4LeUuzBoWLma0ZcypaW1mY1ghzGocVYixz+Spl0UIIg90bKK87UrUpmGA193jBqd1obxeduwTJ8I57cTHAyAR75F8J7v01VpjyXzblSSPim6nPHAnWfwNKO83gqG4wL52WTAQ1BKlNty9i/SP3bSvn5w+2nZvVYBxswhyyJnnQzXfsf2qCq9aGFI0LsKAEzDJf6RrYeqj0fNd8meEYMg9Z7xW7khe6jR8GFm23J3hb5/nSI1CBOjBzx/rHwVbj/GQow4m9Yp0S5zEC19HfMioHNilUwVmWHojflQZazIXnStHNmuy7729dFP0byRABAg352c1nXM/b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(91956017)(110136005)(6486002)(2616005)(66946007)(316002)(6506007)(66556008)(64756008)(54906003)(41300700001)(6512007)(66446008)(66476007)(76116006)(8676002)(8936002)(4326008)(5660300002)(26005)(71200400001)(478600001)(7416002)(2906002)(83380400001)(36756003)(82960400001)(38070700005)(921005)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5iNytWS3d2TFE0Z0ZTSENoUGlJcnpiMHFWMXorZk5WWUpZc3pDV1M0UVkw?=
 =?utf-8?B?aEQxeSs0dk9ZamN0SDFUOUpwVDBoaW5PclVGRENubG9la2hzbzR6cWlTM2RP?=
 =?utf-8?B?bU02eEpUU0VEWVlXNEd6clZpVGVKOVY2ZUhyeU1KRTQ1VW9tZFFrTHg0cytv?=
 =?utf-8?B?cW9iOFNrNGhzZ2xUR0gxZjEvVFhhbG8yRTNqUzk0dUQ2YzB2c3hRNHJSOUo1?=
 =?utf-8?B?MGEwQ0NMRjN2d0lpOVFiWktCVG9JR1ZtZ1Y5NTl3eXExOXloZHNPRjRHNEQv?=
 =?utf-8?B?eWxYWTBiRUdpOFVWQjdIY1RGcGd1ZkJLRzByZnZYL0QvaytqWGRtZ3B0U0lT?=
 =?utf-8?B?eFBoUkhNclZUdVQzSTVKL2VRbGkwcWIrd1JFWnA2Sm5QR3h1UUUxWDJ3SEhO?=
 =?utf-8?B?U2RiVzFjZkZmWXlOak5aVHZhamo4MmxPaFhMK09VcXFsWlJGa3JSL2x4eU56?=
 =?utf-8?B?U2IyUisxOVNReEY5L3N6OGpNcUcxeXRUNXkrdHBxRVkvbEhIdkpNQVdsZVpV?=
 =?utf-8?B?WDRVYXhobWNXWEI3dGU2b2RJRmI4b0RWQTI3eDlTMkZldWhIekV1RVJJN1BF?=
 =?utf-8?B?eVlmb2FtVHBTSmdIeU8yUTEzRlgwNUdEdkVCSnpEUDlaRmI2YVM3OWNub3pO?=
 =?utf-8?B?dTlyN0pjay91bUUyQThEWGVPL0RJSkVwOTVCZzhzYlc0WjJIRzhmc1pKMXFa?=
 =?utf-8?B?MnEwRVh1VzEwMTIwc1V1Sld0Z245TnRVemZsMUoyZzdtR1lBVTRxQXRYNVlu?=
 =?utf-8?B?T3VJV1hpcUtON0NCWHVXVGJTNC9Bdy81c29abUpJcS9ubUxVTklNMXdpdTkz?=
 =?utf-8?B?RHhHOUJ2K0JzR3RSZEI3OVJLTXg1UFZyU2RDSU1XVFhTejFCMi9TblpVNXRH?=
 =?utf-8?B?c0MvK2FranlwOWNVSnNBUlBMY1pmUTV0Qjg3YS9QU0RIK3B6ZHJzRVZaR24v?=
 =?utf-8?B?OVVFUHdLODh2cmlZTEtRaGtNeGkvQytiNEEwR29vK0dNbVdhL21IYUN4Tm1j?=
 =?utf-8?B?elBLckVNMm9ia0phNzhKOUhFY3RwYStjd1lQcXY0TGRhMlUrN252ZHB1dlk0?=
 =?utf-8?B?NnVITThMVEFkZDFhY1pLVm5mL254KzRJNGNwdSs4WC91UEF6a25Ybm1YaE5S?=
 =?utf-8?B?SU5VOWxXN1cwNks1NE9EZ0EyMkR5aEJaV0FER1ZvQXBUQXJkdy9SV2hGRk05?=
 =?utf-8?B?TGhya1pMTHgyc2s2dWR4WUJkT21MN2c2NlRKUmhHS1YycFNRZUIzRzFOZU9l?=
 =?utf-8?B?eHdWM2dBeWYyZWFCcDl2aFJHbHcyT0lScTNLVFhRajkzQmYwYzU2V3pUVFRu?=
 =?utf-8?B?R1pXSXVNZG5ZWmlCVE1ta25VU0VjM05oTXlZMUFEQU0waHdBVUpMYjhUVmpH?=
 =?utf-8?B?eDY1K1NQRzNGbmcrS3oybStpcDBRYnJPMnczZ2xvTEc2c2krSnBrMG9TVGpQ?=
 =?utf-8?B?OEZNM25VQXhDOW5tby8xQytmcFloMzhPNHRuWlVXMzJWejErR3VmSGxpTFJh?=
 =?utf-8?B?ekYwT0F4N2w1bnQ1THozQkFPdlpQNXRxcDlIQzJLWFloNGt4b3YrZ0xHTlBI?=
 =?utf-8?B?KzZoNFB1ZXVCRXFsZGJTczJicHpjMDJJdWlwOFJSS2xQeVJjcFJPMmV2SEln?=
 =?utf-8?B?a0lQTjA3TU5QeGJSVEI2RGVDdHArdDNkV3cwRGlBYUE0OXNxN1pVU1h4akcv?=
 =?utf-8?B?ZjFwZEZOLzY4MXVNYkIzZXZOejdDajFxenVCcyt2TWNvSjE5NGh3cDlKMlpr?=
 =?utf-8?B?dHpoS0lYdXY1eUNuT3VPMDRQeEJ0aUhKS2NtbXgrSFdueThpeDk4bk1wUHp0?=
 =?utf-8?B?QzUyTU9pNnA5bVpCdGxaTW5wQWlXRnBZVk9CaEJIa3pYcWM4UHpyQlBQS3lX?=
 =?utf-8?B?WHdteDVsNjQySEpXbzZpL2xKU2wreFpOY25xTHB4UUJhZlBrZnhDWXZ0SDNU?=
 =?utf-8?B?M1VLdlF0SHdzTURNVkVWd1RHWVlqb1NJVGJHTnZHM2puM2NYRy9vY2g3RWYw?=
 =?utf-8?B?YlpZNUNlWXFzQThjSWJJaGpybTZYMERvVzMvM1VzYXVsbzFWS3Y1Z3lEYjgx?=
 =?utf-8?B?a1lQT1Z0dEZoQjFNVUFQL1UvUkVQS2o3VWV6L2I2WFdHeXlPU1dReE5rbnBN?=
 =?utf-8?B?YzRMQUtaZWZldTQrKytMekVJTmRqZ2xScFZYd2RGZU1yeUVGRTdwengwaUlm?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1FDCC3133877C4A9F04808A62B7EF67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610077b8-ec1d-4a2f-ce05-08dbc56f2f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 06:49:13.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwunwPqa1BPySitSDDVCcu9uSlp/ZUMoUN/mY0FoJYZAUprAmemlZpbQEGeTlBS07n5qte+o6XAZ/4SvlBjYZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDIzOjIyIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFdlZCwgMDQgT2N0IDIwMjMgMTY6MTM6NDEgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBXZWQsIDIwMjMtMTAtMDQgYXQgMTA6MDMg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMDMgT2N0IDIwMjMgMTU6
MDc6NDIgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+ICANCj4gPiA+IHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgMjAyMy0xMC0wMyBhdCAwMTo0NSAtMDUwMCwg
SGFpdGFvIEh1YW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBCdHcsIHByb2Jh
Ymx5IGEgZHVtYiBxdWVzdGlvbjoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlb3JldGlj
YWxseSBpZiB5b3Ugb25seSBuZWVkIHRvIGZpbmQgYSB2aWN0aW0gZW5jbGF2ZSB5b3UgZG9uJ3Qg
IA0KPiA+ID4gbmVlZA0KPiA+ID4gPiA+ID4gdG8gcHV0IFZBDQo+ID4gPiA+ID4gPiBwYWdlcyB0
byB0aGUgdW5yZWNsYWltYWJsZSBsaXN0LCBiZWNhdXNlIHRob3NlIFZBIHBhZ2VzIHdpbGwgYmUg
IA0KPiA+ID4gZnJlZWQNCj4gPiA+ID4gPiA+IGFueXdheQ0KPiA+ID4gPiA+ID4gd2hlbiBlbmNs
YXZlIGlzIGtpbGxlZC4gIFNvIGtlZXBpbmcgVkEgcGFnZXMgaW4gdGhlIGxpc3QgaXMgZm9yPg0K
PiA+ID4gPiA+IGFjY291bnRpbmcgYWxsDQo+ID4gPiA+ID4gPiB0aGUgcGFnZXMgdGhhdCB0aGUg
Y2dyb3VwIGlzIGhhdmluZz8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBZZXMgYmFzaWNhbGx5IHRy
YWNraW5nIHRoZW0gaW4gY2dyb3VwcyBhcyB0aGV5IGFyZSBhbGxvY2F0ZWQuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gVkFzIGFuZCBTRUNTIG1heSBhbHNvIGNvbWUgYW5kIGdvIGFzIHN3YXBwaW5n
L3Vuc3dhcHBpbmcgaGFwcGVucy4gIA0KPiA+ID4gQnV0DQo+ID4gPiA+ID4gaWYgYWNncm91cCBp
cyBPT00sIGFuZCBhbGwgcmVjbGFpbWFibGVzIGFyZSBnb25lIChzd2FwcGVkIG91dCksIGl0J2QN
Cj4gPiA+ID4gPiBoYXZlIHRvcmVjbGFpbSBWQXMvU0VDcyBpbiB0aGUgc2FtZSBjZ3JvdXAgc3Rh
cnRpbmcgZnJvbSB0aGUgZnJvbnQgIA0KPiA+ID4gb2YNCj4gPiA+ID4gPiB0aGUgTFJVbGlzdC4g
VG8gcmVjbGFpbSBhIFZBL1NFQ1MsIGl0IGlkZW50aWZpZXMgdGhlIGVuY2xhdmUgZnJvbSAgDQo+
ID4gPiB0aGUNCj4gPiA+ID4gPiBvd25lciBvZnRoZSBWQS9TRUNTIHBhZ2UgYW5kIGtpbGxzIGl0
LCBhcyBraWxsaW5nIGVuY2xhdmUgaXMgdGhlICANCj4gPiA+IG9ubHkNCj4gPiA+ID4gPiB3YXkg
dG9yZWNsYWltIFZBL1NFQ1MgcGFnZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBUbyBraWxsIGVuY2xh
dmUgeW91IGp1c3QgbmVlZCB0byB0cmFjayBTRUNTIGluICB0aGUgdW5yZWNsYWltYWJsZSAgDQo+
ID4gPiBsaXN0Lg0KPiA+ID4gPiBPbmx5IHdoZW4geW91IHdhbnQgdG8gYWNjb3VudCB0aGUgdG90
YWwgRVBDIHBhZ2VzIHZpYSBzb21lIGxpc3QgeW91DQo+ID4gPiA+IF9wcm9iYWJseV8NCj4gPiA+
ID4gbmVlZCB0byB0cmFjayBWQSBhcyB3ZWxsLiAgQnV0IEkgYW0gbm90IHF1aXRlIHN1cmUgYWJv
dXQgdGhpcyBlaXRoZXIuDQo+ID4gPiANCj4gPiA+IFRoZXJlIGlzIGEgY2FzZSB3aGVyZSBldmVu
IFNFQ1MgaXMgcGFnZWQgb3V0IGZvciBhbiBlbmNsYXZlIHdpdGggYWxsDQo+ID4gPiByZWNsYWlt
YWJsZXMgb3V0Lg0KPiA+IA0KPiA+IFllcy4gIEJ1dCB0aGlzIGVzc2VudGlhbGx5IG1lYW5zIHRo
ZXNlIGVuY2xhdmVzIGFyZSBub3QgYWN0aXZlLCB0aHVzICANCj4gPiBzaG91bGRuJ3QNCj4gPiBi
ZSB0aGUgdmljdGltIG9mIE9PTT8NCj4gPiANCj4gDQo+IEJ1dCB0aGVyZSBhcmUgVkEgcGFnZXMg
Zm9yIHRoZSBlbmNsYXZlIGF0IHRoYXQgbW9tZW50LiBTbyBpdCBjYW4gYmUgIA0KPiBjYW5kaWRh
dGUgZm9yIE9PTSB2aWN0aW0uDQoNClllcy4gIEkgYW0gbm90IGZhbWlsaWFyIHdpdGggaG93IGRv
ZXMgT09NIGNob29zZSB2aWN0aW0sIGJ1dCBpdCBzZWVtcyBjaG9vc2luZw0KaW5hY3RpdmUgZW5j
bGF2ZXMgc2VlbXMgbW9yZSByZWFzb25hYmxlLg0KDQoNClsuLi5dDQoNCj4gPiA+IFRoZXJlIHdl
cmUgc29tZSBkaXNjdXNzaW9uIG9uIHBhZ2luZyBvdXQgVkFzIHdpdGhvdXQga2lsbGluZyBlbmNs
YXZlcyAgDQo+ID4gPiBidXQNCj4gPiA+IGl0J2QgYmUgY29tcGxpY2F0ZWQgYW5kIG5vdCBpbXBs
ZW1lbnRlZCB5ZXQuDQo+ID4gDQo+ID4gTm8gd2UgZG9uJ3QgaW52b2x2ZSBzd2FwcGluZyBWQSBw
YWdlcyBub3cuICBJdCdzIGEgc2VwYXJhdGUgdG9waWMuDQo+ID4gDQo+IE9ubHkgbWVudGlvbmVk
IGl0IGFzIGEga2luZCBvZiBjb25zdHJhaW50cyBpbXBhY3RpbmcgY3VycmVudCBkZXNpZ24uDQo+
IA0KPiBBbm90aGVyIHBvdGVudGlhbCBhbHRlcm5hdGl2ZTogd2UgZG9uJ3QgcmVjbGFpbSBTRUNT
IGVpdGhlciB1bnRpbCBPT00gYW5kICANCj4gb25seSB0cmFjayBTRUNTIHBhZ2VzIGZvciBjZ3Jv
dXBzLiBCdXQgdGhhdCB3b3VsZCBjaGFuZ2UgY3VycmVudCBiZWhhdmlvci4gIA0KPiBBbmQgSSdt
IG5vdCBzdXJlIGFib3V0IG90aGVyIGNvbnNlcXVlbmNlcywgZS5nLiwgZW5jbGF2ZXMgdGhlb3Jl
dGljYWxseSAgDQo+IGNhbiBhbGxvY2F0ZSBwYWdlcyAoaW5jbHVkaW5nIFZBIHBhZ2VzKSBpbiBk
aWZmZXJlbnQgY2dyb3Vwcy9wcm9jZXNzZXMsIHNvICANCj4gd2UgbWF5IHN0aWxsIGVuZCB1cCB0
cmFja2luZyBhbGwgVkEgcGFnZXMgZm9yIGNncm91cHMgb3Igd2UgdHJhY2sgU0VDUyAgDQo+IHBh
Z2UgaW4gYWxsIGNncm91cHMgaW4gd2hpY2ggZW5jbGF2ZSBhbGxvY2F0ZWQgYW55IHBhZ2VzLiBM
ZXQgbWUga25vdyB5b3VyICANCj4gdGhvdWdodHMuDQoNCkxldCdzIG5vdCBjaGFuZ2UgY3VycmVu
dCBiZWhhdmlvdXIuICBJIHNlcmlvdXNseSBkb3VidCB0aGF0IGlzIG5lZWRlZC4NCg0KU28gaXQg
c2VlbXMgdG8gbWUgdGhhdCB3aGF0IHdlIG5lZWQgaXMganVzdCBzb21lIHdheSB0byBsZXQgdGhl
IE9PTSBmaW5kIHNvbWUNCnZpY3RpbSBlbmNsYXZlLiAgSSBhbSBub3Qgc3VyZSB3aGV0aGVyICJ0
cmFja2luZyBFUEMgcGFnZXMgaW4gc29tZSBsaXN0cyIgaGFzDQphbnl0aGluZyB0byBkbyB3aXRo
IGNncm91cCBhY2NvdW50aW5nIEVQQyBwYWdlcywgc28gd2lsbCB0YWtlIGEgbG9vayB0aGUgcmVz
dCBvZg0KdGhlIHBhdGNoZXMuDQoNCg0K
