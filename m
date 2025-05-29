Return-Path: <cgroups+bounces-8388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C01AC77B4
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 07:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9650A2572C
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C735252299;
	Thu, 29 May 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtDGRn12"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E494685;
	Thu, 29 May 2025 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496803; cv=fail; b=pvTzfOBvNmR/UrQLG5hS0QNnRBp5/ZoeQuECxE45FTauEM+lUfPeh9yzYhe2r3XQLP4rV48xIdcfKfcHs7jmBBlK4prq+K46Nw/GwXZxNK74x+Nv3reUgUqDHxxBAv78TQlxoJJtEixo8tRklVQ+PUHUSCHsWYtWFrnnUh0Svv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496803; c=relaxed/simple;
	bh=bifcJIHQ16y39kI1Jvexb0aKdgIwWFFQ0nNqi5c4iN8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXzaa4tI1IGIBSie+HSPmSjFOc9IOFWa+3Cf+thx1/NpX7i3uSFj7KlcePkt54CmWq1ZnhSnCaCVyJnaGQE8HaWkEjtD4f9OlS+ueTxRrLnAUfdUu3/D2NxwuBjFNEKPNgJvPtjpgwNthJX8j0KcHRC11eppidYZjjYi81fSfcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtDGRn12; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748496802; x=1780032802;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bifcJIHQ16y39kI1Jvexb0aKdgIwWFFQ0nNqi5c4iN8=;
  b=NtDGRn12NIqD/jsPc5s1XYbKEVoXx7bGSbfJ9/4X4iSWqUqmJ8dq+vOz
   fVBh6ot/VEsuP/fRvYeC5Wku7Ud3wLa3uBJP5TI3Vm6IHSKoT3cOH+cf+
   1xAq/muRK6stDQtySE7jLxow5J7J1WHqc1qW9E9ucwfIotay6sLYtWN5/
   U+JsEv0hY0pssE1j2mlv87t/isgHy5R4GRbZfQytAQGoUsMxGOQ8ctymK
   Y4jDGTXOnIO80EigVhGyfrRF66fMmxjD13dqCtRyOmjV7eoXsus59AqZv
   1gH+s53l+mW3DQqjJ0Xx0aZ0/XogDG4zl+oxZU4t9+Y7k5iLqG1B0nfub
   g==;
X-CSE-ConnectionGUID: 5Duux8jfR864BKCse7WbCQ==
X-CSE-MsgGUID: CnGpJoSNTiaIjlDVxg2IOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68093766"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="68093766"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:33:19 -0700
X-CSE-ConnectionGUID: NHDi6dPSTRyuWwdT143IqA==
X-CSE-MsgGUID: zeJ97elfQ76z4mA04XmJiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="174459617"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:33:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 22:33:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 22:33:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 22:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/C9k4HdYiqzAozfzwlFBbyLjDxSqeqFy4mREgejf1ND7UtSMmllwhhk74sBSlvJfpe6ljJbGd6sYx86tJVAB8F44IGC3EzA4CerXWWni70cyUEZhh8JxAK/VZWW4LvFO9H/U3H7aGrAElMelmHMLP+B+WSRqIEOQM/ATJZEqzManXNMbVsUAgEkq1hG2PsKI1fcO/OUueIYY+lX0Q0hWtpV5HWLtH3GREgE9cevk3nsQeIUdMGyTxBrX383o/Kq074dEP0MGmRhKA8twXh3ZogW3etc/nruVDhfO9Ajw991S8YLz7gsLzOT2SfSzQk2xTLlyJe6czPJ5gWvR9J4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFy9sxZaRnv2ljUA1C4B5c5cyCsMcAghgaQuS66plL4=;
 b=t4BHNGozp8Sbok1h4HlLSgoeAHt/MtmUZ5SX+cyG16swgYEIqgGJI5vJBiXs48KrqPorZ8MRLsxR7visP6bK+cD8V/dKMPIcCvjlsD/n4+dEjyuSJb8FGARNCra7RwOPUYbHBl8NZ5hJop35zEXyDAG5ldpNpFv34fBVpkcZrn9Npar9pmd4DCOgKeZETh9ROePso8yPj5tTDb2efJHyimKtqNxNfKeLMdTEzpTSoEy2MlME8TYWbqHY7YT6zpNkDTVlJp8ySTEatMZKujqIdoMpXsXLmg5V970gn8HxZFqyiPIb0njlsrSSQ9QYP7E37v5r02NOC6LSFjMXfrdRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.30; Thu, 29 May 2025 05:33:02 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8722.027; Thu, 29 May 2025
 05:33:02 +0000
Message-ID: <2b48d217-36e0-4919-b89d-fc0f7a48b89d@intel.com>
Date: Thu, 29 May 2025 13:32:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] sched/numa: add statistics of numa balance task
 migration
To: Andrew Morton <akpm@linux-foundation.org>
CC: <peterz@infradead.org>, <mkoutny@suse.com>, <shakeel.butt@linux.dev>,
	<mingo@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>, <corbet@lwn.net>,
	<mgorman@suse.de>, <mhocko@kernel.org>, <muchun.song@linux.dev>,
	<roman.gushchin@linux.dev>, <tim.c.chen@intel.com>, <aubrey.li@intel.com>,
	<libo.chen@oracle.com>, <kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>,
	<venkat88@linux.ibm.com>, <ayushjai@amd.com>, <cgroups@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <yu.chen.surf@foxmail.com>
References: <cover.1748493462.git.yu.c.chen@intel.com>
 <20250528222637.38b3a12b6b01d2e499afcb7d@linux-foundation.org>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250528222637.38b3a12b6b01d2e499afcb7d@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B6.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: faa6d917-1638-458e-8898-08dd9e72476a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzllQi9RenBlWU5WamR3V0txazNQakFsL0I0UGJYRGdhNFQ0NTcvdnppMUF4?=
 =?utf-8?B?T2VNY3RMZkMvMUtFOFpMTmVRRDd2Y3VadmRvam5UMEdZNnRxREVQdzRLWmky?=
 =?utf-8?B?aWJBY2w5R0lKM0F6UW5XOXNrdjBacWpmUDJXbkhucnRhYWdyZ2tXcVJhQisv?=
 =?utf-8?B?bkM0eUZZVURmM2VTQnhZblBXMis1dU5HRHRGc3ozbFpoaWtRN2dFdUx2ODRo?=
 =?utf-8?B?NUgwanUzaExkTGppdVlHZG5BZmF6d1hpdmlDQzdQajdWYjMxYVplQm1nODJQ?=
 =?utf-8?B?OVVhTGZzYmdMUU9QWjNEbVVOZ1FPMHM4UElaODAvNXUzSlhqWnJhRXk0M3E5?=
 =?utf-8?B?VTBTMGVqYTFuK2I2YUkvcE9tWU1pTlZEYnhFb0lnRkZJWW4zY3IyOVlkWlhP?=
 =?utf-8?B?dEo4ZzhXSHJvc0J3MUpMTGprMDEyTjkwQXVhK1N3UlViM0RyT1daVnlmQXJZ?=
 =?utf-8?B?VkVwR2psUDVrMHArTWhZMU5VZ05FMnZoNDRiMDVjdjlsVktxK2ZGaEM5aHd3?=
 =?utf-8?B?NGhiWUs5QVZuSVJyM25RckVXV1ZVU2p3VEgxWWl4MHhIVEJ3N0ZmUWVLV3Bq?=
 =?utf-8?B?ZVBDNU8yZm5LM3ZoMFk1OVhBWjAwNWhMTjdyLzNQYUZTN2l4S2JuV0YxMmFr?=
 =?utf-8?B?RW12S0JhZ2NlVmY0QWxiOG1WZldqaW1Rby9DSkViV3BQcXp5MzZCSzFleWd3?=
 =?utf-8?B?bFA3aHpPd3pzWlpDWUJUcUg2RkFPMjgyc1BTSHhxaUl4MHpNTVZreG9Fa3lN?=
 =?utf-8?B?R0IwcmMwVDd6SE9QTzFkQUNyTXBQV1JyWlJhYTcyT0hNRDVPMDExS3diTmt2?=
 =?utf-8?B?TzV4eHVMZm55eHZ3MEFoWWJWVGIyMFJ1ZzlSV0VqQlFzcEV1OVByTDRzV1J4?=
 =?utf-8?B?WG9WYm10YTU1eW40NjNkVTlTbGlVTGppUDhvam9uYWdxWnRyQTJjTks1Q3Jy?=
 =?utf-8?B?bmxQWjFqQjFtMkkrVzBGZWxieTBBQUp2T2RvTDVQQTQyU3JkUitEMFMvOUpr?=
 =?utf-8?B?YW1JYW5pQkZXL1BCZWlEaW8wTEFIc2J3d0pEeEhxT3ZkTWRza2U1bG56U3po?=
 =?utf-8?B?N1F3KzZyam1ZTWIzRElDV2EzNUFRNW9wTGoxRVA2dWlnU2d1enlDR1hZQ0JP?=
 =?utf-8?B?aUl2QWNpOVlxK29XQzNBbEIva05iVWtQbFhVSU16cFd5RU1SQkRwOG9jWW9y?=
 =?utf-8?B?SXhDeHl2QXVLTnAxNGhvLy85cW5XS3F0d0N4NXR2RG1oblNybWt1QndRNGFV?=
 =?utf-8?B?TEtjdE5CN2U5UG5vaWJkblRxQ05oV0plRGVPQkllZENtM2lkYVdLNU9jWXZz?=
 =?utf-8?B?QnRhSmZUeHZXUmhvMUNqYjgxa0x3KzhDQitRcWZtSHRudXltVTRWa0tXaXBD?=
 =?utf-8?B?RCt1MlZmTWlITWtJb3JGVkhJR2Q2eGV4amhrdkpsN2R2a2hJVVJ1VWpCRHhE?=
 =?utf-8?B?dGNuQWZUQVdWbUF6Qm1oS0FGZUlkM05mTlcxU1podkZMTXBELzhDK0gzaGdm?=
 =?utf-8?B?N2FvbGprZFBnbHczMHNtbXE1YlhPWlZnZkwzeHZjSGJXMSs4eEw3TzZqbVBR?=
 =?utf-8?B?QmgyK1AwNEIvYWJZcjlEV0hRUHR4YkdZdHNTR2VpZkhkMkhuUmh2U0FKU3Bh?=
 =?utf-8?B?MVk5N1c0VzZYVDlRdDBCOCtkenRZUU5IT3o3MDVXWGt3RFVkK3ZvdlM2czdN?=
 =?utf-8?B?dENHaDhnZmo0UHFHUlJ1VHl3NXU3eXZBdmNnUzUzWk5XVUZnTEV2dUFRc2R6?=
 =?utf-8?B?YzBmcGVVZ3lUbHRUMlVCZFlKaldQbXZFbkpsK05BMlhBdlRpMTRDd082cnZz?=
 =?utf-8?B?ZUgrVXVwMjhqcUdmei9wN09Kb1Rjc0RUVDI1ZzdpSjJJWmxkVU5Qa2dwbHRV?=
 =?utf-8?B?N0pFbDFleEtTd3U4SEY5azFpUFZzOG5xRnpWOVJ0QzlBaDlXMGtpYS9pNmxT?=
 =?utf-8?Q?hLuWGGvDzJ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmptK1FZeUEvSkU0T21hOWJLNExRT3NXcnZTNGhLNWxPNnIvbzJCMlZPSVRv?=
 =?utf-8?B?a1NVa25oMFM4amFKTlVadWFpb1JvYWZNZzA1TWhFWUtMWmtqd0MzS3cxSnkw?=
 =?utf-8?B?alNDZVNXTzNLN1VYemZrdXBDRkk2cEowRXZ2KzFoMlVzeGI3c2tHcjRUak1S?=
 =?utf-8?B?YmV2MnRYdFpsa3VneTVuTFVNK3A0cjBXOUcxck9Ba3ZlRlpsc1ViQ2FucnlF?=
 =?utf-8?B?c2VCSytiYThQU0c3dkhmeFJOTWxLTlhsdGxqN3VoeXN5UFdVY1FrYjVicGUx?=
 =?utf-8?B?VnF6MmNCRitwcUwvSUZ6cGFORDdpY0hCMWtZQ0EvbVRjeUlRbTlRZXhGVlBT?=
 =?utf-8?B?N2FNcUhBaWcwU25lRDZSeitxSEVkL2loYm5VcnA5U1hubGtHNUVRNDVaUldF?=
 =?utf-8?B?azQza2ZLZ0t6M1hMME1SR0dvS09DM0J6UXczSWZOQlRCN3dxL2huRldTUFky?=
 =?utf-8?B?TEw3VXhPMDdaQXF4TVlrSldNUXJKWFJFVnVzYnMzWnNTK3BGUmIxcU05MjVD?=
 =?utf-8?B?SitqREU1VTlGMUhTdy9pNUx4ZG5mMlZCQVB5aE4yUUxmMkxtU2YrZk9LMEEw?=
 =?utf-8?B?SVVvRzBDZURtM3FZRDlJY2RKcGhvb0RwOFZMR2Jqd0JIQkpuYVNKK1lKTGZu?=
 =?utf-8?B?V3VodHFwZklwM3JnemErRVpxY2dRTXhSU3RVMHpjZmpDc25ObXJTcHhPaHdE?=
 =?utf-8?B?aE82RjFFLytsU0V1RjZWNXV0U2dFb01EME11R3VvR0dzV0laZ05DSXBRUVhG?=
 =?utf-8?B?MDRhSjNXbXlHSHd5WU96RGgzMFVPcHNEOFNRTS96YjM0MlFiNzlhdTZvY0hu?=
 =?utf-8?B?cVpRQjVGNU80VUhnVkJmbVZsUWpFNkR4RFV3MTZNM1FNWmJOUytoR0hhWkpD?=
 =?utf-8?B?NzZQMUlTYzdWYmJ3MUpjSU1uaWhwOEMzcEttemtvYyt1VXY5NU5LQUlkSFQv?=
 =?utf-8?B?RmhlanJxU2ZwZXdYS09WZ2hUSE1kenZjd05Wb0VPTnZhTDhsVGtnUHc0aEU0?=
 =?utf-8?B?aHBsSnZWTzRZUzU4SG1xOW5Kckg2b0p2WFVEUXFjSlNsTFlORDZTdnV5ZEtt?=
 =?utf-8?B?WnhsNFNZTjN6UHZqVk1tYm4vTVBsUDJheVRwcm4vQmw4Sko1NzZ4QTJGTU1a?=
 =?utf-8?B?aW9jVEZTdHNPZENPQmtsQzB5d1J6Nmk1c01Ec3hybnZnTTlraGR5cmQ4WFQx?=
 =?utf-8?B?aDRhTE03a1Q4dHMrTW1SYlZSREtvMnZRS2ZoY3BDcVpNSk4yNmJrcTlYa09v?=
 =?utf-8?B?dllxeC9oeVdFNzF0aWtMTVNqQUJLTlZYY2owYTIyL3UzVDIzU21wOFFVYWRk?=
 =?utf-8?B?S1NsSUpWUkxOVFZTT0Z0elZtd1pNVHAvSE14enFzMys1NGdqcjg1M3FZRi9v?=
 =?utf-8?B?T2RrODg2YU0yOWo2SURpdXJoSnhqY0VmdlJNbFVSS2hPNXlUbUpnQ2h2bzdU?=
 =?utf-8?B?Z0hjTTJxY3gwMDlHbjExQWIzbEZVYkk4ZjdyVDFtMndCdWlKWkdaZk03QkR1?=
 =?utf-8?B?eE5WTm1IcGFUWlhMbWVkUittclpXd1lBMXRlQmdvMUtib2s1SmIxamNiVTFH?=
 =?utf-8?B?VUVyNTVsTWNkWmNMMGdRR2dIcmtDaHZxeWQ0UjRPMmN1UXdMd1Z6KzJtQWw3?=
 =?utf-8?B?UzBUTmNGeVAwK05tTDRxWTJtL1JKajhaMnVGQVZ2VEMwMmZXTFptcGZ4OGsr?=
 =?utf-8?B?SVNWcUVCSzJKV1dpODJCVEFUcHZqZGdtVmU5Wk9VMm15SzJNUWgvR3RRSUNy?=
 =?utf-8?B?N2pBUzRHKzdmbEtIa1g4cGZ5WjVkOXhKOHFYT3BqclBQZ0pPVHpGQS9uU2Za?=
 =?utf-8?B?UWxxUWxCMk50T205ZG12d3kwbnYzL3M4d2V2K1owdGV0cXNEcm1VQ2dFMFZm?=
 =?utf-8?B?eUtLdVUrWmc5RUFiWFR4V2Y3TUJRbEs1aS8yd2ZsUkJtb0laRFRYOHhRK05H?=
 =?utf-8?B?QWpoYlZJdTA2NFFwc3E2eDVnNGdiaW4xM3ArUzBoV21LelNhZCtVeDNzYnRy?=
 =?utf-8?B?cTVKYkI4RzhVQlI0U1FISEgxUEYvRkRYQjZEZGMwRUVCemFFS1BPQktDbmR4?=
 =?utf-8?B?SEVoemVnNWc5bVJkazlwTlhZQWcvM1BVU3dKVFBHVERKVVZhL2Z4K012S0sz?=
 =?utf-8?Q?ev5uWdLEk8+D0oxZRTieItJYG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faa6d917-1638-458e-8898-08dd9e72476a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:33:02.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRgDX1w81IDE0ewNVDAJMzUTME/Q3cLtm2nlZFGE0NBWiqtXKPAMASjmt1dRR0WlO9oH+divBmPHoQOa0NsEow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
X-OriginatorOrg: intel.com

On 5/29/2025 1:26 PM, Andrew Morton wrote:
> On Thu, 29 May 2025 12:53:36 +0800 Chen Yu <yu.c.chen@intel.com> wrote:
> 
>> Introducing the task migration and swap statistics in the following places:
>> /sys/fs/cgroup/{GROUP}/memory.stat
>> /proc/{PID}/sched
>> /proc/vmstat
>>
>> These statistics facilitate a rapid evaluation of the performance and resource
>> utilization of the target workload.
> 
> OK, thanks, I confirmed that there were no code changes since v5 and I
> updated the changelogs in place.
> 
> I'll aim to include this series in the second mm.git->Linus pull
> request next week, unless someone prevents me.

OK, thanks Andrew.

best,
Chenyu

