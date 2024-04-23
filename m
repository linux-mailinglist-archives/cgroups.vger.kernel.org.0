Return-Path: <cgroups+bounces-2683-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DB8AFB92
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 00:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527A62853B5
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 22:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D28143891;
	Tue, 23 Apr 2024 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2opiSzG"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83626288;
	Tue, 23 Apr 2024 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910405; cv=fail; b=gtdE28rQtDNXw6LKAdoEIH2CLVdAQ03NBBp5fDfY9+er/j0dKAZmZmMr5heE0oNzRy8Ufim2t3eXU2R+OSc15s4mCW2VhvCzmyRlZzjR2fkUlASziAD0K5m8CwWcdwTO8Uk9UmINxl2KUGeyjOLJniW0LHv7G491xMAxSWyWYck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910405; c=relaxed/simple;
	bh=Dqsok+mMAIda6goYNF24gQXrp/pnP6FcSb5RRLJJJoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rRgsh54TY9gNGY5UN4XBc4/91vp7ucw2L7b8uXzKEVYDueHoT9PH4Mcr6sOcDvjghbQRoopKTaBkE87iBHkehtlvuXB2h2FJZ3ypY7WuI9zdC3DBHKcbVqnwv8NrjXRPKkT6bDVQzz++K+owjOjgF2oDBlU64LvbtzKpaYX80io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2opiSzG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713910403; x=1745446403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Dqsok+mMAIda6goYNF24gQXrp/pnP6FcSb5RRLJJJoA=;
  b=g2opiSzG2GBkCJtZ5AckuqgINzDmNBFiMJlqdsD0LJPdkyhc1eNGdHof
   bY4ihyiBNhkA/TH5Ys9WHYGyjxKYDD02pR0HXMYHHCxx7iZmQEcAbkI3d
   tSACbpm4vEhs9A8TcvNZ3xnSuUwdKgBi/D9tBq2I1XvV8mk08aDDLitjB
   HVViNUFS3pRBDLVgdo8zDtr/pWn/5/96Z1/7zCpp3KI+rHqr23P90bPKd
   x4W49+MfW/po5Ucx2ukZsosUrekyq/p7CS9hN+UpfgEEJy8+IMaReXpEl
   ZU61+bt6IqxF+sdRtENjHRpdgCPMduGChsKlVuDQa5Od/VXJNPbrLxicw
   Q==;
X-CSE-ConnectionGUID: r8jMAg6PTNq5MKJhzSUc9A==
X-CSE-MsgGUID: N3Nu0K1FTwOIA6u9Gz7BEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="12453944"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="12453944"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 15:13:22 -0700
X-CSE-ConnectionGUID: omofCxmSQ3itsmOgVTn+7A==
X-CSE-MsgGUID: mpY9hhf/R5e7ehBUScXASw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29150390"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 15:13:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 15:13:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 15:13:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 15:13:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 15:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnUEHTU5nCeGf2vmVLzLn4MBe5Q5j4BEhDXm5Rrq5qUFa4aNgep8evK4zGZ8vQrwS4PgStrxd2MNGkMIrpvtamimMv5kO94RG/e1RR1x0LLpdF0rbbnbBaOfAWRqYN/ezVMgzgeGu9C1njJNpgTS+vmYruG7u/oJbyWLkVQ/1E5RSJuC9J5M2mHhHVog7RFmaxLYwa0S515Mbjs3/6QegwnkdoPU1nH+7jdNAANebDMfqt92OYVkLXBMgRfByq/fc8qMgDuiVKLMyZNI7zvxbWFHsJ9Zgb7efWyD2G6KHDbKE9fL88HpYZnKp4hfzXVFksto9FfhkhBDiV1R/KrH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqsok+mMAIda6goYNF24gQXrp/pnP6FcSb5RRLJJJoA=;
 b=LAbKu7dfdOf3PVXV2f5uknLsJjbYvypfeaW1re5fn+DXWpgd0mAv4hgoylVBNDAAV7NEApAAlPUPlaeeNV6Jd/bWI64PWNSPR4zJxxYpRG+IQwrPxzH/w6YU7kMR8sLVBW3/HTJZsLjeA4+/TKZvn46ERY1WyegtomKtD8+sHywG2B8hWBYkk/+CfCCOiJXlUO+LmnGvuZb27Xumfu6y0r9Ukzz1Q/O2fh1SCB3AS8a+WweaID5cZcWSl2APr5jdyqIvQKDdv9WttsbPbIS0mfQBx95eVK5HH87kKclAM9jgJI8GSeFMZgkt4Z2LmDEnzP2FjUjJUx7RsEQwPUttjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 22:13:15 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 22:13:15 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHaj60Hm4kuVj4TEkStIzrrR8Dgw7Fu03YAgAEjfYCAAEAagIAAKb6AgAMWJgCAAQrQgIAAZFmAgAD5LgCAABP4AIAAE9eAgABwawA=
Date: Tue, 23 Apr 2024 22:13:15 +0000
Message-ID: <bdae9afa3e1dd40fbaaf47ad720a57050dda0e72.camel@intel.com>
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
In-Reply-To: <op.2motdpw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7264:EE_
x-ms-office365-filtering-correlation-id: abd527a5-f008-482f-6be5-08dc63e2926f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?WXBEVWFmVVorOUdhVFp5cnVucDlveTMrV25wcDUvT05kci93U1pWblNyM1N1?=
 =?utf-8?B?VlZGa1orNGNYZWFlSjV0M1o2OVdGL2lUY2I1dk5vdVU4amtSVW5DSkFQdURW?=
 =?utf-8?B?NG9BU3hxSlQyb0RPWUZjRGJpOVBVRHRSNyttWnJWZ3AxWnN1eEFZVC9hTTFJ?=
 =?utf-8?B?eTJ2TTkrbGRhWmM1TU9tTEdLbzA4anFmRXVBOGVDSmJmS0R6RklxTUtoSVRv?=
 =?utf-8?B?R2RXYkI4WHduWHJFY3dsM3hLNGRUaW8wK2lYU3BBRTVZSVVsOWpJOW5qSk9s?=
 =?utf-8?B?YnlYUlNzSGtYU0N2dlB0a05ZK21UdG0xdjEyL0k2Wi85bFZlNlZzUmxyT1Za?=
 =?utf-8?B?TTlFQVVhamhaUlZ5dnFkVS9ja0VEMTRFa3c2b1ZiL0I4b3NmbitGUGZxSVZp?=
 =?utf-8?B?VEt1VlN0emw3VjRPZWxLbThVY25wblhYNlVCbTU1MEhuTy9idEhzZVdNVDdL?=
 =?utf-8?B?enV1ejREcmFtS0o5MTUvM3F0NkdEaVhtL0xNN3lSOWNJYlRiSHZ4REYweVFa?=
 =?utf-8?B?SVl2N3FvNnlMb1RoSUkySStsVlBvWUkwWHNFNFdNYlRlcjlUbXVzR0crWU02?=
 =?utf-8?B?c2w0Q1dVV0d5Z2pJOVFwcVRtNzBxMVJxSXYxZmYwWFlhNm41S2FDaytZTGJu?=
 =?utf-8?B?dzVwK1htOHdOUVZiYjJxMGgvcGxkN1I1akFHbzBpQks1U0NMRWhsdHM0NlEw?=
 =?utf-8?B?aEVPeC9aM2VLckhLbkY3aVpoRzhCWVEyRGZTdFREWDcrYndFd2FjOEQ4aFBO?=
 =?utf-8?B?V0R3Tm0wWXgrQkRKejlYbFp3Z0FDanJ0UjBhbnJIdXVMMTNXQTdWYktlZk50?=
 =?utf-8?B?VTJsNXpHSnpDUGRGZnVBSjlORmR3NXZTdmR3L1VxZTZUY2ZvUGJXUHdEeVRQ?=
 =?utf-8?B?SDE5eEpTK252WnRxdktFN2dvOVYvbndNdDYxdzRxMm5sbkd6NHJiU0VuSmsz?=
 =?utf-8?B?d1BlVEVRSHdNdXBCanRtNytLdHZ6NEV5cVZ0a3U3djBKL0c1M0cyMWlHekhS?=
 =?utf-8?B?WlBnZjd5c3l5THhGY2JkUzZzSDlKSlExdHB5a3lsd2VmRHp3TmpYRElwdGE1?=
 =?utf-8?B?RmxHUjNWSXlxem51c0luSFpRSkw4ZVA5d0pkQnl6STJXN1A0bHRaZ0tuR3pm?=
 =?utf-8?B?aGE1U0trMi9TaURxTCsxS0lNTDE0SldoMTNkUFNjaGZQUzA2dlVYaWlHS0M3?=
 =?utf-8?B?UHZpcFowK0VNeHV1eEdrTEJWT0tWdWZmWkNzcjVMYVdNcGZHdmxmb1RmWWFv?=
 =?utf-8?B?SGVwNi95N3dxbkM5c3BMaHVieURDSFhuZDBzVEMzZmlnVUU4WlJ2TzBCTldL?=
 =?utf-8?B?SE9HbWZ4TXMyWnBUWXdoWDZTMlZ1dVdXd0FrckZUQng5azBua0lmTWs1ZHMz?=
 =?utf-8?B?UTUvVDFaNDZSVTFsckdURTMyNmJpY01kalJRcDVLRmhyMFJldjRldGxmQndn?=
 =?utf-8?B?ZE42c2pBbTVGYldEbG11M1YrQkkvaytIektObnp1Z2hjRDBVVGkvZzRjQXpk?=
 =?utf-8?B?c0Z4NHNzREdKaU9IQ21wdDVHdy9KcTdXc0JVRFhOKzFpV3FTaEh5bEo2aDZi?=
 =?utf-8?B?N2ZGR1hheU1wMGZOMFBVSXBhS05qcUkyQ21ycGdqazNQbmdDQzR4Z3RXLzlS?=
 =?utf-8?B?aHBOMFZPSEVoRExCd3JDSmtoajV6SVF5NXB4RE9iWHRRU0V3WDV5L1RNNTNs?=
 =?utf-8?B?N0pobFhSbXQ1ZEw1UkJPc0g5cGIwdDdYK25sN25mNlJiTTdJb1BGUEQvSzUr?=
 =?utf-8?B?c0JhdzZuL3BCRkpHQXV5TldPdmtBOFYvekl1SUtSS3hvZnY2QlczOG9DMDh6?=
 =?utf-8?B?SzJUMmJITW9WdE9tVlRqZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05UbHNpWHRIQnlXTGlnUnlxWERlWHZFM0lsMjBTNFd2S01DMnpHVnJtTGpL?=
 =?utf-8?B?NTdablhxMjd0QlFkeHBQQ3JKaS83cWNVcWd3eGI5cUFuL09SQjJZT1VTRFE3?=
 =?utf-8?B?NzFmVU5xYXVIcmRoWFpSbnI0NWNWaklNZXdKMy9GUDMrQkQ1cWRUdGtWSGE1?=
 =?utf-8?B?OWdoWncrTno5d0N5Z085M29EM0creGtCVmR4Z1d6UmM1K3JxVC96Rk1tZ3FE?=
 =?utf-8?B?NFUvMWFGRmZxWDBJRW56L1l2Wkw3cTZlLzlmMFBEZmdpYjVqcEV0YURiUG53?=
 =?utf-8?B?bk1UeTFuUXFVUTQxWkEvbGIzbFFYWThyMTJHdVh1clc1R3JobjhwdUoxQk42?=
 =?utf-8?B?eWJiMW9UbWNwRnFSbnBUZk1PUThtYS9PVm9ZZUFHa0lOTzdvUjI4djRKNUd4?=
 =?utf-8?B?bzkxZlNUYStZZzl4bzJDTXVUVDd4SE8wQkpLd1R0b0VOaEhwNndFRkp5V01y?=
 =?utf-8?B?a0xZMjdlV3o2bFNucHpkWUxwc0xFdDVVNXI3QWU0akt1b3QzS3hvSGhiS2NI?=
 =?utf-8?B?Z3YrMEFGZnN6ZHRKS3lrQ0IyL0JwTEJzM3hnUm44L0ZCTHNra1d0cGFzaE1S?=
 =?utf-8?B?NTcrSm9YeUl6d2FqNGxIMVV0VExtMEZVdU40d0NXMC9ENkJ0V2Z3RDkvNWlU?=
 =?utf-8?B?S0diaEo1VUY4YWZzcDVqalM1SU0yRFZvY3ZrMUxFV0JKOXdCTlkxRXpMbkw4?=
 =?utf-8?B?TG5iem9nS1kvRlZ4UHIvOWhUNzBmWW9WbUNPVkJlVVdwT0wyMVVad2dVK0py?=
 =?utf-8?B?MzhMbEJuTEQ5TUYwbW5jUlRmUTR3REdTZlpYUTdrSW1velo3c3JVTzlOS3ly?=
 =?utf-8?B?VVQ1Y2xra0lVNFR2M3RXOXhad2pWWkV6WUs5LzQxeDVzR051SEsxWlYzaDdR?=
 =?utf-8?B?eFRTc2hyTGZpU3lielZXNTJPbjZwbjdJU3dtdUQ3eTF6d3JaWWJHSlRvbXJh?=
 =?utf-8?B?eFZhd0hqL0Z6RE5NOFR4Q2o5YkVOQk5Kc3N3eDFqUnBLWkQveGloSFdVU2RI?=
 =?utf-8?B?aURSeHdyd1ZqQnMyV0R6djRqMzVhNjlXT0xjY1B2aDNtMklBVURESmhnNmNt?=
 =?utf-8?B?dmI1T09URGJiRDFDaTgvdWpNSldSelhEMnpBOHE5Z0xVRDFtVzZCZFFGTmhH?=
 =?utf-8?B?RDZBQTVQV1FtczljdllBbHFpNkNaa1dLK1NaZW9vR0FQdGkzanFhRVJIS3Z1?=
 =?utf-8?B?bWhFRWp4cjhBSFp6dHFlTUcyV3JmTmpMWGIyY0h6aTcyWlJkS2M0MHc5dlBu?=
 =?utf-8?B?YWJNa2g4b21rTjdncHpDVis1eVh6T2xIOVUwd1RoUTk4NnZlcGxpQUFtYXdx?=
 =?utf-8?B?QVBIenZFQnhCRFpaQ0xKRVdEN2dwZkNKRUYyZmdjZkdZZW9hY0t4TG1zSnkx?=
 =?utf-8?B?bEVqTUVxejBURG9PMWdCcmVHelExRkpzWTlVbUdRUTBvYldpbWh5T2ZBeUs1?=
 =?utf-8?B?NFZrdm5GOGU4OGVENEVGZStEVmRFNTRUK1lWbHpPN3RmeWNiZDlkUzhkcC9I?=
 =?utf-8?B?Vk83MmNJSjR2MDlUTWFaTVl5aERpRDlMR1Y1ZXhKT1V2WGhzSmNsLy9hbjFi?=
 =?utf-8?B?cEFWNmpWWllaelJDeVByaW16SXFVVldXWlY3M01JZU1RL2xXelVHL2Z6SThJ?=
 =?utf-8?B?dWNWZ1JucXdubDRlVW9mQVBkQ3lKTjZ3Qk84ZkJ3a29mRkZMUkdEUEFhbE93?=
 =?utf-8?B?V1hwcGF4ajJhaE9RTEtIZCt0MjVLbFJFdEZvbEd3a2dJekFZVG9aOHdjcUc1?=
 =?utf-8?B?NW03aTZ3YkxsNm1ibWJFU3h3cmhXWmQ4bkZlTkptSE1NaWNQeE1lcHFIZWt5?=
 =?utf-8?B?ckwyRWpHck1wQm1Wb0haakF1NWpaUjZjcm80aGg1anV4V05MNExoblpFZlRk?=
 =?utf-8?B?VGkwRUxqNVBiTkJBQWxSODJpUGFjZmh0OUgyalFJWFlRR2NzaUFIWmV1SGMw?=
 =?utf-8?B?VmVyYnZDWXM0c1dVVkRkaGlxTU53ekN6U2pRN1FzN3psbThOcEFqUVgyRXdE?=
 =?utf-8?B?TmpZMTZ2czcwVVNzRUtKb0t4bWhPNm9DSVVHRjlBYmZlNTBVYjRoS2tISW05?=
 =?utf-8?B?QWFQdmEyQzF5UVRndlpZOWYyV0RNeWdHVFFOclVqbjNjclhHb2V0RVd0K2J4?=
 =?utf-8?B?bVBCVmdEK3V0NW9wSGc3MWhBekZwUmpzZFdpZTA3S2Fab2loc3VTNUFFUEE5?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <578C8B3409A8464EA38163815E962E18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd527a5-f008-482f-6be5-08dc63e2926f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 22:13:15.0141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouXfBpDc0eUP+j2e0dlSMxAIeBur6PxtZfFkJgO8eYI/nrc/qxo2b68TBl3pCYxE6H5c+ZG/i/Xu14eTbrYykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDEwOjMwIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gPiBJdCdzIGEgd29ya2Fyb3VuZCBiZWNhdXNlIHlvdSB1c2UgdGhlIGNhcGFjaXR5PT0wIGJ1
dCBpdCBkb2VzIG5vdCByZWFsbHkNCj4gPiA+IG1lYW4gdG8gZGlzYWJsZSB0aGUgbWlzYyBjZ3Jv
dXAgZm9yIHNwZWNpZmljIHJlc291cmNlIElJVUMuDQo+ID4gDQo+ID4gUGxlYXNlIHJlYWQgdGhl
IGNvbW1lbnQgYXJvdW5kIEBtaXNjX3Jlc19jYXBhY2l0eSBhZ2FpbjoNCj4gPiANCj4gPiDCoCAq
IE1pc2NlbGxhbmVvdXMgcmVzb3VyY2VzIGNhcGFjaXR5IGZvciB0aGUgZW50aXJlIG1hY2hpbmUu
IDAgY2FwYWNpdHkNCj4gPiDCoCAqIG1lYW5zIHJlc291cmNlIGlzIG5vdCBpbml0aWFsaXplZCBv
ciBub3QgcHJlc2VudCBpbiB0aGUgaG9zdC4NCj4gPiANCj4gDQo+IEkgbWVudGlvbmVkIHRoaXMg
aW4gZWFybGllciBlbWFpbC4gSSB0aGluayB0aGlzIG1lYW5zIG5vIFNHWCBFUEMuIEl0IGRvZXPC
oCANCj4gbm90IG1lYW4gc2d4IGVwYyBjZ3JvdXAgbm90IGVuYWJsZWQuIFRoYXQncyBhbHNvIGNv
bnNpc3RlbnQgd2l0aCB0aGXCoCANCj4gYmVoYXZpb3IgdHJ5X2NoYXJnZSgpIGZhaWxzIGlmIGNh
cGFjaXR5IGlzIHplcm8uDQoNCk9LLiBUbyBtZSB0aGUgImNhcGFjaXR5IiBpcyBwdXJlbHkgdGhl
IGNvbmNlcHQgb2YgY2dyb3VwLCBzbyBpdCBtdXN0IGJlDQppbnRlcnByZXRlZCB3aXRoaW4gdGhl
IHNjb3BlIG9mICJjZ3JvdXAiLiAgSWYgY2dyb3VwLCBpbiBvdXIgY2FzZSwgU0dYDQpjZ3JvdXAs
IGlzIGRpc2FibGVkLCB0aGVuIHdoZXRoZXIgImxlYXZpbmcgdGhlIGNhcGFjaXR5IHRvIHJlZmxl
Y3QgdGhlDQpwcmVzZW5jZSBvZiBoYXJkd2FyZSByZXNvdXJjZSIgZG9lc24ndCByZWFsbHkgbWF0
dGVyLsKgDQoNClNvIHdoYXQgeW91IGFyZSBzYXlpbmcgaXMgdGhhdCwgdGhlIGtlcm5lbCBtdXN0
IGluaXRpYWxpemUgdGhlIGNhcGFjaXR5IG9mDQpzb21lIE1JU0MgcmVzb3VyY2Ugb25jZSBpdCBp
cyBhZGRlZCBhcyB2YWxpZCB0eXBlLiDCoA0KDQpBbmQgeW91IG11c3QgaW5pdGlhbGl6ZSB0aGUg
ImNhcGFjaXR5IiBldmVuIE1JU0MgY2dyb3VwIGlzIGRpc2FibGVkDQplbnRpcmVseSBieSBrZXJu
ZWwgY29tbWFuZGxpbmUsIGluIHdoaWNoIGNhc2UsIElJVUMsIG1pc2MuY2FwYWNpdHkgaXMgbm90
DQpldmVuIGdvaW5nIHRvIHNob3cgaW4gdGhlIC9mcy4NCg0KSWYgdGhpcyBpcyB5b3VyIHBvaW50
LCB0aGVuIHlvdXIgcGF0Y2g6DQoNCgljZ3JvdXAvbWlzYzogQWRkIFNHWCBFUEMgcmVzb3VyY2Ug
dHlwZQ0KDQppcyBhbHJlYWR5IGJyb2tlbiwgYmVjYXVzZSB5b3UgYWRkZWQgdGhlIG5ldyB0eXBl
IHcvbyBpbml0aWFsaXppbmcgdGhlDQpjYXBhY2l0eS4NCg0KUGxlYXNlIGZpeCB0aGF0IHVwLg0K
DQo+IA0KPiA+ID4gDQo+ID4gPiBUaGVyZSBpcyBleHBsaWNpdCB3YXkgZm9yIHVzZXIgdG8gZGlz
YWJsZSBtaXNjIHdpdGhvdXQgc2V0dGluZyBjYXBhY2l0ecKgIA0KPiA+ID4gdG8NCj4gPiA+IHpl
cm8uDQo+ID4gDQo+ID4gV2hpY2ggd2F5IGFyZSB5b3UgdGFsa2luZyBhYm91dD8NCj4gDQo+IEVj
aG8gIi1taXNjIiB0byBjZ3JvdXAuc3VidHJlZV9jb250cm9sIGF0IHJvb3QgbGV2ZWwgZm9yIGV4
YW1wbGUgc3RpbGzCoCANCj4gc2hvd3Mgbm9uLXplcm8gc2d4X2VwYyBjYXBhY2l0eS4NCg0KSSBn
dWVzcyAiaGF2aW5nIHRvIGRpc2FibGUgYWxsIE1JU0MgcmVzb3VyY2VzIGp1c3QgaW4gb3JkZXIg
dG8gZGlzYWJsZSBTR1gNCkVQQyBjZ3JvdXAiIGlzIGEgYnJpbGxpYW50IGlkZWEuDQoNCllvdSBj
YW4gZWFzaWx5IGRpc2FibGUgdGhlIGVudGlyZSBNSVNDIGNncm91cCBieSBjb21tYW5kbGluZSBm
b3IgdGhhdA0KcHVycG9zZSBpZiB0aGF0J3MgYWNjZXB0YWJsZS4NCg0KQW5kIEkgaGF2ZSBubyBp
ZGVhIHdoeSAic3RpbGwgc2hvd2luZyBub24temVybyBFUEMgY2FwYWNpdHkiIGlzIGltcG9ydGFu
dA0KaWYgU0dYIGNncm91cCBjYW5ub3QgYmUgc3VwcG9ydGVkIGF0IGFsbC4gDQoNCg==

