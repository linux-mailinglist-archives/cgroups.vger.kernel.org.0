Return-Path: <cgroups+bounces-12838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA3CEC143
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D6513015840
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA526B971;
	Wed, 31 Dec 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdkIy6Sz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E87261B8F;
	Wed, 31 Dec 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767190920; cv=none; b=Fb/Kh7D5vztFGXNsicELqVgYhP1fL0y/94w+1Wh2iWPiAbuPYgWsaajpi90p86YUpMGKwPwnxcg5bcvUhgLeR1+CKn7P2u9o1KLLJsIraVqJYjRcEvxFIpjM2xEOVJdYRiJOM+kNyplqBv62znHKsqrAdjD1lfrb87/91n+F8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767190920; c=relaxed/simple;
	bh=ThxbPyVAuuGbA1hxol61p5aRyqgSEJPk5GSWaXCro3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8SCTw0xSkPTp8d/7Y3ZhXEMfcaoWyPeiRompqq6daBUCL9HqHPUSCTn2urzRlM8k3sfqkJl81ExJpPoMPnq94Or/QWxUNU5J/fy/2mlfrqCPCA8ir0tMHBgJFfhWgY6h4ZeH2+WbxTopBccJMBzwMGRXonBHYOnyCX77AHHCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdkIy6Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D7AC113D0;
	Wed, 31 Dec 2025 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767190919;
	bh=ThxbPyVAuuGbA1hxol61p5aRyqgSEJPk5GSWaXCro3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdkIy6Szlw8k7WZ5M4sr0W+mpchR0nIFJWieDi+fUljSS8EAjYlSchHFr67dKhexm
	 KJJMdMWfYo8IWLH2chBoG8s+ZzgqZmkjbUlBC+Vq0AxW4efi7nbP/ljmMjJI+NbTL1
	 sLgKSLCCNSmx6D/VujTYD1MVuxw2wr6bHhfmYE3B+2Va+JDWfgi0fQhFtPsUzwhJdE
	 cLIAzLkpUT7dXDv7EQ9Fky4+vRRiwgjcI8gk7iiqsUR7/k1wzYboc2OATWu/Ld1MR1
	 jUVkuUAHST53zHzaocUECX2wUK5wFha+6qsdBMVyGyNbCMW4qKIWzEnCyzkbvzH2oB
	 lq9ruU1QKaHig==
Date: Wed, 31 Dec 2025 15:21:56 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Message-ID: <aVUxhNlKaT0r6F5c@localhost.localdomain>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-15-frederic@kernel.org>
 <8ecb22ab-d719-44b4-ad40-5af0a185682a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ecb22ab-d719-44b4-ad40-5af0a185682a@huaweicloud.com>

Le Fri, Dec 26, 2025 at 04:08:04PM +0800, Chen Ridong a écrit :
> > +int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
> > +{
> > +	struct cpumask *trial, *old = NULL;
> > +
> > +	if (type != HK_TYPE_DOMAIN)
> > +		return -ENOTSUPP;
> > +
> 
> Nit:
> 
> The current if statement indicates that we only support modifying the cpumask for HK_TYPE_DOMAIN,
> which makes the type argument seem unnecessary. This seems to be designed for better scalability.
> However, when a new type needs to be supported in the future, this statement would have to be
> removed. Also, the use of cpumask_andnot below is not a general operation.
> 
> Anyway, looks good to me.

Ok, let's remove the parameter for now.

> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 475bdab3b8db..653e898a996a 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -30,6 +30,7 @@
> >  #include <linux/context_tracking.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/cpumask_api.h>
> > +#include <linux/cpuset.h>
> >  #include <linux/ctype.h>
> >  #include <linux/file.h>
> >  #include <linux/fs_api.h>
> 
> Reviewed-by: Chen Ridong <chenridong@huawei.com>

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

