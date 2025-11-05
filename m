Return-Path: <cgroups+bounces-11605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A775C37008
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FE755042A2
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519833B94A;
	Wed,  5 Nov 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkrNSQmV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C82339B47;
	Wed,  5 Nov 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361823; cv=none; b=KI42riCZ+1kvSEJWiQlcpKxeSkjsiwgXRQ2fEFbTax+ndc+t3Tq9vkXi0Mu2lH5uLDD6ky/3djDgEB23ujS+8UZWr68dEwHLRMZKvkJG+hbRkEi+GupPynq9LxMVgPCTf0kQSPtej1yoec0884LZYdWutY2S/1ifMxgaDg37yiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361823; c=relaxed/simple;
	bh=nhM7jbKOW56d3hh/niEe2UapYbSyWoAGZQptKDlqI44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1hfKE5NVqdKsc4ZknTJnrLkEa4O5D5/3VygawME0wtKJojxW1IWucyeMJEDtICSvKb4zqtPZxVINLA/2eBPKGB2MsAikfy4ozndQvzrc9rM6jXtO+zuM0Ly9kaCb2XwYV76MUcG5j+GOj/v2DCjOoCVWcYNIzc3DUyyrJNeSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkrNSQmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FC2C4CEF5;
	Wed,  5 Nov 2025 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762361823;
	bh=nhM7jbKOW56d3hh/niEe2UapYbSyWoAGZQptKDlqI44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkrNSQmVRGDQ0lt4n06gp9o429LO1OThSwSo+tIIP2EJBJlS8ww/ro7sMmGiVdhrM
	 t1rgH6uGlaXnjmVa+q0tT6T/wHZzevQNMI/p1TJa24pvFPEM/3OqPC7DF47OIz9o9m
	 rS7nbd/l2kvzZuGV09bu3MD4TN55uh1avGCcK3xopWmiC5ZLktsFp0az7HaETHuJoY
	 Vh1Stje19/PGgTlt9Jb499Vr+Bcz3Vt9T3rYp8qWR+6Y0CAW4VMy94J4OlikA0BiAP
	 dy2pVF6eF1/01q9zF36JMleysXGqAX5oXg57tsMBxZrtmIJQPGP9L3s7oIbUpsJ6fD
	 yvwf0f0RHi11g==
Date: Wed, 5 Nov 2025 17:57:00 +0100
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
Subject: Re: [PATCH 22/33] kthread: Include unbound kthreads in the managed
 affinity list
Message-ID: <aQuB3Oy7i6Z0SJlA@localhost.localdomain>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-23-frederic@kernel.org>
 <ba437129-062a-4a2f-a753-64945e9a13ff@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba437129-062a-4a2f-a753-64945e9a13ff@redhat.com>

Le Tue, Oct 21, 2025 at 06:42:59PM -0400, Waiman Long a écrit :
> 
> On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> > The managed affinity list currently contains only unbound kthreads that
> > have affinity preferences. Unbound kthreads globally affine by default
> > are outside of the list because their affinity is automatically managed
> > by the scheduler (through the fallback housekeeping mask) and by cpuset.
> > 
> > However in order to preserve the preferred affinity of kthreads, cpuset
> > will delegate the isolated partition update propagation to the
> > housekeeping and kthread code.
> > 
> > Prepare for that with including all unbound kthreads in the managed
> > affinity list.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   kernel/kthread.c | 59 ++++++++++++++++++++++++------------------------
> >   1 file changed, 30 insertions(+), 29 deletions(-)
> > 
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index c4dd967e9e9c..cba3d297f267 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -365,9 +365,10 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
> >   	if (kthread->preferred_affinity) {
> >   		pref = kthread->preferred_affinity;
> >   	} else {
> > -		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
> > -			return;
> > -		pref = cpumask_of_node(kthread->node);
> > +		if (kthread->node == NUMA_NO_NODE)
> > +			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
> > +		else
> > +			pref = cpumask_of_node(kthread->node);
> >   	}
> >   	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
> > @@ -380,32 +381,29 @@ static void kthread_affine_node(void)
> >   	struct kthread *kthread = to_kthread(current);
> >   	cpumask_var_t affinity;
> > -	WARN_ON_ONCE(kthread_is_per_cpu(current));
> > +	if (WARN_ON_ONCE(kthread_is_per_cpu(current)))
> > +		return;
> > -	if (kthread->node == NUMA_NO_NODE) {
> > -		housekeeping_affine(current, HK_TYPE_KTHREAD);
> > -	} else {
> > -		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> > -			WARN_ON_ONCE(1);
> > -			return;
> > -		}
> > -
> > -		mutex_lock(&kthread_affinity_lock);
> > -		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> > -		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> > -		/*
> > -		 * The node cpumask is racy when read from kthread() but:
> > -		 * - a racing CPU going down will either fail on the subsequent
> > -		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> > -		 *   afterwards by the scheduler.
> > -		 * - a racing CPU going up will be handled by kthreads_online_cpu()
> > -		 */
> > -		kthread_fetch_affinity(kthread, affinity);
> > -		set_cpus_allowed_ptr(current, affinity);
> > -		mutex_unlock(&kthread_affinity_lock);
> > -
> > -		free_cpumask_var(affinity);
> > +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> > +		WARN_ON_ONCE(1);
> > +		return;
> >   	}
> > +
> > +	mutex_lock(&kthread_affinity_lock);
> > +	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> > +	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> > +	/*
> > +	 * The node cpumask is racy when read from kthread() but:
> > +	 * - a racing CPU going down will either fail on the subsequent
> > +	 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> > +	 *   afterwards by the scheduler.
> > +	 * - a racing CPU going up will be handled by kthreads_online_cpu()
> > +	 */
> > +	kthread_fetch_affinity(kthread, affinity);
> > +	set_cpus_allowed_ptr(current, affinity);
> > +	mutex_unlock(&kthread_affinity_lock);
> > +
> > +	free_cpumask_var(affinity);
> >   }
> >   static int kthread(void *_create)
> > @@ -924,8 +922,11 @@ static int kthreads_online_cpu(unsigned int cpu)
> >   			ret = -EINVAL;
> >   			continue;
> >   		}
> > -		kthread_fetch_affinity(k, affinity);
> > -		set_cpus_allowed_ptr(k->task, affinity);
> > +
> > +		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> > +			kthread_fetch_affinity(k, affinity);
> > +			set_cpus_allowed_ptr(k->task, affinity);
> > +		}
> >   	}
> 
> My understanding of kthreads_online_cpu() is that hotplug won't affect the
> affinity returned from kthread_fetch_affinity().

It should. The onlining CPU is considered online at this point and might
be part of the returned kthread_fetch_affinity().

> However, set_cpus_allowed_ptr() will mask out all the offline CPUs. So if the given
> "cpu" to be brought online is in the returned affinity, we should call
> set_cpus_allowed_ptr() to add this cpu into its affinity mask though the
> current code will call it even it is not strictly necessary.

I'm not sure I understand what you mean.

> This change will not do this update to NUMA_NO_NODE kthread with no preferred_affinity,
> is this a problem?

Ah, so unbound kthreads without preferred affinity are already affine to all
possible CPUs (or housekeeping), whether those CPUs are online or not. So we
don't need to add newly online CPUs to them.

kthreads with a preferred affinity or node are different because if none of
their preferred CPUs are online, they must be affine to housekeeping. But as
soon as one of their preferred CPU becomes online, they must be affine to them.

Hence the different treatment. I'm adding a big comment to explain that.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

