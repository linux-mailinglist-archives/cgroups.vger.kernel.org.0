Return-Path: <cgroups+bounces-16184-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJVCOVOpD2r9OQYAu9opvQ
	(envelope-from <cgroups+bounces-16184-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 02:54:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF45AD987
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 02:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FB4B300F750
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 00:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D44627E1A1;
	Fri, 22 May 2026 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2jnmSuI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA162195811;
	Fri, 22 May 2026 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779411281; cv=none; b=U1Q8yfx42YiRYm4Qi45pjmG2GfqB8U+h0kv7VrnusEb8hvAdolStKsY35E/UIKbdwfkDf9tocjgjeH7gKY3C2Wx4UGVE4XUoYXTHQdhuH0zsNkVMuLRY8ttjnJbzhHNwaAdrkQvlJgal3ThrWz2mxGCj4RnrO5xp2zRzHJ5/6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779411281; c=relaxed/simple;
	bh=uCFEAtmLp5pouaAzSfcLTwrSGfK2rm2rJfYhY5nJ/T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f521IW3D+uDrWcRoH3HziZncyQobt9okjLTtf+uB7RTFipyOIlOdLszUc1Vu6GOwBw2wGEaQcynyF8SL+yo769XkMqqJLX11mWFTjnXTMEDH8ea7Wibca6MQa4Al9099dTqxiACt/gs9VZLRIO3djtL7Rr/Ht6MQ732DyvBCVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2jnmSuI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7CD1F000E9;
	Fri, 22 May 2026 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779411279;
	bh=2S3qdoFa1I+RLITQLUX1CsFtTUclF5hn7NIR5djnZeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l2jnmSuIcu+aXD5Ww51h85HFKZpc+SCQLL7OzDtwOAxJN83QWbCjbS1jHRL/z4YoY
	 lKwgFWFPVBE03V0voly+KroM3f01t1Kf0hR8qbtFrikMfXR8CCXeCfo8q0Yiq6H2Wn
	 +ERt2+sPkEg+4Id9sX1EDzIHkzYhIrCc/dcuUO1D5A5s2ziTf2Q/LOgfHD53GXC2ID
	 Z4MtarjCTSYug0/H1iXajKuEFj5SKdtpzf8fSvANI79o4KL0vMFTC1iI6K4TT+NiUs
	 NrogldeUuL6tZHqFku4OFrHhyslijaATSa+1PqU18dTG79uTOzd2vGMGhVU69egd2i
	 Or/nY8MRJPQTA==
Message-ID: <2a53e936-f22f-47a3-b858-7431749d1bfb@kernel.org>
Date: Fri, 22 May 2026 09:54:35 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: use round-robin victim selection in refill_stock
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Meta kernel team
 <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260521223751.3794625-1-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260521223751.3794625-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16184-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8FCF45AD987
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/22/26 7:37 AM, Shakeel Butt wrote:
> Harry Yoo reported that get_random_u32_below() is not safe to call in
> the nmi context and memcg charge draining can happen in nmi context.
> 
> More specifically get_random_u32_below() is neither reentrant- nor
> NMI-safe: it acquires a per-cpu local_lock via local_lock_irqsave() on
> the batched_entropy_u32 state. An NMI that lands on a CPU mid-update of
> the ChaCha batch state and recurses into the random subsystem would
> corrupt that state. The memcg_stock local_trylock prevents re-entry
> on the percpu stock itself, but cannot protect an unrelated
> subsystem's per-cpu lock.
> 
> Replace the random pick with a per-cpu round-robin counter stored in
> memcg_stock_pcp and serialized by the same local_trylock that already
> guards cached[] and nr_pages[]. No atomics, no random calls, no extra
> locks needed.
> 
> Fixes: f735eebe55f8f ("memcg: multi-memcg percpu charge cache")

Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

and perhaps

Cc: <stable@vger.kernel.org>

as it affects v6.18 (the latest LTS).

Thanks a lot for fixing it, Shakeel!

> Reported-by: Harry Yoo <harry@kernel.org>
> Closes: https://lore.kernel.org/4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org/
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>   mm/memcontrol.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0eb50e639f0a..6392a2704441 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2031,6 +2031,7 @@ struct memcg_stock_pcp {
>   
>   	struct work_struct work;
>   	unsigned long flags;
> +	uint8_t drain_idx;
>   };
>   
>   static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
> @@ -2214,7 +2215,9 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   	if (!success) {
>   		i = empty_slot;
>   		if (i == -1) {
> -			i = get_random_u32_below(NR_MEMCG_STOCK);
> +			i = stock->drain_idx++;
> +			if (stock->drain_idx == NR_MEMCG_STOCK)
> +				stock->drain_idx = 0;
>   			drain_stock(stock, i);
>   		}
>   		css_get(&memcg->css);

-- 
Cheers,
Harry / Hyeonggon


