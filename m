Return-Path: <cgroups+bounces-13011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6FD07F67
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 741023027593
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C3F350D55;
	Fri,  9 Jan 2026 08:46:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4E345CC8;
	Fri,  9 Jan 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948417; cv=none; b=mSX7JI/UWXB7RddlKXDX51eKTeocffOJM9yP/YH1qQB6blvhSefSoZfoTOLtzIdjssm6mLTYw6N/ufzOQDl+bPNMIEhFldvMylJdh7NDCBcBdzDXAe4Mc8amGpFneqs/g0k4JxBmyHabnCd9XVrvPb8rfXSyPuGDuuR5wmKwni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948417; c=relaxed/simple;
	bh=r8ZBffJjNRIXF58McbEpn/VwlQJnOpN0UO16GTg5sfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ltb/OctlfnI6bMHTXg0r3FvNFjpYt7aps8LfcYsiYCcW0gYOEfH0KR5m12CwN8JOK7Ux59HhqwL8QIL89oa6KP+wIbJd84pnDYvZH+oH1EaGQZ9wrqz9hL/JslNO8SkPNihjVtzJI0cERmaDPFA0JDxNR8dgU4xD2E7LVW4CZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dnb326vQbzKHMYm;
	Fri,  9 Jan 2026 16:46:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 10A8A40576;
	Fri,  9 Jan 2026 16:46:51 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPl6wGBpz8itDA--.9837S3;
	Fri, 09 Jan 2026 16:46:50 +0800 (CST)
Message-ID: <5a0b548a-8b32-4ba2-8d58-dd6f2bf1f977@huaweicloud.com>
Date: Fri, 9 Jan 2026 16:46:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] blk-cgroup: skip dying blkg in
 blkcg_activate_policy()
To: yukuai@fnnas.com
Cc: hch@infradead.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 zhengqixing@huawei.com
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-4-zhengqixing@huaweicloud.com>
 <8b5487db-d15a-4dd1-901c-e33ec1418c75@fnnas.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <8b5487db-d15a-4dd1-901c-e33ec1418c75@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3WPl6wGBpz8itDA--.9837S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4kArWrWrWxuF18Ww4rKrg_yoW8Ar47pr
	Z3KF4ak3srGFn2k3ZIgw17Xry0vw18tr15GFW3G3sI9wsxJ34SvF1UuFs8uFZ5AF1DAF45
	X3WqqFyUCF48u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/


在 2026/1/9 0:22, Yu Kuai 写道:
> Hi,
>
> 在 2026/1/8 9:44, Zheng Qixing 写道:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> When switching IO schedulers on a block device, blkcg_activate_policy()
>> can race with concurrent blkcg deletion, leading to a use-after-free of
>> the blkg.
>>
>> T1:				  T2:
>> elv_iosched_store		  blkg_destroy
>> elevator_switch			  kill(&blkg->refcnt) // blkg->refcnt=0
>> ...				  blkg_release // call_rcu
>> blkcg_activate_policy		  __blkg_release
>> list for blkg			  blkg_free
>> 				  blkg_free_workfn
>> 				  ->pd_free_fn(pd)
>> blkg_get(blkg) // blkg->refcnt=0->1
>> 				  list_del_init(&blkg->q_node)
>> 				  kfree(blkg)
>> blkg_put(pinned_blkg) // blkg->refcnt=1->0
>> blkg_release // call_rcu again
>> call_rcu(..., __blkg_release)
> This stack is not clear to me, can this problem be fixed by protecting
> q->blkg_list iteration with blkcg_mutex as I said in patch 2?
It appears that adding blkcg_mutex still cannot resolve the issue where 
the same blkg has its
reference count decremented to 0 twice.
However, it does fix the memory leak caused by pd_alloc_fn() succeeding 
for a blkg that has
already been removed.
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index af468676cad1..ac7702db0836 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1645,9 +1645,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>>    			 * GFP_NOWAIT failed.  Free the existing one and
>>    			 * prealloc for @blkg w/ GFP_KERNEL.
>>    			 */
> Why this check is not done before pd_alloc_fn()? What if pd_alloc_fn() succeed for
> removed blkg?

I will fix this memory leak issue in the next revision.


Thank,

Qixing


