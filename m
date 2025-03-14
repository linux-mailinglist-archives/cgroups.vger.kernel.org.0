Return-Path: <cgroups+bounces-7062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878A4A60E01
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 10:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E41897059
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD81F1523;
	Fri, 14 Mar 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/62s//9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgypt9p8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DGppLy05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TW2+obsf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B651DE89E
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946256; cv=none; b=rmwJQAz7grs4pkv/RW8tSlaJhwGJ05Z95YKJBrUCcRqAGnBP6chlqzKN2EedbvL9WMMNiUSo2OVwUe6YfCWnAGiemxI2JrnBWkqZfB0hA+9yo5BoRYhJJNe74H5JQmzMtL8eSkBoNQJy3XyF8kO7f6adWH0jq0igpTe4cbs5Obk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946256; c=relaxed/simple;
	bh=US5AVY0fJt1FFiao/GIOCX5RUuqGpELLt9NsLtnWPRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BljaD9DfJ1W2M2m7n2Ke8nWXoVK2L+zIcsqpgQn4t03/vZqap7Pe1ZKF8g3sHaks4ASPHImWlW0A9vVFd6vYukVMKXqRdFxmizMKPa2IO5YCHH3mxFngSAjM5iaHknXolhMn8snRuYnbLJyTZ1wXJGw5CrdgPdAHsyv7dspAen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/62s//9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgypt9p8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DGppLy05; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TW2+obsf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C1B71F38E;
	Fri, 14 Mar 2025 09:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsN/mrowEbNJodAcOeGHFarYdWv+Z/b+EuUwOOk18+k=;
	b=2/62s//93UWmVqOxlia+fAKbl2JbnM65aHwoQAYyGGl9oMZLBdNc967j8mK7HK7fxNHfcG
	ez3GIAku9XzGfHrHD9dnePQG4dlTyO/CTWlGOqjhKxuiCA7fDFJH1WTW/ZAhH3kBFY5/l+
	u5HDf9xEi0R3hyHXhjhqqYXA4qj811Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsN/mrowEbNJodAcOeGHFarYdWv+Z/b+EuUwOOk18+k=;
	b=mgypt9p8WlzTkYZBbjG2TpZtaXIyDMv0WrifLeqpq3sBcrs9ArjlxgWrRjPUgoJSDjF7Mj
	YypQBGaPKvkB3fDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DGppLy05;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TW2+obsf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsN/mrowEbNJodAcOeGHFarYdWv+Z/b+EuUwOOk18+k=;
	b=DGppLy05gr0pEIF6+ykLh2F3jdWKWVt9en/wkmltfuHL9OxSpmwxLPN6KwumWA4UZc1tdW
	SbxJtyNmVXGpUgGklsdwUmxxNXF75LyIqOqce67ehz0bigIskOXOeSAmTIZxuk87pIKGI0
	IYHqF39+GqZcRbNfThjR1T/Pg3KK2/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsN/mrowEbNJodAcOeGHFarYdWv+Z/b+EuUwOOk18+k=;
	b=TW2+obsfWG7kUdL2gqSV3S8OUsRQCo4fi88gyhypRuH7kfV51YEilWKPdVwY/auuwgtSs/
	GOZR+w2Q0mOKqDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 423C813A31;
	Fri, 14 Mar 2025 09:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qJ66D4v902ehWwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 09:57:31 +0000
Message-ID: <d9b2bc46-332a-44b1-bd43-41446b7f4228@suse.cz>
Date: Fri, 14 Mar 2025 10:57:30 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] memcg: decouple drain_obj_stock from local
 stock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-3-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C1B71F38E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/14/25 07:15, Shakeel Butt wrote:
> Currently drain_obj_stock() can potentially call __refill_stock which
> accesses local cpu stock and thus requires memcg stock's local_lock.
> However if we look at the code paths leading to drain_obj_stock(), there
> is never a good reason to refill the memcg stock at all from it.
> 
> At the moment, drain_obj_stock can be called from reclaim, hotplug cpu
> teardown, mod_objcg_state() and refill_obj_stock(). For reclaim and
> hotplug there is no need to refill. For the other two paths, most
> probably the newly switched objcg would be used in near future and thus
> no need to refill stock with the older objcg.
> 
> In addition, __refill_stock() from drain_obj_stock() happens on rare
> cases, so performance is not really an issue. Let's just uncharge
> directly instead of refill which will also decouple drain_obj_stock from
> local cpu stock and local_lock requirements.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memcontrol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c09a32e93d39..28cb75b5bc66 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2855,7 +2855,12 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>  
>  			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
>  			memcg1_account_kmem(memcg, -nr_pages);
> -			__refill_stock(memcg, nr_pages);
> +			if (!mem_cgroup_is_root(memcg)) {
> +				page_counter_uncharge(&memcg->memory, nr_pages);
> +				if (do_memsw_account())
> +					page_counter_uncharge(&memcg->memsw,
> +							      nr_pages);
> +			}
>  
>  			css_put(&memcg->css);
>  		}


