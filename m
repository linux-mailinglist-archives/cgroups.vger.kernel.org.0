Return-Path: <cgroups+bounces-7739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5DA97C05
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 03:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E051B60EFE
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 01:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271A2580D2;
	Wed, 23 Apr 2025 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4j68ywu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E579D0;
	Wed, 23 Apr 2025 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370624; cv=none; b=i8T9zzOq9cvwSDydDfUU14O8LcmalNqvsdzjSYxqBAoPDYYZWdTie8ltDqNBtc/4s4OUihi4Zaa+j4VKtaJdkF6JtYOtHHzv29sYoxbSb2BuZn4Qlw2ypoUlzMT2MWSMHlKya+nmcs62/rfc4rS0VTw0RYVciWj74c05JG2opgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370624; c=relaxed/simple;
	bh=sjPUyN4F/YaLRPmL3I2xyElWDgsGew8KjWR4AzAnMJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/pcdFi7XjvGuqGch3mHPW3LgVuEyE6hoBkiCQ152q5ce/WoN5kWb/rs3TeNBgJ5z2y9twMQqJ2exa6a2S1VFywI7UIw7ptFGrbFqXXZbzYhFpi3MZ9qJw+k7DWPe2z39A+ZtPH62+OcGQD9lDHY99rIj7m7/TC7r/x0Itdivr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4j68ywu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F11EC4CEE9;
	Wed, 23 Apr 2025 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745370624;
	bh=sjPUyN4F/YaLRPmL3I2xyElWDgsGew8KjWR4AzAnMJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4j68ywuYSRMjIZ4uPsLtTCTyphXRs4hb6s2H+9sm+Lerq7r5BeXgCrRUwpKuaZXd
	 NCzUKd/DqznGMuX/3I+yj/EHefLowhjmjVXRie2Z4Hj9N+LxJaMrXN+LsNWMVZdXyh
	 rfrOvPOhRTzuNkKHYHxO0AiQGOcqZxuYVUDGrOZGcUbxTCY0jXIRBkZW98TIiyXm+a
	 qvY91vYxzTDJOsgvaPnICQg3MncgTs4Xf86av15xJadSbTD9GYZ0Suifr1VyOaSG73
	 Rkd9HalVLjcfOOXzP3a/2IddJNngepg7rJb1eO67Qka5OAcghbN1uWHTDUf9wCMNBo
	 gtSAlRYs4PIrQ==
Date: Tue, 22 Apr 2025 18:10:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Vlastimil
 Babka <vbabka@suse.cz>, Eric Dumazet <edumazet@google.com>, Soheil Hassas
 Yeganeh <soheil@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <20250422181022.308116c1@kernel.org>
In-Reply-To: <20250416180229.2902751-1-shakeel.butt@linux.dev>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 11:02:29 -0700 Shakeel Butt wrote:
>  static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	struct memcg_stock_pcp *stock;
> -	unsigned int stock_pages;
> +	struct mem_cgroup *cached;
> +	uint8_t stock_pages;

Is it okay to use uintX_t now?

>  	unsigned long flags;
> +	bool evict = true;
> +	int i;
>  
>  	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
>  
> -	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +	if (nr_pages > MEMCG_CHARGE_BATCH ||
> +	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
>  		/*
> -		 * In case of unlikely failure to lock percpu stock_lock
> -		 * uncharge memcg directly.
> +		 * In case of larger than batch refill or unlikely failure to
> +		 * lock the percpu stock_lock, uncharge memcg directly.
>  		 */

We're bypassing the cache for > CHARGE_BATCH because the u8 math 
may overflow? Could be useful to refocus the comment on the 'why'

>  		memcg_uncharge(memcg, nr_pages);
>  		return;
>  	}

nits notwithstanding:

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

