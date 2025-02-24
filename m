Return-Path: <cgroups+bounces-6652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D07CA415C8
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 08:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F79D3B5C99
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772E241668;
	Mon, 24 Feb 2025 07:03:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EB1A5B81;
	Mon, 24 Feb 2025 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380608; cv=none; b=jMEZjkZQ3eUVS0Hi7mskReL1urtD8kyWKk2b7H/i3mH2dMJKNFyCxaopHKj2aVoOFrqhI+2WmTM+Uz61gprDuKxdBtB35fEx+e03wllFibc3ZePE1Yo1kh4gqhlI/Wv+ikqDP/2frk7vEjgyH3lQIDKdxtbK0vtYJgFdXV/+p+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380608; c=relaxed/simple;
	bh=gAatAcowxA6N32Br3D/yFWKOY7JZvCY0MRpVyrJYcrw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Saxhhse1pCI5BMdQX7CR9dkI9IRayC17je7GQ/40U0X67G7pSP+1Eax8mTWhMnvCJjZoozRpj6ykl28iW0E/AAp6Vqrw/yymVpoo8pRNObaktmQmYUiOvRpUYRCPUbfJ486JpyELuaImhnD5sj1yJozk/IJSv1TCzJOTKjGI/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z1WsF5vFcz4f3kvl;
	Mon, 24 Feb 2025 15:02:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 055E61A058E;
	Mon, 24 Feb 2025 15:03:21 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCH61+3GbxnZ6L5Eg--.46097S3;
	Mon, 24 Feb 2025 15:03:20 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
Date: Mon, 24 Feb 2025 15:03:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7vnTyk6Y6X4JWQB@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61+3GbxnZ6L5Eg--.46097S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF47Kw13JryDAFyrtFWkZwb_yoW8urWkpF
	WakFW3Kw4DAFyIkF1rZa18XFWYkrWxArnrJw45Jr95A34UWFyjgFWvyrs0yay5X3Z7W34I
	v3Wjva47AF4jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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

在 2025/02/24 11:28, Ming Lei 写道:
> throtl_trim_slice() returns immediately if throtl_slice_used()
> is true.
> 
> And throtl_slice_used() checks jiffies in [start, end] via time_in_range(),
> so if `start <= jiffies <= end', it still returns false.

Yes, I misread the code, by thinking throtl_slice_used() will return
true if the slice is still used. :(


>> BTW, throtl_trim_slice() looks like problematic:
>>
>> -       if (bytes_trim <= 0 && io_trim <= 0)
>> +       if (bytes_trim <= 0 || io_trim <= 0 ||
>> +           tg->bytes_disp[rw] < bytes_trim || tg->io_disp[rw] < io_trim)
>>                  return;
> That is exactly what my patch is doing, just taking deviation and
> timeout into account, also U64_MAX limit has to be excluded.
Yes, perhaps you can add some comments in the last two conditions of
your patch. I think maybe you're concerned about the case IO is
throttled by IOs and bytes_disp should really erase extra bytes that
does not reach bps_limit.

> 
> If you test the patch, it works just fine. My patch controls bytes_exp
> <= 1.5 * disp, then throtl/001 can be completed in 1.5sec, and if it is
> changed to 1.25 * disp, the test can be completed in 1.25sec.
> 
> With this fix, why do we have to play the complicated carryover
> trick?
> 

I understand your code now. carryover_bytes in this case is wrong, as
long as new slice is not started, and trim slice doesn't erase extra
bytes by mistake, throttle time should be accurate over time because
bytes_disp is accurate.

And root cause really is throtl_trim_slice().

However, by code review, I think throtl_start_new_slice() should be
handled as well, the same as throtl_trim_slice(), if the old bio is
dispatched with one more jiffies wait time, issue a new bio in the same
jiffies will have the same problem. For example:

Caller do sync IO, with io size: (bps_limit / (HZ / throtl_slice) + 1),
and caller will issue new IO when old IO is done. Then in this case,
each IO will start a new slice and wait for throtl_slice + 1 jiffies. I
believe this can be fixed as well so that BIOs after the first one will
only wait for throtl_silce jiffies.

> Thanks,
> Ming
> 
> 
> .
> 


