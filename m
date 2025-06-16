Return-Path: <cgroups+bounces-8536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D81ADAB9A
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F16188A87D
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 09:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D12273D6A;
	Mon, 16 Jun 2025 09:15:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCD2737E1;
	Mon, 16 Jun 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065304; cv=none; b=cQe6d941gz8+58Kk1CiKV2vHcTHwfjcoPziG0nPO3jTtVj9z/Xqjotf2MwQhESLW/viNxxTMZSOnRgNYgJgesqUF/OOvlulCMTDS+5Y7xOgmHX/8Bza3ZuMJvMtef7klzbC5a9AgNKyS0oRf39F7VW8oCtKBk8KcwYtJ5kOJPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065304; c=relaxed/simple;
	bh=2HRrz5CjnU8wZIMFr5D7DyrHO5tkX2e1sFACMrY04Vs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c0a2YAb3smVnhcpwyVCrj+XAX52hSgn0DldpMjXRMMgA1kwNEXfoWzzTDvU16kspxQasxLPkPYGgmxfk7Qm5e5Fw6DFdmvcEhEzT47IU7atEJ70zlja6cW5bVlyuggJlRLFQ9kQwrDhjITNUCevtmlSzmmnwx1C0g31Xw7ZznUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bLPTp172WzYQvRL;
	Mon, 16 Jun 2025 17:14:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E19F1A1DE0;
	Mon, 16 Jun 2025 17:14:53 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAni1+L4E9o9F+9Pg--.37809S3;
	Mon, 16 Jun 2025 17:14:52 +0800 (CST)
Subject: Re: [PATCH RFC v2 0/5] blk-mq-sched: support request batch
 dispatching for sq elevator
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <9d3aee10-9eb3-4f2d-bb9a-1721c05ec3aa@kernel.org>
 <16fd5432-36b0-0a92-0caa-7374ce1464a5@huaweicloud.com>
 <27d2cd23-1c0e-4a21-975c-68be727220ec@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <54c6a041-8937-3d8c-24f4-7cd7f15cdaca@huaweicloud.com>
Date: Mon, 16 Jun 2025 17:14:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <27d2cd23-1c0e-4a21-975c-68be727220ec@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni1+L4E9o9F+9Pg--.37809S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trW3tw43KFWfZry8uF1kuFg_yoW8GFW7pF
	WrtFWayws0gFn2y34v934rKr1Uu34kWFyfJrn8JrW2g3s8Jr1SkrsxKFZ8ZFW7Arn3GFsF
	9FW0qFyFqrn2qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/16 15:37, Damien Le Moal 写道:
> On 6/16/25 16:22, Yu Kuai wrote:
>> I agree that lock contention here will not affect HDD performance.
>> What I suspect the difference in my environment is that the order of rqs
>> might be changed from elevator dispatching them and the disk handling
>> them.
>>
>> For example, the order can be easily revised if more than one context
>> dispatch one request at a time:
>>
>> t1:
>>
>> lock
>> rq1 = dd_dispatch_request
>> unlock
>> 			t2:
>> 			lock
>> 			rq2 = dd_dispatch_request
>> 			unlock
>>
>> lock
>> rq3 = dd_dispatch_request
>> unlock
>>
>> 			lock
>> 			rq4 = dd_dispatch_request
>> 			unlock
>>
>> //rq1,rq3 issue to disk
>> 			// rq2, rq4 issue to disk
>>
>> In this case, the elevator dispatch order is rq 1-2-3-4, however,
>> such order in disk is rq 1-3-2-4.
>>
>> And with batch requests dispatch, will this less likely to happen?
> 
> If you are running a write test with the HDD write cache enabled, such
> reordering will most liley not matter at all. Running the same workload with
> "none" and I get the same IOPS for writes.
> 
> Check your disk. If you do have the HDD write cache disabled, then sure, the
> order will matter more depending on how your drive handles WCD writes (recent
> drives have very similar performance with WCE and WCD).
> 
Thanks for the explanation, I'll test more workload on more disks, and
of corese, explain details more in the formal version as you suggested.

Kuai


