Return-Path: <cgroups+bounces-10664-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86036BD51B5
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A771F18A4BE1
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271E2797AC;
	Mon, 13 Oct 2025 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmYP3scw"
X-Original-To: cgroups@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150E279DB3;
	Mon, 13 Oct 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373460; cv=fail; b=h/A9fiVxmGUQJJ7ldQ16iIQdsYVIibSdAedVmGe4l0AQpMn2udEDguYj3SJAvWwr+CFusVd0hU8sdogH9MgGwdA4F1jeqUIc/vzqRD4lLVifJcpPzcXiK1/BFYU74p2Xf7xm86qhiR5/9NbnExE9P05c5wCmqrggqlNyLbQp3QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373460; c=relaxed/simple;
	bh=6Trd1FmLjXNVvbwqeK1rr40kJbedpb3fLmun7r3jT7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTIXxLQi/ZEmhPw4PX4tkX6xTXf0f4hAVeQ9AR7H2BxecgmxyXn16tviaqu4COkq2OQweo8g5Dby3y3mL88/y1XAY7uzCIq5Vaqv5v7/XD+yCCRSP21t5dUQGS7n9YTFZJ1G7Uz0Mg7GYizvlvgn3a7zhgcLVGZCbXJxP2O28HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmYP3scw; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbkRU6nXIVpx4l2LvxpS8r2hgrmQqdvINfkUqPUWnNsmvtkw/hOmUCrZLYZNhRFwVxqPolA6RbfV94gu9vrXfjMtJpEQzOnSyiqK7fFwT1YCiCVSF9IHjxyJ73RsC8CA1y8P/5UwtRg8OnYe6y6TD/WrbO16bx5XlhmZt+EjyuGr7XkNBts0kwVODtYWnaNzap2y+yKbxmNHZlbVFqyyx8mLeTmpsiaoj/72idrIT1AbhWdMqws9pqWiPfE40ZtdaUfUE83f39wf9SJ0vuqH8fPPBu+3AXr/lppIhe3enr8tlXIRjGuZAXO6i4q9Fb5PQ+kRtTaOWeHdZw5wrBM8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0zBvNj8oYIfIDI4i6yXlCmmUuLzBe6q2XCS01PHIac=;
 b=MdpfYrePllOgvijbsX/Mz+TkvprSbeSi6L8OmZxfNWFyJPhOCeN32goxC3aarThuIP0/ghzrx4hSQIJB4H6XnY2tie0yGGU8zxZquqG8d+b8pKKdtsFBsNdBWF+63n4uK16ZbK/NK8Yfrtx/nAcgVwLHNBxmc8Xahrl6eMrWIskKeTK/l/mvDFx6LLJRRwc4bcrOIpbVixQrawXmA0nhwpa8NWn2ixO04Jw0ra5gQRleTlfD1L+iRaw7kzW7TvPD2gJ6rj2rk89waJS4GlPvmaalikBWax9/4HeCKHDuB0dtLW/gv9g9/sWubUHF1c8F0dK1qVMxDfr3hxw74j2UBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0zBvNj8oYIfIDI4i6yXlCmmUuLzBe6q2XCS01PHIac=;
 b=DmYP3scwkwmlwnvJ4JvfHitfwMdF2l8VKuJJ1EfuSTsYOJ/Z1hIZ3Ev/WhJLu0yf7504ffimp1chcqgs64jGIXPt06PH184PUuwseYxu1b5p3rGVJvSeCs22dBgUaA0cPxps4SDMbh95blwM0Z7zIZKt/ETRHL+WgCWGvjPhxjJuxmdQx7rQqMvcokd6XiUa5K0oqskpiKC7cEW9WMEnAflLy/Bcg2A6pf5loPWARb2epcB3Da6fIUSWJaRE3rk2V7IDYP53AbefYdJ2tGu1NGEk2DTlT6XuLgZ/faJZMTNgy7HoVquNJsCrv9aRuywVMdPeIk6czJ/u9H7iMwkcFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 16:37:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 16:37:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 0/4] reparent the THP split queue
Date: Mon, 13 Oct 2025 12:37:32 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C3134C16-584F-41D2-88E4-4B94B58C16F2@nvidia.com>
In-Reply-To: <df9a3e22-caca-4298-b7d8-5334ce5446a0@linux.dev>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
 <925E0247-2976-4D85-A8AA-E8C92C64CED4@nvidia.com>
 <df9a3e22-caca-4298-b7d8-5334ce5446a0@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:208:178::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4e6006-67bd-4749-546f-08de0a76d00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uc9Yvt7DiIZ6JRz67DetMOZ98lUDm5pCLI6IUSSGLzpDnajzqHR7hLAqlCH0?=
 =?us-ascii?Q?0Y4jYN2ys8n+WbUNl+W5gdoFnKOGT/ifwdeE8Z4HUfq0zyGSPJjqY2xZNiyS?=
 =?us-ascii?Q?5qmsgLMv/qkHkNvv/JQP6jm0oRWhxnJjrDG0v6YORap/YKpcp6OyD5WbRCq1?=
 =?us-ascii?Q?6qGPhjIMQ2YIDWDuFDKRebN0oYS8cifExcxX6rTD+T5Z0+mAHsgiRXgx3m/3?=
 =?us-ascii?Q?Fq0ghzMv8lNvtHfFBNaMPJ2/As5Ic+h8x+MIqlzKXmnHIuxFC2XwuShDkapm?=
 =?us-ascii?Q?U4OjIOgqaUJWYF4MAiCS/fHWt4nJEMWt/DX8zoAmVjsBYM5vR7ucKpiIxU6Z?=
 =?us-ascii?Q?blZNee+i4lHS1iFF5heA8ttMQ7FuIHIOzAsiYEl7y8oubGOSiXLxRz9kzX1x?=
 =?us-ascii?Q?Sb4KGYaTnvh7LmDuoJSQzDJCCGfuSnr2q/1qrYMSVX15unWbHNDT4ZT/lRdv?=
 =?us-ascii?Q?PZVAxCgX+snafsZ/E85k0LxU4RIgs759lQCpU33VAqgXSRdd4dvdQp2JXcme?=
 =?us-ascii?Q?wcwbQNSbY1Vou48kkGAK5vw6u8fgJdNeT9bNfDDUDiK/nEdrNztjejr+Jye/?=
 =?us-ascii?Q?WtT+tc+aGkSAvN5AhNCR+m1oFqaSMlgGg/5BtknJed9lZAWFw+OeuYAQkYqD?=
 =?us-ascii?Q?9ECNMRtCEVC7Aiv8afIb8hZUl2Xm4r5c0eWdl+61GxwVZYnPbzINlOCoGYNH?=
 =?us-ascii?Q?PjOX1GwCi4PkhSzzrYaNFw+boQNYAO60JT/oIixlE76FlzYrpVDmm7ICXhQs?=
 =?us-ascii?Q?Unzyv0f3WK0liLrNiPVJtD/GS1cmGeGBMcwIjN+SbDwjG9kNkQGI9EpHuubG?=
 =?us-ascii?Q?j9HeglxSrXYzrz8x4oIDpMMlfXlCPmK5MYO0Jl1spoTOY4Jlfk4sLk3d5StE?=
 =?us-ascii?Q?d0wbgdZUOgkr/1HueUIpWSffc9Nzvi7hrJ+bva3XD5Bj14JDx0BW32vrPxdQ?=
 =?us-ascii?Q?WRo+rkgbCR3q0Yloa3sqxPXbQ9I7mRMuBSkIRAP2QCeefpeInlUr7e/awFN5?=
 =?us-ascii?Q?REhOSQppPlKXMlkKN53LWLdoGhJaD41SG7S/F54IotpkALzq2tl7aHnal1X1?=
 =?us-ascii?Q?KLutIaYWmEKVLrl4EYiHPtlt6qYb1stmhl5oNFXbyrAZo+IFSSbAPIPvRJGK?=
 =?us-ascii?Q?BlngntRq0uTvAJFRNJlJZPAiPR3gmAPIApjOYg6vCndJSJB2CJadP9nvCtTm?=
 =?us-ascii?Q?FJxDM5WMSPaqOP5TISjum25sZsXWhHHfOONrNwtlptvDQnEyOQlUc/1moumE?=
 =?us-ascii?Q?+xGxekvlewf8vIU+WWrZZFgJs0IP9igYXaxP8B4W9IuvaZq8SPhL4TKFBC1i?=
 =?us-ascii?Q?U85e8k0aIhiJVBye8t+NCBnPLHVruw1qgKjVBwy7C/UhyTypz+3fI713TSKE?=
 =?us-ascii?Q?ypIVtBC21aFy7MuDr/kq4w6oT7V44F/asE43HTMnqVQd9klrsePrc9Exy7gT?=
 =?us-ascii?Q?sAFdPPUaQRQQNenASN6PaCX/PX7W2Ts5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOiMtXFNgQC3VNdKXEZ42uuJHLwpn1iNEJNNOfpeKNr20tDkpzX1QSLze+X/?=
 =?us-ascii?Q?uomJ2g6J4BCAbjDrupoaXmGFO1MgyzFZbV4jCczGfE31kW+Pn9Mv0ol4QcbR?=
 =?us-ascii?Q?j3WCov7yOUYEasnKlcANaNIlwz/VLn0qow81DplvhHfzKnHRJIo5wAfNByA4?=
 =?us-ascii?Q?NWQUOv5Gv5+Zabu30ZoqQS7undGQj87kh+QArzOx7g5hPBspmabcWp3k6wrM?=
 =?us-ascii?Q?gTv3ZayhLl40FpXMr9JXN8AG3ntR8YCEEkpJIJLTfzJx4pb72jZKxb0/0CoO?=
 =?us-ascii?Q?zsdqUF2UM8KZWbHBWLU9VEa6MiTsgIw5KX+XxR6fLOcoeymJBguozka9qiKh?=
 =?us-ascii?Q?SBNkiF07j6UY4EAQODSywF85mTRjL/WaRMJpsVtl5z7wWOBsoDdc2TmOZPY1?=
 =?us-ascii?Q?2PCxNvCdk6Xk2IAzykfqk8DoU4k+5Uynzz3hiI6Fa5hokDS/Nsp2Wu2S3CTS?=
 =?us-ascii?Q?PZx1ZxHhNIryEoFg6bd/TrssPW3jedl1ZO+mSDMwOU3ZztFy1AmhCHv4zZCC?=
 =?us-ascii?Q?ZVtyjSW87P/lbg5M9gtP/Rfu14YZjPlubdDXUZRr6LBpvJ55KbRfDCvQ8x4+?=
 =?us-ascii?Q?a1a4bNz4kJU50sJoedX4h2sQPK4o2jfn+pbQQn1iJH1MAwtVuCZwHlIf4KuI?=
 =?us-ascii?Q?UD8mqc6sGiz0ME2xSxr6n4qWfepKADx36kj8+CEUTSDqq0ExwEMFwK+DEtQk?=
 =?us-ascii?Q?kfr0czCYVYR4VQf8UEIDMbU8QIRrzdLwwJvcpTZMtBKHNV6aXWo9BRpzHZS7?=
 =?us-ascii?Q?vXsjSYpeQSALglIkMSaijNfkTpuiRnkEURnX45jGzLW3BUHUJ7MAxRtSyena?=
 =?us-ascii?Q?l0+tAzCxthYtCTvRjW1CNTMMwFcA9YEIF4Yi1CpPX+baL3WOM1FFkedgRDO/?=
 =?us-ascii?Q?v11yhwtVatPn17MmGsP8QvC/Ql81YhstDPFiDbedlQ4SCY+9eBcIP/w5zXYz?=
 =?us-ascii?Q?smjFXMUZne+WfdGWq8BM1HJl7a+MdQpvufwMsEZ2CzXrvGXTtBlz7fgHOYct?=
 =?us-ascii?Q?0+nCMmhe6gzMw2THVCMDDsoD5SjXJ1qmFpOAtGDr5MfY8AJWlUmxZ2jNIciH?=
 =?us-ascii?Q?s/xe9EhMS3OsjoKE8EsXMUVaZDBtS7JHVQrCix9biGyf9xm+/9hIeY3hAR5i?=
 =?us-ascii?Q?YwLxZ9LX5reb9AXUoxRKeOsp2Cuzdf5zeLWBmojWg/jvIhE+GF29sl45VYQP?=
 =?us-ascii?Q?NMfghWgfuvbte2MXo+F4oRJ/TaQCK1mWjp9qxxuY4pFEFh2SgHXqWQ8CeI32?=
 =?us-ascii?Q?WkhxnShkLjAFtb84sdN8vXki0gKtUYqKsabx6f4sExoUvve0R9T30hIS4m8K?=
 =?us-ascii?Q?4SJAPIjW3p3mCEC6xjtN+Yl05WBGospGXJ1pBJLRFm6Ioks/N25oSqaBEQ79?=
 =?us-ascii?Q?d1uQzXBb7B9p2VOs/5APD5fgacULR56xOj6NwaBsbRm53mL5KHyjE8hzYjqO?=
 =?us-ascii?Q?NeRRBklcOHYM1YNh8tAbGZ3DfIlCO/zzq9TejEdyYqoGY33BS5bYgGntduRk?=
 =?us-ascii?Q?xMeNpLeD6hwl0w+PI9HAlHYdYc5bclfxxnF78xxSCB8UcuhruB9/Fh9fegb8?=
 =?us-ascii?Q?lOvc9EvVUW5RvaZOJaaZ+RnQmqdcG5EKFq4eXiVO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4e6006-67bd-4749-546f-08de0a76d00b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:37:34.7419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH+Y02bHuGiOCeCyPmMvvlyVP5wxUOTmMDKP/Azc35B8OoIb7R2RF8jaeTyxMyIo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928

On 13 Oct 2025, at 3:23, Qi Zheng wrote:

> Hi Zi,
>
> On 10/11/25 12:25 AM, Zi Yan wrote:
>> On 3 Oct 2025, at 12:53, Qi Zheng wrote:
>
> [snip]
>
>>>
>>
>> Hi Qi,
>>
>> I got CPU soft locks when run "echo 3 | sudo tee /proc/sys/vm/drop_cac=
hes"
>> with today's mm-new on a freshly booted system. Reverting Patch 3 (and=
 Patch 4)
>> of your patchset solves the issue.
>>
>> My config file is attached. My kernel relevant kernel parameters are:
>> "cgroup_no_v1=3Dall transparent_hugepage=3Dalways thp_shmem=3D2M:alway=
s".
>> The machine is a 8GB 8-core x86_64 VM.
>>
>> The kernel log:
>>
>> [   36.441539] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [tee:=
810]
>> [   36.441549] Modules linked in:
>> [   36.441566] CPU: 0 UID: 0 PID: 810 Comm: tee Not tainted 6.17.0-mm-=
everything-2024-01-29-07-19-no-mglru+ #526 PREEMPT(voluntary)
>> [   36.441570] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>> [   36.441574] RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40
>
> It seems that the softlockup is not caused by lock contention. I have
> also seen the following stack locally:
>
> [14819.914867][    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 49s=
! [kswapd0:202]
> [14819.914873][    C2] Modules linked in:
> [14819.914877][    C2] CPU: 2 UID: 0 PID: 202 Comm: kswapd0 Tainted: G =
          L      6.1
> [14819.914880][    C2] Tainted: [L]=3DSOFTLOCKUP
> [14819.914881][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.12.0-1 04
> [14819.914883][    C2] RIP: 0010:folios_put_refs+0x34/0x210
> [14819.914889][    C2] Code: 57 41 56 49 89 fe 41 55 41 54 55 53 48 83 =
ec 18 65 48 8b 05 36 51
> [14819.914891][    C2] RSP: 0000:ffffc900039db8e8 EFLAGS: 00000246
> [14819.914893][    C2] RAX: 0000000000000000 RBX: ffff888109e64330 RCX:=
 ffffffff82848bb8
> [14819.914895][    C2] RDX: 0000000000000001 RSI: 0000000000000000 RDI:=
 ffffc900039db960
> [14819.914896][    C2] RBP: ffff888109e642a0 R08: ffff888100403058 R09:=
 ffff888100402fe8
> [14819.914897][    C2] R10: 0000000000000000 R11: ffffffff82711328 R12:=
 ffff888109e64328
> [14819.914898][    C2] R13: ffffc900039dbb30 R14: ffffc900039db960 R15:=
 ffffc900039dbb30
> [14819.914916][    C2] FS:  0000000000000000(0000) GS:ffff888332ad7000(=
0000) knlGS:00000000000
> [14819.914918][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [14819.914919][    C2] CR2: 00007f8d211b3000 CR3: 000000010833c000 CR4:=
 00000000000006f0
> [14819.914921][    C2] Call Trace:
> [14819.914923][    C2]  <TASK>
> [14819.914927][    C2]  deferred_split_scan+0x30d/0x420
> [14819.914934][    C2]  do_shrink_slab+0x105/0x350
> [14819.914937][    C2]  shrink_slab+0x2fa/0x3f0
> [14819.914939][    C2]  ? try_to_shrink_lruvec+0x1a6/0x270
> [14819.914944][    C2]  shrink_one+0x11d/0x1b0
> [14819.914947][    C2]  shrink_node+0x9a4/0xb90
> [14819.914952][    C2]  balance_pgdat+0x548/0x910
> [14819.914955][    C2]  ? __sched_fork+0x160/0x180
> [14819.914964][    C2]  ? __timer_delete_sync+0x2b/0x40
> [14819.914970][    C2]  kswapd+0x1b9/0x320
> [14819.914973][    C2]  ? __pfx_autoremove_wake_function+0x10/0x10
> [14819.914978][    C2]  ? __pfx_kswapd+0x10/0x10
> [14819.914981][    C2]  kthread+0xfd/0x250
> [14819.914984][    C2]  ? finish_task_switch+0x90/0x270
> [14819.914987][    C2]  ? __pfx_kthread+0x10/0x10
> [14819.914989][    C2]  ? __pfx_kthread+0x10/0x10
> [14819.914991][    C2]  ret_from_fork+0x170/0x190
> [14819.914995][    C2]  ? __pfx_kthread+0x10/0x10
> [14819.914996][    C2]  ret_from_fork_asm+0x1a/0x30
> [14819.915002][    C2]  </TASK>
>
> It seems that the reason is that deferred_split_scan() has been execute=
d
> for too long.
>
> Could you please help test the following changes? I applied them locall=
y
> and no softlockup occurred.
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b5eea2091cdf6..5353c7bd2c9af 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4286,8 +4286,10 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
>         }
>         folios_put(&fbatch);
>
> -       if (sc->nr_to_scan)
> +       if (sc->nr_to_scan) {
> +               cond_resched();
>                 goto retry;
> +       }
>
>         /*
>          * Stop shrinker if we didn't split any page, but the queue is =
empty.
>

It does not fix the issue, but only gets rid of the soft lockup warning.
"echo 3 | sudo tee /proc/sys/vm/drop_caches" just runs forever.

Looking at the original code, sc->nr_to_scan was one of the two condition=
s
on breaking out of split_queue scanning and was never checked again
afterwards. When split_queue size is smaller than nr_to_scan, your code
will retry forever but not the original one. After I added pr_info() to
print sc->nr_to_scan at
1) before retry:,
2) before for (... folio_batch_count();...),
3) before "if (sc->nr_to_scan)",

I see that 1) printed 2, 2) and 3) kept printing 1. It matches my
above guess.

The below patch fixes the issue:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 43a3c499aec0..d38816a0c117 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4415,7 +4415,7 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
 	}
 	folios_put(&fbatch);

-	if (sc->nr_to_scan)
+	if (sc->nr_to_scan && !list_empty(&ds_queue->split_queue))
 		goto retry;

 	/*



>
>> [   36.441592] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 0f 1f 44 00 00 53 48 89 f3 e8 92 68 fd fe 80 e7 02 74 06 fb 0f 1f 44 00=
 00 <65> ff 0d d0 5f 7e 01 74 06 5b c3 cc cc cc cc 0f 1f 44 00 00 5b c3
>> [   36.441594] RSP: 0018:ffffc900029afb60 EFLAGS: 00000202
>> [   36.441598] RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffff88=
8101168670
>> [   36.441601] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff88=
8101168658
>> [   36.441602] RBP: 0000000000000001 R08: ffff88813ba44ec0 R09: 000000=
0000000000
>> [   36.441603] R10: 00000000000001a8 R11: 0000000000000000 R12: ffff88=
81011685e0
>> [   36.441604] R13: 0000000000000000 R14: ffff888101168000 R15: ffffc9=
00029afd60
>> [   36.441606] FS:  00007f7fe3655740(0000) GS:ffff8881b7e5d000(0000) k=
nlGS:0000000000000000
>> [   36.441607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   36.441608] CR2: 0000563d4d439bf0 CR3: 000000010873c006 CR4: 000000=
0000370ef0
>> [   36.441614] Call Trace:
>> [   36.441616]  <TASK>
>> [   36.441619]  deferred_split_scan+0x1e0/0x480
>> [   36.441627]  ? _raw_spin_unlock_irqrestore+0xe/0x40
>> [   36.441630]  ? kvfree_rcu_queue_batch+0x96/0x1c0
>> [   36.441634]  ? do_raw_spin_unlock+0x46/0xd0
>> [   36.441639]  ? kfree_rcu_monitor+0x1da/0x2c0
>> [   36.441641]  ? list_lru_count_one+0x47/0x90
>> [   36.441644]  do_shrink_slab+0x153/0x360
>> [   36.441649]  shrink_slab+0xd3/0x390
>> [   36.441652]  drop_slab+0x7d/0x130
>> [   36.441655]  drop_caches_sysctl_handler+0x98/0xb0
>> [   36.441660]  proc_sys_call_handler+0x1c7/0x2c0
>> [   36.441664]  vfs_write+0x221/0x450
>> [   36.441669]  ksys_write+0x6c/0xe0
>> [   36.441672]  do_syscall_64+0x50/0x200
>> [   36.441675]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   36.441678] RIP: 0033:0x7f7fe36e7687
>> [   36.441685] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 0=
0 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f=
 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
>> [   36.441686] RSP: 002b:00007ffdffcbba10 EFLAGS: 00000202 ORIG_RAX: 0=
000000000000001
>> [   36.441688] RAX: ffffffffffffffda RBX: 00007f7fe3655740 RCX: 00007f=
7fe36e7687
>> [   36.441689] RDX: 0000000000000002 RSI: 00007ffdffcbbbb0 RDI: 000000=
0000000003
>> [   36.441690] RBP: 00007ffdffcbbbb0 R08: 0000000000000000 R09: 000000=
0000000000
>> [   36.441691] R10: 0000000000000000 R11: 0000000000000202 R12: 000000=
0000000002
>> [   36.441692] R13: 0000558d40be64c0 R14: 00007f7fe383de80 R15: 000000=
0000000002
>> [   36.441694]  </TASK>
>> [   64.441531] watchdog: BUG: soft lockup - CPU#0 stuck for 53s! [tee:=
810]
>> [   64.441537] Modules linked in:
>> [   64.441545] CPU: 0 UID: 0 PID: 810 Comm: tee Tainted: G            =
 L      6.17.0-mm-everything-2024-01-29-07-19-no-mglru+ #526 PREEMPT(volu=
ntary)
>> [   64.441548] Tainted: [L]=3DSOFTLOCKUP
>> [   64.441552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>> [   64.441555] RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40
>> [   64.441565] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 0f 1f 44 00 00 53 48 89 f3 e8 92 68 fd fe 80 e7 02 74 06 fb 0f 1f 44 00=
 00 <65> ff 0d d0 5f 7e 01 74 06 5b c3 cc cc cc cc 0f 1f 44 00 00 5b c3
>> [   64.441566] RSP: 0018:ffffc900029afb60 EFLAGS: 00000202
>> [   64.441568] RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffff88=
8101168670
>> [   64.441570] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff88=
8101168658
>> [   64.441571] RBP: 0000000000000001 R08: ffff88813ba44ec0 R09: 000000=
0000000000
>> [   64.441572] R10: 00000000000001a8 R11: 0000000000000000 R12: ffff88=
81011685e0
>> [   64.441573] R13: 0000000000000000 R14: ffff888101168000 R15: ffffc9=
00029afd60
>> [   64.441574] FS:  00007f7fe3655740(0000) GS:ffff8881b7e5d000(0000) k=
nlGS:0000000000000000
>> [   64.441576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   64.441577] CR2: 0000563d4d439bf0 CR3: 000000010873c006 CR4: 000000=
0000370ef0
>> [   64.441581] Call Trace:
>> [   64.441583]  <TASK>
>> [   64.441591]  deferred_split_scan+0x1e0/0x480
>> [   64.441598]  ? _raw_spin_unlock_irqrestore+0xe/0x40
>> [   64.441599]  ? kvfree_rcu_queue_batch+0x96/0x1c0
>> [   64.441603]  ? do_raw_spin_unlock+0x46/0xd0
>> [   64.441607]  ? kfree_rcu_monitor+0x1da/0x2c0
>> [   64.441610]  ? list_lru_count_one+0x47/0x90
>> [   64.441613]  do_shrink_slab+0x153/0x360
>> [   64.441618]  shrink_slab+0xd3/0x390
>> [   64.441621]  drop_slab+0x7d/0x130
>> [   64.441624]  drop_caches_sysctl_handler+0x98/0xb0
>> [   64.441629]  proc_sys_call_handler+0x1c7/0x2c0
>> [   64.441632]  vfs_write+0x221/0x450
>> [   64.441638]  ksys_write+0x6c/0xe0
>> [   64.441641]  do_syscall_64+0x50/0x200
>> [   64.441645]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   64.441648] RIP: 0033:0x7f7fe36e7687
>> [   64.441654] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 0=
0 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f=
 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
>> [   64.441656] RSP: 002b:00007ffdffcbba10 EFLAGS: 00000202 ORIG_RAX: 0=
000000000000001
>> [   64.441658] RAX: ffffffffffffffda RBX: 00007f7fe3655740 RCX: 00007f=
7fe36e7687
>> [   64.441659] RDX: 0000000000000002 RSI: 00007ffdffcbbbb0 RDI: 000000=
0000000003
>> [   64.441660] RBP: 00007ffdffcbbbb0 R08: 0000000000000000 R09: 000000=
0000000000
>> [   64.441661] R10: 0000000000000000 R11: 0000000000000202 R12: 000000=
0000000002
>> [   64.441662] R13: 0000558d40be64c0 R14: 00007f7fe383de80 R15: 000000=
0000000002
>> [   64.441663]  </TASK>
>>
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

