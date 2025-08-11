Return-Path: <cgroups+bounces-9066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C9B1FE5F
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 06:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FD11893D66
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 04:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CE11F1501;
	Mon, 11 Aug 2025 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkROSjM2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D342E36EC;
	Mon, 11 Aug 2025 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754886890; cv=none; b=NAbBYV2b2vBcWJUcz86e6iJiWcBYt7rjYGs/rWGyLOqWD5QUHKyBAzaSPj+U741oRDOGgmUPUqXKygUb6K/QPca+Y5ilWjnQ4+c2XhXFwnRhbrbD1PsYr4RI1j57EwUoEkdmAS3ICmLMMwu/QFul/j1CygG1LDcIHf+so5KkXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754886890; c=relaxed/simple;
	bh=eylq5gbtLfW2JqhoIRtLsoH1Hfz3O0pavW/QDfuf2TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CW0G0GafCCXsHvqjisVFOXH9NPVTEy0iEGRnX1TepJz0j3mVf8FpwHLmF1t2llTHx+hrnb1XAZHd1NrV/3IVY0TzbmM2/aR0JA4/uV/RqbzYSzgHVa9kHmp6Cxo5mw/jP60oDv/z/hteKnLq+L/RK8Y2iEA930Ffpg7h4K+bC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkROSjM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E6C4CEED;
	Mon, 11 Aug 2025 04:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754886890;
	bh=eylq5gbtLfW2JqhoIRtLsoH1Hfz3O0pavW/QDfuf2TE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GkROSjM2spkEqEwhn+rojjG/9ScKmFGn6PpT8SJbGvS+tcZPGJU6KV2UxELC1ve/p
	 5I6ATJDQb8MFL8pnXDUZSMM0+vAfAP16knEsyewq5v4r9Hp77+fRvnnWHE50rtZ+bO
	 IMIfPoI86YMUwV9KT3VYsgRhTxZrfBeL1VVJ8k9uiVGLoCOmPaHQLlJF42IQfFaINX
	 qj4r+it1aOSNWfHTAOBNsEYaKht+rkgKMKuiAVOmazWaTu+WJ77Zv9ljYcZvCSqkvB
	 ElRDH2ZNexWAQY9rpd/KNCl5zFh8T2lWfo4vY23iWU1O8xkJrjtamK+zpBXNpAxHxK
	 n5oJXsfY0pjfA==
Message-ID: <5974ead5-2ef1-4887-91f5-422c87c30273@kernel.org>
Date: Mon, 11 Aug 2025 13:34:47 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] blk-mq-sched: introduce high level elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, jack@suse.cz,
 bvanassche@acm.org, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250806085720.4040507-1-yukuai1@huaweicloud.com>
 <20250806085720.4040507-2-yukuai1@huaweicloud.com>
 <61c62ef0-4dde-4c14-8039-213258d3c6ae@kernel.org>
 <70789114-81ad-1226-c99c-b35e152b7769@huaweicloud.com>
 <6a0a203c-c25d-4d01-9295-8d78bb897a07@kernel.org>
 <f4429faf-65b7-244f-7cf5-18c08ce4964c@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f4429faf-65b7-244f-7cf5-18c08ce4964c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/25 13:25, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/11 11:53, Damien Le Moal 写道:
>> On 8/11/25 10:01, Yu Kuai wrote:
>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>>>> index 55a0fd105147..1a2da5edbe13 100644
>>>>> --- a/block/blk-mq-sched.c
>>>>> +++ b/block/blk-mq-sched.c
>>>>> @@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>>>>    		if (budget_token < 0)
>>>>>    			break;
>>>>>    
>>>>> -		rq = e->type->ops.dispatch_request(hctx);
>>>>> +		if (blk_queue_sq_sched(q)) {
>>>>> +			elevator_lock(e);
>>>>> +			rq = e->type->ops.dispatch_request(hctx);
>>>>> +			elevator_unlock(e);
>>>>
>>>> I do not think this is safe for bfq since bfq uses the irqsave/irqrestore spin
>>>> lock variant. If it is safe, this needs a big comment block explaining why
>>>> and/or the rules regarding the scheduler use of this lock.
>>>
>>> It's correct, however, this patch doesn't change bfq yet, and it's like:
>>>
>>> elevator_lock
>>> spin_lock_irq(&bfqd->lock)
>>> spin_unlock_irq(&bfqd->lock)
>>> elevator_unlock
>>>
>>> Patch 3 remove bfqd->lock and convert this to:
>>>
>>> elevator_lock_irq
>>> elevator_unlock_irq.
>>
>> I do not understand. Since q->elevator->lock is already taken here, without IRQ
>> disabled, how can bfq_dispatch_request method again take this same lock with IRQ
>> disabled ? That cannot possibly work.
> 
> Looks like there is still misunderstanding somehow :( After patch 3,
> bfq_dispatch_work doesn't grab any lock, elevator lock is held before
> calling into dispatch method.
> 
> Before:
> 
> elevator_lock
> bfq_dispatch_request
>   spin_lock_irq(&bfqd->lock)
>   spin_unlock_irq(&bfqd->lock)
> elevator_unlock
> 
> After:
> elevator_lock_irq
> bfq_dispatch_request
> elevator_unlock_irq

Ah, yes, I see it now.

But that is a nasty change that affects *all* schedulers, even those that do not
need to disable IRQs because they are not using the lock in their completion
path, e.g. mq-deadline. So I do not think that is acceptable.

-- 
Damien Le Moal
Western Digital Research

