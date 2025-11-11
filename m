Return-Path: <cgroups+bounces-11786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B504FC4B4E5
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7261884602
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35F34321F;
	Tue, 11 Nov 2025 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ogFJes54"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF36314A8F
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831504; cv=none; b=Z/b8cnvAeapjDwAHzNXREYm4haIg0v1JNbAPIkPPDotlVLbAM21luISWzPJch50bHTM9nL7D/SVKrTs1Ew3oyQBGtq2pDcLCLUTAl7S6/XN/uVczwfy84CT847tq6Nd/mrW8FA+0Pno2j+4jrFoBAbmAd0hsLfWdvuxhPS8tPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831504; c=relaxed/simple;
	bh=OoSV22me2WuJEL6YRDR+17uiJzwO2z0GRrrBr44fTTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEiIq7pBNwGrTT9lXuawk2F6IaChwSVQeV/Ylx88RGUAMfgf50+sY4Glp3lDIPz2ejwksgDndQnFc2/bosYFHBicQnrOKJx074AaNGJQQBpNi1XElBsdOmTVVkIth1bHKGcKn9VX+J6svm5gy1i84HROvHzhExcJCr6lE1gCxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ogFJes54; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a6dfda1-380d-4e6b-af72-4e6257838c08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762831500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HakIRat1LMkIofrDpBtAbKRxMTQrzWYviIUr8PQmSMQ=;
	b=ogFJes54pFGN05g+xE+mxRKl0VVn+YgldSLppe95wFlyb9aBoDjP+jF+JbbB1/Q27r7zkF
	YEawhKNCho3YnnN0yEOB5fjIk9iM8KO0D5HOr5PC8rt+yhSwKVoiQ7IggLJr1XK99JhtrJ
	dprOCkMUeB3Gj3cHItXB2SOg41/a2z8=
Date: Tue, 11 Nov 2025 11:24:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
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
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
 <646pwrc7sxan6wlwndjyu7upx32fkd7bv5vqlut3tjt65eeyby@23efyxvpg2nx>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <646pwrc7sxan6wlwndjyu7upx32fkd7bv5vqlut3tjt65eeyby@23efyxvpg2nx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/11/25 11:17 AM, Shakeel Butt wrote:
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
>>
> 
> Yes we can disable irqs on PREEMPT_RT but it is usually frown upon and
> it is usually requested to do so only for short window. However if

Got it.

> someone running PREEMPT_RT on an arch without HAVE_CMPXCHG_LOCAL and has
> issues with mod_node_page_state() then they can solve it then. I don't
> think we need to fix that now.

OK.

> 


