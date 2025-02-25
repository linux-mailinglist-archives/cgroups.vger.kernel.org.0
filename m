Return-Path: <cgroups+bounces-6702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E069AA4336D
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 04:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D44189BF5C
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294D2144AD;
	Tue, 25 Feb 2025 03:12:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326A2135BC;
	Tue, 25 Feb 2025 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453155; cv=none; b=j0dMcgLyGy1cIDV1MKqgnHuFTiF811pg50DjPf7DAWQRgXMaXdE43l76HX0Ra56HPnXFwwQztmW7aJwO8v/ssUvBEmzrqzyYqNxAMTd/3AhOmi6yLTk5L0cIHeywBHrojZnai0DmjKCvjHS0310zQyd44rH5aazA80+P54fJufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453155; c=relaxed/simple;
	bh=kjl+s6sWQ2AJgnYEcm8bFURklJKF/fJp4g1rYKQXWyM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d4SSGtO727oXmgL6sOdPsf3QgDL5RgjnICGK/4NzDbKYYXZlhoOe+SXe2F39XU37zLa6qMis54WjoWF4SccPB68ffIJfHmgf8zizQcrhLurXtARbrScZz0mYP+EYadqBB7A1bMqRw4zE5qHmW6JYda7IMuptoiVwjEBvhkPOUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z22hM5wt8z4f3kvf;
	Tue, 25 Feb 2025 11:12:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0FD1C1A0DCC;
	Tue, 25 Feb 2025 11:12:27 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGAZNb1nh_xKEw--.65158S3;
	Tue, 25 Feb 2025 11:12:26 +0800 (CST)
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com> <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
 <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
 <Z7w0P8ImJiZhRsPD@fedora>
 <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
 <Z70btzRaN83FbTJp@fedora>
 <8473fca2-16ab-b2a6-ede7-d1449aa7d463@huaweicloud.com>
 <Z70qvZEBdq6L3-Yb@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <084e25a1-5ed7-3097-5bae-b87addeaf01f@huaweicloud.com>
Date: Tue, 25 Feb 2025 11:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z70qvZEBdq6L3-Yb@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGAZNb1nh_xKEw--.65158S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr13Zw13Aw48uFWfCr4DJwb_yoWkXFX_uF
	9xJwn3Cwn8CFn7uF4YkFy8K3y7Xr1Svry8C3yfGry7Z34IqFs7Z3WxGasa9ry2qa93X3Z0
	vFn8AF1xGFn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Ming!

在 2025/02/25 10:28, Ming Lei 写道:
> Can you explain in details why it signals that the rate is expected now?
> 
> If rate isn't expected, it will cause trouble to trim, even just the
> previous part.

Ok, for example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
slice is 20ms(2 jiffies).

expected rate is 1000 / 1000 * 20 = 20 bytes per slice.

If user issue two 21 bytes IO, then wait time will be 30ms:

bytes_allowed = 20, extra_bytes = 1;
jiffy_wait = 1 + 2 = 3 jiffies

and consider
extra 1 jiffies by timer, throtl_trim_slice() will be called at:

jiffies = 40ms
slice_start = 0ms, slice_end= 40ms
bytes_disp = 21

In this case, before the patch, real rate in the first two slice is is
10.5 bytes per slice, and slice will be updated:

jiffies = 40ms
slice_start = 40ms, slice_end = 60ms,
bytes_disp = 0;

Hence the second IO will have to wait another 30ms;

With the patch, the real rate in the first slice is 20 bytes per slice,
which is the same as expected, and slice will be updated:

jiffies=40ms,
slice_start = 20ms, slice_end = 60ms,
bytes_disp = 1;

And now, the second IO will only have to wait 10ms;

Thanks,
Kuai


