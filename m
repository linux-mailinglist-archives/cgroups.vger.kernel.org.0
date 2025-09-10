Return-Path: <cgroups+bounces-9963-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457DB52089
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153847B4F01
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D722D3236;
	Wed, 10 Sep 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T4xrHi/+"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AAE253951;
	Wed, 10 Sep 2025 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530821; cv=fail; b=MO6bd7yRuFkUiqHoaXEZM1+DCW3XVK6u1sKyGeRkeMUK8Kbmve/M/EoIpLUPhh261xLMcYKCHIF58cp2YgAzTmejc0j8vaunzf5vYwW/8DoP6sCj6YbnZnxOsvfGRNwz/n65LB1Jb9YvMP7MpbQMuYU+HpVleH0ZJu82mbtfeSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530821; c=relaxed/simple;
	bh=NPS1tlHRCrPEAIdr5848rf6diAXWXVNha1r7d2bZgv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OoNrIpfUMQnDLioknqsIt3IcjQ/icAC1sQ8LCDgOIOBxRytDgSGTOIbEy0Nghcrt/zdLDZq3nyyIi00QZcBBL5Lr7n+Ba3Mw6N+kka++7bPzQbfGUX16GTbXBvefETMS/BohX+BjzZViWnVllUkFqcr1YjVGTOM+dtlyvv6KMjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T4xrHi/+; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/bruae6VqDV7PDpeqrs3Qwara1uPUCutYx4HJNgiwnXbhEdiH81H3e86/5RC9SZH1vO0/ScKYZMvepfvStwaP3U7pUNEGQbuK9ceqpMmETbB12jzUTcQVse/JlVb9+3j5TgMUTKb8tkWWvxxeXj68Mp9S/jM3orPtVZhviIiA25c6xg4VfVeHdrkP7z5PabCo4e5YrpCqe1hkF2qinsH9Z6oUiMS3APz57Pu1Rp8plibRy2kwADMOSz7vfOr1xFSGBZQWfJ20xmPn7wrjk0SS5pueB+IChH6Qo1DTV5p62LKxfD4CSHnfaIo/Iro2DvQ+Wv5Ru95gVbr+cONyQEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y/qmPRki73rYHtx4yvpPj97p8VmHbJ8M5V8v5IZeLk=;
 b=g87wlYOo6Z8mzXNh9RJ1tuDCAoGvVACZUVutLbGBUjL3FHVUTNueAa4HNbBWxG1arlIEGUCx1JCD3OR+kTcQ971EegZ7/udEu1nEa6zWRasQ6bu0ZHWoxgIoR68UCJbwQaSr0pJJw5FsQX6JomVhaaO2nu4M/zjNRnHjviBPwsD6DXI3DuQOkmbxUz7H2eD0elZTwmwuKRz/aDeOfFRpyc0dxXkYtr8PLIZPnFg2rxANe6bUzIjPLI2AVPqU2sxLXOFAladefMVxipcP0BfjAGHreF9wY6nkAYQqj3errFJSRAHlcANnfCSrs5L/2oQAEPU2KP4JdQvOGywvBy9Y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y/qmPRki73rYHtx4yvpPj97p8VmHbJ8M5V8v5IZeLk=;
 b=T4xrHi/+40wg7FfKHy0uL36zNnUtLvOfPVJkiH/3g+RRu76UhJV6Tq97XGMt+vZQp1f+tLrmKCH5lnrtj2L5Ixd8xTCpZw+n68PJ6JZF+2YLC20LVHMTQcsnw+2lGIRL6pzMu3iOu12bXvZnf4KUIZsGikjmkj4mzhXNKxYhCXY5HnLF0JfJ9vcPkKDMOy1jGLpdlM6UkzSimDIaf2tbfMTggBVBXEysPDEpQsBW0Zezg5zyRd8Zb2htH6XmZbm9SwV2VIbys0L9XKrvGLottVLAQwPLVDUlAnSAoHX4q4m40sFagdt6R4yjdLLr6Z8Pt5/VTi2Y3qTBM2rsPXdb9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 19:00:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:00:13 +0000
Date: Wed, 10 Sep 2025 21:00:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <aMHKuRBUSeNFiLVF@gpd4>
References: <20250910154409.446470175@infradead.org>
 <aMG2HAWhgAYBdh6Q@gpd4>
 <20250910183555.GV3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910183555.GV3289052@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e510f3f-a284-49f2-2280-08ddf09c45a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3c3MUFjbnJiSkJ0R0NFRkpURzdQRkhIQW1iMjdqdTFvd0p5WklwK1MxTXFN?=
 =?utf-8?B?L1FlSGEwanNmMXgvL0ZlTTgyeDhsR2R0eExnMmdLcCtNVTFFY1pjQm90aTl3?=
 =?utf-8?B?MDNFcWhQVEE5ZXorYXhmc21xajBJY3F3cXl5NVUxZlRRRW8vSVNpQ2ppNWgr?=
 =?utf-8?B?bHdiOU5Qc2tDekhFcjlKWkZHWFhKV1FYY0RsV2tlc0xHay9yUExBL0NQTFBp?=
 =?utf-8?B?WVRqSjhvUWRSNmhNR01Eait3RkJVbUxsajJsa2JHYUU5OHZCU09FTDdGL0cv?=
 =?utf-8?B?cVo4SEh2T2x2NjFSYlFUYXNVUEpldVMrZ3Mxd2pGemdiMWNsUlRUcnZodnIv?=
 =?utf-8?B?cjhXUXZYTVlZelZQaFpUMFdNRmFHTjBodmZ0Y055a2pjeHd1UmFVN1RhSFJi?=
 =?utf-8?B?TCt5TGo5K0NpRnQyWE9Hd3A4YW05eGcvelkyNFZvVWxPTkR1NTZ5aGU1cGM2?=
 =?utf-8?B?ZEpVSDRBY0ZXcjgvTGJwZG9rM1Y4Q00rb0NRRnlzWnVNWFZ2OHU1QkF0QWZG?=
 =?utf-8?B?YTVESmkzZkl3TkNoZytNeWlFcXhDN0ZyWXNPTWJjSUdHVkZJMXpsRW9Nbktq?=
 =?utf-8?B?REx0V3BLR0YrSkJhVTdMbUV2KzBLenJHVlFqcnpZM0JwYnhrZURxUTJDV0hZ?=
 =?utf-8?B?MmJRUSs3K1J5eGtVNm5sdThEU0xNTFBMTE9FeGk1M1lUM2JsTE5vWC9kTStG?=
 =?utf-8?B?aFBNcUFtZm1HKzhEY1JWMGFvWmVVME9GNG12eTRuTjJQOTlQc1dsV1EzY2Nw?=
 =?utf-8?B?Z1RDekJkTjVPQThUbS8wNkVtZk5aaWxicHkwTWFIS3FUWmFkeGxzQy9JMlE3?=
 =?utf-8?B?dWVrSHlIM3hjdjcrYXlsSVhVY21CL3Nnc1I3b2pLbW9pNlU4cEJnSVpPSTBZ?=
 =?utf-8?B?TTFqYURRTjYwdnk3RmFSQ1pzSlNJUmo1Y3BOU2pubFBFYU1Ca1FxUU9FOXNU?=
 =?utf-8?B?VWdKckRnT3AwVW5WR0docnJJTkUzNGtFbCs3UlM2WjhweDBGZ3RZWUorckpn?=
 =?utf-8?B?TEZOd2QzcFRnVGdVNk1kY0drK3RlbWZ6SEVwbHNPQy8xVnhEb015L2U1MURq?=
 =?utf-8?B?Y3ZlZGUwczZMQnk0b2JDUVdiMDZYVmhJN2ZKdTU1djdySjV1ditPbXZtNWFq?=
 =?utf-8?B?N3daQkFtVUkwRFB2b0VhU21XU1hTUjFyZjUxaXk0cExJZk1namFnZkl1dVhY?=
 =?utf-8?B?VGdOb0owWTBINU51L1VEdG9tUEFMV1VKNjl3M0VHL1dNdGU1d1dhRzB0MStk?=
 =?utf-8?B?OFJVWjB1ZnV2OHhaejR5R1Q2Sjl3M1lkS3RpbVN2ODkvUUZha0RTRlpyYTRI?=
 =?utf-8?B?ZVp6ZzNEOWgzckRZeUJTdkJjVWtSeW1Na2FWOWpTeGErNXBFVVZ2RjR3KzBO?=
 =?utf-8?B?T1VsdDFoemZ0Y2VZOGxCWEdrbmt5MTNjU2ZxcXNud0p6bXBHYVZ4eVBWTFFr?=
 =?utf-8?B?MjZ6K3lEVlRSenZuTTJkNmRPYjY2MThuOVh0UFQ3VW1GRjQrc0lkN2p5MmFa?=
 =?utf-8?B?WFRtTnl2UldFZk1xYmwvbWlRWjY3czZKZDZUdTBqS1hDems0SnVkVkhlQlh6?=
 =?utf-8?B?ajhxZm8rR09mdFdxSGFwdTBoUEZRK3VHekVpRTRLWGtINlYySDIzeHNNR2RP?=
 =?utf-8?B?c2JxQ3RxbTJvNDE2aHc3aVZBN3ZxNkszSnBSOGZrN1ExWDlobGJNM3VLNnlG?=
 =?utf-8?B?QUtHWUpSaVFVbW5XaWMxQTJib0REUnhWejI1K0ZtZTNkLzl1R1V5dDdmMVdp?=
 =?utf-8?B?eFExcmpWbG1QNFdCTEZzS3lKaUU1S0NQcW44anBYNWNOS2t5bjREckpJNm9V?=
 =?utf-8?B?T1VRV3RwU0R5cnU1YzFpelNyajY4NE1jYjA4U1NkQitLbmVCdUhUczJjNUQx?=
 =?utf-8?B?STU1VWNrQ1czS0VTYWhZUU5uNlFrVGdyNmtRanFzTit6b3VFV3RPQUc2ODdn?=
 =?utf-8?Q?lwqAzTTK5+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3VPc1lkT1N6VFRLeC9vN2xtUzlhVFNCcDVXbWJHS3c2UnMzT05hOHFpZmlO?=
 =?utf-8?B?Z202MmRhbzN6VTV0andybEV5TWZ4Qmx3WVZsTldMYjNnTW1YNkRTMDRsMWZY?=
 =?utf-8?B?SFowYlNJZE8xSzN0NVFNWllsN2hDaEh5MVREL0pOdVFRczRWYTc4d0o0Q1BR?=
 =?utf-8?B?cXF6WkxEOG4rcElMMktyUlNMN0EyL29KbjUxNGVkeHFLUGNwOWZjNHBLRjRQ?=
 =?utf-8?B?blEzaTFCbmQ1ckNmRkpWREhrWUd0dm55a210RGltSlJ0VHRTTU9xT08ycWxt?=
 =?utf-8?B?VFBCUjJ3ZEpGY3p4eW5tTWczM0JYYWd4bDR6MEU1aFRwak5vU0hUYWJ5aXZU?=
 =?utf-8?B?UW1BR1BLNm1PenNsamo4WVZFN2ZFQk9lbFRFWTJIZVJDMEcxd2h1TlFZOXFG?=
 =?utf-8?B?NGZHdzNOSzZSUE51RkRRRUxPQkdCclFEcHh4NFcyMTRreGdkR09Oa1RyWW92?=
 =?utf-8?B?eHNKZ21WWTVvTHpwVy8wT0s5emxnRzlOYS9XSnk5VXlsWlRFT0FzM3M2czkx?=
 =?utf-8?B?UG85QzdpREIxSHo5bGtyeW14VWlNVllYREtmN3gzaDRTT3B2ZzA4ZlI5RzZI?=
 =?utf-8?B?TTdwMWkwMTF3K04xZjlpSmdZK2JacHQyU1dEUmc0WWtlQnlCWDVqTnNLRlg0?=
 =?utf-8?B?c0lpeGpDM1A3ZmR5cmVSdmdJN2ZRdVJKQzMvUWVEa1dNK1dIOUVUYTZSYmNP?=
 =?utf-8?B?VHNSVW9pNS9FakU5eGZoQkd6SVg2V29na2tZM2lkc283ZzRrVmsrekZ6c2sw?=
 =?utf-8?B?Q0VCM2pPUHZMa0VEYkY2SGlFdXVYVWgrWFpZTWJqMVR1RURSSHF3WElrN2Nz?=
 =?utf-8?B?UDRmcXpERkhlV2tObWhyWGhzZERQQmw5RlVocXBFL2ZEZks4VkdKZUtnTGwx?=
 =?utf-8?B?NUpraFNZTFpNYTc3NVNrWThvOXdRYU1UME56TVdpNmsvU1JMa0VDaVZrYUlK?=
 =?utf-8?B?dUFzaDdPc0MwRDRhWmd0d3prdExmZGordUdSVHVoU3lLYWNPeUpDMWd6eE42?=
 =?utf-8?B?dGo5TW91U0lYL1NpQjFjdzN2MUJtR25XaU1xVlZhV2J3L2hoc0w5YzRNTGpX?=
 =?utf-8?B?Mjc1Qmc3MFpiWWxrK05OMk5KZFNuTFU0UXlVL2FwQnZ1d2J6dWdMWHYwQnAr?=
 =?utf-8?B?UmRUZCt0SU1xZ2wzZXBnbVZlUmIvZno1MS8rRndUU3VvSUYzTVhRNzZUUUQy?=
 =?utf-8?B?N1BrVWIyWS9kbnh0ODExMXNqU3EvODN2cER4ODBmZituVWdoU2lpVHRwYjI5?=
 =?utf-8?B?Sjhid3ZlL2drZGJ2WHhEV3BaVEJmenRMd1lmZG4rb012MEQ3RUNNRkNFeEc1?=
 =?utf-8?B?Um5vb0NVZEZzK2ZROGhBKzZ2bnR3Vmo0dGVWZGlEY0NoNmsvT1FtQ0Y1Rndl?=
 =?utf-8?B?L3pwWTlUZU1UNlJxekVXdW5uTHk5bW5aYlNlUGdJZ3Jqa3dpeXRnUThFR0dG?=
 =?utf-8?B?WTNOK0tNajVPVHNSZkFHazRTSEY3RTQ2S3FPWVliQklrNndhUU96cWdPN1hr?=
 =?utf-8?B?aER1b0N3L0s5blQ5bnY1Z1dBelUrWHl5UVRtS2piSEs5ZFNpUGVzbkFQUW1Y?=
 =?utf-8?B?YjhWbWxjdGVNT28vZ3pSb2dnRG9Bczl6YzlEZGxobFlUV2FyY2pueGpTRjFW?=
 =?utf-8?B?dEhXNWVnS3RtUy9iZHJsdzBuczh6YXNkNThoUWV6TExFdm9seGhGYW9QRnNQ?=
 =?utf-8?B?QXdMem5YcnpCSFFFcnNiNmdDeTJlcG0rTFNxMDBkS01IU3FpU0lrQUswZ2Mw?=
 =?utf-8?B?UHdHTS9IcmtPRE5YRTQ0QzVVcDN4MWd0aGRYc3N5U2wxcG0rS2ZOTmlndlVU?=
 =?utf-8?B?amR5WUdtSi90bnd1MFFqMzNuaSs1TkdtWCttbzVYL3Jia0R6MTYvK1dmYU9D?=
 =?utf-8?B?NTcwUlBKOVlQNkw2RVJaVUhYd0hmc0xFWXo3WC9wY2wxdFBERzJqc0czY1VO?=
 =?utf-8?B?aXFiV1krZGZ5ZUlqbWZ0UDl0RWp1T3RnUEpTWmN0SFRqNDdYQjBrOVlYWGl2?=
 =?utf-8?B?N0V5N3psNG1lTzVjZlJ6TEJ6RFRpTmRZZWpKUURRcHhKeFVTaDVsaVNLaWt4?=
 =?utf-8?B?ZU5Pc2E5cjI0Y05RZzFhYnQ1NjExbkdhN3pFTDNhYy8rdno4dEJlWEc4RUta?=
 =?utf-8?Q?5RNCdqJ1ic3ignI7jcNs6nn7u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e510f3f-a284-49f2-2280-08ddf09c45a0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 19:00:13.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n215EtwKMxTJ8i7+Fjoowj7lOeUtM06RiYr1Gn8QcKuP5TBVoTwKBvcvZn1+dtlVbb/P1WQIEaf3nqXtf0nFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331

On Wed, Sep 10, 2025 at 08:35:55PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 10, 2025 at 07:32:12PM +0200, Andrea Righi wrote:
> 
> > [   15.160400] Call Trace:
> > [   15.160706]  dequeue_task_scx+0x14a/0x270
> > [   15.160857]  move_queued_task+0x7d/0x2d0
> > [   15.160952]  affine_move_task+0x6ca/0x700
> > [   15.161210]  __set_cpus_allowed_ptr+0x64/0xa0
> > [   15.161348]  __sched_setaffinity+0x72/0x100
> > [   15.161459]  sched_setaffinity+0x261/0x2f0
> > [   15.161569]  __x64_sys_sched_setaffinity+0x50/0x80
> > [   15.161705]  do_syscall_64+0xbb/0x370
> > [   15.161816]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Are we missing a DEQUEUE_LOCKED in the sched_setaffinity() path?
> 
> Yeah, the affine_move_task->move_queued_task path is messed up. It
> relied on raw_spin_lock_irqsave(&p->pi_lock); rq_lock(rq); being
> equivalent to task_rq_lock(), which is no longer true.
> 
> I fixed a few such sites earlier today but missed this one.
> 
> I'll go untangle it, but probably something for tomorrow, I'm bound to
> make a mess of it now :-)

Sure! I’ll run more tests in the meantime. For now, that's the only issue
I've found. :)

Thanks!
-Andrea

