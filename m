Return-Path: <cgroups+bounces-2689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E478AFE39
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 04:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273C1284C1A
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 02:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A32F125C1;
	Wed, 24 Apr 2024 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bX3bnCeg"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310DC13D;
	Wed, 24 Apr 2024 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924824; cv=fail; b=pcRYaVRwBXaP8rIIuJOenqW1/tCEQ6YQFekEW4EOu5lqF56hQsqXGJwuYM349rHPcSmrTLg5yApUQce50pv5YecqExtIoWRX+AYXnGNhpqAQV8KwC8/+BBAufoMS08EzN5psHBi8qcfyerZVCRsWAk4QEz5e1wlWHBT6zXBZIzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924824; c=relaxed/simple;
	bh=NCdga+nq+7Kuq8G2qeAEOKVkwioRTdWwWDZywGNZMw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPqgtZv9aTqviuVcW6JALGSo25vPNT01HkUUDJY+uuo15Nrj/VZWwJxoxipRFRmbUWU8LexXHyI8sLcIPnz6SWYuupHOVQpEC5oJKH4EyyIHy3Ma4RnaMERn6Qd5f6zzLAPNqYOuS72t66Yu7gdQdc655xv5V+DAlq/63vIfx4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bX3bnCeg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713924822; x=1745460822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NCdga+nq+7Kuq8G2qeAEOKVkwioRTdWwWDZywGNZMw0=;
  b=bX3bnCegvRtxTBKl3geVASTix22qy0qiIYPCfvdL309EhauLqhIhii7C
   hLPpjjjw7ytxHMNPwh47U2hGAl9n+6h6lRG4intFsbGXoJidhRy8qpdCB
   zrrI/4hZNso+ghZ6ORVR5P5peK+If/Y3AQv+No6nfCxCJhUEXQXyXLPAR
   0gC1ZYeRGyVNvDs4/Zz7W2aoLX69pWHtAx+PFZW7uIfRallIg08YZwIiA
   ZEQKa0IhsNZbODIWoLqakYxUrBF7RCPq7ZRBctWv6hdDcvM4/OYH0SgJf
   MoU3a5HAMEyIhPa1HGoCrapIeYH2uASub+8vcE8JoWjN6YQkaqIAsa6qY
   w==;
X-CSE-ConnectionGUID: Y3oCMVAqQ3Kj7apX4v0DMQ==
X-CSE-MsgGUID: ektyN8LHTH+y31BBfUhlPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20686252"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20686252"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:13:41 -0700
X-CSE-ConnectionGUID: gX27R6oCTfiFnhtMinCXXA==
X-CSE-MsgGUID: AmX5LT+pTTGAZ5rS8X9rCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24995718"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 19:13:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 19:13:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 19:13:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 19:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1YovgT5ChJCEMw227bArDMUQLGXVL2z+n6myjwuOOgcShj3gfF4W6OXsotmNQ9BDbz/YkMc+q27xJz4sy3v0Facty33ie3WWvFl85MiJTrM4x8OiaHT6FDaGUVDwKQ05ntEVr6ROKddS+bYm29IS0mQZcYpX0P/cu5AzX/MgcraC/RwenjP56BSbkoP2DsuZnhsFhOl4/P8rwZruakt5cVgHbkSxGPld0sh9mwwOYVwyGUDSwBMg0M3rwWBomva+zsOCfAhht/DgWQBg5xxNbDDpUfeD8+mnW/S+psGIlecrApYOBmsf7DkUuRgtS7fSc4nR46lRy59+JenGpm1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCdga+nq+7Kuq8G2qeAEOKVkwioRTdWwWDZywGNZMw0=;
 b=nYr7Ce+f51vj5fQlKuMVTPchm9iRP49sqsnBJLr3FtSsPXS4F3TnwdFtxPfMiD4HBTh1sTfSfXevDbxGazpijf3X976mt0rT2RDOfMQ8mLVaZHCspGU0iGS+mm1YPot6QaaDNPRRmPmCF/hBUsNr3jqNOehDV9u84ynMh5u5XUILKfCEi/py+t0Wo14uUrCFK0a6LHne9/dK1QrcecEUewhGzIEGWCMfLspL7/+Rfp09+pDgVELFwphj7xcKgZFJaUNZPRnnSi5xeLFi8NEH9MkGJsMzH7oFG5QofCwLkujtjOx+gKH/trLMp9OxadZuUty/2TgFuTFmOjtZoHblNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Wed, 24 Apr
 2024 02:13:38 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 02:13:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
Thread-Topic: [PATCH v12 09/14] x86/sgx: Implement async reclamation for
 cgroup
Thread-Index: AQHaj60Hm4kuVj4TEkStIzrrR8Dgw7Fu03YAgAEjfYCAAEAagIAAKb6AgAMWJgCAAQrQgIAAZFmAgAD5LgCAABP4AIAAE9eAgABwawCAACUsgIAAHf2A
Date: Wed, 24 Apr 2024 02:13:38 +0000
Message-ID: <e56216ee4d5f7ef6d97c70f56243a5ddc8dea19d.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-10-haitao.huang@linux.intel.com>
	 <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
	 <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <4be309656cb4e03793703098bbebab3dee93077e.camel@intel.com>
	 <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <e8d076fb097774f1f0fe3365883e6cf5a823fc4f.camel@intel.com>
	 <op.2mm0u7uswjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <914371bd0673870c03e5f4c37db5a2a08fc50aa4.camel@intel.com>
	 <op.2momr8oewjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <be1b1198e05a91b16677acf4037cd52519273529.camel@intel.com>
	 <op.2motdpw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <bdae9afa3e1dd40fbaaf47ad720a57050dda0e72.camel@intel.com>
	 <op.2mph51towjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mph51towjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA0PR11MB8335:EE_
x-ms-office365-filtering-correlation-id: c7289085-5307-4184-f150-08dc64042750
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Wkc1eWNJR1g1MUg2M1dJSTExN0ZvTzF4aDNQdEtyWmhLQjNxZGRWQlV3d256?=
 =?utf-8?B?S2xBaTdZWTRlWnYrUmFHM05WaVNscUdXQjVraktUdHdzYTZMZDQ3WjFCcVM2?=
 =?utf-8?B?b21aNzZzUVBpMTA4aXNrSUdXS2x0NXg3T2dndXhTSUg4QnFQNjBjUVZhM3R2?=
 =?utf-8?B?Z0xPUUNrMnhqMG83NEFGemhBNzZyRWNDMEtKc2JYcXcwWW5Md0dGWXV5M0RV?=
 =?utf-8?B?RFIvbC90YVBGK09JL3Q2YWI3aERKSFdYUkkzRTBOYXFrWGVkbmhRMi9ZRXV1?=
 =?utf-8?B?TEFiYlFIY2Rwcm1KQ1Zsd3J4UGcvVzZOQW5rQ3FEVlBpalJ4c2RzVFVXa0Jx?=
 =?utf-8?B?Uk95dVVFUXYwTlZ4MGlhNmZKT1RjeFlVb2N1Q0EyaVVrNHQ5K3hsNVRUT1NJ?=
 =?utf-8?B?aTRPZXFlU2Q4SXFuQzRPRE1OU09XbjFQUW8yU2dEQmQ4U0lSZndiME5vQk5M?=
 =?utf-8?B?dFIrNmxCM2c3bTVPM1ltTlhmTzBEZTlkaVExQkVVUlorRHQveUpoQXFhUXM5?=
 =?utf-8?B?T1Z5T1FlRUNEQWJRZTVXSyt0cVFhNmRFMGJKYmwwSzRRd1hOVVF0T2wyeHdD?=
 =?utf-8?B?eFFva3RjWm5MNGlVaTVPWjRjeEh1NCtsQVcya1lTWS9HRk1JaW1VSGFvZWEr?=
 =?utf-8?B?QVNaWHl5ZEtJRE5mZmRwdmVaeHJwSHBJWEZaYmVvTnB4byt6VEFhZzhpYUw3?=
 =?utf-8?B?OGU4ZlRmNU1leExQR21XdUVXMXMwaEI1TmN2dGhnRkpSbEFwdWJ2VnlEa05w?=
 =?utf-8?B?THkvaktUdTlnTHZDRkJWS0UwMHFsZEVUMXpvYW5SMmVYMHI5WFhIb2FaSFhC?=
 =?utf-8?B?QXNyZUo2M2t3VjVHdzVxNlNwTjlzUk96UnBxQU9tSHUrV3lZY0dyQW1NTzE0?=
 =?utf-8?B?V3BEQ3Q0OWxVT3EvenliaFpRUU5pQTI2eHBHaWdicFVTak1MVmV5UHVEdndz?=
 =?utf-8?B?V0gyVVJOZGU3SkFXdXhEUUlPWnowRkZuYytydm9RUXlwdGxIajhnREhqMUww?=
 =?utf-8?B?bmtGRWJha0JsTnppTjlxV0lzNExvSEpaWVR6STVyaHUvU1owczU4c0QxR2l2?=
 =?utf-8?B?TVRzVVlnL1UvR2V6cENuTlZ4N1RrNUJxV1lZZXBBNHlORHAyOFZvVHU3Ti9R?=
 =?utf-8?B?SU9nV05UYTFXd2dINkV3R2NLTzYzc0FCWHVRTTd5alY5Y2loZ2FRbW5YWUFI?=
 =?utf-8?B?NHJaNVFmY3Z0bWI5NmN4UHBHdC8wNm5TMWVJSnFYUk8vMHJybjdYSzUzUWpW?=
 =?utf-8?B?alRMckt4RHU1UThUWnpqZm1PMlBDTDliVzhnN0QxeUJQRHZDZStOTnI4cVlW?=
 =?utf-8?B?Wkg5U3Jia3MwTldBVXpJVXprREVySVVOQitkMXIxMGVyTnlPQm5vSTNINk80?=
 =?utf-8?B?Sis5cE9uWTZIeWExMXRvWStmbkhESmpZMjVuS0lTM3NPWjZVUDFMOGViTVln?=
 =?utf-8?B?VjFrNHYyc0hKd2VISE9tOWc1WU9SbEM1aUFTdHFHRlZGdTU3THNmdzFMR2cx?=
 =?utf-8?B?aXppNTM0aEFHTXVwNFk2VXhWekZSSi9WQTFVV1BuR3RBZ0Z4anQ3UVNSQkp1?=
 =?utf-8?B?NkZ4MTZkNkVSRlZpUlRCK05kcW5GMVBZR0trZ3hUUThyMVhLWEdwUGNrNFEx?=
 =?utf-8?B?Syt5NHlNT0c2OENXczg4L2Ivd25Ia2xVQnA4eEQ2M0c0MkNmUjl3c2dVNUpi?=
 =?utf-8?B?bkFGS0hvNVpiSzlnblAvU29peVRFaEErUTg3WXNHdEJvLzdzVmU0ZmNQWm9B?=
 =?utf-8?B?UWk1dDE3LzFsNHV1bXhsUmRxZEVMT3RuRG9UUjhGeFp6MCtEZUszcitvWEpB?=
 =?utf-8?Q?wvfLsTLvLohn8Okshyil8m4fLPHLPHalbV0fs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enFKajQ5UjBsT0FNdEExZERZcW43UE8yYjc4b01CYXFlV2JFb3JkblFsc21y?=
 =?utf-8?B?cS8vSUlpMXdhY2kxdDVFSXlmVmlqamp4WnYwbnlNNFBGaWR4WXFtTHR2bFIx?=
 =?utf-8?B?Q21jOEw5aHdzenhpdHFoUFNmcGhvRFNIaDJCYkNmYTlXQTFGNU9Pc0FFSVZy?=
 =?utf-8?B?Tm1Da2prRC9vRWxEaWFVTFQ3NmZTY3ZnRUNQK3JONXN5UTk0NlRlQmYyN3Rq?=
 =?utf-8?B?bXdGSXhPQVFSVzdJRXNKRnlxa0g1b1hRZDVibW0xQ3dRZU5IckZSNFBtWVRR?=
 =?utf-8?B?QUt4UkZLaUVVdlhwMzhES0tYc29rZlovekxUSFVSaGVMMHRPQXZyMWR5TjRv?=
 =?utf-8?B?enNDRUc2Z2M2TmczZndoRFF5dWMrdzh1UkgrbE5jUHYvWEFhUmxkVnBSWWZl?=
 =?utf-8?B?TVFiaEtEaURwM2I4d3ZSbmRlVGszTS9qRVFOYXVZOXU4Yks3dTRIQ3ozSEZM?=
 =?utf-8?B?MHdtbW1PdHpnMml5ZFExd3ljY3JyWGdOczZFV1pLMjZNamxKMkM4d2FRVUkx?=
 =?utf-8?B?TzNZa1BINy9pL2RjV2xQMTg5cUZ1aHlNQ1FDVFBnbmM4OEVzS29NTW8xZGkv?=
 =?utf-8?B?WmUrSkNtdGkwUm9iTTB6dzZQR0N0L1dIRDJkb292eDJqc05PUVdKaWtmN1My?=
 =?utf-8?B?c0R2VEVVMEk4UnEwN1h4U1BsdUZKRnZzYWE4cE1nUDB1aVRsaHIvQnA3a2VD?=
 =?utf-8?B?dVVBeHZ4dk1INC9oUVZKN1R4TWQ3bmtBaXRIUlhFKzZxeWNZTTYrV0ZmU0hj?=
 =?utf-8?B?NVpkbGRyM1FVdU4wdVNHVlhYMjNBRWxRQ3k1cVpVdE9maE53OWVqeTJSdG13?=
 =?utf-8?B?QjZrajNPS01zRmpIRVJQVjNSMk9SRGV3YSt3ajBZQXlrbHBFZllQVlEzVnBY?=
 =?utf-8?B?VlUrbDRUZVBIZWpHL2oxMHJpdG1JSTROUUorck9RVHJTYWVuVnJIemdrMWlj?=
 =?utf-8?B?dmN6cXQxQVcrTkxuRWRPcE5ka0tha05OWGd5cmdoSVlHWCt3UUw0VWYvay9W?=
 =?utf-8?B?SEFvWWEyYzNVSEgzL0ZqeGRxVkNrRDA5THpkSlkyeXh3WnZtNXE2dkVUdFE3?=
 =?utf-8?B?SEVFUE45V1NGWllRQ0hXQmlFTmhuQm1zYlloNTVWVzFKaDM4K1d0Rkl4R0Ju?=
 =?utf-8?B?YUZIZms2Rm9acDB5VHAyRmhMd0thbUp5eXB5NDNFSXdBTXppMEZ0dU1UMHFC?=
 =?utf-8?B?bzJMQW92UEc2c3BXMnBQZWxIVStwOEJlcm9WUVAzdHgra1UvdGhEd0V3K2hm?=
 =?utf-8?B?WURtdzgyUGVlTEYvdENlNHR5ajZUbnBpWlUvNnc2WWRVT1BKNVh3MjlWZkwr?=
 =?utf-8?B?TEZIdVhvRGZlbXd0TmxnMjBjTmtFUXhIZHhYYkxTbHVURHY4YmJtWjhkSGZM?=
 =?utf-8?B?OVQrZDNsUnluZHRJRlUvWWYreTZJL3VkdUFZU2RoalNienl5Ry9KNnBaMkJw?=
 =?utf-8?B?cEFSVWphQXdISkw5UHE5SHZnTExtdTJDTVpJQm9YVHRTWlZ4S1BzeEEvNXkv?=
 =?utf-8?B?Q2FrMGthVm5JZW5WeWFXb01WSGJNbmMzZVg2OHZnangxeitickxDNWRHbWhP?=
 =?utf-8?B?UGllU0FMZzhDTWZpZHZ5YStoUHM5YTEwM3VJcGFkMEUrdUFOWWpmRGhkcHpQ?=
 =?utf-8?B?RXZ0NldRSUFCaUdWVzdUR0ZMVExYbU92OXFpUER3RGg5dGxxQ2laRHlYdWhN?=
 =?utf-8?B?ZTRZREdVWTR5SFk0WG9lV09MMWxTMFV5S2Nqb2RDb3FFVGZ1b1FkNWtmSE5B?=
 =?utf-8?B?dGtxM1RQWlV1NGxURldYS3lEOHlZNXVaY2ZOdWZqMDc3dE1HODRMSG1JOVBr?=
 =?utf-8?B?YVErUFd5L2hTOVplTmI4bGd5MlhTbW1jUGkzTm1MWFQxdDNPZENqR1Jtd1Zv?=
 =?utf-8?B?MWhBZkgwUkM1MVc2M2FvNDRHTEJzRjBxajlhcTRJcnZHdVprU2g1WE1zU1Bw?=
 =?utf-8?B?TW41YjI0REJSWlhya1VuYS85dkc3K0JKQXBvWUVVQk85Uk1weTlXSGZNeENh?=
 =?utf-8?B?UXVkL2wwZjJBdk43bUVnYVYzTTdjdjIwY2toRUt4RXdRVUpIbUxjWDcyRUpE?=
 =?utf-8?B?bjhZSEsxalJmckhzQ0NKZGx6KzY3QnRJajdmMWFGOXVlZUxWZ1hTSHFJcExW?=
 =?utf-8?B?S1dPNkFWWkFOa1h0TUdKMGZrMnJkMlZ1RzY4R1NQbjZNWnREdjk1L0tmSkIz?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35C7436384B4B54A88EBFAC9657B20C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7289085-5307-4184-f150-08dc64042750
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 02:13:38.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcxZ5VXN35qaN0XE1X1pytfV7spFdTsghiVERR3UuPuoY0hQhEfciOGb/Aw7HmHII9ZLQr2iqOJPP2ws1zcdQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDE5OjI2IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMjMgQXByIDIwMjQgMTc6MTM6MTUgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBUdWUsIDIwMjQtMDQtMjMgYXQgMTA6MzAg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+ID4gPiBJdCdzIGEgd29ya2Fyb3VuZCBi
ZWNhdXNlIHlvdSB1c2UgdGhlIGNhcGFjaXR5PT0wIGJ1dCBpdCBkb2VzIG5vdCAgDQo+ID4gPiBy
ZWFsbHkNCj4gPiA+ID4gPiBtZWFuIHRvIGRpc2FibGUgdGhlIG1pc2MgY2dyb3VwIGZvciBzcGVj
aWZpYyByZXNvdXJjZSBJSVVDLg0KPiA+ID4gPiANCj4gPiA+ID4gUGxlYXNlIHJlYWQgdGhlIGNv
bW1lbnQgYXJvdW5kIEBtaXNjX3Jlc19jYXBhY2l0eSBhZ2FpbjoNCj4gPiA+ID4gDQo+ID4gPiA+
ICAgKiBNaXNjZWxsYW5lb3VzIHJlc291cmNlcyBjYXBhY2l0eSBmb3IgdGhlIGVudGlyZSBtYWNo
aW5lLiAwICANCj4gPiA+IGNhcGFjaXR5DQo+ID4gPiA+ICAgKiBtZWFucyByZXNvdXJjZSBpcyBu
b3QgaW5pdGlhbGl6ZWQgb3Igbm90IHByZXNlbnQgaW4gdGhlIGhvc3QuDQo+ID4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBJIG1lbnRpb25lZCB0aGlzIGluIGVhcmxpZXIgZW1haWwuIEkgdGhpbmsgdGhp
cyBtZWFucyBubyBTR1ggRVBDLiBJdCAgDQo+ID4gPiBkb2Vzbm90IG1lYW4gc2d4IGVwYyBjZ3Jv
dXAgbm90IGVuYWJsZWQuIFRoYXQncyBhbHNvIGNvbnNpc3RlbnQgd2l0aCB0aGUgDQo+ID4gPiBi
ZWhhdmlvciB0cnlfY2hhcmdlKCkgZmFpbHMgaWYgY2FwYWNpdHkgaXMgemVyby4NCj4gPiANCj4g
PiBPSy4gVG8gbWUgdGhlICJjYXBhY2l0eSIgaXMgcHVyZWx5IHRoZSBjb25jZXB0IG9mIGNncm91
cCwgc28gaXQgbXVzdCBiZQ0KPiA+IGludGVycHJldGVkIHdpdGhpbiB0aGUgc2NvcGUgb2YgImNn
cm91cCIuICBJZiBjZ3JvdXAsIGluIG91ciBjYXNlLCBTR1gNCj4gPiBjZ3JvdXAsIGlzIGRpc2Fi
bGVkLCB0aGVuIHdoZXRoZXIgImxlYXZpbmcgdGhlIGNhcGFjaXR5IHRvIHJlZmxlY3QgdGhlDQo+
ID4gcHJlc2VuY2Ugb2YgaGFyZHdhcmUgcmVzb3VyY2UiIGRvZXNuJ3QgcmVhbGx5IG1hdHRlci4N
Cj4gPiBTbyB3aGF0IHlvdSBhcmUgc2F5aW5nIGlzIHRoYXQsIHRoZSBrZXJuZWwgbXVzdCBpbml0
aWFsaXplIHRoZSBjYXBhY2l0eSAgDQo+ID4gb2YNCj4gPiBzb21lIE1JU0MgcmVzb3VyY2Ugb25j
ZSBpdCBpcyBhZGRlZCBhcyB2YWxpZCB0eXBlLiAgDQo+ID4gQW5kIHlvdSBtdXN0IGluaXRpYWxp
emUgdGhlICJjYXBhY2l0eSIgZXZlbiBNSVNDIGNncm91cCBpcyBkaXNhYmxlZA0KPiA+IGVudGly
ZWx5IGJ5IGtlcm5lbCBjb21tYW5kbGluZSwgaW4gd2hpY2ggY2FzZSwgSUlVQywgbWlzYy5jYXBh
Y2l0eSBpcyBub3QNCj4gPiBldmVuIGdvaW5nIHRvIHNob3cgaW4gdGhlIC9mcy4NCj4gPiANCj4g
PiBJZiB0aGlzIGlzIHlvdXIgcG9pbnQsIHRoZW4geW91ciBwYXRjaDoNCj4gPiANCj4gPiAJY2dy
b3VwL21pc2M6IEFkZCBTR1ggRVBDIHJlc291cmNlIHR5cGUNCj4gPiANCj4gPiBpcyBhbHJlYWR5
IGJyb2tlbiwgYmVjYXVzZSB5b3UgYWRkZWQgdGhlIG5ldyB0eXBlIHcvbyBpbml0aWFsaXppbmcg
dGhlDQo+ID4gY2FwYWNpdHkuDQo+ID4gDQo+ID4gUGxlYXNlIGZpeCB0aGF0IHVwLg0KPiA+IA0K
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlcmUgaXMgZXhwbGljaXQgd2F5IGZvciB1
c2VyIHRvIGRpc2FibGUgbWlzYyB3aXRob3V0IHNldHRpbmcgIA0KPiA+ID4gY2FwYWNpdHk+ID4g
dG8NCj4gPiA+ID4gPiB6ZXJvLg0KPiA+ID4gPiANCj4gPiA+ID4gV2hpY2ggd2F5IGFyZSB5b3Ug
dGFsa2luZyBhYm91dD8NCj4gPiA+IA0KPiA+ID4gRWNobyAiLW1pc2MiIHRvIGNncm91cC5zdWJ0
cmVlX2NvbnRyb2wgYXQgcm9vdCBsZXZlbCBmb3IgZXhhbXBsZSBzdGlsbCANCj4gPiA+IHNob3dz
IG5vbi16ZXJvIHNneF9lcGMgY2FwYWNpdHkuDQo+ID4gDQo+ID4gSSBndWVzcyAiaGF2aW5nIHRv
IGRpc2FibGUgYWxsIE1JU0MgcmVzb3VyY2VzIGp1c3QgaW4gb3JkZXIgdG8gZGlzYWJsZSAgDQo+
ID4gU0dYDQo+ID4gRVBDIGNncm91cCIgaXMgYSBicmlsbGlhbnQgaWRlYS4NCj4gPiANCj4gPiBZ
b3UgY2FuIGVhc2lseSBkaXNhYmxlIHRoZSBlbnRpcmUgTUlTQyBjZ3JvdXAgYnkgY29tbWFuZGxp
bmUgZm9yIHRoYXQNCj4gPiBwdXJwb3NlIGlmIHRoYXQncyBhY2NlcHRhYmxlLg0KPiA+IA0KPiA+
IEFuZCBJIGhhdmUgbm8gaWRlYSB3aHkgInN0aWxsIHNob3dpbmcgbm9uLXplcm8gRVBDIGNhcGFj
aXR5IiBpcyBpbXBvcnRhbnQNCj4gPiBpZiBTR1ggY2dyb3VwIGNhbm5vdCBiZSBzdXBwb3J0ZWQg
YXQgYWxsLg0KPiA+IA0KPiANCj4gT2theSwgYWxsIEknbSB0cnlpbmcgdG8gc2F5IGlzIHdlIHNo
b3VsZCBjYXJlIGFib3V0IGNvbnNpc3RlbmN5IGluIGNvZGUgIA0KPiBhbmQgZG9uJ3Qgd2FudCBT
R1ggZG8gc29tZXRoaW5nIGRpZmZlcmVudC4gTWl4aW5nICJkaXNhYmxlIiB3aXRoICANCj4gImNh
cGFjaXR5PT0wIiBjYXVzZXMgaW5jb25zaXN0ZW5jaWVzIEFGQUlDUzoNCj4gDQo+IDEpIFRoZSB0
cnlfY2hhcmdlKCkgQVBJIGN1cnJlbnRseSByZXR1cm5zIGVycm9yIHdoZW4gY2FwYWNpdHkgaXMg
emVyby4gU28gIA0KPiBpdCBhcHBlYXJzIG5vdCB0byBtZWFuIHRoYXQgdGhlIGNncm91cCBpcyBk
aXNhYmxlZCBvdGhlcndpc2UgaXQgc2hvdWxkICANCj4gcmV0dXJuIHN1Y2Nlc3MuDQoNCkkgYWdy
ZWUgdGhpcyBpc24ndCBpZGVhbC4gIE15IHZpZXcgaXMgd2UgY2FuIGZpeCBpdCBpbiBNSVNDIGNv
ZGUgaWYNCm5lZWRlZC4NCg0KPiANCj4gMikgVGhlIGN1cnJlbnQgZXhwbGljaXQgd2F5ICgiLW1p
c2MiKSB0byBkaXNhYmxlIG1pc2Mgc3RpbGwgc2hvd3Mgbm9uLXplcm8gIA0KPiBlbnRyaWVzIGlu
IG1pc2MuY2FwYWNpdHkuIChBdCBsZWFzdCBmb3IgdjIgY2dyb3VwLCBpdCBkb2VzIHdoZW4gSSB0
ZXN0ZWQpLiAgDQo+IE1heWJlIHRoaXMgaXMgbm90IGltcG9ydGFudCBidXQgSSBqdXN0IGRvbid0
IGZlZWwgZ29vZCBhYm91dCB0aGlzICANCj4gaW5jb25zaXN0ZW5jeS4NCg0KVGhpcyBiZWxvbmdz
IHRvICJNSVNDIHJlc291cmNlIGNncm91cCB3YXMgaW5pdGlhbGx5IGVuYWJsZWQgYnkgdGhlIGtl
cm5lbA0KYXQgYm9vdCB0aW1lLCBidXQgbGF0ZXIgd2FzIGRpc2FibGVkICpzb21ld2hlcmUgaW4g
aGllcmFyY2h5KiBieSB0aGUNCnVzZXIiLg0KDQpJbiBmYWN0LCBpZiB5b3Ugb25seSBkbyAiLW1p
c2MiIGZvciAic29tZSBzdWJ0cmVlIiwgaXQncyBxdWl0ZSByZWFzb25hYmxlDQp0byBzdGlsbCBy
ZXBvcnQgdGhlIHJlc291cmNlIGluIG1heC5jYXBhY2l0eS4gIEluIHRoZSBjYXNlIGFib3ZlLCB0
aGUNCiJzb21lIHN1YnRyZWUiIGhhcHBlbnMgdG8gYmUgdGhlIHJvb3QuDQoNClNvIHRvIG1lIGl0
J3MgcmVhc29uYWJsZSB0byBzdGlsbCBzaG93IG1heC5jYXBhY2l0eSBpbiB0aGlzIGNhc2UuICBB
bmQgeW91DQpjYW4gYWN0dWFsbHkgYXJndWUgdGhhdCB0aGUga2VybmVsIHN0aWxsIHN1cHBvcnRz
IHRoZSBjZ3JvdXAgZm9yIHRoZQ0KcmVzb3VyY2UuICBFLmcuLCB5b3UgY2FuIGF0IHJ1bnRpbWUg
ZG8gIittaXNjIiB0byByZS1lbmFibGUuDQoNCkhvd2V2ZXIsIGlmIHRoZSBrZXJuZWwgaXNuJ3Qg
YWJsZSB0byBzdXBwb3J0IGNlcnRhaW4gTUlTQyByZXNvdXJjZSBjZ3JvdXANCmF0IGJvb3QgdGlt
ZSwgaXQncyBxdWl0ZSByZWFzb25hYmxlIHRvIGp1c3Qgc2V0IHRoZSAiY2FwYWNpdHkiIHRvIDAg
c28gaXQNCmlzbid0IHZpc2libGUgdG8gdXNlcnNwYWNlLg0KDQpOb3RlOg0KDQpNeSBrZXkgcG9p
bnQgaXMsIHdoZW4gdXNlcnNwYWNlIHNlZXMgMCAiY2FwYWNpdHkiLCBpdCBzaG91bGRuJ3QgbmVl
ZCB0bw0KY2FyZSBhYm91dCB3aGV0aGVyIGl0IGlzIGJlY2F1c2Ugb2YgImhhcmR3YXJlIHJlc291
cmNlIGlzIG5vdCBhdmFpbGFibGUiLA0Kb3IgImhhcmR3YXJlIHJlc291cmNlIGlzIGF2YWlsYWJs
ZSBidXQga2VybmVsIGNhbm5vdCBzdXBwb3J0IGNncm91cCBmb3INCml0Ii4gIFRoZSByZXNvdXJj
ZSBjZ3JvdXAgaXMgc2ltcGx5IHVuYXZhaWxhYmxlLg0KDQpUaGF0IG1lYW5zIHRoZSBrZXJuZWwg
aGFzIGZ1bGwgcmlnaHQgdG8ganVzdCBoaWRlIHRoYXQgcmVzb3VyY2UgZnJvbSB0aGUNCmNncm91
cCBhdCBib290IHRpbWUuDQoNCkJ1dCB0aGlzIHNob3VsZCBiZSBqdXN0IHdpdGhpbiAiY2dyb3Vw
J3Mgc2NvcGUiLCBpLmUuLCB0aGF0IHJlc291cmNlIGNhbg0Kc3RpbGwgYmUgYXZhaWxhYmxlIGlm
IGtlcm5lbCBjYW4gcHJvdmlkZSBpdC4gIElmIHNvbWUgYXBwIHdhbnRzIHRvDQphZGRpdGlvbmFs
bHkgY2hlY2sgd2hldGhlciBzdWNoIHJlc291cmNlIGlzIGluZGVlZCBhdmFpbGFibGUgYnV0IG9u
bHkNCmNncm91cCBpcyBub3QgYXZhaWxhYmxlLCBpdCBzaG91bGQgY2hlY2sgcmVzb3VyY2Ugc3Bl
Y2lmaWMgaW50ZXJmYWNlIGJ1dA0Kbm90IHRha2UgYWR2YW50YWdlIG9mIHRoZSBNSVNDIGNncm91
cCBpbnRlcmZhY2UuDQoNCj4gDQo+IEZvciBub3cgSSdsbCBqdXN0IGRvIEJVR19PTigpIHVubGVz
cyB0aGVyZSBhcmUgbW9yZSBzdHJvbmcgb3BpbmlvbnMgb25lICANCj4gd2F5IG9yIHRoZSBvdGhl
ci4NCj4gDQoNCkZpbmUgdG8gbWUuDQoNCg==

