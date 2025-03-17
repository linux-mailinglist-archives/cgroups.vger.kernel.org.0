Return-Path: <cgroups+bounces-7106-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59782A65FCB
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 21:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939B8179A74
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0171F866A;
	Mon, 17 Mar 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ezFSyfRu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HZ5bGAT0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ezFSyfRu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HZ5bGAT0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC21DDC15
	for <cgroups@vger.kernel.org>; Mon, 17 Mar 2025 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245003; cv=none; b=LeOYIsUYIhlm6AM6n1X7vhNtUiH6WjoSnyctECBv2oEa5d2YPItDkmILrx4G/vmQ8DkEcBE95YWszhwx/q5Fwwv6Wj95lCKc/3e9xiupuKZ3zrCrxv+3nVpBa99FlDHcbIX5gHujitanLJ0jCHBXuRNjJuEZ2aFzII5s9Tt+5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245003; c=relaxed/simple;
	bh=0WX8Kx9Flp9jZSzhAn2munAAdf//GhyeZMSOHwMSaas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaIohAkq2LA1ORlVrpRRCdW0o7ko9WE9a54iQpL+sCb9y9XoKzuAQ1KHaOraLyjgii7O73Fh2o77je872GQIxENQEQ0RYDHjmc31bei5SCfSk0P3VPnKE/odpbyzQkOt4eU1hHXlbOyLr/m4TBmhCDMBblrbNBQDQ5PsEohGKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ezFSyfRu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HZ5bGAT0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ezFSyfRu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HZ5bGAT0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5C7021BBE;
	Mon, 17 Mar 2025 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742244999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNikvRpXPHVfwQlspximhFbBerhlvWKmLHhDH78muhc=;
	b=ezFSyfRuYk0BBPaun1XDmrvUmTLDMrWP1d5XHJgTNRScqGnoJHm3DGllz4jel+QBwx21z8
	BGQjRkbH2bgevWpz1rY8SNVCIxzrvMplOp+PEL/Pn8CkDYyksej3gNfVMx+eKIhJpCT+Ha
	Demf/Suxr1ZP8/BxR2OM0hdWCk9AI5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742244999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNikvRpXPHVfwQlspximhFbBerhlvWKmLHhDH78muhc=;
	b=HZ5bGAT0fnV3jw1YB/4bctl8RgmJijpdlfBmH2lSCVD3llWlkTVrNrySTN8OymX/DLsLqQ
	H69GNbgUe6Gsx9Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742244999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNikvRpXPHVfwQlspximhFbBerhlvWKmLHhDH78muhc=;
	b=ezFSyfRuYk0BBPaun1XDmrvUmTLDMrWP1d5XHJgTNRScqGnoJHm3DGllz4jel+QBwx21z8
	BGQjRkbH2bgevWpz1rY8SNVCIxzrvMplOp+PEL/Pn8CkDYyksej3gNfVMx+eKIhJpCT+Ha
	Demf/Suxr1ZP8/BxR2OM0hdWCk9AI5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742244999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNikvRpXPHVfwQlspximhFbBerhlvWKmLHhDH78muhc=;
	b=HZ5bGAT0fnV3jw1YB/4bctl8RgmJijpdlfBmH2lSCVD3llWlkTVrNrySTN8OymX/DLsLqQ
	H69GNbgUe6Gsx9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8543C139D2;
	Mon, 17 Mar 2025 20:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TRyVH4eM2GddYQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 20:56:39 +0000
Message-ID: <7d50a14a-edfb-410d-840e-17876806a63b@suse.cz>
Date: Mon, 17 Mar 2025 21:56:39 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] memcg: use __mod_memcg_state in drain_obj_stock
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
 <20250315174930.1769599-8-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250315174930.1769599-8-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/15/25 18:49, Shakeel Butt wrote:
> For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
> disabled, so we can use __mod_memcg_state() instead of
> mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
> in __mod_memcg_state().
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I've asked in the RFC and from Sebastian's answer I think my question was
misunderstod, so let me try again.

After this patch we'll have from mod_memcg_state():

mod_memcg_state()
  local_irq_save(flags);
  __mod_memcg_state()
    memcg_stats_lock(); <- new and unnecessary?

Instead of modifying __mod_memcg_state() we could be more targetted and just
do in drain_obj_stock():

memcg_stats_lock();
__mod_memcg_state();
memcg_stats_unlock();

Am I missing something?

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


