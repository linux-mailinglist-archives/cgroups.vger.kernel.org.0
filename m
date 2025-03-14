Return-Path: <cgroups+bounces-7070-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B5A61002
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 12:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF023A73AF
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F061FDA63;
	Fri, 14 Mar 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pN4tX6ZF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXTBaDHq"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36F1F4275;
	Fri, 14 Mar 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952138; cv=none; b=A7SAFQbIQIJUROj+IHeL2eNK5i8ENgrTTiHppJYG6pExmRyLkIZlYy0dUKyplzJDnS21Xq2746o0ijFuJ6Dbw7mQc6jYdCwK3nxJlVTHPAtR2PeV6I6PSf4GidZdNdJPISCr2LNxiZfznG+K/sgWk6bZPAwavlEKfqJaA8EDgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952138; c=relaxed/simple;
	bh=R/tewh/p5atljgam4ymOvOpvh9GKdhUydr+c3OAOiBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZyC9eTr4AhlgLRzCRTzWyDbBPo9EOm0um2KGVHEgA9axvU5RVT0plhoVYhPXOFVoodH/y4cAt6tnMD0DV2i1PNzoibCyjp4pNRPhQ2r7GCAmNgXR3rBG4h2h1I0qrYnVHcv1JcCaeTOMKVMuuwWT+FUqqC8gDEwV4uzyc9uJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pN4tX6ZF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXTBaDHq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 12:35:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741952134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FQBo+G9NS5s5m9Or6v/ScN1p/wGWm+FuNiuvYY6ACA=;
	b=pN4tX6ZFyWEQFOPQiTwkjg7y9qa0bRlaapCNyuWUSwaWTYb6mnN5jX66hpoHhHvRHeqO/D
	e5YIXNbIzP/4PBhL8/oF85ZOhPimml3ONrtIqIl4/A93YRuXFNDfOF17lWNZTZ32yYcxEW
	dbjTNDGhROHWb+VDHwyCQ7p2RmHALCiaGrgSgseztU7tzRHNTXhe1TxgYuN8gJOm5HLvFb
	6LTOKKywuApbpXeJ3CeyTwG/2Qjzxor+bKZ59rhAE02gOyWufVjuGinYKcy4X71h2SNCHv
	C+TH+gn3bjJJfT1ckqYb0Ro18B9zYaIbcj9CByFpM9Y+/qkXu/SJXC5YHGBQ8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741952134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FQBo+G9NS5s5m9Or6v/ScN1p/wGWm+FuNiuvYY6ACA=;
	b=zXTBaDHqySfpFgV+G7VyJBWir7Y4Pm+Mk8JFgK1HGEVizypNRWcb7Pr8J8qMYe7F7G9K4D
	RfkBFbVr4bcrWtAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 06/10] memcg: do obj_cgroup_put inside drain_obj_stock
Message-ID: <20250314113533.jNrVXeyr@linutronix.de>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-7-shakeel.butt@linux.dev>
 <0b3ab5e5-e684-44ce-b6ed-276ad37784e6@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b3ab5e5-e684-44ce-b6ed-276ad37784e6@suse.cz>

On 2025-03-14 11:17:28 [+0100], Vlastimil Babka wrote:
> On 3/14/25 07:15, Shakeel Butt wrote:
> > Previously we could not call obj_cgroup_put() inside the local lock
> > because on the put on the last reference, the release function
> > obj_cgroup_release() may try to re-acquire the local lock. However that
> > chain has been broken. Now simply do obj_cgroup_put() inside
> > drain_obj_stock() instead of returning the old objcg.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Hm is this really safe? I can see obj_cgroup_release() doing
> percpu_ref_exit() -> kfree(), do we have guaranteed that allocation won't be
> also in a kmemcg and recurse?

This was like this until commit
	5675114623872 ("mm/memcg: protect memcg_stock with a local_lock_t")

at which point the put had to happen outside. This "percpu_ref_exit() ->
kfree()" was also prior this commit.

Sebastian

