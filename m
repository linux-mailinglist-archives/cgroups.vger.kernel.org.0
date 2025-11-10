Return-Path: <cgroups+bounces-11706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6344C44E6E
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 05:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49FAD4E04B6
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 04:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50020468E;
	Mon, 10 Nov 2025 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QrKMgcjb"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F641C63
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762749032; cv=none; b=k0KE872OXo7qVWKDPAZaJPe0hc/kvqw88F1g5aQdAW5nKhkyfUB+oJQM0NIHWXPxu5yG8V90I3yaDSkHZ9KR9OIxNIkB2KXOOx43crT5qBhHoJxhZKJgsKvoEAGzlpI0JyA9engjC1Q+PcWtCZ+7gZZN2dGrIbEEgXkZ77AZ/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762749032; c=relaxed/simple;
	bh=j3o1PVMLua/Gnsl0SBuyqCBAYrO7OxpEAe/BvmQDT1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMw/3ig+x9U7cAW5u9kJf4C45EVtwB7WWEGS6V4d7SgAWATTcY+MpWZSXhw5G5veBPZGPf6h25EnCiA1b1Jmsy2A5/XogwoZIjzFcULsrJbe+L6SWZkzh/6iMKJ1ps/o8D8CtHXADXrfMVYuryswHzveTUEsafHqDIQgzlV7uS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QrKMgcjb; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762749017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VM4mtZug8xE4ghkhPgkEdlWdDR6+a0E4+YRze3eMGSI=;
	b=QrKMgcjb+M+1F+KOE1U1Kz2oPhiC+29MYWaxjYCseEb9dCjF/qm7ht2OVhV3hu6Ni8yXAS
	0k2iLbwHoKMIxa4K4ZUwxl+IOfLx4O354NnSpcjicDEqtBtrjS0hjI2H/wZRxnioVCq0s9
	yXbOo+3DumqD4576zhhXeGXKJJNoBrE=
Date: Mon, 10 Nov 2025 12:30:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
To: Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry> <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aRFKY5VGEujVOqBc@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/10/25 10:13 AM, Harry Yoo wrote:
> On Fri, Nov 07, 2025 at 10:32:52PM -0800, Shakeel Butt wrote:
>> On Fri, Nov 07, 2025 at 10:20:57PM +0900, Harry Yoo wrote:
>>>
>>> Although it's mentioned in the locking documentation, I'm afraid that
>>> local_lock is not the right interface to use here. Preemption will be
>>> disabled anyway (on both PREEMPT_RT and !PREEMPT_RT) when the stats are
>>> updated (in __mod_node_page_state()).
>>>
>>> Here we just want to disable IRQ only on !PREEMPT_RT (to update
>>> the stats safely).
>>
>> I don't think there is a need to disable IRQs. There are three stats
>> update functions called in that hunk.
>>
>> 1) __mod_lruvec_state
>> 2) __count_vm_events
>> 3) count_memcg_events
>>
>> count_memcg_events() can be called with IRQs. __count_vm_events can be
>> replaced with count_vm_events.
> 
> Right.
> 
>> For __mod_lruvec_state, the
>> __mod_node_page_state() inside needs preemption disabled.
> 
> The function __mod_node_page_state() disables preemption.
> And there's a comment in __mod_zone_page_state():
> 
>> /*
>>   * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
>>   * atomicity is provided by IRQs being disabled -- either explicitly
>>   * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
>>   * CPU migrations and preemption potentially corrupts a counter so
>>   * disable preemption.
>>   */
>> preempt_disable_nested();
> 
> We're relying on IRQs being disabled on !PREEMPT_RT.

So it's possible for us to update vmstat within an interrupt context,
right?

There is also a comment above __mod_zone_page_state():

/*
  * For use when we know that interrupts are disabled,
  * or when we know that preemption is disabled and that
  * particular counter cannot be updated from interrupt context.
  */

BTW, the comment inside __mod_node_page_state() should be:

/* See __mod_zone_page_state */

instead of

/* See __mod_node_page_state */

Will fix it.

> 
> Maybe we could make it safe against re-entrant IRQ handlers by using
> read-modify-write operations?

Isn't it because of the RMW operation that we need to use IRQ to
guarantee atomicity? Or have I misunderstood something?

> 


