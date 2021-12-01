Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DDC464A8E
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 10:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348205AbhLAJ3o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 04:29:44 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28207 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348199AbhLAJ3m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 04:29:42 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J3tvT1J3Mz8vnn;
        Wed,  1 Dec 2021 17:24:21 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 17:26:19 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 17:26:18 +0800
Subject: Re: [PATCH v2 2/2] block: cancel all throttled bios in del_gendisk()
To:     Tejun Heo <tj@kernel.org>
CC:     <hch@infradead.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20211130011730.2584339-1-yukuai3@huawei.com>
 <20211130011730.2584339-3-yukuai3@huawei.com>
 <YaZQqjjygHGFEdbx@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a30bfafa-82ed-0ac1-deac-afb83f29c805@huawei.com>
Date:   Wed, 1 Dec 2021 17:26:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YaZQqjjygHGFEdbx@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2021/12/01 0:26, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Tue, Nov 30, 2021 at 09:17:30AM +0800, Yu Kuai wrote:
>> +void blk_throtl_cancel_bios(struct request_queue *q)
>> +{
>> +	struct throtl_data *td = q->td;
>> +	struct blkcg_gq *blkg;
>> +	struct cgroup_subsys_state *pos_css;
>> +	struct bio *bio;
>> +	int rw;
>> +
>> +	rcu_read_lock();
> 
> So, all of the draining is being performed without holding the q lock, which
> *might* be okay given that we're in the del_gendisk path but is likely risky
> - ie. there can still be timers or whatever racing against it.

I'll hold queue_lock to draining bios in next iteration,

Thanks,
Kuai
> 
> Thanks.
> 
