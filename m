Return-Path: <cgroups+bounces-4369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB9957F32
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 09:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48801F21E95
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31841C62;
	Tue, 20 Aug 2024 07:15:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01A18E37F;
	Tue, 20 Aug 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138117; cv=none; b=rgiwiwcmz9iU6i0lWMpcacXoBQrp8j0PHqOjLHiqRTs0YqhpKHKFHqTdZEMSVFscc0D4lv30ZGqKWb7i2ydja01I7A/XFjtCo/V3wkyIWnlmaeloUFOgYSXKPFzgrO9BApf4DhuBNd1BkhXFeNFP+Wr4BWU40YDCIuKFjHRpIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138117; c=relaxed/simple;
	bh=L3pdmJ91dhND924Hc7k0yeVx7Sdn7wFJLytIERkF50w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQMinqdXIxuaTloX/U9L5E6MBP1MM4eo06vDbIuO0Zdk8O5TXJMwSqUSYCMC7laoGBBVYo21Bi2hq8KRP6pr36arXNSF+aVvsBEbMWkw0lvY9I45gjEBro8GDsXuT6qWmjCDSvLTHqzH18LwXTzkMaBpHBUz7iINnootBD/blNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wp11x5XTsz4f3jYx;
	Tue, 20 Aug 2024 15:15:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5EDF81A018D;
	Tue, 20 Aug 2024 15:15:11 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4V+QsRmnCnNCA--.30389S3;
	Tue, 20 Aug 2024 15:15:11 +0800 (CST)
Message-ID: <9852111b-cbb2-bb39-652c-5e56f28bd991@huaweicloud.com>
Date: Tue, 20 Aug 2024 15:15:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] blk-cgroup: don't clear stat in blkcg_reset_stats()
To: Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc: josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, longman@redhat.com,
 ming.lei@redhat.com, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yi.zhang@huawei.com, lilingfeng3@huawei.com, "yukuai (C)"
 <yukuai3@huawei.com>
References: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
 <Zn3HHvcgZruLkMdn@slm.duckdns.org>
 <97e5374a-d083-2602-f632-3de546458ac0@huaweicloud.com>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <97e5374a-d083-2602-f632-3de546458ac0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4V+QsRmnCnNCA--.30389S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fZr4DZr1UtrWkCFy5XFb_yoW5urW7pF
	Z5K3Wak3yktryvkr12gw1IgFyFkws5t345Jry5J3WfGr1UWr90qr4IvrZ09a4UCFWxKr1U
	Xr4YyrZ5Zw4Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

Friendly ping ...

Thank.

在 2024/6/28 11:14, Yu Kuai 写道:
> Hi,
>
> 在 2024/06/28 4:10, Tejun Heo 写道:
>> Hello,
>>
>> On Thu, Jun 27, 2024 at 05:08:56PM +0800, Li Lingfeng wrote:
>>> The list corruption described in commit 6da668063279 ("blk-cgroup: fix
>>> list corruption from resetting io stat") has no effect. It's 
>>> unnecessary
>>> to fix it.
>>
>> I find this paragraph a bit confusing. At the time, it was broken, 
>> right?
>> And if we were to memset() now, it'd break again.
>>
>>> As for cgroup v1, it does not use iostat any more after commit
>>> ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup v1"), so using
>>> memset to clear iostat has no real effect.
>>
>> Ah, okay, this is because we made the stats blk-throtl specific but 
>> didn't
>> implement ->pd_reset_stat_fn(), right?
>
> I'm afraid not... Implement pd_reset_stat_fn() or not is another
> problem, this patch should be just code cleanup, not fixing any real
> problems.
>
>>
>>> As for cgroup v2, it will not call blkcg_reset_stats() to corrupt the
>>> list.
>>>
>>> The list of root cgroup can be used by both cgroup v1 and v2 while
>>> non-root cgroup can't since it must be removed before switch between
>>> cgroup v1 and v2.
>>> So it may has effect if the list of root used by cgroup v2 was 
>>> corrupted
>>> after switching to cgroup v1, and switch back to cgroup v2 to use the
>>> corrupted list again.
>>> However, the root cgroup will not use the list any more after commit
>>> ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup 
>>> io.stat").
>>
>> Hmm... I'm still having a bit of trouble following this line of argument
>> given that all the patch does is dropping stat clearing.
>>
>>> @@ -668,7 +645,6 @@ static int blkcg_reset_stats(struct 
>>> cgroup_subsys_state *css,
>>>        * anyway.  If you get hit by a race, retry.
>>>        */
>>>       hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
>>> -        blkg_clear_stat(blkg);
>>>           for (i = 0; i < BLKCG_MAX_POLS; i++) {
>>>               struct blkcg_policy *pol = blkcg_policy[i];
>>
>> The patch looks fine to me although it'd be nice to follow up with a 
>> patch
>> to implement ->pd_reset_stat_fn() for blk-throtl. I'm not quite 
>> following
>> the list corruption part of argument.
>
> The code deleted by this patch was claimed to fix a lsit corruption,
> however, the list corruption does not exist now hence related code can
> be removed:
>
> 1) Take a look at blk_cgroup_bio_start, now there are two conditions
> before this blkg can be added to the per_cpu list:
>
> blk_cgroup_bio_start
>  if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
>  -> the list will always be empty for cgroup v1
>   return;
>  if (!cgroup_parent(blkcg->css.cgroup))
>  -> the list will always be empty for root blkg
>   return;
>  ...
>  llist_add()
>
> 2) blkcg_reset_stats can only be called from cgroup v1 api, hence
> there is nothing to be cleared for blkg_clear_stat();
>
> 3) Noted that user can switch from cgroup v2 to v1, however, we found
> that user must delete all the child cg to do that, hence only root blkg
> can be kept after switching to v1. And root blkg is bypassed from
> blk_cgroup_bio_start(), hence no problem.
>
> Thanks,
> Kuai
>>
>> Thanks.
>>
>


