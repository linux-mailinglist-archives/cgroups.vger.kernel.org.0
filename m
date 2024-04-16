Return-Path: <cgroups+bounces-2520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D98A6DDB
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEFC285236
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4A812FF9E;
	Tue, 16 Apr 2024 14:17:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC8128805;
	Tue, 16 Apr 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277057; cv=none; b=eiJ8Yc7bEluiaf94b3ciVBz6Is1ysZuHZxbasce84W8kiiX4JnlvuZpo7I8zx7h5GdAHfO+MGeYfeqq6gXL400rLy8Pdxz6qT4yn9X+PCmNti8ueclUUCCwgGhzX/GkiGEaoTiXsy1Hzee84XU15qLxQiNqiJkspynV853se5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277057; c=relaxed/simple;
	bh=nVjL7xFxhNE5qVQP1x7QBvAR9LfWcP0/FxFyMGPLsLQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xj7gT19ZGph+QXXTQRuQItAFi42bQsfH8HQHxwJYeDFH4AanyS6KiywbmOp/Yf4v7170rktDiebvQMk3s7v5s+ocCz0yrPuppOh3Az+mA8M6qO/EAPdjT580OkSikDmw6YxdKXWXLN6eUgVZ9GFhUbJ0kpPgof2nuOg93OBkW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJmMQ6Stxz4f3n6l;
	Tue, 16 Apr 2024 22:17:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C37B51A0D4C;
	Tue, 16 Apr 2024 22:17:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF5iB5mB_iTKA--.31202S3;
	Tue, 16 Apr 2024 22:17:31 +0800 (CST)
Subject: Re: [PATCH RFC v2 6/6] blk-throtl: switch to use rq_qos
To: Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
 jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, pctammela@mojatatu.com,
 qde@naccy.de, zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-7-yukuai1@huaweicloud.com>
 <Zhl5ONFlPg4vqjGj@slm.duckdns.org>
 <b522c2b7-efae-a7ca-ee6c-197a4b9b54ff@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ed253aa4-517c-0f56-5550-96b23093528b@huaweicloud.com>
Date: Tue, 16 Apr 2024 22:17:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b522c2b7-efae-a7ca-ee6c-197a4b9b54ff@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF5iB5mB_iTKA--.31202S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4DuF17GFWDGrW5tw1kZrb_yoW5Jw1fpa
	y0g3WUCrWDCrnY9w13Cw40qFWSyr4UA3yUJr98JFZxJF1DJr9YgFy3Zw109ayUXFs7Wr4j
	va4UJw4xu3WDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/13 10:17, Yu Kuai 写道:
> Hi,
> 
> 在 2024/04/13 2:11, Tejun Heo 写道:
>> Hello,
>>
>> On Sat, Apr 06, 2024 at 04:00:59PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> To avoid exposing blk-throttle internal implementation to general block
>>> layer.
>> ...
>>> @@ -832,7 +832,7 @@ void submit_bio_noacct(struct bio *bio)
>>>           goto not_supported;
>>>       }
>>> -    if (blk_throtl_bio(bio))
>>> +    if (rq_qos_throttle_bio(q, bio))
>>>           return;
>>>       submit_bio_noacct_nocheck(bio);
>>>       return;
>>
>> This is a half-way conversion, right? You're adding a dedicated hook to
>> rq_qos and none of the other hooks can be used by blk-throtl. Even the 
>> name,

Actually, rq_qos_exit() is used as well for destroy blk-throtl.

>> rq_qos_throttle_bio(), becomes a misnomer. I'm not really sure this makes
>> things better or worse. It makes certain things a bit cleaner but other
>> things nastier. I don't know.
> 
> Yes, the final goal is making all blk-cgroup policies modular, and this
> patch use rq-qos to prevent exposing blk-throtle to block layer, like
> other policies.

After thinking this a bit more, I still think probably rq_qos is a
better choice, and there is something that I want to discuss.

There are two different direction, first is swith blk-throttle to
rq_qos_throttle() as well, which is called for each rq:

1) For, rq-based device, why blk-throtl must throttle before
rq_qos_throttle()? And blk-throtl have to handle the bio split case
seperately. And it looks like blk-throttle can switch to use
rq_qos_throttle() with the benefit that io split does't need
special handling.

2) blk-throtl treats split IO as additional iops, while it ignores
merge IO, this looks wrong to me. If multiple bio merged into one
request, iostat will see just one IO. And after switching to rq_qos,
bio merge case can be handled easily as well.

Another is still add a rq_qos_throttle_bio(perhaps another name?), and
meanwhile iocost can benefit from this new helper as well. Because
iocost really is based on bio, currently it must handle the io merge
case by debt.

Thanks,
Kuai

> 
> There is another choice that I think is feasible:
> 
> Let blk-throttle ping a policy id, and use the id to call throttle
> function directly, this will require initializing the 'plid' from
> blkcg_policy() during definition instead of blkcg_policy_register().
> 
> Thanks,
> Kuai
> 
>>
>> Thanks.
>>
> 
> .
> 


