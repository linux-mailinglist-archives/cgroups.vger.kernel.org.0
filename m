Return-Path: <cgroups+bounces-12610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3C4CD9C04
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 16:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D613032730
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 15:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA729ACDB;
	Tue, 23 Dec 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWsF7jIJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E63267B05;
	Tue, 23 Dec 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503079; cv=none; b=CIosTCerC0lkl5M7eTBpxjee5ZoY/VrKdM7co9sEhwT7es16+iPA9ztfBt3DEYCTp8ABvykLYFIMhA0W1Vge2Q0DD8AK+3dw60smSDB/khSUTlk67WkWy4zZLll3s6lNcqSjdk72rNP4UYYmVub0yrHoQXTTJnF5Vjc9C7vvVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503079; c=relaxed/simple;
	bh=xHMvPjpKyxjB5+zEUkjOy7aEQZr7/WEBY7QJCb1Hs8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYLhlUluZYh0eXhoparq8da2VSzA8CUCx9fZw+azcpyCrbzvZvco5ZWCtbozPauP7z0DWNVRMY6rxkuz1eJrX1OKvq+o/algB45CptW404VHYVh9xnWVWihSVnSNEbJ/sW/vAMAuFngHt56msCjZK662nsfawc+myRhoWNpubqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWsF7jIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C86DC113D0;
	Tue, 23 Dec 2025 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766503078;
	bh=xHMvPjpKyxjB5+zEUkjOy7aEQZr7/WEBY7QJCb1Hs8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWsF7jIJOslT8s1S7u/8bjnxl+YQ/1ByeQ1ewt/+rY/9WYG7O1ARU2wUEC0MpvUkt
	 nJ29+l60fflZZupPoGJY+iB2n0drXAFhG9mh6pnuMBJb+Q3dWKObeiO7STxE+Fl2lq
	 /KJl7wC7I4QxiKm6M1Zpl1TE/4K8VCzBQpRQArSOLRIrhIRdNuylIsV4o8rCr8jETr
	 eubw6Onv5VRePw33jttvcPvJiaJCMvHFthEnaBXxiGC8xSNdWgKZcgBD+Fs1McLBoa
	 6Zqxp/0BvGVhgeE0KZ5Sh8GsmQJZ+tbuC+UMA/z97aVCaWhHitaOxuz7S+m+nR/Dcu
	 HtgrcvRm/JsRw==
Date: Tue, 23 Dec 2025 16:17:55 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH 17/31] cpuset: Propagate cpuset isolation update to
 workqueue through housekeeping
Message-ID: <aUqyo58-CDReEm10@localhost.localdomain>
References: <20251105210348.35256-1-frederic@kernel.org>
 <20251105210348.35256-18-frederic@kernel.org>
 <e0b3f050-ef2e-478e-9e22-5f800b86ee42@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0b3f050-ef2e-478e-9e22-5f800b86ee42@huaweicloud.com>

Le Thu, Nov 06, 2025 at 08:55:42AM +0800, Chen Ridong a écrit :
> 
> 
> On 2025/11/6 5:03, Frederic Weisbecker wrote:
> > Until now, cpuset would propagate isolated partition changes to
> > workqueues so that unbound workers get properly reaffined.
> > 
> > Since housekeeping now centralizes, synchronize and propagates isolation
> > cpumask changes, perform the work from that subsystem for consolidation
> > and consistency purposes.
> > 
> > For simplification purpose, the target function is adapted to take the
> > new housekeeping mask instead of the isolated mask.
> > 
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  include/linux/workqueue.h |  2 +-
> >  init/Kconfig              |  1 +
> >  kernel/cgroup/cpuset.c    | 14 ++++++--------
> >  kernel/sched/isolation.c  |  4 +++-
> >  kernel/workqueue.c        | 17 ++++++++++-------
> >  5 files changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > index dabc351cc127..a4749f56398f 100644
> > --- a/include/linux/workqueue.h
> > +++ b/include/linux/workqueue.h
> > @@ -588,7 +588,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void);
> >  void free_workqueue_attrs(struct workqueue_attrs *attrs);
> >  int apply_workqueue_attrs(struct workqueue_struct *wq,
> >  			  const struct workqueue_attrs *attrs);
> > -extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
> > +extern int workqueue_unbound_housekeeping_update(const struct cpumask *hk);
> >  
> >  extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
> >  			struct work_struct *work);
> > diff --git a/init/Kconfig b/init/Kconfig
> > index cab3ad28ca49..a1b3a3b66bfc 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1247,6 +1247,7 @@ config CPUSETS
> >  	bool "Cpuset controller"
> >  	depends on SMP
> >  	select UNION_FIND
> > +	select CPU_ISOLATION
> >  	help
> >  	  This option will let you create and manage CPUSETs which
> >  	  allow dynamically partitioning a system into sets of CPUs and
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index b04a4242f2fa..ea102e4695a5 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1392,7 +1392,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
> >  	return isolcpus_updated;
> >  }
> >  
> > -static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
> > +static void update_housekeeping_cpumask(bool isolcpus_updated)
> >  {
> >  	int ret;
> >  
> > @@ -1401,8 +1401,6 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
> >  	if (!isolcpus_updated)
> >  		return;
> >  
> > -	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
> > -	WARN_ON_ONCE(ret < 0);
> >  	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
> >  	WARN_ON_ONCE(ret < 0);
> >  }
> > @@ -1558,7 +1556,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
> >  	list_add(&cs->remote_sibling, &remote_children);
> >  	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
> >  	spin_unlock_irq(&callback_lock);
> > -	update_unbound_workqueue_cpumask(isolcpus_updated);
> > +	update_housekeeping_cpumask(isolcpus_updated);
> >  	cpuset_force_rebuild();
> >  	cs->prs_err = 0;
> >  
> > @@ -1599,7 +1597,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
> >  	compute_excpus(cs, cs->effective_xcpus);
> >  	reset_partition_data(cs);
> >  	spin_unlock_irq(&callback_lock);
> > -	update_unbound_workqueue_cpumask(isolcpus_updated);
> > +	update_housekeeping_cpumask(isolcpus_updated);
> >  	cpuset_force_rebuild();
> >  
> >  	/*
> > @@ -1668,7 +1666,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
> >  	if (xcpus)
> >  		cpumask_copy(cs->exclusive_cpus, xcpus);
> >  	spin_unlock_irq(&callback_lock);
> > -	update_unbound_workqueue_cpumask(isolcpus_updated);
> > +	update_housekeeping_cpumask(isolcpus_updated);
> >  	if (adding || deleting)
> >  		cpuset_force_rebuild();
> >  
> > @@ -2027,7 +2025,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
> >  		WARN_ON_ONCE(parent->nr_subparts < 0);
> >  	}
> >  	spin_unlock_irq(&callback_lock);
> > -	update_unbound_workqueue_cpumask(isolcpus_updated);
> > +	update_housekeeping_cpumask(isolcpus_updated);
> >  
> >  	if ((old_prs != new_prs) && (cmd == partcmd_update))
> >  		update_partition_exclusive_flag(cs, new_prs);
> > @@ -3047,7 +3045,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
> >  	else if (isolcpus_updated)
> >  		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
> >  	spin_unlock_irq(&callback_lock);
> > -	update_unbound_workqueue_cpumask(isolcpus_updated);
> > +	update_housekeeping_cpumask(isolcpus_updated);
> >  
> 
> The patch [1] has been applied to cgroup/for-next, you may have to adapt it.
> 
> [1]:
> https://lore.kernel.org/cgroups/20251105043848.382703-6-longman@redhat.com/T/#u

Right, I just waited for -rc1 to pop-up before doing that.
v5 will follow shortly.

Thanks.

> 
> -- 
> Best regards,
> Ridong
> 

-- 
Frederic Weisbecker
SUSE Labs

