Return-Path: <cgroups+bounces-9512-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24AB3C7E2
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 06:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D285581D31
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 04:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4FB27876A;
	Sat, 30 Aug 2025 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="YDGWY+h0"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3A182D2;
	Sat, 30 Aug 2025 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756528148; cv=pass; b=QctBca38dC+8BfKrnH6WMVRW5FpZrhIgA10sSdvDrRJq9Bp9fRbWjlBorVKaBeUF0CaatgA2B1bfNW9DNkrkz/EFRYC/q7UfWrDJ1Vq0U/09YXPCwqcd9AL341Kp85GJXis1Xu/tIyqN9+DgC0SeoAmjE/fZLWTAU5r6WQ1Cr3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756528148; c=relaxed/simple;
	bh=2kqlA7PGh1rp20T1L7OvrfUhLTO0ApS5++q0xlek83Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2HoLG0yKhun0MbAYVvG8SnBEbhK++lcGMfPboZJr1NbtaXPkL5+7s5TGbUoAstRjNrbdvuC5+bAiZ4qj36hDhzOZb1+oNY8y+vekqZRFymQ0Xzo4UPbJt8yOxQaDosGFfC+khWcEoGQDPxOHWNtIUnM3n4uzUbKGm5zC8+GZ0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=YDGWY+h0; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1756528119; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VvO88RAUoupwOZt3YdtwFC/W60664w7fLZz2kEjvjr9HtUgDhY6/pY0AwlV5p8RP7b5MPrM4hmOziw2Kzj5uctCgNWx7RiyfDi/ZC8dAbM1KkZeTe2hBRS3IZFZxb7DdcFuxKd/s7qAh6uwkLGV32MRreLCOG5cry0jCcNJhrP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756528119; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y703uyxAGsnJhLcj6Za6azyaPwY84u+BNcattdfon0Y=; 
	b=gfnXHcvJXWq+YgN1CkVS5MB/pj3CC3KNJ5Pc8c2UUwbWLWdo6Dk08Sv4cWnx1t7v7KS4fnZgV+30vrYasDqLaKqeZRYmrs+MV5mPxd97hiOTQZjghEwaYS7zsG9V9UnrQxr513LdnT9d3ZOmd9www3gYKoICalojONtQZeQoDfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756528119;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=y703uyxAGsnJhLcj6Za6azyaPwY84u+BNcattdfon0Y=;
	b=YDGWY+h0G1iSK2M1TAit5QnnDpd4hKxXMUo2j49AboqWTssQr6Zjjv6NqaU4rGzR
	9oQ3CddxohXdbTeun0lkFKBRHGn/iHw1b/FtFvvIqABNKpyWrYlNEJenFaQ41P0iGYI
	ck3LqKd0D/GkpCa/CbeaQ9GT43pxSMO3bF58wtEY=
Received: by mx.zohomail.com with SMTPS id 1756528117375177.67627132485097;
	Fri, 29 Aug 2025 21:28:37 -0700 (PDT)
Message-ID: <79aae55c-a2fe-465c-9204-44dce9a80256@yukuai.org.cn>
Date: Sat, 30 Aug 2025 12:28:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/10] block: fix disordered IO in the case
 recursive split
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 neil@brown.name, akpm@linux-foundation.org, hch@infradead.org,
 colyli@kernel.org, hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-10-yukuai1@huaweicloud.com>
 <23872034-2b36-4a71-91b9-e599976902b6@kernel.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <23872034-2b36-4a71-91b9-e599976902b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/8/30 9:02, Damien Le Moal 写道:
> On 8/28/25 15:57, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, split bio will be chained to original bio, and original bio
>> will be resubmitted to the tail of current->bio_list, waiting for
>> split bio to be issued. However, if split bio get split again, the IO
>> order will be messed up, for example, in raid456 IO will first be
>> split by max_sector from md_submit_bio(), and then later be split
>> again by chunksize for internal handling:
>>
>> For example, assume max_sectors is 1M, and chunksize is 512k
>>
>> 1) issue a 2M IO:
>>
>> bio issuing: 0+2M
>> current->bio_list: NULL
>>
>> 2) md_submit_bio() split by max_sector:
>>
>> bio issuing: 0+1M
>> current->bio_list: 1M+1M
>>
>> 3) chunk_aligned_read() split by chunksize:
>>
>> bio issuing: 0+512k
>> current->bio_list: 1M+1M -> 512k+512k
>>
>> 4) after first bio issued, __submit_bio_noacct() will contuine issuing
>> next bio:
>>
>> bio issuing: 1M+1M
>> current->bio_list: 512k+512k
>> bio issued: 0+512k
>>
>> 5) chunk_aligned_read() split by chunksize:
>>
>> bio issuing: 1M+512k
>> current->bio_list: 512k+512k -> 1536k+512k
>> bio issued: 0+512k
>>
>> 6) no split afterwards, finally the issue order is:
>>
>> 0+512k -> 1M+512k -> 512k+512k -> 1536k+512k
>>
>> This behaviour will cause large IO read on raid456 endup to be small
>> discontinuous IO in underlying disks. Fix this problem by placing split
>> bio to the head of current->bio_list.
>>
>> Test script: test on 8 disk raid5 with 64k chunksize
>> dd if=/dev/md0 of=/dev/null bs=4480k iflag=direct
>>
>> Test results:
>> Before this patch
>> 1) iostat results:
>> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz  aqu-sz  %util
>> md0           52430.00   3276.87     0.00   0.00    0.62    64.00   32.60  80.10
>> sd*           4487.00    409.00  2054.00  31.40    0.82    93.34    3.68  71.20
>> 2) blktrace G stage:
>>    8,0    0   486445    11.357392936   843  G   R 14071424 + 128 [dd]
>>    8,0    0   486451    11.357466360   843  G   R 14071168 + 128 [dd]
>>    8,0    0   486454    11.357515868   843  G   R 14071296 + 128 [dd]
>>    8,0    0   486468    11.357968099   843  G   R 14072192 + 128 [dd]
>>    8,0    0   486474    11.358031320   843  G   R 14071936 + 128 [dd]
>>    8,0    0   486480    11.358096298   843  G   R 14071552 + 128 [dd]
>>    8,0    0   486490    11.358303858   843  G   R 14071808 + 128 [dd]
>> 3) io seek for sdx:
>> Noted io seek is the result from blktrace D stage, statistic of:
>> ABS((offset of next IO) - (offset + len of previous IO))
>>
>> Read|Write seek
>> cnt 55175, zero cnt 25079
>>      >=(KB) .. <(KB)     : count       ratio |distribution                            |
>>           0 .. 1         : 25079       45.5% |########################################|
>>           1 .. 2         : 0            0.0% |                                        |
>>           2 .. 4         : 0            0.0% |                                        |
>>           4 .. 8         : 0            0.0% |                                        |
>>           8 .. 16        : 0            0.0% |                                        |
>>          16 .. 32        : 0            0.0% |                                        |
>>          32 .. 64        : 12540       22.7% |#####################                   |
>>          64 .. 128       : 2508         4.5% |#####                                   |
>>         128 .. 256       : 0            0.0% |                                        |
>>         256 .. 512       : 10032       18.2% |#################                       |
>>         512 .. 1024      : 5016         9.1% |#########                               |
>>
>> After this patch:
>> 1) iostat results:
>> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz  aqu-sz  %util
>> md0           87965.00   5271.88     0.00   0.00    0.16    61.37   14.03  90.60
>> sd*           6020.00    658.44  5117.00  45.95    0.44   112.00    2.68  86.50
>> 2) blktrace G stage:
>>    8,0    0   206296     5.354894072   664  G   R 7156992 + 128 [dd]
>>    8,0    0   206305     5.355018179   664  G   R 7157248 + 128 [dd]
>>    8,0    0   206316     5.355204438   664  G   R 7157504 + 128 [dd]
>>    8,0    0   206319     5.355241048   664  G   R 7157760 + 128 [dd]
>>    8,0    0   206333     5.355500923   664  G   R 7158016 + 128 [dd]
>>    8,0    0   206344     5.355837806   664  G   R 7158272 + 128 [dd]
>>    8,0    0   206353     5.355960395   664  G   R 7158528 + 128 [dd]
>>    8,0    0   206357     5.356020772   664  G   R 7158784 + 128 [dd]
>> 3) io seek for sdx
>> Read|Write seek
>> cnt 28644, zero cnt 21483
>>      >=(KB) .. <(KB)     : count       ratio |distribution                            |
>>           0 .. 1         : 21483       75.0% |########################################|
>>           1 .. 2         : 0            0.0% |                                        |
>>           2 .. 4         : 0            0.0% |                                        |
>>           4 .. 8         : 0            0.0% |                                        |
>>           8 .. 16        : 0            0.0% |                                        |
>>          16 .. 32        : 0            0.0% |                                        |
>>          32 .. 64        : 7161        25.0% |##############                          |
>>
>> BTW, this looks like a long term problem from day one, and large
>> sequential IO read is pretty common case like video playing.
>>
>> And even with this patch, in this test case IO is merged to at most 128k
>> is due to block layer plug limit BLK_PLUG_FLUSH_SIZE, increase such
>> limit can get even better performance. However, we'll figure out how to do
>> this properly later.
>>
>> Fixes: d89d87965dcb ("When stacked block devices are in-use (e.g. md or dm), the recursive calls")
>> Reported-by: Tie Ren <tieren@fnnas.com>
>> Closes: https://lore.kernel.org/all/7dro5o7u5t64d6bgiansesjavxcuvkq5p2pok7dtwkav7b7ape@3isfr44b6352/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-core.c     | 21 ++++++++++++++-------
>>   block/blk-throttle.c |  2 +-
>>   block/blk.h          |  2 +-
>>   3 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 37836446f365..b643d3b1e9fe 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -725,7 +725,7 @@ static void __submit_bio_noacct_mq(struct bio *bio)
>>   	current->bio_list = NULL;
>>   }
>>   
>> -void submit_bio_noacct_nocheck(struct bio *bio)
>> +void submit_bio_noacct_nocheck(struct bio *bio, bool split)
>>   {
>>   	blk_cgroup_bio_start(bio);
>>   	blkcg_bio_issue_init(bio);
>> @@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>   	 * to collect a list of requests submited by a ->submit_bio method while
>>   	 * it is active, and then process them after it returned.
>>   	 */
>> -	if (current->bio_list)
>> -		bio_list_add(&current->bio_list[0], bio);
>> -	else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
>> +	if (current->bio_list) {
>> +		if (split)
>> +			bio_list_add_head(&current->bio_list[0], bio);
>> +		else
>> +			bio_list_add(&current->bio_list[0], bio);
> This really needs a comment clarifying why we do an add at tail instead of
> keeping the original order with a add at head. I am also scared that this may
> break sequential write ordering for zoned devices.

I think add at head is exactly what we do here to keep the orginal order for
the case bio split. Other than split, if caller do generate multiple sequential
bios, we should keep the order by add at tail.

Not sure about zoned devices for now, I'll have a look in details.

Thanks,
Kuai

>
>> +	} else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
>>   		__submit_bio_noacct_mq(bio);
>> -	else
>> +	} else {
>>   		__submit_bio_noacct(bio);
>> +	}
>>   }
>
>

