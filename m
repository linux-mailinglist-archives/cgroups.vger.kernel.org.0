Return-Path: <cgroups+bounces-14060-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMCJGZWbmGkTKAMAu9opvQ
	(envelope-from <cgroups+bounces-14060-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:36:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E9C169C0F
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20576304A30B
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62501365A12;
	Fri, 20 Feb 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk4/g+sk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC41365A10
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608978; cv=none; b=JvWfCfg4DKVImK2QMJ5PfzrhM7ubgbUe8/qd8pXsiKm4lCz++Fg9sHiw8C9/lqj4hKnfJZeuClSUVT73376YX1VVBXRN1fXxqF2rZmTMMwIa6QWTgyy58rJvSNMGTBwTmWO1w6FDpIzl/l2cD5yfeuFtQaPURgqwIWyc6f4tlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608978; c=relaxed/simple;
	bh=NugPw72MOwfm33ElpPfIIe5OdoblLhaj8Ii5u02un4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CylhHve4gOuRwOf1BgSHSb3MCsUbvjdYDet16h/t1NtL5PRFBPW1CtYpL2bf8bhtGgUNsA50dhnedAvEG3TsfHbiM5Z9ri9rkQ7nQcZkVHeMXoYNjJ2gMNvbholvb4TElCpma5c75gVnOPLA0iG7cWRCC0929ryuxCSGj7GklUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wk4/g+sk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771608975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IqjOdiofWjjCWCfPy8j7WH4t5XK2/Efigokxu3dvlE=;
	b=Wk4/g+skn6TAc44DSwAhpbGG5L9WR9ycM/lS5m+NhCm9Kh8ntJDNzXnM9jNYYWnwdem0ri
	w7x+ycKiBhR4sdlx4+AM1mGCnEpsL/TWv9bfurDwxBKSiKCGEUovJFTW6/t+B+xNDA28UU
	qyafBOkEgWPNtVCjFf78se4vGNUFkxg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-GCy-qzgoOVO6a-GZTQQOwQ-1; Fri,
 20 Feb 2026 12:36:11 -0500
X-MC-Unique: GCy-qzgoOVO6a-GZTQQOwQ-1
X-Mimecast-MFC-AGG-ID: GCy-qzgoOVO6a-GZTQQOwQ_1771608969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F65719560A3;
	Fri, 20 Feb 2026 17:36:08 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF4231800348;
	Fri, 20 Feb 2026 17:36:06 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id BD690400DC5A8; Fri, 20 Feb 2026 14:35:41 -0300 (-03)
Date: Fri, 20 Feb 2026 14:35:41 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Vlastimil Babka <vbabka@suse.com>
Cc: Michal Hocko <mhocko@suse.com>, Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <fweisbecker@suse.de>
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
Message-ID: <aZibbYH7yrDZlnJh@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
 <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14060-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quantvps.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3E9C169C0F
X-Rspamd-Action: no action

Hi Vlastimil,

On Fri, Feb 20, 2026 at 11:48:00AM +0100, Vlastimil Babka wrote:
> On 2/19/26 16:27, Marcelo Tosatti wrote:
> > On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> > 
> > Michal,
> > 
> > Again, i don't see how moving operations to happen at return to 
> > kernel would help (assuming you are talking about 
> > "context_tracking,x86: Defer some IPIs until a user->kernel transition").
> > 
> > The IPIs in the patchset above can be deferred until user->kernel
> > transition because they are TLB flushes, for addresses which do not
> > exist on the address space mapping in userspace.
> > 
> > What are the per-CPU objects in SLUB ?
> > 
> > struct slab_sheaf {
> >         union {
> >                 struct rcu_head rcu_head;
> >                 struct list_head barn_list;
> >                 /* only used for prefilled sheafs */
> >                 struct {
> >                         unsigned int capacity;
> >                         bool pfmemalloc;
> >                 };
> >         };
> >         struct kmem_cache *cache;
> >         unsigned int size;
> >         int node; /* only used for rcu_sheaf */
> >         void *objects[];
> > };
> > 
> > struct slub_percpu_sheaves {
> >         local_trylock_t lock;
> >         struct slab_sheaf *main; /* never NULL when unlocked */
> >         struct slab_sheaf *spare; /* empty or full, may be NULL */
> >         struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
> > };
> > 
> > Examples of local CPU operation that manipulates the data structures:
> > 1) kmalloc, allocates an object from local per CPU list.
> > 2) kfree, returns an object to local per CPU list.
> > 
> > Examples of an operation that would perform changes on the per-CPU lists 
> > remotely:
> > kmem_cache_shrink (cache shutdown), kmem_cache_shrink.
> > 
> > You can't delay either kmalloc (removal of object from per-CPU freelist), 
> > or kfree (return of object from per-CPU freelist), or kmem_cache_shrink 
> > or kmem_cache_shrink to return to userspace.
> > 
> > What i missing something here? (or do you have something on your mind
> > which i can't see).
> 
> Let's try and analyze when we need to do the flushing in SLUB
> 
> - memory offline - would anyone do that with isolcpus? if yes, they probably
> deserve the disruption

I think its OK to avoid memory offline on such systems.

> - cache shrinking (mainly from sysfs handler) - not necessary for
> correctness, can probably skip cpu if needed, also kinda shooting your own
> foot on isolcpu systems
> 
> - kmem_cache is being destroyed (__kmem_cache_shutdown()) - this is
> important for correctness. destroying caches should be rare, but can't rule
> it out
> 
> - kvfree_rcu_barrier() - a very tricky one; currently has only a debugging
> caller, but that can change
> 
> (BTW, see the note in flush_rcu_sheaves_on_cache() and how it relies on the
> flush actually happening on the cpu. Won't QPW violate that?)

(struct kmem_cache *s)->cpu_sheaves (percpu)->rcu_free with the
s->cpu_sheaves->lock lock held:

do_free:

        rcu_sheaf = pcs->rcu_free;

        /*
         * Since we flush immediately when size reaches capacity, we never reach
         * this with size already at capacity, so no OOB write is possible.
         */
        rcu_sheaf->objects[rcu_sheaf->size++] = obj;

        if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
                rcu_sheaf = NULL;
        } else {
                pcs->rcu_free = NULL;
                rcu_sheaf->node = numa_mem_id();
        }

        /*
         * we flush before local_unlock to make sure a racing
         * flush_all_rcu_sheaves() doesn't miss this sheaf
         */
        if (rcu_sheaf)
                call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);

        qpw_unlock(&s->cpu_sheaves->lock, cpu);

So if it invokes call_rcu, it sets pcs->rcu_free = NULL. In that case,
for flush_rcu_sheaf executing remotely from flush_rcu_sheaves_on_cache
will:

static void flush_rcu_sheaf(struct work_struct *w)
{
        struct slub_percpu_sheaves *pcs;
        struct slab_sheaf *rcu_free;
        struct slub_flush_work *sfw;
        struct kmem_cache *s;
        int cpu = qpw_get_cpu(w);

        sfw = &per_cpu(slub_flush, cpu);
        s = sfw->s;

        qpw_lock(&s->cpu_sheaves->lock, cpu);
        pcs = per_cpu_ptr(s->cpu_sheaves, cpu);

        rcu_free = pcs->rcu_free;
        pcs->rcu_free = NULL;

        qpw_unlock(&s->cpu_sheaves->lock, cpu);

        if (rcu_free)
                call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
}

Only call rcu_free_sheaf_nobarn if pcs->rcu_free is not NULL.

So it seems safe?

> How would this work with houskeeping on return to userspace approach?
> 
> - Would we just walk the list of all caches to flush them? could be
> expensive. Would we somehow note only those that need it? That would make
> the fast paths do something extra?
> 
> - If some other CPU executed kmem_cache_destroy(), it would have to wait for
> the isolated cpu returning to userspace. Do we have the means for
> synchronizing on that? Would that risk a deadlock? We used to have a
> deferred finishing of the destroy for other reasons but were glad to get rid
> of it when it was possible, now it might be necessary to revive it?

I don't think you can expect system calls to return to userspace in 
a given amount of time. Could be in kernel mode for long periods of
time.

> How would this work with QPW?
> 
> - probably fast paths more expensive due to spin lock vs local_trylock_t
> 
> - flush_rcu_sheaves_on_cache() needs to be solved safely (see above)
> 
> What if we avoid percpu sheaves completely on isolated cpus and instead
> allocate/free using the slowpaths?
> 
> - It could probably be achieved without affecting fastpaths, as we already
> handle bootstrap without sheaves, so it's implemented in a way to not affect
> fastpaths.
> 
> - Would it slow the isolcpu workloads down too much when they do a syscall?
>   - compared to "houskeeping on return to userspace" flushing, maybe not?
> Because in that case the syscall starts with sheaves flushed from previous
> return, it has to do something expensive to get the initial sheaf, then
> maybe will use only on or few objects, then on return has to flush
> everything. Likely the slowpath might be faster, unless it allocates/frees
> many objects from the same cache.
>   - compared to QPW - it would be slower as QPW would mostly retain sheaves
> populated, the need for flushes should be very rare
> 
> So if we can assume that workloads on isolated cpus make syscalls only
> rarely, and when they do they can tolerate them being slower, I think the
> "avoid sheaves on isolated cpus" would be the best way here.

I am not sure its safe to assume that. Ask Gemini about isolcpus use
cases and:

1. High-Frequency Trading (HFT)
In the world of HFT, microseconds are the difference between profit and loss. 
Traders use isolcpus to pin their execution engines to specific cores.

The Goal: Eliminate "jitter" caused by the OS moving other processes onto the same core.

The Benefit: Guaranteed execution time and ultra-low latency.

2. Real-Time Audio & Video Processing
If you are running a Digital Audio Workstation (DAW) or a live video encoding rig, a tiny "hiccup" in CPU availability results in an audible pop or a dropped frame.

The Goal: Reserve cores specifically for the Digital Signal Processor (DSP) or the encoder.

The Benefit: Smooth, glitch-free media streams even when the rest of the system is busy.

3. Network Function Virtualization (NFV) & DPDK
For high-speed networking (like 10Gbps+ traffic), the Data Plane Development Kit (DPDK) uses "poll mode" drivers. These drivers constantly loop to check for new packets rather than waiting for interrupts.

The Goal: Isolate cores so they can run at 100% utilization just checking for network packets.

The Benefit: Maximum throughput and zero packet loss in high-traffic environments.

4. Gaming & Simulation
Competitive gamers or flight simulator enthusiasts sometimes isolate a few cores to handle the game's main thread, while leaving the rest of the OS (Discord, Chrome, etc.) to the remaining cores.

The Goal: Prevent background Windows/Linux tasks from stealing cycles from the game engine.

The Benefit: More consistent 1% low FPS and reduced input lag.

5. Deterministic Scientific Computing
If you're running a simulation that needs to take exactly the same amount of time every time it runs (for benchmarking or safety-critical testing), you can't have the OS interference messing with your metrics.

The Goal: Remove the variability of the Linux scheduler.

The Benefit: Highly repeatable, deterministic results.

===

For example, AF_XDP bypass uses system calls (and wants isolcpus):

https://www.quantvps.com/blog/kernel-bypass-in-hft?srsltid=AfmBOoryeSxuuZjzTJIC9O-Ag8x4gSwjs-V4Xukm2wQpGmwDJ6t4szuE



