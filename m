Return-Path: <cgroups+bounces-4506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A349607C4
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C79B20ACE
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED519E7FA;
	Tue, 27 Aug 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7K3zqXx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400216BE14;
	Tue, 27 Aug 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755565; cv=fail; b=PBh9IVOEY1Cd/hczDXM0QJMg6JBZ0fEde2mxzjkVVrBC3UvruXpxTRclB60E2feG19/a9F3SP2zLskVfNdIftCqGJbdK3OiZLaswxu5Cm5vEtYNSKwWLvtPD2qf8awGILdeIjFEQJ+iGqOmvF+Rv6akFdcB079eqlssAsmBEMkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755565; c=relaxed/simple;
	bh=51zCclIOg7oeE0UlD+TrHgdTNCgkEMRaOdw3150zNew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zwm0/DCHo+PsS8cmdtigcR4PNaYNItUyBeDDBCF8vpp37Kuceml5a2o6q/ZOAYmWHKmsCAWrUA4FKkkDwqKCfxu3/Ub433a86LJEblzCJHVjTyrWrlTAmTa6F8+0UPJQDuyB9MgDYu51iKC88o8o8SJ0M5ATRom++IAmt4Xy8l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7K3zqXx; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724755561; x=1756291561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=51zCclIOg7oeE0UlD+TrHgdTNCgkEMRaOdw3150zNew=;
  b=k7K3zqXxlQyVUDGq8rKePuclNYdXGCiN4FQwZcFKgA8bPySYOYIQpKF0
   Oto991ZvdiUBfY+6Plz6q7cRx+CmMOtqZG0xo7V15jLdFAiq7kUqnxMiv
   6p8gvtQp8+wRBeX0u/G07TchK8Duhf4kTDzBzq7+OH49hDQcF1wWGPnuF
   leQvwli9KyQJpXsNMeB2WiHsbAaM6bjQ4ZIlQmxliPYedJiEgjCesY1wY
   KfrivNLLPk647YXPKhfk6MxcpssMc54N5T6SLs/+5PlxSEO/TsnLXjZ9N
   A0uCIbNu+sjGbmfofhUbR+85ehL3+sSOTVzX9L3VjY78OUVhZc82Mgcz2
   w==;
X-CSE-ConnectionGUID: ark2+sNEQaO3TfrcuHc2kw==
X-CSE-MsgGUID: kXBIvg/9SRa1DWklEynX8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13234532"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="13234532"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:46:00 -0700
X-CSE-ConnectionGUID: aaHlAW8DRKGKy8LNjYdqew==
X-CSE-MsgGUID: zUn3bqP9SjSkdgGvP/JtBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="66966908"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 03:45:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 03:45:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 03:45:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 03:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnZMfywwhtovUzPgatbEsgcGEpmhNsugBmxKNRp9L8ZpAajajmscs8SRDeJ8+qWkH7oR30mVu4tn6gNUCj+c+k0zgaPElb5GjW3Cwd+6dVn0v/LZJPRGoPFmM+I8n/1BOU+dfCDH9OlFYCgxTa8fHsTmypVqF+lGBOoH8T1eqHFp5PoeNfVorQFEy00Z2qzoIVcM9OifL+YFselNIo88PHSD1ED4jXp+72X8c8dud+bU7olmlZME8UON6oulpYAg126cD9pUgIR7axDqkFJsrsTm7E4GqoQaJWG72kaT/nGfHcCez/pFe72dBKCAGM3XA+EfcXzOZ1BGgnU8wX8duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51zCclIOg7oeE0UlD+TrHgdTNCgkEMRaOdw3150zNew=;
 b=r8+BYIT+V8gQ2tYGjUHXaa9DeWy+A7l+wrwfzPGg3AaqK6jR6cOSKLzOTuIK/iyM6pDJait9Ck6/IsxES4Cytmgi1Sr0iyXUmD/AaOdXZEPSNo/cqa5boNeQKASKxYH7oJY3gdApeNOD09QK7pvABNLIPB3SlQHTXCPwJonQd4KHrugWFNOpOHwUKD789qxiEGHYpSnq9yG0xBtuv18Ee/1dD4wziFqpgrQ8CxGV9/1eysvg/r8DwH+4L4nWqv4kyEQFFeTWIloqBJqvtjjW+Z6pMg/rj5kgFIPPJ6yYTKS5qBtOAb0E2A6hNsod/uTafSfdWBvyk4jvbsHYuu7aCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 10:45:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:45:55 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "chenridong@huawei.com" <chenridong@huawei.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v16 02/16] cgroup/misc: Add per resource callbacks for CSS
 events
Thread-Topic: [PATCH v16 02/16] cgroup/misc: Add per resource callbacks for
 CSS events
Thread-Index: AQHa820M+aXPyhARP0at8Tp1xHkKkrI69bMA
Date: Tue, 27 Aug 2024 10:45:55 +0000
Message-ID: <7f078f230face5538206906749e173a2e490b00c.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-3-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-3-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5046:EE_
x-ms-office365-filtering-correlation-id: 890738c3-d231-45f1-ec49-08dcc6856de3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFM4bk1KWnV6QjZHT0VwWlUxU1F3ZnRBZmpRemt1a2JZZEhoSE1vaW56QjBU?=
 =?utf-8?B?MGd4bUcxZXhMOCs2QWkwT3p6MmtXa2xwV3BaRlcxM3RHaVdLNlgwbjk0Y0cz?=
 =?utf-8?B?eVR3dUplenVWa0M1c1JSK1dvMjFXaStMNXlKVTNxNHY2b0sxZDl4MTcxRnZx?=
 =?utf-8?B?NWptaFVINVNHRW9JYjZyUUc1TkFnRi9XTVZKTjBRSi81ZzB4TGtWRjBQcUF6?=
 =?utf-8?B?TTExb3d2eFoxcHJqWldFZFJndHB5UlJ6OURGL2l1eUJrRTNKL0toNEJXY1RS?=
 =?utf-8?B?cGp3YzE5dG9IbEhNRzkrSE43VkIzMFZvOVlSbkxsLy8vT0F2RWljZWpCeFZQ?=
 =?utf-8?B?dkhKNHpDcS9IQ25EWmFpdThoOTBOeEhQVHV1K3EybnNqaHNWQ0RvZkp1NWNl?=
 =?utf-8?B?MklzeFJLMC9xbXk2NiszYWZ2NHBwTGRaaDBCcG1wM0IwS3Z2V2plaFM2ODU4?=
 =?utf-8?B?eGxMTjR3ZUUydENtS1VndnlaZnRkdDVyVVpYdk1Ka2VhT2JsTzhxRGx2UFVK?=
 =?utf-8?B?N0ZseVQ0c3U2dDFkWGk3VXpKUkp6M01pcU9CT0NhK3R0V1p3SERrM0N6WVZI?=
 =?utf-8?B?V3JxN2ZMMmxaaTVnbURDcjhCUloybmxZS2ZnS1dreDMzelg0eXRkaFZoMVRl?=
 =?utf-8?B?UXNWQ3ZHeEQxN3JuTU4rK215aFRqcVJ1SldBRlNiNEVycWYvbGduOStqNlZu?=
 =?utf-8?B?NS9ITHYycVhFNS8zYVpwYUpsN01PKzBTTFM1YXJjalRNUHMvcFRyckdCaHha?=
 =?utf-8?B?cUhMMEVWaTJFdlBMTW1qWVJtUVJjTDJaYlF0VHV3SytGdm5SaERTT0tYOVRT?=
 =?utf-8?B?L1pYQ3djbFZ2bjNkYnpzYU5uYTBRMG92c21jdWJOV3NUbUtaVTdWRjk0cTkw?=
 =?utf-8?B?Mjd3U2pwdG40OHZBejlOVjdlZmt5WHJBalk1OEU2aXkwWXM1ZUI3dXhXc0F5?=
 =?utf-8?B?Qjg0STNxRHhBTXY1aEFKOW91YWZQaE5iMHRmN0JCT2RZODAyK0hkc3JSWlp3?=
 =?utf-8?B?VWtJUkVrTytrR2llbWRHa2c3bEgza1RrNElyR2Q1MFh1SWgyR0p4Uzg3cmRV?=
 =?utf-8?B?RDI3L09waTh3aTFzYldqR3UrSndMNkZydCtxTXlseWZkSjd2Mk1pbUhDYTRT?=
 =?utf-8?B?QVpSd004TlErSUZBY2JKSmhDdUNOM2FNMDFrNTZpLzFiRVA2Q0lYa2wvWllq?=
 =?utf-8?B?cGlJcEVnTDVZbE5TV3k0N0IzVVhKeTdLa1JSWVNMRjVUSmFNS2FKN1RVdDZB?=
 =?utf-8?B?WFkwTHRzSWNZT2RCdndQa3V5VEZaTlJTYmtrMGRmRDNtWG51QzQ3Q05LQVdK?=
 =?utf-8?B?K3YwSWZNUXc3bWZIRG43RHF0K2F1OXdoT1RyeWhMSkFUaVVXc1M1cTE4bjJ1?=
 =?utf-8?B?THlXMU51M1QxNDlMejNNN05wajhKdjNSS2hWWmFxRWs5VHFCcWlzU1VpV2Qw?=
 =?utf-8?B?d3BaOHM2RXZrL3l2U0dXcDliOWErOVlNVTRURTVLUXh2cWpPWktIaFJUNGRV?=
 =?utf-8?B?WnQxbkVVWGRIR1BCeCtxbGFrOTdFYzFKdTZWVVhETnBxMjk2REhJWkRKL3VQ?=
 =?utf-8?B?OGtOcDkvR2Y5WSttR2JKenRlbzhpaVVteVJXQmltNWJFdGpaVTgzRVVETUEx?=
 =?utf-8?B?bGp5bFBXVFdVMFVVdzVDSlUzaEhIdTFHTldkQ3NIM0FiWkR1cDVaWHY2ZnUr?=
 =?utf-8?B?ZG5INWVtR2U5SFJDaHhLUldoamx3VFhpZ2Q5NU9YbVlFUnRBeG1TdmVoeWVh?=
 =?utf-8?B?bTN2eHhUZHhBV3RjVi83UmdzMlMrOWxDcmRsOFN3bmw1bGc5QjFrQnB2UjBP?=
 =?utf-8?B?STZTZ0M4ZGtsTXZsdS9nV2wwdzh0VUZDUzlTRFk4R1NyaElsenBYOWlNMzVu?=
 =?utf-8?B?cks5NGJYT1ZTZ0VmaTFhckU3dW15bmpxSmo1NEJMNmdmSVEwb0Y0Y1Q3YXNQ?=
 =?utf-8?Q?xVswv2s4dYs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjNaNjhhUlVjeEVvcHBmTE1zK3hBbm4zRVYwR0xKTGFoMllGajZPdjRZVHJT?=
 =?utf-8?B?ZjFLbWF5TVRka1B5N2ZDaU1FWXYrOUtsblBzRHRlWmpxTmJKYXgxT0l1d2dD?=
 =?utf-8?B?QWRlbzRQSlZsalNvZm9QMWJsc0dXS2pRdDlxNVM2dXlFUnFvVWZ6ZWxvZm9x?=
 =?utf-8?B?WUdMYkxZbDg5M1pnWTFLME5JWStGRHEzZGZYZkhqUXRROXNpOGpSdVJYYURJ?=
 =?utf-8?B?OGRaMU1jcllGTTFoSTBzUkhmalZVWDIwcGdIaTkyZmlSdHdnYVdaLzNkL3JR?=
 =?utf-8?B?RjREZGRTV0t0dGp5ZnZuWk0rcDlmZVlhZnZSOFdxemNTd3l6bXY3Q1RqRGVM?=
 =?utf-8?B?TlZFRTYwWm5sbkc4ZmlKNHZraTUyQ21QL3RyUmRaR1B3aWtCb2VTaFgyUHFy?=
 =?utf-8?B?M2ZWQ2dyUk1zbk1tN2FJbFpIbkltWVYxcEFQK1NEM1ljb2ZEcU1pMW5xbktX?=
 =?utf-8?B?OFVFcERlYnJBbzNpUkpJSjNoeEZtL2FVQTBVc2MvSFdKM3BBWDVwaldyeGJs?=
 =?utf-8?B?VXM5ajNIUmtsUDdyUTc3SDFJZDNQZkZObW15L0RIc0RuUFg4c01Qbi9NbjlO?=
 =?utf-8?B?cWozUXhNV0UvRm5GYmg1dlNISXBrT0ZTa1ArOWVHSlZHOG1yTlVBT0hrNFRs?=
 =?utf-8?B?Y1laRWNrck5HQTBuK1hHdHh4V0plVkFqRStWK2M5RXhYaUZXbFRxUkpadjFS?=
 =?utf-8?B?OFlnUFhTbTgrZGNjcDhOamljdlJvOXBxSG1ybUVYYTFpZTlUd3R5djZFL1Yr?=
 =?utf-8?B?Zk5vRGdPMXVEbGEyWHRJd0hkQmhuZ0Q5WFUxVXZLNTlvRU5EbjhGdTc3UGdw?=
 =?utf-8?B?TXNLMXRSaG1nOHpFVDdPbmZGc0NzN01ZRlpOVE5aMmlxTW5saHo0TFpkQU15?=
 =?utf-8?B?bDVacGZjNHlSdEtHRTd3Z2pvWU1ZODJBM0lXWGFkeVZVa1NzZjY0WkhIRE9k?=
 =?utf-8?B?a29SSkhXTHVPMEtQVEZIYklEK3UxR0IxcVkwVHA0SHZNRFBESmE3QlJKUHlS?=
 =?utf-8?B?L0IzcnRRd2JhN0tOV1VraFhPR042NGR6aTRVY1AzZTV3UzFsZE5TTmMrUk1P?=
 =?utf-8?B?WkJGV2N6KzVnN1dDQVpGOXBOMWl3Y3RCZ21VQVhEcmpaN0E2TmNhejZIMXJq?=
 =?utf-8?B?ejhUZzhkNlIxSUhLcW13NjN6b2xyVWUzOGxXRFdORnZ5dEtETTF5cGxIOVds?=
 =?utf-8?B?V2h5emduQjEvRFRxSnVtUm1OYWlTbnMxd3N3OGthR1paN2FvWmU5aDlTbmtM?=
 =?utf-8?B?Z1JxMVhHL3JSOG1rd2lRMCtSR2xyNm1RandFT1RsWXpXVlFoQVVpWDl2V2JK?=
 =?utf-8?B?TE5EdDZHSFlHcy9wSVhLVVBjQzFTc3dCT240akpLNk1xZ0tRbk84SmFhVHdG?=
 =?utf-8?B?VFRhK1pPaVZmaFIwb09oejJhY0ROSGF5SFEwWnRNYVRMOTBlRE1keHpUY1lm?=
 =?utf-8?B?QXYrNjBjU0xKaldTTTZEb3RzVEVodXFlZnRlQzdrdlBWQnZCdTE5RjZFdUli?=
 =?utf-8?B?blp6WjJnWU93c1VoRFIyTUZzZXkveTlONTNDWGZSMzZNaGkydTlzdjhZbEtB?=
 =?utf-8?B?cnl5Mkd5K3hQZkR6MmdXc0RDL0o5b2lzMzEweUpVK2Q1T09BNmZiWHRNNFFp?=
 =?utf-8?B?TW01YU1uTkZsWTdYVG9TR0FBU2labkRBZ1dKaXAxUVBmMlBsWFlRUXZ5Qklo?=
 =?utf-8?B?R0JaSUxubDlSUXBMc004cUJnR0JRRDYxSllKaHAya2g4ZXdleUNvMWpTcXNx?=
 =?utf-8?B?bnJQaU80V1RNenRZdmNsVGlZZWxxYkNKL01odDVpejY2NjNwdnh3ZkoxdGZt?=
 =?utf-8?B?ZkRWMFV6eHhsTkh6ejc3K3l0UWoxK3JEN0tzbGF2YU0weTI4RWlsSjVYWmpk?=
 =?utf-8?B?djEzVHpFN3NKZzlzSlRHcFlYTDc0d0RGYlI5bjVUaGxZQWtCTW1aVHVCVUIz?=
 =?utf-8?B?SkNhWnl0U3R6RXducmt2VjN2U3ZHQnRKUlBQMzdTS3RobFkwNlViUUtUam1W?=
 =?utf-8?B?T0VQTEFXYUs1enJmcHZYaGtwb0dYdkM0REVQTEh4RlJ1T3FLZXpUQ1lPd0pL?=
 =?utf-8?B?NFN2V2FGWUw1WlBnd0ZQeW5EdzdkanpGbnF5RVNqYmQ3ZnZvMHQrbzRnem92?=
 =?utf-8?Q?9oAqKLUeVynq74AF0/f3jSGi7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E440032B242E948840293A9E368BBB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890738c3-d231-45f1-ec49-08dcc6856de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 10:45:55.5968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zH2SWEQh3mg0HSyCSSMpp5GZsIzxD0BAYaAUbsPvEGtpNRF/vZ3lNnb/uxsl9TKxhEApm64siwrBquaqmCNskA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE4OjUzIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ICsvKioNCj4gKyAqIG1pc2NfY2dfc2V0X29wcygpIC0gcmVnaXN0ZXIgcmVzb3VyY2Ugc3BlY2lm
aWMgb3BlcmF0aW9ucy4NCj4gKyAqIEB0eXBlOiBUeXBlIG9mIHRoZSBtaXNjIHJlcy4NCj4gKyAq
IEBvcHM6IE9wZXJhdGlvbnMgZm9yIHRoZSBnaXZlbiB0eXBlLg0KPiArICoNCj4gKyAqIFRoZSBj
YWxsYmFja3MgaW4gQG9wcyB3aWxsIG5vdCBiZSBpbnZva2VkIGlmIHRoZSBjYXBhY2l0eSBvZiBA
dHlwZSBpcyAwLg0KPiArICoNCj4gKyAqIENvbnRleHQ6IEFueSBjb250ZXh0Lg0KPiArICogUmV0
dXJuOg0KPiArICogKiAlMCAtIFN1Y2Nlc3NmdWxseSByZWdpc3RlcmVkIHRoZSBvcGVyYXRpb25z
Lg0KPiArICogKiAlLUVJTlZBTCAtIElmIEB0eXBlIGlzIGludmFsaWQsIG9yIHRoZSBvcGVyYXRp
b25zIG1pc3NpbmcgYW55IHJlcXVpcmVkIGNhbGxiYWNrcy4NCj4gKyAqLw0KPiAraW50IG1pc2Nf
Y2dfc2V0X29wcyhlbnVtIG1pc2NfcmVzX3R5cGUgdHlwZSwgY29uc3Qgc3RydWN0IG1pc2NfcmVz
X29wcyAqb3BzKQ0KPiArew0KPiArCWlmICghdmFsaWRfdHlwZSh0eXBlKSkNCj4gKwkJcmV0dXJu
IC1FSU5WQUw7DQo+ICsNCj4gKwlpZiAoIW9wcykNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsN
Cj4gKwlpZiAoIW9wcy0+YWxsb2MpIHsNCj4gKwkJcHJfZXJyKCIlczogYWxsb2MgbWlzc2luZ1xu
IiwgX19mdW5jX18pOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAo
IW9wcy0+ZnJlZSkgew0KPiArCQlwcl9lcnIoIiVzOiBmcmVlIG1pc3NpbmdcbiIsIF9fZnVuY19f
KTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJbWlzY19yZXNfb3BzW3R5
cGVdID0gb3BzOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwobWlz
Y19jZ19zZXRfb3BzKTsNCg0KQXMgbWVudGlvbmVkIGluIGFub3RoZXIgcmVwbHksIHRoZSBleHBv
cnQgaXNuJ3QgbWFuZGF0b3J5IGZvciBTR1ggY2dyb3VwDQpzdXBwb3J0IGR1ZSB0byBTR1ggZHJp
dmVyIGNhbm5vdCBiZSBhIG1vZHVsZS4NCg0KQnV0IEkgdW5kZXJzdGFuZCB0aGUgaW50ZW50aW9u
IGlzIHRvIHRyZWF0IHRoaXMgaW4gYSBzaW1pbGFyIHdheSB0bw0KbWlzY19jZ19zZXRfY2FwYWNp
dHkoKSBldGMgd2hpY2ggYXJlIGN1cnJlbnRseSBleHBvcnRlZC4NCg0KSSBoYXZlIG5vIGhhcmQg
b3BpbmlvbiB3aGV0aGVyIHRvIGV4cG9ydCB0aGlzIG9uZS4gIEJ1dCBpZiB3ZSBleHBvcnQgdGhp
cywgSQ0KZG9uJ3QgcXVpdGUgbGlrZSB0aGUgZmFjdCB0aGF0IGl0IGRvZXNuJ3QgYWNjZXB0IHRo
ZSBOVUxMIG9wcyB0byBhbGxvdyB0aGUNCmNhbGxlciB0byB1bndpbmQuDQoNCkJ1dCBJJ2xsIGxl
YXZlIHRvIGNncm91cCBtYWludGFpbmVycy4NCg0KPiArDQo+IMKgLyoqDQo+IMKgICogbWlzY19j
Z19jYW5jZWxfY2hhcmdlKCkgLSBDYW5jZWwgdGhlIGNoYXJnZSBmcm9tIHRoZSBtaXNjIGNncm91
cC4NCj4gwqAgKiBAdHlwZTogTWlzYyByZXMgdHlwZSBpbiBtaXNjIGNnIHRvIGNhbmNlbCB0aGUg
Y2hhcmdlIGZyb20uDQo+IEBAIC00MzksNiArNDc3LDM2IEBAIHN0YXRpYyBzdHJ1Y3QgY2Z0eXBl
IG1pc2NfY2dfZmlsZXNbXSA9IHsNCj4gwqAJe30NCj4gwqB9Ow0KPiDCoA0KPiArc3RhdGljIGlu
bGluZSB2b2lkIF9taXNjX2NnX3Jlc19mcmVlKHN0cnVjdCBtaXNjX2NnICpjZywgZW51bSBtaXNj
X3Jlc190eXBlIGxhc3QpDQo+ICt7DQo+ICsJZW51bSBtaXNjX3Jlc190eXBlIGk7DQo+ICsNCj4g
Kwlmb3IgKGkgPSAwOyBpIDw9IGxhc3Q7IGkrKykNCj4gKwkJaWYgKG1pc2NfcmVzX29wc1tpXSAm
JiBSRUFEX09OQ0UobWlzY19yZXNfY2FwYWNpdHlbaV0pKQ0KPiArCQkJbWlzY19yZXNfb3BzW2ld
LT5mcmVlKGNnKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSBpbnQgX21pc2NfY2dfcmVz
X2FsbG9jKHN0cnVjdCBtaXNjX2NnICpjZykNCj4gK3sNCj4gKwllbnVtIG1pc2NfcmVzX3R5cGUg
aTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IE1JU0NfQ0dfUkVTX1RZ
UEVTOyBpKyspIHsNCj4gKwkJV1JJVEVfT05DRShjZy0+cmVzW2ldLm1heCwgTUFYX05VTSk7DQo+
ICsJCWF0b21pYzY0X3NldCgmY2ctPnJlc1tpXS51c2FnZSwgMCk7DQo+ICsNCj4gKwkJaWYgKG1p
c2NfcmVzX29wc1tpXSAmJiBSRUFEX09OQ0UobWlzY19yZXNfY2FwYWNpdHlbaV0pKSB7DQo+ICsJ
CQlyZXQgPSBtaXNjX3Jlc19vcHNbaV0tPmFsbG9jKGNnKTsNCj4gKwkJCWlmIChyZXQpIHsNCj4g
KwkJCQlfbWlzY19jZ19yZXNfZnJlZShjZywgaSk7DQo+ICsJCQkJcmV0dXJuIHJldDsNCj4gKwkJ
CX0NCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQoNCkkgZG9u
J3QgZnVsbHkgdW5kZXJzdGFuZCB3aHkga2VybmVsIHVzZXMgUkVBRF9PTkNFKCkvV1JJVEVfT05D
RSgpIHRvIGFjY2Vzcw0KbWlzY19yZXNfY2FwYWNpdHlbaV0gYW5kIG90aGVycyBsaWtlICdjZy0+
cmVzW2ldLm1heCcsIGJ1dCBpdCBsb29rcyB3ZWlyZCB0aGV5DQphcmUgbm90IHVzZWQgd2hlbiBh
Y2Nlc3NpbmcgbWlzY19yZXNfb3BzW2ldPw0KDQo=

