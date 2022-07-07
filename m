Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16631569B22
	for <lists+cgroups@lfdr.de>; Thu,  7 Jul 2022 09:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiGGHAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Jul 2022 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiGGG7m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Jul 2022 02:59:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A45B1E9;
        Wed,  6 Jul 2022 23:59:15 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LdnKj22SLzkX3Y;
        Thu,  7 Jul 2022 14:57:45 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 14:59:13 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 14:59:13 +0800
Message-ID: <66a1d60d-b6a7-7d7e-6c70-e75456bc828c@huawei.com>
Date:   Thu, 7 Jul 2022 14:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [Question] The system may be stuck if there is a cpu cgroup
 cpu.cfs_quato_us is very low
To:     Tejun Heo <tj@kernel.org>, Benjamin Segall <bsegall@google.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <vschneid@redhat.com>, <dietmar.eggemann@arm.com>,
        <bristot@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        <mgorman@suse.de>
References: <5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com>
 <YrlrBmF3oOfS3+fq@mtj.duckdns.org>
 <f0f55f89-14db-de29-c182-32539f8d4e4d@huawei.com>
 <xm26czeoioju.fsf@google.com> <Yr9V755mL6jr20c2@mtj.duckdns.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <Yr9V755mL6jr20c2@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/7/2 4:15, Tejun Heo 写道:
> On Fri, Jul 01, 2022 at 01:08:21PM -0700, Benjamin Segall wrote:
>> Yes, fixing (kernel) priority inversion due to CFS_BANDWIDTH requires a
>> serious reworking of how it works, because it would need to dequeue
>> tasks individually rather than doing the entire cfs_rq at a time (and
>> would require some effort to avoid pinging every throttling task to get
>> it into the kernel).
> 
> Right, I don't have a good idea on evolving the current implementation
> into something correct. As you pointed out, we need to account along
> the sched_group tree but conditionally enforce on each thread.
> 
> Thanks.
> 

Understood. Thanks for your detailed explanation.

Thanks.
--
Qiao
.
