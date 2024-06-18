Return-Path: <cgroups+bounces-3227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11690C6C1
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 12:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5A71C21D79
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F67813D8A0;
	Tue, 18 Jun 2024 07:59:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70267347F;
	Tue, 18 Jun 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697551; cv=none; b=lt687fAYmY//dwOZLXvY08hLxMDtO3Hua3UI7SW2RPYpN2T/HsIWFq3yzDx0z8GtjZrI4izGWBnviulZ3pZWpP4maqWv73TvVYthqcAwW1l46Q2dtT/0CXoFXb8rFcGDvRMF8IQkf8iNSw6hztVOqtjAseMsREICcI+DJ8dau6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697551; c=relaxed/simple;
	bh=Y90ifYr0ogOPuVwNY5g4IUYWfNDBVn0dzH4lh3TC8fg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Md9HizLN6tNe0hMyyRjsWyf/S/sqjP5z8dIkbJesX8eJIBNvVNQ6fg4eLfV1R06sr8bqwmbF3vqrddhLc9sQwogFtDt+R+J2nOcYAkahSz/ui8LDE6E0YKbkh1bnByAPbQHGzDot141GuuCZPIXguhwbpRuw6cAIq4AJ/xUA7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3Jzc2t3rz4f3jHh;
	Tue, 18 Jun 2024 15:58:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 269691A0181;
	Tue, 18 Jun 2024 15:59:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCH8A0_PnFmUyQPAQ--.23034S3;
	Tue, 18 Jun 2024 15:59:03 +0800 (CST)
Subject: Re: [PATCH RFC v2 3/7] block: export some API
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, gregkh@linuxfoundation.org,
 bvanassche@acm.org, josef@toxicpanda.com, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240618031751.3470464-1-yukuai1@huaweicloud.com>
 <20240618031751.3470464-4-yukuai1@huaweicloud.com>
 <ZnEzyJW9WAX0Rjsx@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <25110963-cc9e-7c9f-09b3-d57e4ce6109b@huaweicloud.com>
Date: Tue, 18 Jun 2024 15:58:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZnEzyJW9WAX0Rjsx@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH8A0_PnFmUyQPAQ--.23034S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWfXw48GrWDCr43Xw15twb_yoW8WF1kp3
	yUtF45K39Fkr97Ars8JF1jy34rtw4xGrW5GrsakrW5urZ0qry5ZFn5GrWvkaySyFZ7CFn8
	JFW0qFZ8Cr4UCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/06/18 15:14, Christoph Hellwig Ð´µÀ:
> On Tue, Jun 18, 2024 at 11:17:47AM +0800, Yu Kuai wrote:
>>   bool blkcg_debug_stats = false;
>> +EXPORT_SYMBOL_GPL(blkcg_debug_stats);
> 
> exporting variables is lways a bad idea.a

Yes, export variable is the easiest way here. Will it be acceptable to
make this variable static and add a helper to access it?

> 
>>   
>>   static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
>>   
>> @@ -688,6 +689,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
>>   		return NULL;
>>   	return bdi_dev_name(blkg->q->disk->bdi);
>>   }
>> +EXPORT_SYMBOL_GPL(blkg_dev_name);
> 
> And this helper is just horribly to be honest.  The bdi_dev_name
> should not be used anywhere in block code, and something like this
> certainly should not be exported even if we have to keep it for
> legacy reasons.

And I can reuse __blkg_prfill_u64() for iocost like bfq did, then this
can be removed.

> 
>>   /**
>>    * blkcg_print_blkgs - helper for printing per-blkg data
>> @@ -815,6 +817,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
>>   	ctx->bdev = bdev;
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
> 
> This again is a horrible function papeing over blk-cgroup design
> mistakes.  I absolutely should not be exported.

There is already bigger helper blkg_conf_prep() exported, as used by bfq
for a long time already, and this helper is introduced for code
optimization, as iocost configuration doesn't need to access the blkg.

Perhaps this should be another discussion about "design mistakes",
however, I'm not sure why. :( Do you have previous discussions?

Thanks,
Kuai

> 
> .
> 


