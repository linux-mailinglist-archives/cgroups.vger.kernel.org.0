Return-Path: <cgroups+bounces-13235-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531C5D22742
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 06:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A943026879
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 05:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2C22C15AC;
	Thu, 15 Jan 2026 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JazgTWl2"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E828CF77;
	Thu, 15 Jan 2026 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768455866; cv=none; b=epHudpc2EqMuCjZ3P5Q5fZ26dQxLUuQLO/Id51DFjerWbqVIp/XbNNCRfBs9s5I8HCFdxHb1RdyMt2PKVLK+xae2BQl8zYC88zde4MCNUMI5OHcW3jBxQwdx6bEuf3wzKKZEvYfd8ZNcZBavOhiltdYuuJQOjB88k93Kz/K1CFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768455866; c=relaxed/simple;
	bh=+2Xr+QVU5EHdw9RUdnIE0Pp3V7kJaLV/sC2sfAeTaMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sMutQffi2SxdYypg/HYWLrdR+qYbBamICo9NstWIftUG3bSSO3pfeP1Ih0eciGNo1BuFUcOH80lN7uuQAfmTvejfFn8YyftEapuQ0kX9yvKYm5nQE6/ljLLgwwqF1XneB4tlXC0/FFRlq55Gsso4lS0YDRpGbZFBwsOLJwBMPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JazgTWl2; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yfSxkx0+G5w6qup/JbuydzWZnFxw4o74pcA7oS4Kb+0=;
	b=JazgTWl2ShyJeC7wTNhP6PpCUQxNn5pA8/oLOyVF0s/78U3pZbeL/frjZDDNjOIJ0KZHbEy3i
	Y+Qj45Bm/LR+Id3GgdCvqYMuKp/MRwPhHvR/m+4/btUEU6dK3sq0pDkE8GT5nFzqc4OxsjitA6z
	ztp96kWxa6oy1LTjtL/gZFs=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dsBfz0LXHz12LD3;
	Thu, 15 Jan 2026 13:41:15 +0800 (CST)
Received: from kwepemh100003.china.huawei.com (unknown [7.202.181.85])
	by mail.maildlp.com (Postfix) with ESMTPS id C006040363;
	Thu, 15 Jan 2026 13:44:14 +0800 (CST)
Received: from [10.174.178.72] (10.174.178.72) by
 kwepemh100003.china.huawei.com (7.202.181.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 15 Jan 2026 13:44:13 +0800
Message-ID: <3ec605aa-dd61-46eb-bcb6-282b482b90ea@huawei.com>
Date: Thu, 15 Jan 2026 13:44:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation and
 blkg destruction
To: <yukuai@fnnas.com>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mkoutny@suse.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <tj@kernel.org>,
	<josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@infradead.org>, Zheng Qixing
	<zhengqixing@huawei.com>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
 <20260113061035.1902522-2-zhengqixing@huaweicloud.com>
 <b004989f-900f-447f-a931-93c91082ca63@fnnas.com>
From: Zheng Qixing <zhengqixing@huawei.com>
In-Reply-To: <b004989f-900f-447f-a931-93c91082ca63@fnnas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100003.china.huawei.com (7.202.181.85)

>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 3cffb68ba5d8..600f8c5843ea 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1596,6 +1596,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>>    
>>    	if (queue_is_mq(q))
>>    		memflags = blk_mq_freeze_queue(q);
>> +
>> +	mutex_lock(&q->blkcg_mutex);
>>    retry:
>>    	spin_lock_irq(&q->queue_lock);
>>    
>> @@ -1658,6 +1660,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>>    
>>    	spin_unlock_irq(&q->queue_lock);
>>    out:
>> +	mutex_unlock(&q->blkcg_mutex);
>>    	if (queue_is_mq(q))
>>    		blk_mq_unfreeze_queue(q, memflags);
>>    	if (pinned_blkg)
> Can you also protect blkg_destroy_all() will blkcg_mutex as well? Then all access for q->blkg_list will
> be protected.
Why does blkg_destroy_all() also need blkcg_mutex?

After finishing ->pd_offline_fn() for blkgs and scheduling 
blkg_free_workfn() in blkg_destroy(),
blkg_destroy_all() clears the corresponding policy bit in q->blkcg_pols 
to avoid duplicate policy
teardown in blkcg_deactivate_policy().



