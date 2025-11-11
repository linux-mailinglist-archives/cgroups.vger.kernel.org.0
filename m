Return-Path: <cgroups+bounces-11818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4E0C4F1B5
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A033BC00D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4A73730D9;
	Tue, 11 Nov 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rfXPZSdW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9A36CE1E
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879481; cv=none; b=n7tet8bLPe9+WTd2km7Yl7z67OzdHzM+ZQNUbCIqC7fvFmAccUqPg96XkmXRNU8+MYlqsF+8hI7Sw6DzrHoXn1Alebi1YXVbBw4fPBblIYuAfAb2fS/m0L3HTQWVXxivzhtSueFFXebW0ExCz+p3vVMEKRAR9Qzc4Zn5TPP6R1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879481; c=relaxed/simple;
	bh=4cFlTn1ndDkONGK1hqa3YKpwy44LbNZPfGhXgFQq30w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWkE4RdSpQgM3huEhEx7SUva3bUHoKNuXlpYnNENsvGGSWc3E32+rPPnTa9TyqiFL4SFOfZ6THEnjmaO3QXXdFSRCQLyfAydBDaHEfCyEOAbCKFwu8nTwzrtHsdFLzb8cgMA33AITVGdQXW5JC+P98+X4ayOkfn3nuuCnuUrW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rfXPZSdW; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Nov 2025 08:44:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762879463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFGArA0AwyLodhjb1ON/WMsB8iA1cwp5MzvB1sHE/Ws=;
	b=rfXPZSdWWJKvfp/fyeozoSkkYJwyDMDkRUVrEra7CvbSs6AFwxYotJETtKrWvS3TJZRC2h
	Arwcb/Xt1oFuQUnzOeHaCFe/795zZ0GNk5RO/LZXgNAfpb+qLnIUjCIe0slSEGkSjAeNYH
	bROAJPYA4Fq3TcbIL99NO0L3yuoCXjU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>, 
	hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <jzihvbb6w26d4codfigy2o7b2h26izb4ahihouw54cvuzau54d@jyaa6rgpzuai>
References: <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
 <aRKqm24Lrg-JnCoh@hyeyoo>
 <20251111084900.babaOj0w@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111084900.babaOj0w@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 09:49:00AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 12:16:43 [+0900], Harry Yoo wrote:
> > > However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
> > > still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?
> > 
> > Hmm I was going to say it's necessary, but AFAICT we don't allocate
> > or free memory in hardirq context on PREEMPT_RT (that's the policy)
> > and so I'd say it's not necessary to disable IRQs.
> > 
> > Sounds like we still want to disable IRQs only on !PREEMPT_RT on
> > such architectures?
> > 
> > Not sure how seriously do PREEMPT_RT folks care about architectures
> > without HAVE_CMPXCHG_LOCAL. (riscv and loongarch have ARCH_SUPPORTS_RT
> > but doesn't have HAVE_CMPXCHG_LOCAL).
> 
> We take things seriously and you shouldn't make assumption based on
> implementation. Either the API can be used as such or not.
> In case of mod_node_page_state(), the non-IRQ off version
> (__mod_node_page_state()) has a preempt_disable_nested() to ensure
> atomic update on PREEMPT_RT without disabling interrupts.
> 

Harry is talking about mod_node_page_state() on
!CONFIG_HAVE_CMPXCHG_LOCAL which is disabling irqs.

void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
					long delta)
{
	unsigned long flags;

	local_irq_save(flags);
	__mod_node_page_state(pgdat, item, delta);
	local_irq_restore(flags);
}

Is PREEMPT_RT fine with this?

