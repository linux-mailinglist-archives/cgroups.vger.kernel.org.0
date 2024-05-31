Return-Path: <cgroups+bounces-3044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE88D57B4
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 03:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E63FBB20E05
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 01:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B46AD7;
	Fri, 31 May 2024 01:21:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014415E9B;
	Fri, 31 May 2024 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118491; cv=none; b=Cx6SvA4z9fWCfSJkHNqfPaxn+0xhT/KRKtv+X4uJ5oM+PQLlfBZesJwxx8PtSKglLkGNR1LUQ2nDchEFXOM1oWuQYC9oIBqhf/X++nedxtfA69ey6x+H8tNfZKbIjW3ewj4r44jW8vIdQf+yrc1IZ3PzUcpm9KNHf4rAuNm/6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118491; c=relaxed/simple;
	bh=3iZda8hQoxDkFln2Bed60LL/YAsuXzhJiaI3KKtJlUA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mkuU+CBUxbBjlISwc25UXDTktD7WF8Pnz/fW3y+hdpfqXWFUcb9yMMd2Ys74A0xVusatQ3mh1N6KitbMV17OKchB2C0dQ8a44SeWk48QveStuoMj9Xqt/GAwb2tXbSZ4qOfEZLUoL5nWG38xWUGI76uQHr687WiP1+ua009vEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vr51B0fv5z4f3k6d;
	Fri, 31 May 2024 09:21:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 34CCC1A0184;
	Fri, 31 May 2024 09:21:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4SJllmULOSOA--.35328S3;
	Fri, 31 May 2024 09:21:24 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: Fix incorrect display of io.max
To: Waiman Long <longman@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Schatzberg <schatzberg.dan@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Justin Forbes <jforbes@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240530134547.970075-1-longman@redhat.com>
 <0de07021-df77-4196-bb75-9ded88b74ce2@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8191bb3d-2afd-ab76-c8b4-50f2871b7a9d@huaweicloud.com>
Date: Fri, 31 May 2024 09:21:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0de07021-df77-4196-bb75-9ded88b74ce2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ4SJllmULOSOA--.35328S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4rXr1DZw47ur4UWr1UGFg_yoWrZryUpF
	93trWUW345X3Z5KF13tr1UXFW5JrWDJa4DXwn3WFy3Ar4UAryIgr1DXr1v9rWUAF48Gr4Y
	yw1UXr9xZF17J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

在 2024/05/30 21:49, Waiman Long 写道:
> 
> On 5/30/24 09:45, Waiman Long wrote:
>> Commit bf20ab538c81 ("blk-throttle: remove 
>> CONFIG_BLK_DEV_THROTTLING_LOW")
>> attempts to revert the code change introduced by commit cd5ab1b0fcb4
>> ("blk-throttle: add .low interface").  However, it leaves behind the
>> bps_conf[] and iops_conf[] fields in the throtl_grp structure which
>> aren't set anywhere in the new blk-throttle.c code but are still being
>> used by tg_prfill_limit() to display the limits in io.max. Now io.max
>> always displays the following values if a block queue is used:
>>
>>     <m>:<n> rbps=0 wbps=0 riops=0 wiops=0
>>
>> Fix this problem by removing bps_conf[] and iops_conf[] and use bps[]
>> and iops[] instead to complete the revert.
>>
>> Fixes: bf20ab538c81 ("blk-throttle: remove 
>> CONFIG_BLK_DEV_THROTTLING_LOW")
>> Reported-by: Justin Forbes <jforbes@redhat.com>
>> Closes: 
>> https://github.com/containers/podman/issues/22701#issuecomment-2120627789
>> Signed-off-by: Waiman Long <longman@redhat.com>

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

>> ---
>>   block/blk-throttle.c | 24 ++++++++++++------------
>>   block/blk-throttle.h |  8 ++------
>>   2 files changed, 14 insertions(+), 18 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index d907040859f9..da619654f418 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -1347,32 +1347,32 @@ static u64 tg_prfill_limit(struct seq_file 
>> *sf, struct blkg_policy_data *pd,
>>       bps_dft = U64_MAX;
>>       iops_dft = UINT_MAX;
>> -    if (tg->bps_conf[READ] == bps_dft &&
>> -        tg->bps_conf[WRITE] == bps_dft &&
>> -        tg->iops_conf[READ] == iops_dft &&
>> -        tg->iops_conf[WRITE] == iops_dft)
>> +    if (tg->bps[READ] == bps_dft &&
>> +        tg->bps[WRITE] == bps_dft &&
>> +        tg->iops[READ] == iops_dft &&
>> +        tg->iops[WRITE] == iops_dft)
>>           return 0;
>>       seq_printf(sf, "%s", dname);
>> -    if (tg->bps_conf[READ] == U64_MAX)
>> +    if (tg->bps[READ] == U64_MAX)
>>           seq_printf(sf, " rbps=max");
>>       else
>> -        seq_printf(sf, " rbps=%llu", tg->bps_conf[READ]);
>> +        seq_printf(sf, " rbps=%llu", tg->bps[READ]);
>> -    if (tg->bps_conf[WRITE] == U64_MAX)
>> +    if (tg->bps[WRITE] == U64_MAX)
>>           seq_printf(sf, " wbps=max");
>>       else
>> -        seq_printf(sf, " wbps=%llu", tg->bps_conf[WRITE]);
>> +        seq_printf(sf, " wbps=%llu", tg->bps[WRITE]);
>> -    if (tg->iops_conf[READ] == UINT_MAX)
>> +    if (tg->iops[READ] == UINT_MAX)
>>           seq_printf(sf, " riops=max");
>>       else
>> -        seq_printf(sf, " riops=%u", tg->iops_conf[READ]);
>> +        seq_printf(sf, " riops=%u", tg->iops[READ]);
>> -    if (tg->iops_conf[WRITE] == UINT_MAX)
>> +    if (tg->iops[WRITE] == UINT_MAX)
>>           seq_printf(sf, " wiops=max");
>>       else
>> -        seq_printf(sf, " wiops=%u", tg->iops_conf[WRITE]);
>> +        seq_printf(sf, " wiops=%u", tg->iops[WRITE]);
>>       seq_printf(sf, "\n");
>>       return 0;
>> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
>> index 32503fd83a84..8c365541a275 100644
>> --- a/block/blk-throttle.h
>> +++ b/block/blk-throttle.h
>> @@ -95,15 +95,11 @@ struct throtl_grp {
>>       bool has_rules_bps[2];
>>       bool has_rules_iops[2];
>> -    /* internally used bytes per second rate limits */
>> +    /* bytes per second rate limits */
>>       uint64_t bps[2];
>> -    /* user configured bps limits */
>> -    uint64_t bps_conf[2];
>> -    /* internally used IOPS limits */
>> +    /* IOPS limits */
>>       unsigned int iops[2];
>> -    /* user configured IOPS limits */
>> -    unsigned int iops_conf[2];
>>       /* Number of bytes dispatched in current slice */
>>       uint64_t bytes_disp[2];
> 
> Add Yu Kuai <yukuai3@huawei.com> to cc.
> 
> 
> .
> 


