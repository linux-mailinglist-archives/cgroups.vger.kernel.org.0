Return-Path: <cgroups+bounces-11779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F8C4B469
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514E0188E460
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C53C31355C;
	Tue, 11 Nov 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m1VOnbj0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FF303CB4
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830280; cv=none; b=QAirZ5z3GRSLaug7QQM8b7ApEm1ScjSTUG0lzV64l9jYaqV7PyZ2VoC73Fy2zLXZ70HjVv/x2ULVgStfjq5p46sWtQ2G5x9JN2E6znxe3Q+LWDhUooBwySBZ9ovsHvIWoExrVxuSBEdjn86svNEnCggLXyOrvd9h+Cf1ODa6Rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830280; c=relaxed/simple;
	bh=54lsAScodbRTpR1bH6qMs5x+FVqbnXjPhe6PWB9xz3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcFuELv59G+Pc1UK4ZwlclP+En8oi6o2P/dY3bal6pYq8V0TcGgk/w/anfMJUonaYck4yEzd2HwswDd1VN8m0lyF8/qGPdKN2Y1WsmNLCiqR+UmkYbE5Mv8fMYovhPB8LGi4o5EJPoJOFln0UnWI1LVBHv0wafSe0KK4A0fv5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m1VOnbj0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762830265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5c8zazQymbCh3EJOF0KTydVfHgB+HL63txNkj2DBcg=;
	b=m1VOnbj0B52FF5eqkgvxn2ibcAZ2AlUdQ2OpPrHQmPQeylgDhQJZc44smuZ/tFwxYYmsLz
	MO94ShQBlC2V/Nu2D3aYvij6xrHH3NeUozTm0MkGI8F9M9YBE2vzLtaW4CW2d3AV3LqiNx
	ieAfXns9GSZy2EFyQl44C+OKbFBoyNc=
Date: Tue, 11 Nov 2025 11:04:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
To: Shakeel Butt <shakeel.butt@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
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
 <aRFKY5VGEujVOqBc@hyeyoo> <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/11/25 12:47 AM, Shakeel Butt wrote:
> On Mon, Nov 10, 2025 at 02:43:21PM +0900, Harry Yoo wrote:
>> On Mon, Nov 10, 2025 at 12:30:06PM +0800, Qi Zheng wrote:
>>>> Maybe we could make it safe against re-entrant IRQ handlers by using
>>>> read-modify-write operations?
>>>
>>> Isn't it because of the RMW operation that we need to use IRQ to
>>> guarantee atomicity? Or have I misunderstood something?
>>
>> I meant using atomic operations instead of disabling IRQs, like, by
>> using this_cpu_add() or cmpxchg() instead.
> 
> We already have mod_node_page_state() which is safe from IRQs and is
> optimized to not disable IRQs for archs with HAVE_CMPXCHG_LOCAL which
> includes x86 and arm64.

However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?

> 
> Let me send the patch to cleanup the memcg code which uses
> __mod_node_page_state.


