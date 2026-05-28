Return-Path: <cgroups+bounces-16400-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAZHJkOaGGr+lQgAu9opvQ
	(envelope-from <cgroups+bounces-16400-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:40:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C85F73F2
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4F573045B13
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA582348C79;
	Thu, 28 May 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0w8tpRZ"
X-Original-To: cgroups@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41852351C0B;
	Thu, 28 May 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997225; cv=fail; b=Fd8vRA36mb1aUnA2iJutcarTUNaCZI6Un4OBfsqjaPyUKn4+DbUhWfAPekT4yx8PKgpwxoWPpQR5JRU6A+9gnLgmGYujuFF6YrXC1APGx4lK9A4faOqYIHDretpwhbCbldcCZe+jXVEQCrE71IuXhDjW+++8KXdVRhhGK7IO2OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997225; c=relaxed/simple;
	bh=vqnKa9VhMd/rICn4EBXejRDLlQGw34WnR00/iWLBJLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bn9h73iaShc64Hx8Ls1Ymzw7IWCuyE1UhIg9SRDRHhurraWG52OU2uIW/LK9zpt+ASjiQzd2nb89QTCmIwHVz4bOe4Ku3/RZtN2t4D1xeTeZbLBX+Danoza+IoemObRksacJTiY/goM1jcA9xaQrkKLQqM/pKF7MS/nFZmy3utg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0w8tpRZ; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSiVQF/3mT2ObragUqGPgtC27PlClB0a4sDS+A/qmayAd+RkJc53lqHpHRZiV8UIT0JeIyVuKAiOZQanV4E5HuX7coPXwlySIEIBqJtw6EEbnmLKdcGltJmDcQPiT87EIztPfSiV05vRp/8W2d1WDP8+YO/vgt0qAtQfX7GeGoEL+a3Q9iGUEg9/M9/tzGrapSL5pO2mXDLplRaJoz5NHSXAC8Jpo6nmLu4xcRO0MB0YQNpNrPoNgnrnz9YTboPVpcsUE3E4evC4YXmB3thVZQleE1Z0iYhJorML7h2+lT2QQWs3RHcUa36e5zp1aXbG362M6nOvCEPAk8c+oKwNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzKJ3A0knsCp43XZiY+7zOOoAcsdxX7BewlyBtfaan0=;
 b=GH1JWRa+P+HqedzZSN+coawbTWjnwTcvljF59pR7J1xX2G3fFHu8/f4wOTzEP6Aw/PsUG2hYgjh0EvXq6gPoDFrRq4nJGls5qfmC61R3MLmL5jeKlWu27nuvepC87ziRJL/08l7+ENd6UNGAoKw5z29aWGf7KL/huFVEpH3C9/4icn3bj5jSjPYOmTYyNUoK/35uvCT3quE1hkAyPn+/F5Gpo4+xt74dzdHrfZRUPfUpMocbQ1N9tHOfdfzaMnQ0XoLBi6FSOIWZHILN1NgduEk+3yRHUhysCBmumFD3bhMCRrEOQ9IJJy4/7zro5GNAE3in33AL6Xee3qCIF03aQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzKJ3A0knsCp43XZiY+7zOOoAcsdxX7BewlyBtfaan0=;
 b=R0w8tpRZaB3BHpFdFSOfYdZYi4B9gizuiQx6MHgxe3hJbwjkVc2sUqU3NfIf2SlLNdQBl8339cZ7qFQmcRbzpIxIkWhZ0OaDsZmg32jZdjhSkJM25QvUrocnnThbE3XOojrsrp1McGn4FtQ/RUHRGCu6mqXi6KYrRPM9fnZsfWimsEon0pcRwG99OX6IYQ47BsSHLzxrPqdMfPuijXndX798sjMlKstPyprIzoiJcD01Ak/U93RuY54ojF4XaMsppZKSaRUeuHdvJclyl4A1lQaazHY+1OLn9b1qzDR7bOtvMrwoWKq4kxnOhVvzLYR1XeK4zplxfTLyGAkbKOHOoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 19:40:13 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:40:13 +0000
Date: Thu, 28 May 2026 15:40:10 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in
 mpol_relative_nodemask()
Message-ID: <ahiaGvfMZ-7MIcZF@yury>
References: <20260528190337.878027-1-ynorov@nvidia.com>
 <305848e7-f987-494c-8244-bcf8eed6fb7d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305848e7-f987-494c-8244-bcf8eed6fb7d@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5bdcc0-4070-4fbe-a0f6-08debcf0efbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NWr2uF0skJB5jR3HnjE4nrntKjk9tPrdQRGHt/b0UU73pNXxbStDby0euNoO9BkYjt9wTV05xy8fOvLRyKvCBVFqx/BaM7hKrPOHgvx4fd3GH6/le76ZXJstUDerE/0y9N5Ogb8ARO1bJgrIxo3DrsFQHRJPEvfg05mYxPmnevT+iOip4XNfHFHgV4OxAO63WE/uZdZ9vw0Zx5qXHlXLAUgheToOfwuEOoRjFus/smXs0Uf6Nt8uhX/ea0WSKlOdHOKbeJW4WOODAbZO54+ZvLI7KeNMwkFFj9CgRM0RWopL5ZdmzJCU27EDXLvjezhNx0K+zxoc+YIpUVm6atVvn8CNjjaafxR/wjlRMBP5+WkKo6wmZJLjFNWOuLpAjqwxgOD/eARhyunFL9jIwHtMmigQCths8tyfbdmGQ/ts8RVTDr2eR6T7+0ae8+OqOlGSZxXq2g89W/eRYo8b0ZiNPvRnbW63DLD/B4IA1KPYkUQ9ui7ykMAlsvplrxBkGJyTSEGVoeibaKVKpAdsqNpxgQEFwJr9K82AdtC3/JFCkdcBP+lOXPvm/n+lF/OrLeyqJXPF9Inw5ofSXd4ckFxYBJt84puAwbJHUgBrzb1i0F55o0rx2qCESIlXrcyAu27Tp2I47xiYAnFSwl3SYstOXQd6N+o2ZIKesegD66I31qSTFX/jRhkjW6O94j6JH4XKWhdl086GKkWpF0FPXsK/gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nmi5OS2T59jPCAIn3QB1iZCzxEUZBSX7w+d2PDEg0fd5aZHBv7yQm43v2Nza?=
 =?us-ascii?Q?kZjGz9/DS6O9Ewb733RcKCLPWz2zoa5ZKh3g30KeeexU4rKLicfUUJNtYTfP?=
 =?us-ascii?Q?VA0OaPVvhNkrMwO870YihT9+IRP5Bp1ka67OUA3u9i4MlVzmk+wTcGuetSYw?=
 =?us-ascii?Q?NMCMXZXwSeNsGouUpbPUqVqyFriQUqH6G1MhOYu6fBDGRUVRzt7lDIaQfDNa?=
 =?us-ascii?Q?O4G6mdj3K8+hGyp1v6Vr5N6RfMZ3hKCdnrbishQuH/obh4hWU4wseYwgBDex?=
 =?us-ascii?Q?MI9zvqoClBQraIGfRYnxiTXePNZSOfC6qQVIPFtm2G2xR3suvT3C43MT8cm5?=
 =?us-ascii?Q?UMFohRNPr6rD4sPN0RFMpZdA2KzM8db/RTpB1eUSR7bnjVpaVtj2Kifv/e3T?=
 =?us-ascii?Q?ZZmfki/Is9VrHQ6XgEclF2vXOn1P3C0PaLng84ZtFw51UGkwXbUeGZH2rNLp?=
 =?us-ascii?Q?gcRYsYPHEmGhKW7v0Z6BFU0YiFKg0qd69qwM/eUjGhUgNh53JQffsoKzJnfG?=
 =?us-ascii?Q?cVri2xCv0jy2FePBjxvB1cf95f7m28rhnLDpIZYBIFkgOZwN+acqUY9hELbw?=
 =?us-ascii?Q?6rC35Va52WMoE5CGn4JDitEeCCvNjGlzeBojZuaWzuXF3AR3Jmh2kNopb+RS?=
 =?us-ascii?Q?K+NsDKWeoqPbCHUWHq0OWv/ToMjg37bn2AbCyEmZYgawW00hcWvFxY5bU8Z+?=
 =?us-ascii?Q?d30OxVjieV+ddOQ3PSm0BvaaXueSwvTtNMzGigKbTKYC3GZMszYs06uMCqom?=
 =?us-ascii?Q?0/KlsKY2bUJ4i0nknmBtMhF/g5YpGZSmgfp6FNQzhUbdPCzoS8MvvZASbZyJ?=
 =?us-ascii?Q?IYKxwngiSkKL+iJH2GOzSk/Dx26MPzcG+dwEUIRdvWH380BObKjWwgp0ny0U?=
 =?us-ascii?Q?7DEwnJT3Xf6YeTmTXRQyyQGPFtnBChp6KJYBZOHfET4yCC46JpBw7sKXgFdG?=
 =?us-ascii?Q?gvYtcA0xSTCgdr/wqKQ04AwK4JxrLbWW/JFcf2MEntMk+y5ABM8TJbL67Ric?=
 =?us-ascii?Q?b07q5ZmNsvNJ24t9z22KSI+re3/VYLIUkajswgydKmpo7uu5LuRNB0rmHQb2?=
 =?us-ascii?Q?NHil6sagFmbmu+dZFIQGMJL5i2IIWSTU12a+BV3fETH8//tBjeGdQsdu27t8?=
 =?us-ascii?Q?zH2dIUXGHDSTey2THgIcz0wi0n3Sqo3LwJIegvIs6IwFdYYlKbZnsutdKj03?=
 =?us-ascii?Q?1KyG3YBKPLMAUresm3lcHDDbff4arZBQuY/uvUnH3q4wSV2M3XO/fZzYQlqn?=
 =?us-ascii?Q?zQWzzPqgMRJEMo3cM3ipOp3RXWe3J1jvMh3e3jUgt0zCvxpHAgS11cA0wjEf?=
 =?us-ascii?Q?fRs4vrE56FxQNxL+cocigpW5K9+UXhON6zeybaq9c7gm2cbcV5jG8YMj9Y6T?=
 =?us-ascii?Q?yj5xzF9Sp5LT9bMG3fyhYO/oKGJeE+A31vS+c+g3ehhzNSCpB/Cy+wS+MK0K?=
 =?us-ascii?Q?PmLJ3BQE2g28u8oEAErFw+IrZT3hjRf9S+IshHPXxV7N3s1HonDqlu1h2hQ0?=
 =?us-ascii?Q?F5Pi6ZdzIj9Ghr+3W34YcKZYLvTneW2FlzKEU+FEFufGUHOCoGwK3RmZ5dsS?=
 =?us-ascii?Q?ditVWpAKEmz1P/nd+r/Un/h44glKTUeAO8erzWnts1vhIDbE6+X/whCYUtrw?=
 =?us-ascii?Q?RCogJscyqMcQjdYF4uZFYy+qbr/ZBuNsZQHmihNxdEDHr2ePs7YaMWSB9dbT?=
 =?us-ascii?Q?qZcltNc0knke78TW4F9M7pwqe3SHhLLnyxlQQJaFFHJQihLtePE7T6WSGXjz?=
 =?us-ascii?Q?+6r6TGQNR84xm6sqBx5O08pXOAt9/3poa8/kOgPL82rq93TOIwQX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5bdcc0-4070-4fbe-a0f6-08debcf0efbb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:40:13.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+qnAq3NvYgBRO1BV0OUD/sqTNLqiF/otkbBBiibeWSUdVJzUFkodcNXFFSVX1psDPi1rNTYgriSvfDR5toFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16400-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,kvack.org,vger.kernel.org,berkeley.edu,rasmusvillemoes.dk];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,berkeley.edu:email]
X-Rspamd-Queue-Id: 348C85F73F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 03:37:04PM -0400, Waiman Long wrote:
> On 5/28/26 3:03 PM, Yury Norov wrote:
> > Reassigning nodes relative an empty user-provided nodemask is useless,
> > and triggers divide-by-zero in the function.
> > 
> > Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > Link: https://lore.kernel.org/all/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >   mm/mempolicy.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 4e4421b22b59..cd961fa1eb33 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -370,8 +370,13 @@ static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
> >   static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
> >   				   const nodemask_t *rel)
> >   {
> > +	unsigned int w = nodes_weight(*rel);
> >   	nodemask_t tmp;
> > -	nodes_fold(tmp, *orig, nodes_weight(*rel));
> > +
> > +	if (w == 0)
> > +		return -EINVAL;
> > +
> > +	nodes_fold(tmp, *orig, w);
> >   	nodes_onto(*ret, tmp, *rel);
> >   }
> 
> mpol_relative_nodemask() is a void function, so this code should fail
> compilation. Right?

Apologize, submitted the wrong file. Will resend shortly.

