Return-Path: <cgroups+bounces-3435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA991B558
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 05:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909171C21C0D
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 03:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129631C6A4;
	Fri, 28 Jun 2024 03:14:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11914277;
	Fri, 28 Jun 2024 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544457; cv=none; b=J8iKtvZCodkZCBC9O3CVc+9H4Jw9ygyfuksdQjcYOdfgqkzoXeTOaAk3J++nYUssKBd7M/37PLwB5x3MjS32yzssskTSvqASwajiqmvcHKixzoc4oT/7PvPma15Mz5HMiXrkELevDne9vlNqyu25hoe9n8eDYeUQ7T8XAp53rXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544457; c=relaxed/simple;
	bh=p73zFRFe8BwwOuJ6OMG41rHa6cFeVxYFp2tdGWNRmwk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gLG5krHHpKhdtJjpmOiMfsBc0FWimZ3oWtF+oRLeX381knUhM/g2RgZqLf8ICJu4JL2XDrsM0JNdVjfc6B68WC8TA9FIRRnHcJX5PXCI4z4ezbkdrPcYpWaxw6Kk2OxOFcznCc4KewtwqySUFkk2mYPPdfK5ljBWuI8cRwa2YG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9LBM6TN6z4f3jYb;
	Fri, 28 Jun 2024 11:14:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 13B251A0199;
	Fri, 28 Jun 2024 11:14:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP2 (Coremail) with SMTP id Syh0CgB34YaAKn5mclozAg--.48443S3;
	Fri, 28 Jun 2024 11:14:10 +0800 (CST)
Subject: Re: [PATCH] blk-cgroup: don't clear stat in blkcg_reset_stats()
To: Tejun Heo <tj@kernel.org>, Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, longman@redhat.com,
 ming.lei@redhat.com, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yukuai1@huaweicloud.com,
 houtao1@huawei.com, yi.zhang@huawei.com, lilingfeng3@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
 <Zn3HHvcgZruLkMdn@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <97e5374a-d083-2602-f632-3de546458ac0@huaweicloud.com>
Date: Fri, 28 Jun 2024 11:14:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zn3HHvcgZruLkMdn@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YaAKn5mclozAg--.48443S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1rtF1rJw15CrykGFy5XFb_yoW5AFykpF
	Z5K3W3Aw4vqrWv9r17uw1IgFyFkws5t345XrZ8Gw45GF1UWr98tr1IyrWYya47CFyxKr17
	Xw4YkrZ5Zw4jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/06/28 4:10, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Thu, Jun 27, 2024 at 05:08:56PM +0800, Li Lingfeng wrote:
>> The list corruption described in commit 6da668063279 ("blk-cgroup: fix
>> list corruption from resetting io stat") has no effect. It's unnecessary
>> to fix it.
> 
> I find this paragraph a bit confusing. At the time, it was broken, right?
> And if we were to memset() now, it'd break again.
> 
>> As for cgroup v1, it does not use iostat any more after commit
>> ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup v1"), so using
>> memset to clear iostat has no real effect.
> 
> Ah, okay, this is because we made the stats blk-throtl specific but didn't
> implement ->pd_reset_stat_fn(), right?

I'm afraid not... Implement pd_reset_stat_fn() or not is another
problem, this patch should be just code cleanup, not fixing any real
problems.

> 
>> As for cgroup v2, it will not call blkcg_reset_stats() to corrupt the
>> list.
>>
>> The list of root cgroup can be used by both cgroup v1 and v2 while
>> non-root cgroup can't since it must be removed before switch between
>> cgroup v1 and v2.
>> So it may has effect if the list of root used by cgroup v2 was corrupted
>> after switching to cgroup v1, and switch back to cgroup v2 to use the
>> corrupted list again.
>> However, the root cgroup will not use the list any more after commit
>> ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup io.stat").
> 
> Hmm... I'm still having a bit of trouble following this line of argument
> given that all the patch does is dropping stat clearing.
> 
>> @@ -668,7 +645,6 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>>   	 * anyway.  If you get hit by a race, retry.
>>   	 */
>>   	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
>> -		blkg_clear_stat(blkg);
>>   		for (i = 0; i < BLKCG_MAX_POLS; i++) {
>>   			struct blkcg_policy *pol = blkcg_policy[i];
> 
> The patch looks fine to me although it'd be nice to follow up with a patch
> to implement ->pd_reset_stat_fn() for blk-throtl. I'm not quite following
> the list corruption part of argument.

The code deleted by this patch was claimed to fix a lsit corruption,
however, the list corruption does not exist now hence related code can
be removed:

1) Take a look at blk_cgroup_bio_start, now there are two conditions
before this blkg can be added to the per_cpu list:

blk_cgroup_bio_start
  if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
  -> the list will always be empty for cgroup v1
   return;
  if (!cgroup_parent(blkcg->css.cgroup))
  -> the list will always be empty for root blkg
   return;
  ...
  llist_add()

2) blkcg_reset_stats can only be called from cgroup v1 api, hence
there is nothing to be cleared for blkg_clear_stat();

3) Noted that user can switch from cgroup v2 to v1, however, we found
that user must delete all the child cg to do that, hence only root blkg
can be kept after switching to v1. And root blkg is bypassed from
blk_cgroup_bio_start(), hence no problem.

Thanks,
Kuai
> 
> Thanks.
> 


