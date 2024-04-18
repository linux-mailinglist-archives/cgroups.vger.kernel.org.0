Return-Path: <cgroups+bounces-2583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60928A99AC
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AA11F226F7
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501915F405;
	Thu, 18 Apr 2024 12:22:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452315D5D6;
	Thu, 18 Apr 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442922; cv=none; b=RLCVsceEVS5bP3qYNRXUDrUDL8WunkIY1k7XRd2bslEffsL53YSc73qGnO7vAic1uc6vTaS3xEwP4l7N1JOoXWAIrtn1QsuB/JdmxZhN8QyNohuQIjzBfofC7DdyyzfPD6Kzb2cAhMdCgQGBvrLb6G+CyXWGRBcROWZDzd5pXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442922; c=relaxed/simple;
	bh=PKFSX9CcoLcO4YzC9BdJPuOUBdQy9VE5vwvKjPYtrUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXGOhH0S+0YWka33BYsBC0rd3qZ+fKfUSUcmSVaX4+0UXWdjE5A07+HhI3BcnR1Y81lWMLUI7XAR2QqA4pYYr4dhZEev9PGjHiEdVCz4sxUdJv8LbpFD8ACSRiIM16zcjUKtH6zkD3fPKKA0KW2W/7mLdjKWTc5X4CeyFimf3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VKxjB70BDz4f3k6G;
	Thu, 18 Apr 2024 20:21:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9F4221A0572;
	Thu, 18 Apr 2024 20:21:55 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw5hECFmjeUnKg--.20914S3;
	Thu, 18 Apr 2024 20:21:55 +0800 (CST)
Message-ID: <f9a65bb0-70ce-f79f-916d-0dddfd88f9e9@huaweicloud.com>
Date: Thu, 18 Apr 2024 20:21:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-iocost: do not WARNING if iocg has already offlined
To: Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
 tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: hch@lst.de, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240418072340.2090877-1-linan666@huaweicloud.com>
 <75a8212a-a6ff-416c-7bce-0f4036a4abc0@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <75a8212a-a6ff-416c-7bce-0f4036a4abc0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHaw5hECFmjeUnKg--.20914S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1xJFW5Zr13tryxGFWxJFb_yoWfXFbEy3
	Wvywn7KrnrtayI9anYyws0qws3CayYkay0qwn5XwnxZ3WftFWDGFs3Gr98X3Z8Ca9xG3Wa
	kFyqqF42yw4akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/4/18 16:52, Yu Kuai 写道:
> 
> 
> 在 2024/04/18 15:23, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
>> is intended to confirm iocg is avitve when it has debt. However, warn
>> can be triggered during removing cgroup controller, as
>> iocg_waitq_timer_fn() is awakened at that time.
>>
>>    WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 
>> iocg_pay_debt+0x14c/0x190
> 
> This line doesn't match the code from mainline, please mention that
> which kernel release you're testing.
> 

Thanks for your review.
I tested at 5.10, but mainline has the same issue.

> Other than that, ioc_pd_free() indeed clear 'active_list' before
> canceling the timer, this patch looks good to me.
> 
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

-- 
Thanks,
Nan


