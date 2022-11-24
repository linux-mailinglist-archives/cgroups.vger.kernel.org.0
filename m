Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538F463795D
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 13:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiKXMxn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 07:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKXMx1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 07:53:27 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6156D73;
        Thu, 24 Nov 2022 04:52:54 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHyZD19wKz15Ms3;
        Thu, 24 Nov 2022 20:52:20 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 20:52:51 +0800
Subject: Re: [PATCH 05/11] blk-throttle: simpfy low limit reached check in
 throtl_tg_can_upgrade
To:     Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-6-shikemeng@huawei.com>
 <Y35l3cRfYNgCzBgC@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <64e54286-2c77-7162-4d50-1c644d1f0caf@huawei.com>
Date:   Thu, 24 Nov 2022 20:52:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y35l3cRfYNgCzBgC@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



on 11/24/2022 2:26 AM, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 02:03:55PM +0800, Kemeng Shi wrote:
>> -static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
>> +static bool throtl_tg_reach_low_limit(struct throtl_grp *tg, int rw)
>>  {
>>  	struct throtl_service_queue *sq = &tg->service_queue;
>> -	bool read_limit, write_limit;
>> +	bool limit = tg->bps[rw][LIMIT_LOW] || tg->iops[rw][LIMIT_LOW];
>>  
>>  	/*
>>  	 * if cgroup reaches low limit (if low limit is 0, the cgroup always
>>  	 * reaches), it's ok to upgrade to next limit
>>  	 */
>> -	read_limit = tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW];
>> -	write_limit = tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW];
>> -	if (!read_limit && !write_limit)
>> -		return true;
>> -	if (read_limit && sq->nr_queued[READ] &&
>> -	    (!write_limit || sq->nr_queued[WRITE]))
>> -		return true;
>> -	if (write_limit && sq->nr_queued[WRITE] &&
>> -	    (!read_limit || sq->nr_queued[READ]))
>> +	return !limit || sq->nr_queued[rw].
>> +}
>> +
>> +static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
>> +{
>> +	if (throtl_tg_reach_low_limit(tg, READ) &&
>> +	    throtl_tg_reach_low_limit(tg, WRITE))
> 
> Are the conditions being checked actually equivalent? If so, can you
> explicitly explain that these are equivalent conditions? If not, what are we
> changing exactly?All replaced conditions to return true are as following:
condition 1
(!read_limit && !write_limit)
condition 2
read_limit && sq->nr_queued[READ] && (!write_limit || sq->nr_queued[WRITE])
condition 3
write_limit && sq->nr_queued[WRITE] && (!read_limit || sq->nr_queued[READ])

Transfering condition 2 as following:
read_limit && sq->nr_queued[READ] && (!write_limit || sq->nr_queued[WRITE])
is equivalent to
(read_limit && sq->nr_queued[READ]) &&
(!write_limit || (write_limit && sq->nr_queued[WRITE]))
is equivalent to
(read_limit && sq->nr_queued[READ] && !write_limit) ||
((read_limit && sq->nr_queued[READ] && (write_limit && sq->nr_queued[WRITE]))

Transfering condition 3 as following:
write_limit && sq->nr_queued[WRITE] && (!read_limit || sq->nr_queued[READ])
is equivalent to
(write_limit && sq->nr_queued[WRITE]) &&
(!read_limit || (read_limit && sq->nr_queued[READ]))
is equivalent to
((write_limit && sq->nr_queued[WRITE]) && !read_limit) ||
((write_limit && sq->nr_queued[WRITE]) && (read_limit && sq->nr_queued[READ]))

All replaced conditions to return true are collected as folloing:
condition 1.1
(!read_limit && !write_limit)
condition 1.2
(read_limit && sq->nr_queued[READ] && !write_limit)
condition 1.3
((read_limit && sq->nr_queued[READ] && (write_limit && sq->nr_queued[WRITE]))
condition 1.4
(write_limit && sq->nr_queued[WRITE]) && !read_limit)
condition 1.5 (the same as 1.3, can be ingored)
(write_limit && sq->nr_queued[WRITE]) && (read_limit && sq->nr_queued[READ]))

Condtions to return true in this patch is:
(!read_limit || (read_limit && sq->nr_queued[READ])) &&
(!write_limit || (write_limit && sq->nr_queued[WRITE]))
As "(a || b) && (c || d)" can be extracted to
(a && c) or (a && d) or (b && c) or (b && d ). So we can extract condtions to
condition 2.1
!read_limit && !write_limit
condition 2.2
!read_limit && (write_limit && sq->nr_queued[WRITE])
condition 2.3
(read_limit && sq->nr_queued[READ]) && !write_limit
condition 2.4
(read_limit && sq->nr_queued[READ]) && (write_limit && sq->nr_queued[WRITE])

Conditions match as following:
condition 1.1 = condition 2.1
condition 1.2 = condition 2.3
condition 1.3 = condition 2.4
condition 1.4 = condition 2.2

-- 
Best wishes
Kemeng Shi
