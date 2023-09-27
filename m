Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005A7AFFBA
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjI0JVF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 05:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjI0JVD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 05:21:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D356AD6;
        Wed, 27 Sep 2023 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695806461; x=1727342461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S6QOzVRq1PTNWFlm0qoxRV04gqxKlA3P39HBooVm2kY=;
  b=C9p/c/ek89whQMhSypuyusAZhGkQyjlAog8mobVQFEEFlQRvBVv6kf6F
   ROEC4eQa2DPNFslgFg8EMsgD5fsHr+m5xpWpFeGnBraAYX62cXK4H51yM
   mca+VrilD/z2sbwjRjMhUP1kHZl4575m6TWCsN6uJrLVAKKo1trSRs+ni
   j+qZmslS/TvwcW/oFJnsFA6jQhIbVst5mjT7S05GS4jaL8wpHjR7bE3s0
   lmeVxYLyvwr6j9djMefOvWbuvKArF+wkOCLMjzKBCHy4Y1hi5eS8ZxS10
   +CDvBtJ4PdDcRwodyEmgM6pxhNTW3Salgu9uR0/Pq7c5ymkrJvTgcE20D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412690963"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412690963"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 02:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1080069523"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1080069523"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 02:20:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 02:20:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 02:20:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 02:20:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 02:20:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKys1cYIdH5AHmLh+M1TSy9ZS+Iphn19b7kggJF/YWMaBcVJ+Wv99x7D+ZAL3Q2uqlAhWcQVrZBQafYJRCXw97tmh/MO1rZ5UuFaNnlI7kse0hzlgzuaDVWzfpM13GGAPtnB2qq6cxC9O9iRCUAMCxd98+GKgAvWv2h5GAQ3u8PlEkocgwDWlj+gKuhjJIYyg/TtYIgrLt8/XJEN4Dw9PLIUD+KIUabhjytrSeZ6k4PWF4IfXnWqr1NrLvUEAfZ14ri4VxdlsB4lR30wilvkqAnCZbH9tXBp0T4NNEcAUlCJV5uyEzpdgUhCrwCMel39MHVJOV+0rAUHjbWAkMadVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6QOzVRq1PTNWFlm0qoxRV04gqxKlA3P39HBooVm2kY=;
 b=JmtjGGc1fKdbSiiWKWdQTi5SZnIvfW0mytiNvAN2+t3LJkxfehikgCUJhT0ftn0TADK2FnI3vXjK/YYaBp4ONKXhG2EJCivBr6aIL9nzaJMKNR/d00EZ6DkUOzvL3zqB+e1pJy60jpvl4KjVpDRerVfwt7SavO3nQD3iE+udAXptXDplVDOSOl5MrgSr0h/g0aqbkwfTHBEgspgbC/5O6PS4oOExjjin48h/k6n3sX717ewufCKlPCbp5VGpaDoxLGMUeh1kCHYfXhGe9cjwNd/V00/LwdB1RG8VOnFiF/TIVgQCBUDpij8mpovXUfF7QTFOZiw+DC14tfQLtfGJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 09:20:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 09:20:55 +0000
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
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
Thread-Topic: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
Thread-Index: AQHZ7csLgUp1FdJvLEmGgG47BlLSl7AubDsA
Date:   Wed, 27 Sep 2023 09:20:55 +0000
Message-ID: <8f08f0b0f2b04b90d7cdb7b628f16f9080687c43.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-2-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-2-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8573:EE_
x-ms-office365-filtering-correlation-id: 7bbac0b7-c6e6-4818-44b8-08dbbf3b0dd8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akdKnngAQypLyjeV8I0uDUx3DtXGR+1hoy09wjIvQZDVr9vP+ixBXsdak1vk1WaLLZK8Nm2XEz4Q6n0j2HBzDfPI0S46S2c/nq4uy7zp62QdPujsAgZCgxVp7dEX2izjk67NTqpkeL0aFthmRIKjtAehD+Tq9yoMHgYdBeelNXgSptS6ET+XXaHQ4AwxfRlgfKsDblYNIwbOniZ+QSG2pZyI81CDY0AwQJzpD/bJ+DgVWRd4/MtrhcW/jzTFr0fSE07gr9TCExmmcfgSee1dnjCWfebckE8b0QwIM3F0Q2C3G3/aCs5sjfgpiaxorrrcsg019dvrjf45w0a2JJkyZSRcVsNCJGM0b4bKc5Ni+hR6vdkoRd/MGx9uX8HSarxwz9ARGbz9P+OAqPjTwxbejw5BG0pdmLu149mhraDTqxTuaswq0bKeH+DuOaEAHiWVmxV0Zz8ifpAkK+oSJI9H48jkubMrFEIIzlaE3XVD3kWyApZDTakCGvyK2FrqvBrXGa2lazHp5Jw7Vm2+iFZDB+Q5+JvepqPXAeBO8r+r8bCbK8N4kXLWpyxobe9wlSCThGCLnT0DBiP5YiwfcoBzCXono0JsxHZi7+qw/zLTh5862BpjNA+cMe5euw0oWF/nHh0TtilPZraJ256aeuoKuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(36756003)(86362001)(8936002)(921005)(6486002)(38070700005)(71200400001)(8676002)(2906002)(82960400001)(122000001)(38100700002)(4326008)(76116006)(110136005)(6512007)(66446008)(41300700001)(66556008)(83380400001)(26005)(5660300002)(2616005)(64756008)(66476007)(6506007)(66946007)(7416002)(478600001)(316002)(54906003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlQwL0JWRGhhR2dsaG9ndDE5andnd24yN2JXSTRXZkpoTWd3d0RnUjF6Qjkw?=
 =?utf-8?B?WHIxeWljemdSM3NKNW1qeHpJUTByNUU4bWRqVXVvZDRiek5YbzdFOHZNb25z?=
 =?utf-8?B?ZXU4cythS1FMVzNjWER0UElVN0ExcXF2SmJzcm1VOTFLNk9oTjkzZGp4M3Ny?=
 =?utf-8?B?aHNxUnRPeEpMWlB3STIxby9EVU5DbG1ZZFJSTFN3biszRm1FODBYK3NRS0Jh?=
 =?utf-8?B?dHpRbHlpdW5oSTNTb0FLeW5Ba1dBWWlHVVM3SmtvQXRvN3ZKUHdubEtJS1Zx?=
 =?utf-8?B?SnZQNGlqYkpoZ3R6d21WazhiTGFQTVNZaU81R2x1ODlVZ0pqenJrRy9CNGN5?=
 =?utf-8?B?Q2pEdFh1SjRWN2owMzV4bzdOcXZNVnNlVkZMdDgvMmVvWlMxSjVHZlBkWFFO?=
 =?utf-8?B?clh5MlFKcEo3dFpWdGdjUXpBMUt2dUd1WmlIN253ZUdJaWc0R0FiNy9iVVJD?=
 =?utf-8?B?WlMwYk9BUWNwUTlFalFaclNUa21ac09nd3FITVRCbFF5ZGpQbWhMQUN2S0xu?=
 =?utf-8?B?VjlTMUsxNWcvWFlxUWdKUWxaOFAvZ0xEV3hjSU83eC9BTCtEcWxRd3Y4eFdp?=
 =?utf-8?B?ZHpQelFlaTI1Z25XU0ZwMS9zRU9SenhoVkpUaU1WbG1lQytWOThCQWc4TEN3?=
 =?utf-8?B?YXZmRktWd1FMYWdiVWp4UTdZaVJYcjFUaXB6SnFZcWZQNVhYcXJOU3ZzTFo0?=
 =?utf-8?B?UUdaS2dwakxRMWtHSFoxSHMwaU9VTnlFK2ZkTzVEMVhJUHNseFVXRVFFbm05?=
 =?utf-8?B?UTM4ZWZlTEtNUmZYL1ZhejR5T213NzRWcm5tdUVobFdpTU5VWEEwblhnd0hO?=
 =?utf-8?B?RVpwNEJkcER2dGZScXY0dVdxSDhaeGNocWplMFhwaXdjL2lGMUtxajR6VzRY?=
 =?utf-8?B?MVd4MkN5a3psUUVWS0VxSGljZ3Z1aU4zTXo1cnFqbXI3SWRZdlgxN2l5Um02?=
 =?utf-8?B?NHQwYmZqNmVkYktkRUVoc3prakhQdVRwQ0QxWXhLVUhsWjBNWTRUOEZlTFdY?=
 =?utf-8?B?R2Y0SGJQODVuZDcyRTJYUDdlazgwZjkvRlhUekQwV1dqR3EyK3JieWxONW9V?=
 =?utf-8?B?V1M2UFh3RFZWZm9WanQwRm16dHRvKzhEd2tvNGFYaTJCNVhYVGw2MHI4ckM1?=
 =?utf-8?B?Rk1LdG1YYlZ4cWVLcFl0ZzZCNThjdExQbkNwK2pwcDFQVjhEdGd5M0RWbGNG?=
 =?utf-8?B?eHNKRjNFQ0ZabnNFd0VTdkplQmtlTWxXZHdYNTdMcVFMZDFIS25MOWovZHMw?=
 =?utf-8?B?a3BtVVpmSDZ3ZDUrZVRheG1BamN6Qnp5VTA5M1NJcFRhQ2FUWnFOTmp2ZUhv?=
 =?utf-8?B?OUNHVVFqM2dQUzNnNjJGajcxOHdUR2ZuUVJ5RlJmazd4VkdVSDVuUDZnZzVq?=
 =?utf-8?B?ejFSZ3BkRThMS2tXWXBzSUVJTDhUKzB0OC9NOWxqcFhZb2dwT1NJQXIxT3dv?=
 =?utf-8?B?aU1qT0tONkFVTWNIRWpvcTYwWnN2dEtNSE54Vzc4MFlEYU1idlhpV1psbVpv?=
 =?utf-8?B?MWdURThYZHpjL1dqMW9GZkpjY2JaQTNCaXVCM3JEWEE1N0E4Nmk2Z1J3Tkpv?=
 =?utf-8?B?U3FJTW9KbE91YmlXRmtGdUp0eFY3YlBNN3dTQkNiSGE2SWRJU0xXSE5ZakV0?=
 =?utf-8?B?ckY1eFFPaG90QXlZZElYN0t2VnZ5dks0T0xPTHQ4K3pJOHVwOUREOVg2ZGZu?=
 =?utf-8?B?RGx1b0VVeHlLZjRDOXF6NjY0bVhpbnF1UEFHVU5RNTJpSUM0ZHE1NlFGRWlt?=
 =?utf-8?B?a3FOZVZVbi9YbHFzeVk4N2V4YmJGN3QwUzI0TzVkWThtRHV1WThJOXBsMTl3?=
 =?utf-8?B?dlhIZTA3Tno1Mk1DdksvR1RKSnI0WEM5T0ZIbjNsem9BRlliaHdIZzQ2UzNp?=
 =?utf-8?B?a1hObFZ6RnhMMGJRMGhNUmFreGlMeHEyZkYyRVY5UzlCcWpKVEVnYWpXOXpC?=
 =?utf-8?B?cGtQc3loSE1wQXU0VGhwRVJURkgrek9JVkJlekVlRzQvelczMVVSNUt1M0pm?=
 =?utf-8?B?Q0ZBUThaYThkZVZYYzhWdCtqQ3c4WHdlVElYT2xzU2RhZGxXNWZSZ3VIZUpt?=
 =?utf-8?B?d3VxSXUwd1pROU9TczRTNDNIZlMvMnczQ2VITGJYQ1FscnlVbktlUnhKMURa?=
 =?utf-8?B?ZDlkQldob1creHdGeTFsOVdnQVpJRnZuZnNjU2N5d1dOOWlaRWVxRSs5NzM5?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42AE0FD477FC33439C918692DDB9C796@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbac0b7-c6e6-4818-44b8-08dbbf3b0dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:20:55.8803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MGjXWFgrqX8AIxWDU44sjjpeedxub2s8oehb/Fin2jbjKQzlg1jIpFAo6CRwqQdiqNxksXhAwLB4WBAKxtJwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFRoZSBtaXNjIGNncm91cCBjb250cm9sbGVyIChzdWJzeXN0ZW0pIGN1cnJlbnRseSBk
b2VzIG5vdCBwZXJmb3JtDQo+IHJlc291cmNlIHR5cGUgc3BlY2lmaWMgYWN0aW9uIGZvciBDZ3Jv
dXBzIFN1YnN5c3RlbSBTdGF0ZSAoQ1NTKSBldmVudHM6DQo+IHRoZSAnY3NzX2FsbG9jJyBldmVu
dCB3aGVuIGEgY2dyb3VwIGlzIGNyZWF0ZWQgYW5kIHRoZSAnY3NzX2ZyZWUnIGV2ZW50DQo+IHdo
ZW4gYSBjZ3JvdXAgaXMgZGVzdHJveWVkLCBvciBpbiBldmVudCBvZiB1c2VyIHdyaXRpbmcgdGhl
IG1heCB2YWx1ZSB0bw0KPiB0aGUgbWlzYy5tYXggZmlsZSB0byBzZXQgdGhlIHVzYWdlIGxpbWl0
IG9mIGEgc3BlY2lmaWMgcmVzb3VyY2UNCj4gW2FkbWluLWd1aWRlL2Nncm91cC12Mi5yc3QsIDUt
OS4gTWlzY10uDQo+IA0KPiBEZWZpbmUgY2FsbGJhY2tzIGZvciB0aG9zZSBldmVudHMgYW5kIGFs
bG93IHJlc291cmNlIHByb3ZpZGVycyB0bw0KPiByZWdpc3RlciB0aGUgY2FsbGJhY2tzIHBlciBy
ZXNvdXJjZSB0eXBlIGFzIG5lZWRlZC4gVGhpcyB3aWxsIGJlDQo+IHV0aWxpemVkIGxhdGVyIGJ5
IHRoZSBFUEMgbWlzYyBjZ3JvdXAgc3VwcG9ydCBpbXBsZW1lbnRlZCBpbiB0aGUgU0dYDQo+IGRy
aXZlcjoNCj4gLSBPbiBjc3NfYWxsb2MsIGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIG5lY2Vzc2Fy
eSBzdHJ1Y3R1cmVzIGZvciBFUEMNCj4gcmVjbGFpbWluZywgZS5nLiwgTFJVIGxpc3QsIHdvcmsg
cXVldWUsIGV0Yy4NCj4gLSBPbiBjc3NfZnJlZSwgY2xlYW51cCBhbmQgZnJlZSB0aG9zZSBzdHJ1
Y3R1cmVzIGNyZWF0ZWQgaW4gYWxsb2MuDQo+IC0gT24gbWF4X3dyaXRlLCB0cmlnZ2VyIEVQQyBy
ZWNsYWltaW5nIGlmIHRoZSBuZXcgbGltaXQgaXMgYXQgb3IgYmVsb3cNCj4gY3VycmVudCB1c2Fn
ZS4NCg0KTml0Og0KDQpXb25kZXJpbmcgd2h5IHdlIHNob3VsZCB0cmlnZ2VyIEVQQyByZWNsYWlt
aW5nIGlmIHRoZSBuZXcgbGltaXQgaXMgKmF0KiBjdXJyZW50DQp1c2FnZT8NCg0KSSBhY3R1YWxs
eSBkb24ndCBxdWl0ZSBjYXJlIGFib3V0IHdoeSBoZXJlLCBidXQgd3JpdGluZyB0aGVzZSBkZXRh
aWxzIGluIHRoZQ0KY2hhbmdlbG9nIG1heSBicmluZyB1bm5lY2Vzc2FyeSBjb25mdXNpb24uICBJ
IGd1ZXNzIHlvdSBjYW4ganVzdCByZW1vdmUgYWxsIHRoZQ0KZGV0YWlscyBhYm91dCB3aGF0IFNH
WCBkcml2ZXIgbmVlZHMgdG8gZG8gb24gdGhlc2UgY2FsbGJhY2tzLg0KDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVs
LmNvbT4NCj4gLS0tDQo+IFY1Og0KPiAtIFJlbW92ZSBwcmVmaXhlcyBmcm9tIHRoZSBjYWxsYmFj
ayBuYW1lcyAodGopDQo+IC0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlIChKYXJra28pDQo+IA0KPiBW
NDoNCj4gLSBNb3ZlZCB0aGlzIHRvIHRoZSBmcm9udCBvZiB0aGUgc2VyaWVzLg0KPiAtIEFwcGxp
ZXMgb24gY2dyb3VwL2Zvci02LjYgd2l0aCB0aGUgb3ZlcmZsb3cgZml4IGZvciBtaXNjLg0KPiAN
Cj4gVjM6DQo+IC0gUmVtb3ZlZCB0aGUgcmVsZWFzZWQoKSBjYWxsYmFjaw0KPiAtLS0NCj4gIGlu
Y2x1ZGUvbGludXgvbWlzY19jZ3JvdXAuaCB8ICA1ICsrKysrDQo+ICBrZXJuZWwvY2dyb3VwL21p
c2MuYyAgICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWlzY19jZ3JvdXAuaCBiL2luY2x1ZGUvbGludXgvbWlz
Y19jZ3JvdXAuaA0KPiBpbmRleCBlNzk5YjFmOGQwNWIuLjk2YTg4ODIyODE1YSAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9saW51eC9taXNjX2Nncm91cC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgv
bWlzY19jZ3JvdXAuaA0KPiBAQCAtMzcsNiArMzcsMTEgQEAgc3RydWN0IG1pc2NfcmVzIHsNCj4g
IAl1NjQgbWF4Ow0KPiAgCWF0b21pYzY0X3QgdXNhZ2U7DQo+ICAJYXRvbWljNjRfdCBldmVudHM7
DQo+ICsNCj4gKwkvKiBwZXIgcmVzb3VyY2UgY2FsbGJhY2sgb3BzICovDQoNCk5pdDoNCg0KVGhp
cyBjb21tZW50IGlzbid0IHF1aXRlIHVzZWZ1bCBJTUhPLiAgQW5kIGl0IHNlZW1zIHlvdSBzaG91
bGQganVzdCBleHBhbmQgdGhlDQpleGlzdGluZyBjb21tZW50IGZvciB0aGUgJ3N0cnVjdCBtaXNj
X3JlcycsIHdoaWNoIGFscmVhZHkgY292ZXJzIHRoZSBleGlzdGluZw0KbWVtYmVycy4NCg0KT3Ig
YXMgSmFya2tvIHN1Z2dlc3RlZCwgbWF5YmUgeW91IGNhbiBpbnRyb2R1Y2UgYW5vdGhlciBzdHJ1
Y3R1cmUgJ21pc2NfcmVzX29wcycNCmFuZCBjb21tZW50IG1vcmUgZGV0YWlscyBmb3IgYWxsIHRo
ZXNlIGNhbGxiYWNrcyBqdXN0IGxpa2UgJ3N0cnVjdCBtaXNjX3JlcycuDQoNCkFueXdheSBpdCdz
IGNncm91cCBtYWludGFpbmVyJ3MgY2FsbC4NCg0KPiArCWludCAoKmFsbG9jKShzdHJ1Y3QgbWlz
Y19jZyAqY2cpOw0KPiArCXZvaWQgKCpmcmVlKShzdHJ1Y3QgbWlzY19jZyAqY2cpOw0KPiArCXZv
aWQgKCptYXhfd3JpdGUpKHN0cnVjdCBtaXNjX2NnICpjZyk7DQo+ICB9Ow0KPiAgDQo+ICAvKioN
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jZ3JvdXAvbWlzYy5jIGIva2VybmVsL2Nncm91cC9taXNj
LmMNCj4gaW5kZXggNzlhMzcxN2E1ODAzLi42MmM5MTk4ZGVlMjEgMTAwNjQ0DQo+IC0tLSBhL2tl
cm5lbC9jZ3JvdXAvbWlzYy5jDQo+ICsrKyBiL2tlcm5lbC9jZ3JvdXAvbWlzYy5jDQo+IEBAIC0y
NzYsMTAgKzI3NiwxMyBAQCBzdGF0aWMgc3NpemVfdCBtaXNjX2NnX21heF93cml0ZShzdHJ1Y3Qg
a2VybmZzX29wZW5fZmlsZSAqb2YsIGNoYXIgKmJ1ZiwNCj4gIA0KPiAgCWNnID0gY3NzX21pc2Mo
b2ZfY3NzKG9mKSk7DQo+ICANCj4gLQlpZiAoUkVBRF9PTkNFKG1pc2NfcmVzX2NhcGFjaXR5W3R5
cGVdKSkNCj4gKwlpZiAoUkVBRF9PTkNFKG1pc2NfcmVzX2NhcGFjaXR5W3R5cGVdKSkgew0KPiAg
CQlXUklURV9PTkNFKGNnLT5yZXNbdHlwZV0ubWF4LCBtYXgpOw0KPiAtCWVsc2UNCj4gKwkJaWYg
KGNnLT5yZXNbdHlwZV0ubWF4X3dyaXRlKQ0KPiArCQkJY2ctPnJlc1t0eXBlXS5tYXhfd3JpdGUo
Y2cpOw0KPiArCX0gZWxzZSB7DQo+ICAJCXJldCA9IC1FSU5WQUw7DQo+ICsJfQ0KPiAgDQo+ICAJ
cmV0dXJuIHJldCA/IHJldCA6IG5ieXRlczsNCj4gIH0NCj4gQEAgLTM4MywyMyArMzg2LDM5IEBA
IHN0YXRpYyBzdHJ1Y3QgY2Z0eXBlIG1pc2NfY2dfZmlsZXNbXSA9IHsNCj4gIHN0YXRpYyBzdHJ1
Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqDQo+ICBtaXNjX2NnX2FsbG9jKHN0cnVjdCBjZ3JvdXBf
c3Vic3lzX3N0YXRlICpwYXJlbnRfY3NzKQ0KPiAgew0KPiArCXN0cnVjdCBtaXNjX2NnICpwYXJl
bnRfY2c7DQoNCk5pdDogDQoNClRoZSBiZWxvdyB2YXJpYWJsZSAnKmNnJyBjYW4gYmUgbW92ZWQg
aGVyZSB0b2dldGhlciB3aXRoICdwYXJlbnRfY2cnLg0KIA0KPiAgCWVudW0gbWlzY19yZXNfdHlw
ZSBpOw0KPiAgCXN0cnVjdCBtaXNjX2NnICpjZzsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+ICAJaWYg
KCFwYXJlbnRfY3NzKSB7DQo+ICAJCWNnID0gJnJvb3RfY2c7DQo+ICsJCXBhcmVudF9jZyA9ICZy
b290X2NnOw0KDQpOaXQ6DQoJCXBhcmVudF9jZyA9IGNnID0gJnJvb3RfY2c7DQo/DQoNCj4gIAl9
IGVsc2Ugew0KPiAgCQljZyA9IGt6YWxsb2Moc2l6ZW9mKCpjZyksIEdGUF9LRVJORUwpOw0KPiAg
CQlpZiAoIWNnKQ0KPiAgCQkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ICsJCXBhcmVudF9j
ZyA9IGNzc19taXNjKHBhcmVudF9jc3MpOw0KPiAgCX0NCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkg
PCBNSVNDX0NHX1JFU19UWVBFUzsgaSsrKSB7DQo+ICAJCVdSSVRFX09OQ0UoY2ctPnJlc1tpXS5t
YXgsIE1BWF9OVU0pOw0KPiAgCQlhdG9taWM2NF9zZXQoJmNnLT5yZXNbaV0udXNhZ2UsIDApOw0K
PiArCQlpZiAocGFyZW50X2NnLT5yZXNbaV0uYWxsb2MpIHsNCj4gKwkJCXJldCA9IHBhcmVudF9j
Zy0+cmVzW2ldLmFsbG9jKGNnKTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJZ290byBhbGxvY19l
cnI7DQo+ICsJCX0NCj4gIAl9DQo+ICANCj4gIAlyZXR1cm4gJmNnLT5jc3M7DQo+ICsNCj4gK2Fs
bG9jX2VycjoNCj4gKwlmb3IgKGkgPSAwOyBpIDwgTUlTQ19DR19SRVNfVFlQRVM7IGkrKykNCj4g
KwkJaWYgKHBhcmVudF9jZy0+cmVzW2ldLmZyZWUpDQo+ICsJCQljZy0+cmVzW2ldLmZyZWUoY2cp
Ow0KPiArCWtmcmVlKGNnKTsNCj4gKwlyZXR1cm4gRVJSX1BUUihyZXQpOw0KPiAgfQ0KPiAgDQo+
ICAvKioNCj4gQEAgLTQxMCw3ICs0MjksMTQgQEAgbWlzY19jZ19hbGxvYyhzdHJ1Y3QgY2dyb3Vw
X3N1YnN5c19zdGF0ZSAqcGFyZW50X2NzcykNCj4gICAqLw0KPiAgc3RhdGljIHZvaWQgbWlzY19j
Z19mcmVlKHN0cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRlICpjc3MpDQo+ICB7DQo+IC0Ja2ZyZWUo
Y3NzX21pc2MoY3NzKSk7DQo+ICsJc3RydWN0IG1pc2NfY2cgKmNnID0gY3NzX21pc2MoY3NzKTsN
Cj4gKwllbnVtIG1pc2NfcmVzX3R5cGUgaTsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBNSVND
X0NHX1JFU19UWVBFUzsgaSsrKQ0KPiArCQlpZiAoY2ctPnJlc1tpXS5mcmVlKQ0KPiArCQkJY2ct
PnJlc1tpXS5mcmVlKGNnKTsNCj4gKw0KPiArCWtmcmVlKGNnKTsNCj4gIH0NCj4gIA0KPiAgLyog
Q2dyb3VwIGNvbnRyb2xsZXIgY2FsbGJhY2tzICovDQoNCg==
