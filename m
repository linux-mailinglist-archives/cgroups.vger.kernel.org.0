Return-Path: <cgroups+bounces-8345-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264BAC349D
	for <lists+cgroups@lfdr.de>; Sun, 25 May 2025 14:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2640A16F6AF
	for <lists+cgroups@lfdr.de>; Sun, 25 May 2025 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A62A1DF254;
	Sun, 25 May 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Obj7fv4S"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D723741;
	Sun, 25 May 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748176544; cv=fail; b=DXB2u0WRgQJYkOigdAqf3cQ5ZO2itWRljshVE//bgFnM+L3pahD+gznruN4/e+GnWRdC5OYcSzbFP0iSd1LYOf0O4oYQM4TCiKjU8j0Q8DABECJAQYGbQbQWLKojApJDPQWy+zCEh+ZEyDccihr0X2Yd2O1WwR9bLiHEcRhlaT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748176544; c=relaxed/simple;
	bh=a16096z7+7tCZM3pTfl7b0w8BObz/vU+4fPsFCzZwbo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhXGhO++csN/TSw70L90gVv0EKRnblpTNXRes6m+Oiexl+l5ottOxSR4itGCegMT9jW8ZJOTxz+LOPTvHC3rJzeNkTbEsuCPlUGuBJXlAd2KeyYNpJDR5392Q/NvqjNMU1PKWxkEildtqX0VWKcxgxDoKjeYVRoAM4y4QySGk0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Obj7fv4S; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748176543; x=1779712543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a16096z7+7tCZM3pTfl7b0w8BObz/vU+4fPsFCzZwbo=;
  b=Obj7fv4SK1D4ElRjIqpWWhqnKEv3lsmxF/x+36y4gFrh6bwF69UDplE7
   iKAF12D44l3hTL2SzgZFAdOBHeVwQH1DkSe2IG7K8m5zZfvxwpRVsrLi7
   yi+EZ8lw9e2n+vGZdCmCnSE6+MzEgzrSA8k6NIuCtObZmR13CxISx/arz
   O1BsyVlXC3dsYWtrRkrGtNGVP668uuzkrXDmxVP8RjRi3V6M3ImFfvy2X
   tWMsoomnC9hiv2SXpuXnOJNnlWvAqK+2j3ZfQWjK5rUxpQ9GQ3wenL6us
   y52RXaaiYGnfhcaUVl/f6T5f9A+2adBBIXyQ1VAZZUBRKjv1QKZzwuwKV
   Q==;
X-CSE-ConnectionGUID: cbC3bd7DSPGYOgytglHs/Q==
X-CSE-MsgGUID: u1QR4IFXT3y11xZTIi0fmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="37789019"
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="37789019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 05:35:41 -0700
X-CSE-ConnectionGUID: BdsX71LPQBGyalRYLRg0JA==
X-CSE-MsgGUID: lnvuV2ekTm2JZCw03N/a2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="147099192"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 05:35:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 05:35:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 05:35:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 05:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDfba2i7vVLnrORo16V/uavRmnNmFsQwtvBAnEQC7sk3P9yW0piPYdj9c1j564NCqBtp3f/2+gZ5n47YCTb/O4cBVF1CzxsNQf4/owcdIQHqI5JSG7J6AKQfzMmvnmD7EVAyQbcRohx8kVN3jutM+8uHFY6RK8TyP5szkkR6s47erTXZsegEza3ZfcZov1xUlCc4baCmUILLRBo4DhbKEEsKLt20h1GRs1aAggE75Va45DL3IJP72w7hEvMmmLjcahXGly59VA7ZEOWyR+jBASMpMYPY0wvk6otLMYHAWmKF4Zi4pFhjUyw/BcMwuEIm7FRSvB56hW8NHzadiQnyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOB7epIHn1of7NVJ3C9U9icFm8X5qlMk7nXaKWr9CZs=;
 b=yR5xSG05q3GxlaAbNdVjsqf15/hbmc3jaeieTCiRxQF+AbHzLAbiQK5GWGeSqO+3paNXZvhwVINT2Jl3SxPqhDqV2V8TxyZvEq9Ylo8KRPSyO07MGNlxhZtT5WMwLx6U/IvZYrDdtY/HpggLKwwVYCnWUrNIPDJzkVwnAiyOMUVtfZHPz1z8nguP8tMGbhohLQ/amrMxoZwR6tMLBB9SvWdX+mtiRPrprPy9Z9ggyOhbnqLiDbaFghet3w921DZz6drwIwkWZlmmva43IE7YoQIoPHYSoYAJJnZZaTHXDuoZpg3qmuJK218wt5mXS9KZmEiYyLwMHi6A88mCy4JjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Sun, 25 May
 2025 12:35:38 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8722.027; Sun, 25 May 2025
 12:35:38 +0000
Message-ID: <52a1b56b-9598-499d-ac9c-de99479d5166@intel.com>
Date: Sun, 25 May 2025 20:35:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <peterz@infradead.org>, <akpm@linux-foundation.org>, <mkoutny@suse.com>,
	<mingo@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>, <corbet@lwn.net>,
	<mgorman@suse.de>, <mhocko@kernel.org>, <muchun.song@linux.dev>,
	<roman.gushchin@linux.dev>, <tim.c.chen@intel.com>, <aubrey.li@intel.com>,
	<libo.chen@oracle.com>, <kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>,
	<venkat88@linux.ibm.com>, <ayushjai@amd.com>, <cgroups@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <yu.chen.surf@foxmail.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <ad9f8af5-6bac-48c0-924b-498863370079@intel.com>
 <CAGj-7pX9yFFEFuMPgXBL_gsWevX8MtUZix5qyUQxOqWGKcbFzA@mail.gmail.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <CAGj-7pX9yFFEFuMPgXBL_gsWevX8MtUZix5qyUQxOqWGKcbFzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0080.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|BN9PR11MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: df7232f8-43fb-4155-93f6-08dd9b88a72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEJNUVJDbGYyQUdkTG5ndmozT0g0SGdYSjVKMGhDWU51WXFIYVE0bHZhdGZJ?=
 =?utf-8?B?cU90U2xLTHBaSmRmUHhOT3gvK3hFSEN3RWFtdGh4S3M3N0dsU3lzazJ6MFU0?=
 =?utf-8?B?LzdtVk1DNE5UN0lDb2FDcXBReHovbTFsOGpEeGJleW9aRUVMTkZTUkYxbitZ?=
 =?utf-8?B?MkVXL3FhNzZpWXRUdVNROVhKVS81OTJjRmZ3L2FjU2M4OE0xNndIZEpneVRj?=
 =?utf-8?B?TEFwSkZ2SWxmbzN2ZVFJYmlTd3JrZjZMNmYzbW0rM2liQytuMk1hZG1RRFRw?=
 =?utf-8?B?OTVIV05vY3dUTGFDYzBRRjkvMDJheHhDc09iSHp0SGJKNFd1TXVNdU5PQkpD?=
 =?utf-8?B?YklrbVJmZlZKQjJCUmFjek8xQzdPdDlmS2g0ZzZ1OU51cHlldnEwTnlyanBW?=
 =?utf-8?B?T3JMMTZXTkZoYWNtdk1IaWRXaVBVOUhXR3lBOHhPM045L3JSb2pCT0lWcUIx?=
 =?utf-8?B?U0dveWZiR2pOeDdrWTg5bWpZRzFocG1DcFFjSmdkWDM0VHVoWU5UM3M2Ymdn?=
 =?utf-8?B?UVJwWnJHaTZjZGk5aW16UVIwR2Z0d0g0UlVkdG9uZEJhZythTXUwclF4a0Ny?=
 =?utf-8?B?YzJpcFRWa3JYRkZtUm5DSkVVbzdzYUlhSmlFeGNsekFRK2s4blFMTVdmVGR4?=
 =?utf-8?B?YStCOFI1a28raEZzL3ZkQkVRTTVoT3MrV2w4d3dyVURYRHhZZE1Nb1crYjBv?=
 =?utf-8?B?VXdkaFBMZEtjVC9kMUtaWXJmY2hOOEI1VmtGTjFnek5jd2FWakp1SEdTbWxC?=
 =?utf-8?B?M0dWemova21ab2ExSlF1eG9kQ3hNUkpzT25PNmlOK21UOHIrNDhTUUpkR05m?=
 =?utf-8?B?a3BydHdQaDVOd3BSell6S0dNQ3Q2Ti91TXlHSXE2MU9LaXVoWHZWZDNDN1Zp?=
 =?utf-8?B?RS9FMXhVdXRzNm9xQWZ0SnlCbGdYbEtJZFovbDNkSjZsOGF1dDd3d25MeGRJ?=
 =?utf-8?B?U0huWCsxeld3UGt4RXNLSmhodEdtckFQbGxrWXNCNnpSTFNISHR0Q0ZOTEJW?=
 =?utf-8?B?bm9rOWlEd3JsemZNanNqSngyc0tsU3FaQzAzMFVTVTBXSmRBUDh0TjF5Nk16?=
 =?utf-8?B?eTFoZXEwK1ZSTEJCczBSaWVSdXR0Y21VT29YVVFaRWM0Zy9rOWpGa1crVUVI?=
 =?utf-8?B?bUJrYTJQMG8rRUhmYzl1UTBmL0JCaHRlMVNjWG5HR1ZrSXpkaTNsMHM4VzJD?=
 =?utf-8?B?UDEweTFuY0NlNHlnM1cxUUg3bmNHMkFSZnFocElsWlRkTHBzaEN3WHU4OTdx?=
 =?utf-8?B?N0l2ZlhXN2lnOWdRcHJzSU5kdWhON1dnVEVGM0RYZ0REbmt1dGkxam1LRnYw?=
 =?utf-8?B?WDk2NjBlK1V4MjRrcmd5ckdCSS9OZFg0eGM1WTE5WDlwd25zQnluK0lXWEFs?=
 =?utf-8?B?NjVsa0E5SlNlbUw1TU1BNU9Ib0VsV2dQdTMxL1RzZVpBYldvUEljamlPYk03?=
 =?utf-8?B?SlZycnVhTWVOQWxIR01YM21DRzlOQmtUMHlOYnlVYmpDeHlWU0FDbGRHM0Nx?=
 =?utf-8?B?V1phKzMzaGxSZWcxemsyUEJ6SlY5SlRoVUY1aFdBa1BSYVl0WlhSbk0xb0w2?=
 =?utf-8?B?b1oza0tNVjZLNVRHVXIwcDdBeHIwVThDdnI1K09HTnZyWlNRekUzV0IrcDdy?=
 =?utf-8?B?NVNyYTFObzdrWHBEaTdoR3A5Z0dwdlVtaWZmUUFML1NJRG15NTVZNmFKWVFU?=
 =?utf-8?B?ajBETWUyWmhENGxXMjljcGNGbVBuWkd0RTZocGVPdVB4MWlaRmN1dXNKcURS?=
 =?utf-8?B?cDBBNDBmZ2lNbExBYXZWclkwaWNhMUI1T1BCc3liOSs0RVlualp3N3lKb0ZJ?=
 =?utf-8?B?cHpJc216TVNGMUE2ZTZ2TmpycmExOGhOK2RwSHB6cnBmYnQybUc1dlcvMEwx?=
 =?utf-8?B?cnFQcDlSMDd1SGYwM1kya2lwSVZoa2lmN2hTcnk5Rlh4b0NLNG1rMlh0SDMw?=
 =?utf-8?Q?lWwiq3ETcrI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFQ1UmVUS1NvaGc0TGdXR1BPNHcyczA2bW02MnJUZ3Z2R1EwM2FOdlZZRlJr?=
 =?utf-8?B?em9SeUxQYXBMZTFZT1Y4TnRJcUQ2YjVvRys0U080VVpKYVJTU1B4N0JhalFz?=
 =?utf-8?B?R2xZUUFWRlFXeXk3Q0hMS0R4QWhEVkZkUlRqUGp0bk1pV1B3NjRkSWp0cXB2?=
 =?utf-8?B?c0FoaFlIV21aMUNFRDJiQm0wMHdGZE9QWnhnanNKaG5oTTZoc0w5WFE2V1Br?=
 =?utf-8?B?OThiemYyMnJHUC9MaCtra2NhSmlUc0pVQjRsQXdPL0FIaHVOcE41M1p3T2FL?=
 =?utf-8?B?QlNnNW5nOXBMMzdiMWhGNDFNTW1EMTB1VU14N0dFbUtTMlI4T3pRVTE3U3B5?=
 =?utf-8?B?RE1rNktOUjNTMGI5aUxkNXNSdCs0a1VRVVRMWmx3dmlVL0N2UlVaeEdPbk02?=
 =?utf-8?B?czNHMlJMYk9FZm9HN0MzY0wzaGlwSFNha25BdmZYditWeVNpYm5LcEc3dVhG?=
 =?utf-8?B?QXFKbnl6WS9kYitKVnFHZ1cyeVJYeEgvcmo4VXE1UkQ0K0RQbGxHQWFFN3VT?=
 =?utf-8?B?SStrZVJwVnhHbGxlcDJTLzdPR2xqMlVXaWpFcTNzd0RJR2R0QmZISXBBM0NN?=
 =?utf-8?B?TzB5eGZ2TjhXNG16UGt5Vjl1WTdmY25KUHBSU2RZck9Iem9IMHZybWhJRlRH?=
 =?utf-8?B?RDloSmkwQWhROWt6Y0tMN3NWVUFidGNQTEpGUitBOGVlNXdkRGN1N2kzWmNT?=
 =?utf-8?B?RFRKMVJhZ1hzZlZTTU5tNzZDeWNUZ2FBa3VpK1NuMGhJbW55RWhvTHpOREVt?=
 =?utf-8?B?ejRHL2dVN2crZXJRL3ZJZTljVUN4QURNM2NNRDV2T0E3bW5BTnh0TjE3ekFE?=
 =?utf-8?B?SHBXQ3JncXRJd0F0WFZ6NStDdUZrd3FScDU2S01GUEFWSncreHB2dDArcjN1?=
 =?utf-8?B?U0E5V0tzNTFZcDRBWDNVM1kwVDhzZ2trK284UG4zbVhqbWxxWVZpV0I3RTVH?=
 =?utf-8?B?QTFSamMvZmlvWFhoSGhraElBa2N3aE1zN3dRL1kyZk9FNXl4eCtHZ2tJRHRw?=
 =?utf-8?B?c2NjSWxDa3gvdCtqajBVRUVoYXh2YTIyTzlUVjNpcmdqTHdpRGJtZmwwZmxT?=
 =?utf-8?B?ZVIvQThkR0pvVVAzQU9hTzRGRGMvcis2K1Y4NkhpS3c1STNMckdjZUNnRjRY?=
 =?utf-8?B?WWpwb0cvejNBd2o0UHB2YVlueTRpTVBEL09aeWdESE82Q1VtRHAxZklOOVlP?=
 =?utf-8?B?RDFiTlJHYWJVdlNvRm1KL2hoTU0vV1h6RXB4OHJFekxld2JsU3h2ais3K2FL?=
 =?utf-8?B?NVVhZWdjTnZiajZkY3RscVQxd3hTZVNpUkFFZC9YZSticDNDVDJiZU1RUXF3?=
 =?utf-8?B?eHNMR0lKdFgrTlh0bzBkMTFVRmF0WFVHb1pXa25XdmxYMU5xR2xRVFp6cGRC?=
 =?utf-8?B?VDVBcmxiMExYcE5PRDk2VFpPNFdlcXBpcEpsb0FFU0hyOHI4Y1ZPUGZ5c3p2?=
 =?utf-8?B?dlNRQlpkRjliczZ0K2I0Ym9wS3pYdkZaMXJWaWxkM29YMFdJTEhoRWpyZUZy?=
 =?utf-8?B?R0FsaVVmTXdjam94R1V4V3JEKzdIemFyb0M1SzJBeDlmZGxSMVVyMzI1V3U4?=
 =?utf-8?B?THNRaGJ3aDJEazAxZ1VqbFNIQkJ5cTJTVEdOUzBzY21OWFlwdEpYV0dONjBD?=
 =?utf-8?B?UHcvdUFsaEoxejJCZFJEcUMzOUUvaHRBZUJKTU1NdDhyTHA1bWlrWGdaTXQw?=
 =?utf-8?B?cU1WWFJzR0JHN1BhQlZwSHdjbzgwaUt3VjJVYXhFMFRuYUswRUpmS3dnT2d1?=
 =?utf-8?B?Z2EzaVFVWWo3TU16VGlsOGtHZDg2N2Fkem1QNnZHUUJCbjJwa25pSy8ybE1G?=
 =?utf-8?B?elVjSmMwNzJpWEpSTG9PUzRrU1Bhc0RIZlBkcUdsR0tRT3M5M0Zmb3g4UEN2?=
 =?utf-8?B?MU5wZEcyUFI2R25rNjYxRnBWL3U2RmxYWmRvTGdGYmwvU29mOHU0ZDAyeEhw?=
 =?utf-8?B?UjljRzBzc04xN0FtZXBzaHBpNkRYRnpEZUt3WTRYbUU1Y2IrS09Yb3B0VGxG?=
 =?utf-8?B?dGVsVnM1c2RrSFN6K2o3dHRSZklWRnZCVHd0d01lUnN0UmNOamNCd3VoM3dh?=
 =?utf-8?B?d3hjQTh6RzBzc3V5VkxBeWdTeVRhK0ZWTkxOOTF3QU4yT1lXNTNmY1E2enY2?=
 =?utf-8?Q?cCiS5zPug3ilvwx8gh4IO+Fyq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df7232f8-43fb-4155-93f6-08dd9b88a72d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 12:35:38.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFeOcdwNZtAtAL012o4sssl1Qebzp4PDkUaxG8V9r9QW0aF2SF3WVzAzt5KR7/g3Zh4sISzzuW6dAobPqDsdCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com

On 5/25/2025 1:32 AM, Shakeel Butt wrote:
> On Sat, May 24, 2025 at 2:07 AM Chen, Yu C <yu.c.chen@intel.com> wrote:
>>
>> Hi Shakeel,
>>
>> On 5/24/2025 7:42 AM, Shakeel Butt wrote:
>>> On Fri, May 23, 2025 at 08:51:15PM +0800, Chen Yu wrote:
>>>> On systems with NUMA balancing enabled, it has been found
>>>> that tracking task activities resulting from NUMA balancing
>>>> is beneficial. NUMA balancing employs two mechanisms for task
>>>> migration: one is to migrate a task to an idle CPU within its
>>>> preferred node, and the other is to swap tasks located on
>>>> different nodes when they are on each other's preferred nodes.
>>>>
>>>> The kernel already provides NUMA page migration statistics in
>>>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched. However,
>>>> it lacks statistics regarding task migration and swapping.
>>>> Therefore, relevant counts for task migration and swapping should
>>>> be added.
>>>>
>>>> The following two new fields:
>>>>
>>>> numa_task_migrated
>>>> numa_task_swapped
>>>>
>>>> will be shown in /sys/fs/cgroup/{GROUP}/memory.stat, /proc/{PID}/sched
>>>> and /proc/vmstat
>>>
>>> Hmm these are scheduler events, how are these relevant to memory cgroup
>>> or vmstat?
>>> Any reason to not expose these in cpu.stat?
>>>
>>
>> I understand that in theory they are scheduling activities.
>> The reason for including these statistics here was mainly that
>> I assumed there is a close relationship between page migration
>> and task migration in Numa Balance. Specifically, task migration
>> is triggered when page migration fails.
>> Placing these statistics closer to the existing Numa Balance page
>> statistics in /sys/fs/cgroup/{GROUP}/memory.stat and /proc/vmstat
>> may help users query relevant data from a single file, avoiding
>> the need to search through scattered files.
>> Notably, these events are associated with a task’s working set
>> (footprint) rather than pure CPU cycles IMO. I took a look at
>> the cpu_cfs_stat_show() for cpu.stat, it seems that a lot of
>> code is needed if we want to expose them in cpu.stat, while
>> reusing existing interface of count_memcg_event_mm() is simpler.
> 
> Let me address two of your points first:
> 
> (1) cpu.stat currently contains cpu cycles stats. I don't see an issue
> adding these new events in it as you can see memory.stat exposes stats
> and events as well.
> 
> (2) You can still use count_memcg_event_mm() and related infra while
> exposing the stats/events in cpu.stat.
> 

Got it.

> Now your point on having related stats within a single interface is
> more convincing. Let me ask you couple of simple questions:
> 
> I am not well versed with numa migration, can you expand a bit more on
> these two events (numa_task_migrated & numa_task_swapped)? How are
> these related to numa memory migration? You mentioned these events> happen on page migration failure,

I double-checked the code, and it seems that task numa migration
occurs regardless of whether page migration fails or succeeds.

 > can you please give an end-to-end> flow/story of all these events 
happening on a timeline.
> 

Yes, sure, let me have a try.

The goal of NUMA balancing is to co-locate a task and its
memory pages on the same NUMA node. There are two strategies:
migrate the pages to the task's node, or migrate the task to
the node where its pages reside.

Suppose a task p1 is running on Node 0, but its pages are
located on Node 1. NUMA page fault statistics for p1 reveal
its "page footprint" across nodes. If NUMA balancing detects
that most of p1's pages are on Node 1:

1.Page Migration Attempt:
The Numa balance first tries to migrate p1's pages to Node 0.
The numa_page_migrate counter increments.

2.Task Migration Strategies:
After the page migration finishes, Numa balance checks every
1 second to see if p1 can be migrated to Node 1.

Case 2.1: Idle CPU Available
If Node 1 has an idle CPU, p1 is directly scheduled there. This event is 
logged as numa_task_migrated.
Case 2.2: No Idle CPU (Task Swap)
If all CPUs on Node1 are busy, direct migration could cause CPU 
contention or load imbalance. Instead:
The Numa balance selects a candidate task p2 on Node 1 that prefers
Node 0 (e.g., due to its own page footprint).
p1 and p2 are swapped. This cross-node swap is recorded as 
numa_task_swapped.

> Beside that, do you think there might be some other scheduling events
> (maybe unrelated to numa balancing) which might be suitable for
> memory.stat? Basically I am trying to find if having sched events in
> memory.stat be an exception for numa balancing or more general.

If the criterion is a combination of task scheduling strategy and
page-based operations, I cannot find any other existing scheduling
events. For now, NUMA balancing seems to be the only case.


thanks,
Chenyu

> 
> thanks,
> Shakeel

