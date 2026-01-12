Return-Path: <cgroups+bounces-13102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3643FD15731
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 22:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1EED3008F69
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC9340D86;
	Mon, 12 Jan 2026 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qptVqZGT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2B259C92;
	Mon, 12 Jan 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253688; cv=none; b=PNsUJXd9Q1TBfvZQzYCkBPZ/wGg+M8tduNzrKsyPETHHRJZ/svgrFTfpDO+Ujsxyzyut/fpVM0RynrFTioVaisN8Ih/lRNnFulFNMtFP7bYgm/XNBz3MiR8/sxFoDKg76sG0XybMMczjoO82vlBVRWvs7Mtp67tQBsOiAdPO/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253688; c=relaxed/simple;
	bh=9r8xMa9X/yGGRMfGiUGCl1DnzpxKkGTZr05lhBx3Fuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6xlV0xteJu6o2jKW7wbZPWWJf2wo0Mp1iYYN0mzuRlB2t9KsvofYQdnr7qisvv3c/3jqWP5y0a+9tQLgncEOgc5uhx4PFAc5tDhMXaBdSvESfBx+6rREWgbArcbloinRK0FErePH19b0cdpd0lAkCsXWhafOSjki2y7DJT6HEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qptVqZGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F249CC116D0;
	Mon, 12 Jan 2026 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768253688;
	bh=9r8xMa9X/yGGRMfGiUGCl1DnzpxKkGTZr05lhBx3Fuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qptVqZGT+1fDu0cNQxrhf3GZG86xaiN60eR79t5T8VE8+jboA88I9+H4wWs36cDgn
	 WxvxvvzXqOxIPCEr6sQ67QhSGivnZxlPVbnisNAp2Fq2Lx2FOw8jD/GAGl/bjvO6wA
	 6XazLKC2q1ORoXy/dIBsw2qKYEbznnqE5D7prXft0h17ygA48CYGKQ5VUzU03M8PJR
	 nPRoNbTwzdiYvZ09K3eWroErKiVKPpP757Mf3asaHLOHCtf7eTT+iKFzXr7v4NDbwG
	 gCnGFBI+WlVAAippbwzuqtJRjlwHegTnT0EXMx3JG1F2iTuEovYgG0LImYZN60Cu5s
	 GiJXQ+NiC2dlw==
Date: Mon, 12 Jan 2026 22:34:45 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 13/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
Message-ID: <aWVo9em4C3f1TfOQ@pavilion.home>
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-14-frederic@kernel.org>
 <20260107115653.GA196631@kernel.org>
 <18ee9089-8a08-44ed-8761-7c9db765cd4e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ee9089-8a08-44ed-8761-7c9db765cd4e@redhat.com>

Le Sun, Jan 11, 2026 at 09:45:36PM -0500, Waiman Long a écrit :
> On 1/7/26 6:56 AM, Simon Horman wrote:
> > On Thu, Jan 01, 2026 at 11:13:38PM +0100, Frederic Weisbecker wrote:
> > > HK_TYPE_DOMAIN's cpumask will soon be made modifiable by cpuset.
> > > A synchronization mechanism is then needed to synchronize the updates
> > > with the housekeeping cpumask readers.
> > > 
> > > Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
> > > cpumask will be modified, the update side will wait for an RCU grace
> > > period and propagate the change to interested subsystem when deemed
> > > necessary.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >   kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
> > >   kernel/sched/sched.h     |  1 +
> > >   2 files changed, 37 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > index 11a623fa6320..83be49ec2b06 100644
> > > --- a/kernel/sched/isolation.c
> > > +++ b/kernel/sched/isolation.c
> > > @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
> > >   EXPORT_SYMBOL_GPL(housekeeping_overridden);
> > >   struct housekeeping {
> > > -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> > > +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
> > >   	unsigned long flags;
> > >   };
> > > @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
> > >   }
> > >   EXPORT_SYMBOL_GPL(housekeeping_enabled);
> > > +const struct cpumask *housekeeping_cpumask(enum hk_type type)
> > > +{
> > > +	if (static_branch_unlikely(&housekeeping_overridden)) {
> > > +		if (housekeeping.flags & BIT(type)) {
> > > +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> > > +		}
> > > +	}
> > > +	return cpu_possible_mask;
> > > +}
> > > +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> > > +
> > Hi Frederic,
> > 
> > I think this patch should also update the access to housekeeping.cpumasks
> > in housekeeping_setup(), on line 200, to use housekeeping_cpumask().
> > 
> > As is, sparse flags __rcu a annotation miss match there.
> > 
> >    kernel/sched/isolation.c:200:80: warning: incorrect type in argument 3 (different address spaces)
> >    kernel/sched/isolation.c:200:80:    expected struct cpumask const *srcp3
> >    kernel/sched/isolation.c:200:80:    got struct cpumask [noderef] __rcu *
> > 
> > ...
> > 
> The direct housekeeping.cpumasks[type] reference is in the newly merged
> check after Federic's initial patch series.
> 
>                 iter_flags = housekeeping.flags & (HK_FLAG_KERNEL_NOISE |
> HK_FLAG_DOMAIN);
>                 type = find_first_bit(&iter_flags, HK_TYPE_MAX);
>                 /*
>                  * Pass the check if none of these flags were previously set
> or
>                  * are not in the current selection.
>                  */
>                 iter_flags = flags & (HK_FLAG_KERNEL_NOISE |
> HK_FLAG_DOMAIN);
>                 first_cpu = (type == HK_TYPE_MAX || !iter_flags) ? 0 :
> cpumask_first_and_and(cpu_present_mask,
>                                     housekeeping_staging,
> housekeeping.cpumasks[type]);
> 
> Maybe that is why it is missed.

Good catch guys! Fixing this.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

