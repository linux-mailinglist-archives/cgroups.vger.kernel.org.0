Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8185329B0
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 13:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiEXLrz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiEXLrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 07:47:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A142122BCA;
        Tue, 24 May 2022 04:47:52 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L6snH1B3kzQk91;
        Tue, 24 May 2022 19:44:51 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 19:47:50 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 19:47:49 +0800
Subject: Re: [PATCH -next v4 4/4] blk-throttle: fix io hung due to config
 updates
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220523082633.2324980-1-yukuai3@huawei.com>
 <20220523082633.2324980-5-yukuai3@huawei.com>
 <20220524095936.GB2434@blackbody.suse.cz>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <9b3712a1-1f6d-9c9a-4133-a058fe3b111c@huawei.com>
Date:   Tue, 24 May 2022 19:47:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220524095936.GB2434@blackbody.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/05/24 17:59, Michal Koutný 写道:
> On Mon, May 23, 2022 at 04:26:33PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>> Fix the problem by respecting the time that throttled bio aready waited.
>> In order to do that, add new fields to record how many bytes/io already
>> waited, and use it to calculate wait time for throttled bio under new
>> configuration.
> 
> This new approach is correctly conserving the bandwidth upon changes.
> (Looking and BPS paths.)
> 
>>
>> Some simple test:
>> 1)
>> cd /sys/fs/cgroup/blkio/
>> echo $$ > cgroup.procs
>> echo "8:0 2048" > blkio.throttle.write_bps_device
>> {
>>          sleep 3
>>          echo "8:0 1024" > blkio.throttle.write_bps_device
>> } &
>> sleep 1
>> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
>>
>> 2)
>> cd /sys/fs/cgroup/blkio/
>> echo $$ > cgroup.procs
>> echo "8:0 1024" > blkio.throttle.write_bps_device
>> {
>>          sleep 5
>>          echo "8:0 2048" > blkio.throttle.write_bps_device
>> } &
>> sleep 1
>> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
>>
> 
> It's interesting that you're getting these numbers (w/patch)
> 
>> test results: io finish time
>> 	before this patch	with this patch
>> 1)	10s			6s
>> 2)	8s			6s
> 
> wait := (disp + bio - Δt*l_old) / l_new
> 
> 1)
> wait = (0k + 8k - 3s*2k/s) / 1k/s = 2s -> i.e. 5s absolute
> 
> 2)
> wait = (0k + 8k - 5s*1k/s) / 2k/s = 2.5s -> i.e. 6.5s absolute
> 
> Are you numbers noisy+rounded or do I still mis anything?
Hi, Michal

The way of your caculation is right, however, it seems like you missed
that io is dispatched after 1s:

sleep 1  -> here
dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
> 
> (Also isn't it worth having this more permanent in tools/testing/selftest?)
> 
>> +static void tg_update_skipped(struct throtl_grp *tg)
>> +{
>> +	if (tg->service_queue.nr_queued[READ])
>> +		__tg_update_skipped(tg, READ);
>> +	if (tg->service_queue.nr_queued[WRITE])
>> +		__tg_update_skipped(tg, WRITE);
> 
> On one hand, the callers of tg_update_skipped() know whether R/W limit
> is changed, so only the respective variant could be called.
> On the other hand, this conditions look implied by tg->flags &
> THROTL_TG_PENDING.
> (Just noting, it's likely still not possibly to pass the skipped value
> only via stack.)
> 
> 
>> @@ -115,6 +115,10 @@ struct throtl_grp {
>>   	uint64_t bytes_disp[2];
>>   	/* Number of bio's dispatched in current slice */
>>   	unsigned int io_disp[2];
>> +	/* Number of bytes will be skipped in current slice */
>> +	uint64_t bytes_skipped[2];
>> +	/* Number of bio's will be skipped in current slice */
>> +	unsigned int io_skipped[2];
> 
> Please add a comment these fields exists to facilitate config updates
> (the bytes to be skipped is sort of obvious from the name :-).
Ok, will do that in next iteration.

Thanks,
Kuai
