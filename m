Return-Path: <cgroups+bounces-2467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322888A3A4B
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 04:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59761F22248
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29025101D5;
	Sat, 13 Apr 2024 01:59:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B56D52F;
	Sat, 13 Apr 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973594; cv=none; b=WYw2iuPINSjBjWCkneWn7uukRpB0IbwPwnfcnvJwZlxqLt32YIqQyrtyX8jtJXQappStqtph5pA0U4Xqw0lXuFllIpnOEmspsFYTXUFuqdwBFyhEKNNJ0XYOQurO5Afb1m3sHFrluW6SdS8l+9v926NbTiIY0orNvC3+rEEHjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973594; c=relaxed/simple;
	bh=nnlDPjPKfEohwaKd9r81/1qp2ve/24ImVnOTGTeLfs0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gjtUGHB8wmIiB0osNQeeSHJJp5+F0DCyLLWIHJmajhc5z1R78CHVxK1Ueq1w+uA2V5FP33u6zUTQgWzvG+QWsF5Tfnfsj8cQiHdxKnEfeHmICJ82iflBwbLTqb2CTYbiJ1OsM3FtPhh9U9kLpRgrfIJOTDpFJDL1x43ROD36SeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VGc7h0fWvz4f3l95;
	Sat, 13 Apr 2024 09:59:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8E6AD1A0175;
	Sat, 13 Apr 2024 09:59:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBET5xlmKg1bJw--.20969S3;
	Sat, 13 Apr 2024 09:59:48 +0800 (CST)
Subject: Re: [PATCH RFC v2 2/6] blk-throttle: delay initialization until
 configuration
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
 jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, pctammela@mojatatu.com,
 qde@naccy.de, zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-3-yukuai1@huaweicloud.com>
 <Zhl2a2m3L3QEELtj@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7531ba77-964a-169d-f55f-a8dcfcdbb450@huaweicloud.com>
Date: Sat, 13 Apr 2024 09:59:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zhl2a2m3L3QEELtj@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBET5xlmKg1bJw--.20969S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKr1rtF4xGFykXw18ZrWDArb_yoW8Jr4fpa
	y5Xa98tF4kXrZag3srZw1fZF9akr4xAFy8C3s8KrW5JF42vr4rKFnYg34YyF4fAF1I9r42
	va18Grn8G3Wvka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/13 1:59, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Sat, Apr 06, 2024 at 04:00:55PM +0800, Yu Kuai wrote:
>> @@ -1480,6 +1547,9 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>>   	struct cgroup_subsys_state *pos_css;
>>   	struct blkcg_gq *blkg;
>>   
>> +	if (!q->td)
>> +		return;
> 
> So, this naked test is safe because the interface functions are shut down by
> the time this function is called.
> 
>>   static inline bool blk_should_throtl(struct bio *bio)
>>   {
>> -	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>> +	struct throtl_grp *tg;
>>   	int rw = bio_data_dir(bio);
>>   
>> +	if (!bio->bi_bdev->bd_queue->td)
>> +		return false;
> 
> and this one because ->td is set while the queue is frozen and this path
> shouldn't be running while it gets set, right?

Yes, this is called under bio_queue_enter()
> 
> Can you please add comments explaining why those are safe? Otherwise, the
> patch looks generally sane to me on the first glance. Can you please also
> add how you tested the change?

And I realized that there are no tests for bkl-throttle from blktests,
and I'm using some other tests from our testers to cover basic
functionality. Perhaps will it make sense to add some tests to blktests?

Thanks,
Kuai

> 
> Thanks.
> 


