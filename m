Return-Path: <cgroups+bounces-12842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 998F4CEC345
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E08CC3000E94
	for <lists+cgroups@lfdr.de>; Wed, 31 Dec 2025 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE5298CDE;
	Wed, 31 Dec 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxDab8BY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158322258C;
	Wed, 31 Dec 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767196387; cv=none; b=ek5f3W4QNgv9dy8xyoQB3QyxFMnuadrTCykN7L3vgqsduz3N3/cJfu7T7VNR7rlBwDnoZV6O4OWTR8BAiyXM7a1SLKL9702S0umktWgBPd/59btsCKSLS7oTh8R6PMMr/WDuz1NvmWZzOLWosu5Kl6qEzpAlzXZYGTGtdHHmfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767196387; c=relaxed/simple;
	bh=WuZtOdVS5pt77HE6C/4UqSC04WxBcGthdWDuudQRYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8Ua4mgiEvs4me+1NKColCyf41VIVKaKDU9JrLl3XjyJypsnhLDm8QLiOoQHDRJRJSJ0O9ppTidZqrDQ8rTRCrpXxAE81GWNqP6/hu690FZQCH4QG3YigBBg93rBpOnyvLna1IWeoql/BofwUFjUkZqjI3LecCWMRalg4tL9Sus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxDab8BY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1961DC113D0;
	Wed, 31 Dec 2025 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767196386;
	bh=WuZtOdVS5pt77HE6C/4UqSC04WxBcGthdWDuudQRYgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VxDab8BYNIAerqtNV5zwvbjoskp/SPlehgZo8EmzUsqwfpTjb+PHLvjB3/Qja0h31
	 UULkJOtXQH1SfmAb7vyAh6oIHb0OjR053QxyQL9jp1E2EPXisgst2fDkb6Pwm1biyT
	 VWmvvozz2gG6CzWs1cAr3cftru801On2WHgnh2PLITLRtRFg3votB3ExybxAyD/TCc
	 E9pfkXScaZOYlT/k3gRfSRJG9ofOzMXgcL5MwRQUb7FcyRsFHUs49yU5OMxzP78nXN
	 a9Vs6QnYfGFU1BHGsY59xWhfGdN5QneBF7NTvxT2/ddwqD5zYUeX9DP8WxIh0e0M9/
	 Gody5xZN6Kx0w==
Date: Wed, 31 Dec 2025 16:53:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
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
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 19/33] cpuset: Propagate cpuset isolation update to
 timers through housekeeping
Message-ID: <aVVG3-NBYIhJmVsk@localhost.localdomain>
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-20-frederic@kernel.org>
 <a8262eaf-169d-415d-949e-70f1a17b1e38@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8262eaf-169d-415d-949e-70f1a17b1e38@redhat.com>

Le Fri, Dec 26, 2025 at 03:40:25PM -0500, Waiman Long a écrit :
> On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> > Until now, cpuset would propagate isolated partition changes to
> > timer migration so that unbound timers don't get migrated to isolated
> > CPUs.
> > 
> > Since housekeeping now centralizes, synchronize and propagates isolation
> > cpumask changes, perform the work from that subsystem for consolidation
> > and consistency purposes.
> > 
> > Signed-off-by: Frederic Weisbecker<frederic@kernel.org>
> > ---
> >   kernel/cgroup/cpuset.c   | 3 ---
> >   kernel/sched/isolation.c | 5 +++++
> >   2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index a492d23dd622..25ac6c98113c 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1487,9 +1487,6 @@ static void update_isolation_cpumasks(void)
> >   	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
> >   	WARN_ON_ONCE(ret < 0);
> > -	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
> > -	WARN_ON_ONCE(ret < 0);
> > -
> >   	isolated_cpus_updating = false;
> >   }
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index d224bca299ed..84a257d05918 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -150,7 +150,12 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
> >   	pci_probe_flush_workqueue();
> >   	mem_cgroup_flush_workqueue();
> >   	vmstat_flush_workqueue();
> > +
> >   	err = workqueue_unbound_housekeeping_update(housekeeping_cpumask(type));
> > +	WARN_ON_ONCE(err < 0);
> > +
> > +	err = tmigr_isolated_exclude_cpumask(isol_mask);
> > +	WARN_ON_ONCE(err < 0);
> >   	kfree(old);
> 
> If you are doing "WARN_ON_ONCE() in housekeeping_update(), you don't need to
> do it in update_isolation_cpumask() to avoid double warnings. Actually, you
> don't need to return an error code from housekeeping_update() at all.
> 
> Cheers, Longman

Ok, I'm keeping the error return for allocation failures at the beginning of
housekeeping_update() but the rest will only warn in place.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

