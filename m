Return-Path: <cgroups+bounces-7084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19644A6194B
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 19:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6C17AC0C9
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248F20468F;
	Fri, 14 Mar 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hSb1GWIB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bdlMZGy4"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CE202F96;
	Fri, 14 Mar 2025 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976393; cv=none; b=cHlUlH9VaXHZfQvz/XLNPgA28XNbN2sbDG2OgwH2rQuAwVc6e+m00tlHYhe63kz7AO2I0VzU2g8bWCZDMFJoUY/fZtNRKycyIFmdyxjJxbuBasJ7/BW7LiGw7epS1AXXED9USzsaHURzxMiCBvwyra72Yf2fsGhMfErX9W6n1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976393; c=relaxed/simple;
	bh=p3lEx5AeDIot0RR3wPr6612f9S8LWcZEp9QT/e8nkC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ESOi4L+8aezIz/xgdXr72+3lSfC406abaRFR1ZKq+ddM2nwmDj5uWzRc4IEDWJPihfAMkohgOAPgTQy3R1McWyxwm3cwo7zyUjeXR4PbNzt4tFsncqEPr9/IGj/T10mQNg+47N+TJ2jWDNzR+r7x3KwJxmg4fSWW44o5u3BX0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hSb1GWIB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bdlMZGy4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 19:19:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741976390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=kPyPW+naAFlbw+Xbn145mrlsK5koPOENM07QgOBvPOk=;
	b=hSb1GWIBOVE0BOuFpl5XdClM2mEBLIp1uIUdWCR8I+zfcY5Sdn9gitO56UzTe0m7dCXAyQ
	0tAvFZzWXoq1UPqgPY1l420712+f+MnRZOMIqh/KiKTCp1+akGlSla5c6OF12yZhfH+5N+
	rHmCe7NMrSaHdhqGHYg4hp0HOwz4nXePSBr5y4kSC3gR/BEjFvEajxuL1i8DD93HniWFOx
	aHTYijk4rLMz4Vf+JsBVZ4vhlVGPPfJgDw5QrpeqKCldjnWhrgDNJ05vFLViKJbH4gkwZS
	H7bzkgmBSNzUZfT16I04g8e8FHCyXNZ9vmR2094+lX2EzUUdWuf/YkAVtA3pmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741976390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=kPyPW+naAFlbw+Xbn145mrlsK5koPOENM07QgOBvPOk=;
	b=bdlMZGy4ApqFqNgI6RekFFiyr7GJTpLsP7DgYwDv0wToSDbymjVhJXgUI9s78Z9V4DP/f9
	f/E6keN2I68610BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 10/10] memcg: no more irq disabling for stock locks
Message-ID: <20250314181948.A5DQsYZB@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <t6gqzrhipj3zxmev7pdmxbbbkx76eyscvkn4m66ifwcq3kfqtx@7jmqtzu5bs54>

On 2025-03-14 10:02:47 [-0700], Shakeel Butt wrote:
> > 
> > on arm64, __this_cpu_add will "load, add, store". preemptible.
> > this_cpu_add() will "disable preemption, atomic-load, add, atomic-store or
> > start over with atomic-load. if succeeded enable preemption and move an"
> 
> So, this_cpu_add() on arm64 is not protected against interrupts but is
> protected against preemption. We have a following comment in
> include/linux/percpu-defs.h. Is this not true anymore?

It performs an atomic update. So it loads exclusive from memory and then
stores conditionally if the exclusive monitor did not observe another
load on this address. Disabling preemption is only done to ensure that
the operation happens on the local-CPU and task gets not moved another
CPU during the operation. The concurrent update to the same memory
address from an interrupt will be caught by the exclusive monitor.

The reason to remain on the same CPU is probably to ensure that
__this_cpu_add() in an IRQ-off region does not clash with an atomic
update performed elsewhere.

While looking at it, there is also the LSE extension which results in a
single add _if_ atomic.

Sebastian

