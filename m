Return-Path: <cgroups+bounces-2612-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14C8AAB5C
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 11:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BD71F22A7A
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64417C081;
	Fri, 19 Apr 2024 09:20:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4917581A;
	Fri, 19 Apr 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518428; cv=none; b=Klw+ww5mQkd9vIwllXdFsmWtwJkyDia3gr8oOrLNHx5H7lZfm0vAoYbuR6VfEB5UvRw+PZAqH9mewnvndZbvYuZX613UJYbkRR6lUPU6glGjzhKVgPdMSDqEzg+veXdbbG+LFz5+yUO9hhHlLzugn7/tv0g1xhMpOlpoxzLZwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518428; c=relaxed/simple;
	bh=WaogRnoe7hdBqtvTzhUFskAdd+jFv4uOzZL7FIIZjHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSjE/8EvI38cNhQjk7JaHLokHp/WSQshFqKcxcbuH3m5L8VaXgFDR0hGmnBV1MlzrnbweArP34AfgktkCl/Mt/ShbUAJUHdsu1PKJlY2aPIk291BoM9D6a0eZmODa1EwndqCLjJc5DdNblw95jliBfbMQ1cRaNE2UTYD2rBSrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VLTd93rwnz4f3p13;
	Fri, 19 Apr 2024 17:20:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8524F1A09FD;
	Fri, 19 Apr 2024 17:20:22 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQxUNyJmH6p5Kg--.17521S3;
	Fri, 19 Apr 2024 17:20:22 +0800 (CST)
Message-ID: <f641e693-6ae2-b3a6-8655-848b2986503b@huaweicloud.com>
Date: Fri, 19 Apr 2024 17:20:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-iocost: do not WARNING if iocg has already offlined
To: Tejun Heo <tj@kernel.org>, linan666@huaweicloud.com
Cc: josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20240418072340.2090877-1-linan666@huaweicloud.com>
 <ZiFG5KtGGpYdOmnY@slm.duckdns.org>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZiFG5KtGGpYdOmnY@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXOQxUNyJmH6p5Kg--.17521S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry7uFyxWw15uF4fGw1kGrg_yoW8uw1kpr
	W5K3ZFkF1jqrnFya92q3Z2qw10gan5Xw1fJw1fWrn8AFy3uF1Iq3Wq9r4YqF92qr1rAFZ3
	ZF48G3ySvF4UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/4/19 0:14, Tejun Heo 写道:
> Hello,
> 
> On Thu, Apr 18, 2024 at 03:23:40PM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
>> is intended to confirm iocg is avitve when it has debt. However, warn
>> can be triggered during removing cgroup controller, as
> 
> Maybe saying "a blkcg is being removed" is clearer?

Thanks for your suggestion. I will correct my expression in next version.

> 
>> iocg_waitq_timer_fn() is awakened at that time.
>>
>>    WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
>>    Call trace:
>>    iocg_pay_debt+0x14c/0x190
>>    iocg_kick_waitq+0x438/0x4c0
>>    iocg_waitq_timer_fn+0xd8/0x130
>>    __run_hrtimer+0x144/0x45c
>>    __hrtimer_run_queues+0x16c/0x244
>>    hrtimer_interrupt+0x2cc/0x7b0
>>
>> The warn in this situation is meaningless. Since this iocg is being
>> removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
>> is canceled after removing 'active_list' in ioc_pd_free(), which ensure
>> iocg is freed after iocg_waitq_timer_fn() returns.
>>
>> Therefore, add the check if iocg has already offlined to avoid warn
>> when removing cgroup controller.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   block/blk-iocost.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index baa20c85799d..2e109c016a39 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -1440,7 +1440,7 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
>>   	lockdep_assert_held(&iocg->waitq.lock);
>>   
>>   	/* make sure that nobody messed with @iocg */
>> -	WARN_ON_ONCE(list_empty(&iocg->active_list));
>> +	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
> 
> Can you add a comment explaining why we need the pd.online test?

Yeah, I will add comment in next version.

> 
> Other than the above nits, looks great to me. Please feel free to add
> 
>    Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 

-- 
Thanks,
Nan


