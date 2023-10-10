Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8477BF05A
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 03:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379346AbjJJBer (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 21:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379278AbjJJBep (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 21:34:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E68F;
        Mon,  9 Oct 2023 18:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696901683; x=1728437683;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=794BHWMj+EomrOXNAX3+peIKmuvRZ4CeeRrF1l7sJiE=;
  b=Dm19asFzbc75MGlPQSRbtP1zL5IW+xGH9GNsAxi9ik69NMdRozzEYPD/
   N9pA71wG0H0V/vARe5ZZAe4jCbKSBKLf9Zb9wSvHeCocPyJyCU2fitF/t
   /aAwI8f/CBXx5qd5wGtigDCv//N0diNciSf/vn6dKleeq1nKzxjvAxN9K
   8xhx868LVuxSC5Wqx7f5cV8gMJbzHjnTEWhknXPRw/m66bMv4av/GJaFL
   felP2HqkCpXdzrwPirOy35btutHqXLqFMej0nW1DqvyRzcl8I6cCwqa30
   miqUuORXJSBsBpgOZuW7i5jSWz2Elo3HQ5FBweBUCghSvpo90+HOzjp4v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364582256"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="364582256"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 18:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="756915468"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="756915468"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 18:34:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 18:34:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 18:34:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 18:34:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 18:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRJ/00vp8i5FxGlorrthvWej4Goib2L4QPspKbqq/4deP5sROT9hDcb3vZuankbqG1Dki+WSYPFwmbJ3a1RzFFOuNwRkDAZcIlb6wY0NxGUkbOujgK25th1nPPu9Hrs4dXi7vFgcVEchrfxha5FJReF0shY6eY1VkTghZJHtqdOp/4Hu+oA40UPiQYMfJKGAMApK+z3vkhp2fVCewN9WuWrQOpQwKVLB/VwWIcAau4K7gdYgmSzlV5+FkC3VRSiQyfS+4KZtS8NTbtsB9BasWic7qYw/o4wqPeOpm2N/MDDiCt8FQ5KpiEpMMgBjYGCh0T49UqCwIdPBHRb9n79Ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=794BHWMj+EomrOXNAX3+peIKmuvRZ4CeeRrF1l7sJiE=;
 b=mjjISipJitZsgo4DZ+jp02FDEDCUdzaTzg45oxizH1G5AQnhlfkM6frg88mModuzCMpn0r/nSc+tgwI+A5s7elPc9RtC5gg4tglMUbr7B9gGK/rrkdeHI3cMzGPa23yq7joSuQPeB5V073Ma0lw739EvWl1yQydhyohKyBWbxQbOCwo7DZr9VZar+cV9nEOOHbEEBTUqk4L42rrtXFzwjmxDOv0RN9TwT3USxAZCzeMCwvc6oW6H4YHL6hti0+PvooonNIv3sp/2DLXgztGDAdnAYNA/s13+KyTAFuqXgHOzDmfDbnd6BrHKQV3YeBKTcfqb34zn1PHx5Ozyjxxicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB5331.namprd11.prod.outlook.com (2603:10b6:610:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 01:34:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 01:34:29 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgIAADEaA
Date:   Tue, 10 Oct 2023 01:34:29 +0000
Message-ID: <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
         <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
In-Reply-To: <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB5331:EE_
x-ms-office365-filtering-correlation-id: 6158214c-bd10-4e18-cb4d-08dbc9310c33
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpRKVVoj13JLGmAILERKKqSNx/c5goQWJfR2V023FwPEo7kyb7tinNJykeU1RD3b3mKZPz8n7qAe14bBeev3bHnEasQMXTXrOIj+7k+ZWGe50/M9F7TyBBvUTIoPKO/Tz2lZMqzdQZQAZ9gjLe//g8qkyLMyLy91anmEeZ/S2QzFqGNdNpT5FC9KLGgwicEXQtBysMol2lmFDzMbyQqUUPiTM0OHfmiH1tNJ7qna2j500g4Vs98UiZiFDb9yZTDHf6AcHbz6i95TtCjzKEseJ9WOvoN40Ra+rQ7nb9Jf3iVCkLYJ5l2e6uDoByYgWDv8ArNBR99A46LibWW8i9An+C8wkbdBNHCUPUi+CUGDhzfj34HjwC8l1s+dOqrMhAr+zplqI7hXRpbdIoS+iYjqPFF6SFj+riPaDDHgJqHdbmm38eblbGfSRk4Up83RXMpCJDV8IeucdRrvZyMmLoPyQcH8zyoXjXwUCFnQp4ynfnEeLlcJNGYa82OpM8g2Dp1mgVjF3Tsni84hp2DLaQ7srxAS5jfNn9kUT43st0wj/K9i6zZL0v+dr4VHUFVqP5UsOIKcbrAwJC2X6C/8wqvIGX7gttdf526Srcu/RRdER+PYNinAxOx67dDf2QlQZBcb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(2616005)(6506007)(478600001)(41300700001)(2906002)(83380400001)(6486002)(4001150100001)(7416002)(71200400001)(66446008)(91956017)(76116006)(66946007)(66476007)(5660300002)(54906003)(66556008)(6916009)(64756008)(8676002)(4326008)(8936002)(26005)(36756003)(122000001)(316002)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWF3cjZJNXQrUXI1WSswdC9Nd2s3QlZSOURTc0RRTTRYVFNPclRHVk5RNmdi?=
 =?utf-8?B?RVA1aVpEK1J1WHVvZVlRUTlJcVdlNmhpV1JsRjBKN3c1cEc4eDRmT1o0Q3FL?=
 =?utf-8?B?S05oMFdUcHIzVk8yWG1zNnI3NjVmclpEWEVHdEdXcldaVVdTSlQ4em5nUTFU?=
 =?utf-8?B?WFlpSzU4MjI5Qit3c3VQWUxDZlRxUDdjWWZCb1lDSVd4RmdHUzErb25Nc3Uz?=
 =?utf-8?B?UzJvcDBVQTc0Y09zTkF5OXRkYWprWTl6aXlhb3Fja2ZXZTdBVU8wcW9RWTJ6?=
 =?utf-8?B?VGxFa3hnalVMM2VzdTdpS0pCWXNYVERWS01EZWF0Nks4Y3dtK01JN3JRREpk?=
 =?utf-8?B?RC9NejR1U3hieDR3OC9sTGJ5d3lMYW9Xa0hPdlZiZytnU3lLWTJiUTZMTDhH?=
 =?utf-8?B?YTdrZ2F0N2UwbU9SV3VRNjdRZjFYZzhSNDV2NklleGRYNmpnMERLUGw1V09a?=
 =?utf-8?B?NGdoWDg5UndtcFVDSHRPM0hOUWJuZWNpaFRXUlZTUFYxeWZsaFZKN09ZN00z?=
 =?utf-8?B?VVNSdjdzRjkyUGRIQ3piZUpYdkxlcVJwcDlzRkJ4UUxnUXlib29IQ2pibDlY?=
 =?utf-8?B?NldsS2pTTmsyNEFSblBmMy9NUithTDEvVjF2SUFzOEZOK0J3MHhPT3VjQzdK?=
 =?utf-8?B?QTQrWDM2dWQzYW4rcUdrOW5CbmJiWXkrbFhsdFN5OTZuTHg4eE4wWHNrL1pl?=
 =?utf-8?B?bk5DdnpiRkFTcFlkQ25Tem9SRm5xdS8wOFg5cC9FRE4wOFVrSitTMFpEZ3B4?=
 =?utf-8?B?NEFabzFKYVQ0Vjc3Nm84RDl1czVNYnpYajEvZUJ3ZWRWMUtkeWF1OUFVcFBW?=
 =?utf-8?B?cit3L09Fb0lGcUxMMjRhaTVseGZhcFRUOTR2cnpvRXl3Ymk1MFFXZ24xWVMy?=
 =?utf-8?B?Q2x6eTBjWnhXaVY5ZUMvMWV3WmRUeEo4M2RqNEMvQm0wMVA3SWlIb0c0aEFm?=
 =?utf-8?B?clZGd044dzZPSk96OTgvVFp2UzdxUy8vY0kvaFBMVW1KYm1jVmxwMVJLQmlq?=
 =?utf-8?B?RkdtQ3V3ZTVXM0Y5T2dFT3ZTc3BGbWlMellRZHREb1UvdVlCRm01SzFqektV?=
 =?utf-8?B?cVFnYVdIR3pMeVRqenhzWjlZRG5TZi9LNTg5dm85WDhSTTBrU01OaXZRTDFp?=
 =?utf-8?B?WHJERWl2VXdZSU05ZURzVll1eE5ic0VFZXpHMU1icHVDRVI4VVVnQTJhSFRV?=
 =?utf-8?B?R1FKcHhIeWwvSFZKUU5tek5IcXRwdU4rbDdrVTdxWkRTS0Y3RytHOUhmVUU3?=
 =?utf-8?B?TG1tVnA1T1BtbThjZ1dsMEc2M3UwWHRJNmJZMTBrY05yemt4RVdNZWFlY0pv?=
 =?utf-8?B?QlkzU2F6SUoyV3F1dDR1MlV1NzJZMk10SGpvQVh1T1FBOHFhZXFHbit1T3JM?=
 =?utf-8?B?UU14dGUyeTJvM2FuTmhHZlYvaFlPVkp4cjZHR2U2NStzTWJ3cGFrdEE0N0ti?=
 =?utf-8?B?NTF6UDM5ZGdkRHlhUy8vek5pSmdGK3lqTkJmV29oSnZOMng1UjZodnZHck4v?=
 =?utf-8?B?NTRrU3IzaEZsckhEVVoxdERWY2Z3eWh1K0ZDamZiMEJkL1NVNlBTMWo3anhM?=
 =?utf-8?B?d3JiLzhKdXRlbExsR1B3OFNjMzdQUzV6aHZKWE10bDlMQ3Y4QkVpbER3cTRr?=
 =?utf-8?B?TlhMbGNrYVh3VzgxeGlMUFhDenVYZXNWU0pKWnF4VEtFeUllMzIxczBDOGJl?=
 =?utf-8?B?WDB4SzZVc0pZUCtROVVKZmlOOFpaZWphK0p3Q1FTWWFKeGZDSmhwWWZjOFI4?=
 =?utf-8?B?Z1Z1QitPUi91Y21sd2JOQ3M3S2M2cjFoQ2VmR01naTkvb3hWZzdWd1BwaEpH?=
 =?utf-8?B?Y1hDYms3dmlQUStvYmZHV2x6MUMwUHpIQTcrK1d5cWJNbnhhcVlvZDFuTVB2?=
 =?utf-8?B?R1lVNGx5SStPZ0U3MkRidGlETHI5aDhVc3Q0bTFqTkdrMHhoWHBETDQ5cGFi?=
 =?utf-8?B?b0JjY3VMN2NobHlvTWJLeXVLTUJkVXlmUDF6bWM3VmNXeVVmcGhHS2cvVU40?=
 =?utf-8?B?UVMreXNBeld6OVk2Q2Y5TEwrUjlwT1RvME5ZZEdVT3hHUHJMZnpPTHE2SlZN?=
 =?utf-8?B?cjZoSnRmMWU3ckk5d0FnYVBGRkZNMTFJTldrNk5kbWRKb05QUkczemVPcjBO?=
 =?utf-8?B?TnZGRHNJVTZocmtxYWtBcU9iU0hKaDAvdHhxN0V5enNjd21PRE9VYmNtcEc3?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1784F0B2B5BB2F498181EF88B25D13C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6158214c-bd10-4e18-cb4d-08dbc9310c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 01:34:29.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eekh1WVX6n4UDKwFqyKpwdGItCOQZd9j6i8UzCHmRl4JZ7bFTigoMDtmbgkNDYKlxyOMae1qWMxlkItdroQxdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5331
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

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDAwOjUwICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBNb24sIDIwMjMtMTAtMDkgYXQgMTc6MjMgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3Jv
dGU6DQo+ID4gT24gTW9uLCBPY3QgMDksIDIwMjMsIEthaSBIdWFuZyB3cm90ZToNCj4gPiA+IE9u
IEZyaSwgMjAyMy0wOS0yMiBhdCAyMDowNiAtMDcwMCwgSGFpdGFvIEh1YW5nIHdyb3RlOg0KPiA+
ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBzZ3hfZXBjX29vbSgpIC0gaW52b2tlIEVQQyBvdXQtb2Yt
bWVtb3J5IGhhbmRsaW5nIG9uIHRhcmdldCBMUlUNCj4gPiA+ID4gKyAqIEBscnU6CUxSVSB0aGF0
IGlzIGxvdw0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFJldHVybjoJJXRydWUgaWYgYSB2aWN0
aW0gd2FzIGZvdW5kIGFuZCBraWNrZWQuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK2Jvb2wgc2d4
X2VwY19vb20oc3RydWN0IHNneF9lcGNfbHJ1X2xpc3RzICpscnUpDQo+ID4gPiA+ICt7DQo+ID4g
PiA+ICsJc3RydWN0IHNneF9lcGNfcGFnZSAqdmljdGltOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJ
c3Bpbl9sb2NrKCZscnUtPmxvY2spOw0KPiA+ID4gPiArCXZpY3RpbSA9IHNneF9vb21fZ2V0X3Zp
Y3RpbShscnUpOw0KPiA+ID4gPiArCXNwaW5fdW5sb2NrKCZscnUtPmxvY2spOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsJaWYgKCF2aWN0aW0pDQo+ID4gPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArCWlmICh2aWN0aW0tPmZsYWdzICYgU0dYX0VQQ19PV05FUl9QQUdFKQ0K
PiA+ID4gPiArCQlyZXR1cm4gc2d4X29vbV9lbmNsX3BhZ2UodmljdGltLT5lbmNsX3BhZ2UpOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKHZpY3RpbS0+ZmxhZ3MgJiBTR1hfRVBDX09XTkVSX0VO
Q0wpDQo+ID4gPiA+ICsJCXJldHVybiBzZ3hfb29tX2VuY2wodmljdGltLT5lbmNsKTsNCj4gPiA+
IA0KPiA+ID4gSSBoYXRlIHRvIGJyaW5nIHRoaXMgdXAsIGF0IGxlYXN0IGF0IHRoaXMgc3RhZ2Us
IGJ1dCBJIGFtIHdvbmRlcmluZyB3aHkgd2UgbmVlZA0KPiA+ID4gdG8gcHV0IFZBIGFuZCBTRUNT
IHBhZ2VzIHRvIHRoZSB1bnJlY2xhaW1hYmxlIGxpc3QsIGJ1dCBjYW5ub3Qga2VlcCBhbg0KPiA+
ID4gImVuY2xhdmVfbGlzdCIgaW5zdGVhZD8NCj4gPiANCj4gPiBUaGUgbW90aXZhdGlvbiBmb3Ig
dHJhY2tpbmcgRVBDIHBhZ2VzIGluc3RlYWQgb2YgZW5jbGF2ZXMgd2FzIHNvIHRoYXQgdGhlIEVQ
Qw0KPiA+IE9PTS1raWxsZXIgY291bGQgImtpbGwiIFZNcyBhcyB3ZWxsIGFzIGhvc3Qtb3duZWQg
ZW5jbGF2ZXMuIMKgDQo+ID4gDQo+IA0KPiBBaCB0aGlzIHNlZW1zIGEgZmFpciBhcmd1bWVudC4g
Oi0pDQo+IA0KPiA+IFRoZSB2aXJ0dWFsIEVQQyBjb2RlDQo+ID4gZGlkbid0IGFjdHVhbGx5IGtp
bGwgdGhlIFZNIHByb2Nlc3MsIGl0IGluc3RlYWQganVzdCBmcmVlZCBhbGwgb2YgdGhlIEVQQyBw
YWdlcw0KPiA+IGFuZCBhYnVzZWQgdGhlIFNHWCBhcmNoaXRlY3R1cmUgdG8gZWZmZWN0aXZlbHkg
bWFrZSB0aGUgZ3Vlc3QgcmVjcmVhdGUgYWxsIGl0cw0KPiA+IGVuY2xhdmVzIChJSVJDLCBRRU1V
IGRvZXMgdGhlIHNhbWUgdGhpbmcgdG8gInN1cHBvcnQiIGxpdmUgbWlncmF0aW9uKS4NCj4gDQo+
IEl0IHJldHVybnMgU0lHQlVTLiAgU0dYIFZNIGxpdmUgbWlncmF0aW9uIGFsc28gcmVxdWlyZXMg
ZW5vdWdoIEVQQyBiZWluZyBhYmxlIHRvDQo+IGJlIGFsbG9jYXRlZCBvbiB0aGUgZGVzdGluYXRp
b24gbWFjaGluZSB0byB3b3JrIEFGQUlDVC4NCj4gIA0KPiA+IA0KPiA+IExvb2tzIGxpa2UgeSdh
bGwgcHVudGVkIG9uIHRoYXQgd2l0aDoNCj4gPiANCj4gPiAgIFRoZSBFUEMgcGFnZXMgYWxsb2Nh
dGVkIGZvciBLVk0gZ3Vlc3RzIGJ5IHRoZSB2aXJ0dWFsIEVQQyBkcml2ZXIgYXJlIG5vdA0KPiA+
ICAgcmVjbGFpbWFibGUgYnkgdGhlIGhvc3Qga2VybmVsIFs1XS4gVGhlcmVmb3JlIHRoZXkgYXJl
IG5vdCB0cmFja2VkIGJ5IGFueQ0KPiA+ICAgTFJVIGxpc3RzIGZvciByZWNsYWltaW5nIHB1cnBv
c2VzIGluIHRoaXMgaW1wbGVtZW50YXRpb24sIGJ1dCB0aGV5IGFyZQ0KPiA+ICAgY2hhcmdlZCB0
b3dhcmQgdGhlIGNncm91cCBvZiB0aGUgdXNlciBwcm9jZXNzcyAoZS5nLiwgUUVNVSkgbGF1bmNo
aW5nIHRoZQ0KPiA+ICAgZ3Vlc3QuICBBbmQgd2hlbiB0aGUgY2dyb3VwIEVQQyB1c2FnZSByZWFj
aGVzIGl0cyBsaW1pdCwgdGhlIHZpcnR1YWwgRVBDDQo+ID4gICBkcml2ZXIgd2lsbCBzdG9wIGFs
bG9jYXRpbmcgbW9yZSBFUEMgZm9yIHRoZSBWTSwgYW5kIHJldHVybiBTSUdCVVMgdG8gdGhlDQo+
ID4gICB1c2VyIHByb2Nlc3Mgd2hpY2ggd291bGQgYWJvcnQgdGhlIFZNIGxhdW5jaC4NCj4gPiAN
Cj4gPiB3aGljaCBJTU8gaXMgYSBoYWNrLCB1bmxlc3MgcmV0dXJuaW5nIFNJR0JVUyBpcyBhY3R1
YWxseSBlbmZvcmNlZCBzb21laG93LiDCoA0KPiA+IA0KPiANCj4gImVuZm9yY2VkIiBkbyB5b3Ug
bWVhbj8NCj4gDQo+IEN1cnJlbnRseSB0aGUgc2d4X3ZlcGNfZmF1bHQoKSByZXR1cm5zIFZNX0ZB
VUxUX1NJR0JVUyB3aGVuIGl0IGNhbm5vdCBhbGxvY2F0ZQ0KPiBFUEMgcGFnZS4gIEFuZCB3aGVu
IHRoaXMgaGFwcGVucywgS1ZNIHJldHVybnMgS1ZNX1BGTl9FUlJfRkFVTFQgaW4gaHZhX3RvX3Bm
bigpLA0KPiB3aGljaCBldmVudHVhbGx5IHJlc3VsdHMgaW4gS1ZNIHJldHVybmluZyAtRUZBVUxU
IHRvIHVzZXJzcGFjZSBpbiB2Y3B1X3J1bigpLiANCj4gQW5kIFFlbXUgdGhlbiBraWxscyB0aGUg
Vk0gd2l0aCBzb21lIG5vbnNlbnNlIG1lc3NhZ2U6DQo+IA0KPiAgICAgICAgIGVycm9yOiBrdm0g
cnVuIGZhaWxlZCBCYWQgYWRkcmVzcw0KPiAgICAgICAgIDxkdW1wIGd1ZXN0IHJlZ2lzdGVycyBu
b25zZW5zZT4NCj4gDQo+ID4gUmVseWluZw0KPiA+IG9uIHVzZXJzcGFjZSB0byBiZSBraW5kIGVu
b3VnaCB0byBraWxsIGl0cyBWTXMga2luZGEgZGVmZWF0cyB0aGUgcHVycG9zZSBvZiBjZ3JvdXAN
Cj4gPiBlbmZvcmNlbWVudC4gIEUuZy4gaWYgdGhlIGhhcmQgbGltaXQgZm9yIGEgRVBDIGNncm91
cCBpcyBsb3dlcmVkLCB1c2Vyc3BhY2UgcnVubmluZw0KPiA+IGVuY2FsdmVzIGluIGEgVk0gY291
bGQgY29udGludWUgb24gYW5kIHJlZnVzZSB0byBnaXZlIHVwIGl0cyBFUEMsIGFuZCB0aHVzIHJ1
biBhYm92ZQ0KPiA+IGl0cyBsaW1pdCBpbiBwZXJwZXR1aXR5Lg0KPiANCj4gPiANCj4gPiBJIGNh
biBzZWUgdXNlcnNwYWNlIHdhbnRpbmcgdG8gZXhwbGljaXRseSB0ZXJtaW5hdGUgdGhlIFZNIGlu
c3RlYWQgb2YgInNpbGVudGx5Ig0KPiA+IHRoZSBWTSdzIGVuY2xhdmVzLCBidXQgdGhhdCBzZWVt
cyBsaWtlIGl0IHNob3VsZCBiZSBhIGtub2IgaW4gdGhlIHZpcnR1YWwgRVBDDQo+ID4gY29kZS4N
Cg0KSSBndWVzcyBJIHNsaWdodGx5IG1pc3VuZGVyc3Rvb2QgeW91ciB3b3Jkcy4NCg0KWW91IG1l
YW4gd2Ugd2FudCB0byBraWxsIFZNIHdoZW4gdGhlIGxpbWl0IGlzIHNldCB0byBiZSBsb3dlciB0
aGFuIHZpcnR1YWwgRVBDDQpzaXplLg0KDQpUaGlzIHBhdGNoIGFkZHMgU0dYX0VOQ0xfTk9fTUVN
T1JZLiAgSSBndWVzcyB3ZSBjYW4gdXNlIGl0IGZvciB2aXJ0dWFsIEVQQyB0b28/DQoNCkluIHRo
ZSBzZ3hfdmVwY19mYXVsdCgpLCB3ZSBjaGVjayB0aGlzIGZsYWcgYXQgZWFybHkgdGltZSBhbmQg
cmV0dXJuIFNJR0JVUyBpZg0KaXQgaXMgc2V0Lg0KDQpCdXQgdGhpcyBhbHNvIHJlcXVpcmVzIGtl
ZXBpbmcgdmlydHVhbCBFUEMgcGFnZXMgaW4gc29tZSBsaXN0LCBhbmQgaGFuZGxlcyB0aGVtDQpp
biBzZ3hfZXBjX29vbSgpIHRvby4NCg0KQW5kIGZvciB2aXJ0dWFsIEVQQyBwYWdlcywgSSBndWVz
cyB0aGUgInlvdW5nIiBsb2dpYyBjYW4gYmUgYXBwbGllZCB0aHVzDQpwcm9iYWJseSBpdCdzIGJl
dHRlciB0byBrZWVwIHRoZSBhY3R1YWwgdmlydHVhbCBFUEMgcGFnZXMgdG8gYSAoc2VwYXJhdGU/
KSBsaXN0DQppbnN0ZWFkIG9mIGtlZXBpbmcgdGhlIHZpcnR1YWwgRVBDIGluc3RhbmNlLg0KDQoJ
c3RydWN0IHNneF9lcGNfbHJ1IHsNCgkJc3RydWN0IGxpc3RfaGVhZCByZWNsYWltYWJsZTsNCgkJ
c3RydWN0IHNneF9lbmNsICplbmNsYXZlczsNCgkJc3RydWN0IGxpc3RfaGVhZCB2ZXBjX3BhZ2Vz
Ow0KCX0NCg0KT3Igc3RpbGwgdHJhY2tpbmcgVkEvU0VDUyBhbmQgdmlydHVhbCBFUEMgcGFnZXMg
aW4gYSBzaW5nbGUgdW5yZWNsaWFtYWJsZSBsaXN0Pw0KDQpJIGRvbid0IGtub3cgOi0pDQo=
