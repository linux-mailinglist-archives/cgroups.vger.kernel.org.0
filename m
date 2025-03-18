Return-Path: <cgroups+bounces-7124-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDADA66D31
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2AA3BD408
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BE51F8724;
	Tue, 18 Mar 2025 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M2gfY0Us";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdaaZzNn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M2gfY0Us";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdaaZzNn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63C205E36
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284743; cv=none; b=piDvxs77lln2oY12VwFSZvOc90HpH/FF2feJll2f2gZVT7gtt8egkbX2InQe5J5kqAH4UfeA38T+stgWxmB9GrW9gcrl85ZQdbTRWeBzlGKzb612XKdFyLHhmz8ipj1EOJ87OWVPTeQsWo20/IIfClVIY1gfnA3TgnOBk2GVQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284743; c=relaxed/simple;
	bh=y6FUdqVL0RpA2aDaFdyihfsoYuqJe5hlUk2KbI9bmCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4UE2NE6E1dn1n9zLx7lRZYwhcSBzWBFR4js8L+tHn8gALWULpIeUwtSSqXYNcKvissN5fUkBM3DVhu4IlF6eH+iDaRdPNDW3BmcKRKOzYVLptaqN0os/LGHalo/sRrz+12CO6ny2JpmphTCK+EKrdugrp1STJEb08bKeYRoeuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M2gfY0Us; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdaaZzNn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M2gfY0Us; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdaaZzNn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D1D921D85;
	Tue, 18 Mar 2025 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhvAj9f0vslq+dqnUVL7oqgaJNKSRMMwm6koO2lL4Fg=;
	b=M2gfY0UsTD9UDg4vW6BrxWNDO6z32BccQJCWkQm7dsignIGrZhdsTB866ayR94XuGeMBfR
	Ud7oUD+RgFX1G7j1FLLp/XcX8j/QKoms353Bfbto8Pb1XqKgwp3pjT2YWTajkwTie0rCG2
	zVTwgBfULjigfu+rGLjwo2kfA2TGo1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhvAj9f0vslq+dqnUVL7oqgaJNKSRMMwm6koO2lL4Fg=;
	b=GdaaZzNnmSyDXA6SRNZ9yMgodM1FCvWfXSfn+aQBLj2V2W83Nqd94l65d92qU5MHoaL/lL
	uWb5f9Xa/8NZk1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhvAj9f0vslq+dqnUVL7oqgaJNKSRMMwm6koO2lL4Fg=;
	b=M2gfY0UsTD9UDg4vW6BrxWNDO6z32BccQJCWkQm7dsignIGrZhdsTB866ayR94XuGeMBfR
	Ud7oUD+RgFX1G7j1FLLp/XcX8j/QKoms353Bfbto8Pb1XqKgwp3pjT2YWTajkwTie0rCG2
	zVTwgBfULjigfu+rGLjwo2kfA2TGo1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhvAj9f0vslq+dqnUVL7oqgaJNKSRMMwm6koO2lL4Fg=;
	b=GdaaZzNnmSyDXA6SRNZ9yMgodM1FCvWfXSfn+aQBLj2V2W83Nqd94l65d92qU5MHoaL/lL
	uWb5f9Xa/8NZk1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ECE11379A;
	Tue, 18 Mar 2025 07:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GpKrAsMn2WeEBQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Mar 2025 07:58:59 +0000
Message-ID: <5429e6f1-a050-4f2b-b83c-aba824636bb8@suse.cz>
Date: Tue, 18 Mar 2025 08:58:58 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] memcg: manually inline __refill_stock
Content-Language: en-US
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-5-shakeel.butt@linux.dev>
 <Z9jFPP7HsTzs_aW0@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z9jFPP7HsTzs_aW0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/18/25 01:58, Roman Gushchin wrote:
> On Sat, Mar 15, 2025 at 10:49:25AM -0700, Shakeel Butt wrote:
>> There are no more multiple callers of __refill_stock(), so simply inline
>> it to refill_stock().
>> 
>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/memcontrol.c | 32 ++++++++++++--------------------
>>  1 file changed, 12 insertions(+), 20 deletions(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index b54e3a1d23bd..7054b0ebd207 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1865,14 +1865,21 @@ static void drain_local_stock(struct work_struct *dummy)
>>  	obj_cgroup_put(old);
>>  }
>>  
>> -/*
>> - * Cache charges(val) to local per_cpu area.
>> - * This will be consumed by consume_stock() function, later.
>> - */
>> -static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>> +/* Should never be called with root_mem_cgroup. */
> 
> How about adding something like this?
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 768d6b15dbfa..5c26002f2168 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1881,6 +1881,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>         unsigned long flags;
> 
> +       VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));

Already in patch 1 though? But I agree.

> +
>         local_lock_irqsave(&memcg_stock.stock_lock, flags);
>         __refill_stock(memcg, nr_pages);
>         local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> 
> 
> Other than that,
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


