Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB0562CC0
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGAHeq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGAHep (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 03:34:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960AE4132B;
        Fri,  1 Jul 2022 00:34:44 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LZ6NR3mhQz1L8fQ;
        Fri,  1 Jul 2022 15:32:23 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 15:34:42 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 15:34:42 +0800
Message-ID: <f0f55f89-14db-de29-c182-32539f8d4e4d@huawei.com>
Date:   Fri, 1 Jul 2022 15:34:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [Question] The system may be stuck if there is a cpu cgroup
 cpu.cfs_quato_us is very low
To:     Tejun Heo <tj@kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <vschneid@redhat.com>, <dietmar.eggemann@arm.com>,
        <bristot@redhat.com>, <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <mgorman@suse.de>
References: <5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com>
 <YrlrBmF3oOfS3+fq@mtj.duckdns.org>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <YrlrBmF3oOfS3+fq@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


Hi, tejun

Thanks for your reply.

在 2022/6/27 16:32, Tejun Heo 写道:
> Hello,
> 
> On Mon, Jun 27, 2022 at 02:50:25PM +0800, Zhang Qiao wrote:
>> Becuase the task cgroup's cpu.cfs_quota_us is very small and
>> test_fork's load is very heavy, the test_fork may be throttled long
>> time, therefore, the cgroup_threadgroup_rw_sem read lock is held for
>> a long time, other processes will get stuck waiting for the lock:
> 
> Yeah, this is a known problem and can happen with other locks too. The
> solution prolly is only throttling while in or when about to return to
> userspace. There is one really important and wide-spread assumption in
> the kernel:
> 
>   If things get blocked on some shared resource, whatever is holding
>   the resource ends up using more of the system to exit the critical
>   section faster and thus unblocks others ASAP. IOW, things running in
>   kernel are work-conserving.
> 
> The cpu bw controller gives the userspace a rather easy way to break
> this assumption and thus is rather fundamentally broken. This is
> basically the same problem we had with the old cgroup freezer
> implementation which trapped threads in random locations in the
> kernel.
> 

so, if we want to completely slove this problem, is the best way to
change the cfs bw controller throttle mechanism? for example, throttle
tasks in a safe location.

Thanks.
    Qiao

> So, right now, it's rather broken and can easily be used as an dos
> attack vector.
> 
> Thanks.
> 
