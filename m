Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF85579CB
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiFWMEa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiFWME2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 08:04:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FB48E50;
        Thu, 23 Jun 2022 05:04:24 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTJm01YXWzkWYG;
        Thu, 23 Jun 2022 20:02:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 20:03:53 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 20:03:53 +0800
Subject: Re: [PATCH -next v5 3/8] blk-throttle: factor out code to calculate
 ios/bytes_allowed
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220528064330.3471000-1-yukuai3@huawei.com>
 <20220528064330.3471000-4-yukuai3@huawei.com>
 <20220622172706.GA28777@blackbody.suse.cz>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <21aabcb3-9801-f159-103c-9e1c35983237@huawei.com>
Date:   Thu, 23 Jun 2022 20:03:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220622172706.GA28777@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi，

在 2022/06/23 1:27, Michal Koutný 写道:
> On Sat, May 28, 2022 at 02:43:25PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>> +static u64 calculate_bytes_allowed(u64 bps_limit,
>> +				   unsigned long jiffy_elapsed_rnd)
> 
> Just noticed with all series applied this argument needn't be called
> _rnd. (It's a nit.)
> 

Yes, you're right. I'll change that in next version.

Thanks,
Kuai
