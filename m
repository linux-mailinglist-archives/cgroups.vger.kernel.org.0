Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C474ACE76
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 02:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiBHBzc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 20:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiBHBzc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 20:55:32 -0500
X-Greylist: delayed 1014 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 17:55:31 PST
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C934C061355;
        Mon,  7 Feb 2022 17:55:30 -0800 (PST)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jt5CM6X25zZdZp;
        Tue,  8 Feb 2022 09:34:23 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 09:38:34 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 09:38:34 +0800
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in cgroup
 v2
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220114093000.3323470-1-yukuai3@huawei.com>
 <YfGE9L4i7DtNTo08@slm.duckdns.org>
 <235b0757-d322-2b6e-3ab6-ecc8c82f8f1e@huawei.com>
 <Yflr4FzUTWsiLTC/@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <32b6949d-60b1-82ce-ae44-1cf089a78276@huawei.com>
Date:   Tue, 8 Feb 2022 09:38:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yflr4FzUTWsiLTC/@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

ÔÚ 2022/02/02 1:20, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Thu, Jan 27, 2022 at 10:36:38AM +0800, yukuai (C) wrote:
>> In our case, the disk is provided by server, and such disk can be shared
>> by multipul clients. Thus for the client side, the server is a higher
>> level parent.
>>
>> Theoretically, limit the io from server for each client is feasible,
>> however, the main reason we don't want to do this is the following
>> shortcoming:
>>
>> client can still send io to server unlimited, we can just limit the
>> amount of io that can complete from server, which might cause too much
>> pressure on the server side.
> 
> I don't quite follow the "send io to server unlimited" part. Doesn't that
> get limited by available number of requests? 

Hi, Tejun

Here I mean that io is not limited through io throttle from client. Of
course io must be limited by avaliable number of requests.

> ie. if the server throttles,
> the in-flight requests will take longer to complete which exhausts the
> available requests and thus slows down the client.

For example, if we have 8 clients, and available requests is 64.

1) If we don't limit iops, and each client send 64 io to server, some
client might have performance issue.

2) If we limit iops to 8 from clients, then server can receive 64 io at
most at the same time, both client and server should work fine.

3) If we limit iops to 8 for each client from server, client should work
fine, however, server can receive 64 x 8 = 512 io at most at the same
time, which might cause too much pressure on the server.(maybe bps is
more appropriate to explain the high pressure).

Thus I prefer to limit io from client.

Thanks,
Kuai
> That's how it's supposed
> to work on the local machine too.
> 
> Thanks.
> 
