Return-Path: <cgroups+bounces-12428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B83CC6CED
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 10:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9F1305F3B6
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415F33A9F5;
	Wed, 17 Dec 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cgst9XJs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2A33B95A
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963900; cv=none; b=QayQBwKAuVK04wi0uI/qSruGV2qjQkO3YxwK/2Vq/ThIrcCbj6MSQjlNB6r1w62viXHN0k+5A1zqWXcq041ELimSNpfLQBQMvhKc5WMjZuuy+NwY/GZ2QBLq1qXlICJP/UxO1JJfEmR+Melo/+LebbYX73tVvR9brKJEK0QYNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963900; c=relaxed/simple;
	bh=Yt8k6jHem+sjqoJ9MdbYAJqiWv3kHqcoVBPkLP9hJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyqgB+2S8qThk4s1cHMN76eGa1Vtd2RSqbY8/xlkUtnuWu0u0PE96eVVbE3lkrq1lrq7HdBT4J8QecdDlWaFmBXY2v6mgEV2MIctLlIiwtb9/OViT8jh4TkjE+fNxUotVNJ9zr9np/5Ogar30mNdKSLKGya6Z74NYg2VsFXbPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cgst9XJs; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430f1cd0026so2706889f8f.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 01:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765963896; x=1766568696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zup+NREwv4bDGFbQ2A2HUXZHOK+ZTfY+5pUYXAKCRlU=;
        b=Cgst9XJsx2bHZs0IePYRFKgYK5zTf62alX0LSd+593nF9vY3cGUecJdb2GHmwqIxln
         W/D7+95R+VOE1Ao0yOf0rtmpvdbvdXFt+c1RaePfSriGhw3OB10EKX38LQKy3L5zhSB8
         NKyMiw9KrJoEsqdT6HHi0YC+QcyfGTjtn/TsPgwWWAqeSJA9Yy9zueHuNR9a1owGB0Zn
         /TiO08EUmjyi/wRqfka4GWOpCUnkSnGwTRImgbFjvArYjmXBhivu/9+Iy2gh9LzYH8KQ
         mbdU+ZzTb8IXImXyvyallde2jtY9DJwk4C7GuxdhROaEM6WoovfHqdOvIUN63B8wvLpP
         ulzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765963896; x=1766568696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zup+NREwv4bDGFbQ2A2HUXZHOK+ZTfY+5pUYXAKCRlU=;
        b=HhdNmLRya0JNUb/vpWViC6pnb1Mud9YI9cNyMH1KIlE1WKs2aflH6Q/itabCOUFP7K
         osNEghVpmtoVVSh8ldIeXqREYlt6jQS6gMjrN7tkpQb3KtDSuwimaPgKZM4qSH2CBei1
         3ItrjGe9XagA6pRGDJWYW7jFrf+tCUczsg6xchkWr22twcDu4REjePT6pHmFRJ13JTVe
         kFuiUK+yvoQqI++ibrMkE+N28ZecKqZr33kdpNkgGQMXl4tBwvc+mrlXfPkN65mS9hFk
         4vlA0gCePFE6BCd139Lo2HMn4dfEVvBArTQYPibhf7xeWdBf8qowV+WjOns9QDhIlOXw
         z+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUz2Xms3Ieh5UsE52eV/WJqUjP2JZLSOck3wsby5drDum/15kAwxolzGpo821h8mUnD4M8JiyNh@vger.kernel.org
X-Gm-Message-State: AOJu0YxLBuSiK0Lm2E1dZP23V95nLT3XasmUdDkBUdqarPyKsAMQ5zrI
	UlUkoOlJIlXePtKro0ZNn2ik5ZyuQ/XKcb9FSu7Wc0ycVvr33YV8QHi2J1Q2XTBMkPE=
X-Gm-Gg: AY/fxX58g+QyuCn7q3GrGBr3MTPJaXll7A1p+rue3Ow9Y7M1Ec82wiOA1a/1wIr7LlN
	vcFZV6RYgJm2yqDCpcqxAzUMr+9ByNskZAYplZV0XS/zMmSwR7E277zl5B0dZIYMOV48+oWOHBd
	/1gIay3N4ZeQl6kj/r6mL7yJI6yb9oqRwtn8Nk6OFf3LrDN/18FRpqOvfhcdS839uIaDY957eUK
	0I2tCaMiaNWoPkdbs7ccsGFL17JNJ4g8y+yFBxv/xO1MjPqGjdqOJ878TR68fUcGd6r5aMIVY2L
	UCGa0vOAsyPhRs3bWTBGPgkHGvVcrC7/0Jp3Ny2Lv06UI0AMyFRqdAkogCndM8JKjjrD04rTdWP
	IIKS5QlUcHz7QEnhXKjcpUs8RTsQd1/QlJp00G0KdW2UuvkihmyOEyak3WBD8D+gQPd1zukaeCH
	SJg7SqgH2SUIEY7WkvSI9b6u0z
X-Google-Smtp-Source: AGHT+IHUg2s9qNRy2h8qzqEF7qPvmz9s/zPHkKaoW/kuwR3Q+5QdFqNBmMhrQm4/Lja8vlq0ergnFA==
X-Received: by 2002:a05:6000:4285:b0:431:3a5:d9b2 with SMTP id ffacd0b85a97d-43103a5db00mr6698510f8f.39.1765963896012;
        Wed, 17 Dec 2025 01:31:36 -0800 (PST)
Received: from localhost (109-81-92-149.rct.o2.cz. [109.81.92.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adad05fsm3888033f8f.15.2025.12.17.01.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:31:35 -0800 (PST)
Date: Wed, 17 Dec 2025 10:31:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH] mm: memcg: fix unit conversion for K() macro in OOM log
Message-ID: <aUJ4dsVxsUj52hnz@tiehlicka>
References: <20251216212054.484079-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216212054.484079-1-shakeel.butt@linux.dev>

On Tue 16-12-25 13:20:54, Shakeel Butt wrote:
> The commit bc8e51c05ad5 ("mm: memcg: dump memcg protection info on oom
> or alloc failures") added functionality to dump memcg protections on OOM
> or allocation failures. It uses K() macro to dump the information and
> passes bytes to the macro. However the macro take number of pages
> instead of bytes. It is defined as:
> 
>  #define K(x) ((x) << (PAGE_SHIFT-10))
> 
> Let's fix this.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reported-by: Chris Mason <clm@fb.com>
> Fixes: bc8e51c05ad5 ("mm: memcg: dump memcg protection info on oom or alloc failures")

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e2e49f4ec9e0..6f000f0e76d2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5638,6 +5638,6 @@ void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
>  		memcg = root_mem_cgroup;
>  
>  	pr_warn("Memory cgroup min protection %lukB -- low protection %lukB",
> -		K(atomic_long_read(&memcg->memory.children_min_usage)*PAGE_SIZE),
> -		K(atomic_long_read(&memcg->memory.children_low_usage)*PAGE_SIZE));
> +		K(atomic_long_read(&memcg->memory.children_min_usage)),
> +		K(atomic_long_read(&memcg->memory.children_low_usage)));
>  }
> -- 
> 2.47.3
> 

-- 
Michal Hocko
SUSE Labs

