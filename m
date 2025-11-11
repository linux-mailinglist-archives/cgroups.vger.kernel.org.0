Return-Path: <cgroups+bounces-11787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98869C4B524
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7225E188F8AE
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314AE3346B9;
	Tue, 11 Nov 2025 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U51cVDT+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BC2E54A3;
	Tue, 11 Nov 2025 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831759; cv=none; b=JIiFifBYUWYwutBslXT/p3iAIeIa1V26bGnmXBmYaKwws1c8MdSVLV//XX6b012hzGxdxPihR3epLhv1GhsmxHSsdb1Ry4xUc4MBq6xyxqYGR3tC1AA4xc6Bx/F+GCm4FD2kihjpivzkQX7xhgrJSUcGEg0GNPzKfDqpjf/iDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831759; c=relaxed/simple;
	bh=DPR/6cYQRqsxotHssDhTpx/SX9RVzW35tP8lTAQyWZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0InPgwyDockSqBQFl11Capm1ohQzjD+bkUiuMij5EZd8R7/Y5exoRi3phpWS1MzukBBXvxWeeGNjDrh2b5q473a4i41JISsxC/w1L3GCX5xSN6+EkmJ4MmUmRjHKQF+x7cso+kgpjKq+HcwVW72eub0lxvx61HKFrq0NpqMWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U51cVDT+; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2750e21-2853-414c-9552-4f7faac12afd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762831755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4Gwun/4Q7PEKmKnOLx/o5MXaYbKvzj+YtrVyTMLJUI=;
	b=U51cVDT+HoQJkqGpZyUh24NPRj8r8kB9s7IFPlUaPzcFECva7S0Za+l8wdZrgWmjPfgS9X
	sSk5DXMwygzYLR9y19gvsioIxANWmk+n4/q0Cg1JMGOY4JFs9V/Rqu1YROgCP4lqMFD6I8
	3RF7Cs0QV6cRRGItbLSkpv3V9yP3X8k=
Date: Tue, 11 Nov 2025 11:29:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo> <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
 <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
 <hgf4uciz7rp2mpxalcuingafs5ktmsgvom2pefjv3yogel5dh3@7kkwtrnqotnc>
 <982d6b8c-53e7-46f3-9357-afb85319d0a3@linux.dev> <aRKq-JOzoCW9kKMz@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aRKq-JOzoCW9kKMz@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/11/25 11:18 AM, Harry Yoo wrote:
> On Tue, Nov 11, 2025 at 11:07:09AM +0800, Qi Zheng wrote:
>>
>>
>> On 11/11/25 11:00 AM, Shakeel Butt wrote:
>>> On Tue, Nov 11, 2025 at 10:48:18AM +0800, Qi Zheng wrote:
>>>> Hi Shakeel,
>>>>
>>>> On 11/11/25 10:39 AM, Shakeel Butt wrote:
>>>>> On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
>>>>>> Hi,
>>>>>>
>>>>> [...]
>>>>>>>
>>>>>>> Are you or Qi planning a follow-up that converts spin_lock_irq() to
>>>>>>> spin_lock() in places where they disabled IRQs was just to update vmstat?
>>>>>>
>>>>>> Perhaps this change could be implemented together in [PATCH 1/4]?
>>>>>>
>>>>>> Of course, it's also reasonable to make it a separate patch. If we
>>>>>> choose this method, I’m fine with either me or Shakeel doing it.
>>>>>>
>>>>>
>>>>> Let's do it separately as I wanted to keep the memcg related changes
>>>>> self-contained.
>>>>
>>>> OK.
>>>>
>>>>>
>>>>> Qi, can you please take a stab at that?
>>>>
>>>> Sure, I will do it.
>>>>
>>>>>
>>>>>>>
>>>>>>> Qi's zombie memcg series will depends on that work I guess..
>>>>>>
>>>>>> Yes, and there are other places that also need to be converted, such as
>>>>>> __folio_migrate_mapping().
>>>>>
>>>>> I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
>>>>> using the same reasoning we can convert it to use mod_zone_page_state().
>>>>> Where else do you need to do these conversions (other than
>>>>> __folio_migrate_mapping)?
>>>>
>>>> I mean converting these places to use spin_lock() instead of
>>>> spin_lock_irq().
>>>
>>> For only stats, right?
>>
>> Right, for thoes places where they disabled IRQs was just to update
>> vmstat.
> 
> ...Or if they disabled IRQs for other reasons as well, we can still move
> vmstat update code outside the IRQ disabled region.

Ok, I will take a closer look.

> 


