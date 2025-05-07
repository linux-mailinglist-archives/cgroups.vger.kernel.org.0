Return-Path: <cgroups+bounces-8070-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA89AAE390
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826B71BA7972
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A011289E0A;
	Wed,  7 May 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQpLXpKz"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656B280325;
	Wed,  7 May 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629572; cv=fail; b=rY5kaf+rkRJMGqrBPxQMpBC5TXKitm3FOZIlT3l5hhZXtFI13Ue5IFV6Cs09oRXc6fUdutlDz/SQK1QVNpyGP26hZ11qXwJ6RE9JJERvYG5oLluS1GFGq8egZf4TdVcyZMl21TAP2GW/nBY76M99Xenx6b32f/WKc+bamJwlP0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629572; c=relaxed/simple;
	bh=tr/EP1yX5AF1nYX6221nyR05FRj0m1NzAKk5w2W2XWw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUWAinheE4fhn6KyH9Jv7iL8u9x6GXkUN88p5MnNuQCqZG2XTePnq2P1RniDnwztL0xYJEb5X8Ly3guV7zmTpDIBh15PlHXo7UFfh2VWPzNzaR4RXT9LIKZXc9zU8c5VLTBKlk4GDsOc0W518YR4Sf/DB9Jnz2k9HYy08ajfPhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQpLXpKz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746629571; x=1778165571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tr/EP1yX5AF1nYX6221nyR05FRj0m1NzAKk5w2W2XWw=;
  b=NQpLXpKz6savBnj34t2LYU5wXOj4iKOEpRkIm1BVmje80YI19uybYVcS
   Ma6hprzPsJFFb/p8oPXNi6vO+5SXQZDx63xmFsKywJAmsKCgabEBp7dwj
   wwV0G20aq/cJlrmFIEiaYzXv//JiyzA1DWoGpTaRE3oA1YH2I+LkuXxth
   OvcvumySvkEsNz/+IhQtcw0YE/bXUf3KnoNe07WEp3gnLeHpDiqKBVKVC
   uydwAZcrN6BuRfIoK/9asWETeojEnEZ4G8GCrAcTF7QCJIRZTiSPXOYPt
   A306qcLmaN9MTBSTifgoy4b6iN5fvS+mnq31eh9xD9u+3l7PPdj9pDewz
   w==;
X-CSE-ConnectionGUID: L4tsv7mnQr2q5Txlw8cTJQ==
X-CSE-MsgGUID: tD9sCPUgTNWVfE+htZtvDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59762633"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="59762633"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:52:50 -0700
X-CSE-ConnectionGUID: FCe1Vf3wRRKxa1oh3IjuRQ==
X-CSE-MsgGUID: FIS4D8crQlu/mf28cl6uxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="140824823"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:52:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 07:52:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 07:52:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 07:52:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPF8PGVWtG2QEG+hsg8tjA9TPvRxiiDHc6I/oOc49hM6B37+6KaCfIBthhSRuM7MFyT2EPMrT78yA7TA12qqAWk+SHBZofyYH+KyDPXxg7vOmSoXa92G95AZqWz8dXdtkKwDhwcbutiqXU7fu8M1QSiMuh1uZRlixfnMpYI0V34cBNRXqFB3Ncpa0YOX85VMXSt9U+LKW8Z+Gk854iNRCAEVXH840GzHNbhC7HyK8lGyP5y8aCORwex2NkN2APyhtDesv7jC2iCKcPz6RhQNsjSL9jsf5N/4I0GuVi8TqX4GUKcbLv95UbPHBfJUyby4dNoeyc3yeNYJ5YjiXNKqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZEvoFy7225ejeNQqY5OcMToHkldbSSUz7rmPDOXHr8=;
 b=l04iaavuMz/5CjTbYgzkG4uNne2GLXUHg1Dt81uuYaisvdwK4vMnMfWIHetOEUlAoKuLhnsVH9xrjhePqPF6glm40zXKedBcCHX0x6uoizwpUEcwvHJolpL/oYUU/CXqHwrzsh8oIT2xAmLJc5YCqsC0HepqZOuLzBbou+N/iPCcYz0OGUpvQGAbXGlstT1+eCtc4JHcSQCeti2Jvz3qJ7wW8oNVq5J/n5cko2xgiB8r/DBy3VZT8pdEBjHP51DStNhQGEHOY7kv+HNeTeb0ExArLCv7Ymw4vx0vT3KhMPOsMPda7kvZ6tvk1syfnTuMN+OOmqvsnicLgYmOyEKpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB8163.namprd11.prod.outlook.com (2603:10b6:8:165::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Wed, 7 May 2025 14:52:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 14:52:41 +0000
Message-ID: <c4757667-6d6a-4010-80c5-f5203630557a@intel.com>
Date: Wed, 7 May 2025 22:52:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] sched/numa: add statistics of numa balance task
 migration
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
CC: <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>, Tejun Heo
	<tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet
	<corbet@lwn.net>, Mel Gorman <mgorman@suse.de>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim
 C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Libo Chen
	<libo.chen@oracle.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, "Jain, Ayush" <ayushjai@amd.com>,
	<cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@foxmail.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
References: <cover.1746611892.git.yu.c.chen@intel.com>
 <363632bc-ce31-4a6d-8271-ecae6f6c2d0a@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <363632bc-ce31-4a6d-8271-ecae6f6c2d0a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4773f9-85e8-488f-f107-08dd8d76d0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUF5bnZFd0g2M0xVa2pHeUptUWRmME83Mm5iUFZ1UVNSQ2VDeEJ0alVMRGVK?=
 =?utf-8?B?Ry9pV2lNVVZJNC9pbkxpekpBOTE2Y2c5ZDJ4N2E3Q2JITWdYNTJxZWFLbkc2?=
 =?utf-8?B?MnY2L0tQWXlEaS85T3UzQ29BK0RwMHBGMXBsNDZrKzdJWk9rQUY3Q3gwaXAv?=
 =?utf-8?B?N2szUXp4cHc0b1BPQ1djTDFORThmbUd3bTFJOWxORXp0ZFlvRkl2NnNyeTlx?=
 =?utf-8?B?ZGN0alpDckxtbTJFVlcvVXE0NGZLamUzT3ZXZWRuODlJQ0Zsamdic3JPUWlP?=
 =?utf-8?B?WmVlRDFPeHNHeWpzaWU5UXVueStBdVpUNXdGL3lkRVBJWWJzTnNMcDMyTzN3?=
 =?utf-8?B?QXNyT0kyNExmbzJQOS9GVndTVE0wT2ZkTjljOGFnZnNkOG5vUkxzYm9yVkNw?=
 =?utf-8?B?aFFFTS9CbWFiMnZZd0JvYVhxUzMxSUVJbjA2eE9ETGtIeTJMZm9QajFQRUhN?=
 =?utf-8?B?ci9YdWhYaFhxR3pDdVBZWXpoQXJZYVo2a01DS3hXOCsvc1VyU25pZjBiR2Nj?=
 =?utf-8?B?ZGhkclVHNXdFbFBTNGtJUkZjQXZzSHV2Q05nbmRmZ0o0YXp5emdBNHE0Yko2?=
 =?utf-8?B?WHo5MUJNaC9LQ0pYK2dIdmV4NjlwSk8zcDRrL3orcUk5ajA1dEpjamZyZS8v?=
 =?utf-8?B?UmdGbyszTGUwSDlVQTdudUJCRGg0eXdlZG1JRlRacGlyMFNHR05VSk55c2wx?=
 =?utf-8?B?cXBTUm1ybGhQalhuekhHZlRjRmxSOWpQaTNsYzhyMGVRUUJmYTMrQ20yM1NK?=
 =?utf-8?B?d3JJdTlZSzJuMUhreThjUFJtZWg1OGljSUkvcnArMnNSVGVLdUl6QjNyaHVu?=
 =?utf-8?B?ZlloQVBwWmoydStUV2N0am0vWU0wMFZ5OXJ2WDZVQUN6WlpTVHZWdnppSHlq?=
 =?utf-8?B?bS9Jb05kS2Fic05lVHZObUhpK3htSUp6eVNPWk5LQXdZMUhLeDRJYWgwUVZt?=
 =?utf-8?B?RjVqUEpadmpySDhDWkR1UWpUbjJrbmVzSTBLcVRwQlVUbHhNODByaURRZGU5?=
 =?utf-8?B?TzdybFBPVjVuS04zM2MwMHhVWUFBWEtxN3EyaGhCci9yWWhpZlV2aHN2QWNK?=
 =?utf-8?B?WXdFTDAvR2M0R0hFOEVHd1lyUWphYzZ5Q0FiR0hNUFZzcjFQaVhQUUpsRExy?=
 =?utf-8?B?Wmh3WkVVNFV0VE9IY0VxS2VnZFFRS3ZQTC9FWnFnWHlRMzZSVXdLR2ZEbk9z?=
 =?utf-8?B?N0ttOEJMQ2RQU25oUTlKcXdBVUFnekM2OXdsL0NaU2F0VVRZalZPUFJUSGth?=
 =?utf-8?B?eHR5U00vRzlaTUJ6S1ZuMVM5c2dqVjd0cDJrYkovQklqZ3pLZzdWSmhmSEpi?=
 =?utf-8?B?VEMwSHhLdlR6Y2VKYlpVVENLbkNsNTRrRnhYemhSU2haUDhTUStncUhBT212?=
 =?utf-8?B?LytzR0Z1NjNnWkN2NE5XWXZEcXZtT2l4NzhiRm9wckhKci9CUUorNkYyQ0pG?=
 =?utf-8?B?cnIxaWt4SDZjdVpEbEhsSk9UcGd3VnR4VlJic1Nab1V3OEFpbEh5SzRucHBX?=
 =?utf-8?B?ZHU1dzdSeHRNRU4zU2MzejBNUTJoUmNPUThJV0tXVi83SWpmcW9Qak5TQjVL?=
 =?utf-8?B?L1ZuakVKVU1HbE5SQkhqc3ZXeFNwOSsyUXQzTnhkbXV0aTliekhoY2hJaHll?=
 =?utf-8?B?ZFJpbmczVzhzR0pSVms0OFZrV1VRbU1idVdWNXV3N0hjdldpTGZxNno0MlBl?=
 =?utf-8?B?NGRBZm9wK3h4V0NqVmJIaGpCTlFhZFNCbmN0OSs4U3BUTVhkTjRTek9xVFNu?=
 =?utf-8?B?dVkyS2lMenBFNERncWRDdWZvUUZ5dEh3NEtLNkpBcGFxV0RPQmRJYTRuOENh?=
 =?utf-8?B?c0VjQXE1TFVJRXFORFB2bGVBWE04ZjN3dmZNUU9tVVlEYndpMXhkMlBkdW9i?=
 =?utf-8?B?WUpPNzdxZ3M3QnQ2ODF3VTNONG4yVEZTT25rV2xCcTVCRzdPWEpMZnNpY0s0?=
 =?utf-8?Q?ORRF5TbrnIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkEwUTJmMmNINjZ4TUdPMmlnSkVTY3kybXFSR0NOcU9McE5hTXJUNklEQXlu?=
 =?utf-8?B?bFFjaDVFQXpUOXlXaXhwZFNCdFJWS2haVnpnZHkzT1EzcG5QREFnc1grNzY3?=
 =?utf-8?B?Lzl3RzgyR3BPV1dtUlUzRFF2Z2RZZVozTXZocVB0K1FwQ24wVkJUK3EzVHZD?=
 =?utf-8?B?S0wyaFAzelRDYWU1clAzckNHNlVRZnFoR1BVK1UwSllZZ2VDeUNzWVlPL3li?=
 =?utf-8?B?RzFtUHlqVXRBb2M0cmFqRVBRR2h3VmFBZ0VtV2l5SE9raDFWOElFMEVOQUMw?=
 =?utf-8?B?bGtoZGk5YjA4UUNHR0ZCallOVmY5TFNONGJ5LzQzMTlqM3gxOVowQWNqNzRZ?=
 =?utf-8?B?TEhVSDhDZm1mUHVySjc0cEZoTDhhSmFNS3kwcU1rNzFERmpPb2JxSDVtWTM2?=
 =?utf-8?B?K2Y0Yk84U2FFOFkrWjd6NUZuelFEeG9OWGI2YlNiZnM4THZkOVVkZmtWMnVm?=
 =?utf-8?B?ZVhjREhmSmsvYTlhSU5Sak1DZjUvS1luVnI1cVpYMWN5Zzk3VWM4dFp6VStL?=
 =?utf-8?B?Sktza05WSU54UktKVHd5RG9lRHFtSzhFM2xPdktET0E1emx3NEVnNndUcCtD?=
 =?utf-8?B?SXE2cUlDNXBKUlA3cTRnUWg1SkVLVWNySUZscmV2OExKaUVNQzJsdktyZXRZ?=
 =?utf-8?B?UjRXNkVXQy8xc0dtTFhjTEFUWTNMNDBWNk13S1JtUVVRYzhnaWNFVG40dENz?=
 =?utf-8?B?QXdEQUwxNlM1QkFDNGlBVk0rNTYvZjkwSnV5NWlGN2hGTnRuZDVDaEd4R1BQ?=
 =?utf-8?B?c1RSaWZOcjVlalNMd3lGbXl1dG1Rc09zWUw4Tm5YRldER0FHV2N0S3NlS2RQ?=
 =?utf-8?B?N3doUGtFT2EvUFZpdGlJd2lwSVh4a29nZXNaWkd1WERMaUxFb1R0QVRmaURo?=
 =?utf-8?B?OVJvbExXU0JSQlNZdm9taDJHV2dpNlEvaTFZU3paanhaL0xha3pIcTFRSFRV?=
 =?utf-8?B?eXdzUmFjQWJIOXRsNmdJOWk4cTJmSTJpM3doS0NUT1J5ZVJOdXE2SzVycU16?=
 =?utf-8?B?MUlyMXJYWGUrdDY2QjB4SGdEcnZ2YlYzMmUrZmFUbzNtTEZDeGJVTkh5cFkz?=
 =?utf-8?B?RTZ3RUF0a0oyWEhob05ZSXliaFp5MDhZZHFGcWZQYlhzWDNYV2s2ZTFBYjQ3?=
 =?utf-8?B?clhYRmFHeUxSYjhTQjdSNnMwWGF6bkNlQzRSTDVZUEk1c2VLNUdBOXQxNGNW?=
 =?utf-8?B?OXNST09qUGJSdFhLemtURWNvL09ZMTNyZ3FCQTVBK3BkQ1A2MXBkK2t1aXg1?=
 =?utf-8?B?dWRQa3VuRU0rNEtZdWRTcnMrSkpycXk0RTJnUjNiTmVJdWlzU2xWbGxLWHI1?=
 =?utf-8?B?WUd3UytVem43elkzUURWTWlzOWpkaTNvbnhPaVBnK0Y2c1IyVWNBajJndjNk?=
 =?utf-8?B?L2lHTGVCc1llOEltK3hKRGE2OUl1bWg5QnVEdXpxUFNENEVvRVVPUFZJMkov?=
 =?utf-8?B?eXQ2WXZsbE9jT0k3Z3FnUEJpaHFsOVVnUk93Smc2akdQQjNqMlpYNWNiOWZs?=
 =?utf-8?B?SzJ1SmR2SkpJdE5BeVdpU2o1cEt1azRJYUtqenlXVGxyTGZKNEFoRm9WVTVB?=
 =?utf-8?B?dElDUmM1MXVMYlAyMWZUWFF0Ly93VnNIOS9NaXhQNXQ4M1VsME9temQ5Q2pB?=
 =?utf-8?B?TkxMd0tJVDluQmRBS1QrM3J5Zkh4Q3RDWlk5Vkk2dk14ZS94RDFiT21QWmdN?=
 =?utf-8?B?aVdnNmc1WXBBRk5STm04WFAvYzZmeURWQ0VqTnB4Ym1DQ2hMMlBYNDFkUVhh?=
 =?utf-8?B?TGE5ckhzVXlXbllGRWtzV3RYL0EvSXBCT3RsalkybEw0QTdGK2oxYlZ3eGt0?=
 =?utf-8?B?aElyaDliS3czTmxlOGprejFoQjNSbXZCcWs4d3p2d1pyWXgwUXVtN2VoclFM?=
 =?utf-8?B?V0hlbjlxcUphY0Erc2pFS1Y3MCtERTFMTzc1L00yOVNXNzR2RDFXK2pJU1NV?=
 =?utf-8?B?MS9rWDlNNmtCOXNEVnRKWUQ4VHlvUzZpY0h1NEltMkY0SHF6bUZiRjgwYXF1?=
 =?utf-8?B?MG1OMWVYOEZrRWlvcDdIc0FzK2JtQ0VIWGFMYWpJQWhJc25OU1VteHdMMVVB?=
 =?utf-8?B?ZENjcDZOTHA0dkVNQmlLS3NtbitNTnpJZHZJdnpjb0NwczhEZTJwbkRpV2Jl?=
 =?utf-8?Q?aLhMF+gmTOyNfcXKVYluvg79r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4773f9-85e8-488f-f107-08dd8d76d0ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:52:41.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EvSVArhNoxj8qTqRcpfIeMm7QzEGPwzC2tcpRmpMsCVvccbDvHqFgYO58blWlyGAXurv+MpDe/hn9VGYZEZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8163
X-OriginatorOrg: intel.com

Hi Venkat,

On 5/7/2025 10:32 PM, Venkat Rao Bagalkote wrote:
> Hello Chenyu,
> 
> 
> On 07/05/25 4:44 pm, Chen Yu wrote:
>> Introducing the task migration and swap statistics in the following 
>> places:
>> /sys/fs/cgroup/{GROUP}/memory.stat
>> /proc/{PID}/sched
>> /proc/vmstat
>>
>> These statistics facilitate a rapid evaluation of the performance and 
>> resource
>> utilization of the target workload.
>>
>> Patch 1 is a fix from Libo to avoid task swapping for kernel threads,
>> because Numa balance only cares about the user pages via VMA.
>>
>> Patch 2 is the major change to expose the statistics of task migration 
>> and
>> swapping in corresponding files.
>>
>> The reason to fold patch 1 and patch 2 into 1 patch set is that patch 
>> 1 is
>> necessary for patch 2 to avoid accessing a NULL mm_struct from a kernel
>> thread, which causes NULL pointer exception.
>>
>> The Tested-by and Acked-by tags are preserved, because these tags are 
>> provided
>> in version 1 which has the p->mm check.
> 
> I see below tags from version 1 are missing. I think, its contridicting 
> to the above line. Please correct me, If I am wrong.
> 
> 
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 

These tags are in the patch 2/2, because Madadi and Prateek mainly
tested patch 2/2.

> 
> For some reason, I am not able to apply this patch on top of 
> next-20250506. I see patch002 fails to apply. Please find the errors below.
> 

next-20250507 should be OK(I just checked on top of commit 08710e696081).
next-20250506 might still have the old patch 2/2, and next-20250507 has
reverted it.

thanks,
Chenyu

