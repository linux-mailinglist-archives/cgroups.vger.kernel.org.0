Return-Path: <cgroups+bounces-4532-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20F961ADF
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3A7B226FA
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6461D47C3;
	Tue, 27 Aug 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVXQ6P6H"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752241760;
	Tue, 27 Aug 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724803103; cv=fail; b=D8FWjWmGGSl7W0ktD6dnFW2IGxYCMC1nPFGmtQZehwZR8cERo4MOJWk2HR32dL70dconQH8V6cxuHOLPX5/GIk5Lpt/i1O4dZSzYCkbgVZMQKyKqUvjaFAiXUeG8D/xMBcXqZErIgaVG6nS52ZERtSyX04vtD4/eCxHZEVOKR9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724803103; c=relaxed/simple;
	bh=qFHDOhqt5XzeGY1wpMSbZMoFH76VUS4MSO68HBm4XtU=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q399x6vZ1Gn1yO8OPxPYgpV0UBWgxK3MSoMZEYYguVjfO/vau0XYftkxwRm3iAW8nG3kf9+x+/nAyL57GHhm675qiQMH05e+5Z/P6PXlEQBpnw5Ze32PBSSHlkfOFnFGwjJUR6HKQnu5MpagAU0yjt4yYOi80mLRt+9IhyJhdJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVXQ6P6H; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724803102; x=1756339102;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qFHDOhqt5XzeGY1wpMSbZMoFH76VUS4MSO68HBm4XtU=;
  b=TVXQ6P6HZcyiamXy2HV+XI/g206RFVm/D+4xfl2DtZqnxkdXVzxBckSz
   R6nZiK8CJ/Euwp7rN5VUfz5tuyg+B5ZVDpEItc1hvIbTcMbXVF4n0C8E4
   UGeZEgI+QzQaQXP3Z3GHFxC7QrsFR+5yoaGi2U0YnXbfe9qWGyEaHv8KL
   HQ8GPeIoGsGS9n0Flc2cbtbkALSoYssXMG7TCmrHLJVicaJjOhsgEwRRB
   9Pz+8ZnEGiqkFnFyVRSKEC0zdtu+9s0iHC43J4rUzOmaOGJhMtWYaebaF
   r2BJFIEAgSIkyBV2hyoUDXuIzbnjxpO9RyJ1fA+yIWZGtAddxwAKQawIv
   A==;
X-CSE-ConnectionGUID: b3BV2/bYR8ae0JLVOPn6Gw==
X-CSE-MsgGUID: n8tmZs07TKGuqV0KhkBvwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22837124"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="22837124"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:58:21 -0700
X-CSE-ConnectionGUID: Ow803cEoQyqOBAcM4PmQQA==
X-CSE-MsgGUID: KNaEqTiHTrK/LEmRb/A9Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="62700774"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:58:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:58:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:58:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:58:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihT8seq8DViVR7buFD5MpTObvkUvMNgxbVbYpyijt4borHidJ5kWRcHp1IYwUbVzqlHI2EFZaK9iLogRGjsxK980i+L+5LgH0QGPDpPn2dPwgx41Gro4sssMsDy+iuoniHeKI9GvewqtRqfm4oMJI1d96ARTCShcKZqzf8Usiza3jgJl9KK90vyJQHg3BRRwPgOSRYrhhvy3t2v5zjbwadDkpgad2Pq+yHxogZ4lD25eNFh2nxwBGn0qRDSmDdul2Heqpy4Sv1MgULWlv9C9nJcxuSE6QYB1I3av5WiXzsDuV/ct5PRtLNAnMZkjNzpWCI9QCWjZQb9Prx//1aN7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYWu1JEKdLZ1KkcrtpIf5HHygbmnhHNL1dNeZkcW/S4=;
 b=q6mEMI1Ge9aXyQA1+yOF0x8urwjnFK3hZwqICQ8N3ckQq4CK7UTR10uy1TDIy/WdoRRXwTdj5VM5Rd1wAOEva+fkYztuzKoy4czO/cort/HDHg94G4xMsp+nbSXb5fs0QyiaVF+tS6nCXtYswf4hTspwU5bP153pbJ36tCkGrbusgiD2+om1uKUgHqWWoQpS+T//d3qjQxdfz2UgbaPNbjBaI29lte5Kx0tpUW6e3/cWhzMwcmLFg4u+6QScqSEHqPN603Eg0KMzJ+571DRk+5BuRED9qGQm7WwMWNWZMPaDKNpfYk9IaGnKTkxNuvznt5IgLUZGd4shGY0jQWttvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV3PR11MB8727.namprd11.prod.outlook.com (2603:10b6:408:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 23:58:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:58:16 +0000
Message-ID: <48a17a78-0564-4a97-9c87-2fecae1d4afa@intel.com>
Date: Wed, 28 Aug 2024 11:58:04 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 08/16] x86/sgx: Encapsulate uses of the global LRU
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
 <20240821015404.6038-9-haitao.huang@linux.intel.com>
 <b91e6636ab7b6b96a723c9ea78ad5119ea1502c9.camel@intel.com>
Content-Language: en-US
In-Reply-To: <b91e6636ab7b6b96a723c9ea78ad5119ea1502c9.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|LV3PR11MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: c02c3ec9-5404-4f20-fbda-08dcc6f41e95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0RHd2NqcTJJTjRsZVlDei9tTElIUGY1dlBIWVg3THpIVmlxN2hNa2pnc3BL?=
 =?utf-8?B?cklmNVNJTmhYSnRseWdFUy8xVW1KK2dmSUliT3RwSi9Rb1FXNTVySTlwWEFw?=
 =?utf-8?B?dUhLS2U1SE1taVJYZ0hqZzRzbGNrSzFqbXR2K3JaU1FhakN5MWlqZXp2YXZK?=
 =?utf-8?B?ckZ5MTVwNUxBNmFPMTR6bCtBMTJQQytQcHhZbUlpdXBqNmJ5aXVQVTVJZW5X?=
 =?utf-8?B?Q3ExcjlhWFFraDRYRGtQOVB2NDdwUzJSblFreXJqQnhtMlg2OEdzZzhodHJ3?=
 =?utf-8?B?aW9nUklZM0QrZ0MvUkNwRi9VWmFMUVVuRUNtdnp5NHJxK1k2eWN3WUcwMmxt?=
 =?utf-8?B?T0dCWVVpU1MxdmdDSDZDREtZMmlyMmVBc2l0M1VlNE5MSGFDY2RoQnVjY09Q?=
 =?utf-8?B?SjdHeUg2QnJ0ZjMzQTRSNDMrT29ocW1aZklFMWRRSHF4Q2dqeUhKQjUvMVYx?=
 =?utf-8?B?S0RFdWhNKzU5a0V1MGJmNk9oRE9LVG5tVTAxMUloTlg2Yis3dGduaG42Z2dh?=
 =?utf-8?B?WUJhWlVMa056QllDQ2lhbE45Y0wxSy9SYnhvcStuUDZWckU2RGxiVVNiai9V?=
 =?utf-8?B?VmRkZnNkRGQ2bGFyUFVWWkVMWGpaZ2hTV08zZ2lsbHBIdzdDNGNsZWxiYkkv?=
 =?utf-8?B?SXlxOHp2Ylk0d0NEdVJuZzBhc1dNSGswZFpRU2ZzdzE5NkJRNFgzNHBTek9w?=
 =?utf-8?B?UjhoYWZJRGFRc2JZMEFhenBmcjROcnQvUTYvTFFEdUlIOWpYQzFaUG1RNXRN?=
 =?utf-8?B?akZTWHZiUHY2SjZvMkwwN25zSUpIczdheTlBczJSU2tudENLUTBmWk5HUlJw?=
 =?utf-8?B?WEk1WkN5TEVKcjNDWlU1bE5lSEYrcDc3MVZtRjVpK3A1MHRxbVZCRVA0RE1C?=
 =?utf-8?B?L054Q3hSSlovRGdJZHJHUkxMVG5VSmxiN1IrQTN1d3pFNzdtMU9abHZRK2lI?=
 =?utf-8?B?c1BGT1RPeWpmMkVDQ3NZUSsrT2RuV0JjTzRBbnJqYXI2U21TNnJHem53R3hv?=
 =?utf-8?B?L0dwVXJ2Q2cwaGhjQk1kdCtYbXVxZ01zZDBSODgzQ2hGbUJkWEkrN3JhbTBs?=
 =?utf-8?B?cmZHOFZMWUJHUGFHQ09JK05zZFVrVnl0M3Zzb0grSjU0ajdQa2doVmZOTnB2?=
 =?utf-8?B?U1lLVkJzaVFpa2VRN0VmaUVacVFTYm1VYXZhWmJjMGhWY2hpM0p2QitEbVBQ?=
 =?utf-8?B?b2JpZWZ0Znc3QmhpbndTWVkvdzJhZzU1UDRCckFPNUxPcS95YS8vVFVmTkJq?=
 =?utf-8?B?TDhzYXBRZUlmT0RENW54VHNhU3N3NExtMGVqeE5Yb2FTNHU4QnRhcXNPV3Y2?=
 =?utf-8?B?Zk5acTY1cVpXZXFQVEJ0aWtiVmk3OUpGSkdBeFJiMDhRdElWbW5sbHBUMEpN?=
 =?utf-8?B?WlJLczhuSzZhZTNSek4vN1VHVHhaZTAwZjBMamQ3UXlHWFpZc2EwQjlycFI1?=
 =?utf-8?B?MzE2MFBDQ0tLN3FXM3E2THR4ajdwZjBGVitBTitSNkpqS3p1UGhsTEROVVhQ?=
 =?utf-8?B?S3lndW42T3pnSGsxQWFYZGg5K25lTzU4bnRQTXRXaWI0VHREMnBhZUVPeVdu?=
 =?utf-8?B?N1hwdVY2OFUxTmpDZUtGejV3T3V4bVMwVGYySFFwMDZUL2NwckFIWjA5VEN6?=
 =?utf-8?B?VnNQdU00NThjL2dXbExsZjNNbTI1RGN0ZGFSc1VsVTkrTmtDcjNZYld1Y0Ri?=
 =?utf-8?B?bnlBaTJrYnRDSFRZanlITGlTNHkrT0hlMU5rQzBkK0FzWjByM1RBNXd2dGNu?=
 =?utf-8?B?ek5aNmVrSHZ2WERGZkx1WnJkaEdhK1RyRDNZL2pVS2NHNzdQb29mcXh1Mkd5?=
 =?utf-8?B?RFZRTElKSyswN0hDeDJvT1dTb0hORno1YXNQejdyYURXZFlOeE1GVWhCck9o?=
 =?utf-8?Q?YLQ4CrkznwswG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhHcWxHelQwajVUbWNjUHdTUG1WalpxR2xmbFY1Nkg2UncrcmJ4NGd5SS92?=
 =?utf-8?B?Q3pGeXkvWWpCbzQvUGQ0MnZzWW5IVEQ3VDNsbVVzWU9oY2RQY3ZEaXlaemxR?=
 =?utf-8?B?SjdsNFFQc3NDdTlIQzFNVlNpV2djUlZhSlV0dnVTVWQxQ3NWbHgyR1VPM1dF?=
 =?utf-8?B?eUwzdDFtMFhxK0xQTDFlbU9KMWc2K1BidnE1U09kdkhSZnZjM3poeS9MbUU4?=
 =?utf-8?B?UTFuTE9ONFBsQU5WOTNKRDEwdTdSckJqeDg4L01hNHZxck5jSnR2eXdnUU4y?=
 =?utf-8?B?WTdjdTZJY216ZkJGQnZpQkJsQkRjdisxN01yWDZZVlBHczVyRWlrOElBdGhh?=
 =?utf-8?B?WFVkOWJoL1hYUzJMNTV5S3A0bkFVK0FsUkw0MVkwMVAyZzVMR2NPYkRTOGlh?=
 =?utf-8?B?QUFxYW4vSW14dEVQUmhPbWk4Y0c3UmVtY1QrYS9VckowQkFzSGZGb2lQeUFz?=
 =?utf-8?B?ZlBWUlpTb0Z6SlVNOVZwazd6ZVZQUjdXY0pNR2Zrczc3UTBTT0kwbnZwZm5C?=
 =?utf-8?B?MXB6MDNjN3B5MlNiUVdoS0R2SHNlamdUUnp5eXJBNXlQMkdhSGRjaWlMc0RE?=
 =?utf-8?B?VWFZbDQxU3hkSU0yQ00yaGdNdGJ0K05FaVpUcmJCQm5VS0xxc252WjR0amEy?=
 =?utf-8?B?cVFBTVloY3pDNWQ0TitQVUlXc09ubCs0WEI3ak1YUGpjYWdhc3NpUkgzWEIy?=
 =?utf-8?B?RVZUMG9xOXJiU0NYV1FaSGdDOWlZQzBrNkJyMkg1dXVrT0E2V3B0WkxjUEM2?=
 =?utf-8?B?Y2RMOHdDUEpwNEdYbFJsVUVJY1pxTWVZT2p6L2FzRHlaV0hydUdvS0tVVWFU?=
 =?utf-8?B?Sjc4VzlXbGY2eXdzQ0FDQjdxMUNubjBpZVFBQUVkbVhXQWk3TllGV2lwSEpy?=
 =?utf-8?B?L1NKTjNvNGJaWkVJbHBnRmZHNklUZU9vVzNBVXZkNFh2VUlxeG9iazducGo1?=
 =?utf-8?B?YzlvbCtIclpnVi9jM0NQRXd5WUZHWUdzek5BRkhhdTQ3NGZaQTNVcnZKMVBJ?=
 =?utf-8?B?RzJhVnlRcGRkQk8vdnA4ZjBZVklGMHBWSTAwQWs0djYxeUdEMlNCZHFndWtI?=
 =?utf-8?B?VllzbjRacysvVmh4QVdzc3BvN01tbjV4NjZsRVlNZWJRb3dQYXplRXF3ekRJ?=
 =?utf-8?B?STN3a1J0aWtFeXhLK2lnY2ZqRlNiTXM1bTBvVW56bFcwNzZWUmJGcmt0Y1FS?=
 =?utf-8?B?RzRhUjg3NHgvM2lDUXJKb0FPYndSaC9jVFJZeFdrM1BGdnI3TWJCZHcxWGhx?=
 =?utf-8?B?MWRUWlVUaGFqYVJCL3cxYjVUdnR5c1g2U2VUbU9Helgra2NQd09ybWU2cVRm?=
 =?utf-8?B?Nk0vUFZrR2FaV3JsR3VRQ3VndnJOZmtJN3FjOTI5RVpIUTVFU09PZkZyRTRO?=
 =?utf-8?B?SkFCMmgrVk13NWdhQ0JGTEMzeUo1QTh4cWp5Z3ZjeWcwdloxbm84ZGwwamNZ?=
 =?utf-8?B?Vk16RjUyM2laa0RQNURZN29VUnJteGw1YTlzZk14cnJLdnp4azJ1ZXJESzJT?=
 =?utf-8?B?UCtjTUlDSm1GcnIvTkNuLytoWjNMSE1NTzd2ZTdQKzYvUUpsTlNlQ3BxQWtn?=
 =?utf-8?B?dHc3TDVsQm1vOTk2bGVIb3FMajJ1RHpzbEdxVlc0MDUrWnRNWWpNSms3a291?=
 =?utf-8?B?cE1jY1pKbGc5VGc4cTZBdm5OY090VlRrQXdCMTR4YzY0U2ptRm1aZkZZVG5h?=
 =?utf-8?B?bVFZbHVGK0NqRml5SUsvL1ZvZXdwU3dZQk5GUTJxTVl1UTU5QlE5MzAvcUtN?=
 =?utf-8?B?dGhNRlFkUVhyWXRBUkZJSFd6N3BqOGRQa256a05MVWF1U0NiK0NhRUV0Qk8w?=
 =?utf-8?B?UCs0Y3RDdUpjWmJsbHIwV09RUzNsYWxpZExnK3ZrZy9VOC9lNlJZaFFCRlJG?=
 =?utf-8?B?dzJHZUdOUS9INnptd3l2ZnVmZ2RwTjNCVmo0WEJadzd0UlVITXg1ajdzeXZu?=
 =?utf-8?B?M3F6cHk5clV4ZkZPU0FXdURGcWpwSmc0dFJ5UmNDRlFHNUtNQ296TGYvTUg0?=
 =?utf-8?B?QjhDZlo4amtsWnBDei9ldWJ1OC9hOUtYYUNKYWNWb1hyWUladURRRktuakdD?=
 =?utf-8?B?ZWljV3plN0l4NXFza2ZsQTRxS2JBNWZXUmZ3dzFMVHRuUXJ2eVllM3g4b2Zy?=
 =?utf-8?Q?dx16ml+ukO0YRvlfKNKjC82Aj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c02c3ec9-5404-4f20-fbda-08dcc6f41e95
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:58:16.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMnzVCJvLrXO//owdyjLa1MyjgNEmitQTYSORg1udDkHQg0A4xx4imk+nG8TbKeKvKjN6yWrZK212XesntdTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8727
X-OriginatorOrg: intel.com



On 27/08/2024 11:13 pm, Huang, Kai wrote:
> 
>> +static inline bool sgx_can_reclaim_global(void)
>> +{
>> +	/*
>> +	 * Now all EPC pages are still tracked in the @sgx_global_lru, so only
>> +	 * check @sgx_global_lru.
>> +	 *
>> +	 * When EPC pages are tracked in the actual per-cgroup LRUs,
>> +	 * replace with sgx_cgroup_lru_empty(misc_cg_root()).
>> +	 */
>> +	return !list_empty(&sgx_global_lru.reclaimable);
>> +}
> 
> Firstly, sgx_cgroup_lru_empty() is only introduced in the next patch, so it's
> wrong to mention it in the comment in _this_ patch.
> 
> It's weird to add the above comment here in this patch anyway, since ...

With this comment moved to patch "x86/sgx: Revise global reclamation for 
EPC cgroups",

Reviewed-by: Kai Huang <kai.huang@intel.com>

