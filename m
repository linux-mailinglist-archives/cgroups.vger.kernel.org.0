Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391754977BF
	for <lists+cgroups@lfdr.de>; Mon, 24 Jan 2022 04:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiAXDsY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 23 Jan 2022 22:48:24 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31116 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiAXDsX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 23 Jan 2022 22:48:23 -0500
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JhwpQ0Sd1z1FCnk;
        Mon, 24 Jan 2022 11:44:30 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:48:21 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:48:20 +0800
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
To:     Ming Lei <ming.lei@redhat.com>, <tj@kernel.org>
CC:     <mkoutny@suse.com>, <paulmck@kernel.org>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
 <20220110134758.2233758-3-yukuai3@huawei.com> <Yd5FkuhYX9YcgQkZ@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <96bee53a-7d3b-5066-409c-6b2f203d2137@huawei.com>
Date:   Mon, 24 Jan 2022 11:48:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yd5FkuhYX9YcgQkZ@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/01/12 11:05, Ming Lei Ð´µÀ:
> Hello Yu Kuai,
> 
> On Mon, Jan 10, 2022 at 09:47:58PM +0800, Yu Kuai wrote:
>> Throttled bios can't be issued after del_gendisk() is done, thus
>> it's better to cancel them immediately rather than waiting for
>> throttle is done.
>>
>> For example, if user thread is throttled with low bps while it's
>> issuing large io, and the device is deleted. The user thread will
>> wait for a long time for io to return.
>>
>> Noted this patch is mainly from revertion of commit 32e3374304c7
>> ("blk-throttle: remove tg_drain_bios") and commit b77412372b68
>> ("blk-throttle: remove blk_throtl_drain").
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-throttle.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>>   block/blk-throttle.h |  2 ++
>>   block/genhd.c        |  2 ++
>>   3 files changed, 81 insertions(+)
> 
> Just wondering why not take the built-in way in throtl_upgrade_state() for
> canceling throttled bios? Something like the following, then we can avoid
> to re-invent the wheel.

Hi, Tejun


