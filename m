Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938277BEF8B
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379152AbjJJAM0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379115AbjJJAMZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:12:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F69DAF;
        Mon,  9 Oct 2023 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696896743; x=1728432743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L9DdWs1dLevR1JvFZJgEf2uOOmTpHjYS3Eo/AY2fRJc=;
  b=IKD1HCAt853luWfdWdF3ndInSJlMDg07D9593AfiMfmO/f/Dtl3ZXW+B
   tDHRJqnqHgfMsRDpvP1jIYWBPZNJzAJh69Alj/87JLUYvIInqfHc8/P19
   4o9ALSNBMxRTL27PIB9NLNG1P782TKUjnjDfjeC4xDyJ1D5LJO99nzHvt
   Zo3JsX8+gaZdr3mVzaVSZpUgN0rG42kiCvZbKgatvV3YuiwoiZY/EfnAK
   a6D+eY/MVXxyiW16MHxo8hCE7nbhilld95vRxb84L8sVnI76alYD3znLO
   I6fH9mcE6eMtDYyzdMe8ZKXWKeoAqIXgx5cwH7LR4KrzzsJLuGjVHA6Ou
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374620778"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="374620778"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084529084"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1084529084"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 17:12:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:12:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 17:12:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 17:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBhnUi1icyXPcQ8rT5wpQxCdHuXLEwMDQuWmL4Xv4lUPtULC72MsKevuwEuHuwCaUbbOx9CcUmnHPWnyqujcBE/SECXQKJRD26FNoLz6161w8l2cEOg1HTrMUFVKpzRwksdwF4Gvu8l4ki+Dn7IjXn4ECDkc5yOY6OFkBrNwqwnp/Eqz5vFp6PCcV8vL8hHqTLahy86P2N23OaKysuw7sujWVAmpChrBSstNadfFNzdDRtoTK9C8s+GURiQx3DGjrOypsUxjohrpMsW9yp35IApzFPXToIYFNMVrwGu3rclfA4tDy14J08yLdCseI0LqgGxe2xZPMOa3W1sTSesYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9DdWs1dLevR1JvFZJgEf2uOOmTpHjYS3Eo/AY2fRJc=;
 b=ApPB+qKttpVGs+L74eVDfz2h+N38CQ1zbnbDlWy+lKqTvDp3DdJ2xS6tKjGMWb+W8u96a+r45HiF9D/FpYB+vXPxmbylvx0ebiXMUwrPFr2EKtg5wobbkMDDjVZehLudwqhAlbBasJlIdWxBYi1+hYRmqcS+opgdsfGxmKv51m+fi74Gxo+XpVyEzOxct7bUQ1VE5b+deRU0pzdiuBlL1r25yppXVV13+QeK3/HwTJoSWMRJem2wvdi69jdylqLrmJOBZb0yDYaDQ0+H3SKiyNCDBjUb8L+wJMSOzFNfPjpHw36FJ5WLSCtb1rM9pCbQx2N43TbqjUW6gHIBdS9v0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 00:12:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 00:12:13 +0000
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
Thread-Index: AQHZ7csxMWGpeN5dZUG6Wyp0ITB+SrBCQTiA
Date:   Tue, 10 Oct 2023 00:12:13 +0000
Message-ID: <676610f1d7f264a72cfbd5597015fec49a599616.camel@intel.com>
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
x-ms-office365-filtering-correlation-id: dcd40355-4290-4e21-e7b2-08dbc9258e2b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLA9rJjuzdJYOsgKIVF1BWN7lj2WzedolS1VfrCtFDTZcHitKrjynnRSFWKdjZF1j2sdgHp9jqJvNr+mXnOo0Mcx61CjVf83nGUSFRUSfixYX3efGx4Rgl8cGGggeyG++UEzmV80u19zUn62e5+NfcyE7LWRATT3X4OakI762lVTj4K8L8TLIeFoZdOSx68ks6PijoqQodSV6uCeC+FvUQ9T90NuOxp8AeMrx8LIl5XmMx7nPDoaLPRl2vovsv6ihYUwKROI7vLpt/TMoqKQROFv6YPB99k/xlwdW14Swt87z6zxopFZi/IdFSnFKXG+k/pEoMc8yNpgiHZKtZeYLww7mUWslYnPaKctZMEN3rbtGOcadqlsHIVes7wPly44aeRK0Np0ukpGH3I9NKdeJJo4WffXHATC2+cuCrepkZuBFce7KIsUbJGVN9dEPTdTk3jDrg9PQdAgCWcQ2Sr6+fSoMr4Zd2jpDrCq6UVjpj5knbEAmErVei3ijbexFcxS1CNGTG1yzEtq8rCHLulL+dhPviRSHrP/LlUBIvAMhI82OmqjZTXPNBdpYOa93oP5k8h24hO4yjxIHRjqGf0kH6scjo0YP95l2MEMQivZStUN2rgfeMfHUlow1FxqNiD1ww/zAL3wIRJkXxk7VUC8HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(26005)(2616005)(6512007)(8676002)(7416002)(478600001)(6506007)(2906002)(4326008)(83380400001)(54906003)(110136005)(66946007)(66556008)(66446008)(91956017)(64756008)(66476007)(6486002)(5660300002)(8936002)(316002)(76116006)(41300700001)(38100700002)(82960400001)(921005)(122000001)(36756003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEpKVHBRUERlMEJJb1lndk9hSXY5S0U2dFhpVUJ2Z3B4WnNPVTI0N055b0J5?=
 =?utf-8?B?NWhKbTJtYUpNRlZ4YWpGZ2pobFF4b1pOcHhRelh1R3NvUlYwV1MvNHJUYVBs?=
 =?utf-8?B?NW9RRUlIb2lvZUFrc2hpTVNmUGliNWhUL1ZCeWdoZlFFdEpNM2FOc0tOTnhj?=
 =?utf-8?B?SkFwclBKNmlHNklrUGFvc1ppNCt1WHZ6enZyRkhhUDZlZEkxbkdUYmZiN25U?=
 =?utf-8?B?ajI5TVdURnkzV1l4YUtnOWxzTi9WRzMxallXbGp1eW0vNVVieUJRQk9jcU1Q?=
 =?utf-8?B?c3BQY1pkYWRiSmhjRFdIdVM2SktVem9rdGFLaHRIYy94NkwxakZPOGtqcEt6?=
 =?utf-8?B?c0NQaFowSGY1T2FZTWlaam1HeFZNcHJwVlVJdU5NT1lhb3lzL1p6SGJCeGc0?=
 =?utf-8?B?SE5pdmFhclVQNTFBWnpFbytwUFJlWnZMRS9seDBiWXA4K1FKcWZXOEdEcG9s?=
 =?utf-8?B?TFZGMUlxdHBsdkhCWG0zTGptWlBmeFI3TWdhc0I2S2tObjNqVFFJVERUY3ZN?=
 =?utf-8?B?c25JcTRUdVZKblZDS21BVnF1cjV5c0huQjVrVWQyRjFDY2MyekNCUjZlSHpk?=
 =?utf-8?B?TVZoZ09URm1TT3BwdDdVbWt3eGJPbVZoQnlNSktoblB5Q3N1cHlGaXRiNS9R?=
 =?utf-8?B?N1NWZ0VTcTByZXd0cUhlNmtKQ0pTdm1zdXJUbmZYRjhXZjhNRFdRN0ZLb0RH?=
 =?utf-8?B?UWh6cDdkNE5SZDZKaVhhNktiOWhsbnFFeXpwWmpPMHhUTDkwUStyRjFMNkFH?=
 =?utf-8?B?dC9ic25iOHZlMmt1SGxYbC91emU4UFdkWGh0bGlBQ2w2VkhITVFrNEk3Tmhr?=
 =?utf-8?B?UGZPUHU0azQ0c1lWcVdYWFVTQ2VWcGh3bmlGbnh4U1ZyaEhVZ3JnQzl5ZnRI?=
 =?utf-8?B?enpNRm4weW9BZHp2aFJYYjZvWDlpZlV6SVorNWFlTVpPV2cwYzlTeXI1K3Vn?=
 =?utf-8?B?bVBXbzdaa2NydlRQZFMzajhZYWl2ZjdySEJIQkJadWNCNk1Eb3hmOFJPRVF6?=
 =?utf-8?B?clk1YlNsdk9wdkxIYmNPZHZ5TWJ3em5DQi9uRDVoaytJSzc1aVorYWh6S1B5?=
 =?utf-8?B?NnR2NVpXVG4xbml4TnpDQlJJWGlPWEJJZHYvY1Ywd3c0U1o4enFUV3NYWXdN?=
 =?utf-8?B?b2JBMmM5clVHWEpWU1RuN3F3Tk85alU5UjdFYzBLdG01UWdDOFl4S0Q1NXdB?=
 =?utf-8?B?bkZ1VFBYdlpSTFZ5R25zTjY4MUxid1lxVVlOdzFmS3VQQkJkMG94K25FeDZz?=
 =?utf-8?B?WVdzR1Y5alp1NUxhSkhidEVpZDUwMTlwLzVxbXVWcXV5UHRlRjRVTmp5YUFs?=
 =?utf-8?B?VklaRUVlMmE5TGlxTU90SkdjbW1RSW94NHRxb1VjWUlRTVBWRERMczZPU2F4?=
 =?utf-8?B?ckQ3Y01langwWVhLMzV4SGFnSW5RWE1uNXRTcXFrci9hUXF2anhxVFVKTGlq?=
 =?utf-8?B?MCtpNlhhVHdzNWs0clhrVmdiZFJlejEyclN2SzJITnUrOGpNSTFvajVSbzZO?=
 =?utf-8?B?UHFzaEJTRFF5UHlneE5salg3Ly9LQzN5eUJLUjVXai9wVzBPUFpTNEp6ekpH?=
 =?utf-8?B?SGlmOEx1TWhsa1ZOUlBGaS9KUThDaDZjeDAwREhXUk9nMUJMMDdndm5acE9Y?=
 =?utf-8?B?RUlXTGFOWDJobGZXdzFvN0JOZUVHTDZaN1cwUUZGVS9LVkdGQXdGNkkrc0Zi?=
 =?utf-8?B?dGhLL0o0cGwyM003eGI1VzJjbTZ5YnpTL3o0SDc4VkNDYzdGNGpvdlhWM0hO?=
 =?utf-8?B?ODJvNmNhUllMb1E1QXBMS2dya1lPWXpnekhRNGcrNzhNZ3RldmtSSk80K3hp?=
 =?utf-8?B?UFFGK0s3OVUxMzFDaFlMT2VzenRVU2tQZkhHNlhidUU1REZtS0NjZEF0R1Jo?=
 =?utf-8?B?QlFrMHNMbm9PRTZuZmRid2ZFNFhkVUJYT1d5NG1aenhzQTBaQmxVRG9YdXhq?=
 =?utf-8?B?aGZiVXl1SDNvNWZMRmtQU2duVTBjdWFjbW00RFZnYjJMdnRXMEloaHJneVpN?=
 =?utf-8?B?MDMyWFU0T0ZSZUYwZXM5V1poUWZoQTJ4dlJ3QlZQZnc4UWNWRTBTV1VoL203?=
 =?utf-8?B?ZjZzeDV3T3IrdUxVNUFVenlWdENLS3J5SndhazFlN3podmpRa1p0RjJmdU1K?=
 =?utf-8?B?YnhlSnJDQUFPT3IzVUczQWhXUHlXSERpR3dZWkRpajBMaWZoRCsyRUtjZVhi?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FF81A99CFAACE4780CEC077CBBA446B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd40355-4290-4e21-e7b2-08dbc9258e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 00:12:13.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jyg82zIIDDKE9Xty6dLg+HBmfiPgfzR9wQa/lZIa2pD+pT7/fPX7AUTboU5gGRZeiVg+gENoU19yuD36tlADqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+ICsvKioNCj4gKyAqIHNneF9lcGNfY2dyb3VwX2xydV9lbXB0eSgpIC0gY2hlY2sgaWYgYSBj
Z3JvdXAgdHJlZSBoYXMgbm8gcGFnZXMgb24gaXRzIGxydXMNCj4gKyAqIEByb290Oglyb290IG9m
IHRoZSB0cmVlIHRvIGNoZWNrDQo+ICsgKg0KPiArICogUmV0dXJuOiAldHJ1ZSBpZiBhbGwgY2dy
b3VwcyB1bmRlciB0aGUgc3BlY2lmaWVkIHJvb3QgaGF2ZSBlbXB0eSBMUlUgbGlzdHMuDQo+ICsg
KiBVc2VkIHRvIGF2b2lkIGxpdmVsb2NrcyBkdWUgdG8gYSBjZ3JvdXAgaGF2aW5nIGEgbm9uLXpl
cm8gY2hhcmdlIGNvdW50IGJ1dA0KPiArICogbm8gcGFnZXMgb24gaXRzIExSVXMsIGUuZy4gZHVl
IHRvIGEgZGVhZCBlbmNsYXZlIHdhaXRpbmcgdG8gYmUgcmVsZWFzZWQgb3INCj4gKyAqIGJlY2F1
c2UgYWxsIHBhZ2VzIGluIHRoZSBjZ3JvdXAgYXJlIHVucmVjbGFpbWFibGUuDQo+ICsgKi8NCj4g
K2Jvb2wgc2d4X2VwY19jZ3JvdXBfbHJ1X2VtcHR5KHN0cnVjdCBzZ3hfZXBjX2Nncm91cCAqcm9v
dCkNCj4gK3sNCj4gKwlzdHJ1Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqY3NzX3Jvb3Q7DQo+ICsJ
c3RydWN0IGNncm91cF9zdWJzeXNfc3RhdGUgKnBvczsNCj4gKwlzdHJ1Y3Qgc2d4X2VwY19jZ3Jv
dXAgKmVwY19jZzsNCj4gKwlib29sIHJldCA9IHRydWU7DQo+ICsNCj4gKwkvKg0KPiArCSAqIENh
bGxlciBlbnN1cmUgY3NzX3Jvb3QgcmVmIGFjcXVpcmVkDQo+ICsJICovDQo+ICsJY3NzX3Jvb3Qg
PSByb290ID8gJnJvb3QtPmNnLT5jc3MgOiAmKG1pc2NfY2dfcm9vdCgpLT5jc3MpOw0KPiArDQo+
ICsJcmN1X3JlYWRfbG9jaygpOw0KPiArCWNzc19mb3JfZWFjaF9kZXNjZW5kYW50X3ByZShwb3Ms
IGNzc19yb290KSB7DQo+ICsJCWlmICghY3NzX3RyeWdldChwb3MpKQ0KPiArCQkJYnJlYWs7DQo+
ICsNCj4gKwkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ICsNCj4gKwkJZXBjX2NnID0gc2d4X2VwY19j
Z3JvdXBfZnJvbV9taXNjX2NnKGNzc19taXNjKHBvcykpOw0KPiArDQo+ICsJCXNwaW5fbG9jaygm
ZXBjX2NnLT5scnUubG9jayk7DQo+ICsJCXJldCA9IGxpc3RfZW1wdHkoJmVwY19jZy0+bHJ1LnJl
Y2xhaW1hYmxlKTsNCj4gKwkJc3Bpbl91bmxvY2soJmVwY19jZy0+bHJ1LmxvY2spOw0KPiArDQo+
ICsJCXJjdV9yZWFkX2xvY2soKTsNCj4gKwkJY3NzX3B1dChwb3MpOw0KPiArCQlpZiAoIXJldCkN
Cj4gKwkJCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCXJjdV9yZWFkX3VubG9jaygpOw0KPiArDQo+
ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gDQoNClsuLi5dDQoNCj4gDQo+ICBzdGF0aWMgaW5saW5l
IGJvb2wgc2d4X2Nhbl9yZWNsYWltKHZvaWQpDQo+ICB7DQo+ICsJaWYgKElTX0VOQUJMRUQoQ09O
RklHX0NHUk9VUF9TR1hfRVBDKSkNCj4gKwkJcmV0dXJuICFzZ3hfZXBjX2Nncm91cF9scnVfZW1w
dHkoTlVMTCk7DQo+ICsNCg0KSXMgaXQgYmV0dGVyIHRvIGtlZXAgYSByb290IHNneF9lcGNfY2dy
b3VwIGFuZCBwYXNzIHRoZSByb290IGluc3RlYWQgb2YgTlVMTD8NCg0KPiAgCXJldHVybiAhbGlz
dF9lbXB0eSgmc2d4X2dsb2JhbF9scnUucmVjbGFpbWFibGUpOw0KPiAgfQ0KPiAgDQo=
