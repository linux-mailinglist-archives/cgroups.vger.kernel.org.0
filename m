Return-Path: <cgroups+bounces-17653-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rELvEBAwUWonAgMAu9opvQ
	(envelope-from <cgroups+bounces-17653-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 19:46:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5551773D1A0
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 19:46:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=oMc2V4Ug;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17653-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17653-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8710F3008FDC
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E620F3749E5;
	Fri, 10 Jul 2026 17:46:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A392E413;
	Fri, 10 Jul 2026 17:46:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705608; cv=fail; b=W8NmlLW5cXfCrDdNQf21BA9t09W6iv1d4rnnKVXAYSoPn2LFnU4gQlQSpvcvA51XWPV/KspH+/ciYLh38GzdXzzovX4czo4Si8I9aB25C9+TzJNk7SiHJDuLBmv0zv2nAqaVoU6mlToorG3Lt3o+B+lv1IKRGQtskRM6qtu4wvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705608; c=relaxed/simple;
	bh=eLVs1337HDjGm6oJ3JDP5Wv7pYs2t2qkYmkRdosmfT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aTGWXVSt6zKAClKHh8FPNSPPgGidUvAHjWF6pLvIcBi5ImZGrFKGAbfIyNFj1ut+SsCSSdsTxlyQB5LZL1g2gPo6hXB4dKg9wUmZexS5km/6T8AJ/yhQHci1JhkbALgBOdLf1k5SMUQ7xHv8Sh/zAVsxWsFfhRggLrhEwN/jXyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oMc2V4Ug; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axneNyV0C4u9iyBPFgRcFzr1HIefzYclZZao9whgKHd3BdBUAb1Y7o74xGFjLxTvZr0J30MqnT1KtDnWCCqcTs7JMcTCUD6q7Yp5DSuSB17YVAN2rTYcoXLWe6j0aLSmB6yIBhQy59s3I82h2KOB/gx11OJAun3bic5AyqE8WAMWs/EMYhyzDlYOUHTl0QipDdcKcXhPrlHkCl1e0TDxzKwJGGnuXeNCrhjlhvXW6DJ0cWr0w7+VxlIkPPwXTe3BXrvXWSG7di77uSYgbUYgr1qjkgJq28WvLmTSfqo0HmfNCFp/FMlI4SMLRnOrbeZqqN8nIw+rD0WqOTP1Ll+UVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi2hPtnkdBg8FgK570WBYwNL6h/WgzNbKeJeXT+MmYE=;
 b=X/lwVtpDA/W2jEWeeU3BxLxrGeEMjByzd+PpHl5cQWwTyXMsDnpj2xz6hzHcI7hgxgMX9TKJRVXw+hemTXnnZAFNG6p6dwJzbXrEIwyctShV49Tj8p+d+oKL/CUMH7G4TpCpJJEELKM7yJVP4Qo4Kwyj0IRkA8ueGR5O2D9CtNmtT6zB4ywSfEjgTiUGHmwI60CKdGGZI3ai0gmgsnsv4F1Ya370bOtSQxQ5CN8NeidL1wsheISneg/FSrAs6Ueq3K/IwFyRBqqICKCQGPtNvTGlsfDPM25cqiFn2vs43pM2GEE/h/0b2FT5cpZTiCRtjNOlyf3bxogyeozJaELLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi2hPtnkdBg8FgK570WBYwNL6h/WgzNbKeJeXT+MmYE=;
 b=oMc2V4Ug4aUGqreo/RNuJs4fRh+sIa+HKeePDho+l0BROoZiSpuyv71B0htWnM73iNvD1XJ5gzd2IENq0oEo3hPP/XIxX0/vyWopP0kXcFf9IAMnX7+hHrpZcwNzCNuG3i9B17cv3UT83jg1jD0b51rjyykBMp0tHTjdwDumwFJRz0FhVGqWg3oa0amdBOfHUhpYMlGVDXbimbc6hQ+XU2A68B3C6VzTsQGiW04fgU/YCj5Fo0gEImAgYu7RmVmagIKrdZP/28l1qM0RGkUTFHcSL2NhnhZtV+szsci/F1uvWxdshcgR4JTIqUNRfqZ+q+d4DS8yGG5NJ/sP7zliKA==
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 17:46:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 17:46:38 +0000
Date: Fri, 10 Jul 2026 19:46:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>, sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] sched_ext: Fix deadlock with PSI trigger creation
Message-ID: <alEv8QosliGUfUNZ@gpd4>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710100441.2653477-1-matt@readmodwrite.com>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7b5851-1bfa-49da-5c4a-08dedeab3101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	daqPq6gEYpWjhtjXXt+ky6wBCzs7hwAJis7iv7QFyhsUMpjmgr27fOL+gkGtabnIKD/MHz0y/5EuxJMuyOrXD6eH31n7UuYPDFBOjflQzUfQRDaPVh+uWM+PP33Wc+bLzno4No4zjNKWsMLqf4p6UN9O0psOYtSlYlVDclc2oMc7E0xxnotOwCwk+FcXVqz5As7iziKN8P21Ut1z1KOaW9L5i1w3NovgZzKzAVSgKBaAGagm6+1LKfFLsKS58bLUZhZBAlfB7zp//yB+tk0QeB9emib4c83oAXV+8fnlcQ6F3uGzAswGzfuNlYbMaeK8QPZXmErlvXv0yFuPn5/mIBRF+vzyp+64GPGUUxIavYnZcjJjLQ4vnqo6EVoSS+aK3BINOoDDaCQDxfVryWFSdZaskZlXwaQq2248gR06L+YcFZBXSWMfMTSrWNpgWPECiMamslcP++PiVqibCAwTQoVeFwfBcLMrSQ+by5bRGQ/6t8ImuO6kPY94QL+PCDn/tD8bAhT/pZEFNLTThptcwoCaY5gtGL96WYKtDuv20xBQbfG2k8rorrvPvf+RAHjG3KuK56Ppk+EFeAMwpApBzPrGs5BWeI9nrvxOKgf6fNkPRSDxaRN7ujMx47S18qSxarJu7UESkZUf47SB/q6qIC4+uKHF4qwDqOSR3ZqbNFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVYvwFAUIQ85mX95ywrM4VfbNNo6uLKiuZVAwJDU1crWpGiU03cLs9kJaXWB?=
 =?us-ascii?Q?89SrPgukjbXVzRuvld5skwFcM4sWzEeqtqYuYzmjugRWyljLneHg0fcrv/t5?=
 =?us-ascii?Q?ryNJGI9Ci0p4nGp9pqRYhtsdFJuGIA8AJPjyFaRhlAX6xOPQUYp8PozXkgTQ?=
 =?us-ascii?Q?Z2SsUgjQRFchW2+Rpt7sElkvOZiAgbUhy1cnnVjPBiyjj+6hpMuAoAXjKnuq?=
 =?us-ascii?Q?H52PgNOjO19mMzko0ykn/9kwr3bN3gEtGESmfCPIUWn1wCsnadkcG1uq0KIC?=
 =?us-ascii?Q?xTnK9L97gKVqDwXhEAypGakmit53OJQGNCNLxp6ZnAM+qgkDVfNutMAVUvR4?=
 =?us-ascii?Q?8Ds7NG+iJEUxskEW1lRs8eH53o/U6NtDDZssf42QNq2L81a6OUiP92k9vq26?=
 =?us-ascii?Q?Ul9Qbd7VuVQV33LK3woLg9h1kp3fZWfEBiWGRz3zh1SgmWUVTBUhhkGT0Idk?=
 =?us-ascii?Q?Ig1Oqv323fuKBfdBGyFHWvdi2+azQZ7+UgrTKZNDSy7Z13L2XEjlxKu6cNUs?=
 =?us-ascii?Q?mNyAQ1Pej76xmBi2+K12xpNiPP09DcRsx23OCaOCfTyhAf/bvPCXZnvL02qv?=
 =?us-ascii?Q?755moZO2fYT0ADbVtQAM36oKGtsiyub4U/GQyg5TCXCJb+SEEqJ+jYiEec1R?=
 =?us-ascii?Q?3fPhTG5pb8QZ+k21JkLRs+i4JkM48ERfyk0dK0a910fD/Nd7qqrnfsrT8PCT?=
 =?us-ascii?Q?7KiqN+Aem/QiijYGEc/gEAzlvhMijznzz9sUVXhOI5q1C9ZR+1tZT4Wp35SZ?=
 =?us-ascii?Q?wdB4NCxzXKAQwpWTxbEX1dXatavfDsy+RKKeAjV3STVQ0F91wOtbevC0Lw1D?=
 =?us-ascii?Q?bd/oH++5NPgZBzVldgsCWCxrdtsoSDl/UNlX23m/E/JjH0B4dK+a/lonZIpb?=
 =?us-ascii?Q?R6D4xULXP4xVWt67OAw9f2ESaNJS0VfNyDryoenX85OMFTo+lWExRYWTKCFP?=
 =?us-ascii?Q?7ij4GkkG0kqhsXv3ehmhUT/S7W4jf8mUv7PsK0lfRLKjQGIpXBdint/FzwJF?=
 =?us-ascii?Q?Uv++fl86sYPNen9X7fGiLgsOJIdoNLXa3Cz22qqS0se6Hg7NzXKEXBMTq0sw?=
 =?us-ascii?Q?lCgYuHJNy7dVkryA3BaA9knEaFKqmQRLngz5urq9bFjmcs4Q6Kw8aTBQIDwC?=
 =?us-ascii?Q?zNu8mLfpyKgcxtrRtKVHffMAozsemoYU7aWumafj+9z7t/6h+N04r75UH76q?=
 =?us-ascii?Q?eA+DTaplkLshb0hL6GFyFhuuUGIw8ggCL6Gs0CB6z5HGiaDdHwLzqZopOcS3?=
 =?us-ascii?Q?sMsZUzlQzl1y3aOhZfOYvssT0pmfURRn8abM66ZVOQFJb5i86iSpWp663wyx?=
 =?us-ascii?Q?1J9bcH6qK711rRbPVk5zkGOQf/dxm7qz4UWqzjbw90rtJQI2mMayG58uKQkj?=
 =?us-ascii?Q?eMi86oivyV2il2q7pHDI/wRQIP5qFtXU+Bjvc/TAk0L4CdASkBW46KixF1J3?=
 =?us-ascii?Q?LoJssGT7XCHJw/koh69+J+4/EYff3CEo9EgqSwjJJ4VSoDtO65YfUDsct2DP?=
 =?us-ascii?Q?d7+BYgmXY49ZKqTHp+840kXnMdtsvwKmiryt2XQhO1O541dP5xalFEBUuS3w?=
 =?us-ascii?Q?WXKP3hPuVG3C9HAbr8omFJl3yDix/5iS9t4/y7cjOIIZgXQVnd4IVeG4vRHO?=
 =?us-ascii?Q?Sna2i80GUOdgvWZ7Mtwu8Kui8lx4cwzOW7uPOBRdg/uRZeTvXiqnYuIWHKCE?=
 =?us-ascii?Q?+kVsmS1cQnvSnMZHaF+29xf0sQqReIfAvoo4jottbTJ4UG6eIw34cv4DKNmV?=
 =?us-ascii?Q?PEctjM02gQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7b5851-1bfa-49da-5c4a-08dedeab3101
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:46:38.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/24JfLgnzIYo29/cGIa/8aiuykkh33jinea+ngJA9Qkr3jOloxmwch2I4v/pBt0kC17ux135pZna0+B0HIWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17653-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matt@readmodwrite.com,m:tj@kernel.org,m:void@manifault.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,m:mfleming@cloudflare.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[arighi@nvidia.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,manifault.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,lists.linux.dev,vger.kernel.org,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cloudflare.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5551773D1A0

Hi Matt,

On Fri, Jul 10, 2026 at 11:04:41AM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> scx_root_enable_workfn() currently takes scx_fork_rwsem for writing
> before acquiring cgroup_mutex. Since commit a5b98009f16d ("sched/psi:
> fix race between file release and pressure write"), pressure_write()
> holds cgroup_mutex across psi_trigger_create(), which may call
> kthread_create() for the psimon kthread. kthreadd's fork then enters
> scx_pre_fork() and waits for the read side of scx_fork_rwsem.
> 
> This results in a deadlock. The enable worker holds scx_fork_rwsem and
> waits for cgroup_mutex, while the PSI writer holds cgroup_mutex and
> waits for psimon creation to complete. Any concurrent fork blocks on
> scx_pre_fork() behind the enable worker.
> 
> The hung-task detector captured all three sides of the deadlock:
> 
>   scx_enable_help:
>     __mutex_lock
>     scx_enable_workfn
>     kthread_worker_fn
> 
>   systemd:
>     wait_for_completion_killable
>     __kthread_create_on_node
>     kthread_create_on_node
>     psi_trigger_create
>     pressure_write
>     kernfs_fop_write_iter
> 
>   python3:
>     percpu_rwsem_wait
>     __percpu_down_read
>     scx_pre_fork
>     sched_fork
>     copy_process
>     kernel_clone
> 
> It also identified systemd as the likely owner of the mutex on which
> scx_enable_help was blocked.
> 
> We reproduced this on a 128-CPU AMD EPYC 7713 by enabling scx_lavd
> concurrently with writes to cgroup PSI trigger files. Unrelated tasks
> piled up in scx_pre_fork() and process creation on the box stopped.
> 
> Fix the inversion by acquiring cgroup_mutex before scx_fork_rwsem in
> scx_root_enable_workfn() and releasing them in reverse order, while
> preserving the existing exclusion around cgroup and task initialisation.
> 
> Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

This seems to introduce the following (running the sched_ext kselftests):

[   28.963575] ======================================================
[   28.963670] WARNING: possible circular locking dependency detected
[   28.963752] 7.1.0-virtme #1 Not tainted
[   28.963804] ------------------------------------------------------
[   28.963887] sched_ext_helpe/2619 is trying to acquire lock:
[   28.963954] ffffffff83685240 (scx_cgroup_ops_rwsem){+.+.}-{0:0}, at: scx_root_disable+0x45d/0x840
[   28.964071]
[   28.964071] but task is already holding lock:
[   28.964151] ffffffff83682910 (scx_fork_rwsem){++++}-{0:0}, at: scx_root_disable+0x160/0x840
[   28.964260]
[   28.964260] which lock already depends on the new lock.
[   28.964260]
[   28.964355]
[   28.964355] the existing dependency chain (in reverse order) is:
[   28.964455]
[   28.964455] -> #2 (scx_fork_rwsem){++++}-{0:0}:
[   28.964539]        percpu_down_write+0x49/0x150
[   28.964610]        scx_root_enable_workfn+0x5d0/0xd30
[   28.964679]        kthread_worker_fn+0x121/0x360
[   28.964749]        kthread+0x10c/0x140
[   28.964802]        ret_from_fork+0x189/0x330
[   28.964872]        ret_from_fork_asm+0x1a/0x30
[   28.964941]
[   28.964941] -> #1 (cgroup_mutex){+.+.}-{4:4}:
[   28.965025]        __mutex_lock+0xbe/0xd80
[   28.965070]        scx_root_enable_workfn+0x5c4/0xd30
[   28.965138]        kthread_worker_fn+0x121/0x360
[   28.965210]        kthread+0x10c/0x140
[   28.965263]        ret_from_fork+0x189/0x330
[   28.965331]        ret_from_fork_asm+0x1a/0x30
[   28.965402]
[   28.965402] -> #0 (scx_cgroup_ops_rwsem){+.+.}-{0:0}:
[   28.965485]        __lock_acquire+0x14c5/0x2a40
[   28.965554]        lock_acquire+0xd3/0x280
[   28.965608]        percpu_down_write+0x49/0x150
[   28.965677]        scx_root_disable+0x45d/0x840
[   28.965745]        kthread_worker_fn+0x121/0x360
[   28.965815]        kthread+0x10c/0x140
[   28.965867]        ret_from_fork+0x189/0x330
[   28.965935]        ret_from_fork_asm+0x1a/0x30
[   28.966002]
[   28.966002] other info that might help us debug this:
[   28.966002]
[   28.966097] Chain exists of:
[   28.966097]   scx_cgroup_ops_rwsem --> cgroup_mutex --> scx_fork_rwsem
[   28.966097]
[   28.966233]  Possible unsafe locking scenario:
[   28.966233]
[   28.966314]        CPU0                    CPU1
[   28.966379]        ----                    ----
[   28.966444]   lock(scx_fork_rwsem);
[   28.966496]                                lock(cgroup_mutex);
[   28.966579]                                lock(scx_fork_rwsem);
[   28.966661]   lock(scx_cgroup_ops_rwsem);
[   28.966713]
[   28.966713]  *** DEADLOCK ***
[   28.966713]
[   28.966794] 2 locks held by sched_ext_helpe/2619:
[   28.966861]  #0: ffffffff83682818 (scx_enable_mutex){+.+.}-{4:4}, at: scx_root_disable+0xba/0x840
[   28.966974]  #1: ffffffff83682910 (scx_fork_rwsem){++++}-{0:0}, at: scx_root_disable+0x160/0x840
[   28.967090]
[   28.967090] stack backtrace:
[   28.967158] CPU: 8 UID: 0 PID: 2619 Comm: sched_ext_helpe Not tainted 7.1.0-virtme #1 PREEMPT(full)
[   28.967164] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   28.967166] Call Trace:
[   28.967169]  <TASK>
[   28.967172]  dump_stack_lvl+0x6d/0xa0
[   28.967175]  print_circular_bug+0x2e1/0x300
[   28.967179]  check_noncircular+0x144/0x170
[   28.967182]  __lock_acquire+0x14c5/0x2a40
[   28.967202]  ? scx_root_disable+0x45d/0x840
[   28.967204]  lock_acquire+0xd3/0x280
[   28.967207]  ? scx_root_disable+0x45d/0x840
[   28.967209]  percpu_down_write+0x49/0x150
[   28.967212]  ? scx_root_disable+0x45d/0x840
[   28.967213]  scx_root_disable+0x45d/0x840
[   28.967219]  ? kthread_worker_fn+0x51/0x360
[   28.967221]  kthread_worker_fn+0x121/0x360
[   28.967223]  ? __pfx_scx_disable_workfn+0x10/0x10
[   28.967224]  ? __pfx_kthread_worker_fn+0x10/0x10
[   28.967227]  kthread+0x10c/0x140
[   28.967228]  ? __pfx_kthread+0x10/0x10
[   28.967229]  ret_from_fork+0x189/0x330
[   28.967231]  ? __pfx_kthread+0x10/0x10
[   28.967232]  ret_from_fork_asm+0x1a/0x30
[   28.967235]  </TASK>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f64..ba89eafe7964 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -7193,7 +7193,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	/*
>  	 * Lock out forks, cgroup on/offlining and moves before opening the
>  	 * floodgate so that they don't wander into the operations prematurely.
> +	 * cgroup_mutex must nest outside scx_fork_rwsem because cgroup file
> +	 * operations may create kthreads while holding cgroup_mutex.
>  	 */
> +	scx_cgroup_lock();
>  	percpu_down_write(&scx_fork_rwsem);
>  
>  	WARN_ON_ONCE(scx_init_task_enabled);
> @@ -7216,7 +7219,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	 * while tasks are being initialized so that scx_cgroup_can_attach()
>  	 * never sees uninitialized tasks.
>  	 */
> -	scx_cgroup_lock();
>  	set_cgroup_sched(sch_cgroup(sch), sch);
>  	ret = scx_cgroup_init(sch);
>  	if (ret)
> @@ -7283,8 +7285,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  		put_task_struct(p);
>  	}
>  	scx_task_iter_stop(&sti);
> -	scx_cgroup_unlock();
>  	percpu_up_write(&scx_fork_rwsem);
> +	scx_cgroup_unlock();
>  
>  	/*
>  	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
> @@ -7369,8 +7371,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	return;
>  
>  err_disable_unlock_all:
> -	scx_cgroup_unlock();
>  	percpu_up_write(&scx_fork_rwsem);
> +	scx_cgroup_unlock();
>  	/* we'll soon enter disable path, keep bypass on */
>  err_disable:
>  	mutex_unlock(&scx_enable_mutex);
> -- 
> 2.43.0
> 

