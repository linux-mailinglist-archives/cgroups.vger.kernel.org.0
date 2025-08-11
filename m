Return-Path: <cgroups+bounces-9064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C90B1FE41
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A7A7A9DFA
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 03:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781EF23F42D;
	Mon, 11 Aug 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbAinhet"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F498F6F;
	Mon, 11 Aug 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754884384; cv=none; b=iwlMKS6BieN9eFruoj6G91SUSLJ8OhAcAzzxEaG7xnYTzktTen00ge1gspENEXc6AyYF+/dX8rVUbCZBgwM2sIeLnai0OHMwtyx/xipHRG9rtzoALDyZX+BExSsvyjXOfk8H7SvKoq0eK2WUA49F/IlzRHYBIWmZxI4ECOjX3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754884384; c=relaxed/simple;
	bh=aNH529pCRu9+SA4gE8UXYXNS5yeFnObsQC4TW5cLFLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVN4RWM0wfCm0cP97grp21pZCaKfD8s4VGcXhR9oLlARHWN4+7jTEUrai+EtGcuwXYMjPClKnq3wZHkk8g/BJMNyFO65+nDKqLk/n2rliiI1D5A4jcXz/HWF/ILOr8zRZx/WLHwm4phikHmrmITxuWDp5PYwkpYW448hV0oTy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbAinhet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD9FC4CEED;
	Mon, 11 Aug 2025 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754884383;
	bh=aNH529pCRu9+SA4gE8UXYXNS5yeFnObsQC4TW5cLFLI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PbAinhetPgabCy1W5zjocItp4AcldnUC2ghV7BzwzbAQtW95RSCs0rVgZimQzj16M
	 xWiHV9MqWZCTApEetKpp4cm7KmqTF/yas4mncKP9Gm8LPEcaORX+AlaUYPyqoLpJ9C
	 oLS7F80L8qo8pm0VN6R933rokOsqhFfYZPt+Lsm0uDJP+ort7mD1nccbP31BHl+Vq5
	 1NdpJq8tmfYmZ9zml3ded7os3CKxXm3ZhnQXVc0d2pPOtsh9Oa3sVoLCr//xRbj+3p
	 JOOrBGVgpOOcteD993jPqmbz5yAfCu/uSjuDLTg1SnxjIaDyp9T9miXsP6tX5J4v1h
	 Y3O/yI0ORZMNQ==
Message-ID: <6a0a203c-c25d-4d01-9295-8d78bb897a07@kernel.org>
Date: Mon, 11 Aug 2025 12:53:01 +0900
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <70789114-81ad-1226-c99c-b35e152b7769@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 10:01, Yu Kuai wrote:
>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>> index 55a0fd105147..1a2da5edbe13 100644
>>> --- a/block/blk-mq-sched.c
>>> +++ b/block/blk-mq-sched.c
>>> @@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>>   		if (budget_token < 0)
>>>   			break;
>>>   
>>> -		rq = e->type->ops.dispatch_request(hctx);
>>> +		if (blk_queue_sq_sched(q)) {
>>> +			elevator_lock(e);
>>> +			rq = e->type->ops.dispatch_request(hctx);
>>> +			elevator_unlock(e);
>>
>> I do not think this is safe for bfq since bfq uses the irqsave/irqrestore spin
>> lock variant. If it is safe, this needs a big comment block explaining why
>> and/or the rules regarding the scheduler use of this lock.
> 
> It's correct, however, this patch doesn't change bfq yet, and it's like:
> 
> elevator_lock
> spin_lock_irq(&bfqd->lock)
> spin_unlock_irq(&bfqd->lock)
> elevator_unlock
> 
> Patch 3 remove bfqd->lock and convert this to:
> 
> elevator_lock_irq
> elevator_unlock_irq.

I do not understand. Since q->elevator->lock is already taken here, without IRQ
disabled, how can bfq_dispatch_request method again take this same lock with IRQ
disabled ? That cannot possibly work.

The other side of this is that if you use elevator_lock(e) to call
e->type->ops.dispatch_request(hctx), it means that the scheduler *can NOT* use
that same lock in its completion path, since that can be called from IRQ
context. This may not be needed/a problem right now, but I think this needs a
comment in this patch to mention this.

-- 
Damien Le Moal
Western Digital Research

