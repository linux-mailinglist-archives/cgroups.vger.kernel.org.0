Return-Path: <cgroups+bounces-2469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E720D8A3A71
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 04:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BAAB2194A
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 02:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA147125B9;
	Sat, 13 Apr 2024 02:17:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2A182BB;
	Sat, 13 Apr 2024 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974679; cv=none; b=KibEiD4H7K2aFbEBLp81i4EwacaUZe6fdA1GFZ5lTI0Zyz8hkqs7965T2GGVF3mqHzvcypHRp71mAcsBLC/yauhztxpKsqEw37YBlq4/oTYsoTokFT5Ja/u8A/1PKJjruzjfiVFy4Ab8eKhmbcwEx6EaTNr/F0CluDOzmLlCpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974679; c=relaxed/simple;
	bh=LdCmdE9QF4G5X/qDNp4uy35b4SPw10KZ8RoarVrkHQU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PynyGJpuVmIFFeb994IOX4/Q/rj7Qkvspashrhvz0bm+zIMjMBs55GN/5eNRLG/aidekP3GogqfbDY/WCehjD1i0Aee80yaLOBSkD/hkDjMN1AcZY9rHXgSz6HWFNIyqrvo1jrVhQtaMcV+wbJlm04795Nqv3hiL5D8noIeYjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VGcXY1Lc7z4f3l95;
	Sat, 13 Apr 2024 10:17:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A56571A0572;
	Sat, 13 Apr 2024 10:17:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g5P6xlmLzJcJw--.19418S3;
	Sat, 13 Apr 2024 10:17:53 +0800 (CST)
Subject: Re: [PATCH RFC v2 6/6] blk-throtl: switch to use rq_qos
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
 jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net, pctammela@mojatatu.com,
 qde@naccy.de, zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-7-yukuai1@huaweicloud.com>
 <Zhl5ONFlPg4vqjGj@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b522c2b7-efae-a7ca-ee6c-197a4b9b54ff@huaweicloud.com>
Date: Sat, 13 Apr 2024 10:17:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zhl5ONFlPg4vqjGj@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g5P6xlmLzJcJw--.19418S3
X-Coremail-Antispam: 1UD129KBjvJXoWrZr4kZFykGF18Jw45tF1rCrg_yoW8JrWfpa
	ySgay8Jr4ktrZa9r1a9F1aqFW8tr4xA3yUJ3s5trWayF1qvr95Gr9rtF1F9a4kJF4xWrW0
	va4UtrW8Ca1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/13 2:11, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Sat, Apr 06, 2024 at 04:00:59PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> To avoid exposing blk-throttle internal implementation to general block
>> layer.
> ...
>> @@ -832,7 +832,7 @@ void submit_bio_noacct(struct bio *bio)
>>   		goto not_supported;
>>   	}
>>   
>> -	if (blk_throtl_bio(bio))
>> +	if (rq_qos_throttle_bio(q, bio))
>>   		return;
>>   	submit_bio_noacct_nocheck(bio);
>>   	return;
> 
> This is a half-way conversion, right? You're adding a dedicated hook to
> rq_qos and none of the other hooks can be used by blk-throtl. Even the name,
> rq_qos_throttle_bio(), becomes a misnomer. I'm not really sure this makes
> things better or worse. It makes certain things a bit cleaner but other
> things nastier. I don't know.

Yes, the final goal is making all blk-cgroup policies modular, and this
patch use rq-qos to prevent exposing blk-throtle to block layer, like
other policies.

There is another choice that I think is feasible:

Let blk-throttle ping a policy id, and use the id to call throttle
function directly, this will require initializing the 'plid' from
blkcg_policy() during definition instead of blkcg_policy_register().

Thanks,
Kuai

> 
> Thanks.
> 


