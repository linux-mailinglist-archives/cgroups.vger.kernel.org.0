Return-Path: <cgroups+bounces-6312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BBA1C033
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 02:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684E07A1479
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717481E98EC;
	Sat, 25 Jan 2025 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sthD+b9q"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65C150980
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768363; cv=none; b=l1kZahdbKSLcwYAVndxfoKbKO6D2u1rzcquETqlvcgINu/XTQjgoQ00OIyznuyKZmagejLkYNMMFCQ/nDLOhCe0bQiCO4RYwEztUbuZfQnnp6Lg1oQa+vu3JHjW+pE7d1xlYSDBAIZTTcysw/SjviDPw64f5GW8HNTFtOcg25eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768363; c=relaxed/simple;
	bh=Qn4DDsIlup8AL+LbIWOmZBqOfG1yOYsV0UYpqQPx6Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhrQtU4iTxGENlZWKsaj5a9QH8HF5V++cJlwQWhYT16GHo2JvkNTVdn2ntX5XFy/CHoS7ix396Q1WbTqcATGYSJEWD6IHY9iD0SOwhYt0LGhndQP4K7v9pckpRixwBvyRywKtjS9xdiLHiPC/OZnS6/ssdQhc/Qkj2eet0Vr4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sthD+b9q; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 01:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737768344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwT2PfcNm2ZOJaOk7v8Yc0w2B0zR2NQznrVcYeb0C6g=;
	b=sthD+b9qbQ6ArrFYLQ9WBZDPk1WIZzbEZlS2Tg3mCmxwq/EzdaFCZSRr4ckQj6xT522qm6
	ROl+XT3XwgQ842YGgTu0IG7Px4nMHBN7XPNpWgfr9jRcaONWKKhacX7HlL8lv1w1Vezvw1
	RtJ2/bul6aGeiu0tXHNroqbqnBQkSh0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
Message-ID: <Z5Q9lObsut0vgluc@google.com>
References: <20250124054132.45643-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124054132.45643-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 12:41:32AM -0500, Johannes Weiner wrote:
> The interweaving of two entirely different swap accounting strategies
> has been one of the more confusing parts of the memcg code. Split out
> the v1 code to clarify the implementation and a handful of callsites,
> and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> 
>    text	  data	   bss	   dec	   hex	filename
>   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
>   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o

Nice!

> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h |  17 +++--
>  include/linux/swap.h       |   5 --
>  mm/huge_memory.c           |   2 +-
>  mm/memcontrol-v1.c         |  89 ++++++++++++++++++++++++-
>  mm/memcontrol-v1.h         |   6 +-
>  mm/memcontrol.c            | 129 ++++++-------------------------------

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks

