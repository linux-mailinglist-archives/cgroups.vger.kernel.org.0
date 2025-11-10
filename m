Return-Path: <cgroups+bounces-11756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C37C4824C
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 17:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DBC1886082
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F732EC0A7;
	Mon, 10 Nov 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Op1P68AK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EE28FFE7
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793289; cv=none; b=qJ0nqIrGcu7pRSxq2yzhHgzCxTQoumUYiFA25dU0CNIXkkfhJ/SAYOhetbHjmbm9dgvofJuL08puk9AfPgrzWLrdDBU4iztqo9Z0f5XdJfmcYbkHZgRxyWZFkZ3CVpD/vAtdVQF6+s7aSYymcIofl7zS0a55B6UWy1SAK9KsxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793289; c=relaxed/simple;
	bh=nbTXEmv9LY/cKsYu4ZiCODgVkOSqUwPWnFRQmS2Y+K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acbe1gCgF0eLBdVO1O5e4ouYQ1CHJRBuKCr+5V4GZJLKEZ/zKMDwuZJsgdTNeGTmm8rEp5VVNl68WRILaK0loIWNLz2Be1p7dR5U0wuoBRh3ucsq5YCBHzBop+kfqimdEQB0Yb2XyBvFvyRA+UecLlKIDbDfAIHsOZkaaVJlPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Op1P68AK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 08:47:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762793285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd3QhG39y54BYRm7BE+GdV6fPsrzgc5k/otRLVZG40Q=;
	b=Op1P68AKP718zvoxiL1HqKGS4nBheJkeq7JhxPVCOxpu8rVb2yLWW0mPcsf8NnNVNKG7gx
	61esQYqXGExt2UH/pe2AHZyPCmZmyZu2DROK3PSsjbECpfaOfWaNKDCsLjMQS2xsYBb3O2
	pPuA297SZhouAMdmqFt+sgt8zY8Z7Fo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRF7eYlBKmG3hEFF@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 10, 2025 at 02:43:21PM +0900, Harry Yoo wrote:
> On Mon, Nov 10, 2025 at 12:30:06PM +0800, Qi Zheng wrote:
> > > Maybe we could make it safe against re-entrant IRQ handlers by using
> > > read-modify-write operations?
> > 
> > Isn't it because of the RMW operation that we need to use IRQ to
> > guarantee atomicity? Or have I misunderstood something?
> 
> I meant using atomic operations instead of disabling IRQs, like, by
> using this_cpu_add() or cmpxchg() instead.

We already have mod_node_page_state() which is safe from IRQs and is
optimized to not disable IRQs for archs with HAVE_CMPXCHG_LOCAL which
includes x86 and arm64.

Let me send the patch to cleanup the memcg code which uses
__mod_node_page_state.

