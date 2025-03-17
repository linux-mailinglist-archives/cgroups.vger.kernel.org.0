Return-Path: <cgroups+bounces-7107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17231A66109
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBB179804
	for <lists+cgroups@lfdr.de>; Mon, 17 Mar 2025 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD82040B3;
	Mon, 17 Mar 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hl9rHEnk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD821FDE2E
	for <cgroups@vger.kernel.org>; Mon, 17 Mar 2025 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248509; cv=none; b=Ra7+ge+LWJdc0EmV3wscCRMBJWlHIn6L62qIZw+FBM3I5AVcSnAeo82UlAODYuClpODTzGT2l1ThnakWNAroKjDqCLHv10kfpLOi/r09S8oofDzP++e+kbjzHWSc/KApEuLh3QuZv+8iy1bN0P+Ee8HdExqapXILZWknu/m5jZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248509; c=relaxed/simple;
	bh=SQLfCmDGnVZB0J5cWpxY0fyb5hw7MRUfqNmoPlr9Nho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJDGUIXmhvTNxD48Uyhq2W1WEZEKIdK9q7BqUdrlCXh5+GXDC3ebwVs7+dLoE6RBVEyFcGLXOqT1JAA+FgpnZ5ia3+kgK6ZsVRaK+W/YA/xQxS/EgKY7l/yYuYLIgGVeTmw65YVnWzfEoc86oD1H4cUViav3MQVLTRIOfF7pJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hl9rHEnk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 17 Mar 2025 14:54:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742248495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8zp66IVL2VPZNUMDSB5F2rdrquIj0RbhStyEr5Jlho=;
	b=Hl9rHEnk46eedn3Q3OYJUjuR6n+mHfz4G4ox+piDVlybnzegawJ8HkN6AxH381K/PtK+F8
	3etfdwWnmelGvnAUK3NcVzOkrqmrR1AtfAjy6ZSFLpGwY4Hz6De+AyxaRO2Wrtm6OIvvdH
	mJDsyw76RRjDeMDhuKFI+rBzTgVL/H4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 7/9] memcg: use __mod_memcg_state in drain_obj_stock
Message-ID: <6n7rsw565dy4kt7yxmik5kpxdz2b5h2bdsysfvi2rwmvl4juml@npkqfiyzfqua>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-8-shakeel.butt@linux.dev>
 <7d50a14a-edfb-410d-840e-17876806a63b@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d50a14a-edfb-410d-840e-17876806a63b@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 17, 2025 at 09:56:39PM +0100, Vlastimil Babka wrote:
> On 3/15/25 18:49, Shakeel Butt wrote:
> > For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
> > disabled, so we can use __mod_memcg_state() instead of
> > mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
> > in __mod_memcg_state().
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> I've asked in the RFC and from Sebastian's answer I think my question was
> misunderstod, so let me try again.
> 
> After this patch we'll have from mod_memcg_state():
> 
> mod_memcg_state()
>   local_irq_save(flags);
>   __mod_memcg_state()
>     memcg_stats_lock(); <- new and unnecessary?
> 
> Instead of modifying __mod_memcg_state() we could be more targetted and just
> do in drain_obj_stock():
> 
> memcg_stats_lock();
> __mod_memcg_state();
> memcg_stats_unlock();
> 
> Am I missing something?

This seems unnecessary because this patch is adding the first user of
__mod_memcg_state() but I think maintainability is better with
memcg_stats_[un]lock() inside __mod_memcg_state().

Let's take the example of __mod_memcg_lruvec_state(). It is being
called from places where non-RT kernel, the irqs are disabled through
spin_lock_irq*, so on RT kernel, the irq would not be disabled and
thus explicitly need preemption disabled. What if in future
__mod_memcg_state() is being used by a caller which assumes preemption
is disabled through irq disable. The RT kernel would be buggy there.

I am not sure if it is easy to force the future users to explicitly add
memcg_stats_[un]lock() across the call to __mod_memcg_state().


