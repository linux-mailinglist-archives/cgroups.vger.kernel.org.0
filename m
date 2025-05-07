Return-Path: <cgroups+bounces-8065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67BFAADD7A
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 13:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30E31B66E6E
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB1233144;
	Wed,  7 May 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBN/O1kD"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46E1553AA;
	Wed,  7 May 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617807; cv=fail; b=CbimV+mAaTzp2dArCmWof4uXvftOydaGC/ajoq+W7pBVde7s5DExM4A6bDfoMiycgqCKoIKU4pLZUQe2oWlLg18olOZwYSanvmk4giNSSTjtHe0DQRuFss2wvNQV+Hq8i2yu3i9l6JdStHp+Saat4eYBATeJcxrxFWXqZvohX84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617807; c=relaxed/simple;
	bh=u6bqGm7ppv5dlGBRAqw1VpxrWC6ADGHv6ys9pMaKBZ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ImR76wiegt0Z08VM4bOp+HxrASXGidRShqbTn3oHPDYmtQHMy4fHKcJbH4F2zNMotp0kZhekKtGOX1HJMKql6FHX4EjCS++mNMaBSWHkpg3qyOwu3EpyqidLcmJaD9TAhXANsp6PacCGiMe9B5w6Wy4zY7NpaJd0xNZL9fKcbO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBN/O1kD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746617806; x=1778153806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u6bqGm7ppv5dlGBRAqw1VpxrWC6ADGHv6ys9pMaKBZ0=;
  b=cBN/O1kDjGCHLy5vow3rdinPhqDe6bUzoYmtY5hW/2ZM9uFdgm3gRqDf
   9z0tA7W15vCZqpSvfnb4Xxa7xZqolJ1O7RFHBFUv+wqgvimdtliN/RPKs
   ni/gLwAVk5/bExeypYSVzbkDZPFerFNDhjRuPmD6506wad7/EWDhgyTzv
   pLd6Yr2LjXas/dGaUyMH2r7tIDO2jcZCTTv3acUNl5GidrKasyursPeLn
   QVJXeiq2LMnVCBYBJ6F8Im0BO0wjPGaljE0g8LDvDO6TI/3uNzjcJkqFc
   3lTWf5/oLzjA50hS7UcaZxPBDDxN28F4QEixW7ncXPR3zvWHCP9IGWDeg
   w==;
X-CSE-ConnectionGUID: 06v7o8AtSB+1qPKVf9wTWQ==
X-CSE-MsgGUID: WAE5peyhS8CwrnUN/kAwyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48456221"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48456221"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:36:44 -0700
X-CSE-ConnectionGUID: J1ZS2JKhQv6Aa43jQ57XtA==
X-CSE-MsgGUID: afa+3Bk5TCmVhVMGRWMfyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135948738"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:36:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 04:36:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 04:36:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 04:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgHf/ZoyqNKJR7gwtPStDiiSu252R46nnVW+9w/GpG85ZvH9kGfdRAtIRvcSE/gpCPv/+HoV6eNnCNQtmvJ8O07aZQIisHxdkVZUTh30waCK3/3ZiZZIGq3Uat4hm3mmwQ7lodzRuNyrcS+zi0nJQTL3QQuLx1+clk3/XSoxjXqSPwhRSDRtxEs6iRt0FVBTjK2n1pmTbNMMvM40WHIZfRsrKkz/QbM/aICXvNFy4y7siYias7oTL00m1ZfUaf7dHFOa5QkxTjf6ysAdficaWc+hbcgZcRxbGZ/6fxvKpUgnWyuUMFBmnLTzw8TAA6hA9n9GPuZGA9jDmTJAaECZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjPSwbLZEwjfh+1x4XEAL6yaSRcnyTChij0v0enUCIo=;
 b=bU1v/kXmGiufC9Bm/a46nWtHAKeXAlENooSwC0TwqBNjxYN5vcOkSHmgrYEDBogBjNlxsn3kxS+mc3oApR7UWS8zjsr4wcHOz0pavkc8pPEVqRtcL6pKwbwzpVI8VqKbJ6S6tdybq37AhJlFeIYI0Z0AhQzKQ7qvirIotG1xyMPd3Qdf3Uzn2KDvcogUsRbUl7LoaZ6O65Hte4DoTyTXkOlj8gKLE7P/Mg4mLwyTZZ1Wdvm9SwQkYsb5wtOxynOoERh8iuiqmqkXYrfShWnf+DuOb7HA8Ro1vSfPvlTxMa1d1awhjdfTllA4BrSFDuqN42P8nnny6p4HhGNSre/SPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 11:36:33 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 11:36:33 +0000
Message-ID: <67dac8ac-95d3-46fe-a384-7d56a9daac27@intel.com>
Date: Wed, 7 May 2025 19:36:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
CC: Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Mel Gorman
	<mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Michal Koutny
	<mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim
 C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Libo Chen
	<libo.chen@oracle.com>, <cgroups@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, <Neeraj.Upadhyay@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, "Jain, Ayush" <ayushjai@amd.com>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
 <e8916a76-61d3-4fb5-81ac-4597180f9078@linux.ibm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <e8916a76-61d3-4fb5-81ac-4597180f9078@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 16541be3-f78c-44c7-514f-08dd8d5b6b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlRvSGY1RElocGt3UEZtWnRyZERnVTdTaCtCNkRXYlVzSmxEbHlkeFRaR0Z5?=
 =?utf-8?B?YTBDeHNYTVNMcll3ekhZbzJGbStTU2Q5b25Nc1FhWVJFWG1RU3ZtQnY0TVZi?=
 =?utf-8?B?NERnQjdTVDFVT0haczUyVk1DZTBCZmxjTG9pWjEyZGw2OUNOSmU4V1ZmRGor?=
 =?utf-8?B?VW5rcTFlRWpmcTEyM204dDFtM3A3aXhQK3dvMnl6WWVHaUQrT25XQ3N0WSt5?=
 =?utf-8?B?THNRMURBdndocmxkelpLZk5NWjkvTEdqR0Vvc3E4aFFhd21xRW1WV0hQVlRH?=
 =?utf-8?B?djEraGp0b2JsdXBaUU5xNUhIV0VJSWx2cmUvSzFuOWpMZmdBc2lyZkdKVExp?=
 =?utf-8?B?dTN4MW1GRnVKNmhTaXFWQ3VYVXRwSVV0QW5WRGsybXZGVGJSSUkrR2xmeGw5?=
 =?utf-8?B?N1NlZ3F3RmQ0YWFSZDFQWXZxWnc5aUdHQzBoQ0FLSElDRDR4SDBPTmRHcEIx?=
 =?utf-8?B?NmV2ak12eFN4YWMybnZ5TWFyNVBtQ0V6M1dIMHkwcEwrWWJSVnJaY3ZjU1g1?=
 =?utf-8?B?c3gzb1F1T2RaTTNnK0pSMU1iL296aDlBb3hCdlByOXpkZEltcVg3d01ObUc2?=
 =?utf-8?B?Zm9rZUU1eTVhU1ZoSUFuUkJ6TS9jc21qMnoyZmx2NE9zbVJkbEVEL29UTm5X?=
 =?utf-8?B?ZVF5ajJRckJGVmY4eGZnVDNjbUpCVHZhUDhETzhoOWdSdGtpbFJYdVJ5bHhY?=
 =?utf-8?B?V3pWT0hkS1Z0RHZhYUlIRVJVby9JTmFoNDBySWhXVW9mZjg2OFBGZFc5RDZ6?=
 =?utf-8?B?MGZiSnh1VjJKVWtJcm1INFk0WDk2eHhHMTkvakc4T054Mi9OSWV0TXE2aktu?=
 =?utf-8?B?OERhNWhXc1l0QnE0OU5lTXF2S1V2aHhtSytmdVRrYUZTM1RDajRGS2cvclk4?=
 =?utf-8?B?NHhFU3h3OVNIVWdwUHBEd29xbDAydXhnWTJoVy9FbTRCVnBDNFY3bG5rSysy?=
 =?utf-8?B?SEw1Um9renROM1JaeFQwWDBHZmQ2K2pwelZDczVvWGpNdUpITTdLb1JyQk5m?=
 =?utf-8?B?dVhqVG5hSTliWnR6OXFSL0cwVzFvWk82NHlTUndhQkdIQXloSEVrRTRWald4?=
 =?utf-8?B?ekFrQjhtOHdQVjVVUkVpVXR1RVQvYlA4REpEN0MrdGtVV1lteHZKNXNGZFo5?=
 =?utf-8?B?QkFkYmx2L2tWdUFURStOZHhiWnFjclR3T2JtTXpORFdRamUxakk0MUsrMVN5?=
 =?utf-8?B?MTdXUUJzOGFGVkRkMCtKMGQrQ1lTMlVxL293OWptOWlwTzBFQ1NFRlkxV0FZ?=
 =?utf-8?B?Mm5vTGpUK3V3SlhDS3ZNdnpXRGN5bkJZSGRyT0x2NnJGZ3djR2VwTk4yeTdt?=
 =?utf-8?B?QUhGM0RjZTlNeWhtTGh6MEZPTlNVbndMTXczb01DQ2dyb2NwOFl6My9lSHI4?=
 =?utf-8?B?ZlNFOFVZQWVGY2s5ZnBiKzMwUHZtMWxHMFdjM1JncXc2RmFpRTV6blBsUnFw?=
 =?utf-8?B?U29rWTBWbHYwVTU2R1dWYS96cGsrdGROTEU0OWFLejNyWVRGNUtpcm10amZZ?=
 =?utf-8?B?L2IvQkhQY3ZUQ00yeGJJMVlmeExiKy94NHEwUXE5RityUzMrS2xFMndtZFN4?=
 =?utf-8?B?K3l6Y0duY1MvRUhJRWdtaktiRUdyMWlwOGU2Ymp0ay9maHNkbHY2VFBrOFM5?=
 =?utf-8?B?YlFvL2ZLUlN1UmJDV2h0Q2U3dlZQbVdyZml5UHRyRVJ1TTBtVlg4YzFycDVn?=
 =?utf-8?B?QjNTSUF0YkxoZm1hcm1QdEVMeFFjQ1MwY25rYXEyVGpBSjdxZHZ6ZWZHWE94?=
 =?utf-8?B?NlhVV0NWN0R3dWJuVXBvMzMyZzNNV0ZmY2Z0K1RPemFoKzNjazZPeFlKS0dq?=
 =?utf-8?B?Qy9UREVrb25jT21SWUlEMFhHMEx0WktCR3NxSStuWkdhNVZHWnZ0UmpoUU16?=
 =?utf-8?Q?uLJsuhyo0EPEV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUt4S0pDTThtK0ZEbVFhMmxaajBJbUd0d201ZmducHM4aW56Z21WcllVelpt?=
 =?utf-8?B?dXIzb0dzQUtFc2xCRW90UFlGVmdKU0hDS28yKythR3VUMTNhREtyOWxkd2E5?=
 =?utf-8?B?TEN3aWVJYkJMMk9PNUkvbHpMMlJjTTB0MTBrTFBzOGtObENDdkx0Qms0THdw?=
 =?utf-8?B?QUlXeDNqMjlBS0RieExOTWU4N3VZM2tpSWorUzdvRE5kWWgxUHYxcWdISTNn?=
 =?utf-8?B?SnYvU2hubSs2N2l2bmJreVo3U3BleWk5dGRVM2dDREhISVNFS2VjVE9TUlFU?=
 =?utf-8?B?YXYzM0duZVQ4Nm5xcTk5Mml6VVl2bnVlZ1laR1lqMHVrbzEzeWlSMzBzSzZv?=
 =?utf-8?B?S3VnMlZEM0EvbUVwUVcxcXJQK1RZdVZYVllyWjRWV3NxN2oxZHlNajRnaHFF?=
 =?utf-8?B?VFFqdXJnTDF4bGZJZDFHenliUlRyKzZsUFJ4OTZHVGxjaU8yMm44QWNLQ2ha?=
 =?utf-8?B?Q2MwS1FORGl6L3JrT044Skw1UmJmd3M4NEpWL0RaSGJoRUU1Nkp3STFDaU9K?=
 =?utf-8?B?SXFjb2ZmU0MwTFg0RXp4M1g1RlBoNEsvcENwNmp1TXh4Ym5CdUZkOGo0cTBw?=
 =?utf-8?B?VGxwbVpWRDZZV015TTMxSUlQcUlLK09mREw0OEZzTnBJWThiYmJubHl2VWxm?=
 =?utf-8?B?ZHFNeFVsMUJFTjhDdFRSMlM0SVZLYmlYYVd5QlJuaE9tckdPdTk1U0h5Sy9n?=
 =?utf-8?B?Vm5UN1lKUytqR2FMaHg0WW41NytKZGY4dXFGSlNlSzZKTUZLU0pDVHUvNE41?=
 =?utf-8?B?TllUN3M4K2MrczIwNjhLeHFUZHBicUwzRXFWZnBxZEJPTVZLTnJpK0pwdGZ3?=
 =?utf-8?B?TnRrUnpFL2dHZzZyY3U4Ny9uRlY0Z0F4U0JVQlkwUXphejdtbkhDWlRjQURJ?=
 =?utf-8?B?R1ZMdFRta2xFbzFiaStVR2IxTnA1K2VjNitvWjNaV2FENTNPODVZbGhGVTg0?=
 =?utf-8?B?di96dGVrZytmY1JlSVU2aTl4VDk0MkN0YXhEMFEwb0dWL0l6bWppVkROTStv?=
 =?utf-8?B?RERxOC9ZaHYwMWJ3b1Y3T1prZ24vNkgxdmtZWWV5WlU2Z0dwdUgwM1R6MUt0?=
 =?utf-8?B?QWxlRzBnQ0huSzMrOEdNanplRGZkdWlKSG5NbFh1dG1xOTUzdmZBYTg3SDFu?=
 =?utf-8?B?VXIvUm1iSFY2YUpjelN0bk5RWTZpRk5wUFUrZndxTmNtd0JNT2lENmJPeXkz?=
 =?utf-8?B?bTZlWWhWYWJTMDRScW5CR2tSQThBSTFRNmJ1UVJDeTM4ZUtweG04a0pFWEs4?=
 =?utf-8?B?TVBNUGRXck1lUG5LeDNJS0RsVklUZXd6bXNkNHpyWi9mS0U5ZGR4aitQaDEy?=
 =?utf-8?B?N204WGl1amM1TDlWWDJ4a0NYQk9lL2hpekhvNktLUXpsSnp5T0EvZm5adGNU?=
 =?utf-8?B?YnFvOEc4ZTlqSDllT0l1Ukx1REo2Q1hoTS8rM1NIeW96VXIrSE9tSFoyOXU0?=
 =?utf-8?B?WXZCV3JOdENzZ0VIb2s5bHhwMlluQ0pMZGFQcUtLcmpNMEt4Wlk3MzFuZEQw?=
 =?utf-8?B?Zm1GNG1SSHE0bG1mdGNlL0dPNjQ3ZzdqWXJxVHV2UkFCaXdOeEx5WGZFUHVw?=
 =?utf-8?B?TmtwYndCT1pBSnlhWWh4Zko2MEh6aStKcW10aVRubDM0ano0UUJOWFRob1U1?=
 =?utf-8?B?TEs3WWEraHpkT29lTWtIRXpMOW5SUUhVbXpPTTJVWk5nS3I1WlArY1JNUnpo?=
 =?utf-8?B?RElKZWRhZjJNNXpCbkpUckZVdHlZeGZ0cEJSakpuVlhGQzZEbDBicVBmNFRv?=
 =?utf-8?B?aThkYmQ2cUhwN1R4NGFVcVAwNGVIYUQwQlY1RGlGUGpuZ0RJVXZlUHBMZHZX?=
 =?utf-8?B?TkN4SGFDMC9uU3l0bmVpR1ZMbGZkeTZoM0xpckFraitaTmduL3ZnRDZSY3NK?=
 =?utf-8?B?SGU3dUg5UUJ0WWx5cTVXQXE4SW5pVVNHR0VsU1FjRGpqQTR5TTE0UHU4bFNy?=
 =?utf-8?B?aDVFQzZhNEU1OGdDQ29mNmNoV1RwNzlRdFhZMSt0ZHdObWpVUXI4QmdTeEp0?=
 =?utf-8?B?VUFleVlMTVRCY1FoRlhYOW01TUNQL1pWMU5GR1FYdUtTdUlGdmNBOTBtWUhZ?=
 =?utf-8?B?MENIWElpeE9ldEZrUHV4TUp3L3ZGUTJuTXBYOU5Vb3JqUFYrejVvZ2gySjFn?=
 =?utf-8?Q?t71a74ViL7tPvTMfxI3D3xUqF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16541be3-f78c-44c7-514f-08dd8d5b6b0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:36:33.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mohN/pJXvLoOBYK6XwGACPuPYXthW1IpMqssYAzz0ikBkj/K21WnRhJSCEhyEIYiIgXN0svvqA2sqON6b/FXlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com


Hi Venkat,

On 5/6/2025 1:25 AM, Venkat Rao Bagalkote wrote:
> 
> On 05/05/25 8:33 pm, Chen, Yu C wrote:
>> On 5/5/2025 2:43 PM, Jain, Ayush wrote:
>>>
>>> Hello,
>>>
>>> Hitting Kernel Panic on latest-next while running rcutorture tests
>>>
>>> 37ff6e9a2ce3 ("Add linux-next specific files for 20250502")
>>>
>>> reverting this patch fixes it
>>> 3b2339eeb032 ("sched-numa-add-statistics-of-numa-balance-task- 
>>> migration-v3")
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux- 
>>> next.git/commit/kernel/sched/core.c? 
>>> id=3b2339eeb032627e9329daf70a4ba8cd62c9cc8d
>>>
>>> by looking at RIP pointer
>>>
>>> $ ./scripts/faddr2line vmlinux __migrate_swap_task+0x2e/0x180
>>> __migrate_swap_task+0x2e/0x180:
>>> count_memcg_events_mm at include/linux/memcontrol.h:987
>>> (inlined by) count_memcg_events_mm at include/linux/memcontrol.h:978
>>> (inlined by) __migrate_swap_task at kernel/sched/core.c:3356
>>>
>>> memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
>>> mm->owner -> NULL
>>>
>>> Attaching kernel logs below:
>>>
>>> [ 1070.635450] rcu-torture: rcu_torture_read_exit: End of episode
>>> [ 1074.047617] BUG: kernel NULL pointer dereference, address:
>>> 0000000000000498
>>
>> Thanks Ayush,
>>
>> According to this address,
>>    4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>    49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>> It seems that this task to be swapped has NULL mm_struct.
>>
>> Does the following help?
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 96db6947bc92..0cb8cc4d551d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3353,7 +3353,8 @@ void set_task_cpu(struct task_struct *p, 
>> unsigned int new_cpu)
>>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>>  {
>>         __schedstat_inc(p->stats.numa_task_swapped);
>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>> +       if (p->mm)
>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>
>>         if (task_on_rq_queued(p)) {
>>                 struct rq *src_rq, *dst_rq;
>>
> 
> Hello Chenyu,
> 
> 
> This issue is reported even on IBM Power servers.
> 
> Proposed fix works fine. Hence,
> 
> 
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 

Thank you for the test. May I know if you could help
check if v4 works without any NULL pointer exception?

https://lore.kernel.org/lkml/cover.1746611892.git.yu.c.chen@intel.com/

thanks,
Chenyu

