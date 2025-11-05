Return-Path: <cgroups+bounces-11604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 925CAC36C9B
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 17:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CB544FC082
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD43358C0;
	Wed,  5 Nov 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJvV3Gcj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9320B800;
	Wed,  5 Nov 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360572; cv=none; b=X8d/iZeaHbZ+rAWTEJaMID2DuzjbO7/Kv2l4ioiFR42VPzZSj/DisDJA+33fqI+tNnJlQHm6HZ0LOQDc1NF+1W32upSB9oPVyMY1RuFFQHeXXzoLMXwdC2yAcxhL5oGTAzcUkePQ9rWV42VpmZuVhotw9jc5aovpekSvO0kq8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360572; c=relaxed/simple;
	bh=6TrJvUK9Bi4MtE396O6mjFvQ4XSVRdM4jTat1mqDJ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNuv9Ah7ucsJKaM+9SOIK3+gk4AK2WmuqpJC0DBwpPSXdGBVprNbZnq5nbR4gCKmzfZHPiEpVP2qSHgvT02yiPTdkQt89Tif0WSxtNGOcbZD+i09jKKSuCjaaZT5mxObvU/1XIlw2DCll3EjJJC2hlnOm8tCmhEfl44A4v/Uq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJvV3Gcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E76C116D0;
	Wed,  5 Nov 2025 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762360572;
	bh=6TrJvUK9Bi4MtE396O6mjFvQ4XSVRdM4jTat1mqDJ+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJvV3GcjxVMkbPp2/HPHTvVQ3suklWsEfheD+VTVjPqA9H4nzGbxr2Z/oMCnFchhM
	 hx0phKZelWW3iUoT74SWOR0eAm/GMDUMSFZuJwRx3xLLzarjdMxhpnjROdsmqC1Bz9
	 MmxSP1G8Pm7sZ6X9Aw3/6NWdF7ILo/dLtzKjptrZcQKyjuY5ue+jqOiVpPmYroetzt
	 pSWR0IX5HMGCyAHJeRFyG1+DMWcS1izzqvM9K89t6srVDOjWc2wPYOBV+rjwy9RPKh
	 A6Jk4/1Jh9oT6si2+yJ2cfyT73UhwGEh/7aY2SdorDojoRR9eU1sKBBAVl6FGvx5cd
	 7YvIKTyAlo22A==
Date: Wed, 5 Nov 2025 17:36:09 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
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
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 18/33] cpuset: Remove cpuset_cpu_is_isolated()
Message-ID: <aQt8-dzr4Ac3l3bt@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-19-frederic@kernel.org>
 <7821fb40-5082-4d11-b539-4c5abc2e572c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7821fb40-5082-4d11-b539-4c5abc2e572c@redhat.com>

Le Wed, Oct 29, 2025 at 02:05:17PM -0400, Waiman Long a écrit :
> On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> > The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
> > housekeeping cpumask. There is no usecase left interested in just
> > checking what is isolated by cpuset and not by the isolcpus= kernel
> > boot parameter.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   include/linux/cpuset.h          |  6 ------
> >   include/linux/sched/isolation.h |  3 +--
> >   kernel/cgroup/cpuset.c          | 12 ------------
> >   3 files changed, 1 insertion(+), 20 deletions(-)
> > 
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 051d36fec578..a10775a4f702 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -78,7 +78,6 @@ extern void cpuset_lock(void);
> >   extern void cpuset_unlock(void);
> >   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
> >   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> > -extern bool cpuset_cpu_is_isolated(int cpu);
> >   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
> >   #define cpuset_current_mems_allowed (current->mems_allowed)
> >   void cpuset_init_current_mems_allowed(void);
> > @@ -208,11 +207,6 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
> >   	return false;
> >   }
> > -static inline bool cpuset_cpu_is_isolated(int cpu)
> > -{
> > -	return false;
> > -}
> > -
> >   static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
> >   {
> >   	return node_possible_map;
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index 94d5c835121b..0f50c152cf68 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -76,8 +76,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> >   static inline bool cpu_is_isolated(int cpu)
> >   {
> >   	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> > -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
> > -	       cpuset_cpu_is_isolated(cpu);
> > +	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> >   }
> 
> You can also remove the "<linux/cpuset.h>" include from isolation.h which
> was added by commit 3232e7aad11e5 ("cgroup/cpuset: Include isolated cpuset
> CPUs in cpu_is_isolated() check") which introduces cpuset_cpu_is_isolated().

Done. Thanks!

-- 
Frederic Weisbecker
SUSE Labs

