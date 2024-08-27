Return-Path: <cgroups+bounces-4527-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC9961A94
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB4E1F23C8A
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAFB1D45F8;
	Tue, 27 Aug 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iutNrRMh"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979AA13A258;
	Tue, 27 Aug 2024 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801369; cv=fail; b=P4ovswJKpS3IyBCEMf1Mbmb3Ft9/JGZbYbgrF7o7qyuJ3VMYPuC5yUlTBAdUUHADoX9RDkTY3XFMhtIO8QmKpOfNKDbRdUtD68fbgboD8FektXncMLZ3fONPkls/DBJErASVFdChWlebXG3l4+qz0FYFFWU9wEgHtlC5avuTEkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801369; c=relaxed/simple;
	bh=nfpVwOy7rVNPKLgleYrN6vSkfIAHihbuTMPQ+7hV+YE=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pgp9Gz6Uhre3inJYDGbQM7pifxWcjRCs0pJMGpOyRPkG7mMnp3HSWSzh3iKpbr20HpN4/Js/oKo69RcfApZAuAj7Q6aZYLQHlGyeKwzRi4GkQ4lEaxcWjenFl8vdkeXK1NWg2NmbJtqhCxOA0CGya8aaoXOddgxvwPjFYL/SYfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iutNrRMh; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724801368; x=1756337368;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nfpVwOy7rVNPKLgleYrN6vSkfIAHihbuTMPQ+7hV+YE=;
  b=iutNrRMhSD/kRiidS0baI6EJouqud1GpZwuxtJuqfvQt90pmWwX7JFkN
   1kFaYruggmJ0kp0pL8qTuhEbLseW4FMtu1QIIUMoWlQ4LCoa817GduFV1
   N0Zjs7LVIC6SgxOo1GhyBQfZIQYF71Iczkj1Kt0uQzHtSOO9Q//ni6Hz9
   acloIdKbYyU8+W56P0He4+uyRE5HWkIXkoyFpWEXzb3rJTDbFKpe3+30w
   iD9BSxs8W9QGFXOFl0yu9F8rpFLiRkdAXdMdoM+SrSHadhVk57keVcDvO
   JFBAcUMafrQl2xMiC37GIt3LR7gAdonLh58uIDf2XxCv7CSb799FxPsoz
   w==;
X-CSE-ConnectionGUID: YYOXA4oWTYmWYkHu6C6eRw==
X-CSE-MsgGUID: hVtBJHwdREKHfSzAVvqoHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27076004"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27076004"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:29:27 -0700
X-CSE-ConnectionGUID: 1lJt+BkPQvGjesIMGyql6Q==
X-CSE-MsgGUID: d8txcx4hRWaRJqxm+h+F5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63026360"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:29:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:29:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:29:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ju1Kjf6IvFKHlA9nIcqBQq5FVq/mA48pSmIj7crmTE95ruiTGv7lKiukbYlfnb2O27oY9A300tV3BlAauIoTN7EGQZRmGkZxRkx7yZPoASDKGghizkuMWBaosmwe3E55Wbz6T6VqHu/WxdWFIiLuthDPejp8m11GKQS6+cYzoJoR6ouf9zh/dtizibap1//xOTX1Fx/19kBE1o5KMuJqLWpZC+IqcRiFA/vldpGTuN+XXcnqTdMkRsOhUR0NfkrSy8QMG0d0XgcuZadX+3DWncLAcI001Q7WPqfSEKNcBpv241D1LmMT2Po5UhqCZkl8v/xD1xS08L00RzaWtrmosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82K/nsIKHWvnBIWglJNGE93IT9zsDGaspXy+I44rOuI=;
 b=E0s5aSlGj+i24pwHInPXnTcptmgs0+HldP3lBgCOXbShTUWhhBTzDkIRiHCREVDy1SHrcSRkI086ky0TIXPcPEwbMCkeSJPfzJM3I8Z6rXDXFfAaZGJrBwOvDiJCe7HZ8n/pdJdsFn+/k2be8j40DZ30Gfrll1sP9cDn7cN2Q1Y4BYsVzMgrEUW99oY+UaOaFs2UZrcbF7Au6m8WoKlKPmgUDUnoMN9Rx+/3XsAGvbAcMkBHPDMDjoiky3NJ65SrfGXjqP3oSwWNof99bgHLREc0TrGXV8/IdCAR63xJsPkC764ZrWAe4kECd0lZvISurEzieAUWc7/l1i2I/JAc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6123.namprd11.prod.outlook.com (2603:10b6:208:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 23:29:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:29:19 +0000
Message-ID: <83ecc15d-c5f7-444c-b99e-990f2903a0dd@intel.com>
Date: Wed, 28 Aug 2024 11:29:07 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/16] x86/sgx: Revise global reclamation for EPC
 cgroups
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
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-13-haitao.huang@linux.intel.com>
 <99793ef7988905a15720c4955590a143313e6af6.camel@intel.com>
Content-Language: en-US
In-Reply-To: <99793ef7988905a15720c4955590a143313e6af6.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|IA1PR11MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b3bb3e-12e9-4ef5-b536-08dcc6f012e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anhIYlNQUmNGVHVleGNYbDhaVG1JZnY1R2tuYVBVRjh2NjFWVzdiU0V4angr?=
 =?utf-8?B?Q2tUejJYdUVCcnlmbmhTZGpKakFnZ1NyeDc3WDI1cHVhZ3FXallKMkt3WmRD?=
 =?utf-8?B?eG5FVkRSMlpkMzFaUXhHYUp4enE0SEg5NEhxdmZOZnQ2MytLb05POTZZMmti?=
 =?utf-8?B?YlFOZDAxR013VzBrSitQY0FlbTdLbTgxODRwQVhLMzJmREJ1czdpck1YdkJz?=
 =?utf-8?B?N1YxMXJzZllHakQ2SXVOeVZUTm5kNEZWK0FaREpPb1pEcHljd3BJcWpuRStY?=
 =?utf-8?B?NUpUb2xmc2g3c3lFbHl1UXNUMFJrRlBkTEdQa0xLZmNGTUtlN28zTGdDNFFo?=
 =?utf-8?B?OFJrWlhIQllvQUwyZVZRRElvRk45TjJzQWxBNkttTzZMdU5XZ25VZENOUFkw?=
 =?utf-8?B?ekxwZmQ3K21OZDlWb2ZoS2MwUUJISEVDRmR2NzJreVowSk10VmViSVh1L0RM?=
 =?utf-8?B?RHMreUpVem9ZWlNmWVFWazA2cXljTjl0b3BpRU5WaTJVWk04ckkzZVNZMmxm?=
 =?utf-8?B?clQxcnFtUzFFMGNPaUlaejdQZ1AvUWhDdko4aDA3WGFOMzZaOHkvMXJxd2J1?=
 =?utf-8?B?Q1UyeGVNZ1BtWU5PeHpBQVY4WTI4OTdhWmpQV3BIMzh2K1RzdkkrTFkwUUdJ?=
 =?utf-8?B?N2dNT0RHQmlnenBJSnFhQzFnSmVHMDBPTG40ZkJtU2pnVHloNUk4UWYwTDFQ?=
 =?utf-8?B?YzhDNzNFYWFUOHhNWUo3c01neFdZQlVDKzJwQnVNSzB3Y0Q3SFpLeThUd284?=
 =?utf-8?B?VlVCd21zbnYralhrVzV6OTcrd0NTNWlwUHpTc1ZNVUEwczBoLzEyaVMrTVIx?=
 =?utf-8?B?eHc1bGVZQXdPbCs5RXEwWnVIdUxlYS9wY3QvVGJjaHUvUzc1dzJoWG9lMFpU?=
 =?utf-8?B?ZHlVQnBmMmFnOHQ4c3B2d05FcWxmbkFHMUUwcCsxa3JvZ2J3TUpxMm9QQ21r?=
 =?utf-8?B?bWFIL1RxUFJhWXZzdnkwQUlNbFdld0xUWnZCRk1ubnpXREF0ZXQ0cXFPMVZx?=
 =?utf-8?B?M0VVeHo3OTh5UVJlWWtROHpqRG9iSHlNY1BMTUc4eFJpOWc2d3VqemprT0Vm?=
 =?utf-8?B?VmVTMU1rb0p2NFl4aE9KZE9LZmFrQ2pXZHpuVllTeTJMRlU0Z2Ntd09jYURB?=
 =?utf-8?B?dHphY1BadUNYQytCcjNtNW9xNHNDRCt0eTNHRnJwYVo4R0l5MEpKZFJJdS8z?=
 =?utf-8?B?RlBPQTdlamI5TGd6OEF4Tm1SVlFONThCSDJyRHlWeFR3QXZ5SDI3a0svbWhG?=
 =?utf-8?B?ZklQWjViOWxkV0dJRml5SkhZa2pEcVUwcmZ6Z0lySk5sM1VKb2FhRExDNDFN?=
 =?utf-8?B?Z2xnV3cvb1NoZVFQd0lPWVBDSDYyalZOYlQzb3h5T0hsN2hyUVVyL3ZKMGxL?=
 =?utf-8?B?Y0FPcUJWNXF5MnlIejBjYnpHV2hQWWEyMHlUUURLaTQ4TGpZQzhBZkZBZ256?=
 =?utf-8?B?QjdLQm9qaXkxbEI4a2ZWMkxKY0ZKSkFpQTBNaTRKeXJSQmE1NXlmQVlNSDBp?=
 =?utf-8?B?b2xJNzlKeEpkbUloYWNZcVRqSUZpTkxweUNhakh2OXNlb1RFeFlSM0hlOE9I?=
 =?utf-8?B?Mk9kZnBneFMvbWVVNVNhTnIzcGJKSWcwNGlBZHFvcDc0QVdBSjlnUDBVVXhX?=
 =?utf-8?B?bGtqTU5QQ1U3c1dVand6aHFFeElZdzJPN1FTc0c0cklBMWQ2UyszREtuK2pK?=
 =?utf-8?B?VjRnWGhxcmxoWTVOTE5odGluZHNqL0J3T2tnZ2pqNDQvemVuMng2cy80T2o2?=
 =?utf-8?B?aTkyQzRQbno4SU5pNFcveXczeTMwTzlsdSsrZ1lERzlOakxQOW1BSXhGYkE0?=
 =?utf-8?B?ZWtVSVJlWEs1OGxMbG1SWDNlQ2E0OGtOakY3UHJGa3Rydi9ZT0JyWjFGazI0?=
 =?utf-8?Q?JdgrS7vokeYff?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTE2c1FMV1BGOG5IOWdoN04wNGdJUUpvSVk0bnRGdG9FY3FDQlBVWHdiVDlO?=
 =?utf-8?B?ZG03UlFvbzkxWUhiMUNvNmxkSGhMZzQ2aGNKSU1kWHlaRnVQVmtIOFBaN2lN?=
 =?utf-8?B?akRGWTJmZ2dVU0VEV3ZZeldhZG5NRkJYYzdwV21uMjJFYmdqRGpqWGxwUG1B?=
 =?utf-8?B?bStVbEp2WCtyVzZtZVhDMW1yYWRiamF0bFFLN21pcUtFTXlocXRTaFRXcHV3?=
 =?utf-8?B?TlFjNFJybGcrUGZYNTBiTjJvenpsQXBHbUorRVhWeG1VN3k4eW9KZXFzZzl5?=
 =?utf-8?B?aCtkMnQvcDJxUjVLNEZhSjBWc0ZpL2JNU016dTlia1BEVnhMbGRaVjBLckJq?=
 =?utf-8?B?QWtGWmpUdUZWbHN0Szlvb2wvMEpNNDZnMHNzbXBFSWVhNWxMUjVkR2pDdE1a?=
 =?utf-8?B?dnhHL1c1SkFVRVkrMnNlZnBDQzBCaEgrNmVmUWJOUlBadWtaQWV2UTNHcDVz?=
 =?utf-8?B?dUdxejlvR3IxUXZ3b1lsK21QWDRnR2tsL0gvaDhjQ3UvdDRiMEhuamlUbm1X?=
 =?utf-8?B?UHZPQnF1NWxLNm9MV0JhY2x2SU9sdk04LzNYeHhIcCtqQnBTVzVCdEd5cUth?=
 =?utf-8?B?SjMyR0ZNR3R1VHZpQXdrM2RBdUVLWENQZEFSY0tmcDh1Z0hzd1pyanZuTkRV?=
 =?utf-8?B?Y3FnaXduYlZaRkE3S2VkSWJDbWx1YVo0Ylo3b1l5d2w3Z3VIbTZyWm9aVXFJ?=
 =?utf-8?B?WTBpaHAvYmYwMUxNVk1YczVWbHl6Rm1XSnpMZGthTGp1RFZsUVQxZ2YrdkN0?=
 =?utf-8?B?MVprRmlYRWhnOHNCSUJXc3JNV2RPMERBbjk3cGNTenhKWktlMHVnVWE4aHFx?=
 =?utf-8?B?QTZYZUVoOGlwTTVETlNlNUdUUytmM3V6SStXNVkwWkdyQURWYlpyN1Q1Ynpj?=
 =?utf-8?B?RmZVZjRKZDRINHVpUityRlgwcURNc29peE5EUklSK3k5RzhML2pFVitYaUhV?=
 =?utf-8?B?VUZtNmcvbWhKd1laa2U1M1JmSEhlZmpLdDNqU3oxeFNLQkxSUGZ0NDUwSFZS?=
 =?utf-8?B?dGpDcThOQTJMcVFzK2JpSG0xM3FTTkNPQkxCRnpseFZ2elRuRC9wQjdLRHpE?=
 =?utf-8?B?K1VlNjU4OTFvU2hvQVBqVGFQOStNNjg4RG9oWGkrbGlEZXNLUWNXelc0aHo2?=
 =?utf-8?B?eHNqWEIxMjRuRTZjR0p0cEVhQ09tNkVyZWszY2V1UUJWYW1mNU9NazVqN2JY?=
 =?utf-8?B?UERTSlF2eEIrSDdzNElJZitNemNtZlBxcGcra21QZjdCWmZJQWlLUnBwYytS?=
 =?utf-8?B?WjNYVHlrRGJhc0JyaVBVNzRKQ1dNZnhuY0RkOFpkaXhCZE9OSm41OGhFS2h4?=
 =?utf-8?B?dUVmVG16WHN0OEhTRXFTSzhadUwzYm42aXh3RmV1UTFmSEQ4NHhPU09KTHh2?=
 =?utf-8?B?RlBHcTcwMktMYTErVVB5Q0l6amZ1blFyNkRoemxTcStLSHdlUFdiV1Vab3lv?=
 =?utf-8?B?cTdmQWhYaWovYy84TW13WFNoT25LcXNsU3A3Sm1TMEVpUmlEbW5PV28rTDBZ?=
 =?utf-8?B?Q3lHRytHS21DMnhvbUdNVThuNEFNTm9QUzZHK1NtbmdDKzBMRE42REtFSGRZ?=
 =?utf-8?B?S2ZOMVBHZGlsTXYzVUIyWG1yTXJ1MGtGTW01ciszejR5bnhoM3BPdXdnQzVW?=
 =?utf-8?B?MG4xdjNOaGplakpPQ1M3OUQyVU1iTEgvd2ZMNkl4cXB0ZmJmbzMwOEVRbS9D?=
 =?utf-8?B?b3BNQlhZejN0Wk5IL2tVZllUaDJLWWljT3hINGhJd04rbEwzSUZCWm81emxw?=
 =?utf-8?B?TTZ6RzlOdE9IeFpROTdmYlFNTUxjRUlraXZkeC9tVm14VVZFdHdmUVhYb1cx?=
 =?utf-8?B?VXNvaUtpV2JPT2FobGlRWjV2V3o1blRKRGc2bERhVjBYSzhYVTNBQk9yTGgy?=
 =?utf-8?B?Q2lGR1JBR0F5RUdQeEJjajNVT2oyQjRnYUU4S2NxbG9IRm8zNmJhenFENmwy?=
 =?utf-8?B?enExV1ByMG5reVRnRzNvSG14YjBQV3UxWGtYK0F4U0dpWThlZ3lnYnRpVlA2?=
 =?utf-8?B?SFdUaWtjVzBmcnplZUNHVnRDcmNvRFd2dVhIeGtEOGxmRGdmdEhZSllsYjhH?=
 =?utf-8?B?TmlUTjhnQjV5L2VXQWlkRjc2T2tzMmRuSHZ5YmhWdE0yWnVaYk9zVG5QS0Zq?=
 =?utf-8?Q?Zl04ly8+OmXMiVSGZejZoAN3E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b3bb3e-12e9-4ef5-b536-08dcc6f012e3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:29:19.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVRa6u9IppNm1XtONW05uNbBJbUUuyG5O7mlrzrb1wdpzqKaO6Ob/VlNGN/fH1RHsdeLwUkJC2e/7GvhGVsPPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6123
X-OriginatorOrg: intel.com



On 27/08/2024 11:32 pm, Huang, Kai wrote:
> On Tue, 2024-08-20 at 18:54 -0700, Haitao Huang wrote:
>> With EPC cgroups, the global reclamation function,
>> sgx_reclaim_pages_global(), can no longer apply to the global LRU as
>> pages are now in per-cgroup LRUs.
>>
>> Create a wrapper, sgx_cgroup_reclaim_global() to invoke
>> sgx_cgroup_reclaim_pages() passing in the root cgroup.
>>
> 
> [...]
> 
>> Call this wrapper
>> from sgx_reclaim_pages_global() when cgroup is enabled.
>>
> 
> This is not done in this patch.
> 

With this removed, and ...

> 
> It might make sense to have this as a separate patch with the comment of
> sgx_can_reclaim_global() being moved here, from the perspective that this
> patch only adds the building block to do global reclaim from per-cgroup LRUs
> but doesn't actually turn that on.
> 

... with the comment of sgx_can_reclaim_global() moved to this patch:

Reviewed-by: Kai Huang <kai.huang@intel.com>

