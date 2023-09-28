Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5457B115E
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 05:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjI1D7V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1D7U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 23:59:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA37BF;
        Wed, 27 Sep 2023 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695873558; x=1727409558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H2N2WfiMzll4Qu9p18xNx9NoXeJ1Zpi7CHa6UPp8Cwg=;
  b=n3eNTSAlah9uCR2f4PuCmYVLtgeH1sZlHvviSK6i5VkAPklWxNI2hLz3
   QPzJnLGRLhQWNMmzfvj4oZrDKDjwMjFLmkwx6c4n/GPXV/GM0pipu9wE9
   SGRMEE2XOdgC/ORIzy1cScjpz4b0aTp9hpHlyMATzQXjdUpEh71f/x3Ai
   ivSoqyhsFNhXWO2yqYrL5i3bRHFiplmtcYle7rhyV4OZsNqnUCHAlTE+3
   vPwCvLvAkqN1RZlr+Jt/EKPrPAQAlFOLE+gN7JALHQg0k4TAdi598RKqs
   j14NCqn3UWXrsS2vW66EWuN7QfvmIIfRtLFAV1fmUGZmWynJHpqolQmeb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="448473154"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="448473154"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 20:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="726089252"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="726089252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 20:59:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 20:59:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 20:59:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 20:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGwZR7IJwxJ9rXMpM+d2coYv0+cAOl3YDppaWokvN6Gh6deB9gsJgO+v+7piDxwFErL2mCHGEfxe2p95pivgpDzD01i/B+HH7saFeWX/BPs5CpTRLjyMWwwnOXWqDd7xPkqLgJz1A2uxaQfpAme8VjOdyBSWvLIHOBPc/7ZSn98PFxmAtJEbqU9b8b6p5QResMkKlHs2Ko4SkSDRnlNvz+O2ZrLBTZOmoQmBH6GbEIzVXgyDmN3r6JTrGNnp7fRpprYvaAMC5kKNeewL1UiPQIbVjc+AFqYRY46Sun6bFM1ELP8jpyRfuQDfYT0DqcRQfppDpW/1RinK0QVxsRnjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2N2WfiMzll4Qu9p18xNx9NoXeJ1Zpi7CHa6UPp8Cwg=;
 b=EAicc0Q9ul3Qvy1Ww8obIlZeUnrmSBKYtAZDEodbDUpbxY1pcd+a5DHKcBCBySuGS5ZOzvDeSQxHbUU1v7dTEaf0aVr43gAPcXHU9oU57Vmk/rZCII3go/MAL5WigmX0Q6+53Uj/tyaYs3w2UdSRpBvUa6i0oe+uMsoAVcsus3CsyPqv3mq2xSGVPC5Hh2zUC2dKbwl1CXSBkc2dzYqzr0Di4FUpfc+k4qegHG1b6vFN8iWrVzaC8CESw1/WwzTuEUKsDQZwDJkrKyEnQCF/rcWNibNk1ANt7daRzs2v3HXyFlA38p/Sy4R0NQhwcqgp3mYtbqWGKV4hYOsaO89ZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 03:59:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 03:59:12 +0000
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
Subject: Re: [PATCH v5 02/18] cgroup/misc: Add SGX EPC resource type and
 export APIs for SGX driver
Thread-Topic: [PATCH v5 02/18] cgroup/misc: Add SGX EPC resource type and
 export APIs for SGX driver
Thread-Index: AQHZ7csQsuJTu1fSxUmEbr/lUT6MDLAvpK2A
Date:   Thu, 28 Sep 2023 03:59:12 +0000
Message-ID: <0b24d7ad4de129681a8783f930f48962e572b653.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-3-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-3-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5280:EE_
x-ms-office365-filtering-correlation-id: fffbea63-0cb8-4f69-1860-08dbbfd746c9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSx5eRwC0PM37ipnD/fabeMBn53ZTWZkR5N6ZRDQdJmC7QUdCbJsnKQeN0tHLtyXl+ZmBLeIBJiyEDMh4ZcY0/JVeitezoI3J0STOLstw7Klg6vDG2J220jXVCrBtIYEg8ROHZC+TE/TSyXrFRWVpifOnZPPOq5g+ckL/9ph6XBdlUCenQkqJM4HQGraYbuQ/QtEXYbL4FxtiexxQ/uQUN0vPF4CVYSz0otR8xSrT6wtwyx/0fsS9/IkZeJv+zYn0OO6jgLUGbsqcLFK24FVt4nop19rctmzFnnSxZr2DLNll0B2sVYt0prLzhQuEugU8dr0I9OXuWsQgAYTzRDAsRBbaYnFd+rhRjCCFR3Gs5H1dfwReqgk6Ajx4WscwU7RF4yc5YzyyAZipbO8PMAGycxRUGK8j2uoLjj1H0XIMqp5MnQUJbldb/WK0Q1pWShtAxSuU4k9GnwSxV7Mn8/B883XZwDWge0k8ahysqs3lpkk1sgzMxvLtp/4qGXCzsaxpFzkrvHucARpgsTg3o7T4P9S1dk6qfxrUWSDSOumscGjj1IkWIyChWQ3vMLvr/5R+B6OGUoulE4JU68YfC6Rhv1ahnNuJm3+noH7epT1ssP8PObZ/p4U33Qt7bUv9iUp3Jd+CYvhK64TEkhZFqkkxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(6506007)(5660300002)(38100700002)(38070700005)(6486002)(71200400001)(8676002)(8936002)(91956017)(110136005)(66476007)(66446008)(54906003)(66556008)(76116006)(316002)(41300700001)(86362001)(64756008)(6512007)(66946007)(36756003)(26005)(2906002)(82960400001)(478600001)(83380400001)(4326008)(122000001)(921005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmhKSEtHMnNTUm1oVW1EQzFndHk3YjlkWkVYT0FMUmxnT21IY0h4M1g1ZG9F?=
 =?utf-8?B?ZVJuK0taNE9BaGl4UjhGOXdjWk1oa2JBNXRBelcwSGVCTWhhYmtiNnJmWmZi?=
 =?utf-8?B?Z0JYdFc4anlROEhLZWN4Q3dwbThSdHMvOFZVc1l2MjBTOVlUbEYyMFNocEJa?=
 =?utf-8?B?dDd0WldKT2ZRaFpXZXB3VEkwQzVpaWpvWVFpTWFzOUxoTHI2dkZqMlNKNk9n?=
 =?utf-8?B?c0c5L3NwSTYzdC81ZkpkYmU3dDlFV2p2QzJIc3lQaTJ1eHJxMWIxM1gwUkE5?=
 =?utf-8?B?Q2ducEtCc0JHaGlYUU1DaEVFSDZvaGNFTjZzMEFaazZ5MFU1cDhnUUZ1MFk2?=
 =?utf-8?B?cDVWNjgyYmxqWTFjaERTd0cwQnFXMG9HVTBsUmtqaStXTGxBMDN6WGJRaXQ1?=
 =?utf-8?B?U3FhVDdiaUg0bThMZXJrbU82OHlUNGFTbXpzNDh6UGt2NDRneFZOaFdHVXhh?=
 =?utf-8?B?aUNTT2w5TDUzK0xKdktTQno5L09TTzVUeHIxalQwSnVkdDhTRTZxMWZ0TTNU?=
 =?utf-8?B?TEhVY0pEaHNwTllBSjBtZVc4TUk1aFlQQ2ZYMm9QQzdUYVk2OXlDMHZ4dDJ4?=
 =?utf-8?B?T3VwT082UER1c0NhcmQwc1dXYmNMVWlUK0Vzbit1NzVHZzNTVHFOanJ0OW91?=
 =?utf-8?B?dXoyK0pFV3BRUW1yaWpTNzFBcjdqaVJJcmZwVTdFbUxWOGVSZkpQY2VnUGVT?=
 =?utf-8?B?RGdmRXdNQWVRelhFSUJwTWczK1kzOWQ0WnlXM2VTejc2RzI5VnhzUjhFbWlh?=
 =?utf-8?B?OUdNMlFUaUxrY3RGQ0hWUFgwdjBDRHFJN3B1clpjTEFHemR3cHlBeFc1RFIv?=
 =?utf-8?B?dDRudGFraDJYb1JCcEU3ZmRrSlVVMGViaFBGVTNMaEt0L1RyOTBPQlVpcWl5?=
 =?utf-8?B?OE4zM1pORVc2WnZ2K0JyZlRVSW1uUmV1MXBmaldlSWtVYy91Y1dna1pSU3FZ?=
 =?utf-8?B?TURXME1IT2ZzbkFGM1UrZzc4MzAvR2FjV2RGbnBUL2J0NEdzS2xlbUs0ZmFJ?=
 =?utf-8?B?K21KWklYWVlVaWFldWpvNE5vQkhyLzZCRVlsby9jVXdNSnRXVFFxQlZRUHdD?=
 =?utf-8?B?NS81UUNLd04xNnpmNTRaT1J3ZzZuVFdlcDBtdkxLa3h3OWlHUU9Dbk9hYVJM?=
 =?utf-8?B?WXVGUlZQVjd5UWtMb1FzNm9CL093emtkYk5JaEIwQmROQ0kxMEl6U1hQeE9G?=
 =?utf-8?B?eE1MRkRCVDkxOUJSYU1hcmxaVUxLNnJXUlpjL1Vsb0RRb2lCOVIzZzYvYlQw?=
 =?utf-8?B?empPbXovL1hyK3A2ekRUNmlkRHNBZ1AvNjNodWNaN0M1QmlSaGdLZDQxRlUr?=
 =?utf-8?B?S0s0SFBDS3dKOXdCbmJ0NzYrTlpqT0tWc3lwZjRNSWlwN2VHTGZmdGJ4N0pt?=
 =?utf-8?B?WEFXT3pZaTYrT09nM1FHSDNWTGQvTnFlOFRpUDJoaUlIbTcxakVmbko0dDhz?=
 =?utf-8?B?bW1FNUpLRUl5c0l6TVBseENYNCtGMXlkcStRZUlqbHh6TFk1SjQ4MTJlUGpY?=
 =?utf-8?B?bzJOZEVydlJieTd6Z2t0czdWeGJnWlptWlhSNzNIUjBtbTlnQzJEY2JzaHVJ?=
 =?utf-8?B?NFBMS1E5aEljdmVLMSs3SGtCbVhiZ0gybUNVVCtDR0tiUVR4MG5TQ0Irbk1G?=
 =?utf-8?B?QUxlMTg5TVdEZDlYdnJEZUh1QWtBU2ZBTHZBTkNtTmFUSjl1MUhqbU0xY3hZ?=
 =?utf-8?B?TzN6U0poWFJHRG1JSitONDNaSGNFbFR1bVFNR3p0dzVVOTFaeTZzNzhoMWhi?=
 =?utf-8?B?WmRPZ01nenY0c1BuYk9uQWYzclpYQnlzYUExQlRiMThSK1lSMDg4ZUY0eHFK?=
 =?utf-8?B?OU1YUHZWVTVORHQ3SGNzQmFTQWZXbC8wb20vLzM2RmVlU0tSTGErZjQzOXNC?=
 =?utf-8?B?cVFUSDFiMXZ0RzYzVTM0QkRZaENuRVZSckgxQmNUUEROanpSSU9xVjFFVXg2?=
 =?utf-8?B?ZlZ0TGhUOEd0b3o2VFY1RXRCWWhVZGROOFFCd3NpWU9YUzBqSUFNNnpLcEhC?=
 =?utf-8?B?VkhmU05Yb3MzNmtZN3gvODJMUzZkZFc1bVV2dkE1SnRGTG5XQS9Yb2FBTHpT?=
 =?utf-8?B?d3JuRlduRjNSRlVZQ2h6UmRrQk9wS2haNEE4QUFqcG9EUmVBSVYzL0pFTnZa?=
 =?utf-8?B?Qlo0VW1PMldLQ3k4Sm95UGZCQUxLcnJISnRFc3A5RngxMndMZDVIeVkycUhY?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <821BD4F849C714438DE09D2A31279A7E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffbea63-0cb8-4f69-1860-08dbbfd746c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 03:59:12.9282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylTW81VuYUw3Pl6tHdctumftPZ5V1jcEMaNENXlpBVAhzgQC5xpLXr83KcddHfV7t3PAbwMA/5iMqqqT7MwEZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
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
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IEFkZCBTR1ggRVBDIG1lbW9yeSwgTUlTQ19DR19SRVNfU0dYX0VQQywgdG8gYmUgYSB2
YWxpZCByZXNvdXJjZSB0eXBlDQo+IGZvciB0aGUgbWlzYyBjb250cm9sbGVyLg0KPiANCj4gQWRk
IHBlciByZXNvdXJjZSB0eXBlIHByaXZhdGUgZGF0YSBzbyB0aGF0IFNHWCBjYW4gc3RvcmUgYWRk
aXRpb25hbCBwZXINCj4gY2dyb3VwIGRhdGEgaW4gbWlzY19jZy0+bWlzY19jZ19yZXNbTUlTQ19D
R19SRVNfU0dYX0VQQ10uDQoNClRvIGJlIGhvbmVzdCBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQg
d2h5IHB1dHRpbmcgdGhlIGFib3ZlIHR3byBjaGFuZ2VzIGluIHRoaXMNCnBhdGNoIHRvZ2V0aGVy
IHdpdGggZXhwb3J0aW5nIG1pc2NfY2dfcm9vdC9wYXJlbnQoKSBiZWxvdy4NCg0KQW55IHJlYXNv
biB3aHkgdGhlIGFib3ZlIHR3byBjYW5ub3QgYmUgZG9uZSB0b2dldGhlciB3aXRoIHBhdGNoICgi
IHg4Ni9zZ3g6DQpMaW1pdCBwcm9jZXNzIEVQQyB1c2FnZSB3aXRoIG1pc2MgY2dyb3VwIGNvbnRy
b2xsZXIiKSwgd2hlcmUgdGhlc2UgY2hhbmdlcyBhcmUNCmFjdHVhbGx5IHJlbGF0ZWQ/DQoNCldl
IGFsbCBhbHJlYWR5IGtub3cgdGhhdCBhIG5ldyBFUEMgbWlzYyBjZ3JvdXAgd2lsbCBiZSBhZGRl
ZC4gIFRoZXJlJ3Mgbm8gbmVlZA0KdG8gYWN0dWFsbHkgaW50cm9kdWNlIHRoZSBuZXcgdHlwZSBo
ZXJlIG9ubHkgdG8ganVzdGlmeSBleHBvcnRpbmcgc29tZSBoZWxwZXINCmZ1bmN0aW9ucy4NCg0K
PiANCj4gRXhwb3J0IG1pc2NfY2dfcm9vdCgpIHNvIHRoZSBTR1ggZHJpdmVyIGNhbiBpbml0aWFs
aXplIGFuZCBhZGQgdGhvc2UNCj4gYWRkaXRpb25hbCBzdHJ1Y3R1cmVzIHRvIHRoZSByb290IG1p
c2MgY2dyb3VwIGFzIHBhcnQgb2YgaW5pdGlhbGl6YXRpb24NCj4gZm9yIEVQQyBjZ3JvdXAgc3Vw
cG9ydC4gVGhpcyBib290c3RyYXBzIHRoZSBzYW1lIGFkZGl0aW9uYWwNCj4gaW5pdGlhbGl6YXRp
b24gZm9yIG5vbi1yb290IGNncm91cHMgaW4gdGhlICdhbGxvYygpJyBjYWxsYmFjayBhZGRlZCBp
biB0aGUNCj4gcHJldmlvdXMgcGF0Y2guDQo+IA0KPiBUaGUgU0dYIGRyaXZlciwgYXMgdGhlIEVQ
QyBtZW1vcnkgcHJvdmlkZXIsIHdpbGwgaGF2ZSBhIGJhY2tncm91bmQNCj4gd29ya2VyIHRvIHJl
Y2xhaW0gRVBDIHBhZ2VzIHRvIG1ha2Ugcm9vbSBmb3IgbmV3IGFsbG9jYXRpb25zIGluIHRoZSBz
YW1lDQo+IGNncm91cCB3aGVuIGl0cyB1c2FnZSBjb3VudGVyIHJlYWNoZXMgbmVhciB0aGUgbGlt
aXQgY29udHJvbGxlZCBieSB0aGUNCj4gY2dyb3VwIGFuZCBpdHMgYW5jZXN0b3JzLiBUaGVyZWZv
cmUgaXQgbmVlZHMgdG8gZG8gYSB3YWxrIGZyb20gdGhlDQo+IGN1cnJlbnQgY2dyb3VwIHVwIHRv
IHRoZSByb290LiBUbyBlbmFibGUgdGhpcyB3YWxrLCBtb3ZlIHBhcmVudF9taXNjKCkNCj4gaW50
byBtaXNjX2Nncm91cC5oIGFuZCBtYWtlIGlubGluZSB0byBtYWtlIHRoaXMgZnVuY3Rpb24gYXZh
aWxhYmxlIHRvDQo+IFNHWCwgcmVuYW1lIGl0IHRvIG1pc2NfY2dfcGFyZW50KCksIGFuZCB1cGRh
dGUga2VybmVsL2Nncm91cC9taXNjLmMgdG8NCj4gdXNlIHRoZSBuZXcgbmFtZS4NCg0KTG9va3Mg
dG9vIG1hbnkgZGV0YWlscyBpbiB0aGUgYWJvdmUgdHdvIHBhcmFncmFwaHMuICBDb3VsZCB3ZSBo
YXZlIGEgbW9yZQ0KY29uY2lzZSBqdXN0aWZpY2F0aW9uIGZvciBleHBvcnRpbmcgdGhlc2UgdHdv
IGZ1bmN0aW9ucz8NCg0KQW5kIGlmIGl0IHdlcmUgbWUsIEkgd291bGQgcHV0IGl0IGF0IGEgcmVs
YXRpdmVseSBsYXRlciBwb3NpdGlvbiAoZS5nLiwgYmVmb3JlDQp0aGUgcGF0Y2ggYWN0dWFsbHkg
aW1wbGVtZW50cyBFUEMgY2dyb3VwKSBmb3IgYmV0dGVyIHJldmlldy4gIFRoaXMgYWxzbyBhcHBs
aWVzDQp0byB0aGUgZmlyc3QgcGF0Y2guIA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzdGVu
IENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+
IFY1Og0KPiAtIFJldmlzZWQgY29tbWl0IG1lc3NhZ2UgKEphcmtrbykNCj4gDQo+IFY0Og0KPiAt
IE1vdmVkIHRoaXMgdG8gdGhlIHNlY29uZCBpbiB0aGUgc2VyaWVzLg0KPiAtLS0NCj4gIGluY2x1
ZGUvbGludXgvbWlzY19jZ3JvdXAuaCB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBrZXJuZWwvY2dyb3VwL21pc2MuYyAgICAgICAgfCAyNSArKysrKysrKysrKystLS0tLS0t
LS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWlzY19jZ3JvdXAuaCBiL2lu
Y2x1ZGUvbGludXgvbWlzY19jZ3JvdXAuaA0KPiBpbmRleCA5NmE4ODgyMjgxNWEuLjg3ZjI5Zjg1
OTdlMSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9taXNjX2Nncm91cC5oDQo+ICsrKyBi
L2luY2x1ZGUvbGludXgvbWlzY19jZ3JvdXAuaA0KPiBAQCAtMTcsNiArMTcsMTAgQEAgZW51bSBt
aXNjX3Jlc190eXBlIHsNCj4gIAlNSVNDX0NHX1JFU19TRVYsDQo+ICAJLyogQU1EIFNFVi1FUyBB
U0lEcyByZXNvdXJjZSAqLw0KPiAgCU1JU0NfQ0dfUkVTX1NFVl9FUywNCj4gKyNlbmRpZg0KPiAr
I2lmZGVmIENPTkZJR19DR1JPVVBfU0dYX0VQQw0KPiArCS8qIFNHWCBFUEMgbWVtb3J5IHJlc291
cmNlICovDQo+ICsJTUlTQ19DR19SRVNfU0dYX0VQQywNCj4gICNlbmRpZg0KPiAgCU1JU0NfQ0df
UkVTX1RZUEVTDQo+ICB9Ow0KPiBAQCAtMzcsNiArNDEsNyBAQCBzdHJ1Y3QgbWlzY19yZXMgew0K
PiAgCXU2NCBtYXg7DQo+ICAJYXRvbWljNjRfdCB1c2FnZTsNCj4gIAlhdG9taWM2NF90IGV2ZW50
czsNCj4gKwl2b2lkICpwcml2Ow0KPiAgDQo+ICAJLyogcGVyIHJlc291cmNlIGNhbGxiYWNrIG9w
cyAqLw0KPiAgCWludCAoKmFsbG9jKShzdHJ1Y3QgbWlzY19jZyAqY2cpOw0KPiBAQCAtNTksNiAr
NjQsNyBAQCBzdHJ1Y3QgbWlzY19jZyB7DQo+ICAJc3RydWN0IG1pc2NfcmVzIHJlc1tNSVNDX0NH
X1JFU19UWVBFU107DQo+ICB9Ow0KPiAgDQo+ICtzdHJ1Y3QgbWlzY19jZyAqbWlzY19jZ19yb290
KHZvaWQpOw0KPiAgdTY0IG1pc2NfY2dfcmVzX3RvdGFsX3VzYWdlKGVudW0gbWlzY19yZXNfdHlw
ZSB0eXBlKTsNCj4gIGludCBtaXNjX2NnX3NldF9jYXBhY2l0eShlbnVtIG1pc2NfcmVzX3R5cGUg
dHlwZSwgdTY0IGNhcGFjaXR5KTsNCj4gIGludCBtaXNjX2NnX3RyeV9jaGFyZ2UoZW51bSBtaXNj
X3Jlc190eXBlIHR5cGUsIHN0cnVjdCBtaXNjX2NnICpjZywgdTY0IGFtb3VudCk7DQo+IEBAIC03
OCw2ICs4NCwyMCBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBtaXNjX2NnICpjc3NfbWlzYyhzdHJ1
Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqY3NzKQ0KPiAgCXJldHVybiBjc3MgPyBjb250YWluZXJf
b2YoY3NzLCBzdHJ1Y3QgbWlzY19jZywgY3NzKSA6IE5VTEw7DQo+ICB9DQo+ICANCj4gKy8qKg0K
PiArICogbWlzY19jZ19wYXJlbnQoKSAtIEdldCB0aGUgcGFyZW50IG9mIHRoZSBwYXNzZWQgbWlz
YyBjZ3JvdXAuDQo+ICsgKiBAY2dyb3VwOiBjZ3JvdXAgd2hvc2UgcGFyZW50IG5lZWRzIHRvIGJl
IGZldGNoZWQuDQo+ICsgKg0KPiArICogQ29udGV4dDogQW55IGNvbnRleHQuDQo+ICsgKiBSZXR1
cm46DQo+ICsgKiAqIHN0cnVjdCBtaXNjX2NnKiAtIFBhcmVudCBvZiB0aGUgQGNncm91cC4NCj4g
KyAqICogJU5VTEwgLSBJZiBAY2dyb3VwIGlzIG51bGwgb3IgdGhlIHBhc3NlZCBjZ3JvdXAgZG9l
cyBub3QgaGF2ZSBhIHBhcmVudC4NCj4gKyAqLw0KPiArc3RhdGljIGlubGluZSBzdHJ1Y3QgbWlz
Y19jZyAqbWlzY19jZ19wYXJlbnQoc3RydWN0IG1pc2NfY2cgKmNncm91cCkNCj4gK3sNCj4gKwly
ZXR1cm4gY2dyb3VwID8gY3NzX21pc2MoY2dyb3VwLT5jc3MucGFyZW50KSA6IE5VTEw7DQo+ICt9
DQo+ICsNCj4gIC8qDQo+ICAgKiBnZXRfY3VycmVudF9taXNjX2NnKCkgLSBGaW5kIGFuZCBnZXQg
dGhlIG1pc2MgY2dyb3VwIG9mIHRoZSBjdXJyZW50IHRhc2suDQo+ICAgKg0KPiBAQCAtMTAyLDYg
KzEyMiwxNSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcHV0X21pc2NfY2coc3RydWN0IG1pc2NfY2cg
KmNnKQ0KPiAgfQ0KPiAgDQo+ICAjZWxzZSAvKiAhQ09ORklHX0NHUk9VUF9NSVNDICovDQo+ICtz
dGF0aWMgaW5saW5lIHN0cnVjdCBtaXNjX2NnICptaXNjX2NnX3Jvb3Qodm9pZCkNCj4gK3sNCj4g
KwlyZXR1cm4gTlVMTDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSBzdHJ1Y3QgbWlzY19j
ZyAqbWlzY19jZ19wYXJlbnQoc3RydWN0IG1pc2NfY2cgKmNnKQ0KPiArew0KPiArCXJldHVybiBO
VUxMOw0KPiArfQ0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHU2NCBtaXNjX2NnX3Jlc190b3RhbF91
c2FnZShlbnVtIG1pc2NfcmVzX3R5cGUgdHlwZSkNCj4gIHsNCj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9jZ3JvdXAvbWlzYy5jIGIva2VybmVsL2Nncm91cC9taXNjLmMNCj4gaW5kZXggNjJjOTE5OGRl
ZTIxLi40NjMzYjg2MjllNjMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9jZ3JvdXAvbWlzYy5jDQo+
ICsrKyBiL2tlcm5lbC9jZ3JvdXAvbWlzYy5jDQo+IEBAIC0yNCw2ICsyNCwxMCBAQCBzdGF0aWMg
Y29uc3QgY2hhciAqY29uc3QgbWlzY19yZXNfbmFtZVtdID0gew0KPiAgCS8qIEFNRCBTRVYtRVMg
QVNJRHMgcmVzb3VyY2UgKi8NCj4gIAkic2V2X2VzIiwNCj4gICNlbmRpZg0KPiArI2lmZGVmIENP
TkZJR19DR1JPVVBfU0dYX0VQQw0KPiArCS8qIEludGVsIFNHWCBFUEMgbWVtb3J5IGJ5dGVzICov
DQo+ICsJInNneF9lcGMiLA0KPiArI2VuZGlmDQo+ICB9Ow0KPiAgDQo+ICAvKiBSb290IG1pc2Mg
Y2dyb3VwICovDQo+IEBAIC00MCwxOCArNDQsMTMgQEAgc3RhdGljIHN0cnVjdCBtaXNjX2NnIHJv
b3RfY2c7DQo+ICBzdGF0aWMgdTY0IG1pc2NfcmVzX2NhcGFjaXR5W01JU0NfQ0dfUkVTX1RZUEVT
XTsNCj4gIA0KPiAgLyoqDQo+IC0gKiBwYXJlbnRfbWlzYygpIC0gR2V0IHRoZSBwYXJlbnQgb2Yg
dGhlIHBhc3NlZCBtaXNjIGNncm91cC4NCj4gLSAqIEBjZ3JvdXA6IGNncm91cCB3aG9zZSBwYXJl
bnQgbmVlZHMgdG8gYmUgZmV0Y2hlZC4NCj4gLSAqDQo+IC0gKiBDb250ZXh0OiBBbnkgY29udGV4
dC4NCj4gLSAqIFJldHVybjoNCj4gLSAqICogc3RydWN0IG1pc2NfY2cqIC0gUGFyZW50IG9mIHRo
ZSBAY2dyb3VwLg0KPiAtICogKiAlTlVMTCAtIElmIEBjZ3JvdXAgaXMgbnVsbCBvciB0aGUgcGFz
c2VkIGNncm91cCBkb2VzIG5vdCBoYXZlIGEgcGFyZW50Lg0KPiArICogbWlzY19jZ19yb290KCkg
LSBSZXR1cm4gdGhlIHJvb3QgbWlzYyBjZ3JvdXAuDQo+ICAgKi8NCj4gLXN0YXRpYyBzdHJ1Y3Qg
bWlzY19jZyAqcGFyZW50X21pc2Moc3RydWN0IG1pc2NfY2cgKmNncm91cCkNCj4gK3N0cnVjdCBt
aXNjX2NnICptaXNjX2NnX3Jvb3Qodm9pZCkNCj4gIHsNCj4gLQlyZXR1cm4gY2dyb3VwID8gY3Nz
X21pc2MoY2dyb3VwLT5jc3MucGFyZW50KSA6IE5VTEw7DQo+ICsJcmV0dXJuICZyb290X2NnOw0K
PiAgfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwobWlzY19jZ19yb290KTsNCj4gIA0KPiAgLyoqDQo+
ICAgKiB2YWxpZF90eXBlKCkgLSBDaGVjayBpZiBAdHlwZSBpcyB2YWxpZCBvciBub3QuDQo+IEBA
IC0xNTAsNyArMTQ5LDcgQEAgaW50IG1pc2NfY2dfdHJ5X2NoYXJnZShlbnVtIG1pc2NfcmVzX3R5
cGUgdHlwZSwgc3RydWN0IG1pc2NfY2cgKmNnLCB1NjQgYW1vdW50KQ0KPiAgCWlmICghYW1vdW50
KQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiAtCWZvciAoaSA9IGNnOyBpOyBpID0gcGFyZW50X21p
c2MoaSkpIHsNCj4gKwlmb3IgKGkgPSBjZzsgaTsgaSA9IG1pc2NfY2dfcGFyZW50KGkpKSB7DQo+
ICAJCXJlcyA9ICZpLT5yZXNbdHlwZV07DQo+ICANCj4gIAkJbmV3X3VzYWdlID0gYXRvbWljNjRf
YWRkX3JldHVybihhbW91bnQsICZyZXMtPnVzYWdlKTsNCj4gQEAgLTE2MywxMiArMTYyLDEyIEBA
IGludCBtaXNjX2NnX3RyeV9jaGFyZ2UoZW51bSBtaXNjX3Jlc190eXBlIHR5cGUsIHN0cnVjdCBt
aXNjX2NnICpjZywgdTY0IGFtb3VudCkNCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiAgZXJyX2NoYXJn
ZToNCj4gLQlmb3IgKGogPSBpOyBqOyBqID0gcGFyZW50X21pc2MoaikpIHsNCj4gKwlmb3IgKGog
PSBpOyBqOyBqID0gbWlzY19jZ19wYXJlbnQoaikpIHsNCj4gIAkJYXRvbWljNjRfaW5jKCZqLT5y
ZXNbdHlwZV0uZXZlbnRzKTsNCj4gIAkJY2dyb3VwX2ZpbGVfbm90aWZ5KCZqLT5ldmVudHNfZmls
ZSk7DQo+ICAJfQ0KPiAgDQo+IC0JZm9yIChqID0gY2c7IGogIT0gaTsgaiA9IHBhcmVudF9taXNj
KGopKQ0KPiArCWZvciAoaiA9IGNnOyBqICE9IGk7IGogPSBtaXNjX2NnX3BhcmVudChqKSkNCj4g
IAkJbWlzY19jZ19jYW5jZWxfY2hhcmdlKHR5cGUsIGosIGFtb3VudCk7DQo+ICAJbWlzY19jZ19j
YW5jZWxfY2hhcmdlKHR5cGUsIGksIGFtb3VudCk7DQo+ICAJcmV0dXJuIHJldDsNCj4gQEAgLTE5
MCw3ICsxODksNyBAQCB2b2lkIG1pc2NfY2dfdW5jaGFyZ2UoZW51bSBtaXNjX3Jlc190eXBlIHR5
cGUsIHN0cnVjdCBtaXNjX2NnICpjZywgdTY0IGFtb3VudCkNCj4gIAlpZiAoIShhbW91bnQgJiYg
dmFsaWRfdHlwZSh0eXBlKSAmJiBjZykpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCWZvciAoaSA9
IGNnOyBpOyBpID0gcGFyZW50X21pc2MoaSkpDQo+ICsJZm9yIChpID0gY2c7IGk7IGkgPSBtaXNj
X2NnX3BhcmVudChpKSkNCj4gIAkJbWlzY19jZ19jYW5jZWxfY2hhcmdlKHR5cGUsIGksIGFtb3Vu
dCk7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChtaXNjX2NnX3VuY2hhcmdlKTsNCg0K
