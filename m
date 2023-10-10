Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB77BEF99
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379141AbjJJARD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379150AbjJJARC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:17:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBA9F;
        Mon,  9 Oct 2023 17:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696897020; x=1728433020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7mmp4fmRFGpeKILcLGb7WfQ9+552twfuq4o8eLZIENY=;
  b=QMXKAtYlSYjzHxQkboxqdxmcb9+J/UMSEFVfpKg7dxID6wjSRoM/nDSC
   Xs8DgA5fsxQgBSqyqy7GPIVLxG/mbtMFHdNG6i8WqK/pG/w7D459dZk/O
   6TMZPZkhVo/DPswr6gwadkmFGa+WzxR46k5HVzNEtEK8sMCByyqvzNPuL
   hyxZFIvRQCYSjsc/cpXBTR+OB6hZPwPGwiBW1XFBLmG6ESdXEBMtmk4F0
   LB/IDmLVYwb05raSrSLlLS/HrpMGDyMvI82wkV1Ma90iLxIZFNDpbsakJ
   jLZRLuGLZ2+2xR7Q5BmE0qVIJ5Vn0deZfvznPrO7gJSPdftBL2hO+a3/G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="383154750"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="383154750"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="746860980"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="746860980"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 17:16:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:16:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 17:16:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 17:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWSoD9ycd4s7zv/31u96TrNEo6AVHWplNO1H/9NzFIz93vjtpKj9U3cmOsbW2FWkdPGb3XseVUy9z1FGGHQ3dLj07vJApbGvXphXq04EegCriGMPtNo2LLGtlTtzBGHGJG6jXh5YWVXdWCVO2ymLFNBCX7tTordOHb5Sey2GA8gN+5taAD7shUGMxpQKDB1lbfXx0rmBNL5gcWoga46EIFwRu4tTyHHjwc2dhviFOjcYVBHVZaLXnY7iiBTgAmdmNk7ff+VyDYx6cglCy6jVIuPLgNoX1tg87PhwDtdYbmG9VHpo8EasrF3tMCUIMH/p7mkwYfqHirRAKoLxtt1Qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mmp4fmRFGpeKILcLGb7WfQ9+552twfuq4o8eLZIENY=;
 b=h68aY+GWDCaejwdKQ9awIWSCwzzy31/li3F7CwHEiGG/7xaYH/e7m7fFc38UaQ5skmfc6wBzlrYscgHpuSvkIzM040CKFFCjMgFuMmJ7GjRmLABS6jMy4Uy7us0XoEHdNLJhZQDW4S8CWh+gkKZC+ak/zRd0CKStINWr6cVg3ZFtgUMZ12OZ1w+c5Q8wqMnAql/7fXLpOXkNaIf07/l3alx/NlkccEPgZq5SmOx3Hr/jef9XXY9a8DndLjIXRrlBHpZSdh/6jCQ92pW/xHsJ2BMwOlFbU2dgUtiE7sGPkfyhuTwqYxs4YNzdtF9K6IYEDbVJaOBYF/3wtVSHTEaQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 00:16:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 00:16:42 +0000
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
Subject: Re: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Topic: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Index: AQHZ7csxMWGpeN5dZUG6Wyp0ITB+SrBCQnqA
Date:   Tue, 10 Oct 2023 00:16:42 +0000
Message-ID: <203734ff98ca09048647d0542434e840e65743ab.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-17-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-17-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7679:EE_
x-ms-office365-filtering-correlation-id: 308e03ae-e5b4-4cab-45e5-08dbc9262e54
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtPAihTQz4cqUEMxiLPd/oJYrjeKMtHBMk++0J3LkxpaxSEa+BFFBvNpD8/EJoW/+J37HdmUaZv69nPZCwvuBOz5WG88hjtNyfTcjSWzvYdnHI5t1Kn1hlUg5KfRemixjpaVS6LlL57Cdsbp6s8h/nHGqhANSOE0NKJet3iaiKdD1lKWSsH6riv+N3Vz7nv1WETqR79s5w/iFREw6mJxj82R3/GD2xRmDBD3x5r2PZAoXAzH1vQVHY/h2dWRC639dKMiRZbXgA3cocWTB+3Rh818PDtz/+zM6HwWOeKKs4wXOUEOySMNOQ/51ZCCdB8oC2eZK/NpYny68t81bZb/paHaWikMVHrjW84ij/1j2OiZPn1z4x3xWbkFEYi56VQYstlfJ60kxUUqDOKNcoax5tmWxZSRR7f9G8RTuDdlb00+W79C8SuauFO8ztCYKrVX/PoT5p0sSa/XH8fYd+q1io6eqvs0oho7L+Gi2xEIY8tNrkakmCcpOXLvt3VjlT2lNeV6zsR50PkPlpUFj5rZOa4awIPEdVvLrAoabgHt9UvJSNTcOWcsjwNTnD0M68N3UcXl89uISo0aLP+I6oba7WhzPXVWuuyCyuHGmertZ8eQQxspYfLbwy1gqqwxGwcn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(26005)(2616005)(6512007)(8676002)(7416002)(4744005)(478600001)(6506007)(2906002)(4326008)(54906003)(110136005)(66946007)(66556008)(66446008)(91956017)(64756008)(66476007)(6486002)(5660300002)(8936002)(316002)(76116006)(41300700001)(38100700002)(82960400001)(921005)(122000001)(36756003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZpTWFjWmVmcmoyQjVzM3RQaEJ6YTdyS21MZ2Y0Y2p4NDAzTFo3aVBKWVg1?=
 =?utf-8?B?dTZPTHN4dG5mMFVKbDlBWmpDUTQwT3IyZG02czVaTUdWVmtWMjNCMU1vTkFn?=
 =?utf-8?B?OTNJWThQOFduYzIwd3NFRU5kQ0NxT2J5UWZwaWc3SmoxdmVmUURNd2swVUQw?=
 =?utf-8?B?bzN2RkdMQ2xxNDNYaERtV1V2Z2sxWnlWaW9ldVEwV3RYQlRPa3pHOXk0N2pZ?=
 =?utf-8?B?ZlRoS0VIZlJ4ZDAxMDgyU3ExcFhDM0ZOSFpCZWVDMUNoZGducmpVY3BtcnpU?=
 =?utf-8?B?eEl2aHdHcCtneGU0RnFKQnI2YkRiWEFhaW1SK2p2S3BwWWFuVkNodWN3VUZJ?=
 =?utf-8?B?N2lNOWJJMS9OUjkzZ3JKVFhmT0ZMUWFCMVhja0VpcFJ2a2NRZ0syRWhYeHRT?=
 =?utf-8?B?R0hENVdDZnRja2hidmVWcUFKOFRwMi9zWTllbDJBYWZzOHdicE4raThYeE1L?=
 =?utf-8?B?RzdUU0tBT1NwYVBSYlFoZnZGL0k3OUZaTHViMytBa1Z3MnRMTkt4R3BzZG9v?=
 =?utf-8?B?VHdTNkVlR0szRHlKamVXbGgrNHNReE1lSjA0WnRGTHBLUXZsRzhJem9wYllp?=
 =?utf-8?B?L0ZWc3pkeTBrZzI2bXdrbWFLZno3bDhYODNFN01xaFB3c1dsME1IUnE4SVFE?=
 =?utf-8?B?VGZYTURSZXZSRGsxOGpVWnpNbnBxdlBoSnd6YUVZb0dhMDRZYkpublRCVFBq?=
 =?utf-8?B?ZXdzMVNtb1B2Lzh6NU1sOFhHd1RINUdWU1dDa1RCT1hFc2o4TVhkbkZxT0xI?=
 =?utf-8?B?S3k2TCtONnptTzFLdUZrZ0hvV2NoWWtsQ0tsMk5HTVlQbENHTytvZU8xS1dZ?=
 =?utf-8?B?ditHSEc5K20wU0g3Uk5Ba1lxRXV3QTFPcE81RmwwYjFiOFN1KzMwQXZ6QSt2?=
 =?utf-8?B?VU9xYmZwV3JRWUswZEhEa21nY3BXcjIzT1Q3eXpmYkExVEFnZFpNVzBza1kx?=
 =?utf-8?B?Z0t6WUFVTklEcFdhRCtyNXRmM3MrUDZ0V05RWnM2QkpkaW5UUnFwZTJ2d0x4?=
 =?utf-8?B?M2Jlc0x6aXVQaU9iaklFOVF5NmJIdHBPQWtPWlg1ZG1pcHpzd25WQ1Y1dzJ1?=
 =?utf-8?B?N2lWV3NqeXE0UUk2SEd5RVJZRjEwMWhmTXFJNW9WRFlTUEJjTE4xQTZ6MnU1?=
 =?utf-8?B?dnU2MHQ5bFppSXQ0V1lJeElzY3dkYjViYWdPOGtWRFNTbnNsdG9jd1UwczBQ?=
 =?utf-8?B?YktuUVVVV21HbFlYQXRDaDR5TWMycldJakpiZmM5VmVqQW5KalByLzZoYnpp?=
 =?utf-8?B?QS9LRTdFREVYZDJwWjU3ZEoyWVZ5bDJONG5XVWtNRWREdlFEdUVZczArVmxu?=
 =?utf-8?B?MnUzSnovTzF2b3psWnVWcmZVOVZKR29hb3hkZU1kMjA5cVdYWXgxcThvRTVG?=
 =?utf-8?B?T0s2TDROOXBEelEwc0NuOHJ1Vk1OQlZGeWZzNDQwY2RXYTViYkJFTmJmV3pl?=
 =?utf-8?B?MzFHcndWa0Y0R1B5UmVPaDdQSXhLUGRTRm9teC9aMVpBUW81bTZDTWEvS2Fj?=
 =?utf-8?B?bTBtcHVwWm95YnJWdWlhSWdyQ0lKNVhVN1ZmS1hvUzRFanhlT2dUKzEzSFYv?=
 =?utf-8?B?dTd3ODNVc2JQZStIdTJITTV4Q3VRbjdweDkzbloyTytKN2lhSEZxWGYrenBM?=
 =?utf-8?B?TStZeDlzVEh5bTloc1JWa0lBZmt0cThnelJqQkw5c3FMZ0RPaFlkc0xZTXdD?=
 =?utf-8?B?VkdvMTl6bDJmQ1VJelQwNmcvbWh5V3R6MVdONEFQY1lrL2Z4K21iU3dYd08z?=
 =?utf-8?B?NXdYZ01FKzZITlF0TmZKWndyWUFzYnlGWUl1eHRDaTJ2TDRPZEtqL0JqU3ZZ?=
 =?utf-8?B?c2VaTkRDc2d0MjVsYnUwdWh1Ym9OMmRaTTJqV2lhbjkvK0krbjFQYTh1a2pX?=
 =?utf-8?B?T1JVVjlPUlE2V1QzTU9vaHN4MHp2aEJvanVhOGpQeURaT0hhdU95VU5TYjZU?=
 =?utf-8?B?OUVKVlRra2kxWncxSHFSbHZoeFRrTCtPdTRqaGhBcDhJR2laMzV2OFplaldG?=
 =?utf-8?B?QkZUTm9zRi9YS09GRFNjRm1PcmNDVDk0VXFjamh3a3JGaVpsQ2dZTitLRmxh?=
 =?utf-8?B?MldUK0VHalRWSVorc1VWV0hMMi8wc1pWV1ZSeXhuR3VIRzRMamtQaWZOdEpD?=
 =?utf-8?B?U3ZjdDQ1SkZPSDdLbjB0eVYrajNNbURFcWZGREF2clhQOEZWTC83Wk5VY3FW?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E42E5E7662F85F4D9D1578F7C62FBAE1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308e03ae-e5b4-4cab-45e5-08dbc9262e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 00:16:42.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9BkMECnYb1LYBk0Cbmt9JSHGs66c7qqXoD2X8DHsd+Ow8pMbcBDs3yx2S05MO/PGgjFnzUDg+vEdQmvgfkxlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
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

DQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBzZ3hfZXBjX2xydV9saXN0cyAqZXBjX2NnX2xydShz
dHJ1Y3Qgc2d4X2VwY19jZ3JvdXAgKmVwY19jZykNCj4gK3sNCj4gKwlpZiAoZXBjX2NnKQ0KPiAr
CQlyZXR1cm4gJmVwY19jZy0+bHJ1Ow0KPiArCXJldHVybiBOVUxMOw0KPiArfQ0KPiANCg0KSXQn
cyBsZWdhbCB0byByZXR1cm4gTlVMTCBFUEMgY2dyb3VwIGZvciBhIGdpdmVuIEVQQyBwYWdlLCBp
LmUuLCB3aGVuIHRoZQ0KZW5jbGF2ZSBpc24ndCBhc3NpZ25lZCB0byBhbnkgY2dyb3VwLiAgQnV0
IC4uLg0KDQo+ICANCj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IHNneF9lcGNfbHJ1X2xpc3RzICpz
Z3hfbHJ1X2xpc3RzKHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKmVwY19wYWdlKQ0KPiAgew0KPiArCWlm
IChJU19FTkFCTEVEKENPTkZJR19DR1JPVVBfU0dYX0VQQykpDQo+ICsJCXJldHVybiBlcGNfY2df
bHJ1KGVwY19wYWdlLT5lcGNfY2cpOw0KPiArDQo+ICAJcmV0dXJuICZzZ3hfZ2xvYmFsX2xydTsN
Cj4gIH0NCg0KLi4uIGhlcmUgaXMgaXQgbGVnYWwgdG8gcmV0dXJuIGEgTlVMTCBMUlUgbGlzdD8N
Cg0KSXQgYXBwZWFycyB5b3UgYWx3YXlzIHdhbnQgdG8gcmV0dXJuIGEgdmFsaWQgTFJVIGxpc3Qu
ICBUaGF0IGlzLCBpZiBFUEMgY2dyb3VwDQppcyBlbmFibGVkLCBhbmQgd2hlbiB0aGUgRVBDIHBh
Z2UgZG9lc24ndCBiZWxvbmcgdG8gYW55IGNncm91cCwgdGhlbiB5b3Ugd2FudCB0bw0KcmV0dXJu
IHRoZSBzZ3hfZ2xvYmFsX2xydSA/DQoNCg==
