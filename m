Return-Path: <cgroups+bounces-2662-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126698ADBAF
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 03:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961D02827F7
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519B9134C6;
	Tue, 23 Apr 2024 01:51:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33CA134A8;
	Tue, 23 Apr 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837066; cv=none; b=hAhP/yv90HTWv8Wul13MCWX9cXk0u3VbaqkoLni8cbZJzUayRZbq0qPjGg9nkw1iqpJRqm66Ei2vtPcIMk2+ySkbCZbQR+96cDKuJhTnN2GBOQKd/BPgaNJWL+4+DQe2Uvv10TbKRYOmd2p58VhWovcBnHzoTlpyeSDB4iMqprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837066; c=relaxed/simple;
	bh=wzuhf0hawkcNBkeWH5LY2+F/ZJYzlObZ/lFVJeFgYAU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t3tD64gFmQTqcAa9ty31wgaqWZYubj6Lz3lXeRynpKucCbGOXD2D2tHXK0jEfFwJCSCOs5kbBJxVvOn4FgooosA6S4/QyhF6YNmYYkb3vMAgg7S9SQ+UzPdCIr4Z1q6+y1rhgx1igZr4cUMiuIiAul5fHeXbfbKT1mEPhr0Z5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNlSp5jcvz4f3mHG;
	Tue, 23 Apr 2024 09:50:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E83221A0175;
	Tue, 23 Apr 2024 09:50:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBECFCdm12jXKg--.14969S3;
	Tue, 23 Apr 2024 09:50:59 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
To: "tj@kernel.org" <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: =?UTF-8?B?5ZGo5rOw5a6H?= <zhoutaiyu@kuaishou.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
 <ea781ccc-c29e-894e-c54a-f44ea349edca@huaweicloud.com>
 <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>
 <fbf135e8-de16-8eb4-9ade-1b979a335e33@huaweicloud.com>
 <Ziag2TL_BqmTRK5D@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <283462e4-c2d7-8d70-bb0f-61db62a86e02@huaweicloud.com>
Date: Tue, 23 Apr 2024 09:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Ziag2TL_BqmTRK5D@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBECFCdm12jXKg--.14969S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryxJr4UGFWDAw1xXrWfuFg_yoW8Aw48p3
	W3Ja1xAr1jyrs7Gw1avw4UXa4FvwsxCrZ8JryrGry2kr98Ga4xtr4xJr4akFnIvFsYkw1j
	yFn3Xas5Wa95ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Tejun!

在 2024/04/23 1:39, tj@kernel.org 写道:
> Hello, Yu Kuai.
> 
> On Mon, Apr 22, 2024 at 11:47:41AM +0800, Yu Kuai wrote:
>> Hi!
>>
>> 在 2024/04/22 11:33, 周泰宇 写道:
>>> What I want to do here was to set an easy to reach value to BPS_LIMIT (10M/s in this example) and an unable to reach value to IOPS_LIMIT (100000 in this example).
>>>
>>>
>>> Under this setting, the iostat shows that the bps is far less than 10M/s and sometimes is far larger than 10M/s.
>>
>> Yes, I know this behaviour, and this is because blk-throttle works
>> before IO split, and io stats is accounting bps for rq-based disk after
>> IO split, if you using Q2C for bps you'll see that bps is stable as
>> limit.
>>
>> Hi, Tejun！
>>
>> Do you think this *phenomenon* need to be fixed? If so, I don't see a
>> easy way other than throttle bio after *IO split*. Perhaps ohter than
>> bio merge case, this can be another motivation to move blk-throttle to
>> rq_qos_throttle().
> 
> Yeah, blk-throtl is sitting too early in the pipeline to easily track how
> the bios actually get issued. However, given that it's been available for
> bio-based drivers for a really long time, I don't think it'd be a good idea
> to move it, so iops limit is always going to be a bit unreliable w.r.t. what
> actually get issued to the device. So, IMHO, if the oddity is just about how
> IOs are counted, I don't think it's a critical problem on its own.

Got it, and agreed. Consider that bps limit for Q stage is stable,
although iostat can observe bps higher or lower sometimes, overall it
should be accurate.

Hi, Zhoutaiyu,

If you really want to fix this, you must come up with a solution with
the respect of FIFO rules, breaking it like this patch is not something
we'll accept, breaking fairness and some other flaws.

Thanks,
Kuai

> 
> Thanks.
> 


