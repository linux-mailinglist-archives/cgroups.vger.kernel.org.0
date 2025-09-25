Return-Path: <cgroups+bounces-10460-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A4BA1439
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E28E3AB3BF
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB231E88B;
	Thu, 25 Sep 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQe70E/a"
X-Original-To: cgroups@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418931E115;
	Thu, 25 Sep 2025 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829802; cv=fail; b=FRh79PeETUgJD4R79G7fiTnLt0ZAxGUecPScfHRv00V8IqjHganDnz+V4Kx8Mo6qQmcXl9MQMOqmm1/zaasVWuIFdQfsHHWkSOMLbmKIVS5JXXnOuKKOzbhnlczoXZeZOIDS6Nv97ILNw9s8MIVt/9MmDGCzz32zn9wlCFnlpjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829802; c=relaxed/simple;
	bh=SdqK+OLaDedAstMYj0nrH5unxZeMysDJr5UcXQlTsq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oaYPxrxP4U0RkF1KCSswOAjJtLw5jQfHEH0tPu/DARg7ot1Q1ub+kNdquWQJwtGQwPyd/rz2I6dcmn8Is6ANlGaxTa97NfYeDO3M2iahR5/m0+iHXWEcBzXzbvY4ZUAKJ/dGMVI44rX1x1g8i3/AEqG+OYaInu0TbYAkji/clJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQe70E/a; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVqnbP3oIwAeN29JivNKuNQTUoiAzDnNWt5TBzkY0aqdFC2uoQZ/bU1rJy1+gP4pSOrmoH5CHu+OjLWNjAYvntdjEhRJZP5gNYNRor5/+XbmKXMRNcQr73shYFV3MUVSGSx0JuGkCGOHlS6VGK90bqMtTUHeMi79V3CuNrxBSlvTo3gzcu79YPb3t+N0/RGY0qiRIHXco3FCJNJM0Z1k9Bk1rbzn792MsnN2cYQpoSmgNP8SUkjnZ6YeIZGi42KwcvA7erHBGPDszFMZjZa1OjI7dshGM1zALgTYo3rZxg3tIjncP1MGH76hSGpVjEZFN858V1ZktHOlev6RocJe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLTgUnF1rWLdehCDF1/phtnQJofvB7emxKJnrtSpjeA=;
 b=nqvvW9v7XgX1hJT2jEd5UG4xDJRnIm55ro7ousPYPv6bZeEuFAkJBIsSI4Q2vBdSszK+UANcFdPtGttlMF/3FhIA75ZlkGHAzObj21V1Uvb8XenP5mF5r4dHPNkn3zUk1QldKkz1N4DnBK/t9QPqcwIpuZi5civvIhTl9DRGiErw9BhB6ybKP5ijkU0gLxb9VaZJBCrn/nBdDOeFlMCj6kSnw/OsFQRlbFAl1uqvUP0TPGEfeDjY72mbw2wPcoRSrPFErfse0eF1J4p/bMAqfgl/BV61Qv+Fm/MJGHXmi+6u1hfWX6k22ZxhAcu90QvZOtqu8egaSbA+M4mROoxUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLTgUnF1rWLdehCDF1/phtnQJofvB7emxKJnrtSpjeA=;
 b=PQe70E/a3spNy9oRRkhDbRY1jmnxoP13eblHi++We9UTfi/1Li6oEXmtaYQW6qF9mOkJd9QF9r+hFM93x/ZbFVyVQ5MR0ONp3EsAAPQwWeFmY8ext1zHQFu3orun1vqAKz4ZndM2gBIf9n9QDJmbASgrHjpOHhfu0YnuIu2B6kFUnlnxiPuI2xpMf9964LapM40VK+Lk7/pvvwMA/1UFAbG7nn7k5Oc9vdtVLATAi3dIN5TJezbqvJAfjPpr3lIh50yNTANkgrOaeylNw339+MTe4hwL/5nFC+ZjoyGibV9b+1sdyk9VvRG5w+9xZULGAUph3NDQ5UAeIDB+CKI9XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Thu, 25 Sep 2025 19:49:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 19:49:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 harry.yoo@oracle.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
Date: Thu, 25 Sep 2025 15:49:52 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <BF7CAAA2-E42B-4D90-8E35-C5936596D4EB@nvidia.com>
In-Reply-To: <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
 <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
 <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:408:141::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 640252b7-4ab4-46c0-585d-08ddfc6cb3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3V3bTJ5VUp1WjRRMHVhb2VadzBuNWdNdEV5RGRQcjVjZHI5blVXYnorQy9Q?=
 =?utf-8?B?dEF3ZUVkWFI3czhvREYvNmhxSGJKc2ZXRmUvZHplZkdLOHc4NEFLRno1N3NR?=
 =?utf-8?B?Rk14akhjR1BEa1crQVRpdTAxN3c1SGJyTGs0OVZlTVFzMDQxQzF5cnB4b2c4?=
 =?utf-8?B?aWlZRG5rV2NpTVlud2tHUm83MFJ6RlZOUXBYUEdiRzZQZklFK0JGYnJhcnRM?=
 =?utf-8?B?MHN6ZFJjM3Q5aUI0UGtMZXU0RFdobGRVQUlFRi9zTk1BMTFINzlGSGxCdHFK?=
 =?utf-8?B?VXQvWTE4QkhaTnN2ZWJVRkV5WlduazZWcHljM3VuUGFzS3drb09uQWJyeDZy?=
 =?utf-8?B?cTJ2WjlLMWc2bW15cVpGbXR1MHRZczhxS041WEJ0TzhqZEtHU0xmYkFOWGZn?=
 =?utf-8?B?VElTSDZtN1gzNjdNeWs4ZzJGSS9FSTlDZ1J4eks2V090OFg2ZWhuVWFFQ1VZ?=
 =?utf-8?B?Q3hudTZsVmowYUU5RW13TndoRmdmUWNtZmJBWEJEb09yV05DdWwzRmVBZGc2?=
 =?utf-8?B?R1BDWTZQZDBzM2VRY3dCVGpMdDBPZFhNZGU0YVBqM28rSnhHNzhyV0luV09u?=
 =?utf-8?B?ZVU4TUpJVHRZaXlHNk0rZlp4UVUrWnpRMFdjZ25nSDVqQXhOU2wrMG0va29T?=
 =?utf-8?B?NEhqckgxcjFvTXc3ZVBWSWVxMG01eHFYdm1FcGJUN3dXdVhMYy9LMisyQzdU?=
 =?utf-8?B?VURvazAxU3NUQ3lHZHAvcXdoZlU5aU8xeUpYTHFsUFYvZGtEZEpseThzWG5H?=
 =?utf-8?B?U2MyRGkwV2NEZlFIRWVwSkowQ05mdnNVOE9lNG5jS2FNN0N5S2QwbGVXOWJu?=
 =?utf-8?B?VGlrTnA5UktxNjZCODQ1b0JLMWQ3aFo0dzRNUnNaenRZWTJQSHdWcXRFSGQv?=
 =?utf-8?B?Q2M2NVZENTVXNCtZSDlkWkp1L0pSZ09wVlBCZGN4M0ZBN0I4Y20rSjVESWpJ?=
 =?utf-8?B?N1hDbFB3Y2JDRU80cU5Fd25RSjhRRVRkU2VpYkgyZEJPT3R3M3lUc0pzdTlP?=
 =?utf-8?B?dW5XbVA3eXNKRU56dnJOWUcxNkRpMk9BK1FTQXk3NGd5R2RWU2pKWjBYRDZX?=
 =?utf-8?B?Yzg0dUlyRSsybVVOQUtWTW9yRnRWbnBSNTlrb001dk5QODhUMHd2U2MyOGRx?=
 =?utf-8?B?NU95MmRNd01jekJCaGc0NmM3dG1OdUdpUEc3NzBtSFJzVHlBczd3Sko0cDg4?=
 =?utf-8?B?U1BNSzdGVnk3c2ZENnJTaHdqcEZDZG92YkFGNml5NUJ4WHVQR0VTMXVsMis2?=
 =?utf-8?B?ZUN6Z0F0MkhzNkFjb2FxcmRrcEtFemhjcW92YjYxREY2V3JOVG4xa1NVdVU0?=
 =?utf-8?B?bjcvcnBYUWFTenZWV2JBMVZLRnoxaEd4ZzNOQlZkQVlObUM0aGdlRzVPd1Ix?=
 =?utf-8?B?RkNjRGsydXBvVld1N1FzOFFHZ1AzTE95aHljdlhoMy9nMzdsUE1ubEFzY0NQ?=
 =?utf-8?B?OElUcUtHTkY2aWRRbGxDL3JHdUU1VGw0RUpyMHRIZXZnUDhOWnVqaVROUzBJ?=
 =?utf-8?B?RW0rS3A1TUFEb0NVSXVkTkQ0Wmc1T1dSNThNTjVkaXE4b29xckhlVDJoOXpT?=
 =?utf-8?B?cVNxdlhYWEZYandVMXdkNXRNWVJ3OC9vdHZQYTlVS25SdVgvTU56MWdJM3hF?=
 =?utf-8?B?R1lTVFQrUGhWeGRCT2xkb3NsUkpLc1BxS0xsWGlJanUxUU5PbHAxWThOaktY?=
 =?utf-8?B?V3VFTWFQM3dDUncxUWkxR1krdyt0bnBqNHplS0EwcVBlalRIenJ6M09QK0kr?=
 =?utf-8?B?UlFrZ1lzWnFuY2lSejYyRHJETEVWalVmLzZwUHlVNjExWWtGbktwalU4aEVT?=
 =?utf-8?B?b3RFbTRVOHQzdVlqSlJGZ3JWMlcvMUNCNmh0WUlua1Y1WEVEaGVzU2NnSERr?=
 =?utf-8?B?cHZGRmQ3R1psajBVcWFJUENVc3I0Q1h6NU4zWVRNSEpKeXo4VGx6VzJ0R0hz?=
 =?utf-8?Q?PXMpsMj6x4OEP2Uluynf0Yj/wbJL/Lq5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K291cGFBc3lES3NUQkgxcFV5SFpMdmhiUmxPbHJtSnYxOVYrdWFkZ21raVpE?=
 =?utf-8?B?TlpnbHpHeldQeHhoZ29URVdtbm9GTlQxQVJlc0hia2JBOElBajJpcWtyWW9j?=
 =?utf-8?B?YUw3c0RMWmFkNytoU0hkeU1pUDNjTGxHNUJpQUtPTFlFUVJlY2lUMXcvQkIv?=
 =?utf-8?B?QUlTQnVVUkw4Z0k0MnlhaURDQWJOdk1TTE0vS2FhMzAvZTdRMElxOUlPY2Fh?=
 =?utf-8?B?L2ZkekltYU1Za25JNldqZzFiakJndU1WbWFwSWg2cU1hNVY4WDJZTEo3ZGQr?=
 =?utf-8?B?TUE2SU9LNTJxVFk5RE45dDk4RTVtdW8wSnBUKzhsNFJ1NHhmMTVxc2o0b0Fu?=
 =?utf-8?B?T1QrallxNkN2K1FvVm5ZNVhqdENLaE11Q0tIZjFmMDhIazB6RWZWR1VCUE9H?=
 =?utf-8?B?MGJhenhlY2tJOXRFTjhqdWRuVVJrZDFybWo3MWxvcUJiYUNzWnpCSUZIRWoy?=
 =?utf-8?B?Zmg3SE5mUmI3K1lsSDkyTzRVeGZlYm1ORXVuQnFRd2M3ZWszTFl5OGpENURa?=
 =?utf-8?B?UGNwRElMelpVNDhFRXpoMjFZVUNNNTJqbkxvU1ZwYSt0RzhRMUsxSWlNTE5k?=
 =?utf-8?B?Zk5Bd3Nrc3Rvb2dMbWNwZ1dmK0Nha3ZJK2k0ZnE3bWtMMXRTQStsVGVTZVE3?=
 =?utf-8?B?bTB3cWd1V1ZjMHVlemNHeDRFM0pSWk1YdXl5R3N1U3RZVzJjenFDem10dVdN?=
 =?utf-8?B?SjNFQnYyM2liMXliV09xSEhyeFF5bDl3dkQ3bEc0MGNocU1NM1huZmJkYit5?=
 =?utf-8?B?akhVTC94a3lZdnoxSG9BZEVGRGVpbHhTL2QwOXZ0dG94bHJEQ0t5MmU1bk1K?=
 =?utf-8?B?ZTB1eTMyUEtZZkdCRlQxdDdXVU5SWHJIbmxDZCs0KytaKzFwQzg0emFlb0Rr?=
 =?utf-8?B?K29QQzZ3b0h0am9kR2oxa0JjcWNjRmhBV1hSODAvUU1BT0ZPeFFGQm95cUhu?=
 =?utf-8?B?UDZkaGNRY0NOY0dKQXhXeC8yZjhvMGM5aWhhR3c2akV3Vm1SaE1IVjUrVld2?=
 =?utf-8?B?MU5rOE0ySFJnaStYSTgxVDUzY09qdjRBNThKWElrbnhIc3Nha1BxTjFGMmg2?=
 =?utf-8?B?YnR0VXBLZXFaSmFadDRIdUoyamNRQjdpZDFONUxScGtsYVB4Q3J3eTlPZHdR?=
 =?utf-8?B?N3Z1RzZmUXIwNjhLNXR1V3h5a210R1BYbkluUWNwNXZoZGZsZHVkandvSVZn?=
 =?utf-8?B?OVQ4Q1pWMFI4Wk5adDNMRG9ybVp5YkwrRmR4RHM4K3lmenIwSHB4cU9pV2Rr?=
 =?utf-8?B?MDF2SktOK01CRHRoRnpteUNpeVNKanNHU1ZuUnovbGRSRG1jWWE4Vi9PcFd0?=
 =?utf-8?B?YmdpSTNGbGJBTWhVY1BzRVlRVWM3K2tYRWdPalBVNGwzZW5LOFg0MVZuUG9t?=
 =?utf-8?B?dm8vRkZqTGVuanhQN3hzREtzcEVUNXUybXMwYWlzankxZUVONGd4WE9nZlRO?=
 =?utf-8?B?akdNeDdndThqTjVUMDI4WGhEWUsvQnpxbzg4TGRDbmE0YzRjcjRXVmcrVTdW?=
 =?utf-8?B?ZzV1RWh6Qlc2S21aaDVKaHVFLzFJb3BidmkwQURYaXFYaDJ0V0xyMmZBNnlT?=
 =?utf-8?B?TXBQS2RKNXpmRjNtOGRnaXhNOU5HaHNuMGZ1M0NKTmlpRHBtMkU5VUJieDF3?=
 =?utf-8?B?RTdvVU9ka2ZUbXRlaGNRbFo0VU9iTnUyUjMxcWc1eWJtZUprVmh5Uzlab2g3?=
 =?utf-8?B?d0s1elgvWjNGc0hhUEJ1Tnc3MHlESm85UUFIc01IQndrMEw1YjVXSGlDRTd0?=
 =?utf-8?B?c3ljbVdwWEx2SnBSek9OVkpDdWI2a0pMc3RFRS9mM3ptR25BWTNYUnptY3cz?=
 =?utf-8?B?d3RqYk9IOGZhcVBRL2lGeFp6QWpveGtoMGFPZFdhaDZYWHBqMGFLbzV3bjFW?=
 =?utf-8?B?NzhjbGZZc2xJZUdkd3Vwd29uR3NqeWdjL1pGSlZsSnBYN2k5QlB3VEpIK3Jl?=
 =?utf-8?B?cEVQbzdvR2RoWnA0MnJ2MzVQMHZGK09RWGlqVXgrMlAveUhTbDQrSFcwQzNN?=
 =?utf-8?B?Rk5LcUpCcGZqTndUdEZKZkczZVNCZHRRNHQybk9NMVVlbk96U1NUTW5HZ09i?=
 =?utf-8?B?YWVFeFMzbUlNdnJ6N1l2aFhBU1BOZ0R4Y1oxVGJMWUlhNHR6Z0lLLzY4WTZh?=
 =?utf-8?Q?dPvWsmi9Uk23BcQ1Dmrd1YGKf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640252b7-4ab4-46c0-585d-08ddfc6cb3d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:49:56.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs5kfJFBGMZZxiWZqiu0G90EALDpi2IEt8Y28YmyE1j9qXSkknhI75NRS5SWzm/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307

On 25 Sep 2025, at 15:35, David Hildenbrand wrote:

> On 25.09.25 08:11, Qi Zheng wrote:
>> Hi David,
>
> Hi :)
>
> [...]
>
>>>> +++ b/include/linux/mmzone.h
>>>> @@ -1346,6 +1346,7 @@ struct deferred_split {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t split_queue_lock;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head split_queue;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long split_queue_len;
>>>> +=C2=A0=C2=A0=C2=A0 bool is_dying;
>>>
>>> It's a bit weird to query whether the "struct deferred_split" is dying.
>>> Shouldn't this be a memcg property? (and in particular, not exist for
>>
>> There is indeed a CSS_DYING flag. But we must modify 'is_dying' under
>> the protection of the split_queue_lock, otherwise the folio may be added
>> back to the deferred_split of child memcg.
>
> Is there no way to reuse the existing mechanisms, and find a way to have =
the shrinker / queue locking sync against that?
>
> There is also the offline_css() function where we clear CSS_ONLINE. But i=
t happens after calling ss->css_offline(css);

I see CSS_DYING will be set by kill_css() before offline_css() is called.
Probably the code can check CSS_DYING instead.

>
> Being able to query "is the memcg going offline" and having a way to sync=
 against that would be probably cleanest.

So basically, something like:
1. at folio_split_queue_lock*() time, get folio=E2=80=99s memcg or
   its parent memcg until there is no CSS_DYING set or CSS_ONLINE is set.
2. return the associated deferred_split_queue.

>
> I'll let all the memcg people comment on how that could be done best.
>
>>
>>> the pglist_data part where it might not make sense at all?).
>>
>> Maybe:
>>
>> #ifdef CONFIG_MEMCG
>>       bool is_dying;
>> #endif
>>
>
> Still doesn't quite look like it would belong here :(
>
> Also, is "dying" really the right terminology? It's more like "going offl=
ine"?
>
> But then, the queue is not going offline, the memcg is ...
>
> --=20
> Cheers
>
> David / dhildenb


Best Regards,
Yan, Zi

