Return-Path: <cgroups+bounces-4504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0BA960754
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 12:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC82E1F23898
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA94619B5BD;
	Tue, 27 Aug 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYB/HmQq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F742FB2;
	Tue, 27 Aug 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754141; cv=fail; b=bATjwXBKS/hV2g0Wceo//KaZk7wLb9AOxiYXeV2nov93vbaC99YQkclIfQ91jrss01uDkLlyS2oJKvo36ylwLgtx1UZPE2A8iWjIc4C0qWQG7o7aq4OwxV+VkB/cJ9JUIejKfqD7ynaRJ6O/TCeTXM4rN0STdgEcpMjFxr2E9Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754141; c=relaxed/simple;
	bh=s5DJBl7XRMufG1ty6QE7Ya97i6QUWd2qS+EvsQvU/Os=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eeMy7EeHJBcmIoX9N+w1J6H7paGfSd9k9V7yTxPQcdwZ+WGI+lwU1uPl2za/HgNo5u6UT5QZ/OX3oDNeC3q3spW1/bx1+c4sRmCT6C/DzGyxp2+UUAmyT5LsWRnWl2j8SKFOeO0qwN0iomVXO8jmJTfXc5nTuwGZEBIW05YUM4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYB/HmQq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724754140; x=1756290140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s5DJBl7XRMufG1ty6QE7Ya97i6QUWd2qS+EvsQvU/Os=;
  b=dYB/HmQqQzdaIFLNF1ixa4XtrqI550tVGHXShUku5dNhCtyREgttmQxj
   SVhEpyUHxtztoBj386JbBzv+T+R6aHhWV4umIL9LKBBZW5B6zaoXbLKKZ
   Dhcjo8g0M5Wxi0Koq5KEcwSjsZKvuHzLqWICH0/5w4NAKSkl+MWo3w7zd
   efpVfKi6k+YfUZJjATTmNETTzfZnyvF61LCzpmNBueFQRxgDe8FKc8Ek+
   9qAEVzGjpkDqaxSJjpLQ0lsPo9WNszqdJd0kJ254DsK2eFryX5iq3Saj0
   EtMkdQnF1dzJPeijfFXH4SL0WxzZWuP/lH61f5Kk3EvLcZBUjQJ6QDwyZ
   g==;
X-CSE-ConnectionGUID: GNkIfk4+TemNPmpPHsFsxg==
X-CSE-MsgGUID: yhHO/LUTQDGufoG24S/zYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34374819"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="34374819"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:22:19 -0700
X-CSE-ConnectionGUID: rbx6JskBS0uHjrgeNgFHcw==
X-CSE-MsgGUID: ghGxsBkTTyCzb21seyYn8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63532980"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 03:22:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 03:22:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 03:22:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 03:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mz17ZKbRJ8nPTxE40aAjLUtgB8QQjeYy6n8Z6gvk/WDmocNOk6Lm/YONF/jzydAOnFI/+m8ianbrUfJiyQsGdoyzDqjZcCwOE1TMUBM+wrKfR6SMUi693fFgGMMRnu5ULnDVpt5MaP+FcIjJnXeoeygR6bW+nuvDQT7lt7jkNfhHr0Kq35pPKQ63tWGg/foZdG8LuXBySqoWSEivbUcv3gEboaleEi/Y0Bhx22gkkiTbwQasjN5LoNJcaByu+3HKuOtgDY76Oll329MUDaRmO9qf/y81AOsRm4nSe1nFnQaBKbMeccCFkRlRYFKAwLwK8xokQekeusmC6Ii9Fmlq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5DJBl7XRMufG1ty6QE7Ya97i6QUWd2qS+EvsQvU/Os=;
 b=f9qyqbGcfiY1RNA5jqf0s8sTqOEwnV9lSKxnDiwBpJMUC74rr9bQuflYhi4KOzve1UHaMpnBPyzkJiJ/w9lK0vO3cSED/pUSDHnZT8usUh15lU+NMCmwVE1Hrggs23bmp1ByaqpdlmXWrje6GB2IFIghGdDz8VpRAiGvc/CdOGWEKZ0Oj50sgiHlxnFLt5z6gX/mNyfC3Q5NkK6vkF3dB9BYrErVA2CrZQQzYg91+iUgOxbFhY/38TrvmLIBG90+va1IRORZVkxK5FLzWz5RyjFV0YkIoudXFjkomzNf1LDeR5g3Noo+JNpkxUjiqIXowfsucC6B4O42LqCjTNQVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 10:22:10 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::a5b0:59af:6300:72ad%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:22:10 +0000
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
Subject: Re: [PATCH v16 10/16] x86/sgx: Implement async reclamation for cgroup
Thread-Topic: [PATCH v16 10/16] x86/sgx: Implement async reclamation for
 cgroup
Thread-Index: AQHa820fYIdW70yq70WDZtgaPrW/l7I67xWA
Date: Tue, 27 Aug 2024 10:22:10 +0000
Message-ID: <93b68e3bf58c78d5a2b941cd2331b838c7824625.camel@intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
	 <20240821015404.6038-11-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-11-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|IA0PR11MB8378:EE_
x-ms-office365-filtering-correlation-id: 67fdf1a1-ab21-425b-abff-08dcc6821c53
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWFTZlpQZzlISjBYN2JPYnoyOGc1WGlwejBjaU9xK1BRWXBtNnVheUhHRjRI?=
 =?utf-8?B?bXpqbFo5eVVpL2dOQ1lLcklkd0lKK0hLN2VjWldUT1FCNXZWOGNINjVqWTBK?=
 =?utf-8?B?VFdnZGlYZm84dllSTUd3Y1A3cGVrMVZpa0ZMZ0hZbFhXaGk2cXBlZHhMeWRS?=
 =?utf-8?B?WGIwSjk0YlNSOE9CdlNqMVdFWG1pbFFEcnZFaHRWQWM3alY0NkVEZWFLOXVH?=
 =?utf-8?B?TTNBSHZNazRMbjBVbW1GY01JZGRyODlLZmNzSTJmY0IvdlA5SDR5dVVQTnc2?=
 =?utf-8?B?UVNkeWozeEc3cVV2MVRhWGRFVUtTTm8vL1ZnemZOMVlKTGUya1ZHWGpaSzd5?=
 =?utf-8?B?U21VODdjZ1h2OTVhVXBIR09ycW5oY28yN000Q3AzeTd4RGpWcTJWMHJLQ3lE?=
 =?utf-8?B?YUVoNVM4Q2s1dkVJRXVHYzduM3pQSWRwQWozTlJVdkRReFZXS1dsSDJTNTlN?=
 =?utf-8?B?K0VXMHJ4RGRGcGZuVUpkOXg4SUZXUDh5UWVnU1RnWElNcWcwM1UzOE9DczJM?=
 =?utf-8?B?OXVpSGZyRHhTSVNyMkhkMFFwZk5BUzArRXkrNlZ5Y3VRa0IzRTd5VktacmVM?=
 =?utf-8?B?TmpWRGxEdWVDV09HQnZ2Y3Z5ZWx5WEwxSTc0UVAweVp1UHJUSEhZRVI2QlJE?=
 =?utf-8?B?MVRLVVdIS1lrZjB2aUoxMFMzZjZNUWVkM2ttTm9mT3dlUjM2dEVQajV5M2Ey?=
 =?utf-8?B?V2pRRHVNSUw5UkNjY1RXWXl2UzNId1dMbm9JU3p2Um1TMmJhcGtkQXRud0Zy?=
 =?utf-8?B?NVFzK0U1cTdyYXljOUthZTJCOFBlMzcybHcwTXR2c0FKSmdvc2F5VjhYSFds?=
 =?utf-8?B?L0ZibEpMLzk3Y3U2NXFTQXFjYms1aERtaklQQ2piZm5QUGRra0pISEdNejAy?=
 =?utf-8?B?SVpxVGZ2dTJmYm11REpsQlZEdHNvaHd2U0lRYkMvWDZGNEVFTzFJaG9kZTBR?=
 =?utf-8?B?RngweHg0TXlqQ1dQcmdybWhxajIyeDF2bjhZZWlRc1BEVWlmZU1USzMvMmJL?=
 =?utf-8?B?RjJhUldtaTJWM2pDbzJTVGtRYnUwTTlCMnFHZ1dkOG51Y2VzYVBhWjg1ZkNw?=
 =?utf-8?B?VjdGVFAyNzRMdUIwb28rb3FMUlBFZ21TTnRKelUvbVUvZnVHY01KSUpoM292?=
 =?utf-8?B?cEtULzlmeFQvcXVhQ0J5cHdLWmN5Zy8wOU5uWTE1WEpkY3RxdjduMnpLQk1q?=
 =?utf-8?B?d1gxMmpxRktFMVp0ZnNKek85THhaQlJ0d3o1Mmh4SVliVmlsbE5JMC9KZHdr?=
 =?utf-8?B?dUY2M3FsbXhQVXQyMnVoOWZmcUwrZG5BaUdwNXFUcHlxUlJUMVdhZ09HM0or?=
 =?utf-8?B?NUI4M0pqZnpiTFRoY0gzMGhQWkF6TndETGQzQXRwckd5MGduN2J1TksxNWN5?=
 =?utf-8?B?bFR6QW5TVFdEMDZGbE1VV1I5b2tPUEJxeENTMW50bytzUGtTMC9aeVF0ZXJK?=
 =?utf-8?B?VVQzdHdnN2d5dm1HNWg0alNidWx4K1duc29qVEhnQVFETjdGbjlnalEvQ0JZ?=
 =?utf-8?B?UVN6MkExVnMxbVB3YUdvYXlqUkFGbU15NDRDdHRUVERJYzJSZHpONXVSbGwz?=
 =?utf-8?B?dGFLR0k4UldRWER5U2RERlQ3TnBKdFlhTHhPL1hCSXpVUkVWM1pHUCsyMHlt?=
 =?utf-8?B?OFp5S29PL0cyQVRWU0YycWpqdDdBQXkvL2F0MCtRRERTRXlQa1psMUg4dno0?=
 =?utf-8?B?MHhBbWtwcWQ5NmtZQkoxTmMxL3Q1aWpWTWNtSXlmR0I4TERsL0c5WXpQcjJr?=
 =?utf-8?B?RTRCMHY3TmRJY3BkUkVLM29xWjNHLzRvSjVNUk91WFk3TnNScWsxYTlpZ0VK?=
 =?utf-8?B?dWgyVHgrM0JPblhTOTZxZ1VqL2E3NmNMeFA0Sy9NOGF3VG1od3pnUUpZWksw?=
 =?utf-8?B?ZjZ1SkhvTTJ5MkdySmViOGplOEY5UkRlL1hEbkVEMXkrMjlUYTdoa2lWbnBo?=
 =?utf-8?Q?PTi6VzOdRhc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkEwYzB5eExxOWtvLzI1Z0o1U0hIOHFURkNSczE0eFVycmZobUp2cW1sZkda?=
 =?utf-8?B?bFlieFRVczd1V1J5Ym5ZcDVoVmREbGxFbVJjYXAvTEt4ZFR0RmpKYXY0TFZW?=
 =?utf-8?B?UHVldVhxOEpsSzNYUmtCVytTV3hoZTE1NzdEYzNvKy96aHZHU2k2WVFrdWlq?=
 =?utf-8?B?MVN6Mi9TcUpzNzJFL1FkRzZsb1pZNkdCZDZyOVJGMHpabEFNcEtRamNaTXR2?=
 =?utf-8?B?dkJlRVh0YXN4OGN6bXJtZldJSGhrcmdOYUcveHF6Vld5aUFScWxkM1JMN0dj?=
 =?utf-8?B?RE43a0t6VEFNODVhYzlQemxBMnF3Q0pldURPd0RuMlRqbmVpSnRwV1UrZ0tV?=
 =?utf-8?B?NzJFcGpoN0VrNE9OU3JJZERxdkU3RXJhN1FiSGc2WERyclhQZEU2OW02RmRX?=
 =?utf-8?B?aTllcjZ2ZllqK1EzeXJTWXl5YjJwVDRHc3FVZlJRTkFCOG9WOVFhVEszS3gv?=
 =?utf-8?B?dVFiQ2RJNnkyYi8yNjBwUG11TGNQUnFtak1EbkhPbldPTnZtMW16K3JzLzBJ?=
 =?utf-8?B?WEV3ajVmQ1VkVlZxd1JCOHpLdFVtVmNOTG4vd1dtMHI4RTlyaEYzaGdJWHMy?=
 =?utf-8?B?L2lIcHorTlJXUE9hYmE5ODFvSG5CdzcvYmNxZnI1U29RRjI0RFdHQjQzMFFr?=
 =?utf-8?B?SjR6OVNxa3VEY29KUWFoYXNmcDZGYW5RSmY3UzVJWDBEQkZtMnhmY3JORmdC?=
 =?utf-8?B?cFZQZlR3bXJZeGo5TUZQd1UrRWRSczVDOGxpQS8ybFRWWFhYSVJsTXUxR09V?=
 =?utf-8?B?K2ZyNlNvRlRoV2NzZ3I1aDJDUng2cU5zY29ybVlMTitZSVF4c2dJMDdHVHgx?=
 =?utf-8?B?dEp2MkdnRHNCc3UzajVZRExDQ1NKbXhwUStQM2tCc2poMTNZWDdoc3h0bXds?=
 =?utf-8?B?R3JOYjBUV0poaGlWMXRpWVFMSWV5NnRsS2NYK3RKWXdLN0w4d0RzR2xVc1Nw?=
 =?utf-8?B?WUppNHVqRUloaGpNSjRUR2pzR2kvVm5sTUViUXJ2K0srbmlBOC93YitwU0kz?=
 =?utf-8?B?NUx5b21HMnl2TzV5dVQrR1hzcjArQm4wZmhnTXpvZk9aM0s1am5ETWI2L0tB?=
 =?utf-8?B?OU4rNk5DL0ZTbFFIeWE3WWJVdzQ0ZUpiRnFuWThzQXVTVXVNQmxwZjhLM1RC?=
 =?utf-8?B?ZmdpY3NJcDVYWU9RZHhmS1FFVU9lSkcyWERsRTBwNTBPOHAraVIwYlI1WW4r?=
 =?utf-8?B?VmNVck8xWnRFb2hsSW1UbGtJSThhWGxndVVKWHBQakg5ZmJHVVBnbVVzYVhv?=
 =?utf-8?B?MC9XanpublRONjJWZVpqcDdhOUIxZDNqb0xwNDhzbmdoTVE0cDRLdXRWUEQ2?=
 =?utf-8?B?QVN4YWQvaEs1MW16c0FrR24raVZiL21tUnRVZkhCZkhzU3Y4WnpqbytLaWdq?=
 =?utf-8?B?dUYvWjQ3NmRIK0ZWR2dPRzhHeG5WLy9RdnBaL29wZUJsZDFBT3Q5SGZuUkhJ?=
 =?utf-8?B?dmh1ZTIyckpaRGFYb2RYSGhMMWxPTUN1UjN2WWN3dC9NelNsaFYyZk5DejIy?=
 =?utf-8?B?WGVzbTRmOHVvMHI4V3dUeE5udzNlOHZWM2FoL0pPZ3hmVHdMVVliSnFPYmVD?=
 =?utf-8?B?YUhhVkFKYkJKdWpKVGwyZzNtQWVrTGRJcGJyUmlvWUNFLy9jREp2eXJta25w?=
 =?utf-8?B?M0p6Q2JFYzBDN3V0Z0lxZkIwZFkvVEtIa0FCZEJhRnpmNVVVVDNYTUR6bGQw?=
 =?utf-8?B?SUNDRmRqdjAxZjFlOU1zUkpTZEZGS3BjTWloempzRVZWMjZqNStnYytkN2Va?=
 =?utf-8?B?QllFcy9KYWJvK0NubFVLeklFWFRQQlFtQTdQSTF6SWVlQVFsdmhTakM5ME95?=
 =?utf-8?B?TVEyQldybFpBZ1AyRWNVVFRUbVhxN2hpeDJqTlZWVHlIVmtSYWdzbjFZQ2hY?=
 =?utf-8?B?YjM3OWdzN1hWSTZ0RE9vcjhWVTRyTjRENExDMUJGTCs0ZTJSb1I1eFpEVCty?=
 =?utf-8?B?Rzhvb1NGbmNOVy9TVnEyTTlMb0g2WWZNUGxrdFNUYzBLeXF4K1pNUUg0ckU4?=
 =?utf-8?B?TmYzUGl0YlJXd0VYUEZBR2xYeTVwSGszd1QyR2VqTGd2Mml5T3JKejY3SFlU?=
 =?utf-8?B?UE9Yd1k1dzRZTXZQTkQ1blZVYlZTc05SclQrZFJNWTA5clVra2k0ek1iQW8w?=
 =?utf-8?B?QXdwNHBXeTN4cGg1Y2dDRG9MeTlOamlkTWtCOVJEcFd2MEsxNjJBWmI3YjdK?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD71B427D2260145AD354B4A2CEAF617@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fdf1a1-ab21-425b-abff-08dcc6821c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 10:22:10.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/CGLs0nTTCjJL0BbjF7nNSkku5CegsF1LDE28ECqgO0Or3XlFdKZIkUJFsDJncKhDKhJD1nX4oXYQ9owZiRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDE4OjUzIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ICsvKioNCj4gKyAqIE9ubHkgY2FsbGVkIGR1cmluZyBpbml0IHRvIHVud2luZCB3aGF0J3MgZG9u
ZSBpbiBzZ3hfY2dyb3VwX2luaXQoKQ0KPiArICovDQo+ICt2b2lkIF9faW5pdCBzZ3hfY2dyb3Vw
X2RlaW5pdCh2b2lkKQ0KPiArew0KPiArCWRlc3Ryb3lfd29ya3F1ZXVlKHNneF9jZ193cSk7DQo+
ICt9DQo+ICsNCg0KRGl0dG86DQoNCmFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAu
Yzo0MTI6IHdhcm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0aA0KJy8qKicsIGJ1dCBpc24n
dCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2Vy
bmVsLQ0KZG9jLnJzdA0KICogT25seSBjYWxsZWQgZHVyaW5nIGluaXQgdG8gdW53aW5kIHdoYXQn
cyBkb25lIGluIHNneF9jZ3JvdXBfaW5pdCgpDQo=

