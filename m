Return-Path: <cgroups+bounces-16749-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wu0tMBxwJ2r1wgIAu9opvQ
	(envelope-from <cgroups+bounces-16749-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 03:45:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E562B65BBB6
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 03:44:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=JN5YVtUE;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16749-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16749-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DE73011BD4
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 01:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B9634AB14;
	Tue,  9 Jun 2026 01:44:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D2306B31;
	Tue,  9 Jun 2026 01:44:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969494; cv=fail; b=I53KTmu98W/QNcHaFnyzgbWt+jEiNLkwARy0w7n0QUl1q8n7baCmHLG/6VIpke1FOSNFrhd0F4gBdTbAN/nTpSXgjxyeTNdF87K1456L78U5+iFuBdzrZpmeCd6UZamzw6f7j5s6O8I7++iZDwv1L41uYj4Hsiv9uJ7fBdfp3Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969494; c=relaxed/simple;
	bh=Xu7Ss53AJGb3vSwpuq33ug7Em6iWGtz08ABPdml6GBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kmen1ctF2Z2Lh0u6da+dRf8ViUGwGNt8A4XJ4VsJq2Mw4py2YJcSz6lpkqIDRK7Hv9PfpOQq8t0DT3INd/ftk3NvVDMUhJpzd7QIfw+d8qunuaDSqVqw7c3tUA/qOMuhtAFGMhg8zLjAieMuTcOizRdsHm6jcmKmdOxELPlUdpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JN5YVtUE; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDYb3Yv/cBlaSR2qSBPEWv0TQOd1xajsbjuqMeIYVPOVZJqjfedjpzYOVjeYJ2cufimyWPeMcafocnDyg/CVn6TYJq33ZqU5ngJKqN2MdlUN6l44hNNnvilKYiKaKgmqHf2Y0pIdUBxRxS6pR3DrbLnte41Ja36jDJdhSMfDseSvNSmViIvQ3SX+3HDIdWNQUjG1PSLRSQd67b2341S4XcyofgrhxntbUDYffAPKrSCmNzCAst9P1xxTvbnViHmo0P9exdVQuKZIwHN9RV33l5BKXOOxMX74VFolBIgIP9a79Y/4YhcXLocn3RW+HSLyihJW1MM+3/zEGRVpzWEMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCsCVwycKyOWOO4nIEhUh0UmGOrLFCsTQvGHRGgT+t0=;
 b=GyM+kXHWusUdcV074DC/qGnHZI/YKbj5I7fZdMJPs8XwiRAKyicndvm+zXvDt91fCYRz7bYbkn7I4n2DYCKUnsXelLs7f0WLsfh7TetsFdwypH9X15Xs3v/aWk3q4Scir/loh2vnQWQSBJO6Jqlx26mDBPFBZcmnfteOQc8qlsbl6bY+05X92NHEFA6+t0p0aTBjhKO25nI88eJEVVx82IfazSJMiLYm6vOpBfT/SNYGwxzEUAS9ZLY8UNo4Q6MeupmFEI9iSkvKuyTb0VKKcldbI1vM8E09Ho8Dk20uMUF5qvUUgw2zqSVHXEeOCJwgC9NVqsqTPj/PmDYLsVDypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCsCVwycKyOWOO4nIEhUh0UmGOrLFCsTQvGHRGgT+t0=;
 b=JN5YVtUEI7DC/WjIKvtgkFbJqU5WTXQwfPfU3j587tPdLDrxyysQKIFJO8coch71fgcL6/lvMlHMvZRZilkWvYiooVbamcJ933GlWb68eAnlPw/veuvEZcsV/wwECgTi6fxhyqVWNoAaliqyK+RTCVQN4GZ9ZVXAVETCmZMKvbut/EkvirgV6zyTBubrHKZxlQZRLNHXp2M0xQdGOvINSpbEAxcdOwGi3SMY0tU1VmljAp0CUcrPzxXPGouP/MdZpfH0sTgqd2+Sk723WLeynyXGNH/a4/vaBINy+2VRuB+U9ECuFm8jQFsZCHVQXz21TdeA9PSlX/FsregG+ZH/UQ==
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 01:44:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 01:44:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 kernel-team@meta.com, longman@redhat.com, chenridong@huaweicloud.com,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, rientjes@google.com,
 chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 baoquan.he@linux.dev, youngjun.park@lge.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com
Subject: Re: [PATCH] mm: constify oom_control, scan_control, and alloc_context
 nodemask
Date: Mon, 08 Jun 2026 21:44:42 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <8C4E5377-F5CF-458E-BA49-3D962CB75477@nvidia.com>
In-Reply-To: <20260609002919.3967782-1-gourry@gourry.net>
References: <20260609002919.3967782-1-gourry@gourry.net>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0279.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0b462c-b443-439e-2e9d-08dec5c8af3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X2O2Ra1NdE88w8XxK+jT1Ctm3GN+QPdtBDFuGReHukYMT/MUpCNOLw+gNJScVaifdzcEEegK0pvQ+qKbCyXspPgoQsL+nSFjCFDvuwShlLw73zW8YpJ0uhI3bMBR1UsuTcDEihnFW1h0gqV663VKzSw5e62MaVJZqoIdKZzKl+ISnvqq/Db5JAQ4uH0FIB0iBe/jzk+vULR5DW8Hg+i/K8KboaERrPJcFv23B2+tr2lHshiy7ZQ1IhulbYcExd7QAzMdvblfc6mp0MYkgPNzao+mbG70YLiXEQ/sFmKYHWWG2w7gyOMxULVFYY1vK1TFC5LX5Yh04wYk4nbZWWTuLRXPayBMLz0IUqjqyJoCdkiFzeMDMIcze3ppZ04g1U4hhA9fyR8Fw+wUpwh/4qfne/HSjUCsh7fhxIdy6gqBaTo1KpdLHPmWi64DItpTXruCL9PPi7ia5PfQrU1QLDSmwati0Kdx2Jhh+12pRP5i11xHvfZvSsw+5trH0kY9pQnlxuVkD4HbNfL8tKTRKwlTWwFqGj1WepmOCTLDsqIaTAbQ00WRBoHZY+uU4FgTtvJeLB1nnu5PZ/sP1PS2NeKy1GbCdu7694wL+Dsp4lhi1ByldFZkQ5wa9ggbtC98sw1Rn2lgEJNIMi4s5F9c5mL/unfS/ELCzZk9Y2Fx+RYyDwoxs3fMQGLcAPNsXtfWBipP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BE0wPIPA7W8b6ch+M65X5xgqQcNEYbSuA1A2Aef96sKd56PYgnBQEmPOMs8Z?=
 =?us-ascii?Q?AHFZkNsob9WiCbHMzOi/srpPJmpj37P2rzgiEUWqfGBwunf25gdt7qeDvBPf?=
 =?us-ascii?Q?CjbLid04vmdJ63MipC59LGDCXlCKPmtFm1ByhqWcqF3KFY15mBZgK/q0Ay0q?=
 =?us-ascii?Q?+DvJsvnQgHcmckgDjX2NikO9foFheHbzf3ehXl9DRxnigvvSwm/756OoX4MV?=
 =?us-ascii?Q?qOsruKK6bz9nXBj9MKXQZOgk7UNe1xZKpB8rOZSpdEd5bXxUmfyelcCxLXCT?=
 =?us-ascii?Q?EFCXAEjevHjPXOy/HI70iMpyCEfFKH7WsDTnE55oqVselg2B+AdLnKA0oPO/?=
 =?us-ascii?Q?w462kX0zm+fe0PN7J2Tm0+HFOnsVy7gVDeTP/MuHTwh+WisGwc8B5/QUMuq7?=
 =?us-ascii?Q?6kaB5H5g/xZrjOxAQsLlyUzNnHJqr/ispsZERyuXqdmq6fsiG277+TX+kkUr?=
 =?us-ascii?Q?ldLrE1qNRXhzU7glw8UgoEU/eQ3xRgpU1L83UXDh1SSZn81YgelbDf09ifAy?=
 =?us-ascii?Q?tobyJrFEyoCSsWwcwMOGeX0NgKBronuyjZZ3i6HFxBdIsuafaPj9PgRRdOAB?=
 =?us-ascii?Q?Dsu7CgF0OVLvMq8i9kvY2MbHtirmPZ1WDAFctkHmuJbRiZdv292XdSO1rMFa?=
 =?us-ascii?Q?i1F1/tpy2r/k8l0Np/uSmeV5xpnjK45Y+n6vZwbDP18u7EJa26T5dQZG4qIa?=
 =?us-ascii?Q?2qpMdibbIk8K8M6zSgPy1wKvgPeMtT/h1dNUxmUL8j20E9BVwp3XOFPzyEe2?=
 =?us-ascii?Q?yIVhodY/5RfS76c+ksU2IH58lhHVcvYmbI1MX3ew9f9SlE23eLoh7qi4Ip9d?=
 =?us-ascii?Q?2sB/+XrJl/mqLOFKkbdNsH06cl5aix/3aPdpqXwPvnWLjufJ+ASHKnTUYFxV?=
 =?us-ascii?Q?YJouCVBic4rxJC+m7NaLyNY3Jc4et08egsX37LKRfSSxULRhhgfxjoMpbR7P?=
 =?us-ascii?Q?oPC5Cjs544EZyF9sTkBhs8cjkkmmuWdpZ2QYNWkxJ+QaBVyuDFYJBOLGxxtf?=
 =?us-ascii?Q?tMxPnLe5bIZu1C0REs6k5BC2xzGB9t98Qbu32aDf58p6exFpsCierjNKIPW4?=
 =?us-ascii?Q?O6eW2GA7hzm7yuMkO/S3mKlHCjVhNr1Yc6jDhgxhdaHYjPeC2PPPzbC3oKyN?=
 =?us-ascii?Q?pwQ316wE8CQZD9DkaNqr8ea8lwToLmmh7oD3C4iMRiAftuqAG8SPx85k6lBx?=
 =?us-ascii?Q?ociCjOVTOtWwukiQxs5Pq6tqWW3QdefMocJypBIdUQ7yHXV499AuUquzhVOi?=
 =?us-ascii?Q?EWOeWcepgTmq8mUBjdwvv5mQV4qx4NIxC244+LEuyXKtOoJ8lyW6YgpmKsm5?=
 =?us-ascii?Q?ZWbUr02nfB6MWtGLgFUO2VGo1tpjixCbUAnQWigPT+rHYwNZNGD7tfBzzfrC?=
 =?us-ascii?Q?Wc86ergAvq5fedjGEPesd6jZmELrcq4FGuf6GI6tEI60ppCfP54CBv+mys+x?=
 =?us-ascii?Q?3b0gswtCNmb8IQ9O5/CRzkcgfKdJH6YJnISOQmt5jZ9PmfU+j1eV9upzXI9F?=
 =?us-ascii?Q?F8nvtUYbzzGRoY133ig60rKg0Uypeq5iA/00WAII8a0TTSc+/naG5mwxwdA/?=
 =?us-ascii?Q?rvnUe8ozWLP9uaPJk+pwTsvKhRsnTRZ5v3eUSTFhgugAFWgMdjY91rhOUUec?=
 =?us-ascii?Q?40HCr+hCqCY2EjCfEQSESpZqediqKghVYQrzQSxmnILnvmnrTutYSV2T3J84?=
 =?us-ascii?Q?5zk2h3E5+9ULKSpvkKu37w+vjTqihUbljJqdFcBZJCGuwDlv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0b462c-b443-439e-2e9d-08dec5c8af3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 01:44:45.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1Va6ej2yxcT6uq+5GeKkdNt9aVontAKJSw7aPub+jUjN3qfeLZVh4xWqB06gH+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-16749-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:kernel-team@meta.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:rientjes@google.com,m:chrisl@kernel.org,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,meta.com,redhat.com,huaweicloud.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E562B65BBB6

On 8 Jun 2026, at 20:29, Gregory Price wrote:

> The nodemasks in these structures may come from a variety of sources,
> including tasks and cpusets - and should never be modified by any code
> when being passed around inside another context.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  include/linux/cpuset.h | 4 ++--
>  include/linux/mm.h     | 4 ++--
>  include/linux/mmzone.h | 6 +++---
>  include/linux/oom.h    | 2 +-
>  include/linux/swap.h   | 2 +-
>  kernel/cgroup/cpuset.c | 2 +-
>  mm/internal.h          | 2 +-
>  mm/mmzone.c            | 5 +++--
>  mm/page_alloc.c        | 6 +++---
>  mm/show_mem.c          | 9 ++++++---
>  mm/vmscan.c            | 6 +++---
>  11 files changed, 26 insertions(+), 22 deletions(-)
>

LGTM and it compiles. As long as Sashiko does not complain, feel free to
add:

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

