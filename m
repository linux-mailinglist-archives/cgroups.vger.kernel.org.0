Return-Path: <cgroups+bounces-9692-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B0B42FEF
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 04:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57937A44CD
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 02:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0A1FBE8B;
	Thu,  4 Sep 2025 02:44:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFA1F869E;
	Thu,  4 Sep 2025 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953881; cv=none; b=Ygz/uwCR7+bl4KuKV0ZqaNYr3wrJkf7yt/u+hL8l3c7zyqNyia+PkpfGXh3yxkbMIyVm5hQQQGcOy59JcJDF36KC77cnvHGukcMHkNds1wSvCvrCs8bX9zE7rdF0dB0PfQZnLFWzcfMZ5U4VO+zgCIKxf4PkoxhCxpuod9YQMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953881; c=relaxed/simple;
	bh=cquMonGgxWqhZGg0znTl+11rd8TzFMhrscmrEb4V7Ck=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SYB1YAdW3irzD22Ewc4xZAQMZSILFDuqZ4BWSQQINA0grYSd9RCAaRX/SrZVlRTMMzhRNknBSwCBLOeW0XYE2ThSZB6BzNOr3Rz2HLUHDeffX8iLw369eSc7O9780AZypR/4fj5DY4jnGbo71RV2T52R2mYU8Y8crPBqf7WhChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cHP2W4rDJzKHN10;
	Thu,  4 Sep 2025 10:44:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 951801A1780;
	Thu,  4 Sep 2025 10:44:35 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY0Q_bhotnlIBQ--.8785S3;
	Thu, 04 Sep 2025 10:44:35 +0800 (CST)
Subject: Re: [PATCH RFC v3 02/15] block: add QUEUE_FLAG_BIO_ISSUE
To: Yu Kuai <hailan@yukuai.org.cn>, Christoph Hellwig <hch@infradead.org>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 kmo@daterainc.com, satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-3-yukuai1@huaweicloud.com>
 <aLhBqTrbUWVK4OKy@infradead.org>
 <5378349f-4d00-4d3e-9834-f3ddf2e514cc@yukuai.org.cn>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dbbfce94-22d8-5c34-ba70-c6de2b902659@huaweicloud.com>
Date: Thu, 4 Sep 2025 10:44:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5378349f-4d00-4d3e-9834-f3ddf2e514cc@yukuai.org.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY0Q_bhotnlIBQ--.8785S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW8JF1Uuw15ur4ruw18uFg_yoW5Ww43pr
	ZYqasrKws3KF4vgan7ta17tF10kF4DGry3C395A3ySkwsakrnFqr18ZrnYvF9Y9rs5CrWU
	Zrn5Kr98Xw4F9rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/04 0:54, Yu Kuai 写道:
> Hi,
> 
> 在 2025/9/3 21:24, Christoph Hellwig 写道:
>> On Mon, Sep 01, 2025 at 11:32:07AM +0800, Yu Kuai wrote:
>>>   static inline void blkcg_bio_issue_init(struct bio *bio)
>>>   {
>>> -    bio->issue_time_ns = blk_time_get_ns();
>>> +    struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>>> +
>>> +    if (test_bit(QUEUE_FLAG_BIO_ISSUE, &q->queue_flags))
>>> +        bio->issue_time_ns = blk_time_get_ns();
>>>   }
>> Given that this is called on a bio and called from generic code
>> and not blk-mq, the flag should in the gendisk and not the queue.
>>
> ok, will change to disk, and also change set/clear the flag to
> enable/disable iolatency.

After careful consideration, I think it's better to delay
blkcg_bio_issue_init() to blk_mq_submit_bio():

- it's only used by iolatency, which can only be enabled for rq-based
disks;
- For bio that is submitted the first time, blk_cgroup_bio_start() is
called from submit_bio_no_acct_nocheck(), where q_usage_counter is not
grabbed yet, hence it's not safe to enable that flag while enabling
iolatency.

diff --git a/block/blk-core.c b/block/blk-core.c
index 4201504158a1..83c262a3dfd9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -728,7 +728,6 @@ static void __submit_bio_noacct_mq(struct bio *bio)
  void submit_bio_noacct_nocheck(struct bio *bio)
  {
         blk_cgroup_bio_start(bio);
-       blkcg_bio_issue_init(bio);

         if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
                 trace_block_bio_queue(bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..5538356770a4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -119,7 +119,6 @@ static struct bio *bio_submit_split(struct bio *bio, 
int split_sectors)
                         goto error;
                 }
                 split->bi_opf |= REQ_NOMERGE;
-               blkcg_bio_issue_init(split);
                 bio_chain(split, bio);
                 trace_block_split(split, bio->bi_iter.bi_sector);
                 WARN_ON_ONCE(bio_zone_write_plugging(bio));
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3a4b77f578..030937b129a2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3108,7 +3108,7 @@ static bool bio_unaligned(const struct bio *bio, 
struct request_queue *q)
   * It will not queue the request if there is an error with the bio, or 
at the
   * request creation.
   */
-void blk_mq_submit_bio(struct bio *bio)
+void b k_mq_submit_bio(struct bio *bio)
  {
         struct request_queue *q = bdev_get_queue(bio->bi_bdev);
         struct blk_plug *plug = current->plug;
@@ -3168,6 +3168,9 @@ void blk_mq_submit_bio(struct bio *bio)
         if (!bio_integrity_prep(bio))
                 goto queue_exit;

+       if (test_bit(QUEUE_FLAG_BIO_ISSUE, &q->queue_flags))
+               bio->issue_time_ns = blk_time_get_ns();
+
         if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
                 goto queue_exit;


> 
> Thanks,
> Kuai
> 
> .
> 


