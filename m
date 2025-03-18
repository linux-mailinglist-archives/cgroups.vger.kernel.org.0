Return-Path: <cgroups+bounces-7125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E516A66D3D
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 09:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83089164C44
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D861FA261;
	Tue, 18 Mar 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rEBxLE8J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IvRC5vbU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rEBxLE8J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IvRC5vbU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF41DF990
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284803; cv=none; b=ALksHfSFKoSk76gZ4C3DtC2IULVjGoFrBuGCo/tQrcXPXlMpm7uaA1HI5T2nZJ8PjHw94Pa0Bnrht2NMLuMDUloDJDWy36T3DJA/RpKmbVrksY2wAEbjx31MDN/bbCbQmjpNzRrc2jjXrnf9jCI+2lbzRY9r8WReRzTVAHItbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284803; c=relaxed/simple;
	bh=TDqy4Lug3HDYRe0TJuc6/J5jWjDzg96i7dkzS9fVgH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2ooqSDYgXmGI+jY/lkBRJl5ztFgonwyrzKssWs1c3Z6BP0iHI+05jm3BfzT+Qerzacm0L37h9yOpwh4QlRBxBySgeAhkqVPKpTg0krkh5MVbOP4vu7GhXdTCsc6z0lVZZKbC6xkrcTwT/YiSYBVnpC6RUzTGmvnTMkqaz1pYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rEBxLE8J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IvRC5vbU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rEBxLE8J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IvRC5vbU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00E27211BA;
	Tue, 18 Mar 2025 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkwdSAVfgyv+p+muqjKCffoNDYh+pRw48b25Sr+XMDs=;
	b=rEBxLE8JxU6Z5YOWpVP7Nf3jP6VagIcXv4i4yWGn3obcj2cyMx2/khRWYJVNgqPoIbjJex
	fzOiQ9mJPqh4QfABSE9637mWzeHcJuag12dRyksQsNkcHAbT/dP192qKRO2jPOCLb0cHUV
	Di8F9XqJm3XjBTaSSrRhg16gon+o0Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkwdSAVfgyv+p+muqjKCffoNDYh+pRw48b25Sr+XMDs=;
	b=IvRC5vbUsFcjr+/Zt+LOYMktAMk1E9vHH1YF9ECb01EV49rRh6jojlk8ZRl4ENkgSILzL7
	onFUk2pJAf2BEeDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rEBxLE8J;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IvRC5vbU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkwdSAVfgyv+p+muqjKCffoNDYh+pRw48b25Sr+XMDs=;
	b=rEBxLE8JxU6Z5YOWpVP7Nf3jP6VagIcXv4i4yWGn3obcj2cyMx2/khRWYJVNgqPoIbjJex
	fzOiQ9mJPqh4QfABSE9637mWzeHcJuag12dRyksQsNkcHAbT/dP192qKRO2jPOCLb0cHUV
	Di8F9XqJm3XjBTaSSrRhg16gon+o0Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkwdSAVfgyv+p+muqjKCffoNDYh+pRw48b25Sr+XMDs=;
	b=IvRC5vbUsFcjr+/Zt+LOYMktAMk1E9vHH1YF9ECb01EV49rRh6jojlk8ZRl4ENkgSILzL7
	onFUk2pJAf2BEeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC2181379A;
	Tue, 18 Mar 2025 07:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id na9nNf8n2WcEBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Mar 2025 07:59:59 +0000
Message-ID: <fcfbb44b-6ab9-4c39-8a00-3e6200dc25b0@suse.cz>
Date: Tue, 18 Mar 2025 08:59:59 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] memcg: remove root memcg check from refill_stock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-2-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250315174930.1769599-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 00E27211BA
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/15/25 18:49, Shakeel Butt wrote:
> refill_stock can not be called with root memcg, so there is no need to
> check it.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

It's not trivial to verify this so I'd add
VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg)); as Roman suggested in patch 4 reply.

> ---
>  mm/memcontrol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b29433eb17fa..c09a32e93d39 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1883,6 +1883,7 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  		drain_stock(stock);
>  }
>  
> +/* Should never be called with root_mem_cgroup. */
>  static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	unsigned long flags;
> @@ -1892,8 +1893,6 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  		 * In case of unlikely failure to lock percpu stock_lock
>  		 * uncharge memcg directly.
>  		 */
> -		if (mem_cgroup_is_root(memcg))
> -			return;
>  		page_counter_uncharge(&memcg->memory, nr_pages);
>  		if (do_memsw_account())
>  			page_counter_uncharge(&memcg->memsw, nr_pages);


