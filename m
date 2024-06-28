Return-Path: <cgroups+bounces-3439-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE591B580
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422901C21961
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BE91CFAF;
	Fri, 28 Jun 2024 03:34:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB11864C;
	Fri, 28 Jun 2024 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545678; cv=none; b=aacTKMNL7Ceh6RhbX8IuwlAL5ALMhmeoaknE21j9XoeJ76aao4gBdu9V7ftXPBqvJqb8KPMD6KrfRRPjE58iT4VTMfZGLsm4gmEdZpgYQZ1lJtbGm99sTVLVPCVJl13ovv2SYXWHnsyNOirn5hvRRbm80PTDniG4EYKN9J0Dz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545678; c=relaxed/simple;
	bh=6/RKlUp2gvVHc6BtNL7Ra0pEQmPGmmm4ZXbXIocCvjI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l4u9qtBqZFIVAYkGD2SYqhSV0XEu1bFoIenllbDcwfhcunvEg2bFrKxh7munH4ZhHrn6NSikRLJuTi+WHPGKdoewKTgmgA4DSKvJu1GzdQWk8Rm4ZxOVonyuQdTwbq/5/LWllafmXoAUHRQ52HSLu8WDmAVjNHlG6viL7LSHNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9Ldm6qk6z4f3kvv;
	Fri, 28 Jun 2024 11:34:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3388B1A058E;
	Fri, 28 Jun 2024 11:34:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP2 (Coremail) with SMTP id Syh0CgCXAYdIL35mX7Q0Ag--.48902S3;
	Fri, 28 Jun 2024 11:34:33 +0800 (CST)
Subject: Re: [PATCH v2] blk-throttle: fix lower control under super low iops
 limit
To: Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240618062108.3680835-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <19568a6b-66a8-bb93-7c8c-3b523972535a@huaweicloud.com>
Date: Fri, 28 Jun 2024 11:34:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240618062108.3680835-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAYdIL35mX7Q0Ag--.48902S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1ftrW3Ar13ArWDJw45trb_yoW8XrWfpF
	W3Kw4UCFsFqFn7KF43G3WayFy8C3y8Zr98J3s8Xr1ayr13CF1DKrn3CF4Yyw4IvFsa9FW0
	gr1ktas7Ar1UuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/06/18 14:21, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> User will configure allowed iops limit in 1s, and calculate_io_allowed()
> will calculate allowed iops in the slice by:
> 
> limit * HZ / throtl_slice
> 
> However, if limit is quite low, the result can be 0, then
> allowed IO in the slice is 0, this will cause missing dispatch and
> control will be lower than limit.
> 
> For example, set iops_limit to 5 with HD disk, and test will found that
> iops will be 3.
> 
> This is usually not a big deal, because user will unlikely to configure
> such low iops limit, however, this is still a problem in the extreme
> scene.
> 
> Fix the problem by making sure the wait time calculated by
> tg_within_iops_limit() should allow at least one IO to be dispatched.

Friendly ping ...
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v2:
>   - instead of extend thorlt_slice, extend wait time;
>   block/blk-throttle.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index c1bf73f8c75d..dc6140fa3de0 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -704,6 +704,9 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
>   
>   	/* Calc approx time to dispatch */
>   	jiffy_wait = jiffy_elapsed_rnd - jiffy_elapsed;
> +
> +	/* make sure at least one io can be dispatched after waiting */
> +	jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);
>   	return jiffy_wait;
>   }
>   
> 


