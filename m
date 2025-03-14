Return-Path: <cgroups+bounces-7073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39DDA6105B
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF77F883D9B
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331091FAC3B;
	Fri, 14 Mar 2025 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="brbl5Kzr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4RAkdwY"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960D1F3D56;
	Fri, 14 Mar 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952825; cv=none; b=m9ZwwWl1tLUCQUSopdmxGMa1sYFIqg6Uu5NiFL5FXvQTSpj0D2816UhX7rhlbhVhpLh0qw3gd5wGFY1WWL1czzxL92I0qhr2VH2oTrGybYPbMidmtysQttpXBT59daYh8dgymCbWR9xWA+WaZgVXhZNPlz0Zk8plucUAxPaWRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952825; c=relaxed/simple;
	bh=eMfILifgeot0mSm0mgwERknMrMaxEIKcmKZGnclhy0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydi28HPMSReOZwjoDKIxIvDTeXP3eq8XzJxEfAQHa9C2595DevLNh2wziM8KQF4whIJklknPYOLWQ51Phm7qsaBQKsgVaZFMi7b/Vn0CYcuPkKzNVTf3ze7/LMdE1+pNB/H5kq6CQQiCso3T3TIhFaPGLqrWS8c+C9jKX50KcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=brbl5Kzr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4RAkdwY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 12:47:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741952821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPFOTPRd7Z85FnKRS0cTn5GgupBXmDpYhiKtcCMp6o0=;
	b=brbl5Kzr7FFK1oFrldCAgathJeQCaROFZpRnUkEmMhtX6StBIfjd1rNPYkpBds/CT56svh
	5ajvsS7TCW1GPm0MNuIiLYhCgU9oH6ykHKudw1YnJKglRQlS6B5KAwH0hOjuK95/CS6T8w
	I6y2lMWbUviZbhH64Lo4L+jfVcYIkRQ6PsUK4wJwieT65A1hXmD/Kb0IdCQj45Y84wCD68
	lB1r7Wt3NgRo5am22H+/y9B41fquuJrHEsCW0JJDWiFkQgXGaZHAAyJ+Mtu6fCCuVqeC0I
	BHr5jc7pJEJ/pbLcZHT4YQhHNjvrbxYCoM0wVbhKOQ6oO/O2BZ4cc0OWN5252Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741952821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPFOTPRd7Z85FnKRS0cTn5GgupBXmDpYhiKtcCMp6o0=;
	b=J4RAkdwY9BJI342ztprMtM0GCDZb/4KAR0KYVuXhvmt53e3NZy1k+Hg+Nfy914XBfdRCOS
	Zyxnl8TAf1gJq3AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 09/10] memcg: trylock stock for objcg
Message-ID: <20250314114700.TiLB4FH0@linutronix.de>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-10-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314061511.1308152-10-shakeel.butt@linux.dev>

On 2025-03-13 23:15:10 [-0700], Shakeel Butt wrote:
> To make objcg stock functions work without disabling irq, we need to
> convert those function to use localtry_trylock_irqsave() instead of
> localtry_lock_irqsave(). This patch for now just does the conversion and
> later patch will eliminate the irq disabling code.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c803d2f5e322..ba5d004049d3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2764,7 +2764,11 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  	unsigned long flags;
>  	int *bytes;
>  
> -	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {

Don't you need to change the of memcg_stock.stock_lock? Didn't we
introduce an explicit different type for this trylock feature?

> +		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
> +		return;
> +	}
> +
>  	stock = this_cpu_ptr(&memcg_stock);
>  
>  	/*

Sebastian

