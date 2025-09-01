Return-Path: <cgroups+bounces-9552-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E8B3DBD1
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEB6170201
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D32E03F2;
	Mon,  1 Sep 2025 08:03:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA61D8E01;
	Mon,  1 Sep 2025 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713809; cv=none; b=LYry/4WyYzmb5YHkWWkOjlGzHKqzTLilAuKM/k63BiKfa8tmELQsw2SMLzKEX4I0Uc8s5uvkNDZuM01j0tJ9MZ4kikAeBw08qavXl9AebeWWH8BWPpsTIF8YWTX+y+TjSFLoXE7pWaE20d4yG7SBr5t9M/WvkwQagSIqKaC4Bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713809; c=relaxed/simple;
	bh=GUBFiAku52msslaqcKLxNTfXPNOXHZyDbXrJGiCnJlE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UM7npy2rszHJGJb/Mg8zEZSIPo7Z0Y7oJFpl/LeWkvo6OOrJJkiH4xp2uMgBDkGRycrZrk8sTxvmuEfQ7DHJfSyPMBZOsv5OL7wQ7InMKYZekSnCpzdtBWoRhBNaCuzW0ZfuOE02JtXTCYqI889zC4HbJLNluBGliiMXpAdO0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFhFp6g8vzYQvP1;
	Mon,  1 Sep 2025 16:03:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6DFC11A1BAC;
	Mon,  1 Sep 2025 16:03:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY5KU7VoWVIKBA--.61024S3;
	Mon, 01 Sep 2025 16:03:25 +0800 (CST)
Subject: Re: [PATCH RFC v3 07/15] md/raid1: convert to use
 bio_submit_split_bioset()
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 kmo@daterainc.com, satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-8-yukuai1@huaweicloud.com>
 <9b9b78cd-06aa-407d-a224-a5903752599f@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4c823b51-f623-9a65-6d38-cfa874857eb2@huaweicloud.com>
Date: Mon, 1 Sep 2025 16:03:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9b9b78cd-06aa-407d-a224-a5903752599f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY5KU7VoWVIKBA--.61024S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kZF47AFW7Cr48AFyfCrg_yoW8tr4xpr
	Wjga1IgFZ8tFZ093ZFqa12vas5tFWUXr13Z3yxGa4DAFnrt39xKF1UW3yYga4UurW3uw17
	G3WkCa9xu3yUuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRbyCPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/01 14:43, Damien Le Moal 写道:
> On 9/1/25 12:32 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Unify bio split code, and prepare to fix disordered split IO.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> [...]
> 
>> @@ -1586,18 +1577,13 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>>   		max_sectors = min_t(int, max_sectors,
>>   				    BIO_MAX_VECS * (PAGE_SIZE >> 9));
>>   	if (max_sectors < bio_sectors(bio)) {
>> -		struct bio *split = bio_split(bio, max_sectors,
>> -					      GFP_NOIO, &conf->bio_split);
>> -
>> -		if (IS_ERR(split)) {
>> -			error = PTR_ERR(split);
>> +		bio = bio_submit_split_bioset(bio, max_sectors,
>> +					      &conf->bio_split);
>> +		if (!bio) {
>> +			set_bit(R1BIO_Returned, &r1_bio->state);
> 
> Before it was "set_bit(R1BIO_Uptodate, &r1_bio->state);" that was done. Now it
> is R1BIO_Returned that is set. The commit message does not mention this change
> at all. Is this a bug fix ? If yes, that should be in a pre patch before the
> conversion to using bio_submit_split_bioset().

There should be no functional changes, before the change we:

1) set bio->bi_status to split error value;
2) set R1BIO_Uptodate;
3) raid_end_bio_io() check R1BIO_Returned is not set, and call
call_bio_endio();
4) call_bio_endio() check R1BIO_Uptodate is already set, keep the
bio->bi_status that is by split error;

With this change:
1) bio_submit_split_bioset() already fail the bio will split error;
2) set R1BIO_Returned;
3) raid_end_bio_io() check R1BIO_Returned is set and do nothing with the
bio;

And the same with raid10 in patch 8,9;

Perhaps I'll emphasize there is no function changes and explain a bit.

Thanks,
Kuai
> 
>>   			goto err_handle;
>>   		}
>>   
>> -		bio_chain(split, bio);
>> -		trace_block_split(split, bio->bi_iter.bi_sector);
>> -		submit_bio_noacct(bio);
>> -		bio = split;
>>   		r1_bio->master_bio = bio;
>>   		r1_bio->sectors = max_sectors;
>>   	}
>> @@ -1687,8 +1673,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>>   		}
>>   	}
>>   
>> -	bio->bi_status = errno_to_blk_status(error);
>> -	set_bit(R1BIO_Uptodate, &r1_bio->state);
>>   	raid_end_bio_io(r1_bio);
>>   }
> 
> 


