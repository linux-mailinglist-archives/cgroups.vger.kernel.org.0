Return-Path: <cgroups+bounces-11783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6D5C4B4B2
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0BDB4F29A4
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4440B30CDBC;
	Tue, 11 Nov 2025 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S1LuwfNA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6622069A
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831067; cv=none; b=cxTuKHAG2UQOKEpBvIp5EmmraqS9+VNpw+YNltTW5KkPoO5YeZZABzTYwDFX42weHAZf70H93bfUdvlXQ/b0gDnt995iD2EAYhp698Byra9G5bu62A5rXbvnnTx99AhtxTmxbGMWrZ/QhVlPYab2n2jarnrbD/OeP+OE9U7vGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831067; c=relaxed/simple;
	bh=GGQ3NElKn4BhT3PxiDn9ZtP6OJPTLhpw4UgKBv88GIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3B3kroxTEB/w8zxpGcFDmXqc/eJ7ZXr0UhoZOiJRT1oqOMgaXcbTcrGN9/z224J6pIy3GejB0SXtqwQMPwAXDWuckKZl9Hr4B05QmzZfRDp0focxqFxfy4XKUc1KzyW9vZVALMdrDwisVkXSX71Ibe+TKVb9i1tu55RjbyzJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S1LuwfNA; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 19:17:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762831052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jE8ud/JwB5HfBpvMy2LpJpkpeLCuOyzlsaO0bOQsL30=;
	b=S1LuwfNAvzPYQrz3vhJx2o2Zsh3g2qbYAclxZd6Ov0jAos7X6TkU3Zyy8C0XRCj+CqkJmA
	zmmEPOyf8rKIUZXgI8jl2S0G+4AxsbJv+Am+W32BJC3UUaJwxBxbFJ3q+EfsAFn2T5Ad+V
	NaHIpRjMUGnxVsHDJIOMnsq8KwRoeYQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <646pwrc7sxan6wlwndjyu7upx32fkd7bv5vqlut3tjt65eeyby@23efyxvpg2nx>
References: <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 11:04:09AM +0800, Qi Zheng wrote:
> 
> On 11/11/25 12:47 AM, Shakeel Butt wrote:
> > On Mon, Nov 10, 2025 at 02:43:21PM +0900, Harry Yoo wrote:
> > > On Mon, Nov 10, 2025 at 12:30:06PM +0800, Qi Zheng wrote:
> > > > > Maybe we could make it safe against re-entrant IRQ handlers by using
> > > > > read-modify-write operations?
> > > > 
> > > > Isn't it because of the RMW operation that we need to use IRQ to
> > > > guarantee atomicity? Or have I misunderstood something?
> > > 
> > > I meant using atomic operations instead of disabling IRQs, like, by
> > > using this_cpu_add() or cmpxchg() instead.
> > 
> > We already have mod_node_page_state() which is safe from IRQs and is
> > optimized to not disable IRQs for archs with HAVE_CMPXCHG_LOCAL which
> > includes x86 and arm64.
> 
> However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
> still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?
> 

Yes we can disable irqs on PREEMPT_RT but it is usually frown upon and
it is usually requested to do so only for short window. However if
someone running PREEMPT_RT on an arch without HAVE_CMPXCHG_LOCAL and has
issues with mod_node_page_state() then they can solve it then. I don't
think we need to fix that now.


