Return-Path: <cgroups+bounces-7126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D068FA66D42
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 09:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB9216E85D
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6244204F8B;
	Tue, 18 Mar 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UOL2Mfeu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="al0mkPIV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RjiRy7/I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KG6XWcgT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55D1F8723
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284835; cv=none; b=CeoP9tZCINKcIiYtPEJdJ73opT5b/FZ7b1EY7RodrD2y/ZPAOoLkXuepfNlOyviDwtvaB3HagbSAxtcheQadPyyHcVbOy2DaK86BWJj7r0v+O17CnLRGYqSgNqChcSiSg4JnK1ifSXludFF2cLolxLmDT2ZYEXjPcsLFmwtOarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284835; c=relaxed/simple;
	bh=LYYzHdAK9XF18zW4ox4b6+qH6+WG0gy67kKnVFUPbdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKcbk3HQi5aAoDMv/ZL0MR92JXl39VFywWD+Zz8Uw1CjNGahbN0QR7GYgpFKB558AwzYMaymkxvO1c+Jl8Z4AhjD3VN2a/vKt/W8ZQuIYZnxN5v/ZJQN+xRECr9npW1jSN7JnQ4d0e5WAZHMJbRxoYKJr3KqHr4WZaXgwKIamZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UOL2Mfeu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=al0mkPIV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RjiRy7/I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KG6XWcgT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9F41FE8A;
	Tue, 18 Mar 2025 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT+SARX9APClJ1Gg1qAwEL+zmJ63qe5yxRDMw/I2qw4=;
	b=UOL2Mfeu2TfoJZoaTt3CsRpkUfhUOB6Sj0k8QRbyH8FOXOlHqmhl/bj3zb33DP8TlxrdDH
	OXPbD5rEeAKg6C75ADvy3379ZxfB4ATTpt+lasrDKe5EzjvwFxgmcRsdNKN0HkYdu6WGT9
	BaoX2EKPHyfXfrzvZojsSt017aW5uh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT+SARX9APClJ1Gg1qAwEL+zmJ63qe5yxRDMw/I2qw4=;
	b=al0mkPIVv6Xhhj1sjYS2/Y1lwg43mfoG/qDX57sF3DHDNilqLk02sWPFOsizjhVhC9FpJn
	ipytBwJqKk9D2TBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="RjiRy7/I";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KG6XWcgT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT+SARX9APClJ1Gg1qAwEL+zmJ63qe5yxRDMw/I2qw4=;
	b=RjiRy7/IgAx+sQanhsJxZbwx7KSC2sulj32teibKJI66c3ScJk5ByfKWbWRTe2T8QC1QBJ
	Jy6WEduU43U4n2Zt+6rOAuCijSwYQPwBuZVf+R35pwTMylFUX0fuvF2A3CrGesyHgQT54X
	nFE/GbE6CBdbvOvb6z5L7BvvJ24FamA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT+SARX9APClJ1Gg1qAwEL+zmJ63qe5yxRDMw/I2qw4=;
	b=KG6XWcgTM55wuk+7c+XZpxo1devkUyw2X6h0gM83Z8MOOO9iWjNHRCMDpypPeKpHRrKsE6
	Ah0UlW1sdSmYVbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 448F71379A;
	Tue, 18 Mar 2025 08:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9LksEBko2Wc4BgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Mar 2025 08:00:25 +0000
Message-ID: <f0667d7b-98bc-4797-9655-33dd403b47ca@suse.cz>
Date: Tue, 18 Mar 2025 09:00:25 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] memcg: manually inline replace_stock_objcg
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
 <20250315174930.1769599-10-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250315174930.1769599-10-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5D9F41FE8A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/15/25 18:49, Shakeel Butt wrote:
> The replace_stock_objcg() is being called by only refill_obj_stock, so
> manually inline it.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memcontrol.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 553eb1d7250a..f6e3fc418866 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2742,17 +2742,6 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	obj_cgroup_put(objcg);
>  }
>  
> -/* Replace the stock objcg with objcg, return the old objcg */
> -static void replace_stock_objcg(struct memcg_stock_pcp *stock,
> -				struct obj_cgroup *objcg)
> -{
> -	drain_obj_stock(stock);
> -	obj_cgroup_get(objcg);
> -	stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> -			? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> -	WRITE_ONCE(stock->cached_objcg, objcg);
> -}
> -
>  static void __account_obj_stock(struct obj_cgroup *objcg,
>  				struct memcg_stock_pcp *stock, int nr,
>  				struct pglist_data *pgdat, enum node_stat_item idx)
> @@ -2913,7 +2902,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> -		replace_stock_objcg(stock, objcg);
> +		drain_obj_stock(stock);
> +		obj_cgroup_get(objcg);
> +		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> +				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> +		WRITE_ONCE(stock->cached_objcg, objcg);
> +
>  		allow_uncharge = true;	/* Allow uncharge when objcg changes */
>  	}
>  	stock->nr_bytes += nr_bytes;


