Return-Path: <cgroups+bounces-14911-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAM6E7/Eu2n1ngIAu9opvQ
	(envelope-from <cgroups+bounces-14911-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 10:41:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B12C8DB4
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 10:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D57305DBAA
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF173B5315;
	Thu, 19 Mar 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d7hsA39S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D32BE7CD
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912560; cv=none; b=gzKB8bsg0VjAl7oLunqRk8RmgaU7Vi9pgnQlgylxsfYqAHS3NDb6+fBkxJq57ecEMVmnNz46vIV6xDUUTNERIx22XYHatQFUYSQaFXzkEqv9FFgV6Q8B2YS+gsoQ+INfUiAnJOZt2QPjIvcuzgXaUOVnqpa5ZywOrDwB2kVi8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912560; c=relaxed/simple;
	bh=njiAOERAJvQEMDoH+2WmTY55fZmpofc517U5NS6YBvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4ZbxSNu6wOCzl9JHhT0SK+LNA2aTl3W1+5LdMN4u9wKn1TRQPmdQCKLLKYL9wOD6v7r+3KyFmCiX9fHmZVOrGUMEfP0E+MLqsjp+fjnqS1JAyqdNQ7iXmrdiEJliF5sQJ1nddOiycvepMPyhw2bsex6BezlIRh1slRz0yt7afQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d7hsA39S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485345e1013so13238205e9.1
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773912557; x=1774517357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50t0EU0nC78Y1uj1H0W04uR9q1D5oxGNIJsGhLT6WV8=;
        b=d7hsA39SYSBAJpIn8uQ17aWSsNJoAvtNXuXfCxEKWKzhq/xQ/pqVcN2nHRTWf47XJJ
         YHB40+xJCmb8zPdTWEH9SJl0vowbCDLZw6MHWXWhIMfpz9onLuevEwac9i5tmjrFNhQD
         KWr4YM9DjjSm+EKTmx3YCXZnfUetvgt5CGmhbW+/rF4GCjtQ5dXJBJW2ZRiR390VHQLZ
         xYSP/rAITi1AYh1aRqcZrPpSh6/ijx+6R8/oEtEkU+vpKFtMVkZSB4m2v7TnJyw80Tn2
         SzVU796A8ejoyqzcCMm49gDM07zhGme/Bg9C+2L56Th559xq03YZaRhKqaD0zE+Z4lb6
         sJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773912557; x=1774517357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50t0EU0nC78Y1uj1H0W04uR9q1D5oxGNIJsGhLT6WV8=;
        b=lVp2RSOF/WHfl2dx6praI8I9Yu05p062dOs0mFJyC9hmDN0SvvgRcmiprXKZmgzvRz
         Vsrwbv9x44J0F/k5jmWLdEb23p4OFJs96es6FYxbm8S67etXYUtMZlInLpWZGT+wVwx5
         mrIXTMEFPJ4gwzR8DplWi94V+Srg+y9QhnGRePnE1OqUfdPQ3XekP48Gi7TyyGFFQqFc
         3ETmFjhdvllLOKwRzCKIEbHbWbhNZm2nFkL5o44iez/JYzePEH7pToFcDHbLuY2Ar5a3
         jv1snoFRdPKETQzNzgAh6Z3lvnUeRIckgdWH1hwfGhsO+kW0kSPOrpMrIf9R0zdxA4Wk
         NB1g==
X-Forwarded-Encrypted: i=1; AJvYcCXrTPJ20Xw32wFgPRmy0GtyIKx8BaFEKPPoPgqJN3GLek3InkO8MVc4IgEeLUh7j4fyS8yzlaU2@vger.kernel.org
X-Gm-Message-State: AOJu0YyW437rf7xj9ZdTFCN7s266UKDTV0UbLmUGkVehueo03bsgTkbw
	wDnex1g0SuzjDPc5Gx19RwVv+OuiNEKP3sIiY2cw4mtwVLtd9TXwCJhEJALyplb05aqVKtAnfwF
	WFEv7
X-Gm-Gg: ATEYQzzpMZkyBtQTKD/i/QhitVI4Wd1TixqCPGpuYLAjXFlNH+8hyWe0raLIguwgveF
	nMooMchJlUMc7RsPQIS3Sw/Y25Xdvsk1q2Cdv67KrU5jZC+VM1MZgu1zLossZB2J3fPOGH07ZWJ
	1vV9S6rQPfUw9myU0FR9sk/ghpH58++gFqr/ah52iHL9YKLVF18HuVnaEFfCOAME/SEgNAyiwrY
	xW3D4NLmDthgWV3kxp2PORyEV4kYSMiCRg03TepqEg7jINmU6NcdpiY2Taf0Sqz5mM7Z1wC0uko
	IB6LnU/GdNEv+oA8CEBRjVnmgCdpQCI5p+1XJe8irRdSxocYz+7s7pqFnob8CN0Vd5kbPfLtNjc
	lKvwbJOrTlpO2rTUI+nutL7zgacx59GaehklR4D8MLu16GyJJvBfbuiuAVCkCLIHx5W8vDWcTvH
	E1SfE/4cAkmy86c6S8RWz0JYwHOPxvLLA8NQ==
X-Received: by 2002:a05:600c:5286:b0:485:50ac:b8cf with SMTP id 5b1f17b1804b1-486f8aa4c58mr41526415e9.0.1773912557243;
        Thu, 19 Mar 2026 02:29:17 -0700 (PDT)
Received: from localhost (109-81-88-11.rct.o2.cz. [109.81.88.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4bbe471sm41130335e9.27.2026.03.19.02.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:29:16 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:29:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: Bing Jiao <bingjiao@google.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org,
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org,
	david@kernel.org, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, muchun.song@linux.dev,
	nphamcs@gmail.com, rientjes@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com,
	weixugc@google.com, yosry@kernel.org, youngjun.park@lge.com,
	yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3] mm/memcontrol: fix reclaim_options leak in
 try_charge_memcg()
Message-ID: <abvB65BYCUDT9JF1@tiehlicka>
References: <20260318215629.2849052-1-bingjiao@google.com>
 <20260318221957.2979346-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318221957.2979346-1-bingjiao@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14911-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,cmpxchg.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.967];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C28B12C8DB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 18-03-26 22:19:46, Bing Jiao wrote:
> In try_charge_memcg(), the 'reclaim_options' variable is initialized
> once at the start of the function. However, the function contains a
> retry loop. If reclaim_options were modified during an iteration
> (e.g., by encountering a memsw limit), the modified state would
> persist into subsequent retries.
> 
> This leads to incorrect reclaim behavior. Specifically,
> MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
> is reached. After reclaimation attemps, a subsequent retry may
> successfully charge memcg->memsw but fail on the memcg->memory charge.
> In this case, swapping should be permitted, but the carried-over state
> prevents it.

Have you noticed this happening in practice or is this based on the code
reading?
 
> Fix by moving the initialization of 'reclaim_options' inside the
> retry loop, ensuring a clean state for every reclaim attempt.
> 
> Fixes: 6539cc053869 ("mm: memcontrol: fold mem_cgroup_do_charge()")
> Signed-off-by: Bing Jiao <bingjiao@google.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> v3:
> - Corrected the Fixes tag (Yosry).
> 
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a47fb68dd65f..303ac622d22d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2558,7 +2558,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	struct page_counter *counter;
>  	unsigned long nr_reclaimed;
>  	bool passed_oom = false;
> -	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
> +	unsigned int reclaim_options;
>  	bool drained = false;
>  	bool raised_max_event = false;
>  	unsigned long pflags;
> @@ -2572,6 +2572,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		/* Avoid the refill and flush of the older stock */
>  		batch = nr_pages;
> 
> +	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>  	if (!do_memsw_account() ||
>  	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>  		if (page_counter_try_charge(&memcg->memory, batch, &counter))
> --
> 2.53.0.851.ga537e3e6e9-goog

-- 
Michal Hocko
SUSE Labs

