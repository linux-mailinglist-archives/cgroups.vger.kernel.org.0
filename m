Return-Path: <cgroups+bounces-10485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427ABA7A6C
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 03:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272433B4FA3
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 01:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973F4207A;
	Mon, 29 Sep 2025 01:02:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B5A31;
	Mon, 29 Sep 2025 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107758; cv=none; b=BIClGgCX4Cr+xxb/4NAxRLcdznYfFo+orGBr3uNFaMGahLatyGcsMJI6V2cu0TeDEzFo2o3i2e9DGGfpKQYoP7c7UgvuV0Gav7tE4ZZw0yb8lL7KHVU7KjyJ9eLUZW7S9HjKguh3lzFPXth44ytQfpUlK9xvrX+Tj4kJeZBeceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107758; c=relaxed/simple;
	bh=OQ2MWIMo+ifV9PZd1sYqy7TBioUTpaaT/nClxx4qxOk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G7nRktuVimx2NEXc/gQyo4p1c0WrZPvwiaoKswKTnHHdGNmvWYw3pWGAN2YdtbFffJZpqtfNa2DH8l/+7L12TVRGXsQnaTLL+SLCc5YGe5jM8KnEHukxOsaoiYRrdDBexoxAGb/kD9XiTpp8R1Uqjj0ScU0ZtxqPCDAwrR7FsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZjZz3DY2zKHMpf;
	Mon, 29 Sep 2025 09:02:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BC1AD1A1286;
	Mon, 29 Sep 2025 09:02:32 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHi2Om2tlog8ipBA--.21198S3;
	Mon, 29 Sep 2025 09:02:32 +0800 (CST)
Subject: Re: [PATCH 01/10] blk-cgroup: use cgroup lock and rcu to protect
 iterating blkcg blkgs
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Yu Kuai <hailan@yukuai.org.cn>, tj@kernel.org, ming.lei@redhat.com,
 nilay@linux.ibm.com, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
 akpm@linux-foundation.org, vgoyal@redhat.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
 <20250925081525.700639-2-yukuai1@huaweicloud.com>
 <bc6fe04d-3245-40dd-aa30-c3a3acb670c2@acm.org>
 <01e7eccd-3529-4d12-8ad2-fd9e034a026d@yukuai.org.cn>
 <688275d5-fbb4-08b3-45e1-798ad8cf77fc@huaweicloud.com>
 <66dcdcd1-df71-43b9-a468-2b4aaa8b6dc7@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9cf50e70-d2e4-cfd7-da2e-3701da0814b4@huaweicloud.com>
Date: Mon, 29 Sep 2025 09:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <66dcdcd1-df71-43b9-a468-2b4aaa8b6dc7@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHi2Om2tlog8ipBA--.21198S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW5urWxuryfZw4DJr17Awb_yoW8Xr47p3
	yFq3W2kr4DtF4q93sFga1jvF1F9an7Gr98Jr4kXry5Aa4qvr1YqFsFyFWqkF1vqanrt3Wq
	k34jkrZ3Jw10vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/27 1:19, Bart Van Assche 写道:
> On 9/25/25 5:57 PM, Yu Kuai wrote:
>> 在 2025/09/26 1:07, Yu Kuai 写道:
>>> 在 2025/9/25 23:57, Bart Van Assche 写道:
>>>> On 9/25/25 1:15 AM, Yu Kuai wrote:
>>>>> It's safe to iterate blkgs with cgroup lock or rcu lock held, prevent
>>>>> nested queue_lock under rcu lock, and prepare to convert protecting
>>>>> blkcg with blkcg_mutex instead of queuelock.
>>>>
>>>> Iterating blkgs without holding q->queue_lock is safe but accessing the
>>>> blkg members without holding that lock is not safe since q->queue_lock
>>>> is acquired by all code that modifies blkg members. Should perhaps a 
>>>> new
>>>> spinlock be introduced to serialize blkg modifications?
>>
>> Actually, only blkcg_print_blkgs() is using rcu in this patch, and take
>> a look at the callers, I don't see anyone have to hold queue_lock. Can
>> you explain in detail which field from blkg is problematic in this
>> patch?
> 
> I'm not a cgroup expert so I cannot answer the above question. But I
> think it's clear that the description of this patch is not sufficient as
> motivation for this patch. Removing the blkg->q->queue_lock lock and
> unlock calls requires a detailed review of all blkcg_print_blkgs() and
> blkcg_print_stat() callers. There is no evidence available in the patch
> description that shows that such a review has happened.
> 

Ok, I'll explain more in details in commit message.

Thanks,
Kuai

> Thanks,
> 
> Bart.
> .
> 


