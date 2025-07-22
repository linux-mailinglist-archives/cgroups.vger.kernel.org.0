Return-Path: <cgroups+bounces-8853-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECEB0DFFD
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC67E6C7BE2
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41AF2ECD01;
	Tue, 22 Jul 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HjIPw5Og"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9A2EA747
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196674; cv=none; b=AzzAEV90HLokJj2yGZL6i+6R6pZDCU6VL/OaXz/oOV5wqNGaGMpd6gALFANs8M/L8zWcrgRBvNp/KbA9Lq8cp44pSXpjPxQsmDNwSzHfKbnA/6MQoHVJdUAiPK0gJJoL9OPb7qDiokX3FqX0IU0So8aLOCn0A49eFYm65UNYJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196674; c=relaxed/simple;
	bh=oF41xQzDXIRBUvqd/gtwa4GKtCbIysbSpVBFpP7X20Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaH3eUCykTFMOKuGYZitWrVTw3QXbtOgfBaATzz9qY4af8pKKCViHlXd7nvseH7gMhr+q8mhsMs5UagrfT55YhdPaHJ43Q+4rWgyu87vKFrBoLmXh7saXKSKJaQ9dyToLgm/5908LaMi7HsGZfY3AX4PDHsCtXwUuIb9RQcYYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HjIPw5Og; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 08:04:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753196659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DM1q4yZN/WH0WXbOJhikh3el0OxMls4EpUCRVMagXJc=;
	b=HjIPw5OgOxP8ER/BTfN1scXUiUd1HYbWSGb5AQu03Q0Lzpeszkmv4tOMjXHzEOpH2GlEgP
	HPAFEH09sdyhwKMz84qO7HnzYIPbD3ea989as18ZLVeTk+a/B3qUrzBv6OVVafnj7+AfoJ
	ZilLjzzLseaSATX3zXENsQ5M/mXxgRc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 00/13] net-memcg: Allow decoupling memcg from
 sk->sk_prot->memory_allocated.
Message-ID: <vokpyz3p5pbv7ja4ltipxapq4xjemqmv26gayezeekcyq7llyq@6kahz7tldhfz>
References: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 21, 2025 at 08:35:19PM +0000, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) has their own memory accounting for
> socket buffers and charge memory to global per-protocol counters such
> as /proc/net/ipv4/tcp_mem.
> 
> When running under a non-root cgroup, this memory is also charged to
> the memcg as sock in memory.stat.
> 
> Sockets using such protocols are still subject to the global limits,
> thus affected by a noisy neighbour outside cgroup.
> 
> This makes it difficult to accurately estimate and configure appropriate
> global limits.
> 
> If all workloads were guaranteed to be controlled under memcg, the issue
> can be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> However, this assumption does not always hold, and a single workload that
> opts out of memcg can consume memory up to the global limit, which is
> problematic.
> 
> This series introduces a new per-memcg know to allow decoupling memcg
> from the global memory accounting, which simplifies the memcg
> configuration while keeping the global limits within a reasonable range.

Sorry, the above para is confusing. What is per-memcg know? Or maybe it
is knob. Also please go a bit in more detail how decoupling helps the
global limits within a reasonable range?


