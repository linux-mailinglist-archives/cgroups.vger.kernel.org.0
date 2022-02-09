Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67844AE6CD
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 03:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiBICkl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 21:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbiBIBWf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 20:22:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D254FC061576;
        Tue,  8 Feb 2022 17:22:33 -0800 (PST)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JthsS3FqNz9sNn;
        Wed,  9 Feb 2022 09:21:00 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 09:22:31 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 09:22:30 +0800
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
 <32b6949d-60b1-82ce-ae44-1cf089a78276@huawei.com>
 <YgK7J8TFyFvp/rv1@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <34ae7d06-4f6b-73f7-7299-65cb8859aad8@huawei.com>
Date:   Wed, 9 Feb 2022 09:22:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YgK7J8TFyFvp/rv1@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
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

ÔÚ 2022/02/09 2:49, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Tue, Feb 08, 2022 at 09:38:33AM +0800, yukuai (C) wrote:
>> 3) If we limit iops to 8 for each client from server, client should work
>> fine, however, server can receive 64 x 8 = 512 io at most at the same
>> time, which might cause too much pressure on the server.(maybe bps is
>> more appropriate to explain the high pressure).
> 
> I don't follow this part. Why can't the server control however it wanna
> control?

Hi,

Do you agree that the server can't control how many io it can receives
from one client if we limit from server? I think the difference is that
limit from client can control it...

Thanks,
Kuai
> 
> Thanks.
> 
