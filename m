Return-Path: <cgroups+bounces-12319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C0CB25B9
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0055D309A435
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987C330171F;
	Wed, 10 Dec 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g2eDdMpN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC033016F5
	for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353947; cv=none; b=euaYftpKOXP0/fohbeZMHZuXxB1yEqaJcNtcvbdnjvKKIvtWUEEsOY1bwXbCd53O/RnSi/HWMbif0O6IyJIzI5XkfVJ33FrM6JCB3uyyqQ/bk0G+LIomeTzKZCw4MuKxa5LFYaDtwQOsi9ZJxCK74jyvQweZyodtlG+XdmrbMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353947; c=relaxed/simple;
	bh=Mfh2SMZWLlsWlSRRauGLCGgY1RkAjY2MqjEguqh+FbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhNH7eyLFIk23COOoikzEieWQnVBYd9/5Xf4RcSA7m0ZIaaYrZIpS5LJg74biTYMavleztIYcnop6w45h+R1zydFrQxHsniVrzHTzuUUJDuldMb67ZZW3UTbgK1FNrhsdRCb+pASYm/UUf4DWMe8vVBqqCNwLGI3ayfvA0MlJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g2eDdMpN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47774d3536dso5796075e9.0
        for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 00:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765353943; x=1765958743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQfsJf21ik2w5RavX753kN9D23TLoxAYXM2cGk1af+8=;
        b=g2eDdMpNivkqMBZIkUNbLJLX0vEohPuicWEXmfCDhSCMOAO2vZ3euW8by0S6JigKmB
         flDkmQzVYDGSE9X1urwwq9z7MsetllmMy2AkJ4f98gqyfO4Td1dNYaDxgieVzmr3AKQN
         N8+z1NJAUYnx3MgemVx6DaO7FuKjz+ZpxnimnOD8A8fOGP2R3zEv8epzibPya/RRIS1V
         9Wf/FjVYfjHYrPqSsANSrzSdZy8ZkgVtCLmfB0z2w963io25QRz5BwqwmIToWAgxgyJV
         a/+I3jqpP23AW/Kx4ls3mvs2qEBWyvAmoGr/cqGwNuv2rr3aocoQN/aqMfqHWDzKPZGf
         Rv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765353943; x=1765958743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQfsJf21ik2w5RavX753kN9D23TLoxAYXM2cGk1af+8=;
        b=n8lA7Xj5R1kg2Ayrb0U5qb680QaJrs7h9YglUr0U8yg6/1m5A9lvVLLD3fu5hKGY7y
         JB7aVOo6GzzZsdJ3pOMf7sBEYC6I4mG+y1nPuGdRgG7klzP2/1NoQNUk6gM6huNsCqkj
         5wCG+rtvYm5PRl2pjAAgLvqpmzNMF2srRE669NzfOcdHFsq57j5PFYIWJY6HaPCtudI6
         1HTeAiIpenr0BE/oDeqIh4QVcGwJppS1woMwGOJd4KVEwmVcFgoFTuSVT6OdbVkC6h7A
         pgRB43RBoRLV99OlePKO7JRVfP59NLF0w+8l7xNuAObOFe1xthe7ZM2DeoFtV4cnP4ks
         BYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtj87fpoad7Uf3WwlkSDhgv6vdy4PYWKg+xa4bmz00R+yMQZORrnmdd/S1+911HVdSMnPUSdKU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpr+i/i+1kbKXzXZPXVW86ee0cYbK1phq/+g60+SneHBuqbS3L
	m29tZNQH9iDeeRKORoZZ3NJWxwxM+HhkMcf29eVEU4huJ8bUIp5jHHkehy3KhEpUIVc=
X-Gm-Gg: ASbGnct/CGzx25Xs/bVmnrnZ8od68FFhJq5CMBzpCzN00/s5gVqgKSlfReaJdApi1zo
	ovxWSSYUVCqndz1q86SrRUaiNZVJV1kZwaoyGe7KCgZVVCzqRX2qRIFNeHa4OJMACAbcnXWWddB
	/YjiD4shfSpixeLdt9kqo98EQdp3zaa12dbRSOactp0TEwCAXowggG+P/piyS7SCdIMzI9vP9MA
	mVfT9wEPGeS1QsO9P4/d+/QyBWZP9eHnzlwN21ydT5M4Loq6BgiMNwKV8e0dqjG/WwQbVW8G1ki
	3RTZ2xdjJBNDz0cQvZg9GRb7EmGM9a+0L8S4Q3zWU34qwdc8daZo8goUyRPFN0XjTZdtmkLhBNt
	RvSPu5YQCHV3hPH7mF/5W7W0yEMXWVlXE+5W+Ctn9qsa3+S7yHHz6F/pTd8P1JWmvINkFKdTfLq
	f3pmE2Xoplpk8fTxBBLJ2S+f+J
X-Google-Smtp-Source: AGHT+IGvXzDH3zfRh7Jnwp4XKq7wlBGzq/g6vrlmPFCQLIHg1YyyhLYmcswXxMwGpDgJf701MMd8gQ==
X-Received: by 2002:a05:600c:3b16:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47a83934bf8mr12958385e9.15.1765353943426;
        Wed, 10 Dec 2025 00:05:43 -0800 (PST)
Received: from localhost (109-81-30-110.rct.o2.cz. [109.81.30.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d26f5asm29905245e9.5.2025.12.10.00.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 00:05:43 -0800 (PST)
Date: Wed, 10 Dec 2025 09:05:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next v2 2/2] memcg: remove mem_cgroup_size()
Message-ID: <aTkp1tIIiw8Nti10@tiehlicka>
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210071142.2043478-3-chenridong@huaweicloud.com>

On Wed 10-12-25 07:11:42, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The mem_cgroup_size helper is used only in apply_proportional_protection
> to read the current memory usage. Its semantics are unclear and
> inconsistent with other sites, which directly call page_counter_read for
> the same purpose.
> 
> Remove this helper and replace its usage with page_counter_read for
> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
> to better reflect its meaning.
> 
> This change is safe because page_counter_read() is only called when memcg
> is enabled in the apply_proportional_protection.
> 
> No functional changes intended.

I would prefer to keep the code as is. 

Btw.
[...]
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 670fe9fae5ba..fe48d0376e7c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2451,6 +2451,7 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
>  static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		struct scan_control *sc, unsigned long scan)
>  {
> +#ifdef CONFIG_MEMCG
>  	unsigned long min, low;
>  
>  	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
[...]
> @@ -2508,6 +2509,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		 */
>  		scan = max(scan, SWAP_CLUSTER_MAX);
>  	}
> +#endif
>  	return scan;
>  }

This returns a random garbage for !CONFIG_MEMCG, doesn't it?

-- 
Michal Hocko
SUSE Labs

