Return-Path: <cgroups+bounces-12318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57998CB257D
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FEC302DB62
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FB72F99A3;
	Wed, 10 Dec 2025 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OYHvrxDv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26981A238C
	for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353723; cv=none; b=WlAz3WP3/IycH5liPIZRHRaa32rNTpvmU3+7U6ZnmPLndYHwOfXekU8K94G0bdhKdNFJNIXmSrUVacq2xjG/d70F1GSAGOFxVDD72rf1tZJCzJVTce5P701cUmpzuG2XCKvuSiDO+Ev+/7ehpn14zpnNeB2ixC+EHbHgjDW7H9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353723; c=relaxed/simple;
	bh=LX8v6z/ah3+Qpk3C8yiRf3o4MPLYa8STtLsBAqPjamQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRSKLbdP7AuXi5nz2dlaSIDHJ13rXqW6zRa8AgPYcqKFBHirI7JgtONAokEUI/PExKieLg/FxLeC0NFqbX1Cc9FcD1yHSKBZuAJ7zyrO4avNb2A7/PWEQ+cOe1YPZa8gEIghIrC5HKMoRyyZH0Yrm2IbLMQVmQKeW6A2iQmkU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OYHvrxDv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a1c28778so79922315e9.3
        for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 00:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765353718; x=1765958518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DkVuj9mbdsClta7Votk9X9DX3sJA8TqrW8wJK43sNi0=;
        b=OYHvrxDva3wKMS6jndlNMFlKdxb6nza6YP5bwVZEQT7l4R4J3VmfGviqYDwJe/Uvx1
         /OcYjA05ihQ2trUQtKUAUENLiFTD/EAathSbEN1vVBticp2qYtr0y+FmeC1likE0OsQI
         s5tJeNyhBhVJNb5x1B2//QpTKiAFoar5XKH1wJn0UGW861saIt4bScNWaJzoKYxY6Rsj
         Algl1eARw0E3bMm4pL5R5/VX7GmI1uZoGnQlyHHybshJmghB1By5adFdlFv1l9Jrb+UM
         cLXZnGC3rdHPBkbQYDXB5kp+/NOUXMZ4v0PO85arrrRQwlzrzGPs+fh/9jm4EwqQ5pm9
         aAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765353718; x=1765958518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkVuj9mbdsClta7Votk9X9DX3sJA8TqrW8wJK43sNi0=;
        b=ohJLB6JW1guuGCJzBRaz7se9dnyWLJBfJ4N7nafgiJikJmrni4jUQACESKHNAVrVup
         DSAfgLx4p23WhGKux6Xi4AmWXRqKMQZxP/6Sqd2UK2pru+b5WBRNjDyItcGS8/4yzzxF
         T3opUj9+za0O+SOqgbiu9zBL/YnCrx4n2Gh9mIXWLoJeF4TS0spkrTm8Wl+Me+DaxemM
         wtcrR5AWGmnI+KxaK9sP3XcXFw5xoE1n4pkl1gShCmgxPu/ti1qDjoMgV0HXsfTcHiVo
         jmQ3nyp8QSmDRBL5tnvRpbYHpHyfpa7UGGYqAlhYSJCqHzn88MhQhVJHJ2YSoHpTMAY2
         Tqfw==
X-Forwarded-Encrypted: i=1; AJvYcCUFJ9dC87xpXfW1aJGByc2BQjm7wF+se3h8M40C5DCSM2Rv0qeBl36r/QFoiAMhbqzPwXGLzlpZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mOJw5l5lvnX6IRcGx5MTfNo4qFQhJwzBFiDPVOxvfijQMWKd
	JSW0VCUfEty8i6D4NdzaZuDp8Gqw9gsTx7xA5qsy9pMKtjMm75+wXq53RZ9rLOE3uno=
X-Gm-Gg: ASbGncuZNyaC5j6Hg7nBv9r6bAalsM7CUuSV4E8K9CmjW6sj1ecba2SYcuEzVwWlfF7
	PqzX8lsZe0sTCf7Plt35q2G29H9pgI5HIaRjW0XP3dYQU1OL3we0JTPebhFjbn/5/c1kCEgoLra
	vEE25U4k/iqUShfjIZ5gaMA4bbiW/AaxeS3XgrFJMk8dUN7pBNVIDFLrqdBGP//K3yFxRIXJKOZ
	9DiQgyHzpluQSw420hsbrDO/glRcqmMkFtVxRRj8AxCpTRqukGfSA8rnqABThFb9oO6ws4xfsqI
	mYBwS1gp1sASdA4K/Lq+xpotpqqTyXVrtYPZ/djgrjCZO4Vay+yWCcOBErhYmZ+6E469uvVYf3w
	XHRD2ZEHXpVzM8Oxzh8uhistpU/UsvXDtUsrynOEYcuKAo9IAtdXIFdvDSBKkfwJz86+NLewkTs
	Tu6V9ZM/9kZQ28b1jDWH8mNcSQ
X-Google-Smtp-Source: AGHT+IEy/SB+X1dvqUJNoBvVJAi+SW3SwFAbjV31jUhKRSf9pIbkpxwopdcXvKFxbuwv92aXLPBn+A==
X-Received: by 2002:a05:600c:c165:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-47a8378cdf5mr12959395e9.18.1765353718060;
        Wed, 10 Dec 2025 00:01:58 -0800 (PST)
Received: from localhost (109-81-30-110.rct.o2.cz. [109.81.30.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d31ec4sm32888435e9.8.2025.12.10.00.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 00:01:57 -0800 (PST)
Date: Wed, 10 Dec 2025 09:01:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next v2 1/2] memcg: move mem_cgroup_usage memcontrol-v1.c
Message-ID: <aTko72qBxxm2YzHT@tiehlicka>
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210071142.2043478-2-chenridong@huaweicloud.com>

On Wed 10-12-25 07:11:41, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Currently, mem_cgroup_usage is only used for v1, just move it to
> memcontrol-v1.c
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Makes sense
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks

> ---
>  mm/memcontrol-v1.c | 22 ++++++++++++++++++++++
>  mm/memcontrol-v1.h |  2 --
>  mm/memcontrol.c    | 22 ----------------------
>  3 files changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 6eed14bff742..0b50cb122ff3 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -427,6 +427,28 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
>  }
>  #endif
>  
> +static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
> +{
> +	unsigned long val;
> +
> +	if (mem_cgroup_is_root(memcg)) {
> +		/*
> +		 * Approximate root's usage from global state. This isn't
> +		 * perfect, but the root usage was always an approximation.
> +		 */
> +		val = global_node_page_state(NR_FILE_PAGES) +
> +			global_node_page_state(NR_ANON_MAPPED);
> +		if (swap)
> +			val += total_swap_pages - get_nr_swap_pages();
> +	} else {
> +		if (!swap)
> +			val = page_counter_read(&memcg->memory);
> +		else
> +			val = page_counter_read(&memcg->memsw);
> +	}
> +	return val;
> +}
> +
>  static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
>  {
>  	struct mem_cgroup_threshold_ary *t;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 6358464bb416..e92b21af92b1 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -22,8 +22,6 @@
>  	     iter != NULL;				\
>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>  
> -unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
> -
>  void drain_all_stock(struct mem_cgroup *root_memcg);
>  
>  unsigned long memcg_events(struct mem_cgroup *memcg, int event);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e2e49f4ec9e0..dbe7d8f93072 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3272,28 +3272,6 @@ void folio_split_memcg_refs(struct folio *folio, unsigned old_order,
>  	css_get_many(&__folio_memcg(folio)->css, new_refs);
>  }
>  
> -unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
> -{
> -	unsigned long val;
> -
> -	if (mem_cgroup_is_root(memcg)) {
> -		/*
> -		 * Approximate root's usage from global state. This isn't
> -		 * perfect, but the root usage was always an approximation.
> -		 */
> -		val = global_node_page_state(NR_FILE_PAGES) +
> -			global_node_page_state(NR_ANON_MAPPED);
> -		if (swap)
> -			val += total_swap_pages - get_nr_swap_pages();
> -	} else {
> -		if (!swap)
> -			val = page_counter_read(&memcg->memory);
> -		else
> -			val = page_counter_read(&memcg->memsw);
> -	}
> -	return val;
> -}
> -
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
>  	struct obj_cgroup *objcg;
> -- 
> 2.34.1
> 

-- 
Michal Hocko
SUSE Labs

