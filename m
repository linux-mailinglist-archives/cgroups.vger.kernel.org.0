Return-Path: <cgroups+bounces-7948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B36AA47D6
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA571BA74DC
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C312231834;
	Wed, 30 Apr 2025 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZ5Fv/Wi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AXUgg6dA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZ5Fv/Wi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AXUgg6dA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F722156D
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007553; cv=none; b=bEgBFX0wQ/QFaHZ4lgbqvGUPPzXCkzbWKjLppjyMKWh1HOIoS7Si9S5wKoBMRmP2E2JDISEIkZUkSJ8boqVic2sj9vii5fGtX24bHsDxy5tlDUq+7E2+ow9ARyb6xSiPaJL0HXJSghJ4IwbhTqfomAvAa0cVCC6sKzPqeCo+0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007553; c=relaxed/simple;
	bh=PU8u7VACN/AJjKJIar6NdPXdcE6ruW+NxSAqS/1EBv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dha0bxull/9xLueoNiVvM8AyguwyuWtWWSKigV/SFL/SLdefgzGU9JCTmEaXrVK5sfhYqQdqliF052OjyKMRaqnbWzeHwzohotxfpchLk+DuNmZ9GpBZAVkZzDogzds9W51jJoHUHWVw3O1IjOBo7zAtxpM8vcL/YUSfIV1Imuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZ5Fv/Wi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AXUgg6dA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZ5Fv/Wi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AXUgg6dA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A35421297;
	Wed, 30 Apr 2025 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746007549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXUil+ET8/TFI2RImwQgr+2V8ec+IC8TtX59DMlILv8=;
	b=mZ5Fv/WizkLn5NQrcxZu/FLmX8MdFpKMB2/SZ/wtUbFUGK/2tfr+ejbshEi0VS25qAVrhw
	Jr/aJcKXiDqdhCtW7FazUfoq6X2F2L6CO+6ZxSOoWlMzQwW9hKl98zAfdbe+XafoLd4gGI
	8FMRNOssevnX6TOFPmOa44mL8ZXzvqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746007549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXUil+ET8/TFI2RImwQgr+2V8ec+IC8TtX59DMlILv8=;
	b=AXUgg6dA2eZI/VUxqCn6CCv2P4mL/A5vhBIQhfCeFvmiADbiR/+r5X8swdJIyEa66qO2pI
	WilQZ+8X0ltfl7CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mZ5Fv/Wi";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AXUgg6dA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746007549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXUil+ET8/TFI2RImwQgr+2V8ec+IC8TtX59DMlILv8=;
	b=mZ5Fv/WizkLn5NQrcxZu/FLmX8MdFpKMB2/SZ/wtUbFUGK/2tfr+ejbshEi0VS25qAVrhw
	Jr/aJcKXiDqdhCtW7FazUfoq6X2F2L6CO+6ZxSOoWlMzQwW9hKl98zAfdbe+XafoLd4gGI
	8FMRNOssevnX6TOFPmOa44mL8ZXzvqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746007549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXUil+ET8/TFI2RImwQgr+2V8ec+IC8TtX59DMlILv8=;
	b=AXUgg6dA2eZI/VUxqCn6CCv2P4mL/A5vhBIQhfCeFvmiADbiR/+r5X8swdJIyEa66qO2pI
	WilQZ+8X0ltfl7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D3C8139E7;
	Wed, 30 Apr 2025 10:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IBLQBv31EWhxMAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Apr 2025 10:05:49 +0000
Message-ID: <ae4b9ac8-d67d-471f-89b9-7eeaf58dd1b8@suse.cz>
Date: Wed, 30 Apr 2025 12:05:48 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Soheil Hassas Yeganeh
 <soheil@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>, Hugh Dickins <hughd@google.com>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
 <as5cdsm4lraxupg3t6onep2ixql72za25hvd4x334dsoyo4apr@zyzl4vkuevuv>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <as5cdsm4lraxupg3t6onep2ixql72za25hvd4x334dsoyo4apr@zyzl4vkuevuv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4A35421297
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/25/25 22:18, Shakeel Butt wrote:
> Hi Andrew,
> 
> Another fix for this patch. Basically simplification of refill_stock and
> avoiding multiple cached entries of a memcg.
> 
> From 6f6f7736799ad8ca5fee48eca7b7038f6c9bb5b9 Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Fri, 25 Apr 2025 13:10:43 -0700
> Subject: [PATCH] memcg: multi-memcg percpu charge cache - fix 2
> 
> Simplify refill_stock by avoiding goto and doing the operations inline
> and make sure the given memcg is not cached multiple times.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

It seems to me you could simplify further based on how cached/nr_pages
arrays are filled from 0 to higher index and thus if you see a NULL it means
all higher indices are also NULL. At least I don't think there's ever a
drain_stock() that would "punch a NULL" in the middle? When it's done in
refill_stock() for the random index, it's immediately reused.

Of course if that invariant was made official and relied upon, it would need
to be documented and care taken not to break it.

But then I think:
- refill_stock() could be further simplified
- loops in consume_stop() and is_drain_needed() could stop on first NULL
cached[i] encountered.

WDYT?

> ---
>  mm/memcontrol.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 997e2da5d2ca..9dfdbb2fcccc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1907,7 +1907,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	struct mem_cgroup *cached;
>  	uint8_t stock_pages;
>  	unsigned long flags;
> -	bool evict = true;
> +	bool success = false;
> +	int empty_slot = -1;
>  	int i;
>  
>  	/*
> @@ -1931,26 +1932,28 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
> -again:
>  		cached = READ_ONCE(stock->cached[i]);
> -		if (!cached) {
> -			css_get(&memcg->css);
> -			WRITE_ONCE(stock->cached[i], memcg);
> -		}
> -		if (!cached || memcg == READ_ONCE(stock->cached[i])) {
> +		if (!cached && empty_slot == -1)
> +			empty_slot = i;
> +		if (memcg == READ_ONCE(stock->cached[i])) {
>  			stock_pages = READ_ONCE(stock->nr_pages[i]) + nr_pages;
>  			WRITE_ONCE(stock->nr_pages[i], stock_pages);
>  			if (stock_pages > MEMCG_CHARGE_BATCH)
>  				drain_stock(stock, i);
> -			evict = false;
> +			success = true;
>  			break;
>  		}
>  	}
>  
> -	if (evict) {
> -		i = get_random_u32_below(NR_MEMCG_STOCK);
> -		drain_stock(stock, i);
> -		goto again;
> +	if (!success) {
> +		i = empty_slot;
> +		if (i == -1) {
> +			i = get_random_u32_below(NR_MEMCG_STOCK);
> +			drain_stock(stock, i);
> +		}
> +		css_get(&memcg->css);
> +		WRITE_ONCE(stock->cached[i], memcg);
> +		WRITE_ONCE(stock->nr_pages[i], stock_pages);
>  	}
>  
>  	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);


