Return-Path: <cgroups+bounces-13010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1FCD07DD5
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 09:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98F7030123FE
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E98350A36;
	Fri,  9 Jan 2026 08:37:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE11DA628;
	Fri,  9 Jan 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947856; cv=none; b=SSRFFuY+02f76dKHCQuDlGHuWdx+dUa2pM38Vu+dscb/afqwnzTkrN5ZmUHyoexqufAHrNiOIcCA4zqapKEZTVu3p9tHxRE2SorwEiii2gEV3/FprgZXL/DpDgGfSNjwvCQwcv7d52kJDEi9vAVWdUA5Vk8ttedUHH/1GL6fxo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947856; c=relaxed/simple;
	bh=ASyCKrzz9Ct9WFL9DbOZJ67O7PIK63ZzMsT+0LvQXsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzS6PkHqxOdb7y9KbKo4EumVsI+9NEGVyFxCtvkqCTYkQtM7JYug0ap1AOdLFaFtOwdK97kRmA2HtRS1/3A6RIhQb7w5GlNAQ7ZbvMA06V7+IVGDeMT5ovX/VpQz8uKuo84GjX61zvQ7fKPVShG1vRF8AA2Pb64mDndB+BkMUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dnZr745X0zKHLvq;
	Fri,  9 Jan 2026 16:36:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A24F340574;
	Fri,  9 Jan 2026 16:37:23 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgBHp_dBvmBpxgCtDA--.8175S3;
	Fri, 09 Jan 2026 16:37:23 +0800 (CST)
Message-ID: <6b6c9d8d-9a55-4769-ba3a-00d5ee7f32b3@huaweicloud.com>
Date: Fri, 9 Jan 2026 16:37:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] blk-cgroup: fix uaf in blkcg_activate_policy() racing
 with blkg_free_workfn()
To: yukuai@fnnas.com
Cc: hch@infradead.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 zhengqixing@huawei.com
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-3-zhengqixing@huaweicloud.com>
 <72dc0ed6-1ba9-46b8-a43f-d11c32e2f341@fnnas.com>
 <5fdbd368-6d00-4453-8f03-23d17c8c1338@huaweicloud.com>
 <22046287-0a36-45ac-bc17-b41636076552@fnnas.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <22046287-0a36-45ac-bc17-b41636076552@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHp_dBvmBpxgCtDA--.8175S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWrJrWkKF17JF15JF4DXFb_yoW8Kw4fpF
	W5JF4Yy3s3trsFv3yqg347WayIga1vgrW5JrW8G39IyrWjvr92qF1UAFyDCFWrArW8JrsI
	yF4YgrZYkF48Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

Sorry for that I replied with the wrong patch. Even after adding the 
blkcg_mutex in blkg_destroy_all()
and blkcg_activate_policy(), the UAF issue described in the 3rd patch 
(multiple calls to call_rcu releasing
the same blkg) still occurs.
For the 2nd patch, in addition to the blkcg_mutex that I initially added 
in the enomem branch, it is
indeed possible to add blkcg_mutex at other places where blkg_list is 
accessed. This would prevent
the case where pd_alloc_fn(..., GFP_NOWAIT) succeeds while the 
corresponding blkg is being destroyed,
which could otherwise lead to a memory leak.
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 5e1a724a799a..439cafa98c92 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -573,6 +573,7 @@ static void blkg_destroy_all(struct gendisk *disk)
>          int count = BLKG_DESTROY_BATCH_SIZE;
>          int i;
>   
> +       mutex_lock(&q->blkcg_mutex);
>   restart:
>          spin_lock_irq(&q->queue_lock);
>          list_for_each_entry(blkg, &q->blkg_list, q_node) {
> @@ -592,7 +593,9 @@ static void blkg_destroy_all(struct gendisk *disk)
>                  if (!(--count)) {
>                          count = BLKG_DESTROY_BATCH_SIZE;
>                          spin_unlock_irq(&q->queue_lock);
> +                       mutex_unlock(&q->blkcg_mutex);
>                          cond_resched();
> +                       mutex_lock(&q->blkcg_mutex);
>                          goto restart;
>                  }
>          }
> @@ -611,6 +614,7 @@ static void blkg_destroy_all(struct gendisk *disk)
>   
>          q->root_blkg = NULL;
>          spin_unlock_irq(&q->queue_lock);
> +       mutex_unlock(&q->blkcg_mutex);
>   }
>   
>   static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
> @@ -1621,6 +1625,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   
>          if (queue_is_mq(q))
>                  memflags = blk_mq_freeze_queue(q);
> +
> +       mutex_lock(&q->blkcg_mutex);
>   retry:
>          spin_lock_irq(&q->queue_lock);
>   
> @@ -1682,6 +1688,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>          ret = 0;
>   
>          spin_unlock_irq(&q->queue_lock);
> +       mutex_unlock(&q->blkcg_mutex);
>   out:
>          if (queue_is_mq(q))
>                  blk_mq_unfreeze_queue(q, memflags);
> @@ -1696,6 +1703,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>          spin_lock_irq(&q->queue_lock);
>          blkcg_policy_teardown_pds(q, pol);
>          spin_unlock_irq(&q->queue_lock);
> +       mutex_unlock(&q->blkcg_mutex);
>          ret = -ENOMEM;
>          goto out;
>   }


