Return-Path: <cgroups+bounces-16397-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKFpHpCSGGoMlQgAu9opvQ
	(envelope-from <cgroups+bounces-16397-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:08:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B185F6E59
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E97E53013611
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063C034250E;
	Thu, 28 May 2026 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gfArPyKF"
X-Original-To: cgroups@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B233469E0;
	Thu, 28 May 2026 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995266; cv=fail; b=F+oFntfaPtYAZEgp20ykzz2T9bLAKiYbwCmUexfERMrG7iEosEq+dsxrDJU6NVP3NU5K6+PjNCNTxZKFgLumKwHklPaL6BKNaEiVLY8EQE4qfYcls2agwgF9dgKYcF5Xyhw8A3irzznzktzYFkHyn64EfbrsXT744RNQ5O0Xlvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995266; c=relaxed/simple;
	bh=JLD5899PYMieoL0ofi3FZItcTpV2uiAwV/W5uqtRc1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XSX6gi/8jKaERrBPGIyhsGzDbCotoQ0oiRGLR7Tfe0eBrfyLoNj2Lchq7kxLOTbn26VqUgVFECqALeqovVcgyYQnLIU0sG/sGlB8/e2jTZSMQVXA3T+moDWAWuvKyIoLj42/doI8Gs3WAnSxu860E4YeYsS0wokamv/P7D0yKN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gfArPyKF; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+ArOZg3W96VZ1K1ygjf6JIZs/vm2LCcV2KbQU78z2wgn3KcxEF7BzWJN9E8w3Tq87TN8VmwfZFFCqeyYX/J+dqTrBCIb4IfnjzUMDl4DN5gP4hAZqhzWPi/OI2ty0R5XoFU+TRN0p1SdZZ7ZGVnKhn7i2IUuQtaV5644ZZxKMWt1cRZ0q7iBWJ3xNABIAu3Ff3QMCHz07AsZbJDQ1UPMsoS7LCUsb7q0wCsQExeQvT5fcsIb9IzS3aFIu2+994reQoljk4JeaU8m7WuuClOsrN6MSPfF0GoFyuBP70kTbV+Itpfg+28I5s7PGNcYy5msY9rrdiLDlXR25arCf3LSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au5A1OF474HJu48oC3lFKncV/ByED27KXTXyPRGkzIY=;
 b=U2xUQe8xeOV0R68SM9fjVWqa3tnEOFfZ1LWwxKPgoeGuRBnIparl9DuedxiJ1WPwahSPKKjCAcC+ucwQu88SYUyIrc+LgAH74G1UINVZBgVGvwQsYFqLcDFLxZmxP3pSki60e3b849rIPVxBKwCzoHja5nWN54motnrJW42t1Tx5njc2TL1GIwUA0WwdMtq+BW3ndkTjAjsscLL7VZ6fkY0mfnwB8CLnXI7wN8ZxJBCcuKzhDCXp5UiQJ373JVaH+rh8GU7BBOw3NJnXOngxItd4ZWRSa3hy+NEYireuitKAhB/bGyV3CedqPL8g63fxkDZaukcQEfTwi4boXyI5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au5A1OF474HJu48oC3lFKncV/ByED27KXTXyPRGkzIY=;
 b=gfArPyKFrm7ajSjwStnCvVgYJbqdEgqvDJfGp/POqzDsXJliEMgv3Ie7ch9h0yAPmkagmG1Kes8eTjuNiwzYNECua+VmV/Nzcs/UyAWfFbIwxYOS0XrYE6kWVRs7D6Ec/IoR2Ih3IPC0aDXAQYww7GrdZWRT/9LPFbs+yEkeDNeUGg2jXTEpqYzUY16GSd9GJ48B9UGb6Winb5cmC72UHRlcQ93ZIoqhir7gofd4dNleEWwzwJmbZG66qFY0RxnsHcBkUv4Y3ByjrANMzq8cWljqJm1y8Jd12pR+JTIWyp44XpaHYeMTneEilfAFMVOv3qO/SaTN8vdnhwQQdFdWVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 19:07:38 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:07:38 +0000
Date: Thu, 28 May 2026 15:07:35 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>, Waiman Long <longman@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] lib/bitmap: divide error in bitmap_fold() when sz argument
 is 0
Message-ID: <ahiSd4NoTdrYs579@yury>
References: <CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1d4a27-56e2-4f30-917d-08debcec6277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|56012099006|11063799006|5023799004|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hiy6QMmwZxkvPJSvTk9x/5hJVHcbkALivhxm1fgXhKhO+PWcPHf4LN7BYs2P8d25JD55oV+W7d0n4pirzD6l9tZPv+U5H1yAPeovJ7/pSw+2u4ZrLPbDC0hWx8QQRCwT7wDujUst4EwR34dj39AIkY6lf/bZpyh3O+kDtVkBY8M/WJ82oyVrM7fuzQRnv85SN3Qwy7N5asbTXLFyG9LMb4UTK5gjOD0WUtwM/tCue/JMcIvxphyB5tgtfOQD2azDZlyzb+braAXDXJRS7SQg8lq4CcA60edWwoWOZ0LzTzXjbp/l/2CRG3OIeR+AYWwFKYi0a2DtGwtB416ZX7Ah+NmKZVYbu8GrzMGkf8YRSR2Tk9ZM16HzvuaMQ/enEnEf6bLH5U3QFDtWhs0ldLcURcPcpj9Ja/OHWm7tUJ8PL4VfDwaKoToFdUd/i342URQ9zaDUzZirGieYF4L7Jk/Z/pN8fzVIu8dMe/k3vApKX99OGHFZz2/ATAZKiuPsejCZowZyYBOLieEkJ0UzrzJ6mwz+0lRTR67Ss0qLL1S7TJEeCdav9q+ICLqTWH8LtfLOuRtBq/zb/zknhaAml6tueI+Zod2W6gHmMU7dt5ugCiaEKNedF41dZ2CeBsTn4nrQrxy4mOpaife2JwTfR50OEKWHjZjZtsOCoE+ktEggrWN/QuUDf+HCpLB04g0rjrGm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ereh0hC8XjS3raHCS1feondMWwtV5D50I7k6U/Ww5EavzyxmOLubbHKbvNKB?=
 =?us-ascii?Q?fL2q9Ry5ITktWBhip3SWcwMsDqvMXvaEDpMlWIXCqwHwNfbPJ6hT1IU+1JLT?=
 =?us-ascii?Q?slGlT+SyK4gp45HVueuRvyMTQnBmetF4rjCn+jfmchm4acyj9IQsae0PeXk0?=
 =?us-ascii?Q?yvPZeKjRkKHyb3E6u9WnrroksNN2QJlx6UJ/BriAn5YLHxkPLPZSSViUHMW4?=
 =?us-ascii?Q?S/POxdudWWKFM9Wsd4nrJu2fOz3vDbFini7NWuJ44sHpX4N9+O4Qcl8FB49X?=
 =?us-ascii?Q?iDlcFxH+EattGfY4CRfCNrf41Omq8KP6SIaDOim2svpv0qPqPUON7seig/9J?=
 =?us-ascii?Q?SyV5/yCJMvU/Y+YPfyHD4WkUCTZJ/9DkgwSK1SPeUYYO+rOV2rH7Ji1wmmE+?=
 =?us-ascii?Q?Zi9VtZtCQuY3cR1HtFF2BRuU8zD4zbA4TX4paJmIM1IysV0GQeLPRGGRpaXA?=
 =?us-ascii?Q?313yvWu8hSp7habAqjhqSYgkYopTqsiSLJxSTwtViBRywL6CUwXq+mGql2rO?=
 =?us-ascii?Q?Bszl8JW+8ZLSpu4xuqz3Gtx+GibKC8/+6VjeusJWdn8bTc37SI3lxr5CnIJB?=
 =?us-ascii?Q?28a/nlx5M5Vbj+MCRcEhZUHPniHQICcdTBXUJFaOAnH2rRkle9m0KV9KNAPl?=
 =?us-ascii?Q?AOweWzc68Uq6NKoWNyNXKzBQdOckD+oa3F4yzYi/XH2fD2lNY/PR8IyhQjRS?=
 =?us-ascii?Q?Q3hWSKUlcqdluZetunCH6iz0AR74MO/VYXNpgpW8mqPCsFGTkF1kbL2evN7/?=
 =?us-ascii?Q?RNT8FKYKGnAzFz1DdLNSfYcOdY80bAF9SinfPq3vYNHHHdpJNL8H9l7m4fyD?=
 =?us-ascii?Q?zj6zg/it1wn+UVKs+VSoLLF7q5RqMgMMYmcfyD7UFiKrYDwMLExEjIrZjxbH?=
 =?us-ascii?Q?iMSVuqYDRcf0z2pUyp65mEhS9f+Bs7xCu9wTyu34br6GUQYxA3tlCfTcknYb?=
 =?us-ascii?Q?+JyIG3Ovn0HP0xVSkTRw5pQ+84+FOgLRBiBE/YkxfsjWcpW65VTm+41ZVmH8?=
 =?us-ascii?Q?kqB7bh+NUuj53vOIpdLoBgguhKT8H+eMP11bGL0WlvESbLDSMrC03zP8Br4q?=
 =?us-ascii?Q?TefWPrddXr2QJ+m3XhbPfGphUoiDwxzHq9TqvoP0DQjfsxeWvDQ4Cm+W3DbT?=
 =?us-ascii?Q?Lfx9sy9ygQ+GoCoyxBJF2NeqdzEtCa23/tyJUhfKJPCj/9shscvHsMGMC4jf?=
 =?us-ascii?Q?mw0J4HvPO/iuQz5ZeA5Z8LtZ3cM72Ybg/DpuICzJXoAblYYe+vterGQTJSVa?=
 =?us-ascii?Q?+KxtpV0SoYRpUJaXKBG4QCJPa68K9fcvMF1L6p95xk3TRbF/RnGUHUgRrECP?=
 =?us-ascii?Q?uylhUMjXWwBsDKfvN1buArpWeRAA34C+i/10+gPLzteX//uB7w14H1lUkrOt?=
 =?us-ascii?Q?kVgoi+weg5/rTj9E/cR/6J0bubPyEOXNQSF2UXu4rvrUiMSLw7CaylGG0PSa?=
 =?us-ascii?Q?faXh8O9XK3neJWzMhuZ3rRPc7dPaYR1kGx6eVe4U/p/zrObkiD8O5yQdV4re?=
 =?us-ascii?Q?agG18sGwbmdeqJ9L9zxgNjsLRn4RKWRmzIOnvLnSt3fupplZ3pajoopR+mLH?=
 =?us-ascii?Q?S/SQslnYv0hV/CHzkzWVaixq1W+oug2n81lRhfn0ZxgQWz8Ps2f7qS/dQwfL?=
 =?us-ascii?Q?mSq/JGzGxQkqt0VDnNuZ8MTXdsWDfn1HDURaH7svVnE2U8SqHPZdWBLaHOkg?=
 =?us-ascii?Q?AQ7yJWiks48W5UJfzHw2R8ROkoSetFZxR2+rYLwAuiGDGU1q3Bs+84N3ey6k?=
 =?us-ascii?Q?Co9VsidTPboBO1jQxVt9LljWrRCG+sVasGWsvhl6OVTYlW+yzk4x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1d4a27-56e2-4f30-917d-08debcec6277
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:07:38.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ld1gwOYl1n6usmXh8/LF7geR9a9omBdkXfD/tcFLEq6p9YjCaGsQhh4U88mO1BIPvK1jZ1dKJKOc4lmDaiduqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,redhat.com,kernel.org,rasmusvillemoes.dk,vger.kernel.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16397-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 38B185F6E59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Farhad,

Thanks for the report. Submitted the fix and added you in CC.

Thanks,
Yury

On Thu, May 28, 2026 at 11:25:36AM -0700, Farhad Alemi wrote:
> Hello,
> 
> I am reporting a divide-by-zero crash in bitmap_fold() found by syzkaller.
> 
> Summary:
> bitmap_fold() at lib/bitmap.c divides by its `sz` parameter without
> guarding sz != 0:
> 
>   void bitmap_fold(unsigned long *dst, const unsigned long *orig,
>                    unsigned int sz, unsigned int nbits)
>   {
>           ...
>           for_each_set_bit(oldbit, orig, nbits)
>                   set_bit(oldbit % sz, dst);
>   }
> 
> The call chain in the observed crash is:
> 
>   mpol_relative_nodemask()   mm/mempolicy.c
>     nodes_fold(tmp, *orig, nodes_weight(*rel))
>   __nodes_fold()              include/linux/nodemask.h
>     bitmap_fold(dstp->bits, origp->bits, sz, nbits)
>   bitmap_fold()               lib/bitmap.c
> 
> When `nodes_weight(*rel)` is 0 (i.e. the relative-nodes mask is empty),
> the `sz` argument passed to bitmap_fold() is 0, and the
> `oldbit % sz` expression executes a divl by zero.
> 
> Observed on:
> - Linux v6.18.32-dirty (where the bug was originally found), x86_64,
>   QEMU Q35
> - KASAN enabled; panic_on_warn set
> - The only local dirty file in my tree is drivers/tty/serial/serial_core.c,
>   containing a local ttyS0 console guard for the fuzzing harness. It is
>   unrelated to lib/bitmap, mm/mempolicy, or kernel/cgroup/cpuset.
> - The crash fires in a cpu-hotplug kernel thread (Comm: cpuhp/1, PID 21)
>   reached via sched_cpu_deactivate -> cpuset_handle_hotplug ->
>   cpuset_update_tasks_nodemask -> mpol_rebind_mm -> mpol_rebind_policy
>   -> mpol_rebind_nodemask -> mpol_relative_nodemask -> __nodes_fold ->
>   bitmap_fold.
> - Source inspection of linus/master at commit e8c2f9fdadee
>   (v7.1-rc4-754-ge8c2f9fdadee) shows the buggy structure is unchanged:
>   bitmap_fold() at lib/bitmap.c:718 still computes `oldbit % sz` with
>   no sz != 0 guard; __nodes_fold() at include/linux/nodemask.h:365
>   still forwards its sz argument; mpol_relative_nodemask() at
>   mm/mempolicy.c:370 still calls nodes_fold(tmp, *orig,
>   nodes_weight(*rel)). I have not re-run a reproducer against
>   e8c2f9fdadee as no standalone reproducer is available yet.
> 
> Impact:
> A divide-by-zero in a cpu-hotplug kernel thread context kills the
> kernel:
> 
>   Oops: divide error: 0000 [#1] SMP KASAN NOPTI
>   CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.18.32-dirty #1 PREEMPT(full)
>   RIP: 0010:bitmap_fold+0x5e/0xb0 lib/bitmap.c:713
> 
> The crash report's code disassembly pins the trapping instruction to
> `divl 0x4(%rsp)` (bytes `f7 74 24 04`) with %edx pre-zeroed by the
> preceding `xor %edx,%edx` -- i.e. a 32-bit unsigned divide by the
> on-stack `sz` value.
> 
> Relevant stack:
> 
>   bitmap_fold+0x5e/0xb0 lib/bitmap.c:713
>   __nodes_fold include/linux/nodemask.h:369 [inline]
>   mpol_relative_nodemask mm/mempolicy.c:372 [inline]
>   mpol_rebind_nodemask+0x1e9/0x2d0 mm/mempolicy.c:508
>   mpol_rebind_policy mm/mempolicy.c:542 [inline]
>   mpol_rebind_mm+0x3ab/0x680 mm/mempolicy.c:569
>   cpuset_update_tasks_nodemask+0x22e/0x340 kernel/cgroup/cpuset.c:2777
>   hotplug_update_tasks kernel/cgroup/cpuset.c:3882 [inline]
>   cpuset_hotplug_update_tasks kernel/cgroup/cpuset.c:3985 [inline]
>   cpuset_handle_hotplug+0xe52/0x1200 kernel/cgroup/cpuset.c:4089
>   cpuset_cpu_inactive kernel/sched/core.c:8377 [inline]
>   sched_cpu_deactivate+0x497/0x600 kernel/sched/core.c:8493
>   cpuhp_invoke_callback+0x44a/0x860 kernel/cpu.c:195
>   cpuhp_thread_fun+0x40f/0x870 kernel/cpu.c:1105
>   smpboot_thread_fn+0x546/0xa50 kernel/smpboot.c:160
>   kthread+0x73e/0x8c0 kernel/kthread.c:432
> 
> Expected behavior:
> Either bitmap_fold() should guard against sz == 0 (return early or
> WARN+return), or the callers in the nodes_fold / mpol_relative_nodemask
> chain should not pass a zero `sz` (e.g. short-circuit the rebind when
> the relative nodemask is empty).
> 
> Reproducer:
> A standalone .syz or C reproducer was not produced for this seed; the
> crash fired during broader cpu/cgroup/mempolicy fuzzing. The console
> report is attached as crash-report.txt.
> 
> Novelty check:
> I searched the syzbot dashboard's upstream open, fixed, stable, and
> invalid (per-subsystem mempolicy/mm/cgroups) namespaces, the Android
> dashboard, and the marc.info linux-mm and linux-kernel archives, for
> "bitmap_fold", "mpol_rebind_nodemask" + "divide error", "__nodes_fold"
> + "BUG"/"Oops", and "cpuset_handle_hotplug" + "BUG". I did not find an
> exact match. The recent Jinjiang Tu series (mainline commit
> 3d702678f57e, "mm/mempolicy: fix mpol_rebind_nodemask() for
> MPOL_F_NUMA_BALANCING") is a sibling fix in the same function but
> addresses wrong-rebind logic under NUMA balancing, not the
> divide-by-zero in bitmap_fold().
> 
> I appreciate your time and consideration, and I'm grateful for your
> work on this subsystem. I'd be glad to test any candidate patches.
> 
> Regards,

> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.18.32-dirty #1 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:bitmap_fold+0x5e/0xb0 lib/bitmap.c:713
> Code: 31 f6 e8 a5 4e 20 fe 41 89 dc 44 89 ea 4c 89 f7 4c 89 e6 e8 84 f2 01 00 49 89 c5 44 39 eb 76 2d e8 f7 fc b9 fd 44 89 e8 31 d2 <f7> 74 24 04 89 d5 89 d0 c1 e8 06 49 8d 3c c7 be 08 00 00 00 e8 39
> RSP: 0018:ffffc9000016f520 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000040 RCX: ffff8881026a0000
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff888126f6f218
> RBP: ffffc9000016f630 R08: ffffc9000016f5a7 R09: 0000000000000000
> R10: ffffc9000016f5a0 R11: fffff5200002deb5 R12: 0000000000000040
> R13: 0000000000000000 R14: ffff888126f6f218 R15: ffffc9000016f5a0
> FS:  0000000000000000(0000) GS:ffff8882abcc4000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcd8c9c6fe8 CR3: 0000000192758000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __nodes_fold include/linux/nodemask.h:369 [inline]
>  mpol_relative_nodemask mm/mempolicy.c:372 [inline]
>  mpol_rebind_nodemask+0x1e9/0x2d0 mm/mempolicy.c:508
>  mpol_rebind_policy mm/mempolicy.c:542 [inline]
>  mpol_rebind_mm+0x3ab/0x680 mm/mempolicy.c:569
>  cpuset_update_tasks_nodemask+0x22e/0x340 kernel/cgroup/cpuset.c:2777
>  hotplug_update_tasks kernel/cgroup/cpuset.c:3882 [inline]
>  cpuset_hotplug_update_tasks kernel/cgroup/cpuset.c:3985 [inline]
>  cpuset_handle_hotplug+0xe52/0x1200 kernel/cgroup/cpuset.c:4089
>  cpuset_cpu_inactive kernel/sched/core.c:8377 [inline]
>  sched_cpu_deactivate+0x497/0x600 kernel/sched/core.c:8493
>  cpuhp_invoke_callback+0x44a/0x860 kernel/cpu.c:195
>  cpuhp_thread_fun+0x40f/0x870 kernel/cpu.c:1105
>  smpboot_thread_fn+0x546/0xa50 kernel/smpboot.c:160
>  kthread+0x73e/0x8c0 kernel/kthread.c:432
>  ret_from_fork+0x4b4/0xa30 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:bitmap_fold+0x5e/0xb0 lib/bitmap.c:713
> Code: 31 f6 e8 a5 4e 20 fe 41 89 dc 44 89 ea 4c 89 f7 4c 89 e6 e8 84 f2 01 00 49 89 c5 44 39 eb 76 2d e8 f7 fc b9 fd 44 89 e8 31 d2 <f7> 74 24 04 89 d5 89 d0 c1 e8 06 49 8d 3c c7 be 08 00 00 00 e8 39
> RSP: 0018:ffffc9000016f520 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000040 RCX: ffff8881026a0000
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff888126f6f218
> RBP: ffffc9000016f630 R08: ffffc9000016f5a7 R09: 0000000000000000
> R10: ffffc9000016f5a0 R11: fffff5200002deb5 R12: 0000000000000040
> R13: 0000000000000000 R14: ffff888126f6f218 R15: ffffc9000016f5a0
> FS:  0000000000000000(0000) GS:ffff8882abcc4000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcd8c9c6fe8 CR3: 0000000192758000 CR4: 0000000000750ef0
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0:	31 f6                	xor    %esi,%esi
>    2:	e8 a5 4e 20 fe       	call   0xfe204eac
>    7:	41 89 dc             	mov    %ebx,%r12d
>    a:	44 89 ea             	mov    %r13d,%edx
>    d:	4c 89 f7             	mov    %r14,%rdi
>   10:	4c 89 e6             	mov    %r12,%rsi
>   13:	e8 84 f2 01 00       	call   0x1f29c
>   18:	49 89 c5             	mov    %rax,%r13
>   1b:	44 39 eb             	cmp    %r13d,%ebx
>   1e:	76 2d                	jbe    0x4d
>   20:	e8 f7 fc b9 fd       	call   0xfdb9fd1c
>   25:	44 89 e8             	mov    %r13d,%eax
>   28:	31 d2                	xor    %edx,%edx
> * 2a:	f7 74 24 04          	divl   0x4(%rsp) <-- trapping instruction
>   2e:	89 d5                	mov    %edx,%ebp
>   30:	89 d0                	mov    %edx,%eax
>   32:	c1 e8 06             	shr    $0x6,%eax
>   35:	49 8d 3c c7          	lea    (%r15,%rax,8),%rdi
>   39:	be 08 00 00 00       	mov    $0x8,%esi
>   3e:	e8                   	.byte 0xe8
>   3f:	39                   	.byte 0x39
> 
> <<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
> 


