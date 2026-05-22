Return-Path: <cgroups+bounces-16199-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHqhBlgLEGpqSwYAu9opvQ
	(envelope-from <cgroups+bounces-16199-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 09:52:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEAC5B03CF
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 082E3300BD56
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337C391E7C;
	Fri, 22 May 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ny9eQ26F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A50314B73
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436257; cv=none; b=rGZ9zExZ1706+aZbOKZ+7HgMFBf/2WZ+eNxIEct2DXyv6xopFk+wfeoRnGfIqrWPbBgclmjp4avbJguPbv0N8Jjp+ijrTBaXyrWjRWhTMrUkQmbaMqOh/saa0AO0qTsV07JKoe4AJ9gOH1BNj9RwaIE8Qwf75FVetFz+43ZRnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436257; c=relaxed/simple;
	bh=L94C2IhDkI84foaa6b1rpY9m9/JmssJaFhGedDDJcRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JW1s283DLQTpQLmZdiQqWd7OHTO2jjpR3lRL9sN4E4J0I0OoaOSewTDagtFROVTg2IuKAI21DIdubOEPEHuDAhuog3ZcDp5lPmII4vQ4nELbOUqZFipfpqgdqinHV/hJ48Cgo7vJJWHn1zE5ZSv3U5+oIBg560WPtHCUEcTring=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ny9eQ26F; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-449de065cb3so6595018f8f.2
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779436255; x=1780041055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIEb9ggG0eAxPAQdLyg2Vnh861QdBe4aCNdLHS7hOUk=;
        b=ny9eQ26F5yeRQoDcf1xc8EVidAZ/S4plCpSLWHfnqVkaNt4d7qx5TA4aENNWkLswad
         G/A1KKNdrB/fQd1ubOZHWRo6y74rZnnMasoc+FYq7jFuZsv2dIAriL43jcT1jxNVx4wv
         pmQwHbTU9GJl75gO6du9vM2bKBX0XthGoMzWZ5Mf0qI9wGcE2u+T81g/4g/WSXSmNxdw
         4NzJpAzqpRFS78CoAYNk7KZjhdn12bhUKNcQ2S7cMzXi6SIjBIWG+ySQuAGKn8JTFDTT
         rr5pLZBWTYssPf2MHN26Cv7tZtdsEfwU6e2ElbUb/srlT8Nod27xba6YukqEECSqLSV9
         2B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779436255; x=1780041055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kIEb9ggG0eAxPAQdLyg2Vnh861QdBe4aCNdLHS7hOUk=;
        b=exFIBMgat72x7BJgVC+xZkK4k/A54kxYI+k3ZdD9bTNKkvheHqpERXv3Oy8dnQkh5O
         2LM/vGX6hnVw2u67ASXSHy2eDnYZo4dyDc6ORpS7+8VxWBD9J9ylCMwM2wgvN+1nSh1l
         vUya/rXm4vKqZfEN6UKSZK9F20Pt0G6NTeuBvhSqWpNDAcS2nXhVRd+ngDWJG6pPTra0
         anpp4wW4D69nngad6uTn4gtvaN3OR+B+wLRSowd7ZvmuXylYxrVWVTeRsYSWRTRxRLUm
         rew/hlluW6I3h5MIvYfeX5z9sK/hre9eQvUKQXmav2bhfYGjm6uMF2gaaXUZ4IhVoTCc
         1pQg==
X-Forwarded-Encrypted: i=1; AFNElJ+wj9Y9q+z6+eZi5uplAOnrs6EYjCh8wgYWJ4VLX4T0tK+BwzCTjfFS9IfuJOvLfzzJ946E5SRT@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuR8NMfb8JnDkA1Clpi//NPbIrLexiaFqY4ndvdXfOxmeZYhf
	2V1FjnoQruJ4i7D/OnFfMwXIpmPrGzwrL5Hf5w3zTre0ll4w15yTULu2
X-Gm-Gg: Acq92OHP0fRdXlOGzXC4oivZ39gGP6uD+xfNotLYwFT/OByQLEIMiyOkC+BGw4U3Lnu
	mu3GGi7E63tvxjLm2L6Wm7GVy3CPL1PaUnwHLhOdccOjHGpIqeoHS9NUX3+yYGOcLAHHbxmlAN7
	WDNERTnpTDECK42lvxUBILovmdp5CDq9A+I/J+l98+at8FYDKKRCCJZAyEopKVo+rPH/aTq6VBU
	12Ej1I0uu9FuGNKJ/7ElOONfI+nL9eZ8W95BCRbwtjyKKZ4W9y7j/xApY19N9mM1IO4OpMElNO1
	BYhfrYwx712Tir7v2Dvi4hutON4p7T4DN7ouuEuiUHaLct+Wvmb6nBM7GvMUZZ0/5PqYkZORAKf
	CuIb98rUV0V6JW2jVvx7bCGEFifrSG8HfuM9YW4eCBunKWjwdEIrCiPsqr2fJErX7n+09ZcbyWj
	/svgErwNy1pMzFYa2qCNjXPsMpThvAhzw6jdWZgTk5CgXOWJDgqAJHgmfoKHwzEycDhTExbBWhf
	sE=
X-Received: by 2002:a5d:5f54:0:b0:45e:73a5:e1ed with SMTP id ffacd0b85a97d-45eb36adb4dmr3485752f8f.27.1779436254515;
        Fri, 22 May 2026 00:50:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d64eb1sm2686180f8f.32.2026.05.22.00.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 00:50:54 -0700 (PDT)
Date: Fri, 22 May 2026 08:50:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Qi Zheng
 <qi.zheng@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Harry Yoo <harry@kernel.org>, Meta kernel team
 <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/4] memcg: int16_t for cached slab stats
Message-ID: <20260522085051.0b4a3f9c@pumpkin>
In-Reply-To: <20260522011908.1669332-4-shakeel.butt@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
	<20260522011908.1669332-4-shakeel.butt@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16199-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,intel.com:email]
X-Rspamd-Queue-Id: 1AEAC5B03CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 18:19:07 -0700
Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Currently struct obj_stock_pcp stores cached slab stats in 'int' which
> is 4 bytes per counter on 64-bit machines. Switch them to int16_t to
> shrink the cached metadata.
> 
> The existing PAGE_SIZE flush in __account_obj_stock() bounds *bytes at
> PAGE_SIZE on 4KiB and 16KiB page archs, well within int16_t. On 64KiB
> pages PAGE_SIZE is well above S16_MAX so that flush never fires, and a
> sufficiently long run of accumulations would overflow the cache. Add
> an explicit S16_MAX guard before each add: when the next add would
> push abs(*bytes) past S16_MAX, fold the cached value into @nr and
> flush directly via mod_objcg_mlstate() before the accumulation.
> 
> Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
> 
> Changes since v2:
> - Collected tags
> 
>  mm/memcontrol.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4f00a8159d5..78c02451312b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2022,8 +2022,8 @@ struct obj_stock_pcp {
>  	struct obj_cgroup *cached_objcg;
>  	uint16_t nr_bytes;
>  	int16_t node_id;
> -	int nr_slab_reclaimable_b;
> -	int nr_slab_unreclaimable_b;
> +	int16_t nr_slab_reclaimable_b;
> +	int16_t nr_slab_unreclaimable_b;
>  
>  	struct work_struct work;
>  	unsigned long flags;
> @@ -3158,7 +3158,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
>  				struct obj_stock_pcp *stock, int nr,
>  				struct pglist_data *pgdat, enum node_stat_item idx)
>  {
> -	int *bytes;
> +	int16_t *bytes;
>  
>  	/*
>  	 * Though at the moment MAX_NUMNODES <= 1024 in all archs but let's make
> @@ -3195,6 +3195,16 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
>  
>  	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
>  					       : &stock->nr_slab_unreclaimable_b;
> +	/*
> +	 * To avoid overflow or underflow, flush directly if accumulating @nr
> +	 * would push the cached value past S16_MAX.
> +	 */
> +	if (abs(nr + *bytes) > S16_MAX) {
> +		nr += *bytes;
> +		*bytes = 0;
> +		goto direct;
> +	}
> +

I think you should do the add first:
	nr += *bytes;
	if (abs(nr) < S16_MAX && (!*bytes || abs(nr) < PAGE_SIZE)) {
		*bytes = nr;
	} else {
		*bytes = 0;
		mod_objcg_mlstate(objcg, pgdat, idx, nr);
	}

-- David



>  	/*
>  	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
>  	 * cached locally at least once before pushing it out.


