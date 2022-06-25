Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF955A81B
	for <lists+cgroups@lfdr.de>; Sat, 25 Jun 2022 10:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiFYIgj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jun 2022 04:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiFYIgj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jun 2022 04:36:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5B313BF;
        Sat, 25 Jun 2022 01:36:38 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LVS2m62Ydz1KC6N;
        Sat, 25 Jun 2022 16:34:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 16:36:35 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 16:36:34 +0800
Subject: Re: [PATCH -next v5 4/8] blk-throttle: fix io hung due to config
 updates
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, <tj@kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220528064330.3471000-1-yukuai3@huawei.com>
 <20220528064330.3471000-5-yukuai3@huawei.com>
 <20220622172621.GA28246@blackbody.suse.cz>
 <f5165488-2461-8946-593f-14154e404850@huawei.com>
 <20220623162620.GB16004@blackbody.suse.cz>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <75b3cdcc-1aa3-7259-4900-f09a2a081716@huawei.com>
Date:   Sat, 25 Jun 2022 16:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220623162620.GB16004@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/06/24 0:26, Michal Koutný 写道:
> On Thu, Jun 23, 2022 at 08:27:11PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>>> Here we may allow to dispatch a bio above current slice's
>>> calculate_bytes_allowed() if bytes_skipped is already >0.
>>
>> Hi, I don't expect that to happen. For example, if a bio is still
>> throttled, then old slice is keeped with proper 'bytes_skipped',
>> then new wait time is caculated based on (bio_size - bytes_skipped).
>>
>> After the bio is dispatched(I assum that other bios can't preempt),
> 
> With this assumptions it adds up as you write. I believe we're in
> agreement.
> 
> It's the same assumption I made below (FIFO everywhere, i.e. no
> reordering). So the discussed difference shouldn't really be negative
> (and if the assumption didn't hold, so the modular arithmetic yields
> corerct bytes_skipped value).
Yes, nice that we're in aggreement.

I'll wait to see if Tejun has any suggestions.

Thanks,
Kuai
> 
> Michal
> .
> 
