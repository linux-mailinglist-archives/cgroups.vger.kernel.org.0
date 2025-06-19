Return-Path: <cgroups+bounces-8604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92659AE067C
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 15:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBCE16E5D5
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1FD2451F0;
	Thu, 19 Jun 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ed61Nmyr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59DB23FC41;
	Thu, 19 Jun 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338258; cv=fail; b=b3Yyvb8cw2tbmanW21zozQPALOjvQM5UcU5sVPs8pWUdgk5yz65I0sU0nA9cNVHoASChd3sebWvcZ2PB0uZSX3HrLBCvXr+O8PUcDA6mw4YZuLPCOnU+VX3bcyNVUKwCfndjQzoebgo3O7gS1nAVgp8pFFA+E05hhDgLnYjaTi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338258; c=relaxed/simple;
	bh=cISkaBdzLmv8Ss70bq/IOp86UE7Oo/Oig//QZMKL3og=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KSxGvh7oE4oAMnYuSY285cJ7+Hs+D493vebGgW/j9ffIi0+7ibLE1UjyJ7+Nbc4l78IGWhshvx0a98P84s/G5NV86urjtf1gQgYaQQ0NT8eFvzek5yVspOTwF+dLaOqIDXUK0EKeHILM9sDdhUJpkZBAD7bqLxn9OyW8mFF5AHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ed61Nmyr; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750338256; x=1781874256;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cISkaBdzLmv8Ss70bq/IOp86UE7Oo/Oig//QZMKL3og=;
  b=Ed61NmyrHyVXbNRGnB5ix421MXKH/BLsfM5xY3K1bTE1f8uGiILIz3bp
   at5OewFLETxyjSryV3Ayy7nNNokFpC9qwUchoVmdDJ25MLt4ICZLL5CF3
   6WUF3tbAeT28J2x9yUe8ajRh4fKrDSShaD2T9pLRbN47yvr9u3+odNqsx
   jXajXf3RxbNFK3Q+fuvNEwzrPhnNH01tWPvjKF7iPyzh8SCi81vMPD9d/
   XaUTsHLAEPoY/MFtSolybAEE/BM0UfFodTXs80uY840pWTjEjXNlt8WNv
   KUgPih6b8LI+RgjQtGL9z80xmAwrB3GCk9w6MB7swAtTict6kWe3S/c6w
   A==;
X-CSE-ConnectionGUID: LYZq0TqEQYivOa55rlc40Q==
X-CSE-MsgGUID: jkFIl+TZSGWva+Hg1AK7fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="70157226"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="70157226"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 06:04:14 -0700
X-CSE-ConnectionGUID: +RXTGD4eRQypSSaAcuxqNA==
X-CSE-MsgGUID: NeRGduZzTua5hNFjaByrMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="155204872"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 06:04:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 06:04:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 06:04:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 06:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doAn4A6AMVheW8XOM+szyVcOdtSX9Rl7BNAUcqbqDtAXraaH0pISZYp/T5DZqzAFdGBPkjSW7UgqY+r1IdCFNRT+A5szwikZe9vYqRukl+yDXvqjddTnCyKSLHwT4lx3tp+ZWALwHHOETXRLqxW0Xmb+ljsZx1QKl2Uu0oH3RcYxn/+BYejYE663fLwSxbv6vubCIPGIrr4WQIPFm/sX/Mh8bhj3egLahuaotHy0KO4x5nG7CP37lLrAXZ9ag1AagLKA3obnxSpQBqyRUZlvHTx8x0Br9xTAysbd30iUPCgg6A6hUn1smUKhpXSqV/SNx/DuTJmbsXaiGN5Vx6Gwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6sZHEPQ3cpSJvg0aG7LZXCGp4HkI+UkZ82T3RGB6cw=;
 b=P9H/C4OjSDFyHpEQsYbIX+Mj8mqmXkJfFtNYaH0udUl/EkzVGvsE9/2i2aR6MAEe6zGLAJ8+dgu6uG2KKKVLCCrjcxMBDa+z1ohw0kheu/MQhP67zAYM1+vK33Dok5xruBjWFXLxQzmoiH3sbYnQavOZd7IgRwO0uxwpGRECjvb0L0ySdFFvYOHhaSI7Qwek0oJzexMt4jetzPOQcutzAyNzY9dbAwxb74t784uxi9SYn8YxLyXxCPe2BqaInbFyyNUM8SdzwCAY3Cg1Ltge701ah6qCssw2IBuY0vTk3LIeXnRk3+gmuLbO+NHgmhChnfrqu8s601RT5zfwUkFBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21; Thu, 19 Jun 2025 13:04:10 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8835.025; Thu, 19 Jun 2025
 13:04:10 +0000
Message-ID: <6e52340a-cabf-48db-b9f1-8300c1c13997@intel.com>
Date: Thu, 19 Jun 2025 21:03:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: Shakeel Butt <shakeel.butt@linux.dev>, <peterz@infradead.org>,
	<akpm@linux-foundation.org>, <mingo@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <corbet@lwn.net>, <mgorman@suse.de>,
	<mhocko@kernel.org>, <muchun.song@linux.dev>, <roman.gushchin@linux.dev>,
	<tim.c.chen@intel.com>, <aubrey.li@intel.com>, <libo.chen@oracle.com>,
	<kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>, <venkat88@linux.ibm.com>,
	<ayushjai@amd.com>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<yu.chen.surf@foxmail.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <uuhyie7udxyvbdpccwi7dl5cy26ygkkuxjixpl247u5nqwpcqm@5whxlt5ddswo>
 <a8314889-f036-49ff-9cda-01367ddccf51@intel.com>
 <fpa42ohp54ewxxymaclnmiafdlfs7lbddnqhtv7haksdd5jq6z@mb6jxk3pl2m2>
 <djkzirwswrvhuuloyitnhxcm3sh7ebk6i22tvq2zzm4cb6pl45@t64jvtpl3ys6>
 <c6bfa201-ed88-47df-9402-ead65d7be475@intel.com>
 <h4chrmiscs66vwl4icda2emof4pbhqabpkklpql2azc5iujilm@o2ttlcanwztc>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <h4chrmiscs66vwl4icda2emof4pbhqabpkklpql2azc5iujilm@o2ttlcanwztc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b67de9a-b7e6-470f-1700-08ddaf31c825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUo1TG1OUC92SklpTGswNHdVUTJLL000TG4vL3NKSlBWYmdpVi9sb2pyRFNL?=
 =?utf-8?B?TU1MMkJKMldqbmxnOElaRWpYMFlKUXBwcjQrOU04c1dvRktFcnc0RzRCSFVP?=
 =?utf-8?B?S1Q2SmkxM3V0eWd2MCs1cGx4L1ZhU0ZwL3YrOFY4TU85MHBlaEpiTkUrUlNK?=
 =?utf-8?B?OTNBNDZYZlpQa0d4SGh6OER0bitEcHpwb1FhQ0owZmVFWFR1R1VIcG12WFlP?=
 =?utf-8?B?NlYvVEZ0alpObURSUFFYTTdrb2ZkK1g4MGx1N0trS0dtUlI5Q2lJV0N2blVL?=
 =?utf-8?B?cWlxTDRONU80Z05mZmdIay93dEtiMTllbWxjRjZKT3RvTk42NkNnSjB3RmV4?=
 =?utf-8?B?TnkralRIblVjUm9VbmdCMFBrVDFBU3k4clY4VTdrWVJOcjlOWnJramo0djU3?=
 =?utf-8?B?MDNubkU2blRWTXhCSHY2N1QxT2ZVeVltd0tkeDUzLzg1OFl6Vm1uSERKcEVa?=
 =?utf-8?B?Q2dOelU3ZDJ6UnRqNStVdUt4S2Q3VlFRMFEwTGlTZ2FwZ25Id0ZBZXhvMnVT?=
 =?utf-8?B?aXg0K0ZGYnJLeXQxaHhGNENWR3ovY1dXN2RxenZPeTBPdmFhVHlhdnlyR1pG?=
 =?utf-8?B?VXhMbGg0OEM0WWF6OVNIL2E5S09yQ3FTNEpIV0htWDJPWXA4aDlWMjZNK2VG?=
 =?utf-8?B?Ni90NUd1dk5ZeFlTclVVZDQ3WWcwb0hVWnVUOEI4eHJaNTJWT01jdWF2Q3RN?=
 =?utf-8?B?WnVSZ2tSam1OQkg0aGxZRDBFZDN0dTg0Nzgvcyttb0Z5dE4raVJaMTRacmpT?=
 =?utf-8?B?K0hYNS9tVTFwdGpiMy82RDk3VDhvTDA4SGN6azZhb2xOMWJWS0tEUVVCNTF4?=
 =?utf-8?B?MGZ5UWVzOG1BTmRkUVRKS3RvRHVlU01HQWp6TjNCU1hFR1dUbnZWQjE1K3dG?=
 =?utf-8?B?TE1YQmg4MTFKU2RWSHQ0anBDbzliUUVDa2lKZFR0Y0VGMkpuc3U2bW9SZFdS?=
 =?utf-8?B?bVY3RFRkakQxWU1BeTh3dmp5T090bnRINHhkYVVGYy9ySis2VnF4enpEYUNZ?=
 =?utf-8?B?blhWczdCYTJMTFkwVnRmSS9DeHZXamFldmtOSElNdHorK2UxQnorNmZGTjFM?=
 =?utf-8?B?cTdXRDNERHVPYzlIcUtENzdkeEZ1TGpXTHdXdGw1UDVKZzRnZmcwY01tbHds?=
 =?utf-8?B?SHBUZXBJV1hMSXRxd2FQallFMGU4R2JVcjZCV3BTVDNocHRPVXJhU0xtNHRu?=
 =?utf-8?B?MysvSXB0d1c3bEpiVzc1OS91dHRxdUdsNUdqUGIrM0Q5R1UrblVUeHh4ZlRX?=
 =?utf-8?B?TWYxL3J5OFJneUZwcEhuY2JtaEVTTGtPRGdrRTlWMzNpUlNFUm10Y1F6dFpN?=
 =?utf-8?B?U3ZEUDVuYW81S0tuQlp6OVNuOTc2WFp2WGZaNVZNaVJ4VjIzOHFOV2pzQUsx?=
 =?utf-8?B?aW1PeUoxRkx3K2IzUkl1V3doYklqdVB1cHo2dGVPcFllVWMvd1VRc2lqbHp3?=
 =?utf-8?B?RzZ6VUFYemVsWmpkWTNzTStLNjJLN0Rva0NVTWs0N2owOWpDTFVyTHhlN1k5?=
 =?utf-8?B?MDczUlJCbTA2RVdNQWZmRytGWVMwVnBxeW96czZ0UG9RUm5rQk15d0pkWEFP?=
 =?utf-8?B?Mi9kUmRNUXNRcmxnRHBHbE15RXZaRDFWQ1JBVmIwV2E0VXlpeVA5NGVTMHpo?=
 =?utf-8?B?aERzZXdJUVM1cmlwbU5UYzlDUVpMc3p4OSt2V2c0cTVkY2h5N283ZmdtTkg1?=
 =?utf-8?B?WTNDNHNsdGRleHU2RDhORVNkbnIvaWhacko0QVdYcEpPZm8vZXMrcEhqeTky?=
 =?utf-8?B?eld3UjVFYU1YZVliWFl0ajE1UHpkNVFNc0RWNVRLcEJOVFZsU3JGT1JIVTZk?=
 =?utf-8?B?eWppaDM0UmRXcHRnT2N2RzZNS2NvdlpvT2tNcldPUGxyaDM1UkxOMlhnbWVK?=
 =?utf-8?B?RVY3eTRYRjBwNWpsREkzZTNnRDJ2SGFaY2tuWjJkSEVDRmRNck1PMHJsaXhu?=
 =?utf-8?Q?HTB+sR45ZAQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBvaThjSWlEKzkxUEFnK3FnMy83dWZ2VncwSWpWMlhoMDFrQzFFdUFaNjVJ?=
 =?utf-8?B?dWQrcXdNbmpRd0M5Y3FSc29OWEd3YnRLT0p3S3R4dGE4M0ppYVNTV2FJeHhT?=
 =?utf-8?B?WHVEZm9EbUZtTEFEQjlXZlFDd3kxajRiWVJPdVhOelc2dlBjelR6c3VUeVpT?=
 =?utf-8?B?NzdiUWoxQldDOEVWRzRkcnBnc29xOVR3MlAwdHNBczloSzdQcWE4cDRiQnh6?=
 =?utf-8?B?M3l4aE9MdFZ3aUdFelJoOFllR1BRQ2pROVE4OXA2ZEk5a1ZaNXZnYWFWWEpI?=
 =?utf-8?B?dnBYdHpIbkZsaGJCYXByYjlwYUtiN1hWZWkxakt0VWZFT210VFFETDN2a01y?=
 =?utf-8?B?U0Exbmw4VW5GV2h6eGFTOHVBOFFFVWFVKzFubnlFMS9NaGRtRUw2ZkswbVZn?=
 =?utf-8?B?WDVoT1lPcy8rUXJqY0ZOQ2FOV1pxS3gzYUgwSDVYb1RVeS9QMnFjdTNXTGFx?=
 =?utf-8?B?ZTdZZUdVc0dNcXRCdGljOERva202UVF4Uis4Yzc3MmhIUHhDMTZoaEl6SkY0?=
 =?utf-8?B?TnlSUXBTd2xFYU83R3IwMlJNUWt1RmxidzNqQUJORXl5SHE3SENlak5UZTAz?=
 =?utf-8?B?VTdjZjJVb3pOUkNZUUZnZUNIOEdmbUZ0STd1QlNlc1orUUZaOWJ5bmtsT0p6?=
 =?utf-8?B?VTZDR0NYNzhaQTFtU3ZxL3hqaDBJQncwL09wSnRENkIrZmx4aEI4T3BuTG1q?=
 =?utf-8?B?cmZrcUgzQVRqc2oxY3BpenJGeDU3U0U4U3pQTUw5L2R5VzQ4SGlCWlh6enAw?=
 =?utf-8?B?Z0tReFZwemtkRm9paER6MGwybUt4WTNYM2s5YUVPY0JCTUtaMTBsaHdub0Zp?=
 =?utf-8?B?Rkxaa09DdDA0dnBFaTNJUG1GOTBBK3A0T3J5NU5WN1NpRHkrUEtyVStqcE9O?=
 =?utf-8?B?UlhkWWpFZzNnek51RGo1Ny9HVFpobWJaZ2Z2TWNHbTIxNzBjUzVCSGIrOGdl?=
 =?utf-8?B?cVR2M09SN3RXVVk0dUtQWkc3OXRwb0tNVVpLa0poS1E2UGUxRWthaVR0WlVx?=
 =?utf-8?B?SlVkQzhxSDlhUjMrYkdZQUxERUZUOFRVdmlMUkpiT1dpa3lVbGFUVnJLcU5X?=
 =?utf-8?B?dmIxY2RvdCsyWU5TZ1NzYWEybzNjcFdtQ1pkeWdFdndyMWVyQ2NxMGZXcWlB?=
 =?utf-8?B?bUZwREFxNEhFNGNHeEFDS3pRWGNRU0xaNEFYc1VFbFJWNTRjMW8zU2o2Uldl?=
 =?utf-8?B?WXhQQmlHSkkzMFBTUjk4bzRhdVhQSFpjOGxjRHhoekVXZkdJVm9teGJ0YXhr?=
 =?utf-8?B?KzloLzJ1a2pOYVowdnUzNEJoVnBELzJpd2E4RkFNYkxHcHc0S2dCdnBYZHR1?=
 =?utf-8?B?WGtRZ3loeWp2ZkdpYk5veE10VmViZ3J3dG1FSGJjRG1HU3FXM1hMWWZGTTFP?=
 =?utf-8?B?eVVqa3ZGajU4a3F0ZkVSdlpXV1JvZi9GeVlFbGs4Z2pTZ0ZUNjZ1NVFtbU5x?=
 =?utf-8?B?R0ZHbmRtQlZFQ0h0dzVVeTZ0TERzdjhJK2J0N0FNZnBzOE81NGY4NDZ1NnNJ?=
 =?utf-8?B?SnFqNWhnMUY1LzFUVGoxUmRnZkdSNFI4ZkFUMDVkSUxacVdMQVZ1eDR1RklB?=
 =?utf-8?B?R0xWMEp3d28wN1dENWl0MjRoZXR5UndTaENMb0k4VFFidU81bHhLQ2ZibUFl?=
 =?utf-8?B?ZVdFWHBVSTBJcVNXY094M0NyL3VIL045MUZOc3ZHbDlyOFRtSjJsYlhEN3A4?=
 =?utf-8?B?UnNNYkw3UnJ5MG1SV1VuR1Z2WGFCRFJwQndiNE1oMVdIaVFJemgwZzNmc0Nt?=
 =?utf-8?B?Z25vamk3a2xqNGh1dmNOYTFqdUs4K2c3LzBadFV6bzJzRjljUlcwRDVYMGJp?=
 =?utf-8?B?NDdCWTZnRDRhYkJCWGthVXJxT01HS2xtQzd0YjYwQWVTeEtYZVVvSTBtVy94?=
 =?utf-8?B?SVFSQmJQQjZRQ3Nna2VseWp0cTBTMWgydG9sMHJ3bzZwcnZCTlM5R2IxQkI4?=
 =?utf-8?B?RWp2MUdoMHBBZWREQ0VBd1QrWnE4cm5JYytKYTJCMHRIWi92ZkJHWXdLQnVZ?=
 =?utf-8?B?RjZnaGZyRXhHZUNTdUNHcE1wUlJoc0M1SndVSjc4dzFtbkxiU2oyZm52Um9i?=
 =?utf-8?B?SWcxYXh6eXVrdU53NVU3VXJzZzhTbElzK2hPVVdWR2JYYkRUSzR3RDJIbmc3?=
 =?utf-8?Q?qEQjeUkiqPRAMpKWifvuPf9yy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b67de9a-b7e6-470f-1700-08ddaf31c825
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:04:10.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mapaDsQTnhjIPvyj0M76+KssyanVkX44FRcDcb6izPu+Mw7QpW5ldDZ+NEcvpHPE75Ywy069Scz72XKaetSozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com

On 6/17/2025 5:30 PM, Michal Koutný wrote:
> On Tue, Jun 03, 2025 at 10:46:06PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>> My understanding is that the "misplaced" container is not strictly tied
>> to set_mempolicy or cpuset configuration, but is mainly caused by the
>> scheduler's generic load balancer.
> 
> You are convincing me with this that, cpu.stat fits the concept better.
> Doesn't that sound like that to you?
> 
>> Regarding the threaded subtrees mode, I was previously unfamiliar with
>> it and have been trying to understand it better.
> 
> No problem.
> 
>> If I understand correctly, if threads within a single process are
>> placed in different cgroups via cpuset, we might need to scan
>> /proc/<PID>/sched to collect NUMA task migration/swap statistics.
> 
> The premise of your series was that you didn't want to do that :-)
> 
>> I agree with your prior point that NUMA balancing task activity is not
>> directly
>> associated with either the Memory controller or the CPU controller. Although
>> showing this data in cpu.stat might seem more appropriate, we expose it in
>> memory.stat due to the following trade-offs(or as an exception for
>> NUMA balancing):
>>
>> 1.It aligns with existing NUMA-related metrics already present in
>> memory.stat.
> 
> That one I'd buy into. OTOH, I'd hope this could be overcome with
> documentation.
> 
>> 2.It simplifies code implementation.
> 
> I'd say that only applies when accepting memory.stat as the better
> place. I think the appropriately matching API should be picked first and
> implementation is only secondary to that.

Thanks for this guidance.

>  From your reasoning above, I think that the concept is closer to be in
> cpu.stat ¯\_(ツ)_/¯
> 
OK. Since this change has already been addressed in upstream kernel,
I can update the numa_task_migrated/numa_task_swapped fields in
Documentation/admin-guide/cgroup-v2.rst to mention that, these
activities are not memory related but put here because they are
closer to numa balance's page statistics.
Or do you want me to submit a patch to move the items from
memory.stat to cpu.stat?

thanks,
Chenyu



> Michal

