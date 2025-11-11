Return-Path: <cgroups+bounces-11785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D8C4B4DF
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4D71883997
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B73491F2;
	Tue, 11 Nov 2025 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UPsgop1U"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F4335545
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831431; cv=none; b=SXKTgstpCe5wI3Q/dQJ7/ZdhLhLhETXrIOYDTKEvorGjO9TgC8zi5+Ah8UkxQuQR9eoU0tsd5BrjxwOzrQJ9q5ny7h81sXCr8m7cWlqyismX7c7T7jNWTPdAHlEJiux0IYsmH931z938d7WqsH/l0rTQTSon/wcCSLADXeTQ5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831431; c=relaxed/simple;
	bh=yC2MCngFM9KUY3X6276NkH+KVvQOjuSlw+e35s1JDmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tY3NE4ed/WP3K3lwftu0xWhrbOGwJfuuHg55518Tem68ETnpTQknBFFcsYARU2yQPCtS8oLGHW8eFON8Y1TTRtHJTUHcNXox2vYQJ/8GGgIks14kdBFDlCdO2LFHTjuHqOasrLUjuG+FLNUIaae6RxrundXgxdk2F6UjKel+q10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UPsgop1U; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ee2e132-6f80-4da5-a03d-820e4031a9fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762831426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRsaTINzsimOU7sZV8eoCiJrcZgmp+6Lp0gB2Wv5aQA=;
	b=UPsgop1UdM6iVCJKMcwkLQQY5vs0SziOL+3tJ/VISeF+lny1aY3cMPROrx3D8xU1Knz0m9
	plXApivp7nUGBs1nBOpcQsteaD4gZ2IUmuGCzVATmlxxRxRqknAme7SMVjU/wDvlKfS9zp
	TplEvHow7j+IYgpq+bQVD88BJ3XJbYM=
Date: Tue, 11 Nov 2025 11:23:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev
References: <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry> <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo> <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev> <aRKqm24Lrg-JnCoh@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aRKqm24Lrg-JnCoh@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/11/25 11:16 AM, Harry Yoo wrote:
> On Tue, Nov 11, 2025 at 11:04:09AM +0800, Qi Zheng wrote:
>>
>> On 11/11/25 12:47 AM, Shakeel Butt wrote:
>>> On Mon, Nov 10, 2025 at 02:43:21PM +0900, Harry Yoo wrote:
>>>> On Mon, Nov 10, 2025 at 12:30:06PM +0800, Qi Zheng wrote:
>>>>>> Maybe we could make it safe against re-entrant IRQ handlers by using
>>>>>> read-modify-write operations?
>>>>>
>>>>> Isn't it because of the RMW operation that we need to use IRQ to
>>>>> guarantee atomicity? Or have I misunderstood something?
>>>>
>>>> I meant using atomic operations instead of disabling IRQs, like, by
>>>> using this_cpu_add() or cmpxchg() instead.
>>>
>>> We already have mod_node_page_state() which is safe from IRQs and is
>>> optimized to not disable IRQs for archs with HAVE_CMPXCHG_LOCAL which
>>> includes x86 and arm64.
>>
>> However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
>> still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?
> 
> Hmm I was going to say it's necessary, but AFAICT we don't allocate
> or free memory in hardirq context on PREEMPT_RT (that's the policy)
> and so I'd say it's not necessary to disable IRQs.
> 
> Sounds like we still want to disable IRQs only on !PREEMPT_RT on
> such architectures?
> 
> Not sure how seriously do PREEMPT_RT folks care about architectures
> without HAVE_CMPXCHG_LOCAL. (riscv and loongarch have ARCH_SUPPORTS_RT
> but doesn't have HAVE_CMPXCHG_LOCAL).
> 
> If they do care, this can be done as a separate patch series because
> we already call local_irq_{save,restore}() in many places in mm/vmstat.c
> if the architecture doesn't not have HAVE_CMPXCHG_LOCAL.

Got it. I will ignore it for now.

> 
>>> Let me send the patch to cleanup the memcg code which uses
>>> __mod_node_page_state.
> 


