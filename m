Return-Path: <cgroups+bounces-2580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC428A955B
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86C628262F
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321D15886B;
	Thu, 18 Apr 2024 08:52:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB42E403;
	Thu, 18 Apr 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430352; cv=none; b=EQXAVFi36fX0OKKV1liKFvEUehO17aG/Uj7tcPeND2ImLAJVg+Y1QXXcIIvTBoS19dUJcySe9hLHGkIYWxLlmnjYOoKIfeJJBVs/H1yzUasn+2Cy89lpoonGgyVIz1TohLHEowEi5fu//MjPj6gpFHi8atphpF+b4B3uxpB2V8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430352; c=relaxed/simple;
	bh=/9FaQAMTMG4Df8jyveTTcRCul4tuZb79MWaz9DUKm8g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h4zD6ihhOp6jStYyK+D/OUOTFNlR4qDlQRQX45AMp33t9LY4hFsgxvYXoKmF7Ut7QGXz2NILFyn5GOniXfYcj91OJrbYTXe4wMdDPAzKx5d8xck1tlCnyq75zKS4KFoAjQHsnnmNOTbQHAzW5nGH8iJzZZAwhcrYmkAtjcsTz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VKs3P2grlz4f3p0g;
	Thu, 18 Apr 2024 16:52:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 527981A0568;
	Thu, 18 Apr 2024 16:52:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g5I3yBmNfwuKQ--.33271S3;
	Thu, 18 Apr 2024 16:52:26 +0800 (CST)
Subject: Re: [PATCH] blk-iocost: do not WARNING if iocg has already offlined
To: linan666@huaweicloud.com, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk
Cc: hch@lst.de, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240418072340.2090877-1-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <75a8212a-a6ff-416c-7bce-0f4036a4abc0@huaweicloud.com>
Date: Thu, 18 Apr 2024 16:52:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418072340.2090877-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g5I3yBmNfwuKQ--.33271S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17Gw13KFW7Wr4Uury5CFg_yoW8Zw1DpF
	45KwnrCF1jqr12kan2q3Z2q348uan5Xws3Jws3Wr15ZFyfur1Iq3Wkur4YqFy0vrn5AFsx
	ZF4xK3yxJa1UuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/



ÔÚ 2024/04/18 15:23, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
> is intended to confirm iocg is avitve when it has debt. However, warn
> can be triggered during removing cgroup controller, as
> iocg_waitq_timer_fn() is awakened at that time.
> 
>    WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190

This line doesn't match the code from mainline, please mention that
which kernel release you're testing.

Other than that, ioc_pd_free() indeed clear 'active_list' before
canceling the timer, this patch looks good to me.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>    Call trace:
>    iocg_pay_debt+0x14c/0x190
>    iocg_kick_waitq+0x438/0x4c0
>    iocg_waitq_timer_fn+0xd8/0x130
>    __run_hrtimer+0x144/0x45c
>    __hrtimer_run_queues+0x16c/0x244
>    hrtimer_interrupt+0x2cc/0x7b0
> 
> The warn in this situation is meaningless. Since this iocg is being
> removed, the state of the 'active_list' is irrelevant, and 'waitq_timer'
> is canceled after removing 'active_list' in ioc_pd_free(), which ensure
> iocg is freed after iocg_waitq_timer_fn() returns.
> 
> Therefore, add the check if iocg has already offlined to avoid warn
> when removing cgroup controller.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/blk-iocost.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index baa20c85799d..2e109c016a39 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1440,7 +1440,7 @@ static void iocg_pay_debt(struct ioc_gq *iocg, u64 abs_vpay,
>   	lockdep_assert_held(&iocg->waitq.lock);
>   
>   	/* make sure that nobody messed with @iocg */
> -	WARN_ON_ONCE(list_empty(&iocg->active_list));
> +	WARN_ON_ONCE(list_empty(&iocg->active_list) && iocg->pd.online);
>   	WARN_ON_ONCE(iocg->inuse > 1);
>   
>   	iocg->abs_vdebt -= min(abs_vpay, iocg->abs_vdebt);
> 


