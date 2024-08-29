Return-Path: <cgroups+bounces-4558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12929964074
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B17A1F26322
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EFF18DF7A;
	Thu, 29 Aug 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PkN/TZk6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BuuYwzT4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PkN/TZk6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BuuYwzT4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE918DF61;
	Thu, 29 Aug 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924534; cv=none; b=WBJVcel0nc0z6D3uiqG/35B2Y5C4Ts3tpkr6Tu+izkZsFXj+GAeKPa4jpStOjFLu6lBBpHhzOJnn4LZkqmVr56/1aZ8tjI53YbLgwKh0I1iD4zKfvc1tGZra0w/52XDdNAUo7xUSMpqx1CeAhX9fwuerh9pmhU6iYKuna6jg7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924534; c=relaxed/simple;
	bh=rFolyB2smdEOAep94giA8o5Dk/FEUMS2Tx07rsuGejE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqPqX0HjE8hNMRn+Nkkj4EUE70gTTCYOemeJMCBLD/FpTNMH1UDEAwhxcqB2CoTupS1wb369bBgqQjfpp4tbK0VIBewdPjhTUAXmiRVEx7VESvV+fLNBi8E5U4gmSrFLfegdbfDcLCukZSZpr25qF/YsPSPD+ht7MYOp0V3AWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PkN/TZk6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BuuYwzT4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PkN/TZk6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BuuYwzT4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74EAE1FD10;
	Thu, 29 Aug 2024 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724924530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eisbvYeW6pkGrS9GN7zICg04QZo4gvnmxaiNhSyOy9s=;
	b=PkN/TZk649FNGZA9OoNowHx4iHVBRospOWu//FKW+anrVa3/rTEdvJRVCpKcvT/NRx+FJT
	qbFoSvoN37c0O3qDQ5oz0zpX60DeVz2PHuc7HRlO14eAzkTEzgwartOGmEiZBOa1cOl1LJ
	o9Qeho5UShUl7dPObNoWt1QuWyNmsxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724924530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eisbvYeW6pkGrS9GN7zICg04QZo4gvnmxaiNhSyOy9s=;
	b=BuuYwzT4MG2Y/GEUZqamtViymPseIxwNijuSC8/dR7eK1rYferY7pU/ucoGZSq8EgrJTPC
	xnhZZTjdg1qR/UCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="PkN/TZk6";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BuuYwzT4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724924530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eisbvYeW6pkGrS9GN7zICg04QZo4gvnmxaiNhSyOy9s=;
	b=PkN/TZk649FNGZA9OoNowHx4iHVBRospOWu//FKW+anrVa3/rTEdvJRVCpKcvT/NRx+FJT
	qbFoSvoN37c0O3qDQ5oz0zpX60DeVz2PHuc7HRlO14eAzkTEzgwartOGmEiZBOa1cOl1LJ
	o9Qeho5UShUl7dPObNoWt1QuWyNmsxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724924530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eisbvYeW6pkGrS9GN7zICg04QZo4gvnmxaiNhSyOy9s=;
	b=BuuYwzT4MG2Y/GEUZqamtViymPseIxwNijuSC8/dR7eK1rYferY7pU/ucoGZSq8EgrJTPC
	xnhZZTjdg1qR/UCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5094D13408;
	Thu, 29 Aug 2024 09:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vSFXE3JC0GZLdgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 29 Aug 2024 09:42:10 +0000
Message-ID: <9fb06d9b-dec5-4300-acef-bbce51a9a0c1@suse.cz>
Date: Thu, 29 Aug 2024 11:42:10 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240827235228.1591842-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 74EAE1FD10
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,google.com,gmail.com,davemloft.net,redhat.com,kvack.org,vger.kernel.org,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 8/28/24 01:52, Shakeel Butt wrote:
> At the moment, the slab objects are charged to the memcg at the
> allocation time. However there are cases where slab objects are
> allocated at the time where the right target memcg to charge it to is
> not known. One such case is the network sockets for the incoming
> connection which are allocated in the softirq context.
> 
> Couple hundred thousand connections are very normal on large loaded
> server and almost all of those sockets underlying those connections get
> allocated in the softirq context and thus not charged to any memcg.
> However later at the accept() time we know the right target memcg to
> charge. Let's add new API to charge already allocated objects, so we can
> have better accounting of the memory usage.
> 
> To measure the performance impact of this change, tcp_crr is used from
> the neper [1] performance suite. Basically it is a network ping pong
> test with new connection for each ping pong.
> 
> The server and the client are run inside 3 level of cgroup hierarchy
> using the following commands:
> 
> Server:
>  $ tcp_crr -6
> 
> Client:
>  $ tcp_crr -6 -c -H ${server_ip}
> 
> If the client and server run on different machines with 50 GBPS NIC,
> there is no visible impact of the change.
> 
> For the same machine experiment with v6.11-rc5 as base.
> 
>           base (throughput)     with-patch
> tcp_crr   14545 (+- 80)         14463 (+- 56)
> 
> It seems like the performance impact is within the noise.
> 
> Link: https://github.com/google/neper [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
> v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
> Changes since v1:
> - Correctly handle large allocations which bypass slab
> - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
> 
> RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
> Changes since the RFC:
> - Added check for already charged slab objects.
> - Added performance results from neper's tcp_crr
> 
>  include/linux/slab.h            |  1 +
>  mm/slub.c                       | 51 +++++++++++++++++++++++++++++++++
>  net/ipv4/inet_connection_sock.c |  5 ++--
>  3 files changed, 55 insertions(+), 2 deletions(-)

I can take the v3 in slab tree, if net people ack?

BTW, will this be also useful for Linus's idea of charging struct files only
after they exist? But IIRC there was supposed to be also a part where we
have a way to quickly determine if we're not over limit (while allowing some
overcharge to make it quicker).

Because right now this just overcharges unconditionally, but that's
understandable when the irq context creating the socket can't know the memcg
upfront. In the open() situation this is different.

> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..05cfab107c72 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -547,6 +547,7 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
>  			    gfp_t gfpflags) __assume_slab_alignment __malloc;
>  #define kmem_cache_alloc_lru(...)	alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
>  
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
>  void kmem_cache_free(struct kmem_cache *s, void *objp);
>  
>  kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..8265ea5f25be 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2185,6 +2185,43 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  
>  	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
>  }
> +
> +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> +		      SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> +
> +static __fastpath_inline
> +bool memcg_slab_post_charge(void *p, gfp_t flags)
> +{
> +	struct slabobj_ext *slab_exts;
> +	struct kmem_cache *s;
> +	struct folio *folio;
> +	struct slab *slab;
> +	unsigned long off;
> +
> +	folio = virt_to_folio(p);
> +	if (!folio_test_slab(folio)) {
> +		return __memcg_kmem_charge_page(folio_page(folio, 0), flags,
> +						folio_order(folio)) == 0;
> +	}
> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +
> +	/* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> +	if ((s->flags & KMALLOC_TYPE) == SLAB_KMALLOC)
> +		return true;
> +
> +	/* Ignore already charged objects. */
> +	slab_exts = slab_obj_exts(slab);
> +	if (slab_exts) {
> +		off = obj_to_index(s, slab, p);
> +		if (unlikely(slab_exts[off].objcg))
> +			return true;
> +	}
> +
> +	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
> +}
> +
>  #else /* CONFIG_MEMCG */
>  static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  					      struct list_lru *lru,
> @@ -2198,6 +2235,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  					void **p, int objects)
>  {
>  }
> +
> +static inline bool memcg_slab_post_charge(void *p, gfp_t flags)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_MEMCG */
>  
>  /*
> @@ -4062,6 +4104,15 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
>  
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags)
> +{
> +	if (!memcg_kmem_online())
> +		return true;
> +
> +	return memcg_slab_post_charge(objp, gfpflags);
> +}
> +EXPORT_SYMBOL(kmem_cache_charge);
> +
>  /**
>   * kmem_cache_alloc_node - Allocate an object on the specified node
>   * @s: The cache to allocate from.
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 64d07b842e73..3c13ca8c11fb 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -715,6 +715,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
>  	release_sock(sk);
>  	if (newsk && mem_cgroup_sockets_enabled) {
>  		int amt = 0;
> +		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
>  
>  		/* atomically get the memory usage, set and charge the
>  		 * newsk->sk_memcg.
> @@ -731,8 +732,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
>  		}
>  
>  		if (amt)
> -			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
> -						GFP_KERNEL | __GFP_NOFAIL);
> +			mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp);
> +		kmem_cache_charge(newsk, gfp);
>  
>  		release_sock(newsk);
>  	}


