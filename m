Return-Path: <cgroups+bounces-14053-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHJfLCxUmGmSGQMAu9opvQ
	(envelope-from <cgroups+bounces-14053-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 13:31:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C560D1677EA
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13244300BC75
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E532FA10;
	Fri, 20 Feb 2026 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JIjkN21o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719D341AC5
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590695; cv=none; b=qIthdtk/neMI/UXh2ah01AhMhkQuauiJR6K2v7hzwvZefvva/CtOKrXeHNtfauQqngkWWDRigr/vRpEfCw+1zYMtlYsF1dFMES+5T2jCjIKi6XyG2SHjlYpqzWeD2pG0OBfecFs+1QznbOKVlovW3wqqzs5MDHWG3I7q9UYw0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590695; c=relaxed/simple;
	bh=T5POkgsE1VqDjgW6piarSrn23E6zM3xln7UZbhLnXo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjjMlRVL4gD53jj0Duasrwocm7+b5CjjXi06US2kBIpbqY7FBr2WpVam5xaQaIxQ37f+GyAl2ZrX2542VqpBwJrxRSvzWNcAgtYA5f1pDpnNJAYCmj2StH6H6bRGyLnXaB0jK7nncVbzk4wHLDKO9S6TDFvQvjwTPX4LtJadqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JIjkN21o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so22562305e9.2
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771590691; x=1772195491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paC9R7VowpxtjcyveRbHciWvakOZD/98nE1roKe929I=;
        b=JIjkN21oQk7IFYESZXbuJCWap6nAu661v1vImvsNYKNE4tr8J1LxvLE84S/0q0TG+V
         aTyk+NkBCg/MP7EKchQcR2JY/ISNm3pSX0tLBrsbKWeJoxiyuVoA1+ggVfamHuK1K98s
         0/yWiE0Il+jgFxypSWWXF9qt27YsL8P8rJTHJewXSPm9Zq92YcpmlyrP4KWvwd6dE//b
         7H4WkM3FWk700oVmLkv4gmMDSt8H2BcbRv01fX7ra8DxQasJ7i5W1MaIDF6OILL/KMsF
         NYx6e4DWLNi+QM8r/lQR5q3ZjDOXgJZpJP39cuJ531WhoOhGEeCkEg3RyRP78h1W89tm
         H+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771590691; x=1772195491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paC9R7VowpxtjcyveRbHciWvakOZD/98nE1roKe929I=;
        b=KxsEqKcgH5g0ndv05QaEOsseT/YDZdBXpllta44y0cXzq0aI1m966euZTn6/2C5CBt
         bAWnd+iaUpG4qt2+AQYa95ZdvKGC341ga59l6nX2zxNkr9946HjpY7Zhv1NBn13P5/Mf
         uPuxXVH08TX2u5tdT67keo7SF/buXpC57di3JLaKoqTORErjRaYAFXd6KtCJUU5ELNE4
         MTkaFiOBwVC+f4jKJ4Y82/yqFPwEqldymqDPCK4fndFn8gpydHuecxuoSrsbKA+z+G2a
         WcXIUb0NOWtobz1cLCmoikf23XBxZplDLXbNPLDis+jKBdwbeycIPYSUwpYeXT2djOi3
         OTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTgM9f2dbnLDUNp+R7/I7bDr6RylXKvgFRCUUke+czjvDX/IZyQUaqWkux2ijl+f4Kn99bpLKf@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3qlYc6dpvFO0Qdy0mlQpNKbTS3R93Tz4XtkmcQrTpxM/NeQP
	1B7mqFS1B8812Can3aaJHJvbiJiJS4TQdt17+IC8E+nOwEp9oi6oqUtqfAtIxDJwTzM=
X-Gm-Gg: AZuq6aJLmd1hjv67dd2FlB3JS/NMBt+J9RjYjRG/tGBVxirOMfkP5q/dHosadu93B3V
	oRCCtnz3W0UoG7RwdEplw7RhlJ4+LgEdqjNILjOmsoCPun/HP3VfcruvFAUql7nmWsJ5ce7ymH+
	9Pth+Sfy5WDRF11FNzdrQ7KdFh/nA0XsjR9BkUWhYqDOACXGULQLhdmvykQiKX6+81ltOiaeOXT
	CVNgxvFdpexRf3nIpMTDZHhWifrG4UvU0YJPwwIyjAFAH0CyphJCkuqH/cI144r7fiPnsdXoltP
	WVaTQa3dNNovPfZ/RAbn+c7AXVEHmyGUrvwwEqmN/IjWDGGu5D29zx25C3hRnCLnJhPiFdukacq
	zbcBIOW20VDf1Vm2UqagHQhp72eaaOXx2FIlsOJmr08zFyP+UR1YNnCC2i6gbwilD+50nwCcVo1
	l3YcWViUXr5yO4Zlp1ksHadjJ+t0WkP4LLX0O7vmKjpw==
X-Received: by 2002:a05:600c:3e14:b0:483:7783:5363 with SMTP id 5b1f17b1804b1-48398b6e214mr129218225e9.26.1771590691440;
        Fri, 20 Feb 2026 04:31:31 -0800 (PST)
Received: from localhost (109-81-84-7.rct.o2.cz. [109.81.84.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a74704sm59690480f8f.16.2026.02.20.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 04:31:31 -0800 (PST)
Date: Fri, 20 Feb 2026 13:31:29 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <aZhUIbpWF7z5HOMr@tiehlicka>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14053-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,linutronix.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: C560D1677EA
X-Rspamd-Action: no action

On Fri 20-02-26 11:48:00, Vlastimil Babka wrote:
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
> 
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

Thanks, this is a very useful insight.
 
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

This would be tricky because there is no time guarantee when isolated
workload enters the kernel again. Maybe never if all the
pre-initialization was sufficient. On the other hand if the flush
happens on the way to userspace then you only need to wait for the
isolated workload to return from a syscall (modulo task dying and
similar edge cases).
 
> How would this work with QPW?
> 
> - probably fast paths more expensive due to spin lock vs local_trylock_t
> 
> - flush_rcu_sheaves_on_cache() needs to be solved safely (see above)
> 
> What if we avoid percpu sheaves completely on isolated cpus and instead
> allocate/free using the slowpaths?

That seems like a reasonable performance price to pay for very edge case
(isolated workload).
-- 
Michal Hocko
SUSE Labs

