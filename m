Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489AA42E641
	for <lists+cgroups@lfdr.de>; Fri, 15 Oct 2021 03:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhJOBul (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 21:50:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24316 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhJOBul (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 21:50:41 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVpw43R4TzbdC7;
        Fri, 15 Oct 2021 09:44:04 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 09:48:29 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 15 Oct 2021 09:48:29 +0800
Subject: Re: [PATCH v2 -next] blk-cgroup: synchoronize blkg creation against
 policy deactivation
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>,
        <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20211013124456.3186005-1-yukuai3@huawei.com>
 <YWi27oAU0v5v86eN@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6fc9eaa8-c367-f458-4ed9-94af60b55ca0@huawei.com>
Date:   Fri, 15 Oct 2021 09:48:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YWi27oAU0v5v86eN@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/10/15 7:02, Tejun Heo wrote:
> On Wed, Oct 13, 2021 at 08:44:56PM +0800, Yu Kuai wrote:
>> @@ -1401,6 +1406,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
>>   	if (queue_is_mq(q))
>>   		blk_mq_freeze_queue(q);
>>   
>> +	mutex_lock(&q->blkg_lock);
>>   	spin_lock_irq(&q->queue_lock);
> 
> Given that deactivation drains q_usage_counter through
> blk_mq_freeze_queue(), can't the blkg_conf_prep() just pin the usage count?
> 

In fact, the caller of blkcg_deactivate_policy() aready freeze the
queue, either from blk_cleanup_queue() or from elevator_switch().

Grab q_usage_counter in blk_conf_prep() can prevent concurrent with
blkcg_deactivate_policy(), I'm afraid will it be too much since it
will also be synchoronized with all the other freeze/unfreeze queues?

Thanks,
Kuai
