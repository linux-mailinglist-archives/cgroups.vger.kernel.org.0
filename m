Return-Path: <cgroups+bounces-2666-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8888ADE24
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 09:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09E4B21617
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68546439;
	Tue, 23 Apr 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B239KkcP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49F47A5D;
	Tue, 23 Apr 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856918; cv=fail; b=YD5Fq5vu0iLHB8XUBm10ekAGEZuKiK/izeFSYJpcU+pFjIKwDsZMaRJSg7M5XcRJ4cRbKlBRMt5M/vu/EgMzZ6l4FwaA6nwjEbbzEAN2zZOOD/cfzb18EwSdozXykO4MnM/bo1LfucOBwMTLgFwEEExHTqTPab+/8m3RKeUQMLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856918; c=relaxed/simple;
	bh=EiYhzrBoRrmdPMvWuJLTGmriOS/7rABLu3SnpuRHXLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s8veeI4ia3nkXYfwK5lYVjRrhZZkzyAYm6CF+7guunumZGchWsfWQmSOlDajJyuwbdyjYfZZR7Ts67L6z6ZQldtlU3gyKAxT0pOebJCiU+yyWT6C1GD4J+cHOTNwbJ2Mkg2uV4HZZwcX39B4B2AG8cWf+rlxdKdHW2Ze7q9pG4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B239KkcP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713856917; x=1745392917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EiYhzrBoRrmdPMvWuJLTGmriOS/7rABLu3SnpuRHXLE=;
  b=B239KkcPG2z62a0JBF28qJu8AWWElxM6UobULI96Pj7qHX+MFwg37k0q
   PWv86IKHZRQwLTCSzScMBAFYZGQpvbdLF37fNWsvnbvAxZnyck8LqrrDH
   uLtxK3nH3UMTyXM1YyM5MvEvAiqx714t+E/qLg5f62dSRHFMmYIvDQwEK
   OstseUN67eY035vK3z5Qyl24jsWSOAKko0ajfGUvp7y6O9kD9hqsKFMqN
   ZQccTQQ04G+nF/iukQJCa7XKIDkYS1Oh6CpjUjdszIDmqpp3CVnFxZsB1
   GdorM/4oVStS3WkyLkVvQEVWFiCzvkAphB04Uvrka6va7xh372Jdq7Gg/
   A==;
X-CSE-ConnectionGUID: Le0RH3POT2qB8IhBmz0Iwg==
X-CSE-MsgGUID: VTUwS2buR1iDtAykJ3sR3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20121233"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20121233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 00:21:51 -0700
X-CSE-ConnectionGUID: w8AGmZDFS9OzzRv4HK7pxg==
X-CSE-MsgGUID: ebDXCi62RCinke2SQOyEpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24324991"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 00:21:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 00:21:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 00:21:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 00:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeyt8hZ6SCn5leVXuDJHrdT0FbCBgoL93sssYms7DWlE8gMGyRpn+UX54YjtRpR/MgHns0ge9Kxv4V1OgLiA509pe+v3GmYQvopPRDcTGautS8y3qtw10ucQ4fXGqrFcCefIBM0qHyaWHhb5ppW9KaUxIpoCvroPaqN74xrzCzVuh4r6wlveKRG87eXzajXfINf5H+CTmuezf2gnBHAezuvkMQN40nXNDgOEe6e2mBcqoPBaLRCcKcCjvKaM6/UAMjZmPmuHEu3TV9BnDtRNok8uhfKvMweYdCPacWyjqdpj2b+OhF4yp74pozjDgFt6SWM0cZLAcmVjKocQebThgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiYhzrBoRrmdPMvWuJLTGmriOS/7rABLu3SnpuRHXLE=;
 b=ibr6J7xCK8Va0DzYbufOgeL5bBUZSuSeVMRT0NXQWENXICL/mR1QzlcpY5Z0Xzn8l+/Kuu82ZIl3vdfn6/WxvGMfkAbfI3Y54I1vWQhIvMwt5elP3+deavyHqSRuxE+kNOHVB+XByY+WmJlilFMQLWWSKqlpEWE25IBghqvzHgTz4+MwwMUBqujD8XSDMCRwu/Q0okuZl6LIYEuGzks1xbRXDFpmxnNOqap/pVCJ2k3CFyzDk9CrjGF1gx4LYxUjdCiDlm/qoe+GOLhWpGo9n1tvQxOxIZJWGFWeT2xGr8mTN+FYV5SPa9SkHyEtew5mwN2nvvYzXxYEPaCzVt4yTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB8121.namprd11.prod.outlook.com (2603:10b6:510:234::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Tue, 23 Apr
 2024 07:21:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 07:21:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 10/14] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
Thread-Topic: [PATCH v12 10/14] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
Thread-Index: AQHaj60LDv26oAq7TkyoQ6/9PIaxD7F1fmYA
Date: Tue, 23 Apr 2024 07:21:38 +0000
Message-ID: <1b72ca7675ba0f9e81cbcefaca24a57415fdd5e1.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-11-haitao.huang@linux.intel.com>
In-Reply-To: <20240416032011.58578-11-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB8121:EE_
x-ms-office365-filtering-correlation-id: ca881574-6bc2-43d9-7ebf-08dc6366043f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?VnVJeW9FWGJkYlNWT0NNcEFNdVJDUTdLNVdnUWtKOVhYcHRFaEFBZXhramg0?=
 =?utf-8?B?RmpKNnZxRHdKbm9SUFdodmdoa1hkZEgrVXdCWm9iMHBtR3l1ZmFLZjJ1QWow?=
 =?utf-8?B?M2N6Sk0wdEx3YVg4NlpLakx2ZWZENmwyNjFobUxwNEdJMVB5TGRoTXRaVGVl?=
 =?utf-8?B?bVZFUjBNYmF2R1VBN0dvT3ZjSm50UGVxQ2VjWFZ6alJUNXJRVEZCZXhPQ2N1?=
 =?utf-8?B?V1gxTmM1cmpvNmpBOUJxMHFWVTFscXB2WStJbGR2ajdhTDhMK0NxRGZRYWh1?=
 =?utf-8?B?N1NuVld0dEhaZDRMaVYxWG8yUXl3YU1jK0dQSFEyNHJ2K2IxcG9TMnNpVFp3?=
 =?utf-8?B?dTA4Nm5McGNNYUNoSktRUXhrckZZVXRYOUl3UGZFUEdZZGJoWWdpN25QV2xX?=
 =?utf-8?B?bkNjeS92MkI0dytlV1lZemQxL1hLT1F3MjBjbzNIMUg2UW8yQnJ2UGpBUG5V?=
 =?utf-8?B?WEhRdERsWkhyaFc5MXVDaG1OMWQvdFBScjJleEw1V0NZa1dEdHpobkhSMXZN?=
 =?utf-8?B?Q0N5QlNFOGlocnlwZEhqeGNsTDdaWTBIZWwvSEVPWWlRcFFCaTVpQ3hUNHZI?=
 =?utf-8?B?enlPUEVJNWFHRWh1NW93NFBrdkQvZUVNWmlDRTBMRkdpRmZ0U1VISGR0bm5w?=
 =?utf-8?B?aVlySHRaZUF1VEZRTVgwRDZVY0YwS3R2Zmo5aUpDcjcyRlkrckhjZGdsMkpm?=
 =?utf-8?B?U29SNGV0VnJQMm84S3AzbUVqTTVFMFNCdUFqRUlxbW1vVmRMUm5UUUZ3RzhT?=
 =?utf-8?B?aHVuZzFYSW52ZTkwNVlRbnJQTHB2cUkxTlluaWJsSUhXekZrcC9vMG4rSks3?=
 =?utf-8?B?YUh2UkhsOE5MdU5acmNkRENPOS84V0ZadzZ3UWJVU2tUVnFBK0xpMS9LTnFk?=
 =?utf-8?B?Z3RmSHhJbU95c05RanB5cjdJRERTRFFxZFVIZnZET1N0QlVlMGh0Z3NESktN?=
 =?utf-8?B?WklBY0dRZjBwU0pHWFVCbWwyUUJxWVRwUmJpd0VKTHN0NXNsSWgvSmJnQWJ5?=
 =?utf-8?B?SEFnSkszZmhLdjd2b1AxcnRFcXp2ZTVGYVE5V2IvWm85NUp0RXNoOUVqZFpS?=
 =?utf-8?B?cTlIWmdZcWY0Q044RSttVXo3OU80Y2pQemRyaUtPd3ZXSE5HOUFreEpZUzNt?=
 =?utf-8?B?LzZ4TVBveGsyQ1lGOHdzaDliK2E3TGJJenRCTHk5aHRNSmFxc1pSdE9EZGwz?=
 =?utf-8?B?NlUvY082aWp1Q24vUnFaNnJCd05nVWpyTENUNy9ScTgwdytqQWg1bkY0Y2gr?=
 =?utf-8?B?bTJEUERkcG9jN0lzOEErdFNMRWRWcG4wQlYwcWRpUmZWeUI0Qkh6VFo0dnh5?=
 =?utf-8?B?aXJnN3QwV09EL0E3L3R3SC9FNHlUYzVlZW4wUTcrL2NtNURWcXdycldpWG9p?=
 =?utf-8?B?NXhvRGVJYTJSMHVBdXFRbTQvZlRwbVo2S2h1TktNcnljeFRXenozZDFTZVNh?=
 =?utf-8?B?WFdKVEJMcXYxTE9vQVg1ajNHa0tKaFpLekhkTVFsQnhZVGVWS0t5OFRCSnFX?=
 =?utf-8?B?V2dYRXZYUER6RDRUbXpDUGZHZzhEd1EyUEF3L0FoRkpOZjZmK3BQR3J1N21H?=
 =?utf-8?B?Qk5uT2xXWDQwM1pRdnpCK2podG9PSS9IdVl0OUJLQlVsbE1CelJ1d1gzQTFL?=
 =?utf-8?B?UUpjcERnQlpTb2l5aGlCdVRGWm02cEtpMjFFUGh4UTFxdFhLVGdnTnBFYkNU?=
 =?utf-8?B?T0hEUUVhWHNIMS9FUnFIelhVL2xMQlc4TE9idTQ1YnhOY2Y1cUJaYnNBczZ4?=
 =?utf-8?B?VDNRK2tsanN4T1ZrNnV5M0MyM3UxRGw4ZWtjSlVNN0dRdkZpV0R6Y2p0MEtQ?=
 =?utf-8?Q?5JukGFm/By7fov11UPtRJUOD+J4qjyJRGFIE4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUNINHJrMXYzand6cjZ2cisxZ1VBbnZxMTdGY0Q0RXRNMDc5Y3UxMDNIQlVx?=
 =?utf-8?B?dHc0TDcyemkzM0hWWmliRDA2TzFsS2ZKbjh0dkRyaGt1T0NZVVJtQU5SY05n?=
 =?utf-8?B?NzNkS3R4WVdGQWRVdEpuaWo0OVYzd0g0c2UybE55anFZRDdOTVl3elQvdkZi?=
 =?utf-8?B?VDJ5UUZtTnEycGxicGppNzNuWW90a241TVREYXU5djd4UHkzRVIwZlR2WjYx?=
 =?utf-8?B?aDd6T1c3ZzVVeFdiVTVpUDdHcnY1bU40Z0lCNEtYbzBsNEZKcGtTeGlOM010?=
 =?utf-8?B?SzYyVFhBOTV2V3UvdFhHNGxqamoyaTlORTJFcDJuTlUyU3BYSEszT2E2Tkhv?=
 =?utf-8?B?bjBjWFpkVERFakpRVFdIUHVjd0N3TGNZZFM2aDByRzNDSWhHTU52SytPVUQ5?=
 =?utf-8?B?RC9yMDJGajQyVHZZYldnd0FyUlliQTFnQWovdThJSW1uckJVU1kyQm9GUkw1?=
 =?utf-8?B?cjdWUTIvbHQzNWp3NGt1b2lYWC9RZTR6OG1lTE5mNXUzOE5yY3BEcmRYNTVY?=
 =?utf-8?B?dlZTcEV6UjRCMHJUTDZvYTJvZCsxY09sSXV3K0pMeFY1NzRQOGFUL3VNOVlX?=
 =?utf-8?B?UTFzQmN5UEJQekhqZk1xMEJ6aUJqNDZqS1BHdGFaNUNESmliTW53cWF4NktF?=
 =?utf-8?B?SndkZFh5V0dXVEI2YkRSQ3o1QkRraXlpWXlJcUcyTFFBdXh4eDZQNURHZWQv?=
 =?utf-8?B?VkVZaVdUdG01SDg4YnBjVk45OVRydUVVdjVqRC9xTUJoeHU2NWxsN1Zvbkt4?=
 =?utf-8?B?L3REdnFYRURhM0VUZVlZdUdjTll2WHpJTWY5aTBtSlQ5RHV3WmcyUHZGVzk4?=
 =?utf-8?B?VVc4M0daUktJMU9paVJlVk5zT0tUOHpaTFViMWhlbEplYmp4aU52NllMNEp4?=
 =?utf-8?B?aHdEcUIrRXZ6dnNWWEpsOHhOUnNlK0dCZFZnZHk2Zk9DVzZ1MHR0UFlzamQ1?=
 =?utf-8?B?QmYxWnprWm1RZFR2WUhQTGUwdmp4MEN1Wk5QUmdNbUxMeG56bnE0d2ZmT2Jx?=
 =?utf-8?B?VGt4ejFXd3JTWW5TOVd4eG5HOUVNSWJianJ0cFFGN3JvK2t5ZkRVM0pPSEtH?=
 =?utf-8?B?bG83WVZlK0JmUjQwTTNXZ0tkYnVOU3BENXp6NWd4TGYwL2V2NS9RU0ZkbU45?=
 =?utf-8?B?S2xrK3hVSEFObW1VWE10bUtBdVJKS3A4cHdzbE1QYWdNNHBRaWQ4QnlCZkxh?=
 =?utf-8?B?VjNMcDBxbHFBV2tMU2Q0Y0JYYWJCQXdiZC91N2tzODZnQnozdUxMZnB2aUVp?=
 =?utf-8?B?eEtnMW0rRGRiTThVNDUxY0g4dWlZV1VhOUlvOWNkRmhXVHhCSGR3NHpmaXBw?=
 =?utf-8?B?UDhmWU5wSEFmT0NEeVhlQ0RsU3N1NXJqL0J6L1pGdllQZjJrOGh4SWtrR3pO?=
 =?utf-8?B?dENtWGJyY2w1bXRUMi9pYXhDOVZEdVdsYUs1b2FzWStQVXNVWU4ybjBiUk40?=
 =?utf-8?B?NDhrQk5Vc2RGc001ZndwS3VjemEwUWJpN3B0NXVKVGU2NU1MeGV3bEhwL2tH?=
 =?utf-8?B?dHBRWlI2SmJVQlh3ZkJoZXdSSHAyQ0l0QlFOM2RjYUhwejI1QktGQzdmNUFS?=
 =?utf-8?B?OFZaN0hNQXJwZ1EvbTFwQ0hQMnhWdzZxSUZiRUFTZVBsRjN3c2VVcVpid1Na?=
 =?utf-8?B?L0NRTXJmRmk0NDVNcFNTT1ZMVDlKdFJRN1pNVThORXZwcDVKTDlBK01tTmNp?=
 =?utf-8?B?QzVzQUdWZWZJNUpxVlJ6am1yTWtYZnJ4Tk52bjl1QmFGTGZsMkswR2g3MDRs?=
 =?utf-8?B?NWY2cmxPMmZIYjAxM1FvTmJScDdCWG9zbXF3RXBVc3pwdFlRRndUWEVrNTlB?=
 =?utf-8?B?c0FqYXI0SytEUHRkZUdoUlZBemw2VU5mZG5JaUtnSUZvWDBvbFZBN202ZFBv?=
 =?utf-8?B?Zk5LRHhxTStUMXZPQlZLV0RxMWtEWnh1VFlVcVlxVXh5SGlxUGdnQkp3dGFM?=
 =?utf-8?B?bXhHRWFlY0RGYUo5Z25BU0pOS1lrc21GWDRQVXNxQVEyck1LdlRsVFEwRGRx?=
 =?utf-8?B?WEhJOGNtU3lJNytaWFBENTBzaTBTNCtLQlRpMkxqM1dDTGY4MW16TXJDYUg0?=
 =?utf-8?B?MkpEQVdBTFJmZnhGUDdxcmZZeTZVZ2lrOGhsMnBhM1doaW1QMzNHcTJnbmND?=
 =?utf-8?B?SklURTlMMlVaeEV5b3F3aFJpajFaL3hUdFRpZ2s1cERkUFdTallqUVFyT0Q1?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38164691D5CF054A84EB07ADEF4D4F56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca881574-6bc2-43d9-7ebf-08dc6366043f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 07:21:38.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1tpsfjenC+em+av+jEHSWbqXOIZHxLicqU6fBbJpAR20pwkmf8zQUjST/Cy6hC5iKcUDFBNjC2QmxLeX8QH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8121
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDIwOjIwIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEVuY2xhdmUgUGFnZSBDYWNoZShFUEMpIG1lbW9yeSBjYW4gYmUgc3dhcHBlZCBvdXQgdG8gcmVn
dWxhciBzeXN0ZW0NCj4gbWVtb3J5LCBhbmQgdGhlIGNvbnN1bWVkIG1lbW9yeSBzaG91bGQgYmUg
Y2hhcmdlZCB0byBhIHByb3Blcg0KPiBtZW1fY2dyb3VwLiBDdXJyZW50bHkgdGhlIHNlbGVjdGlv
biBvZiBtZW1fY2dyb3VwIHRvIGNoYXJnZSBpcyBkb25lIGluDQo+IHNneF9lbmNsX2dldF9tZW1f
Y2dyb3VwKCkuIEJ1dCBpdCBjb25zaWRlcnMgYWxsIGNvbnRleHRzIG90aGVyIHRoYW4gdGhlDQo+
IGtzZ3hkIHRocmVhZCBhcmUgdXNlciBwcm9jZXNzZXMuIFdpdGggdGhlIG5ldyBFUEMgY2dyb3Vw
IGltcGxlbWVudGF0aW9uLA0KPiB0aGUgc3dhcHBpbmcgY2FuIGFsc28gaGFwcGVuIGluIEVQQyBj
Z3JvdXAgd29yay1xdWV1ZSB0aHJlYWRzLiBJbiB0aG9zZQ0KPiBjYXNlcywgaXQgaW1wcm9wZXJs
eSBzZWxlY3RzIHRoZSByb290IG1lbV9jZ3JvdXAgdG8gY2hhcmdlIGZvciB0aGUgUkFNDQo+IHVz
YWdlLg0KPiANCj4gUmVtb3ZlIGN1cnJlbnRfaXNfa3NneGQoKSBhbmQgY2hhbmdlIHNneF9lbmNs
X2dldF9tZW1fY2dyb3VwKCkgdG8gdGFrZQ0KPiBhbiBhZGRpdGlvbmFsIGFyZ3VtZW50IHRvIGV4
cGxpY2l0bHkgc3BlY2lmeSB0aGUgbW0gc3RydWN0IHRvIGNoYXJnZSBmb3INCj4gYWxsb2NhdGlv
bnMuIENhbGxlcnMgZnJvbSBiYWNrZ3JvdW5kIGt0aHJlYWRzIG5vdCBhc3NvY2lhdGVkIHdpdGgg
YQ0KPiBjaGFyZ2luZyBtbSBzdHJ1Y3Qgd291bGQgc2V0IGl0IHRvIE5VTEwsIHdoaWxlIGNhbGxl
cnMgaW4gdXNlciBwcm9jZXNzDQo+IGNvbnRleHRzIHNldCBpdCB0byBjdXJyZW50LT5tbS4NCj4g
DQo+IEludGVybmFsbHksIGl0IGhhbmRsZXMgdGhlIGNhc2Ugd2hlbiB0aGUgY2hhcmdpbmcgbW0g
Z2l2ZW4gaXMgTlVMTCwgYnkNCj4gc2VhcmNoaW5nIGZvciBhbiBtbSBzdHJ1Y3QgZnJvbSBlbmNs
YXZlJ3MgbW1fbGlzdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFv
Lmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IE1pa2tvIFlsaW5lbiA8bWlr
a28ueWxpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gVGVzdGVkLWJ5OiBNaWtrbyBZbGluZW4gPG1p
a2tvLnlsaW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IFRlc3RlZC1ieTogSmFya2tvIFNha2tpbmVu
IDxqYXJra29Aa2VybmVsLm9yZz4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQo=

