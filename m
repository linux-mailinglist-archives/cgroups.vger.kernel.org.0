Return-Path: <cgroups+bounces-7932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A636AA3D64
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D57B84EE
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCA255F2B;
	Tue, 29 Apr 2025 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLnl7glB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79827E7EC;
	Tue, 29 Apr 2025 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970670; cv=none; b=DGKabIruPNbJh/v3zdjnxqayUKX0lV31soRlQdWp0n1fBWkusmjYAGnTc7l/r5tcTlLgJyCbwvR5VFFJPqsyhYLV0jTcPwLNO/UTsj9WmwW+ZrGI+cBPSR/Gba1GTI+k/dzeptPuONGWV9cx/PJU0V5nSNhH7CRa0nUljPbn1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970670; c=relaxed/simple;
	bh=uapYm7FVDnBf3dK07aTCMdFghyjz+MJ2/0nrFKN6uq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m40wArufD4X2mZV6Ywkv4knHZR9FNJdXeocrL0DZi0z4W7oEhqswnjx2Yo4+LgR26/XW9cFCG3z0C3plv5DFh2xS40gIgzegnc55iY7gTz9Dm99PxefawFu6BZzNX+YLYodr/DYXSUSJMq/Hi5sLKELv7HFi9JWqVTR8Xpp3Z4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLnl7glB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so83364355ad.1;
        Tue, 29 Apr 2025 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745970668; x=1746575468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWi0iKQPjiK8VNZS+w1eIOJ6efpbQpqRgqiKbA2bPi8=;
        b=VLnl7glB6jSWZscFYDRWVib54ndYEvHyoY3KG2u57A9UmwGmyP9IPLTPumgvuydTqg
         jv1M4u3dU4gEyymcUypxVBR+mTdunRYb9aqm4GYXQoAcrkKsRgyVnLUpp8mX0kdXK0F9
         Et2lu4To2ZEWP5nyDNGLPu5E0xV6S/UhBgkxprlY4jiM9rG3FrazCIMMU94Oi5SBvU0p
         UVmMDX6GnlMoTgOkZgOh/a4br1UK1S8mg2drUD3gDFSaMiBUL7X/gfp3EDlZximMrtSR
         tM5cQRpEqggG+Dh/Cn31yUd5MYjoO6AXG1RqTBqpxJP9NqDgzJle2rIQ2YjhIleZGx58
         NwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745970668; x=1746575468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWi0iKQPjiK8VNZS+w1eIOJ6efpbQpqRgqiKbA2bPi8=;
        b=ijuRmW5VoRKFhMMEABdbgTa2/7vbbNtX5nCHgmUKqbc618P3zda0CY0sfpQZykMYjb
         1u4CT29c+zkIKiEKoxuaLl6wVFyu9XYL9PmoWp9RgsN4/paZQICV5z4z0ksO/RtM0l1i
         1DPd6DEak7AvNSmnkrQlD2EXPiTo6rJk2oFw407olZM6Y8+iTOMIIOpOKvSl2W1aH1VS
         wY3avVXE2Zb75ChAO68f4vW35q0PnWwJ8+Qklh+diX1leuA5u4LwkQZ5uwl423vcuGBv
         04H+ADLAHHbala/v1fRSUD/mXHRz4yEPo1i7XSmD7OvNt0YCM20s+WctH0WIx+5oqDgs
         vQaw==
X-Forwarded-Encrypted: i=1; AJvYcCW2YcrDUIboQfl27S6MhXQN7dvfh1odEce7UbUAUSC0MAib7IIQukafiKI3SXNq4rT7g5SgYn3ScZpKztLf@vger.kernel.org, AJvYcCWU5jRX7UL9DaR4eD8ehhu+f0hK/UCf4kKxB256dMBjca5Rzav8OmTBhx5syaBGl9E+e1uYatluvg==@vger.kernel.org, AJvYcCWvmAxPU8iC6QNfiO0NfLx1XOA+S9o+TFfMYNF8uaQaKKcviL2gxOOkhQLG9xO0ETVUVLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8spCxhDyN0O4vkRCHSHxauvvuEzXDyOmsvN2mtF59myVTvG1
	+BFwB4m6AHEstfKcXHyxRQHhiVqnGRFUhTFRIqpMarJ1Iq5m+n0B
X-Gm-Gg: ASbGncv+AYPogqmHLIKaxY1xMxJzztFVYf/fXCsZ4d6EFkgRH7lfxFU7wfRAxJwJIwQ
	LXTgmXFofQ1gYqnsR5Vy/6KYqXuwxqnQ7wiSv+g/4NyzzIXHfJBXwAINoERgetPQco+Fh7JXVXd
	gt7QNTrUo9CzpeZFj4j78CKolCqx0/XoWJuSLV2qfuidmci/U/JdZ26gXNMMJf1QkrOzI9h4vw+
	SAekGDCfgCdFERY8fmztpwT6rqtFd19GezUiGWiq+54zugakPWzbC8gZLIpZ/3n4JxvMWGmAq6J
	pUBYo5++plCBq3uf9uNdquqxcvrLGNzpuPhnkI+cUUgohvxlXOaN9iQG4cwH/7C9Zcc=
X-Google-Smtp-Source: AGHT+IFAj6/RzPK4X20pnS0N9JEaW3fbDH1N/Pm18wDM03DDlN1B9O+hmXJi+f6vFlhc2cYqcdfalA==
X-Received: by 2002:a17:903:2287:b0:22c:33b2:e410 with SMTP id d9443c01a7336-22df5764831mr6298515ad.2.1745970668013;
        Tue, 29 Apr 2025 16:51:08 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4e0cb15sm109577275ad.106.2025.04.29.16.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:51:07 -0700 (PDT)
Date: Tue, 29 Apr 2025 16:51:03 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] memcg: simplify consume_stock
Message-ID: <dvyyqubghf67b3qsuoreegqk4qnuuqfkk7plpfhhrck5yeeuic@xbn4c6c7yc42>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
 <20250429230428.1935619-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429230428.1935619-2-shakeel.butt@linux.dev>

On Tue, Apr 29, 2025 at 04:04:25PM -0700, Shakeel Butt wrote:
> The consume_stock() does not need to check gfp_mask for spinning and can
> simply trylock the local lock to decide to proceed or fail. No need to
> spin at all for local lock.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 650fe4314c39..40d0838d88bc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1804,16 +1804,14 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>   * consume_stock: Try to consume stocked charge on this cpu.
>   * @memcg: memcg to consume from.
>   * @nr_pages: how many pages to charge.
> - * @gfp_mask: allocation mask.
>   *
> - * The charges will only happen if @memcg matches the current cpu's memcg
> - * stock, and at least @nr_pages are available in that stock.  Failure to
> - * service an allocation will refill the stock.
> + * Consume the cached charge if enough nr_pages are present otherwise return
> + * failure. Also return failure for charge request larger than
> + * MEMCG_CHARGE_BATCH or if the local lock is already taken.
>   *
>   * returns true if successful, false otherwise.
>   */
> -static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> -			  gfp_t gfp_mask)
> +static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	struct memcg_stock_pcp *stock;
>  	uint8_t stock_pages;
> @@ -1821,12 +1819,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
>  	bool ret = false;
>  	int i;
>  
> -	if (nr_pages > MEMCG_CHARGE_BATCH)
> -		return ret;
> -
> -	if (gfpflags_allow_spinning(gfp_mask))
> -		local_lock_irqsave(&memcg_stock.stock_lock, flags);
> -	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
> +	if (nr_pages > MEMCG_CHARGE_BATCH ||
> +	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))

I don't think it's a good idea.
spin_trylock() will fail often enough in PREEMPT_RT.
Even during normal boot I see preemption between tasks and they
contend on the same cpu for the same local_lock==spin_lock.
Making them take slow path is a significant behavior change
that needs to be carefully considered.

Also please cc bpf@vger in the future for these kind of changes.

