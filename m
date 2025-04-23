Return-Path: <cgroups+bounces-7769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25ADA99B8D
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 00:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373737A6B0F
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD51F7075;
	Wed, 23 Apr 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrRV4qEm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0002701B1;
	Wed, 23 Apr 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447448; cv=none; b=iNJtRCA0p7AwF166lXZz7lc/uPcsupIhCrBLAwKZv7Nr5HV1kiApn5a4GbM5Kuf50aMJ2B0NXf5tFJzMLZLFWOde6UuTh/tjsESHVbUYnkYd5OtLbjlxaIRL9skcliSeFnuloj3lxyorVy43zKcfH4k+FpaD5+zW5dZRqNbHkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447448; c=relaxed/simple;
	bh=v7uvC031KbxPygQ0Q81LLAIVu0y2fzp6RXRgtN9+ces=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okCIwT6KX12t6ngRH3nNNOYKA9WhPnsSB+76lCO3k0S8Jo69TsrpguLuImK0VQo/pHyEx6bP8HRpysD/QdrZZa5m8DR3JfyaR0kjZJqbfzbMvZDc46Z6u5ToTHPrDs/2gAKIyv6OetBU5nm3vBEq2zL8JCZkLffxTtj/Ros4L50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrRV4qEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E1FC4CEE2;
	Wed, 23 Apr 2025 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745447447;
	bh=v7uvC031KbxPygQ0Q81LLAIVu0y2fzp6RXRgtN9+ces=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HrRV4qEm6Cum6fI3+/bCX5YNQAKLuTD927Q2pC/abmq7LAWalH9WkoEGZvSIU/kh3
	 S7dfEp4onAh4HJ6uLpqCPOOPpEH+7/W8e1MLo50qTkHIzGz/D0fUvrf6Y8jP4WKbjl
	 bHw3fi2RMZhStqMTCmsvuPZ2Hmx9wVT1a7goTJk2e6HyLXSIpyi3shdN7mmM4QJg8z
	 CjCuXWcr8WZOERehn2xkctPrjdLpoKCivbf0+u34uldkimkfjPgaISQ0J/Qki/LSA0
	 1kMQAGNrv26tHwdDS9IpulTnccD01AHMATiBSM5acU6uhDPAudunhyYoI6ivvlmqOd
	 lM48p9wYIM5Jg==
Date: Wed, 23 Apr 2025 15:30:46 -0700
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
Message-ID: <20250423153046.54d135f2@kernel.org>
In-Reply-To: <ha4sqstdknwvvubs2g33r3itrabepz2jwlr3ksrbjdlgjnbuel@appekpf6ffud>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
	<20250422181022.308116c1@kernel.org>
	<ha4sqstdknwvvubs2g33r3itrabepz2jwlr3ksrbjdlgjnbuel@appekpf6ffud>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 15:16:56 -0700 Shakeel Butt wrote:
> > > -	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > > +	if (nr_pages > MEMCG_CHARGE_BATCH ||
> > > +	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > >  		/*
> > > -		 * In case of unlikely failure to lock percpu stock_lock
> > > -		 * uncharge memcg directly.
> > > +		 * In case of larger than batch refill or unlikely failure to
> > > +		 * lock the percpu stock_lock, uncharge memcg directly.
> > >  		 */  
> > 
> > We're bypassing the cache for > CHARGE_BATCH because the u8 math 
> > may overflow? Could be useful to refocus the comment on the 'why'
> 
> We actually never put more than MEMCG_CHARGE_BATCH in the cache and thus
> we can use u8 as type here. Though we may increase the batch size in
> future, so I should put a BUILD_BUG_ON somewhere here.

No idea if this matters enough to deserve its own commit but basically
I was wondering if that behavior change is a separate optimization.

Previously we'd check if the cache was for the releasing cgroup and sum
was over BATCH - drain its stock completely. Now we bypass looking at
the cache if nr_pages > BATCH so the cgroup may retain some stock.

