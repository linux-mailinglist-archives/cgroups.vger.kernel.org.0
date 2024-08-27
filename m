Return-Path: <cgroups+bounces-4505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCE96075C
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 12:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1627C2815C9
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF219AA46;
	Tue, 27 Aug 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gm5O3i47"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BE8F54;
	Tue, 27 Aug 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754322; cv=fail; b=oWi/RPc3Aruu61BPBetdx6itnBMVZmGef1KDIpS1ApIguoeP0XcNblQaD52Rkg8riuwumG0Hantuw3wXH9aEioZcV2r12a58jlKgEQUTGA3q117/sVfDJ8W4FPzZvRLPgjfgahf7oEBnTa3huGpM6Nrh6GuGCl9HdT+pYpfb23Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754322; c=relaxed/simple;
	bh=pNJuntS8mk6o9+YWWqdlbDHEANO34g5TIo6KFxDnu6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=abFqza4NyzvxR6yS86ylexbDRahXlb9UUVxsCi+G2oycCAxuMNd4XLeNfB6wMyP4xFydc8+9kLgUfwbu4XAbAm8cf7rrNl3Tge27GiVyQRsUoXJZ8troNI4wpxYNuPPlDEWT3tnEYuOIom593Uc6l9HOA8CvbG9S+7hNAau6I2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gm5O3i47; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724754321; x=1756290321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pNJuntS8mk6o9+YWWqdlbDHEANO34g5TIo6KFxDnu6A=;
  b=gm5O3i47Kt8jeKUvh64719zEnDil+EoaYUZS97EtVCqzMdjouPhXoz6G
   Uc97rsj7kujMZylaRRgc7qB7QTZ/NKf++Nf9SWbVtwIHAky/aKa3x9SI7
   LrTryemIMgqcCH6ZNhkAMmWehGOs5iVadkndNeK0o6UOtdvIs2sKivx62
   ehyJOQLpShZ8PC9SuAPOI2H+QbomRlJA0uVOP764ZBAUBo5mj97XBID/V
   Cl8D9MS36Mzd2s93ynKnuAZr072hQgMcDTXzXSXualOhoiL+23oEuPIGl
   Bj5rOKfKmZn90fefVCWNy8J3uz8U8uPOWgnOOYdO5Pojddt0HPlrDBiNa
   g==;
X-CSE-ConnectionGUID: VZtwpnBrS2CkTpIPm8MU3g==
X-CSE-MsgGUID: gLOg92Y9QO+OlvVBeurZkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23189451"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23189451"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:25:20 -0700
X-CSE-ConnectionGUID: EvGBGDTETGqoa5JmJTCoAw==
X-CSE-MsgGUID: slTtRldDSJeVfbaWBTU5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67696355"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 03:25:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 03:25:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 03:25:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 03:25:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u64jcUV5Xj4HiF3yaCKk99IB6TnuzA1x5gGZT32PR6NCTsN9c1mvbdpzoYyjrxhtWUVVlZJRta0AHMpu7PuVuPmsKXmGzKKkp4+wIT/UV8KJZMmsoJNH9y3C2L4lX9C7nQVM1fA1Elav/SjgM0x0nHS/pSyJQ89L7UILookzu1dzSH8soILdI6eyeLDb2ddS+xVnkpBEx28qCfi9DaGxo4zgFUxaz6bYttbnY4byLq4e6Np9ipSjGboJYEsL9jlYdNjfw9i41fm5caKKKaKztOqX0YI9YJascBewJrvERy6cnfs2MB2m4yuHJxFB3Dg75I9TprEWV6+JBBSsGbp9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNJuntS8mk6o9+YWWqdlbDHEANO34g5TIo6KFxDnu6A=;
 b=yHnSICknxcgTUJ+Yz7HRtlPhQjWSs6ylI39OMq3ylpJ5HSt1wN1kUzRLbTASyXO+sajCnc5v3IDrANU54Z+IINWZU95QDZc6MnJak3bliiHwzf0dWYKGguxQAUyPrLQ1zw6VBG5S5+bhg9m5LqnuF8yb4/XH/h5rsSO8TlvUhVTriuBe5guZ5ryXjyrUC85aMqfVYjMAxwych8KmEB0ibK43vmC+Bkwq7eu4x5yI7LXL7TlaBTJwdWgIylvJS++8LKe7sdAt0v0iSA1LdvniNKJruTvCF9l4j76ecaidfi7A7Ai4HsOPd3ESZMJ29Gspl7gcKVPnM1AsslTgcUYpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 10:25:16 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:25:16 +0000
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
Subject: Re: [PATCH v16 03/16] cgroup/misc: Export APIs for SGX driver
Thread-Topic: [PATCH v16 03/16] cgroup/misc: Export APIs for SGX driver
Thread-Index: AQHa820Mt3MzRDJHS0Sw6xE2ToCdtbI67/QA
Date: Tue, 27 Aug 2024 10:25:16 +0000
Message-ID: <6ab51a49acb69b90499465c2b00b93eda501862c.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-4-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-4-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|IA0PR11MB8378:EE_
x-ms-office365-filtering-correlation-id: d14b33ef-a8fa-49b3-6cd5-08dcc6828b63
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXl1Q1V5NUhHMzV1STZlekErZTlqOFhlaklla1ZLY2tsMERDbnV6YXpxa2My?=
 =?utf-8?B?VXlIemxDYXFqcTkrZGViNnBJTi9YYmlEVE5YVG5lSlU1dnNmVFdiMjBXWmZx?=
 =?utf-8?B?RDJMdE44NzNYc0VrRkp1aFdmdTQrZGNRcXc0a1lvdFFKOWtvQXY5U1lMYldP?=
 =?utf-8?B?SzY2bldqWU0xelA2cnFsMVR2U1l4MlBnajRMSnN0VS9JZmxpUmxSK1cxbmpS?=
 =?utf-8?B?TVhzWWZkSUFDa2VxUlI3Rjg3aEpUWlJyRjlkZUtpNFdvVjIrTmVQWUJZejJB?=
 =?utf-8?B?WDdzMGlzMHJaeXd4ZUpuZEYvOHJrVkJUME10UG11UHg0S01hSHd1a1hGTXJh?=
 =?utf-8?B?bU96cmtYZEcxZ3Q5Qm83NEw5aHpVQytXNDBIWHpIZlVWeTJ4VEpWbDFZaDdT?=
 =?utf-8?B?MWh6UW5YM2Q4Yk9KazdGTXBzVGViZHNFcitKT1J4OEtoUFdGQlE5dVFaWTc3?=
 =?utf-8?B?OU03Vis4c2VVYm9oektRc0VwTlFQbXA3TjdXaGw4UWRHTDY5WURiNFM0QjUr?=
 =?utf-8?B?dkJoMkxwMXdUZzJINnVTQWZiTWVWcS9OOUVZNjFxdzZOZTZhQ2pDUHlNYito?=
 =?utf-8?B?Tlg1WmlMcWJ4L20zNktMWnpiU2FIVnZOMm14MFVITGtsVDhoa3phaGNFZjNG?=
 =?utf-8?B?d3RBekdIVUd1WVE2Z01Xd3Z4OW9FQUtkNmJmUkpsa2t5UnVJRjlGakpvSDhB?=
 =?utf-8?B?V2Ftcm1ZR3I2ZW1jYnhZNE91ekNFaVU0UzA0ODU3ZW10VDBxdCtTL2M0dVZS?=
 =?utf-8?B?bnp2dWRqMkp0bzdic0RRak1OSkJGMHplNUZjdmdkUWlxVlhBUEhES0pJV2Z4?=
 =?utf-8?B?ajJvQjA0YnpVTzVsQ1dZYVhtK3pwb0NtcGNrM3ZpMXZRa2xGck9ZdkRHaFA3?=
 =?utf-8?B?cGQrY05LMFNLZnY5VWJiUnVTTkh3OTBrdjJ0L1VOUEtHNW8xdkpzaG9QMlN1?=
 =?utf-8?B?eW5rQ0VLT2dBYjJpVmRHUTdYWnl0UStWb0xDOUJrM0NzREt4SzRFcERnRXhr?=
 =?utf-8?B?UVBiQ1VNd0JJUVI1a3VVUTBLMlZ5bkNmR1hRdmIvQ3lVT29peHUyY0J2RHRU?=
 =?utf-8?B?OU4zYkplM2k3NkR4dFArVzFCKzZPUkw5YjAvRE5BR1pmclRvVEJYUEgzU2Q2?=
 =?utf-8?B?ZVdLbmI5SjRkUU10S3FEYkY4aWFRWEJLRHZqejEzMUJVSkFhNGQwak9Janp0?=
 =?utf-8?B?M1VpRG1VaENxVllPem5lNktjN2lOdDBGeVFGUndmYTVBUkxQajRDUFh6VWFX?=
 =?utf-8?B?RjJHaXlQWGxnVjA4UzRJeEhHaG45MmM0WnAxbjhJTERIOU52RWNKSjFwZGlH?=
 =?utf-8?B?aUpkRVBLTC9YMFMwOTRMSkhVNVIwT1RGcFIzSWQyWjJvbDVpaXd4bE0rMmx5?=
 =?utf-8?B?MWFoTEFkRGlhUnR0dHpQWE0rRzkxMVFkV2RTS284S2VkR1hiaHJXc1h0MWkw?=
 =?utf-8?B?a3Q5UDA5K0FBbjZKUStJeXBWRUo2NmFFRllGMHlNUE1WWEZmQzhCUjVkVzlI?=
 =?utf-8?B?UlRiQ0VGcUY2SVMzYXgvSUIrcFRTWE0rUnhmWlpGMnBxVGlwTFV4ZGV0ZmNp?=
 =?utf-8?B?M0RLV0RlYTJ1TkNnbFBsenBqM1ZIUlRxWVdpVW5XVFdtRFBTSTk5SkhOOEho?=
 =?utf-8?B?cmx1VTY1K1dnY0N0blZYZWI3WFZyRmNCaUtmWG9MUzFRaFRhMFlqd3dmeFRG?=
 =?utf-8?B?WlV6OVF5enhtSVB2SGFTNkhJMml1bzEzYjkrejZQYkhGejdoUHJwZ1c1UTRN?=
 =?utf-8?B?RTJsN0diTkdTN1loN0dVT3hlYVpJdHlWU29SQ0tIWWd1a29LYW1xWUlHSENq?=
 =?utf-8?B?TFRrdHhhK2RyK3dRYS9mRGtvZWtkclROYW5NTi9wLyt3TnN3ZWFlelA4VDZE?=
 =?utf-8?B?SWpyKy9pMzVKdktzQ1hUaHVlK0ViZW1hU1hkSGlzaFVkd2l2MlB1d2JSWXAy?=
 =?utf-8?Q?IK55W/KXRvw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2Npcnl2UFNicjdhY2xnSnFqaVVzcVpoT2RBaUVOWGI1UVJpdDJrMm52TnNy?=
 =?utf-8?B?b2ZnRnRqTUVXdi9zTGRCbGNnbjdHOCtKeVFSQ21ZV3Y0SFpaSWlWVSsxN0Mz?=
 =?utf-8?B?NlFjNWpiMUJIRWt4cnMyblQvdFVlL2F0UE5mQ3VVVTRqMXpYcEhJNElpMkVy?=
 =?utf-8?B?Tks1dTEzSTYrWjAxeStFT2xPRGNUaWNsMVB6YU51ZlgyUlBJbkJqUTQrYmph?=
 =?utf-8?B?TkhNSE9xRkpMNHBMSlhzb2hWV1BqMW5iVWxpUzZ6RHgxbUY4eWFyekRMOVNl?=
 =?utf-8?B?N01SVkhsSE1INUZSNVpsbmlDMEd1M3lEWGE4M0lVdlo1RUxlWlNCN2ZGTFFs?=
 =?utf-8?B?NjBrUGJyZjFWUkp3Z1g3eGE4d0FoL09VOTlZVzRLZjc5ZGdUMFBYZUQrRXhH?=
 =?utf-8?B?MnBmM2NMSUlvc0NESHJPSytBZ1NMYnBxYjdJYVFWZW1ta3lUVXo3eVhISC8y?=
 =?utf-8?B?dkdkR0F4ZUtFeDdIQXZKZU5QWExMYTRmTkNsT0VYYm12bnRySCtnbEw4b0tT?=
 =?utf-8?B?K1dZaXA3Z2R2UjVnZStXWGxERGtoOU1mVTJtWmgwakwvSk5rNS9waUVMbHZQ?=
 =?utf-8?B?QUVPRjd0R1NpTmM3VzlLbUtPMVNCL2JMTHgvYTBaaXVPVVRNcThoNVpHZktV?=
 =?utf-8?B?Rk9LQXBoTXFNODFmanNxbHZxRVBHREozNTh1K0xiM2M2SkhkWXNNYnpRM0Jl?=
 =?utf-8?B?U1VPVHpFNkJ4WFdZd2ZaVkFyRm95bXlXVWJTVmI1UXo2OGYxdTBkK1BBYVFi?=
 =?utf-8?B?YjZzQjVSbk9yNXBsVUxiUWhnejV4WU5qZWN6STR0RTYwTm8yc21HYVhvOFBB?=
 =?utf-8?B?ZmkyOVQvV1Fhci9Ba1ZMVVh6SEtSTDdBbnoxT1NCNGhsSnVXUGZscW1jL2ZE?=
 =?utf-8?B?QU5FSnpKOVlLMEY0VXh5L3ZnVlNnSFM5OThheVdGdFJZQzY1TFBGUGNidXpG?=
 =?utf-8?B?OWR6M0xPTXJJSTZHS1pxQitWTEVSbXlCZmNHTlZQaVh5elZoVU1TZVhiK0Vu?=
 =?utf-8?B?WVBNYUhPUjJ1UW5HSUxkWUdZdmJGRXZSdGpHdkI1ZmRJRzMybHBWRzBnblpP?=
 =?utf-8?B?bU40azlpTVRoOFhOY2JycVpQeC94eElOa2NJSDJUelpyTXY3ODcyOEVKcUVm?=
 =?utf-8?B?YmZwYXc1SGhMZW9VbmJhWElJR0lSVGpDcTNuZGRYTkd5N0k2TnVKR0Fpc1Jw?=
 =?utf-8?B?NW81Uk11d2tuZ1BGcW5SWmNDbTJPSGxnOXVOMjBqREFnVTgvUnFkMTJaYXk0?=
 =?utf-8?B?bUZoUUYreWlUdk01UEQ0a1pEeE4yUmtMUlNNbUNYbzQyREttSTZnR08rVlJ4?=
 =?utf-8?B?YkJ6YmtxSGZkbHowRWFsVHZ3SjArVGRsaFZ1RTBhL3ErN2NXK0FMcVd4MTdO?=
 =?utf-8?B?d3ZZVGdGVEZYeWZEM29JTXI3azBsZUJkZ0d5TWhWN2NkQUpHV3pXV3JobHVE?=
 =?utf-8?B?SUlCNTVMbnJORFAxUXJKZXEyenZOWXRvdDFZa1JKZ3V0SWZIUjNzYThvbjVW?=
 =?utf-8?B?SVIwY3htdVprZDM4d2laOU1ZWXF3YlhxekRxMHg1M2pHL2I5eXVzNnBTWGNK?=
 =?utf-8?B?ZC9DOW1oN096YTBweVBYQWhMQWdKL2w3VWlnL3g0L0JqRk5KeFBuTlhvNXpY?=
 =?utf-8?B?ZU1uSVpwbGhzOEtqRkRleEQ5N1dWMEJJT2tNWEoyc0dWWEtsNGF6czhZWEVs?=
 =?utf-8?B?eDhlMWtMeGkxN0JsSDBGL3hmQnFjYzFuaHNHRmg2SlR5N1VTakp5SDNNS0Fi?=
 =?utf-8?B?N3dkOEZpWkJDV0RFL1pQQXg4VXdnSUZvMno2UWZMMHVWVkFyU0xza1RYbG5q?=
 =?utf-8?B?RE9mSm9yNXRiOTk5QW1aTk5Qclc1ZjdOWExvQlZ6S2ozdkR2OU1ZUVVHUlND?=
 =?utf-8?B?OUFmZmxUREhPU2ZydHNmZEMwcW5RRU9Wem95SHZEZk9zSFdlR3ZJQ1crdFds?=
 =?utf-8?B?VUhTZ1JrckZxVUFzdjJGT1VrNFRnWXBMeC8rWEE2U0dEblhhUitPeU5hSHZi?=
 =?utf-8?B?VDVjRVE3dSs0Q3pwdGN4b0J2RVFES1NoSDA0T0pzR1h2WHdqQWl0NmlJU2xn?=
 =?utf-8?B?RGI0aHlSME8yOW5WQmw2KzFRZjVKckxGUjdtVHNyOFBlVk5GbEptZzhmTGVp?=
 =?utf-8?B?ZDJWSlJudVJ2OXVnZ292R2RTL1FKT016VWFaT2tlaDdMa0pPZWNrMmVnbGdj?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <589D09D742457241B5F9C0CB134C1BA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14b33ef-a8fa-49b3-6cd5-08dcc6828b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 10:25:16.6103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecOVBgfg7m3JwIEs1Q6/9VER8rY9nJOjgkVkCG4A5AvASN67H1xDYKOCP3rwuT76VxZR2BGKFJKdQ9sTVcoVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE4OjUzIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IC1zdGF0aWMgc3RydWN0IG1pc2NfY2cgKnBhcmVudF9taXNjKHN0cnVjdCBtaXNjX2NnICpjZ3Jv
dXApDQo+ICtzdHJ1Y3QgbWlzY19jZyAqbWlzY19jZ19yb290KHZvaWQpDQo+IMKgew0KPiAtCXJl
dHVybiBjZ3JvdXAgPyBjc3NfbWlzYyhjZ3JvdXAtPmNzcy5wYXJlbnQpIDogTlVMTDsNCj4gKwly
ZXR1cm4gJnJvb3RfY2c7DQo+IMKgfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwobWlzY19jZ19yb290
KTsNCj4gwqANCg0KVGhpcyBkb2Vzbid0IG5lZWQgdG8gYmUgZXhwb3J0ZWQuICBTR1ggZHJpdmVy
IGNhbm5vdCBiZSBhIG1vZHVsZS4NCg0KSSB0ZXN0ZWQgYnVpbGRpbmcgdGhlIHRoaXMgc2VyaWVz
IHdpdGggdGhpcyBleHBvcnQgcmVtb3ZlZCBhbmQgdGhlIGtlcm5lbA0KY291bGQgYmUgYnVpbHQg
c3VjY2Vzc2Z1bGx5Lg0K

