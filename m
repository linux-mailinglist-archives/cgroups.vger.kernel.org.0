Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAEC7BABB9
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 23:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJEVBj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjJEVBh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 17:01:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956993;
        Thu,  5 Oct 2023 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696539695; x=1728075695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kq0r11Kc+DFGyjUU860sskW9iibX+AMN28BJpnWdhRg=;
  b=cP7fLWUw/sIX0k3NCa0fK6OyTge5AeytHyUdHDcQvYCiO9ol6En0w67v
   zLoslEZhIY48ChhX9Jp+6+TXDCFy1BnNFHLqE77Le92JJmC0+ukSP5gRe
   k+6ZMyjO3PQaGBc6LpFHzY3TJLPePhkrBfu1ieYozII/5IdrV5rhsByGF
   apN0a0uyZUfyichpv1BJVcbU28KxYFJajnG5Gpjwe7IXPxuX3+yfxEyEP
   esDWYQymmYMLzi4DIhxJuHAkuCemfW8O+4SU5W8NobvWLqfm4DMnYlvMc
   1nWysp0Uk2trZk3cMaeK/jKoKdRnVvUu3kvDU8rTz+Bqc9Dommmgs89Gn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383515926"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383515926"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="745608108"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="745608108"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 14:01:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 14:01:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 14:01:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 14:01:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 14:01:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHdfst1rdsOY7zYJoriEzq/2wVh53V2/bpwNqvqGnEurNdZaJxZq7NXuH09qyRmuN4mGyKmk1InDhfr2i1PX7mUEt3BWCCBiCr2YT0ZxsJUmH7Lj9igSEPXg1ZEIPEGlU0P1Uxae7CpBeQDZixzSH8t+MkqEwRezLtLVcuKGR95EQBhOws2zaUdlBUJwNBG1JTqeuDwvytXcHl7QhrpdbAM+nKW82D6lT0PHOXK3ocky5uil+5km9hvRcZKGu7siZ0Nl1svPYeI8K8vQgjjet9KmrqPHrsHJ9XzfZ+xLkI8S8J9H1Y3s7VLd97nqvUOTYJzQPqY8tz2TMWr9Xj10+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq0r11Kc+DFGyjUU860sskW9iibX+AMN28BJpnWdhRg=;
 b=Pi5iEGkEEVIwNegLDc1hX80bPDToC3KG67yKLupmD9rQSRaG77XsdA6/FMM8WQiJFawwDDK2TvAjynxdMvCX8rIUlERBudmxk8OETxV/vsH9LOGDgXpatoRWzZYak7uJbXtzNgLQQzTx7E6WC7pX0bNP4PKQDVxfDuWr5iKzbItl+yAwvj7g6vUDOk2eR6DTB7zoDgUmXwqVv3NMciWk8/jQjh2Qm4z9XQpR5e9181gYRsD3ozZqhWTWSzAH45y4+TBlfv9en9CTk4d4ZKk39+RQEQl84A7er1jTBoI2apGgZd7KbofcR9AgW2d2JZHSpBhJZnbOlGEWa7/nIdnkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 21:01:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 21:01:30 +0000
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
Thread-Index: AQHZ7csxMWGpeN5dZUG6Wyp0ITB+SrA7wqEA
Date:   Thu, 5 Oct 2023 21:01:30 +0000
Message-ID: <09826127c26c3cf30fc6e2c3b72613c13fc7d367.camel@intel.com>
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
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7870:EE_
x-ms-office365-filtering-correlation-id: 59ca96fc-f621-4bbf-891f-08dbc5e63fe1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJahNVFxD9aEgUGJMTDr0oBReW4/Md/aUtTtH/2y2Wt3/mzZubC7Q/Ml5uv24uAU5lwEw8xecKN9nhaY4+BHrwZmjamiQkqCOvABceDngCakCBXg+pxiCwxJngpBFH9DfFK9K6aIEBHcdnfw9iUrXMMAPOeIEvLidu5oCFZSuYksF8kwg9hMZrWfS7aTx6bvRxoXfOYXhuF/pqFT6fr+h4uFPR/84O6oYajyZY59DbUbxUb2aIX6YNWqc2ygWFnZaVVTgiqEupZ2GYtVX1hbLUPjzdjLsRESeKx/Wq6w5KG2p9seYj96xBF74BKgHkOB+6kuTg921ZDL4GHZpD5P+4xeLFtftbR+ZemNV02GX+GFITB3SCEs1oqiZNNll7nG4i4t3i6I52XVc9utepDHwBC1ftIi/AdjBSraueRuxfylPOkrxdPgtbIsusal3wRm9nCsIpH6O+GoNL543JmNF95mBUlrtYLhsLjMHLDObUGLT2hslVICjCxaTgplEAKEeZONT+GAxW1fzt1nQ4zbQsTk/MIUhgb6VrtzkbUp5LhVkIt3VIFpMKsL2dfUSMmZEt642H4ui7hhyq1d59JtSyYasUQfyTvclArAhWj8omgwShvZk2SvmNCRsrXxnmscZGBI1lBTHze0Lk0b+EwTIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(4326008)(8936002)(8676002)(5660300002)(7416002)(2906002)(36756003)(83380400001)(6506007)(71200400001)(921005)(82960400001)(2616005)(6512007)(122000001)(6486002)(478600001)(26005)(64756008)(38070700005)(38100700002)(316002)(54906003)(91956017)(66476007)(66446008)(66556008)(76116006)(66946007)(110136005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVdwU0V4ZDA4aTlneEc0UUI1UHZ0azVpdnY1Zm9KNFNLS3RPMFp3SzltTUYx?=
 =?utf-8?B?Z3d0Tkl1dVIvRWNURDhQL09tSkowSmprZWI4VWJjdVM1VDE2Ti83U1NGNmhp?=
 =?utf-8?B?WG5KT004ZVpoL3orK2tObHNObkxLdHR3YzhpZktxYk9vb3ZXQTJFbnVLeFJH?=
 =?utf-8?B?RkpCTVlmZjNUQjF5MDJIMTNLVy96VXloY2NaT0NJckFkckhtdXBFZTFQaFdL?=
 =?utf-8?B?TDU2dE5ZWGRwcG40WHFCOWxxcUlpeWlVZHRSNWxoOUxaZzd0RHhlRi9XNHJ0?=
 =?utf-8?B?WW9CTXlQWmxnSUh3SURlQzNHeEFmOTFuNU5pV2czSUEyclM5QTNaSlRYeFVT?=
 =?utf-8?B?bkE1b1d3UzN5Rm5HTStmcW5VYWtESnNkRE9HZ05YVzJ3ay9LS2pvMDdWdmdp?=
 =?utf-8?B?TjI3aDY0RG1PdU9ZbXVvMDYzZU1yQkxiU0xJNlpQK2pvQWpWdGNnRmoxc1Jp?=
 =?utf-8?B?ek96SHVBT293anlkVnVkMXVFODhRdm45TGoyM1cwZXUxREM3R28xVzZlY29T?=
 =?utf-8?B?RmdZRm9KSWU5NTJMeDVoZksyU3NLQTViUTBTSDFXTVA4dVlsMEIrMWRPSXJa?=
 =?utf-8?B?dUF4SEdoY0hhMGFhTDlZYTNvSUxKY3ZqVW9CcVgrS2JoVkhObnlidDgvVUpr?=
 =?utf-8?B?V3BteHlJemF6L2JlUndRN2owZlo0ZGtxQXpxNHJ4dG5QZ3ZIM3BFNHh3SlRi?=
 =?utf-8?B?ZmFYOElSS1lPWjdpSzRaQ3VhVWt2WTgyQXhhSFI1MGxVR3hmaUZHNHZKbkFk?=
 =?utf-8?B?MWdQM1ZTR2xSaFpzTzhuZXdmU0pQcHplTkxidEZ0aEpZdkhLUnVtb3RtaUNs?=
 =?utf-8?B?Y1YvZElhTmo4WkdYVVlzWkFNVWhwMU5oN1AyTEh1M0NLa3J6M01FakZ4Nkln?=
 =?utf-8?B?UUg0WTJpdm4rZEViYUwyRUxsNFBaa2duL3ZQN1RqTGxRRyt6TFRFb0RITWlY?=
 =?utf-8?B?eXFHSUNMKzc5TWJwczhIZlNOODdtT21sL0dWc3RVSkJsdnY0TEEvRTdPVFNu?=
 =?utf-8?B?U2s1TTd0aVhKeGJyVVExeGMwdHJkbWNtYnVXWVhwSjN0OHlVMVFqSnk2UXlP?=
 =?utf-8?B?amRzMjNxY0orSVJxSHZqRWhqT3BCbENoV0NZK1BSMW82eDZpQjBLb25QNkJz?=
 =?utf-8?B?dDJoTk9NcEdQRFF6TFIrQWZPaTF1bkZRVnRDeWdNVVFEOFkzVGFpOEswNTFj?=
 =?utf-8?B?ZDBMTDE0UVNZMnNWM3creEM1eFBIdWlTcVBTbFIrWElZd0l0aFJhdXBLTUNw?=
 =?utf-8?B?SVM3RTY5enhvbXpjR2dWTXlLVXM3Y3lEM2VaVzcwTGpjME40bTRqallvNXpL?=
 =?utf-8?B?Z1lMRG5JT1NOd2c1bndoU0V5akhiNHdmS01tMmlPbTd6OUQ0cmhBaFd1aHFz?=
 =?utf-8?B?ZG5HcjdMYnRYenZqNmkwUlJ5aDFIbDdUUnBTR0Uwb1NxOThXbVpNR0JkWU93?=
 =?utf-8?B?d005UlZCQk5qTjc0Y0VkMzlia0crNC9mMGVNNFhpK1NiOUtYNnYveWdBRWF6?=
 =?utf-8?B?L1hna0JJVVcrNFg4VkRSUmpSL0hQV2tzK21UMjRybzFLU0FzRUUwNnQvaWEr?=
 =?utf-8?B?TXp2TW8yS0NwU1pVZTRnd0ZUY0NVS0pISU9TNGd3b2hxUiszTGp3bExleGs4?=
 =?utf-8?B?L0hEQmhBNVhvb0EzV3dvWXpTQVorMVFuM1prL0VGZE96bSs3L1YyN0dqengz?=
 =?utf-8?B?L0lwVTl0WXRRYk8vZVlmZS9GaFJTVEtpUXRiQVJQQVNaeHlZRmwyb25XQStW?=
 =?utf-8?B?Vko2dGh6SGJNcGhqL1NtWW1Bc2o4aWVFVzJRV2RHWEc0cHpqbWJRdlNVdDZM?=
 =?utf-8?B?VE9oRFVLajhBTFJJOVlQcVhDd3BFQlNDaFJ3dGwxdlBCZlhKSElGTVp5RXhC?=
 =?utf-8?B?SUJNd1ZJOEhPUERSUGNadWNuVkxKTkFYZTNrTnEvWU5HQkl4eGxVd0Izejhx?=
 =?utf-8?B?M3dwM1NnM1liRmtDZHFvamp1YU4zLzNiSVU1U280ZjBuSFhkQVM4N0N6bjFI?=
 =?utf-8?B?UnJIejdUdWFyMWtxRE11VzNoZmRUbS93bGFVSlVjNkMxOUkvTkwwNHJMY3h4?=
 =?utf-8?B?OFQ1VVZ0V3NiUXZPeXN0NDV5c1Y4SFRQNTNIQTM2RGtDbzFlaGU4Ym9DYXUz?=
 =?utf-8?B?SkZuY3U5ZXRMUVlUSDhXQjV4L2hkcGpVUE5oYXhJMVhxck0wWXZPZ1MzUDQr?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72F57BE3FB9970438E0E74A2592125D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ca96fc-f621-4bbf-891f-08dbc5e63fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 21:01:30.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VUTzNjSeYdSrLncmHtfSw5Wp2ko/+U9grgnUTjPkLo8Zp9B1QUq5YmfH3nBk8QgASTEbryGCvngqR3KTTf1tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
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

DQo+IC0tLQ0KPiAgYXJjaC94ODYvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsN
Cj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L01ha2VmaWxlICAgICB8ICAgMSArDQo+ICBhcmNo
L3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMgfCA0MTUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmggfCAgNTkg
KysrKw0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jICAgICAgIHwgIDY4ICsrKyst
DQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9zZ3guaCAgICAgICAgfCAgMTcgKy0NCj4gIDYg
ZmlsZXMgY2hhbmdlZCwgNTU2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuYw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaA0K
DQpHaXZlbiBob3cgbGFyZ2UgdGhpcyBwYXRjaCBpcywgaXQncyBiZXR0ZXIgdG8gc3BsaXQgaWYg
d2UgY2FuLg0KDQpJdCBzZWVtcyB3ZSBjYW4gYXQgbGVhc3Qgc3BsaXQgLi4uDQoNClsuLi5dDQoN
Cj4gDQo+IEBAIC05NzAsNiArMTAwNSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBhcmNoX3VwZGF0
ZV9zeXNmc192aXNpYmlsaXR5KGludCBuaWQpIHt9DQo+ICBzdGF0aWMgYm9vbCBfX2luaXQgc2d4
X3BhZ2VfY2FjaGVfaW5pdCh2b2lkKQ0KPiAgew0KPiAgCXUzMiBlYXgsIGVieCwgZWN4LCBlZHgs
IHR5cGU7DQo+ICsJdTY0IGNhcGFjaXR5ID0gMDsNCj4gIAl1NjQgcGEsIHNpemU7DQo+ICAJaW50
IG5pZDsNCj4gIAlpbnQgaTsNCj4gQEAgLTEwMjAsNiArMTA1Niw3IEBAIHN0YXRpYyBib29sIF9f
aW5pdCBzZ3hfcGFnZV9jYWNoZV9pbml0KHZvaWQpDQo+ICANCj4gIAkJc2d4X2VwY19zZWN0aW9u
c1tpXS5ub2RlID0gICZzZ3hfbnVtYV9ub2Rlc1tuaWRdOw0KPiAgCQlzZ3hfbnVtYV9ub2Rlc1tu
aWRdLnNpemUgKz0gc2l6ZTsNCj4gKwkJY2FwYWNpdHkgKz0gc2l6ZTsNCj4gIA0KPiAgCQlzZ3hf
bnJfZXBjX3NlY3Rpb25zKys7DQo+ICAJfQ0KPiBAQCAtMTAyOSw2ICsxMDY2LDkgQEAgc3RhdGlj
IGJvb2wgX19pbml0IHNneF9wYWdlX2NhY2hlX2luaXQodm9pZCkNCj4gIAkJcmV0dXJuIGZhbHNl
Ow0KPiAgCX0NCj4gIA0KPiArCW1pc2NfY2dfc2V0X2NhcGFjaXR5KE1JU0NfQ0dfUkVTX1NHWF9F
UEMsIGNhcGFjaXR5KTsNCj4gKwlzZ3hfZXBjX3RvdGFsX3BhZ2VzID0gY2FwYWNpdHkgPj4gUEFH
RV9TSElGVDsNCj4gKw0KPiAgCXJldHVybiB0cnVlOw0KPiAgfQ0KPiANCg0KLi4uIHNldHRpbmcg
dXAgY2FwYWNpdHkgb3V0IGFzIGEgc2VwYXJhdGUgcGF0Y2gsIGFzIGl0IGlzIGEgdG9wLWxldmVs
IG9ubHkgZmlsZQ0Kc2hvd2luZyB0aGUgbWF4aW11bSBpbnN0YW5jZXMgb2YgdGhlIHJlc291cmNl
Lg0KDQpJJ2xsIHJldmlldyByZXN0IGxhdGVyLg0K
