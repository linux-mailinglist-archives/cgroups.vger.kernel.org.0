Return-Path: <cgroups+bounces-8013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5EAA9B84
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3611892133
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13AE268FD9;
	Mon,  5 May 2025 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Emdp5/Dz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA75189916;
	Mon,  5 May 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469697; cv=fail; b=VceitXZQfDofX30OlfpEhemDIs6QN7UDGpanyez/4CoTYV5fGSoAegOwh9HC7gGZeL2himp7oWiSrb+uNUHJFG57ApUjr/Zl2FBgOCbLpOyO6iDNipgelSaKmgnBMarsR+3h+BVd/o8/F/RXAP7MhN3NPNh0Gfi9D9AYqdXi0i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469697; c=relaxed/simple;
	bh=f0xxGna+/C+zvSw1h6xMCLR87DWuXBjw9zK3HyWRQ+c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mA1VgZIp+5boijskK8Dt8pnq18y9O6JFWJpS+S8VYj9bE7lfeAcgbMKFK4NUBxfXs24G4ItBNnIo8Xvm6AbZ5dw1hxPmzXF2O8paLK1Jd5BW6ZpCk3TNuOL09T4rxTBiHKGkOBpQ4WuEHIsOewoRrqSZuLocozHl7EZc4H8BtwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Emdp5/Dz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746469695; x=1778005695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f0xxGna+/C+zvSw1h6xMCLR87DWuXBjw9zK3HyWRQ+c=;
  b=Emdp5/DzNuY1X2QnXnFzRWW/hmH30nvuaKRIsKNfWn2pDBAwEJJldLXm
   lwrf948WrZIIeuVGpFwZS0frNe23zoB3RjL3ju5yRFWrVMv2HiXJ4hQ0z
   gBVyGaj2dbjBvqX5qMYnt/CzUrGQCYjWqjk7TlbH28DWH+vfSaPdLNVrp
   05zD6G9Vzz8FCZkJIExKyUqV6NyufLy0N0XaAKqH4+xSZxyoFbOxCLTJ+
   oQplyytwfQcmJRytAQ0ItrApmxZ2pjtIPGraoGPURMcPJHDwWgr53obss
   IcJugkKi7njf5JyqEuydLBdTlk+YazyH1RCrkUoIVHYFQ9hr4ST2EHUVJ
   A==;
X-CSE-ConnectionGUID: zuW4L5d+S2amrd2SsoSg+A==
X-CSE-MsgGUID: GzxQl5C4QXGaKKtouK7ldw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58756377"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="58756377"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:28:13 -0700
X-CSE-ConnectionGUID: 0zCS+GNyTRqaxdRTKa6BSQ==
X-CSE-MsgGUID: vzPgSsH9QPih3yilbZomNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="166391996"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:28:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 11:28:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 11:28:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 11:28:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv/mEbQ3eDp6W2zXm4Z4mxoN8O5YpJcGpKd61EUQ3YPDGGWR8LA0kfqkkn/OqAIUCrcbEKADSA1lRDv/DFWLTBUZYV0Ygc/c9jinhwp0PelBhZwToiujO+N1dGo2k+2OC2T4WWFlTOJig10FSD5bhsUrQCxtRYBK5BDKFHZHB3N32bhPiJR1qsMzrBw1FV+4kwgah2cYP2P0+TICj/v0Avv1kV5nsoBV5Ypu2sR9huXSb7fYmaxvlzEKpl21C50uZJVquw20F6FARxWBnuBjbvpI969QZCH5RIDuKk3CAhFoS/ptVrQoCyEDHwnAvu/KPl6Xpc9AJX0BJK2sWfD6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zrm9AMYK4eO1egyq+9KsHsrqZBqoVIep3zat1+hlo8A=;
 b=uYLwnMho/87rWPBN1d/pJ7VUwGKjUgCvlmrV6WuVfiGUrCkT3PR+fiD+aZbIqHi8+GT2YnyQiHKRc6zeYdHpPQ727AHYFAOFkOCUw4u+mQWCbjJpdJiZlzv3wb0m8uDdaDtT18R5bABloe5gxzsUJZ6NBcTKCxxa+CfcqXeFpXg3Y3S11n5L6rNDq5NwlZBj3NIkIjCKYKvJNguZkJcYhRK7XpveZYz0Zni28IXyMFvoDjO4qEDRa7KQMNWkufdCoDjylO+8KiM7icnsWZ/Lvwpa+4VaAzqn/st30CEIkMcfRilJjct+ZFP2R07ChzUY1jrIVrXFZR/XASjJcBfwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB8239.namprd11.prod.outlook.com (2603:10b6:610:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 18:27:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 18:27:41 +0000
Message-ID: <0bdc72c0-8f4a-4d91-8e67-f8d56dc26788@intel.com>
Date: Tue, 6 May 2025 02:27:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: "Jain, Ayush" <ayushjai@amd.com>, Andrew Morton
	<akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo
	<tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet
	<corbet@lwn.net>, Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim
 C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Libo Chen
	<libo.chen@oracle.com>, <cgroups@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, <Neeraj.Upadhyay@amd.com>,
	Peter Zijlstra <peterz@infradead.org>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
 <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0033.apcprd04.prod.outlook.com
 (2603:1096:820:e::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 71949222-2b7b-4f97-4ca0-08dd8c0284fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1hVdm9jTnhFLytnSURhWUkxYjAzL2gzQ1hmMGZ0UEVKQmpyM2U0OWkyQnlL?=
 =?utf-8?B?ckM1N0FSd2J4WFBCeFYwZUgzTGVjWEJkVnlPOW1ZSjZsdkEzWHlxMnZmSHVD?=
 =?utf-8?B?RFBobkUyZFlsbGFNNldKdzNFSWVLVDNEM3Vicll4WDZ4SHk2a1NNdkJZRnNS?=
 =?utf-8?B?VHViWElZeTRnc3hJZnMxSm1lcVhvdDVvcGNZMzFhZnRGY09vaXZoeHlDMXR0?=
 =?utf-8?B?MWp4ayt3ZVhBWVNsQU9uSnJGcy9zMDgrS205cmxZbFpmYWZzTWJ1WDMveEFP?=
 =?utf-8?B?cTJWVkNEQWFBRVJxYXhzbHQrQ2M1aDRlbWZyYUJOMnlzazRNcWFVdzBSMHFt?=
 =?utf-8?B?anVtTmVLV3NYZjdLMjNhTjZFSG1LYXhLb2VyM2xZQ2djM2Q4SjFGb2FqV2Jz?=
 =?utf-8?B?djY5bG9IQkd5NzlhRndqbGpxYmlIelEyTnlnSVR6K1duMWsxYW9idEZvbm82?=
 =?utf-8?B?OHF6SVpPMXJwaVVrMFU3TldEbVY3d0JvSG9PejBEbXcyR1hWOElUTzBKSnIz?=
 =?utf-8?B?OGxBRjFsM3UzY1Q0T0tRZ0Q5aFhEWHdwOXRnNWlTNnRtcTlIVjgvR0lSMEt2?=
 =?utf-8?B?U3dVNTZEdCtZLzV5SDE2anovbStrMXUvZklGeDB4Mk1IRDZFKzhZZWs1SXNG?=
 =?utf-8?B?cXlTQjhaVTMwdnN0NWRncDNTZjQ0TnBCNHErbVNzRUN5YytGYXFkL3pEYnkv?=
 =?utf-8?B?Lzlnam1QSncwbm5YVGVIckYzQnNmSEdxVzkxbWN6YjAxUVdsbmk2ZEFFK0x5?=
 =?utf-8?B?TzhHMngwcGZiRTN0YVZNTlBZWEtNQThOTkRtcWRvY3cyekU2OUM5eGF2djRn?=
 =?utf-8?B?eGgrdmVqOXVrTlAvWmVCZ1l3OG45V3lybTQ5MXlHVm1XbVAvWVVtdzlBekI2?=
 =?utf-8?B?cnVLTkxPNGluTkQ5RC9TaTlPWXFNc0RCWjBsNFNZajNEU0tGbXpXOXoxQW15?=
 =?utf-8?B?ZmZzN3gzM0p2c08xQW8rN1Z6QnVzT0dOVmZUVGpVdmJjbDJSK2ZYTi9aMUFn?=
 =?utf-8?B?bXFCYXhqV1A5TmE3S1B3U2VMRDVvbmNvbjIwYUR0b28rdjVQTkxGMW05YXEz?=
 =?utf-8?B?Vzd3N21sQXhlbCt5SHFLRzV0VVRGTVVERVVDYm4yOUxHa1RzVkxKZ25kNlEr?=
 =?utf-8?B?NjRCbm14VXMvWkY0VE83WXdTSUU4eE5wQTdBQXErZmZPNHVMNU9Vc0xTUkJR?=
 =?utf-8?B?VjFlUU82RkwyWHpBNmVURTdUY2FRSmt2TC83UGlNL01TQ29yQVhHQ3V3VlFB?=
 =?utf-8?B?bHRMcHNlWlJ1ZFIxM0dLcE1ZaXprYjBwNEt0K05DT0JpSzc0bDJRcWJkS2l4?=
 =?utf-8?B?YmZwWmNaLzFnYmtPQjhGT1ZtREZ5M05jdFZwOUNBU1lYS2ttL1FCOTN3LzJ1?=
 =?utf-8?B?TlZPZHZlRmxDOGg0eEJIdHMrd1Zxc0FCZHRQRXpqWTVldGQ2SXdyNGhLZkpv?=
 =?utf-8?B?R2ozYWtUczQwUUhza1dtK0V4dmxCc2ZpRDNqQWtjcDlBdHpFU3hsVjVxRE9L?=
 =?utf-8?B?c1NvSXk0Unc3RW4yQ3ZESWdleU5ZdS9NVXFGbUhIMWYvNGZDZGpIRVRPMmhU?=
 =?utf-8?B?RnJveWkvVkRWOHRycTVqUHJKbnBhbEFHSVJWTTE3KzVtTFJ3M2Q5NFBjZHMy?=
 =?utf-8?B?WkJib3ladENrTURrZVRxOWo2YVpPbTcwR3duRnhSUFFyM2VQdWk1S3V3cmtD?=
 =?utf-8?B?V05TT3p0Q2hEU1FieXo0bW4yNmpKdFhJS2NyUzcvbWRhRVZua1FnRTNqNWxS?=
 =?utf-8?B?Yms0akVSQTRZVVZyZVpyYU5FRVBBOW9DSkFlb1NYUzViZWd0UGJockx0U3o2?=
 =?utf-8?B?N3ZNWCtoRU4xL2ZmMUJCL2Vsa09xUWtmSjBiMVQrOGhEY29abHNrcmZxa05Q?=
 =?utf-8?B?Y0xnbnVGdE5ERjB3UXM3VTlzNmlwd3pCeFV1M2FYTnRuODJCcWE5WjhGb3J3?=
 =?utf-8?Q?gHMBYucZlgM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlF0ZGN3WGNRdTFuUVdOVlpMVXFuY0cxRmRhbUt3OWYvQW9yczBrMlBRRHda?=
 =?utf-8?B?VGhWWnFzVkVFemdFa0tPSDB3VVg3NXl2VUZ6SDByUWxiOUQxRDYzVmRLL1VS?=
 =?utf-8?B?a1dKTGs4NlNZMUFWS3djQXVGeUorZUhKQmxTTUZuUWVDc09XTkJwTEhiRHcw?=
 =?utf-8?B?WDA0azN5L3pZK0srVW0xQUhDamNUdE5YenVLamFQdk5HenZMYWFhb0wxeFI3?=
 =?utf-8?B?ckphWEJqclhkVXBCakZqOGFuSVYwczRpb1RIMVBHb0NTN01yR3FYTUhIejR0?=
 =?utf-8?B?UWRxL214UkU5QXpqNElhUll2YVJoMHFxMlMxS3BncStFdFRrT2tNVStxaUtE?=
 =?utf-8?B?TDNUSEI3cU4zMmIxSkNxOHNUaEFRdTBzZ2U2Mlpqanl4ZHlJSjk4aEp1aGZq?=
 =?utf-8?B?UHl1MTNqWitSZWtZeDFLanV1aWRMSDh2SDZkQmZkOU4wVEUvNVIraEFNelhx?=
 =?utf-8?B?WXZaT21heDl4MU1MbFpiL0J3NmhXQTRybmV0Vk9NRVM4UkFNTVZZcVZ6Z0Ns?=
 =?utf-8?B?VlJydER5ZmpRbXk4VFVuOW9TNUdZTWJPRnNQUHhWZWRZZTdLMnoyVHp0VE1a?=
 =?utf-8?B?KytPVkFHWm9jdUlCWmI3My8vR29wc0o4L2VrVFN3Zkp1VU1iWGFjeThLT1hG?=
 =?utf-8?B?VCtOYzdmRVFzL1l6Vk5LS0QwdjdsVlgzeHdjSGg3R3N5aFkyc2NINGJDaUY1?=
 =?utf-8?B?Qjkvb2RoMStuUmwyMUNtdXl4MExZMFNtby83Q0dEK0p6Ull0OFhtMG1wNFJo?=
 =?utf-8?B?Uy9GWjU0QnhZS2hQTUFrcWVQaVZaUFBacXJmelpMeUNhWFZHK09PTHRBZHBR?=
 =?utf-8?B?Uk5kTERYL0tjUzQ4UlFMZHJVaTNSZCt1Z0pobGtWTkR5SmFZS0lCdk5CVU1w?=
 =?utf-8?B?Nno3YzFuN3kvbFB6YjB0emo3eGdDVkdrdk5NeHdWWjE0RElvSHFIakpCdDdM?=
 =?utf-8?B?ZVNsUytuaVpBMlJrWDdITkkvNmp1cEFJM0tkRDdGOU85WXdNd05jRjNkT1NI?=
 =?utf-8?B?NjVuaS9GZWVnWlIvWlFYUU5hY3A0ekkvL01lZlIvTkVMZGk1QmJFMmZjaHhI?=
 =?utf-8?B?SloxTElVNC9xKzZPNG5RNFNpbEhteE5LTzlZUzRJTFlZeDVZODFrVDhnYWFy?=
 =?utf-8?B?dFp1SUtvdE44Z2gwV00yWXU1YWtadk9yakZsUmFLdE9WaWNIWHBkekEwb2lQ?=
 =?utf-8?B?SlhGZmlndmMvR2xkZUw4MHZVaDRybHk1cGk4eHJxQVBmYnl5dC96Q0JDV1J3?=
 =?utf-8?B?ZzRzd1hpMzJTQTZRK1Zic0tIMldyS1RwQWNTdFpvK2Zvd1FoUzV1OStVVWJh?=
 =?utf-8?B?SWx1YmFBNzJDaVlndkFDY2R0MWt6ZGtydnYzWmVoL3RtOTRIQ2FSUGdvd3BP?=
 =?utf-8?B?OFFocGlxLzBDL0hZb2ZNUEpYL0prWUZ2Z2VDUlVERVBNdDhIR25tRGxETzk5?=
 =?utf-8?B?QW9BL2FUS3lTenFRNXNoQTYrVXBUdm0rdSt1Zzl4d0FQcThEQW1ESElESk1K?=
 =?utf-8?B?MUM3YlU5ZVNtVTVEd04zczVqbC9iSkN6aW5jR3p4NjcxMUdmRG94TmpXcUlZ?=
 =?utf-8?B?KzI4OTFwOWUrVmIzNlVPMTBodHhZWFNxdWl4eGtPNlhjYmhkYjJUbnB6ZmdM?=
 =?utf-8?B?eHV4ZHo5VEs4ZVo0M2JhRHp5K0JkSGRVc1h2M2VEd1lhQzU1bmVMVytzUjZZ?=
 =?utf-8?B?MkhWenNKeUVFZmhGcWtKQmgwSGlnQUhiUTZZWGpjYmljUzFKVXI2ajJKbEpT?=
 =?utf-8?B?MjByNHdpbHA2Sm0weXFvVmQzN0Y5d3hIKzRNamVkOGEySGxHb2RjdWQyd0pr?=
 =?utf-8?B?Q2VGZjVxUE5oM3lQT1FvOW8ycFRPTmZQZU9tRUZrSEhxTlorbFRlbk4xRmJN?=
 =?utf-8?B?cFBHVTJHVE1rQkdNckhFYnRoRVJRaDZ5SllpSjFNMUlsMkYvUzB3VFNpdzBF?=
 =?utf-8?B?NnFBMjJZSU5YRVQrQTVlMEJYM2JWK0l4dWlPY2ZDaGlITWJwUFQzTHdYZnBK?=
 =?utf-8?B?Tllxa1JWUTdMdCs0VWs3TlY0WjNwdVFzTDRUZnBBSEdmYysvd3dYcWxIaWs2?=
 =?utf-8?B?WGttMUEyeDBOL2cwVjk5ZWJaUmRGZlhpMGtUZGwvVDN5eWdaRnpSWE1FeHRR?=
 =?utf-8?Q?1SIXcZ/UUOLlvklhCfRz8Nict?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71949222-2b7b-4f97-4ca0-08dd8c0284fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 18:27:40.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgKxiYsufZM3eNx0DRdnNWJbC1mwaunzNRdkERdcjm/1c+mapuim8RMIqR6+nJeo48LCXPowaVVooIpjXdcUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8239
X-OriginatorOrg: intel.com

Hi Michal,

On 5/6/2025 1:46 AM, Michal Koutný wrote:
> On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>> According to this address,
>>     4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>     49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>> It seems that this task to be swapped has NULL mm_struct.
> 
> So it's likely a kernel thread. Does it make sense to NUMA balance
> those? (I naïvely think it doesn't, please correct me.) ...
> 

I agree kernel threads are not supposed to be covered by
NUMA balance, because currently NUMA balance only considers
user pages via VMAs, and one question below:

>>   static void __migrate_swap_task(struct task_struct *p, int cpu)
>>   {
>>          __schedstat_inc(p->stats.numa_task_swapped);
>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>> +       if (p->mm)
>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
> 
> ... proper fix should likely guard this earlier, like the guard in
> task_numa_fault() but for the other swapped task.
I see. For task swapping in task_numa_compare(),
it is triggered when there are no idle CPUs in task A's
preferred node.
In this case, we choose a task B on A's preferred node,
and swap B with A. This helps improve A's Numa locality
without introducing the load imbalance between Nodes.

But B's Numa node preference is not mandatory in
current implementation IIUC, because B's load is mainly
considered. That is to say, is it legit to swap a
Numa sensitive task A with a non-Numa sensitive kernel
thread B? If not, I think we can add kernel thread
check in task swap like the guard in
task_tick_numa()/task_numa_fault().

thanks,
Chenyu

> 
> Michal

