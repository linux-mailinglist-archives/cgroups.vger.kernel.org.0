Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA34C8CFF
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiCANzN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiCANzN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 08:55:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06245A0BE;
        Tue,  1 Mar 2022 05:54:31 -0800 (PST)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K7JXG75DRz1GBx4;
        Tue,  1 Mar 2022 21:49:50 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 21:54:29 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 21:54:28 +0800
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
To:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org> <Yhxnkg0AEaj36t+a@T590>
 <YhyYpWHGVhs3J/dk@infradead.org> <Yh31bQu3gbXoDBuK@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <836f0686-4ac8-327d-2bab-64a762ea8673@huawei.com>
Date:   Tue, 1 Mar 2022 21:54:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yh31bQu3gbXoDBuK@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/03/01 18:29, Ming Lei Ð´µÀ:
> On Mon, Feb 28, 2022 at 01:40:53AM -0800, Christoph Hellwig wrote:
>> On Mon, Feb 28, 2022 at 02:11:30PM +0800, Ming Lei wrote:
>>>> FYI, this crashed left rigt and center when running xfstests with
>>>> traces pointing to throtl_pending_timer_fn.
>>>
>>> Can you share the exact xfstests test(fs, test)? Or panic log?
>>>
>>> I can't reproduce it when running './check -g auto' on XFS, meantime
>>> tracking throtl_pending_timer_fn().
>>
>>  From a quick run using f2fs:
>>
>> generic/081 files ... [  316.487861] run fstests generic/081 at 2022-02-28 09:38:40
> 
> Thanks for providing the reproducer.
> 
> The reason is that the pending timer is deleted in blkg's release
> handler, so the timer can still be live after request queue is released.
> 
> The patch of 'block: cancel all throttled bios in del_gendisk()' should just
> make it easier to trigger.
> 
> After patch of "block: move blkcg initialization/destroy into disk allocation/
> release handler" lands, the issue can be fixed easily by:

Hi,

Thanks for locating this problem,

Perhaps this patch should wait for the problem to be solved.

Thanks,
Kuai
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index fa063c6c0338..e8d4be5e1de3 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -82,6 +82,7 @@ static void blkg_free(struct blkcg_gq *blkg)
>   		if (blkg->pd[i])
>   			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>   
> +	blk_put_queue(blkg->q);
>   	free_percpu(blkg->iostat_cpu);
>   	percpu_ref_exit(&blkg->refcnt);
>   	kfree(blkg);
> @@ -297,9 +298,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>   	blkg->online = true;
>   	spin_unlock(&blkcg->lock);
>   
> -	if (!ret)
> +	if (!ret && blk_get_queue(q))
>   		return blkg;
> -
> +	else if (!ret)
> +		ret = -ENODEV;
>   	/* @blkg failed fully initialized, use the usual release path */
>   	blkg_put(blkg);
>   	return ERR_PTR(ret);
> 
> 
> Thanks,
> Ming
> 
> .
> 
