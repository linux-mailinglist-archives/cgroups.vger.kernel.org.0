Return-Path: <cgroups+bounces-7067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9F7A60ECE
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C4F16BF4A
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D71F4261;
	Fri, 14 Mar 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+jmdcM7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Da2GVXQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+jmdcM7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Da2GVXQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2D1F3BAE
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948064; cv=none; b=Lr4Gz0y6IAb0/1MFS5uKihcfmMAah7MLSqCCDkVL4erLTXH5mbInqtgdCFW8vs8H29p0PcSpyDcpv/xyqH450dBwT2M6GB9l8iUrqPRFV199o3bVmPsyG7stvCwXAuFwoNj1PKgthGjVRpEIXz1qPCFnbmKipL9Y1t1Rytn0yuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948064; c=relaxed/simple;
	bh=6MUnyoMqfWRXJzMvRu/uODIoNq/j211mmEZ2WIPba3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiM+QpsgP+18KPkVwktHDOjqk12toXb3La/Y+oCjnxLBsW4+5wtCSakHCEUbqjTW2az77Jkj0PHzznrAqQdQPudj8AHT3JbJntbymP/9ZXL8ABP9O55M2FncZgkrr9osxR1FDNiiNmJdWFFQB06wO2lsvxMqxBhtJeM0Ee3ca2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+jmdcM7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Da2GVXQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+jmdcM7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Da2GVXQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 288B01F38E;
	Fri, 14 Mar 2025 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741948061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgnd6h/8+X/DkEnqQwYn262MXQhZFGwUf0NqimX6ZLs=;
	b=m+jmdcM7naaaJYDjiLUoxBoxJ1CUuX2Lg4vABxBJHyTXYB5MR9GuIes3/qRccuoKZF4HDU
	3KeFroriA7gVH/riqYktnDgM1V4ZgY4otUSaZE9PNYqCuWikLFrAlwzSmMrvGPwgZ9YbHG
	dCK2cYFsreK6SZ2EDzsLBlKDEL9qxuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741948061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgnd6h/8+X/DkEnqQwYn262MXQhZFGwUf0NqimX6ZLs=;
	b=2Da2GVXQOSiDIHTxiRa89PZSJ4zgmkGZnKDEmxXRDLU6yAL5/8ePn1raLqhnLE6MJ5Yijm
	e1ZU+M9xehJbbsCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m+jmdcM7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2Da2GVXQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741948061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgnd6h/8+X/DkEnqQwYn262MXQhZFGwUf0NqimX6ZLs=;
	b=m+jmdcM7naaaJYDjiLUoxBoxJ1CUuX2Lg4vABxBJHyTXYB5MR9GuIes3/qRccuoKZF4HDU
	3KeFroriA7gVH/riqYktnDgM1V4ZgY4otUSaZE9PNYqCuWikLFrAlwzSmMrvGPwgZ9YbHG
	dCK2cYFsreK6SZ2EDzsLBlKDEL9qxuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741948061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgnd6h/8+X/DkEnqQwYn262MXQhZFGwUf0NqimX6ZLs=;
	b=2Da2GVXQOSiDIHTxiRa89PZSJ4zgmkGZnKDEmxXRDLU6yAL5/8ePn1raLqhnLE6MJ5Yijm
	e1ZU+M9xehJbbsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11CDD13A31;
	Fri, 14 Mar 2025 10:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mxH5A50E1GeiZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 10:27:41 +0000
Message-ID: <c88739b4-1fe3-47dc-8ed6-22adf0aadcb4@suse.cz>
Date: Fri, 14 Mar 2025 11:27:40 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/10] memcg: use __mod_memcg_state in drain_obj_stock
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
 <20250314061511.1308152-8-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-8-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 288B01F38E
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim,suse.cz:mid];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/14/25 07:15, Shakeel Butt wrote:
> For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
> disabled, so we can use __mod_memcg_state() instead of
> mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
> in __mod_memcg_state().
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Maybe it'll make sense later but as of this patch itself it begs a question
why put memcg_stats_lock()/unlock() in __mod_memcg_state itself and not just
around the call in drain_obj_stock()?

> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3c4de384b5a0..dfe9c2eb7816 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -707,10 +707,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
>  	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
>  		return;
>  
> +	memcg_stats_lock();
>  	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
>  	val = memcg_state_val_in_pages(idx, val);
>  	memcg_rstat_updated(memcg, val);
>  	trace_mod_memcg_state(memcg, idx, val);
> +	memcg_stats_unlock();
>  }
>  
>  #ifdef CONFIG_MEMCG_V1
> @@ -2845,7 +2847,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  
>  			memcg = get_mem_cgroup_from_objcg(old);
>  
> -			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
> +			__mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
>  			memcg1_account_kmem(memcg, -nr_pages);
>  			if (!mem_cgroup_is_root(memcg))
>  				memcg_uncharge(memcg, nr_pages);


