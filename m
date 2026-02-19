Return-Path: <cgroups+bounces-14018-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAzRDZMsl2nmvQIAu9opvQ
	(envelope-from <cgroups+bounces-14018-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 16:30:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEF01602A1
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 765E83072A77
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8244346ACE;
	Thu, 19 Feb 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICvb1KxB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A9346A04
	for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514916; cv=none; b=KC9rW4+szSCV+sbkAXW8WES2juDQrDGTU2L0FwaOUoUEtYdLx5ljENeHwq8glA03JuPvF/P9tPuA+qlS34YzAqhReTGdqcQya5Vupe/Sbt2M4KS5NwgXqIshhC1y9WCINKKuxsOn0AwpfucTPbTkzyVgPARHHKjnhmdSa10BVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514916; c=relaxed/simple;
	bh=y1YfRDaS/B2wxgxzJhU9jwQbs5u5h1dbTcp4HFH8Xe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXo7kf96OHwbI/mT2WSLjvUNncAEc8/7dU+nEH3I/l6FI5gZE/Iodwmh5+g8cf2p7yFmxNTXHBtdkXRZJEykx/Pr42y7mMLHfFG0yS9En1yh0KyfHf7jDsGlkYc6D2mgoZbM1tZIgQRfhLhPqDY0k6CFja1NF12oFwLncxrbhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICvb1KxB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771514914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fOn9mbgWLfiu0CBe21NitF6R9PRIUFVeZ7gu3te+hp0=;
	b=ICvb1KxByhfLSdlB7RyScx1dbs5YQZC6ToGITFqlwan/3b4UfaTLqwCK+zvNAw37Uh9E+x
	+736xqVE96xHzk8wT4RXOvrZSNkljz5ql8NPMRIDH7ly83god7oN0WOGFWT1hHSeThs5/Z
	d+OGinNiT4YM7MGBQaUUJ38b5diTULE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-yXcD8B0TNmmJdn3IohuKgw-1; Thu,
 19 Feb 2026 10:28:31 -0500
X-MC-Unique: yXcD8B0TNmmJdn3IohuKgw-1
X-Mimecast-MFC-AGG-ID: yXcD8B0TNmmJdn3IohuKgw_1771514909
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B545E180025E;
	Thu, 19 Feb 2026 15:28:28 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA3121955F26;
	Thu, 19 Feb 2026 15:28:26 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id AD065405281A6; Thu, 19 Feb 2026 12:27:23 -0300 (-03)
Date: Thu, 19 Feb 2026 12:27:23 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <aZcr255pGT3B/eaL@tpad>
References: <20260206143430.021026873@redhat.com>
 <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad>
 <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash>
 <aZL45yORfkNvS9Rs@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZL45yORfkNvS9Rs@tiehlicka>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14018-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9BEF01602A1
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> On Sat 14-02-26 19:02:19, Leonardo Bras wrote:
> > On Wed, Feb 11, 2026 at 05:38:47PM +0100, Michal Hocko wrote:
> > > On Wed 11-02-26 09:01:12, Marcelo Tosatti wrote:
> > > > On Tue, Feb 10, 2026 at 03:01:10PM +0100, Michal Hocko wrote:
> > > [...]
> > > > > What about !PREEMPT_RT? We have people running isolated workloads and
> > > > > these sorts of pcp disruptions are really unwelcome as well. They do not
> > > > > have requirements as strong as RT workloads but the underlying
> > > > > fundamental problem is the same. Frederic (now CCed) is working on
> > > > > moving those pcp book keeping activities to be executed to the return to
> > > > > the userspace which should be taking care of both RT and non-RT
> > > > > configurations AFAICS.
> > > > 
> > > > Michal,
> > > > 
> > > > For !PREEMPT_RT, _if_ you select CONFIG_QPW=y, then there is a kernel
> > > > boot option qpw=y/n, which controls whether the behaviour will be
> > > > similar (the spinlock is taken on local_lock, similar to PREEMPT_RT).
> > > 
> > > My bad. I've misread the config space of this.
> > > 
> > > > If CONFIG_QPW=n, or kernel boot option qpw=n, then only local_lock 
> > > > (and remote work via work_queue) is used.
> > > > 
> > > > What "pcp book keeping activities" you refer to ? I don't see how
> > > > moving certain activities that happen under SLUB or LRU spinlocks
> > > > to happen before return to userspace changes things related 
> > > > to avoidance of CPU interruption ?
> > > 
> > > Essentially delayed operations like pcp state flushing happens on return
> > > to the userspace on isolated CPUs. No locking changes are required as
> > > the work is still per-cpu.
> > > 
> > > In other words the approach Frederic is working on is to not change the
> > > locking of pcp delayed work but instead move that work into well defined
> > > place - i.e. return to the userspace.
> > > 
> > > Btw. have you measure the impact of preempt_disbale -> spinlock on hot
> > > paths like SLUB sheeves?
> > 
> > Hi Michal,
> > 
> > I have done some study on this (which I presented on Plumbers 2023):
> > https://lpc.events/event/17/contributions/1484/ 
> > 
> > Since they are per-cpu spinlocks, and the remote operations are not that 
> > frequent, as per design of the current approach, we are not supposed to see 
> > contention (I was not able to detect contention even after stress testing 
> > for weeks), nor relevant cacheline bouncing.
> > 
> > That being said, for RT local_locks already get per-cpu spinlocks, so there 
> > is only difference for !RT, which as you mention, does preemtp_disable():
> > 
> > The performance impact noticed was mostly about jumping around in 
> > executable code, as inlining spinlocks (test #2 on presentation) took care 
> > of most of the added extra cycles, adding about 4-14 extra cycles per 
> > lock/unlock cycle. (tested on memcg with kmalloc test)
> > 
> > Yeah, as expected there is some extra cycles, as we are doing extra atomic 
> > operations (even if in a local cacheline) in !RT case, but this could be 
> > enabled only if the user thinks this is an ok cost for reducing 
> > interruptions.
> > 
> > What do you think?
> 
> The fact that the behavior is opt-in for !RT is certainly a plus. I also
> do not expect the overhead to be really be really big. To me, a much
> more important question is which of the two approaches is easier to
> maintain long term. The pcp work needs to be done one way or the other.
> Whether we want to tweak locking or do it at a very well defined time is
> the bigger question.
> -- 
> Michal Hocko
> SUSE Labs

Michal,

Again, i don't see how moving operations to happen at return to 
kernel would help (assuming you are talking about 
"context_tracking,x86: Defer some IPIs until a user->kernel transition").

The IPIs in the patchset above can be deferred until user->kernel
transition because they are TLB flushes, for addresses which do not
exist on the address space mapping in userspace.

What are the per-CPU objects in SLUB ?

struct slab_sheaf {
        union {
                struct rcu_head rcu_head;
                struct list_head barn_list;
                /* only used for prefilled sheafs */
                struct {
                        unsigned int capacity;
                        bool pfmemalloc;
                };
        };
        struct kmem_cache *cache;
        unsigned int size;
        int node; /* only used for rcu_sheaf */
        void *objects[];
};

struct slub_percpu_sheaves {
        local_trylock_t lock;
        struct slab_sheaf *main; /* never NULL when unlocked */
        struct slab_sheaf *spare; /* empty or full, may be NULL */
        struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
};

Examples of local CPU operation that manipulates the data structures:
1) kmalloc, allocates an object from local per CPU list.
2) kfree, returns an object to local per CPU list.

Examples of an operation that would perform changes on the per-CPU lists 
remotely:
kmem_cache_shrink (cache shutdown), kmem_cache_shrink.

You can't delay either kmalloc (removal of object from per-CPU freelist), 
or kfree (return of object from per-CPU freelist), or kmem_cache_shrink 
or kmem_cache_shrink to return to userspace.

What i missing something here? (or do you have something on your mind
which i can't see).


