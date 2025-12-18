Return-Path: <cgroups+bounces-12508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D56EECCC095
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C2DC3072AD9
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CF533554E;
	Thu, 18 Dec 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="jmGBdzjW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F682334691
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064774; cv=none; b=qgpdEsIB55yB2bdaYXnvFeFqUfAstaWLbj9WOW2ywX8b8+96QUbKnFGfi8dcZI100yadsqRAuOsks4iu30ydYiVMgIZwWl+3qChLHpYbRNzIrif9kru8HTVu5o8YcVX4jxQ9tXEhfoXuAELq7eqFVC1S5E0mHZy0gHtmRbGLi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064774; c=relaxed/simple;
	bh=YGEoRnWIgYwcYRWzBC1zSuyhYRERcXNcHvF3xnGn85k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2pZNkryqhjMqJnuOmyzLgnzRMvY9aqHbQk6g/8VabXIl2A62bnEusWT1iC7Q6X6NpeoVDph6tuj3Hq6A0Qt4jjxg3DpS+MAXB5cR5NiIIbuimCLdPjZifoZMBiOxKWE3PsYt0+aAWJqjpl5Vm+Yg54zMmudfQv6F9wbMqPEAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jmGBdzjW; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b9d2e33e2dso94680785a.3
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766064770; x=1766669570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQWA//U94w+RfVBDi+XEBJcp+dqWUOXxb8pArjVqn04=;
        b=jmGBdzjWGbml5DSAjuSTWqpaDoyS91gMnkK7tfC9lx1VnqtdwNWV81idyPXpCQZ9wL
         qBSuDrPZBvFQEiOGQQXyjQR2+4qHLCqtmkq/w2Kw73Xao3ZcGJZbWfyw+twYJiljLKPQ
         NFv7QbDVqSF2VF7r4IvNDQF9BByRedEQk4TvdxrbB9lsb0cgF/KOgnzCDxiqApPKpvqq
         wkjmEkfmUANys4VB9AhNgxPVqHddB7QFqfyOFS4/XzhwngMUxCY/9Daq7qu+BgJqTn9p
         3ON4M/p4l7bv4AtSB7NFDNQCbzdJi1at87nK/Up0Bn6f+X4XAFeYP9o2mk6BtO7X+kjd
         pbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766064770; x=1766669570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQWA//U94w+RfVBDi+XEBJcp+dqWUOXxb8pArjVqn04=;
        b=ZP3TsxSoHe04TdodNC2Cgd+frzymzhrlHG1A5XrpZADeuShbe4Qax7wBrhoM7IKXeu
         uJ2pQrQ+6IKQjAJ8p8LazeY515O7N9FbGNB/wNHz2MvAJnVzv0ceToA74TrAlfV80Das
         jUo+R4yQXXMj3HR8+jsdFnLrB293YKTAOVVj3u46pcQJQS7zPiNkzkN4aW4lqgF3gFJe
         mowYN2olmycXhQHJaa8Ausb0vdFj4RQfIzuWxJQl7Yq+4C+0lxN8Pn+bdHc3lNgj5ffM
         uktlyJPACU0sC45+odpT1LU3jH2tuupbXxLc4fMs9+Sz7Hk5Vt/69d/ugT83k3LK0pul
         m6DA==
X-Forwarded-Encrypted: i=1; AJvYcCX7U9kRZsWGzUijW6pAxFVoyj/f39VSURifdmtdxmTHrl+auSIaIEhwYb7wAKuMwBqPAJaLOUjA@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8Be0ycvNOHHAtH9covUg+DHA/vUDvhTNwDc1EXsljyrrlVCe
	AGHf/S6hA4bqYeFLzKg07ZkPBBqS5fmgwacqBHr1m9o+Vi7KYOJ1ZXLSTKsvPgkW7RY=
X-Gm-Gg: AY/fxX74XycdZMGhYFVXwViTp+I1JGW/HOE5UKVj1Fg1fLOdED/gQvVUXmHRhmjAWuQ
	1PhChgzTBW6v5rCNtRGKQnj3fB4WT61DwgVg2CEZu2SshmbRUO0BuxzbcJfgtAiTa3pPY6abhd9
	TX/IjSacz1wfVsVtqHcu963vfjek9eMF8AQtd91+NSxNFpWvUrSWokVVPy0onS49p1O554akXHz
	Vs4bVDPuakMsRj8Mhqhr/qp7slt9NfjPrzpPVg4N3oq9jrskXxIcX15Y5qo8eA1EYj9iQeHqUnA
	jiFkuQgnzwfTdIF97Lg6t9HaQX4IJgp8rzXtTWF4CUOJ+Kw3Pqv0wojB0rLT6dz2Qx5plzUJbrf
	MNaJ0++fOKGeDyF7INilRD5v2iRAoosMMIKV9Jf9jEKxlwTt+iDh6SiaDQHOlE+gmmX/jL2gEnb
	EGSqulyd8qEQ==
X-Google-Smtp-Source: AGHT+IH3FUksskKCGR1DNGkk10snBCU32vYx1Rd56tm0XXUZfGBDWgz7+GVVqCXyzIf14zAp0WBPFg==
X-Received: by 2002:a05:620a:319d:b0:8b2:74e5:b11 with SMTP id af79cd13be357-8bb3a39c0d7mr3122332685a.82.1766064769594;
        Thu, 18 Dec 2025 05:32:49 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb5d5fb7sm170608885a.7.2025.12.18.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:32:48 -0800 (PST)
Date: Thu, 18 Dec 2025 08:32:45 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 24/28] mm: vmscan: prepare for reparenting traditional
 LRU folios
Message-ID: <aUQCfdnoLQDLoVyg@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <800faf905149ee1e1699d9fd319842550d343f43.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800faf905149ee1e1699d9fd319842550d343f43.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:48PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> To reslove the dying memcg issue, we need to reparent LRU folios of child

     resolve

> memcg to its parent memcg. For traditional LRU list, each lruvec of every
> memcg comprises four LRU lists. Due to the symmetry of the LRU lists, it
> is feasible to transfer the LRU lists from a memcg to its parent memcg
> during the reparenting process.
> 
> This commit implements the specific function, which will be used during
> the reparenting process.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Overall looks sane to me. I have a few nits below, not nothing
major. With those resolved, please feel free to add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -2648,6 +2648,44 @@ static bool can_age_anon_pages(struct lruvec *lruvec,
>  			  lruvec_memcg(lruvec));
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
> +				enum lru_list lru)
> +{
> +	int zid;
> +	struct mem_cgroup_per_node *mz_src, *mz_dst;
> +
> +	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
> +	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
> +
> +	if (lru != LRU_UNEVICTABLE)
> +		list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
> +
> +	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> +		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
> +		mz_src->lru_zone_size[zid][lru] = 0;
> +	}
> +}
> +
> +void lru_reparent_memcg(struct mem_cgroup *src, struct mem_cgroup *dst)

I can see why you want to pass both src and dst for convenience, but
it makes the API look a lot more generic than it is. It can only
safely move LRUs from a cgroup to its parent.

As such, I'd slightly prefer only passing one pointer and doing the
parent lookup internally. It's dealer's choice.

However, if you'd like to keep both pointers for a centralized lookup,
can you please rename the parameters @child and @parent, and add

	VM_WARN_ON(parent != parent_mem_cgroup(child));

Also please add a comment explaining the expected caller locking.

Lastly, vmscan.c is the reclaim policy. Mechanical LRU shuffling like
this is better placed in mm/swap.c.

