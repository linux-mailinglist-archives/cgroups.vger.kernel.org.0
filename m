Return-Path: <cgroups+bounces-8892-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2847B0E9AE
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 06:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FBB1C869D3
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 04:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF521146C;
	Wed, 23 Jul 2025 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFPQJu1M"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDA1E5714;
	Wed, 23 Jul 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245440; cv=none; b=tqU9TK1vxkgRIFSwllLwEidBmdIprq/R7uoqbeycJfpXferyay1AaX8QAGkmhdN0xSaqrMN948s6QdcpajD9aHNUTqdO21Wp0GwUYVIndbBjgpGsOQ/mk1ZJAgMmtVQ4LL/QpY47R+SmOyxpWm2XehfLT33t1taSvpKz83IhlnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245440; c=relaxed/simple;
	bh=LNB7c8Q3FWbbUT0jg4u0cBveqnm3xYrnm8Y9cg2oYVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPNTDhSi18g4PhIFC/TMV+j7HK89lAwrZc8hfd3FhSP3cO/4NcBXmurAFju1+t0ctRcEbVJeN2Xd4aPV9R/T+5k7uXkwypzWW7vX8gigjRgGGHlhpHeZb3nD3hPLg2vygYfSAhaxYdVtzmRW1+we2a2ob1lxL/24sG2VgQhmv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFPQJu1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A16DC4CEE7;
	Wed, 23 Jul 2025 04:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245439;
	bh=LNB7c8Q3FWbbUT0jg4u0cBveqnm3xYrnm8Y9cg2oYVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RFPQJu1Msu3nhQ3efoSHcgAldmwtMlzxfNw8OoVOoqy/1AfLc6RWnNDmj0kMWE4tq
	 aZZKeSsg6ZaA0JHqcRX3KXVpbD44MFsuzQJZw6f0q/lo2YEQW4e0h51gwT3+Cp3XEC
	 NleQTC2XDk+aq+ea5/cs+o71UJd+nh3rDHf1YcSWFSw2hZ6z1677D1m2qQS23+Tn5r
	 RNREoQbzKxRG6hqmZrbW76ztt9xBfO+4xxWuPiu4FsgZhppCJH1ldbLUyVMkTLma1x
	 uPT09fiYA7EAf6MUsmBPYi1hypmyEjBT4Gsr3G7fPEGOsrx9yWviq100Q7Oz5Q4NPU
	 X2qEwJJsi4mDQ==
Message-ID: <352c67be-b39e-4372-9f69-f942b0a9818d@kernel.org>
Date: Wed, 23 Jul 2025 13:34:51 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] elevator: factor elevator lock out of
 dispatch_request method
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-5-yukuai1@huaweicloud.com>
 <08c989bd-20d8-476c-af99-c9eb8065349d@kernel.org>
 <cc6f72cb-3782-4426-57c2-4d54fc4f38f2@huaweicloud.com>
 <d32d44ef-a964-430a-a735-f63f2fa5e7ed@kernel.org>
 <2b48b0eb-7294-c4e1-8b84-ce2e860f3a75@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <2b48b0eb-7294-c4e1-8b84-ce2e860f3a75@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/25 11:51 AM, Yu Kuai wrote:
>> If you apply this patch, stop here without applying the following patches, and
>> test the changes up to this point, things will break since there is no locking
>> during dispatch.
> 
> Do you missed the following change in this patch? Dispatch do switch to
> the new lock, I don't get it why there is no locking.

My bad. Yes, I completely missed it. Sorry for the noise.

> @@ -113,7 +114,12 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx
> *hctx)
>          if (budget_token < 0)
>              break;
> 
> +        if (sq_sched)
> +            spin_lock_irq(&e->lock);
>          rq = e->type->ops.dispatch_request(hctx);
> +        if (sq_sched)
> +            spin_unlock_irq(&e->lock);
> +
>          if (!rq) {
>              blk_mq_put_dispatch_budget(q, budget_token);
>              /*
>>
>> So you need to organize the patches so that you first have the elevator level
>> common locking in place and then have one patch for bfq and one patch for
>> mq-deadline that switch to using that new lock. Hence the suggestion to reverse
>> the order of your changes: change the block layer first, then have bfq and
>> mq-deadline use that new locking.
> 
> I think I understand what you mean, just to be sure.
> 
> 1. patch 5 in this set
> 2. patch to introduce high level lock, and grab it during dispatch in block layer.
> 3. changes in ioc
> 4. changes in bfq
> 5. changes in deadline
> 6. patch 6 in this set.

What about something like this:
1) Introduce the elevator common/generic lock (first part of patch 1 + middle
of patch 4 squashed together)
2) Convert deadline to use elevator generic lock (second part of patch 1 + end
of patch 4)
3) Convert bfq to use elevator generic lock (patch 3 + beginning of patch 4)
4) Patch 6

As for the ioc changes, they do not seem directly related to the elevator lock
changes, but since the code may conflict, maybe bring them as prep patches at
the beginning (0).


-- 
Damien Le Moal
Western Digital Research

