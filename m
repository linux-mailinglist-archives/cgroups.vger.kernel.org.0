Return-Path: <cgroups+bounces-4476-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2913495FBF8
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 23:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7131C227AD
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E119D06E;
	Mon, 26 Aug 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adzDtBMg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9519CD18;
	Mon, 26 Aug 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708762; cv=none; b=FD7CQ7EHbgoroH0AM2ge+6k8lbnWM2Id+gd7fDCwFG0ClQ1MglMZuTe9Z0+g8u2OPTme1dJCN4o1hRWcLdZEMcWz/WVxlZ+IjrPMvIofbWKJTYSKZNWmHsyc+pH2EsLCXIlRQJXrc6YoJmdTrhGE5PJdplh4hoQcmr+hbVx54JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708762; c=relaxed/simple;
	bh=FXf1IEV4Trf2d09bcynbe8IdIqU3v8wtB7Zkt7zV5tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJZe80fX3CMvssX0lZ8yIsChDrErBWYueqPHdDMLPBr9cy024xi6ESJKyCjaMgHKCYh2/kHoKSJx77X7S4su0mdpqNoZcGbVfwxtfG0GO9WRJjkL8yejcWE3siwhfcVQatlAhR22dqIuuQzmm/xgHotSApTc3wVPkQigBiVBqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adzDtBMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC43CC4FE98;
	Mon, 26 Aug 2024 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724708761;
	bh=FXf1IEV4Trf2d09bcynbe8IdIqU3v8wtB7Zkt7zV5tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=adzDtBMgnuGGQvTyfPJfpzVn51PwO7wjruX8sVfnEiOeJ9DQYEyc7GQCL+dgA/JPE
	 vQ44sH4aUC726ctobIVnTT8Ff1apoHRzpNjNkFBDgwBo2LiTGC8TPi3PRu6XAbU6M3
	 Z+6UT/p0T386AmU63oxneW1ohZ6RKbI2RO4GKX8a25eI4Miel3DG93Y7YcyTnhrWDs
	 TOVdJDGxV/GIJSAjuh0RpGL014J4MqbrrVKf0NNekEvV1FrxiWciAir641ynvgEnF1
	 BzKOJcJtsBX9BkABK++MfALiMISwm7DOGO0jFOPUKZZfRuTncdfHwunsVMrUSAPCdG
	 ASlRjnA8ILpWA==
Date: Mon, 26 Aug 2024 14:46:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Vlastimil
 Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, Hyeonggon Yoo
 <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: add charging of already allocated slab
 objects
Message-ID: <20240826144600.20cc15ad@kernel.org>
In-Reply-To: <20240824010139.1293051-1-shakeel.butt@linux.dev>
References: <20240824010139.1293051-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 18:01:39 -0700 Shakeel Butt wrote:
> +EXPORT_SYMBOL(kmem_cache_post_charge);

FWIW ipv4 can't be a module, but perhaps you're just following local
customs

