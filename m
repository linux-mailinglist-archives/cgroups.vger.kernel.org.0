Return-Path: <cgroups+bounces-7071-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C7A61028
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 12:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C2170475
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1481FDE0A;
	Fri, 14 Mar 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ih4I3N+v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XLCPgL4T"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942F3C6BA;
	Fri, 14 Mar 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952338; cv=none; b=MEUqF/qa4YwlYigEwXYe6R6CJXHF3X6E09qf0nLBm0OPZBx40W1hsS/HW9Riy75X7sT2c9P3I8UP2rPy8lwt5xxkek924nb/j7PVS01QiUIMVvah6F2cQ52K8mCiyRLIPUO5hizCKXOZGnbj7h9YQD3p6mZcminSuY82IVwoQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952338; c=relaxed/simple;
	bh=UlVs7tTvuR3bzxMovzx4t8nCJkplGvp1YKQe+o9GN3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8xy/95cNwC0SLW2Yuwo1saGVOcLWcg3WvQGxd8pG7dxJb0DD+Cou9wcks7Qhq8AQqiiLF1MoxboMMb25UIj/u3u/5Vu8sX+Cj75qxQQ6NWBgZFaszubzWVHl37iDUgZSBLd80gFkwR1fJ05FrgiEvHu9LWefUFRSM7BH/Zttkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ih4I3N+v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XLCPgL4T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 12:38:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741952334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUKSy7z6knz10WLm50dw1U0p3v0ZGMjBuqkfU3chOP4=;
	b=ih4I3N+voi1ZC4I+jS1VH+ZZwB8v8dgqMzo5PZvx9VCBvy01qODQzVZNjPlnosZWfVt9FY
	fHJnIlFCow7iwxKiUlYkUA5XSU4NZcYNv6cw0oSYcr4FR2ik2m6HyXVtgoKmVVrhhoY0CA
	vlO56eEmQK467eDaZU0E4En9ERVQvMYv+3MLvALjCBkHOGCBC1K3ZK6frgmCC6RCCehzIX
	gTTVJRcq8tT2RKHhJzq0N6ITFHXtedrpaGfmZEMJergiWzZmUROZZevZUshp6Jl5iGAznW
	2FHL9FrAnobz3JtWz5FpG77h5f205z9i9bW+kLW107jD4MHXI8hLriO6JXOVlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741952334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUKSy7z6knz10WLm50dw1U0p3v0ZGMjBuqkfU3chOP4=;
	b=XLCPgL4TroxdqQG2xY6MurgH9susfpQpR3PEVjibPzp/bApY+hKz364hQ8XCO6DnxPCZmW
	ARr0VyTFEALfLTBw==
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
Subject: Re: [RFC PATCH 07/10] memcg: use __mod_memcg_state in drain_obj_stock
Message-ID: <20250314113852.O1pm0QWd@linutronix.de>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-8-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314061511.1308152-8-shakeel.butt@linux.dev>

On 2025-03-13 23:15:08 [-0700], Shakeel Butt wrote:
> For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
> disabled, so we can use __mod_memcg_state() instead of
> mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
> in __mod_memcg_state().
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

