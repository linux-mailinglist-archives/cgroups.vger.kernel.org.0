Return-Path: <cgroups+bounces-9065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D76B1FE57
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 06:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405687A580D
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 04:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861302609D4;
	Mon, 11 Aug 2025 04:25:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC38F7D;
	Mon, 11 Aug 2025 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754886328; cv=none; b=VWShtuLx83nDd1344OVAc5FehiKTAkKj7PEWEwsDmuH4f3A9zLd+3YKtm6J08UDLJbjMljqtFjjZEwJD8tf4FULwtW9XxSURCwvz1aNT1yUQRYqmdD3s1qZIIOCyAKYVjylo11ElgNbYhDa6cLGI1ho9ai7ZBzdrJjvsSWVZDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754886328; c=relaxed/simple;
	bh=h5l3YnUna+CzgjFarqo76YFDhrwRvBImBE+x+F1mfcU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VKuGNsWRGaK3dE6HwvnvsUZS4ffcyV83tz1l9Umf5SJdshGe2gO/xgfIMyBxNlvysMhIJ0zr82UmaGDaNgJy+lLi802kwATZSyuGbxzHsjd18RhFx5nzkLozAofOze6DGZnUTAoiwXnMe39xoUTMJOkQULyQQRE2N4rek8LrSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c0hPv36DKzYQttt;
	Mon, 11 Aug 2025 12:25:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0EDB91A018D;
	Mon, 11 Aug 2025 12:25:22 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHERKvcJloxJAmDQ--.11300S3;
	Mon, 11 Aug 2025 12:25:21 +0800 (CST)
Subject: Re: [PATCH v3 1/5] blk-mq-sched: introduce high level elevator lock
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hare@suse.de, jack@suse.cz, bvanassche@acm.org, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250806085720.4040507-1-yukuai1@huaweicloud.com>
 <20250806085720.4040507-2-yukuai1@huaweicloud.com>
 <61c62ef0-4dde-4c14-8039-213258d3c6ae@kernel.org>
 <70789114-81ad-1226-c99c-b35e152b7769@huaweicloud.com>
 <6a0a203c-c25d-4d01-9295-8d78bb897a07@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f4429faf-65b7-244f-7cf5-18c08ce4964c@huaweicloud.com>
Date: Mon, 11 Aug 2025 12:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a0a203c-c25d-4d01-9295-8d78bb897a07@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERKvcJloxJAmDQ--.11300S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkKryUCF1ktr1xuFWUXFb_yoW5JrW8pr
	4fJa98tw4DXr1vv3W29w1xXw4UK3yYgry7ur97Gw47tF97Jrn7JF1FgF4vvFWjqrn3GFsF
	gr48Ja95Ca4jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/11 11:53, Damien Le Moal 写道:
> On 8/11/25 10:01, Yu Kuai wrote:
>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>>> index 55a0fd105147..1a2da5edbe13 100644
>>>> --- a/block/blk-mq-sched.c
>>>> +++ b/block/blk-mq-sched.c
>>>> @@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>>>    		if (budget_token < 0)
>>>>    			break;
>>>>    
>>>> -		rq = e->type->ops.dispatch_request(hctx);
>>>> +		if (blk_queue_sq_sched(q)) {
>>>> +			elevator_lock(e);
>>>> +			rq = e->type->ops.dispatch_request(hctx);
>>>> +			elevator_unlock(e);
>>>
>>> I do not think this is safe for bfq since bfq uses the irqsave/irqrestore spin
>>> lock variant. If it is safe, this needs a big comment block explaining why
>>> and/or the rules regarding the scheduler use of this lock.
>>
>> It's correct, however, this patch doesn't change bfq yet, and it's like:
>>
>> elevator_lock
>> spin_lock_irq(&bfqd->lock)
>> spin_unlock_irq(&bfqd->lock)
>> elevator_unlock
>>
>> Patch 3 remove bfqd->lock and convert this to:
>>
>> elevator_lock_irq
>> elevator_unlock_irq.
> 
> I do not understand. Since q->elevator->lock is already taken here, without IRQ
> disabled, how can bfq_dispatch_request method again take this same lock with IRQ
> disabled ? That cannot possibly work.

Looks like there is still misunderstanding somehow :( After patch 3,
bfq_dispatch_work doesn't grab any lock, elevator lock is held before
calling into dispatch method.

Before:

elevator_lock
bfq_dispatch_request
  spin_lock_irq(&bfqd->lock)
  spin_unlock_irq(&bfqd->lock)
elevator_unlock

After:
elevator_lock_irq
bfq_dispatch_request
elevator_unlock_irq

> 
> The other side of this is that if you use elevator_lock(e) to call
> e->type->ops.dispatch_request(hctx), it means that the scheduler *can NOT* use
> that same lock in its completion path, since that can be called from IRQ
> context. This may not be needed/a problem right now, but I think this needs a
> comment in this patch to mention this.
> 

So, the first patch just grab elevator lock for dispatch method, bfq
dispatch still using spin_lock_irq(&bfqd->lock), and complete is still
using bfqd->lock, this is safe.

Later patch 3 remove bfqd->lock and use elevator lock instead, and
because elevator lock will be used in complete path now, elevator_lock
from dispatch path is converted to elevator_lock_irq.

Thanks,
Kuai


