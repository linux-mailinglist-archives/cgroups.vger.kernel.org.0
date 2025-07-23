Return-Path: <cgroups+bounces-8889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9568B0E8BC
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 04:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B101C87E5E
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 02:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE261DF252;
	Wed, 23 Jul 2025 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOH3InyR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFC184;
	Wed, 23 Jul 2025 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238454; cv=none; b=Fn3LoJprMW/tJ4jaE28tAxN90iJkQPSlQe9KwGb99y+5NEH8fFwjhAEoN7BqL1ssHbznWD0J4dfH9/9d31ma0EQ9wSZGt5Ff67IXgHC6bivaCx4FJ6QNtkB2L7IS8lTvSlN27myWKZ+V5KuaAmSHE0V40e8Wu+J3IFzr43Fqsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238454; c=relaxed/simple;
	bh=TzfwHowQJxgSKxU2dTCixsuztKpRgfS9vBY26sV75U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ789My1FK92zH1mRnbXdx/OuhpDItN9LOSVXUUQ6zVCU8YoQccSzanoIeAbi1roYWeHbw0sYnNWxbykc8sABnPVVZpSZKyh4upYoA+IxQAu+o8QHkKvwge2/pI2S5TZxYVQfjgUGoZ1ii0F4RphR841h9AF7c8zw+o2on1jEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOH3InyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D6C4CEEB;
	Wed, 23 Jul 2025 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753238453;
	bh=TzfwHowQJxgSKxU2dTCixsuztKpRgfS9vBY26sV75U4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lOH3InyRY20dSGNxUyzp7uJAy0ip/KFHOVrW55Ub16MEvn+tKIM2uFHNDpzwbvNfg
	 U9zNUIjwCop5wYbnEWpfBxyODixL5SZgCdRUj6YuQgM5Vh32XJCQnGZ3bXiX45hWMH
	 Vg0mlYy9zH9oqQFA6YJzEmeDJy0Ki2hg5lXb3Lzl386Ju98at1PYLZu51ojFA50rqp
	 XbGB/+dg7++gfLgaHphsEMSTIXLqC+IP26oOT8ZbImknbhyqNvd/2SfBnZDzVqw8Zv
	 KBM0Vbi1P+gp0ZDzKPFlZxbgrv9YlikDIn0GekSHpnDT9bSbN/T8JaaRboPAwMYDzX
	 s7cXLIVOEFwAA==
Message-ID: <94ad996f-3947-493d-8ac0-5ca1c03dc9a8@kernel.org>
Date: Wed, 23 Jul 2025 11:38:25 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mq-deadline: switch to use high layer elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-2-yukuai1@huaweicloud.com>
 <625335c6-5ece-4407-bcb8-c2d8d3766208@kernel.org>
 <9bd88c1a-2124-c244-cdc3-5cf1bd4cce11@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <9bd88c1a-2124-c244-cdc3-5cf1bd4cce11@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/25 11:07 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/23 9:46, Damien Le Moal 写道:
>> On 7/22/25 4:24 PM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Introduce a new spinlock in elevator_queue, and switch dd->lock to
>>> use the new lock. There are no functional changes.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/elevator.c    |  1 +
>>>   block/elevator.h    |  4 ++--
>>>   block/mq-deadline.c | 57 ++++++++++++++++++++++-----------------------
>>>   3 files changed, 31 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/block/elevator.c b/block/elevator.c
>>> index ab22542e6cf0..91df270d9d91 100644
>>> --- a/block/elevator.c
>>> +++ b/block/elevator.c
>>> @@ -144,6 +144,7 @@ struct elevator_queue *elevator_alloc(struct
>>> request_queue *q,
>>>       eq->type = e;
>>>       kobject_init(&eq->kobj, &elv_ktype);
>>>       mutex_init(&eq->sysfs_lock);
>>> +    spin_lock_init(&eq->lock);
>>>       hash_init(eq->hash);
>>>         return eq;
>>> diff --git a/block/elevator.h b/block/elevator.h
>>> index a07ce773a38f..cbbac4f7825c 100644
>>> --- a/block/elevator.h
>>> +++ b/block/elevator.h
>>> @@ -110,12 +110,12 @@ struct request *elv_rqhash_find(struct request_queue
>>> *q, sector_t offset);
>>>   /*
>>>    * each queue has an elevator_queue associated with it
>>>    */
>>> -struct elevator_queue
>>> -{
>>> +struct elevator_queue {
>>>       struct elevator_type *type;
>>>       void *elevator_data;
>>>       struct kobject kobj;
>>>       struct mutex sysfs_lock;
>>> +    spinlock_t lock;
>>>       unsigned long flags;
>>>       DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
>>>   };
>>
>> I wonder if the above should not be its own patch, and the remaining below
>> staying in this patch as that match exactly the commit title.
> 
> I think you mean *should be it's own patch*. I don't have preference and

Yes, that is what I meant. Sorry about the typo.

> I can do that in the next version :)
> 
> Thanks,
> Kuai
> 
> 


-- 
Damien Le Moal
Western Digital Research

