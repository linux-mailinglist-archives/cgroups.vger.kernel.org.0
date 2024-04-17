Return-Path: <cgroups+bounces-2556-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FE8A7A33
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 03:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E21283D35
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129EE1C02;
	Wed, 17 Apr 2024 01:39:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285AA47;
	Wed, 17 Apr 2024 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317992; cv=none; b=oHt6T2Fr94L1E9ls/q8hVE/yrNr7Xkc5EgTgOj+QJqCK3DvUOLpXRAtS4Oyv6ydTgGH3s9ZBUSqxPynpbD5L/kl6CxrT/WSKUJEzsrqpl9bDc6ixc5873tHP5xscsLPLBY74TLD6QGZPuP7t6Snbg3DjXTkJSQElM5cdzSGgCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317992; c=relaxed/simple;
	bh=vUkyGPXH/WxKh8Mk0phahzeyUfhPSs5vaQQASy0FhlQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o3MpojJ2p7fkWkV+0eQ3wdHWdTaTRjHiVJw5U0ayW+NTOxhDTXOtGG69STIFzRB6LciEoxK1hp8GW9lw5lMS2F8F9umc+W6R/VOeUUfmAdtoMQY151BTCpB10wSnR+SnuoMbgtD3/WngHGLP9SbRf8eOxNmTbZ3vqartbTcJZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VK3Vf1s6Gz4f3kjK;
	Wed, 17 Apr 2024 09:39:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 650AF1A0568;
	Wed, 17 Apr 2024 09:39:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5fKB9mO6K9KA--.49490S3;
	Wed, 17 Apr 2024 09:39:45 +0800 (CST)
Subject: Re: [PATCH RFC v2 5/6] blk-throttle: support to destroy throtl_data
 when blk-throttle is disabled
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
 jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, pctammela@mojatatu.com,
 qde@naccy.de, zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-6-yukuai1@huaweicloud.com>
 <Zhl37slglnnTSMO7@slm.duckdns.org>
 <1bb85208-1224-77dc-f0b2-7b7a228ef70b@huaweicloud.com>
 <Zh6wx4mXZy_EOViH@slm.duckdns.org>
 <19086c09-3060-a4ce-4ac6-811a29653979@huaweicloud.com>
 <Zh8kPGAu2TG4Su2M@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1ed63126-d2e6-f0b6-42ef-127ecb464955@huaweicloud.com>
Date: Wed, 17 Apr 2024 09:39:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zh8kPGAu2TG4Su2M@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5fKB9mO6K9KA--.49490S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7tr17Gw1UKFWDJrW5ZFb_yoW8Cw45pF
	W2qayrAr1kuF95Can7Aw48Wr4Syry3J3y5Jr95K342v345uryfZF1aqF45uay3Za1DWF10
	va17X347Can8Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/17 9:22, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Wed, Apr 17, 2024 at 09:13:34AM +0800, Yu Kuai wrote:
>>> Probably a better interface is for unloading to force blk-throtl to be
>>> deactivated rather than asking the user to nuke all configs.
>>
>> I was thinking that rmmod in this case should return busy, for example,
>> if bfq is currently used for some disk, rmmod bfq will return busy.
>>
>> Is there any example that unloading will deactivate resources that users
>> are still using?
> 
> Hmm... yeah, I'm not sure. Pinning the module while in use is definitely
> more conventional, so let's stick with that. It's usually achieved by
> inc'ing the module's ref on each usage, so here, the module refs would be
> counting the number of active rules, I guess.

Yes, aggred.
> 
> I'm not sure about modularization tho mostly because we've historically had
> a lot of lifetime issues around block and blkcg data structures and the
> supposed gain here is rather minimal. We only have a handful of these
> policies and they aren't that big.
> 
> If hot path overhead when not being used is concern, lazy init solves most
> of it, no?

For performance, yes. Another point is that we can reduce kernel size
this way, without losing support for blk-cgroup policies.

Yes, it's just blk-throttle is the most pain in the ass becasue it
exposed lots of implementations to block layer. Other rq_qos based
policy should be much easier.

I guess I'll do lazy init first, and then modularization for rq_qos,
and leave blk-throtl there for now. Perhaps add a new throtl model in
iocost can replace blk-throtl in the future.

BTW, currently during test of iocost, I found that iocost can already
achieve that, for example, by following configure:

echo "$dev enable=1 min=100 max=100" > qos
echo "$dev wbps=4096 wseqiops=1 wrandiops=1" > model

In the test, I found that wbps and iops is actually limited to the
set value.

Thanks,
Kuai

> 
> Thanks.
> 


