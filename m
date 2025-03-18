Return-Path: <cgroups+bounces-7120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFAA66CE3
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E9319A136C
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6FC1F869E;
	Tue, 18 Mar 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t97zL5pA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="55dCasU8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t97zL5pA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="55dCasU8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09A1F8724
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284221; cv=none; b=q2FC6U+XQ000UYrwMXO7kKH3VvhCULp4pnIWJkruIB6CJux9/XYbp63+CmoJeviwpGsn/udXJQAkDQneNeLzskOpei18bM0GTGX/TzIwAATOfcJ0Xyu7P4Fq4bDMbofVXL1KVPXLJ4fnjraZMWeMIMjt7+CqWwevNnzdWyLt08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284221; c=relaxed/simple;
	bh=hPMgUQNBZNoqG2HXuRTTV7c8vDJSpkjrrqUYhRqbLgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIa0c77Q1aWHGcRbVHjfGTOob8XDkWYlOnBYWw6P4xFUcU6SaetGZCgFDG2U8cd2ENq0ugGiCKrEM0xHse6fypuhN7O3Q4w3iUcOsFGNFZm7DYn7hwBspVzG/J5KCHqM3zdeqS++domeC8gpKQ0BDIW39sxO8/zn3itTeuXM2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t97zL5pA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=55dCasU8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t97zL5pA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=55dCasU8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32A6421A20;
	Tue, 18 Mar 2025 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUJjNqEaROXfP0ip7X2uVuOzSRfoFZxySuFvEV2R3Js=;
	b=t97zL5pAnIvdIyrMSRmLPam1bF6XxvYFbxJjwpjrTj5/9DVwvwfQnCO60MEUtjgmrhAuAG
	hkmcEn9AaukzuM+DaOQKZcwk+BSBfMd4OQmTH3dvKCsgJjokP56mrys02V2GzLbgpTLicE
	cRlgkLbuh6BReQd6wUBOoy8TUwoQQBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUJjNqEaROXfP0ip7X2uVuOzSRfoFZxySuFvEV2R3Js=;
	b=55dCasU8IGX/wNW1Ck7pc2PYmfzlOpeDbzhB0+G1HUiabkgChdKDZSvnagLnIN7vl6uu2+
	awg2IKRrhF5JVWBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t97zL5pA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=55dCasU8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742284211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUJjNqEaROXfP0ip7X2uVuOzSRfoFZxySuFvEV2R3Js=;
	b=t97zL5pAnIvdIyrMSRmLPam1bF6XxvYFbxJjwpjrTj5/9DVwvwfQnCO60MEUtjgmrhAuAG
	hkmcEn9AaukzuM+DaOQKZcwk+BSBfMd4OQmTH3dvKCsgJjokP56mrys02V2GzLbgpTLicE
	cRlgkLbuh6BReQd6wUBOoy8TUwoQQBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742284211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUJjNqEaROXfP0ip7X2uVuOzSRfoFZxySuFvEV2R3Js=;
	b=55dCasU8IGX/wNW1Ck7pc2PYmfzlOpeDbzhB0+G1HUiabkgChdKDZSvnagLnIN7vl6uu2+
	awg2IKRrhF5JVWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E7DD1379A;
	Tue, 18 Mar 2025 07:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d6UxA7Ml2WcWAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Mar 2025 07:50:11 +0000
Message-ID: <ca8ed915-28b2-48a0-9d8e-dbdcf15b94d6@suse.cz>
Date: Tue, 18 Mar 2025 08:50:10 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] memcg: use __mod_memcg_state in drain_obj_stock
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-8-shakeel.butt@linux.dev>
 <Z9jIxxllVwFSLYeL@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z9jIxxllVwFSLYeL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 32A6421A20
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/18/25 02:13, Roman Gushchin wrote:
> On Sat, Mar 15, 2025 at 10:49:28AM -0700, Shakeel Butt wrote:
>> For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
>> disabled, so we can use __mod_memcg_state() instead of
>> mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
>> in __mod_memcg_state().
>> 
>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>  mm/memcontrol.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 3c4de384b5a0..dfe9c2eb7816 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -707,10 +707,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
>>  	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
>>  		return;
>>  
>> +	memcg_stats_lock();
>>  	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
>>  	val = memcg_state_val_in_pages(idx, val);
>>  	memcg_rstat_updated(memcg, val);
>>  	trace_mod_memcg_state(memcg, idx, val);
>> +	memcg_stats_unlock();
>>  }
>>  
>>  #ifdef CONFIG_MEMCG_V1
>> @@ -2845,7 +2847,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> 
> VM_WARN_ON_IRQS_ENABLED() ?

It's part of memcg_stats_lock()

> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


