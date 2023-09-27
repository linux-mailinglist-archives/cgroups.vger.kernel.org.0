Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3621C7B032B
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjI0LgD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 07:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjI0LgC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 07:36:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8513A;
        Wed, 27 Sep 2023 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695814561; x=1727350561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tjpojIsINnmxhd5hdeiwYNOf6tXUZkMWoCqiHXz6HcE=;
  b=GcnS88fhnBO4Jmpfn91J0z1vHFQg6QXuRLc+DH78/PX/1Jeybw6Z2/rf
   ST2MWRexd95muuBZhuZx0wlin942Xtea7UTJ8/TKOUD+TNe5CEnGpji+b
   2poV0ref3szXllCKI6YKgHPPUpnfnArMaFiwfRjOoasj/sEFFIULX1uCu
   KCFI4n3H8dfMQfh56vyYEaVbzMLhM6duY/F1adCuLwzlVF0Zs8Ovc+FTa
   Hv8F1nzv3kkoUNqtlLbL0xqh+dTyGUVcyXX4vdYvKR8vvglZmxlYIRlqM
   8aTuw8QQdthKPO6vL0M7wQ5oNuYTdkSORyRvaFPi4EYZCR8W8cK14JF5q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366862572"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366862572"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 04:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814846627"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="814846627"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 04:35:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 04:35:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 04:35:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 04:35:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 04:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIZZaaYaLoJrbl2kgkduTjVMg1HeqQfhgeKIhJGtwndoQE0a6OgONhrtE92B94yaoRYWEPOQBiesR5tcJy51tuui81FDMZhPBCWxcRhb/Q4R+GPi8N/bX4C13rSo7kQoOCA8WV56m4OsENya6diNQ2/L5emUriNRuCoCOxjV8otpA3E6Rrmhz1vBg3oC0qIcnWDJOoma0pjoI5M8MKX0yMlikFZR0uCCpttN9wVOsrSV1+EME5pugpSky+2XKSm+XuFfZAQuNsuV3YBS/VbPZoytD3XksaK3uCciyAq6dVY8fRhAzeb3NGW0qWkDbNadVSsL8GtN4eis+UeXrRvkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjpojIsINnmxhd5hdeiwYNOf6tXUZkMWoCqiHXz6HcE=;
 b=RzqkMhXpbLNCPrB5zzboHuPRyjwbpIiQRz4hBrT6g2NWiIEShzDfmWL0Cab+7v60w18qHTqmc1dFd4zSnAP41srEhvEgYzwIq9mCTIa7MZAFMNJ9OdHrk7Ktxmuig4a5mYmJVU0B/SeC1zA8fgtOCV9b6j3K1m3qPtN4z1vJ7qxv6D4PIzLoy/V7vnGBCqkWVHiSHr3nNeK6qNBrFHs5J5R/M4HtJyzkxuK7sLYWZ4LUEuuVfDiQYMHgGpiQrw35gxaYwlsNl4KsUZ299sl241/HCpaxo2RXxb7ezzAv70/GMgetLb5YpUKxWb1zLL/SdNa1tU/XPo3Lip78oloS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 11:35:57 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 11:35:57 +0000
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
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Topic: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Index: AQHZ7cscCwFKzsfMlUe7K1500sBqu7AukfYA
Date:   Wed, 27 Sep 2023 11:35:57 +0000
Message-ID: <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-10-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-10-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB5766:EE_
x-ms-office365-filtering-correlation-id: 2c8811cc-dca3-4091-2590-08dbbf4dea99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlTHV8T0MXHMW2+Q4cldZFjap4m1MOKs+ETJhNpqzGtYFhl8CCbKoPZ4T8DulKblj6Focur5V0eZtisasPwEgN/ML6+fZCnHwM2J1vXVVGbFX/azMDhrFxMSPlwsIlQK906o0uJ6J9busZojVLW3AY9dJKiiVuVybUsbCcUeYxMh5Owxy0fQuggg39ABnXQKuyzQ4PvNBJaRKDr2n/LVK0w5J40BI3OGB3KO043loZaa98SW6JCdu6A0Dc+dKWcDrofXyFasgA6VpCockE/8m5rMiFyUxbncM08lRNx0KwtU891UwXUwUsM1NUiwMiXp1jM05pKRFT2IMZDYw11L9f24I4xdH06vvZpZEF+vE6lc/+dsjBrNkdVgIeiJZh7Z6le47Sln1ZWDKo+xqL2VZIIVypFF7ycPx7CzCyRVrl9ppHlukUiY83zYjMa8SJeGrR9lgro/slGtR3MTbCFJ+M7+5lrLSPXHMR8wPv5sftzFU4l6+325pMp4F79UNDesiwb0xfP1lmHlEzX5Oo37NR4diNhBBNbBJm9yypIaIWIN8YNQuBQeo9ARk7E2D0ujasre6xaYCr7B+rQ8tM7GTAa40AKlfwLfErC16tv7TCFMnnuFYriKYq5fXe3yBfNy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799009)(4326008)(8676002)(8936002)(5660300002)(91956017)(66946007)(76116006)(26005)(110136005)(83380400001)(2616005)(6506007)(6486002)(38100700002)(6512007)(478600001)(66476007)(7416002)(64756008)(66446008)(66556008)(54906003)(316002)(82960400001)(86362001)(2906002)(41300700001)(36756003)(71200400001)(921005)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUMwV1E0MXVFTEJKRVJRbFQ3SUdaekpMSEw2cnVUdHQ5ckJPTjNUNU1PdXF6?=
 =?utf-8?B?WGw0VWhEUHYzWGRrbENGaU1DT1R0ek9rTjdub2EwQVFPQ2Eyb09rSEk0Zmtx?=
 =?utf-8?B?Z3dXRXBEZkUyR2NZaEdtU1NJd1V0UHByaXA5czJrWEpGUGhzMTgrOG93V2E3?=
 =?utf-8?B?a0xuOWRIMVBRdU4yYWwvZ2F6Rzh1Zm12WGFhcjlZMk9CeTNLa3VNUkZhK3VZ?=
 =?utf-8?B?VHRjVUlqWCtzd0xxT0o3aW50ZnlDbmxOMHREd1FXWE5JYTN6dmtPUTJQRHAz?=
 =?utf-8?B?N1lvMDQ5R0VpUnpiTGdRSFBXRHQ0L04wbkJiTjBPM2V0QWE5endsc051ckxW?=
 =?utf-8?B?bGhyTHkzOGdoZEJVTGlLQkZqMjd0SlY0cGxsSUJQajA4ckVlWXJ3aGVOUVEr?=
 =?utf-8?B?ZzFVRzVHMk0vTHBCbU9kcDU0akdHQk5ZZkFtUS9ra0tlWmdOK3Z6MmMyaFhO?=
 =?utf-8?B?UWJmd0dIYUV5eWw3c29YRFFGM09YSU5iV3lsYmJjQWFHVzBTZW56TGs5c1BH?=
 =?utf-8?B?U2t2Umg3dHdSMzdPTGxJSWhlUUlQaUhnYVhhTDVpM2hySGNYVWRjd0RkQ2tN?=
 =?utf-8?B?REdSYjVmaThPWVZxekFzeDVoemRBd0pyelk2NG10VFluMFpTdWxPemprZzFE?=
 =?utf-8?B?c0tqdFdYZ3lvQWR6UkhRSnhVRXp4TnFSa2V4TjlKVGI1YVB2NnA2RklleVkx?=
 =?utf-8?B?ck1odCtSWlR6b3VHaG5hOGlwWVdKb3dRa0diVlFuUnZRSjBiTGM4SmxHYVYx?=
 =?utf-8?B?UHlYOXp4U0hnM2h2azJ6L1BzTGQ5NnBMWG9ic0M5Wk0wMW93NTNzb0Q0SDF0?=
 =?utf-8?B?d2hIRW9jM3U1c2FETTFpQ1l2RVdnd2pWbVhRNzQxdjU2dGx6V0lCOGpuUFl3?=
 =?utf-8?B?NlRQaVJUZS83MGtQVjRCVnJBOEduTHg2WDI5ZnBuWEwyc0xKUzk0bDlCbDFl?=
 =?utf-8?B?YWhJMnhkVGFMcklFdHAwL2NrcmZwR3RhdFUyaHQ3SytKb2QyYXV3cFBpS1lZ?=
 =?utf-8?B?YVJCNStZZXVCcGt5WjdFSVVQZGxZV0hRLzVQRWJoZE5DMCtXTFc4dUJCOUQ5?=
 =?utf-8?B?Ui91YzlpQUpkWEcxMTd2T2VoNk80NnlRZEZhS3BJRnVaTnRkMWxPVmRTK3lW?=
 =?utf-8?B?N1UvVHRUaEQ5eWZTYk9qNDFUTVhQMnl0OTQwMU81V2hXRmFuK0JYK1k0cjRi?=
 =?utf-8?B?Z0pXblRYbjRRbDFZUWs5WjFzSGlUUmVVTHFuQWZYdjU3NTVmdXA2T2dxcitF?=
 =?utf-8?B?d1grN2RyOFA1OUtjOG1WNlUwcWNlTU1rYXJnNldtMzltTmRyRFZmbnRYQkx5?=
 =?utf-8?B?VDZSd0NTU0c3R0NPTDRrM2d0ZWNENHNSSEx4bDJOZ05DcFdZbmpuaDgzWWs0?=
 =?utf-8?B?QnQyZUoyaVE0V2s3T1FxWUZMUm9sbkdIeExRMWRMTE9ZWDJnclJhWEU2UUo1?=
 =?utf-8?B?Nm9DV05wNUVHUVN0N3ZzeE1DQXZhRXBMc1BNbjVJUkpHVGFIWTlHSnh1bXJZ?=
 =?utf-8?B?WHloc1dIRHpVVGRubWJxNWhQSzBubFl1QXRyNXN4Tm5QUm8rUTIwVm1ReGFx?=
 =?utf-8?B?dVF3QWVPUm1FVHlhK1hNck5rSlJoakVBM2k3TWtqRVpVM1J4MUdnWHovOG9v?=
 =?utf-8?B?OHRSNWVWTnB1U1o5aldnV2psMzRVRml1ZzdBQjNoRTNVcXFKUHdEMDRIOWZF?=
 =?utf-8?B?Y3JSY1pBTXdScURvNVYxRE5CZW1UdGgwZmRTRVNYSnI2dzhvUUJEMFdPSkxM?=
 =?utf-8?B?bGhSUGdnQnFQNE1mdTY4RFBLdGJ3c211TXpsZnY0R2x0Mk1rL0F3MUpuaHY0?=
 =?utf-8?B?ZzBNVGFQY0xudzl4T1krMllucEhVVE1kMVNkTE56NGhCazVYUHhaME9HQVdk?=
 =?utf-8?B?Si9zUkwyeU9aTE1uWk5ucUt0c1N4djRYTTZtWWxTdXlMc0dNOHdTTnhHUGxR?=
 =?utf-8?B?VXhPbUV4MU1OTzNMUTRXYjgzeXBBejVVRG5SZFRsbDV0TlhmbndYYWJQdENX?=
 =?utf-8?B?d2ljZ29tNkc1cmx4ZGFqQjRPTEFGSkgwcjBtdEpHQm9sMXFvMW5BWHZlbzhu?=
 =?utf-8?B?L3BVY3MwdnZ4THV4RTNiUWRXcUkreWdyeWtzZ3dlMERoUXIxZmVjTCttMU5h?=
 =?utf-8?B?RWJZdllmcUV3bkkwL2pRYjF1aU5xL1E3WERBeHlqRVB3bmU4dDhodEpRWTN3?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <332F8B9ABFB1DE47A6DF1EB611D6C06D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8811cc-dca3-4091-2590-08dbbf4dea99
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 11:35:57.2185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNEqGIqV00/rrEFVOJG/UraWVY+1LBuhvJe9NgF3uAPQh0mY9OZ5aEzayWEuwevLkk4c4ihkDT3GkXwOs5Q1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBJbiBhIGxhdGVyIHBhdGNoLCB3aGVuIGEgY2dyb3VwIGhhcyBleGNlZWRlZCB0
aGUgbWF4IGNhcGFjaXR5IGZvciBFUEMNCj4gcGFnZXMsIGl0IG1heSBuZWVkIHRvIGlkZW50aWZ5
IGFuZCBPT00ga2lsbCBhIGxlc3MgYWN0aXZlIGVuY2xhdmUgdG8NCj4gbWFrZSByb29tIGZvciBv
dGhlciBlbmNsYXZlcyB3aXRoaW4gdGhlIHNhbWUgZ3JvdXAuwqBTdWNoIGEgdmljdGltDQo+IGVu
Y2xhdmUgd291bGQgaGF2ZSBubyBhY3RpdmUgcGFnZXMgb3RoZXIgdGhhbiB0aGUgdW5yZWNsYWlt
YWJsZSBWZXJzaW9uDQo+IEFycmF5IChWQSkgYW5kIFNFQ1MgcGFnZXMuIMKgDQo+IA0KDQpXaGF0
IGRvZXMgIm5vIGFjdGl2ZSBwYWdlcyIgbWVhbj8NCg0KQSAibGVzcyBhY3RpdmUgZW5jbGF2ZSIg
ZG9lc24ndCBuZWNlc3NhcmlseSBtZWFuIGl0IGhhcyAibm8gYWN0aXZlIHBhZ2VzIj8NCg0KDQo+
IFRoZXJlZm9yZSwgdGhlIGNncm91cCBuZWVkcyBleGFtaW5lIGl0cw0KCQkJXg0KCQkJbmVlZHMg
dG8NCg0KPiB1bnJlY2xhaW1hYmxlIHBhZ2UgbGlzdCwgYW5kIGZpbmRpbmcgYW4gZW5jbGF2ZSBn
aXZlbiBhIFNFQ1MgcGFnZSBvciBhDQoJCQkJXg0KCQkJCWZpbmQNCg0KPiBWQSBwYWdlLiBUaGlz
IHdpbGwgcmVxdWlyZSBhIGJhY2twb2ludGVyIGZyb20gYSBwYWdlIHRvIGFuIGVuY2xhdmUsDQo+
IHdoaWNoIGlzIG5vdCBhdmFpbGFibGUgZm9yIFZBIHBhZ2VzLg0KPiANCj4gQmVjYXVzZSBzdHJ1
Y3Qgc2d4X2VwY19wYWdlIGluc3RhbmNlcyBvZiBWQSBwYWdlcyBhcmUgbm90IG93bmVkIGJ5IGFu
DQo+IHNneF9lbmNsX3BhZ2UgaW5zdGFuY2UsIG1hcmsgdGhlaXIgb3duZXIgYXMgc2d4X2VuY2w6
wqBwYXNzIHRoZSBzdHJ1Y3QNCj4gc2d4X2VuY2wgb2YgdGhlIGVuY2xhdmUgYWxsb2NhdGluZyB0
aGUgVkEgcGFnZSB0byBzZ3hfYWxsb2NfZXBjX3BhZ2UoKSwNCj4gd2hpY2ggd2lsbCBzdG9yZSB0
aGlzIHZhbHVlIGluIHRoZSBvd25lciBmaWVsZCBvZiB0aGUgc3RydWN0DQo+IHNneF9lcGNfcGFn
ZS4gwqANCj4gDQoNCklNSE8gdGhpcyBwYXJhZ3JhcGggaXMgaGFyZCB0byB1bmRlcnN0YW5kIGFu
ZCBjYW4gYmUgbW9yZSBjb25jaXNlOg0KDQpPbmUgVkEgcGFnZSBjYW4gYmUgc2hhcmVkIGJ5IG11
bHRpcGxlIGVuY2xhdmUgcGFnZXMgdGh1cyBjYW5ub3QgYmUgYXNzb2NpYXRlZA0Kd2l0aCBhbnkg
J3N0cnVjdCBzZ3hfZW5jbF9wYWdlJyBpbnN0YW5jZS4gIFNldCB0aGUgb3duZXIgb2YgVkEgcGFn
ZSB0byB0aGUNCmVuY2xhdmUgaW5zdGVhZC4NCg0KDQo+IEluIGEgbGF0ZXIgcGF0Y2gsIFZBIHBh
Z2VzIHdpbGwgYmUgcGxhY2VkIGluIGFuDQo+IHVucmVjbGFpbWFibGUgcXVldWUgdGhhdCBjYW4g
YmUgZXhhbWluZWQgYnkgdGhlIGNncm91cCB0byBzZWxlY3QgdGhlIE9PTQ0KPiBraWxsZWQgZW5j
bGF2ZS4NCg0KVGhlIGNvZGUgdG8gInBsYWNlIHRoZSBWQSBwYWdlIHRvIHVucmVjbGFpbWFibGUg
cXVldWUiIGhhcyBiZWVuIGRvbmUgaW4gZWFybGllcg0KcGF0Y2ggKCJ4ODYvc2d4OiBJbnRyb2R1
Y2UgRVBDIHBhZ2Ugc3RhdGVzIikuICBKdXN0IHRoZSB1bnJlY2xhaW1hYmxlIGxpc3QgaXNuJ3QN
CmludHJvZHVjZWQgeWV0LiAgSSB0aGluayB5b3Ugc2hvdWxkIGp1c3QgaW50cm9kdWNlIGl0IGZp
cnN0IHRoZW4geW91IGNhbiBnZXQgcmlkDQpvZiB0aG9zZSAiaW4gYSBsYXRlciBwYXRjaCIgc3Rh
ZmYuDQoNCkFuZCBuaXQ6IHBsZWFzZSB1c2UgInVucmVjbGFpbWFibGUgbGlzdCIgY29uc2lzdGVu
dGx5IChub3QgcXVldWUpLg0KDQoNCkJ0dywgcHJvYmFibHkgYSBkdW1iIHF1ZXN0aW9uOg0KDQpU
aGVvcmV0aWNhbGx5IGlmIHlvdSBvbmx5IG5lZWQgdG8gZmluZCBhIHZpY3RpbSBlbmNsYXZlIHlv
dSBkb24ndCBuZWVkIHRvIHB1dCBWQQ0KcGFnZXMgdG8gdGhlIHVucmVjbGFpbWFibGUgbGlzdCwg
YmVjYXVzZSB0aG9zZSBWQSBwYWdlcyB3aWxsIGJlIGZyZWVkIGFueXdheQ0Kd2hlbiBlbmNsYXZl
IGlzIGtpbGxlZC4gIFNvIGtlZXBpbmcgVkEgcGFnZXMgaW4gdGhlIGxpc3QgaXMgZm9yIGFjY291
bnRpbmcgYWxsDQp0aGUgcGFnZXMgdGhhdCB0aGUgY2dyb3VwIGlzIGhhdmluZz8NCg==
