Return-Path: <cgroups+bounces-13229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E574D224C6
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 04:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F38683009D65
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C85229AAFD;
	Thu, 15 Jan 2026 03:27:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629F23EA80;
	Thu, 15 Jan 2026 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447677; cv=none; b=deKQtjF8eda9pH+i5dbwjQGvzXonUkrg3uZ+fVPOE3+YGNdBzKtR5y5RnKSq3wD6LhU9NzmtzJy/ukpC03LoNLA932zFFbGAMPVCCmf47lnZlhAPWXBn5oehg//v6LuF41ct/vqIJxPFPGTQMFpOvKmDULv8nG8dNJ5E1H3PszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447677; c=relaxed/simple;
	bh=oW5Umyq9d0GZwFlcKfm3gLZPED6RWLLNZ2U+pNP0lbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mk21T5AOWbEy9ZhFgR39M4byRA77CPLRA3+ILOxwOUqTtQO43N4ruLwRKCSFavuYpa5nRj7+WevHz2C4CFqno+X07Ts6Ju/3DZyB8lgiLe3BujcfzydD+RFlQybQB6izxNHKXaMDoVQ3SbF0LBoyf3cYGumgrBdgj0J91Vhka9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ds7h31JXDzKHM04;
	Thu, 15 Jan 2026 11:26:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2A6234057D;
	Thu, 15 Jan 2026 11:27:52 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgAXePi2Xmhpl_JmDw--.705S3;
	Thu, 15 Jan 2026 11:27:51 +0800 (CST)
Message-ID: <edf84e44-d7e3-4a34-ad49-90ab5a4f545e@huaweicloud.com>
Date: Thu, 15 Jan 2026 11:27:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation and
 blkg destruction
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
 hch@infradead.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, zhengqixing@huawei.com
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
 <20260113061035.1902522-2-zhengqixing@huaweicloud.com>
 <le5sjny634ffj6piswnkhkh33eq5cbclgysedyjl2bcuijiutf@f3j6ozw7zuuc>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <le5sjny634ffj6piswnkhkh33eq5cbclgysedyjl2bcuijiutf@f3j6ozw7zuuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXePi2Xmhpl_JmDw--.705S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXryUXr4fuFy7ArWxZrWxXrb_yoW5Xw47pr
	WSgr9xArykXrWxJr4Duw18Wry8tw45Gw47GrW8GFs5Cr45urWFqr1UZr4v9FyfAFZ7Jr45
	Zw40grZ7ZF1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/


在 2026/1/14 18:40, Michal Koutný 写道:
> On Tue, Jan 13, 2026 at 02:10:33PM +0800, Zheng Qixing <zhengqixing@huaweicloud.com> wrote:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> When switching an IO scheduler on a block device, blkcg_activate_policy()
>> allocates blkg_policy_data (pd) for all blkgs attached to the queue.
>> However, blkcg_activate_policy() may race with concurrent blkcg deletion,
>> leading to use-after-free and memory leak issues.
>>
>> The use-after-free occurs in the following race:
>>
>> T1 (blkcg_activate_policy):
>>    - Successfully allocates pd for blkg1 (loop0->queue, blkcgA)
>>    - Fails to allocate pd for blkg2 (loop0->queue, blkcgB)
>>    - Enters the enomem rollback path to release blkg1 resources
>>
>> T2 (blkcg deletion):
>>    - blkcgA is deleted concurrently
>>    - blkg1 is freed via blkg_free_workfn()
>>    - blkg1->pd is freed
>>
>> T1 (continued):
>>    - Rollback path accesses blkg1->pd->online after pd is freed
> The rollback path is under q->queue_lock same like the list removal in
> blkg_free_workfn().
> Why is queue_lock not enough for synchronization in this case?
>
> (BTW have you observed this case "naturally" or have you injected the
> memory allocation failure?)
>
Yes, this issue was discovered by injecting memory allocation failure at
->pd_alloc_fn(..., GFP_KERNEL) in blkcg_activate_policy().

In blkg_free_workfn(), q->queue_lock only protects the
list_del_init(&blkg->q_node). However, ->pd_free_fn() is called before
list_del_init(), meaning the pd is already freed before the blkg is removed
from the queue's list.

     blkcg_activate_policy()                  blkg_free_workfn()
     -------------------                          ------------------
     spin_lock(&q->queue_lock)
     ...
     if (!pd) {
         spin_unlock(&q->queue_lock)
         ...
         goto enomem
     }
     enomem:
         spin_lock(&q->queue_lock)
         if (pd) {
->pd_free_fn()  // pd freed
            pd->online // uaf
         ...
         }
spin_lock(&q->queue_lock)
list_del_init(&blkg->q_node)
spin_unlock(&q->queue_lock)
>>    - Triggers use-after-free
>>
>> In addition, blkg_free_workfn() frees pd before removing the blkg from
>> q->blkg_list.
> Yeah, this looks weirdly reversed.

Commit f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from 
blkg_free_workfn() and blkcg_deactivate_policy()") delays 
list_del_init(&blkg->q_node) until after pd_free_fn() in 
blkg_free_workfn(). This keeps blkgs visible in the queue list during 
policy deactivation, preventing parent policy data from being freed 
before child policy data and avoiding use-after-free.

Kind Regards,
Qixing


