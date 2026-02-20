Return-Path: <cgroups+bounces-14052-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIB7CnI8mGkQDgMAu9opvQ
	(envelope-from <cgroups+bounces-14052-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 11:50:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596A167068
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DED300F5F3
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8F33F36B;
	Fri, 20 Feb 2026 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z0ZaLZ/Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65F33D512
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584485; cv=none; b=gQH8duwZhabJ7uLhCndw0WA8wWoWDAe29fmI/BzUK3kKV0stn6oDCZXVA2S3Yy9fsGVMaePyOwHabhqplTOs1n+6jfkYtDJNYkUtTiFCWoVmTJ/VqTvx2Kc+lqj9OBSghXYsmFqessS0q6ylZS7c+VdiVKA8Yelr5p7xrYxFjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584485; c=relaxed/simple;
	bh=5iZKfGScVG4WQFH1WEOmNQOcU9lX9vGTUc/XSwmCHS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkJ1MHlUYKIGtBWNlLH613ppbVXbJp8IhcB3YRero1mMIJkeHiuvKIAtsnWp5GQdIx5CK5foFYoISrK41g7WqI0axt9rv9hOqPTezo7OMUvfEApVYdg3WleWk9X58kaslNQkgB2svOTkfTHNawz6Ttu1YfWknf93ZD0i2asi6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z0ZaLZ/Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so2962505e9.1
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771584482; x=1772189282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIuh/mqVOC+QEYbxZAPJ2XnAxftipx1GQkPpqjSSnEY=;
        b=Z0ZaLZ/Z15jxRhhlU/T1TsdFD8yl19KrJ2nhHLLrbZI0ZjOC3Dy1rR58QntXxGklf1
         JApbpfJi9dA2Hj1kQ1GOBSpBLx7PgtPKvAbQXpQxh1v12fJMyELQrGWlPcAM6i+xbT6T
         vjcVPoTiDA0vkc3VtU0q6wZM9eg9l58JB38SeL+ZHLq/dA1Nsow8GxtLj3HbS6mZiuKE
         fPTkLZt6y+PES1j/2//57bbjSkFbuUtPTVT6o2OZT2KWOrB0x+elWhRC+X1xBJDiapzi
         VOmVcdb94iFNS8NBw+pU8eFMRI37K3xU4mq2ecItq3xIdNFG0r20CRXAg8EYhHtkYZln
         eLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584482; x=1772189282;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIuh/mqVOC+QEYbxZAPJ2XnAxftipx1GQkPpqjSSnEY=;
        b=s92rZd6HydJ1hYUuKqK5E3YS/c6oqB4lEwqlSmq26wO5KTgzDDxu3baT49sj898KCg
         0smOHeJee0AdF/47akodmBMg+fbTerA18aCiw6BrLwWmT5oEuQ9umKW2ae3mATBH7SrS
         fYsjhQ4/ZlOSpiDPDH9AOsFgG2tpqMn9kr1QcrmCd6X0r1qmQqBz6WpsFWTvBj5cM8wk
         hS0jAL/5naaoJB6qjcjGArfX7SxSDoU7mJWZgKutQgjv+6p6TsnbTnsB46f4+9HkX+6/
         vEa0f9eruFBwp9e2czNP0Sveqix5a55g8AKxEpplBsV+SeCDuITf8xcyLa+1YU+Oj1P+
         VqPw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJmGjBjtVEKF6Rp0WJV2SYL+4U+CPLfaB4t51RTeoiWLcK+/YexQ9+cigm20T1HaFyzdQHnD7@vger.kernel.org
X-Gm-Message-State: AOJu0YznHLRWDfLz6qY70zbJyRCXu1/MI7oUxGkQi5CCGlBXSPp1JXDr
	G6gUOsvohbn5v8zNDI0DNDEMe4GsAQ0PihiTCYw9b8vKFYSB2ZeleHggkH1W8GSbsaZ4jn+ovaj
	d6R+p
X-Gm-Gg: AZuq6aL8LGO4iQWQAOxAZr9htVo8bKqSaA7/AfnCjb+BQu1B/V67EIO20trz3ebTr4I
	6oC+R9JjwWc+jmdIFss4Zqj8GQ7ErP0T7cZLXgD1gBV87lbWRLGuRkhnWd65/HDNEg+o3OOAwBN
	s9ogE94V2xKbuRpRQJQQoe9rGt11KBl4OCOb7VW7syjetPb8khd7BDZ+XAi5DZftOcgYh0+tB1H
	p6eCp6sK4QGn3McrZ48jLjwsVg8YY+AaeDCzWG0X1MYr8hTWFiL+bOKpHoqKKQg+8dXEIo34RQa
	3GyPIt2a7SYVYCG7eSuwTUe9vaatCWY9+OZ+yGWSRhiOiGlzf4LuX5B2JmQbDkysdx3jA77gKVB
	fefwc0n2kUKIlnoyEyPvFkrwTa5YDhaypKVxmsjVcg9afCYWpjTzVeENkDZ4yru4/h3TqicPaWz
	hxVlwuB2WSBOUwUrD93IRzoPgtokv8
X-Received: by 2002:a05:600c:4448:b0:47b:d992:601e with SMTP id 5b1f17b1804b1-48370e2b6bemr278598485e9.2.1771584481843;
        Fri, 20 Feb 2026 02:48:01 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903::e14? ([2001:1a48:8:903::e14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm62652000f8f.18.2026.02.20.02.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 02:48:01 -0800 (PST)
Message-ID: <3f2b985a-2fb0-4d63-9dce-8a9cad8ce464@suse.com>
Date: Fri, 20 Feb 2026 11:48:00 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce QPW for per-cpu operations
To: Marcelo Tosatti <mtosatti@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Frederic Weisbecker <fweisbecker@suse.de>
References: <20260206143430.021026873@redhat.com> <aYs6Ju2G4bm6_tl2@tiehlicka>
 <aYxviLoWsrLqDU7o@tpad> <aYywl1hdBQP2_slo@tiehlicka>
 <aZDw6xI2izFDfuuu@WindFlash> <aZL45yORfkNvS9Rs@tiehlicka>
 <aZcr255pGT3B/eaL@tpad>
From: Vlastimil Babka <vbabka@suse.com>
Content-Language: en-US
In-Reply-To: <aZcr255pGT3B/eaL@tpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,suse.cz,redhat.com,linutronix.de,suse.de];
	TAGGED_FROM(0.00)[bounces-14052-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 9596A167068
X-Rspamd-Action: no action

On 2/19/26 16:27, Marcelo Tosatti wrote:
> On Mon, Feb 16, 2026 at 12:00:55PM +0100, Michal Hocko wrote:
> 
> Michal,
> 
> Again, i don't see how moving operations to happen at return to 
> kernel would help (assuming you are talking about 
> "context_tracking,x86: Defer some IPIs until a user->kernel transition").
> 
> The IPIs in the patchset above can be deferred until user->kernel
> transition because they are TLB flushes, for addresses which do not
> exist on the address space mapping in userspace.
> 
> What are the per-CPU objects in SLUB ?
> 
> struct slab_sheaf {
>         union {
>                 struct rcu_head rcu_head;
>                 struct list_head barn_list;
>                 /* only used for prefilled sheafs */
>                 struct {
>                         unsigned int capacity;
>                         bool pfmemalloc;
>                 };
>         };
>         struct kmem_cache *cache;
>         unsigned int size;
>         int node; /* only used for rcu_sheaf */
>         void *objects[];
> };
> 
> struct slub_percpu_sheaves {
>         local_trylock_t lock;
>         struct slab_sheaf *main; /* never NULL when unlocked */
>         struct slab_sheaf *spare; /* empty or full, may be NULL */
>         struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
> };
> 
> Examples of local CPU operation that manipulates the data structures:
> 1) kmalloc, allocates an object from local per CPU list.
> 2) kfree, returns an object to local per CPU list.
> 
> Examples of an operation that would perform changes on the per-CPU lists 
> remotely:
> kmem_cache_shrink (cache shutdown), kmem_cache_shrink.
> 
> You can't delay either kmalloc (removal of object from per-CPU freelist), 
> or kfree (return of object from per-CPU freelist), or kmem_cache_shrink 
> or kmem_cache_shrink to return to userspace.
> 
> What i missing something here? (or do you have something on your mind
> which i can't see).

Let's try and analyze when we need to do the flushing in SLUB

- memory offline - would anyone do that with isolcpus? if yes, they probably
deserve the disruption

- cache shrinking (mainly from sysfs handler) - not necessary for
correctness, can probably skip cpu if needed, also kinda shooting your own
foot on isolcpu systems

- kmem_cache is being destroyed (__kmem_cache_shutdown()) - this is
important for correctness. destroying caches should be rare, but can't rule
it out

- kvfree_rcu_barrier() - a very tricky one; currently has only a debugging
caller, but that can change

(BTW, see the note in flush_rcu_sheaves_on_cache() and how it relies on the
flush actually happening on the cpu. Won't QPW violate that?)

How would this work with houskeeping on return to userspace approach?

- Would we just walk the list of all caches to flush them? could be
expensive. Would we somehow note only those that need it? That would make
the fast paths do something extra?

- If some other CPU executed kmem_cache_destroy(), it would have to wait for
the isolated cpu returning to userspace. Do we have the means for
synchronizing on that? Would that risk a deadlock? We used to have a
deferred finishing of the destroy for other reasons but were glad to get rid
of it when it was possible, now it might be necessary to revive it?

How would this work with QPW?

- probably fast paths more expensive due to spin lock vs local_trylock_t

- flush_rcu_sheaves_on_cache() needs to be solved safely (see above)

What if we avoid percpu sheaves completely on isolated cpus and instead
allocate/free using the slowpaths?

- It could probably be achieved without affecting fastpaths, as we already
handle bootstrap without sheaves, so it's implemented in a way to not affect
fastpaths.

- Would it slow the isolcpu workloads down too much when they do a syscall?
  - compared to "houskeeping on return to userspace" flushing, maybe not?
Because in that case the syscall starts with sheaves flushed from previous
return, it has to do something expensive to get the initial sheaf, then
maybe will use only on or few objects, then on return has to flush
everything. Likely the slowpath might be faster, unless it allocates/frees
many objects from the same cache.
  - compared to QPW - it would be slower as QPW would mostly retain sheaves
populated, the need for flushes should be very rare

So if we can assume that workloads on isolated cpus make syscalls only
rarely, and when they do they can tolerate them being slower, I think the
"avoid sheaves on isolated cpus" would be the best way here.


