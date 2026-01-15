Return-Path: <cgroups+bounces-13240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22BD2374D
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 10:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB6973042DA3
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D58333752;
	Thu, 15 Jan 2026 09:22:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE233FE12;
	Thu, 15 Jan 2026 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468944; cv=none; b=tL8qsqtCj+I53zLS8rpOLPG3xeBAXFkfovROhJiQ5tN9isXZVGmij2MrWVSFbUsYYP60YWXMs80QUjC+asEAa+TVnqbrQ6TPfZRK2fcYc7QmqZ9llwVkJlOaask/vRbgQVWcLWk5J340MvyAN7s9OK2C+kDtfdkM09BFxsGsCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468944; c=relaxed/simple;
	bh=bYa1IO7G8wpbljLg/01e+Wci3w/MMDpVcOldCC7TMxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTxzTrReXEAaMn7lIs7v0dBNdzBgWE7HuJcfnsxA+d/AndkSWVaL/HbyET5UZCOG63Pd+R86MZ+WdG+8Q1hXCAiyRe1m85Ea7MOxtfpCo2lIyZ43vKbVS5XTeF7OuChvSBmNuNfSr250tNbA2jAoMAjJpdGM6TnKvNmmoxRti+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dsHYk1tgszYQv3l;
	Thu, 15 Jan 2026 17:22:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 685FB40595;
	Thu, 15 Jan 2026 17:22:17 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgBHqPjHsWhpF4+EDw--.7204S3;
	Thu, 15 Jan 2026 17:22:17 +0800 (CST)
Message-ID: <78362ecd-3f80-471f-8e08-e487f0792c11@huaweicloud.com>
Date: Thu, 15 Jan 2026 17:22:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] blk-cgroup: skip dying blkg in
 blkcg_activate_policy()
To: yukuai@fnnas.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, mkoutny@suse.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, houtao1@huawei.com, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
 Zheng Qixing <zhengqixing@huawei.com>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
 <20260113061035.1902522-3-zhengqixing@huaweicloud.com>
 <50d63ff3-97ef-499f-961d-cf6766a8028b@fnnas.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <50d63ff3-97ef-499f-961d-cf6766a8028b@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHqPjHsWhpF4+EDw--.7204S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyDuF45Cw4xGrW7CrWUCFg_yoWfKrcE9a
	48A3sFvFWkZa9Ykrn0vF15XrZIk3yDXry29r9YqF97ta45JF4fAr43Cw17WF43Aa47Cry5
	urWqg3Z7Gr4SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzt
	xhDUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 600f8c5843ea..5dbc107eec53 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1622,9 +1622,10 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>>    			 * GFP_NOWAIT failed.  Free the existing one and
>>    			 * prealloc for @blkg w/ GFP_KERNEL.
>>    			 */
>> +			if (!blkg_tryget(blkg))
>> +				continue;
> So, why this check is still before the pd_alloc_fn()?
You mean 'after'?
> See blkg_destroy(), can you replace this by the same checking:
>
> list_for_each_entry_reverse()
> 	if (hlist_unhashed(&blkg->blkcg_node))
> 		continue;
> 	if (blkg->pd[pol->plid])
> 		continue;

This change makes sense.

This issue can be resolved by either doing tryget(blkg) before
pd_alloc_fn() or by accessing blkg->blkcg_node.

To keep the behavior consistent with blkg_destroy() and blkg_destroy_all(), I will revise this in v3.

Thank,

Qixing


