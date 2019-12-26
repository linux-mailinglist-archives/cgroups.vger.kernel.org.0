Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0E12AAB4
	for <lists+cgroups@lfdr.de>; Thu, 26 Dec 2019 07:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbfLZG6L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 26 Dec 2019 01:58:11 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50328 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbfLZG6L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Dec 2019 01:58:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tly10jd_1577343401;
Received: from 30.27.116.26(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0Tly10jd_1577343401)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Dec 2019 14:56:42 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20191225140546.GA311630@chrisdown.name>
Date:   Thu, 26 Dec 2019 14:56:40 +0800
Cc:     Hui Zhu <teawater@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6E9887B9-EEF7-406E-90D4-3FAEFE0A505E@linux.alibaba.com>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
 <20191225140546.GA311630@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> 在 2019年12月25日，22:05，Chris Down <chris@chrisdown.name> 写道：
> 
> Hi Hui,
> 
> Hui Zhu writes:
>> Even if cgroup2 has swap.max, swappiness is still a very useful config.
>> This commit add swappiness to cgroup2.
> 
> When submitting patches like this, it's important to explain *why* you want it and what evidence there is. For example, how should one use this to compose a reasonable system? Why aren't existing protection controls sufficient for your use case? Where's the data?
> 
> Also, why would swappiness be something cgroup-specific instead of hardware-specific, when desired swappiness is really largely about the hardware you have in your system?
> 
> I struggle to think of situations where per-cgroup swappiness would be useful, since it's really not a workload-specific setting.


Hi Chris,

My thought about per-cgroup swappiness is different applications should have different memory footprint.
For example, an application does a lot of file access work in a memory-constrained environment.  Its performance depend on the file access speed.  Keep more file cache will good for it.  Then more swappiness will good for it, especially with the high speed swap device(zram/zswap).
And in the same environment, an application that access anon memory a lot of times.  Use low swapiness will good for its performance.  But just let it not to swap is not a good for it because the code is inside file cache.  Just drop the file cache will decrease the application speed sometime.
Both of them are extreme examples.  Other applications maybe access both file and anon.  Maybe define a special swapiness is good for it.

This is what I thought about add swappiness to cgroup2.

Best,
Hui

> 
> Thanks,
> 
> Chris
> 
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>> mm/memcontrol.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c5b5f74..e966396 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7143,6 +7143,11 @@ static struct cftype swap_files[] = {
>> 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
>> 		.seq_show = swap_events_show,
>> 	},
>> +	{
>> +		.name = "swappiness",
>> +		.read_u64 = mem_cgroup_swappiness_read,
>> +		.write_u64 = mem_cgroup_swappiness_write,
>> +	},
>> 	{ }	/* terminate */
>> };
>> 
>> -- 
>> 2.7.4
>> 

