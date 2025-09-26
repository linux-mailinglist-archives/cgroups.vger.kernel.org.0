Return-Path: <cgroups+bounces-10464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76495BA21E0
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 02:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E164740BE8
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 00:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8D1514F7;
	Fri, 26 Sep 2025 00:57:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8426ACB;
	Fri, 26 Sep 2025 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758848232; cv=none; b=WW0/SnLM4kTwAJraz9qobRs/EijtUDr55PM+AtPAFxFFl+yTKXN3eREHTE+0aPeTfgVZRbHZbTK0Hh6eq7TL47TeoRU1aslKAfcNJMj8+vCjCpvhJFN4kCDH1B8q7jhPiFCFOdmHm9vzi6r5wwiwVRUHZkLRDcP/d5b9LoL6yr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758848232; c=relaxed/simple;
	bh=4mX3EcmuNBcUPEBlDvx8Usz+XeVEpNdSEwjS9wu5/Aw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UHnR1np/J3harX+IE1+Ou/19kDwtsvms2Y5SW4yM0q2bNMCXa0VCnlZe3xTXE0P9bauGq8eWGDmCcz1LqE7wMMB5CkE2ra1Axs4gZRGn+Gf5cIZwnysspc+DXQeuE/utLeBX2edeT5BugOJQOhfHQV6D1797j0Q/r8dsaWTNthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cXsc814vfzYQv3Z;
	Fri, 26 Sep 2025 08:56:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F0771A13AF;
	Fri, 26 Sep 2025 08:57:06 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHCmLf5NVoUKZVAw--.24830S3;
	Fri, 26 Sep 2025 08:57:05 +0800 (CST)
Subject: Re: [PATCH 01/10] blk-cgroup: use cgroup lock and rcu to protect
 iterating blkcg blkgs
To: Yu Kuai <hailan@yukuai.org.cn>, Bart Van Assche <bvanassche@acm.org>,
 Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, ming.lei@redhat.com,
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <688275d5-fbb4-08b3-45e1-798ad8cf77fc@huaweicloud.com>
Date: Fri, 26 Sep 2025 08:57:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <01e7eccd-3529-4d12-8ad2-fd9e034a026d@yukuai.org.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHCmLf5NVoUKZVAw--.24830S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF1rXF15Ar4kuw1rAr1UKFg_yoWftwbEva
	n0y3s7Gw15Wwnaq3WrGrnxJFZ5Ka18XryUCF48AFW7twnxAa45G3ZrurWxZFZYka1qywn2
	gr1ku348Jr4aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/26 1:07, Yu Kuai 写道:
> Hi,
> 
> 在 2025/9/25 23:57, Bart Van Assche 写道:
>> On 9/25/25 1:15 AM, Yu Kuai wrote:
>>> It's safe to iterate blkgs with cgroup lock or rcu lock held, prevent
>>> nested queue_lock under rcu lock, and prepare to convert protecting
>>> blkcg with blkcg_mutex instead of queuelock.
>>
>> Iterating blkgs without holding q->queue_lock is safe but accessing the
>> blkg members without holding that lock is not safe since q->queue_lock
>> is acquired by all code that modifies blkg members. Should perhaps a new
>> spinlock be introduced to serialize blkg modifications?

Actually, only blkcg_print_blkgs() is using rcu in this patch, and take
a look at the callers, I don't see anyone have to hold queue_lock. Can
you explain in detail which field from blkg is problematic in this
patch?

Thanks,
Kuai

>>
> No need for a new lock, I think blkcg->lock can do that.
> 
> Thanks,
> Kuai
> 
>> Thanks,
>>
>> Bart.
>>
> .
> 


