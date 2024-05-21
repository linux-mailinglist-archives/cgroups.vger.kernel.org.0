Return-Path: <cgroups+bounces-2973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62A38CAF6D
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 15:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C89D282F85
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2024 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1977EF0C;
	Tue, 21 May 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CGy+yAOc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CGy+yAOc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AB7EF08
	for <cgroups@vger.kernel.org>; Tue, 21 May 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298253; cv=none; b=XZXc76ToEUUxzjeEGajoZL80U8eR4eFaJSX309S7F5FZfA4CMs+qa/9jHC6epU/QH4AbfxE18oI82ebOSMZq7a0HXDPFucWGWdUjc1nTlZWvZkljOe372JoIV3qYBd56Z+yV4j6641+7UvuBBNMDSOgjAg4BuNgsLFAar+mfGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298253; c=relaxed/simple;
	bh=9RN5GQtINjHlEUs59ay8Bgbc4lekEeSNYT2uLIHOpIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnlwK0dDHGJUbmSF/IED4lGCS8uHpHThEpEITjOjrMs1MfyzhZDoIslFr2PNxyqCWnZWBEWCdc7dmvGJm63bRtzSgv2Bh7AjBKlL+zgQNkDipOKwmUl4Z2sGKaWyzGMaNoF/mTrfMGVHQNGwXlOtZeshqQJe19/zjS2mNQkPei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CGy+yAOc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CGy+yAOc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C7235C1A0;
	Tue, 21 May 2024 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716298250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CZtj7ithXukrZLqGcjLLDPzON2J3WyD3PPi0aZrb5T4=;
	b=CGy+yAOcEuCLZp1trz2PoHSliE+pniM6LMjtq6Y6q/THSw6ajYcHNhiZMfnSfIigCMg7FH
	CNxLkBVC6WQ8CZ3+d4nsPhuQi6m9YOhEsaACBcleU7Tuu1zDPQeDbNBns/fZ7+S3IsvBAc
	onhshcQybX1z+v3VgsIt9xkkF12lBX8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716298250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CZtj7ithXukrZLqGcjLLDPzON2J3WyD3PPi0aZrb5T4=;
	b=CGy+yAOcEuCLZp1trz2PoHSliE+pniM6LMjtq6Y6q/THSw6ajYcHNhiZMfnSfIigCMg7FH
	CNxLkBVC6WQ8CZ3+d4nsPhuQi6m9YOhEsaACBcleU7Tuu1zDPQeDbNBns/fZ7+S3IsvBAc
	onhshcQybX1z+v3VgsIt9xkkF12lBX8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02D8B13685;
	Tue, 21 May 2024 13:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VMCROQmiTGYvVwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 13:30:49 +0000
Date: Tue, 21 May 2024 15:30:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: remove page_memcg()
Message-ID: <Zkyh-u9Tbgdtg9d6@tiehlicka>
References: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521131556.142176-1-wangkefeng.wang@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 21-05-24 21:15:56, Kefeng Wang wrote:
> The page_memcg() only called by mod_memcg_page_state(), so squash it to
> cleanup page_memcg().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  include/linux/memcontrol.h | 14 ++------------
>  mm/memcontrol.c            |  2 +-
>  2 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 030d34e9d117..8abc70cc7219 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -443,11 +443,6 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>  	return __folio_memcg(folio);
>  }
>  
> -static inline struct mem_cgroup *page_memcg(struct page *page)
> -{
> -	return folio_memcg(page_folio(page));
> -}
> -
>  /**
>   * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
>   * @folio: Pointer to the folio.
> @@ -1014,7 +1009,7 @@ static inline void mod_memcg_page_state(struct page *page,
>  		return;
>  
>  	rcu_read_lock();
> -	memcg = page_memcg(page);
> +	memcg = folio_memcg(page_folio(page));
>  	if (memcg)
>  		mod_memcg_state(memcg, idx, val);
>  	rcu_read_unlock();
> @@ -1133,11 +1128,6 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>  	return NULL;
>  }
>  
> -static inline struct mem_cgroup *page_memcg(struct page *page)
> -{
> -	return NULL;
> -}
> -
>  static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>  {
>  	WARN_ON_ONCE(!rcu_read_lock_held());
> @@ -1636,7 +1626,7 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
>  	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
>  }
>  
> -/* Test requires a stable page->memcg binding, see page_memcg() */
> +/* Test requires a stable page->memcg binding, see folio_memcg() */
>  static inline bool folio_matches_lruvec(struct folio *folio,
>  		struct lruvec *lruvec)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 54070687aad2..72833f6f0944 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3811,7 +3811,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  /*
> - * Because page_memcg(head) is not set on tails, set it now.
> + * Because folio_memcg(head) is not set on tails, set it now.
>   */
>  void split_page_memcg(struct page *head, int old_order, int new_order)
>  {
> -- 
> 2.41.0

-- 
Michal Hocko
SUSE Labs

