Return-Path: <cgroups+bounces-10610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B437ABC643E
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 20:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B624C19E0AC7
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8122BE7A3;
	Wed,  8 Oct 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUt9NBVm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD2D2BDC32;
	Wed,  8 Oct 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947477; cv=none; b=JaVB2tzkzYnlJt2b+3FNPmNK5UaPKhEuBJ2/eb7F8TKsSDOk7Z1RMpp+ScpQWn0YYCCNr8lMogTBhIwMWFglaNg5V4czHEmNV1FOXs+UdOtcUWSyo+3q/vrA+sTXJbKWjRSMwXlwTdEz0P74Sm8nl+yhnIXv+F6Mr/Yvmz9c8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947477; c=relaxed/simple;
	bh=4aQzZE4dPKYLC7wE9e+3mYUgK3sZmtIL+KSSPfosfqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUHMQXV9xvk6mUqbADeS7rK+R0U40X8mcBP4NNIsZXJqpJM9Xp7TCHDvflWY1grGYqSVLNZ49QlOzvg0r9ni2uKHlT0oYKR7LEsmAzUdCbnLGbPOJ8WL0CVats7crbnZEdbG2cxIL8Y/61n+p87UQGhxOb9AD/iLiIw7Xb6f/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUt9NBVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F88AC4CEE7;
	Wed,  8 Oct 2025 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759947476;
	bh=4aQzZE4dPKYLC7wE9e+3mYUgK3sZmtIL+KSSPfosfqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUt9NBVmokoT4ZHWQS2ZfEzYW9YwNbuP1F8iFd9oXTaOge9DACR/POTm/b7hf7nTE
	 D8NeRBhkov7umkM+ojr4jlvj5K5NMZ2jC1tTJUGLS6APxkkFjdJrvD7R6eSz26xPUy
	 OSwziBUZXFcoLJIyC7ffGhxPeJm0XRHHnUjtVHB2pV6MDugaF3Z02jU9/fquKH+XES
	 kVm4CQhouvOLTs6je5l1/iKeXfqH8aPwKl0DVwfP31DtHo0R9u6V1KARZi1qBLlIF1
	 rFkJuO/nZENaLaTWVGNKuJoCf9QYxinbpR1Hu84vXb8otD+PMj4mbhMRdPZE1mFAUJ
	 vyv2kaNgm3NEg==
Date: Wed, 8 Oct 2025 08:17:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Matyas Hurtik <matyas.hurtik@cdn77.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
Message-ID: <aOaq07jS60mHYGBe@slm.duckdns.org>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <aOVxrwQ8MHbaRk6J@slm.duckdns.org>
 <6cbf24f6-bd05-45d0-9bc8-5369f3708d02@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cbf24f6-bd05-45d0-9bc8-5369f3708d02@cdn77.com>

On Wed, Oct 08, 2025 at 02:46:23PM +0200, Matyas Hurtik wrote:
> Hello,
> > I'm not against going 1) but let's not do a separate file for this. Can't
> > you do memory.stat.local?
> 
> I can't find memory.stat.local, so should we create it and add the counter
> as an entry there?

Yes.

> Regarding the code, is there anything you would like us to improve? I had to
> rewrite it a bit
> 
> because of the recent changes.

I think memcg guys will have much better idea on the actual code. Let's wait
for them to chime in.

Thanks.

-- 
tejun

