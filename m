Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C864B4672ED
	for <lists+cgroups@lfdr.de>; Fri,  3 Dec 2021 08:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379002AbhLCHx5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Dec 2021 02:53:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32876 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378991AbhLCHx4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Dec 2021 02:53:56 -0500
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J54k64k7Nzcbn4;
        Fri,  3 Dec 2021 15:50:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:50:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:50:30 +0800
Subject: Re: [PATCH v4 2/2] block: cancel all throttled bios in del_gendisk()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <hch@infradead.org>, <tj@kernel.org>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211202130440.1943847-1-yukuai3@huawei.com>
 <20211202130440.1943847-3-yukuai3@huawei.com>
 <20211202144818.GB16798@blackbody.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <95825098-a532-a0e4-9ed0-0b5f2a0e5f04@huawei.com>
Date:   Fri, 3 Dec 2021 15:50:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211202144818.GB16798@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2021/12/02 22:48, Michal Koutný 写道:
> Hello Kuai.
> 
> On Thu, Dec 02, 2021 at 09:04:40PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>> For example, if user thread is throttled with low bps while it's
>> issuing large io, and the device is deleted. The user thread will
>> wait for a long time for io to return.
> 
> Do I understand correctly the "long time" here is
> outstanding_IO_size/throttled_bandwidth? Or are you getting at some

Hi, Michal

Yes, this is exactly what I mean.
> other cause/longer time?
> 
>> +void blk_throtl_cancel_bios(struct request_queue *q)
>> +{
>> +	struct throtl_data *td = q->td;
>> +	struct bio_list bio_list_on_stack;
>> +	struct blkcg_gq *blkg;
>> +	struct cgroup_subsys_state *pos_css;
>> +	struct bio *bio;
>> +	int rw;
>> +
>> +	bio_list_init(&bio_list_on_stack);
>> +
>> +	/*
>> +	 * hold queue_lock to prevent concurrent with dispatching
>> +	 * throttled bios by timer.
>> +	 */
>> +	spin_lock_irq(&q->queue_lock);
> 
> You've replaced the rcu_read_lock() with the queue lock but...
> 
>> +
>> +	/*
>> +	 * Drain each tg while doing post-order walk on the blkg tree, so
>> +	 * that all bios are propagated to td->service_queue.  It'd be
>> +	 * better to walk service_queue tree directly but blkg walk is
>> +	 * easier.
>> +	 */
>> +	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg)
>> +		tg_drain_bios(&blkg_to_tg(blkg)->service_queue);
> 
> ...you also need the rcu_read_lock() here since you may encounter a
> (descendant) blkcg that's removed concurrently.

blkg_destroy() is protected by the queue_lock，so I think queue_lock can
protect such concurrent scenario.

Thanks,
Kuai
> 
> (I may miss some consequences of doing this under the queue_lock so if
> the concurrent removal is ruled out, please make a comment about it.)
> 
> 
> Regards,
> Michal
> 
