Return-Path: <cgroups+bounces-16242-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP4XB0ISFGr0JQcAu9opvQ
	(envelope-from <cgroups+bounces-16242-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 11:11:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 740585C860D
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 560983004C6E
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620F3E4C62;
	Mon, 25 May 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YheZVrb8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87C30C17E
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700075; cv=none; b=UXR1g7L0BpbDKvLB5ZY5QNnnSV7wOvZAbm1VnbLcQELkh82LiRdtQdFu+wkWTMR6dhbJpJh1gthiihs9WHKcTiXHu5QMZ8k2DUDrAAtI/+/xKjyzOo+6NXT2aUkfHfaR0Np0Tz0Cc2kOuOfy8vOL9kDhLdkd7TjFzNNg18PFk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700075; c=relaxed/simple;
	bh=pJdx2xij+cxLMzXfJM2Aq01QHnppLs9Fm+DnOtJadtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4jcSEKnjn57IrZOES+9guI8VJHtldU73CmqBNQl2QvFDcH5niNe0TElQH2rukvABxmzaInpcBXQix6ToyM4brypmWX5ohHaFZJajtybG/b12mRXjSJyuJmpVqZpB7i4qPVZR2Jl9dfMvlbMg+Im9a3yPCaCq2zUTIvlZ5M4MHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YheZVrb8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49048e043e5so18749175e9.1
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779700072; x=1780304872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKeRa75/JRbjnQhRaK29cTWmGYwVkcNGukeCupRKFx4=;
        b=YheZVrb8Xs/qRQAmHcZqtapMj/pzno/xFFhyGmd4OldCxWJ73U4iGJFtuVIurKyBcd
         krN0vcOhPJFCq6S3Ll1JzasFDCr5dGJvkSZlhz28OjFhklF01J4BH5GHiPVjF3m+gSL6
         LMCr9ucCr2RiM2uaiBtjcio94Q/ONfr/xd7dDdI+7xDEolOpkP4kQT/6xU1PMoMO4rR4
         aa07upXiQdQqjOBOtVhNe66TuHG2EPGtyjfXCQH9Xr8bjjgKHMHRnNTPD0nF3BIV3x/v
         LXdBFtuYWp5nWCeIu35E63zffD/gdfCiH6NPnxtQHC71pKyXqXEZyxzLGL9D/FzqYv6F
         Lc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700072; x=1780304872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKeRa75/JRbjnQhRaK29cTWmGYwVkcNGukeCupRKFx4=;
        b=ML9IDh1SIVYfH0LtccxVyHBViSGGz23K7wJO5GlWTbTAbschP7PpVp3XqdYUQ1PNLO
         1gxAru+50au9V9vihZocNsIsKydO1ZgCGNLiphPZzQs6Eki0nn9219JndndbxeyU7X9z
         XpOKSFxDRCeAceUNdNNlURsTkpsm9Y0++sRk7tkJ1FrjX9b9SwaFrh9zj70QnMvbhEeC
         6028GRlQkAR3EhuwW1M0l/icmHQYOEkIVoLCh7JH+xrOOA51+EQnkNo8TfS/byLA8r0e
         E6Nzq7ICAhviSssiCtZzoHKNkShMiWJ+mSuKzozGMGcWwvWmojLz+CY7KI5irc9L81QR
         adtw==
X-Forwarded-Encrypted: i=1; AFNElJ8z4NXhOO8h0sOiIBpTExlQJomMvz7wDTxQCLL2YZRmynU69eJydq7xoe21SYc86sOZO9q38/te@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvIn5jLY6AW4qcETWxGvTsXRxYvny1jABVHiVxvvY7jwhWWcv
	KbOkXGGv0elw0KtUCvVkii0Xz977ciAzeqQ6SR+Qj1nwIuOgrqhs7u6RMjeVIoZwbVs=
X-Gm-Gg: Acq92OFkgLCz88hwZm7+4tTBd/Z/eSAbpimgD8g0haEI0hd4/KfYFNyXKP6XtecYZ+9
	L/f+7IHJYIt3AAcblBcqItWCM19aWdhnRrqsTDXN1XEq3zFWb+ff9bLmRjnSiwWag4+HKub3CZ1
	1A3rb5eZQ4sniQAacZIoZrV6DPPXHDFm1vdWjlWe9Nvf+4yfVe/HiZGGRAzEMy9B/BfLhaR5z7o
	o/MRAd+4fD+pczx5NjUNxa6zmLCOjwW2RObD+2WqCgJTkxLh+8lYEX5/EIoZOl+RmAULuLf4t+W
	SK9P+1LsAzlw+Bwk5/C+6zlakKo41l0XbYRSCQR+BMwdL7rrTC1qKw7QczJxz3ZMsmhNeSboPXX
	VWqlU53Sud14NbDgpXnJoaiOwWpSWJxT2vH8JGCvlVTZUz0gBINC99Z6zqhX960ZRAFV/OM0oSF
	+ZSSyRnXHb05jn3mluXUcJ/SdT60V2gsgCLS/h
X-Received: by 2002:a05:600c:3d96:b0:490:5429:1513 with SMTP id 5b1f17b1804b1-49054291bbamr145600515e9.6.1779700072522;
        Mon, 25 May 2026 02:07:52 -0700 (PDT)
Received: from localhost (109-81-80-247.rct.o2.cz. [109.81.80.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm24638766f8f.30.2026.05.25.02.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:07:52 -0700 (PDT)
Date: Mon, 25 May 2026 11:07:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry@kernel.org>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: use round-robin victim selection in refill_stock
Message-ID: <ahQRZlXliL6dhRXv@tiehlicka>
References: <20260521223751.3794625-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521223751.3794625-1-shakeel.butt@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16242-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 740585C860D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu 21-05-26 15:37:51, Shakeel Butt wrote:
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
> Reported-by: Harry Yoo <harry@kernel.org>
> Closes: https://lore.kernel.org/4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org/
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0eb50e639f0a..6392a2704441 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2031,6 +2031,7 @@ struct memcg_stock_pcp {
>  
>  	struct work_struct work;
>  	unsigned long flags;
> +	uint8_t drain_idx;
>  };
>  
>  static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
> @@ -2214,7 +2215,9 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (!success) {
>  		i = empty_slot;
>  		if (i == -1) {
> -			i = get_random_u32_below(NR_MEMCG_STOCK);
> +			i = stock->drain_idx++;
> +			if (stock->drain_idx == NR_MEMCG_STOCK)
> +				stock->drain_idx = 0;
>  			drain_stock(stock, i);
>  		}
>  		css_get(&memcg->css);
> -- 
> 2.53.0-Meta

-- 
Michal Hocko
SUSE Labs

