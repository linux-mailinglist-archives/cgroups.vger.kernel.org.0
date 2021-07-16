Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3D3CBA32
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhGPQBh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 12:01:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47694 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhGPQBf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 12:01:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210716155839euoutp0276f63011465c0a730659bf5e89157c9f~SUKz6e4yA0500305003euoutp02b
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 15:58:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210716155839euoutp0276f63011465c0a730659bf5e89157c9f~SUKz6e4yA0500305003euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626451119;
        bh=+MzerVI9mU/S0yInCgp08mtqd2wbklS0uGBuLN3t2Eo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YB/tnct5K/+cw6LPBp4gM99lKw6wQo22aVZQ6mD8ULfjVLYNw8bfNDQJO5HLxrYb6
         EXI+43iGv0uYhUqsV655dR1tDhjwueU/oqHrb0k6CSY7sepCPLUu3QMm5QHHGvHM19
         G4Vyj3pK9QI5RgOfOmLNe3T4FNO+sQ1gg+0rktb8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210716155838eucas1p1490a1a7da958a58071b2e7cbcc1dbba0~SUKzhAOJ00178501785eucas1p1N;
        Fri, 16 Jul 2021 15:58:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 57.28.42068.EACA1F06; Fri, 16
        Jul 2021 16:58:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210716155838eucas1p20b34d742a9a7bbf27eb9571d97d9e945~SUKzEBRxv2938729387eucas1p2K;
        Fri, 16 Jul 2021 15:58:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210716155838eusmtrp15fb9a0df962fed118dfe776aa875c9d1~SUKzDIgZh2467124671eusmtrp1U;
        Fri, 16 Jul 2021 15:58:38 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-69-60f1acae8975
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.51.31287.EACA1F06; Fri, 16
        Jul 2021 16:58:38 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210716155837eusmtip16dc968efdd470cd6ffc0d7275d8ed83a~SUKyNzEC52587825878eusmtip1i;
        Fri, 16 Jul 2021 15:58:37 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] memcg: infrastructure to flush memcg stats
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <75599651-b3eb-45a7-56c8-f83546650c94@samsung.com>
Date:   Fri, 16 Jul 2021 17:58:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CALvZod5SONQ6=ewesLhMSampu=sxbA3iDS3f+rsHkEUY5G2Cyg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87rr1nxMMNjzUtdizvo1bBY3ls9g
        sfg66QKbxepNvhYHfj5nsbi8aw6bxb01/1ktXn9bxmwxd9Z+FouD114zWhy8f47Z4tfyo4wW
        J2dNZnHg9fh3Yg2bx+E375k9Jja/Y/dYsKnUY/Gel0wem1Z1snls+jSJ3ePEjN8sHpNeuHus
        33KVxePzJrkA7igum5TUnMyy1CJ9uwSujCfdDawFJ+Qqbk24x9LAeE+ii5GTQ0LARGLNjj7W
        LkYuDiGBFYxAzhJGCOcLo8TbtxtYIJzPjBKT7q1ih2n5du4LE0RiOaPEqc5VrCAJIYGPjBK7
        bniC2MICbhIHr2xlAbFFBNQkPi+fBDaWWWAfs8TcPyfAJrEJGEp0ve1iA7F5BewkTt98zARi
        swioSvxadxYsLiqQLHHn9HuoGkGJkzOfAA3l4OAUCJT41JsGEmYWkJfY/nYOM4QtLnHryXwm
        iEM3c0r8+FMHYbtIrLlwgRnCFpZ4dXwL1DMyEqcn94B9KSHQzCjx8Nxadginh1HictMMRogq
        a4k7536xgSxmFtCUWL9LHyLsKHH//nkmkLCEAJ/EjbeCEDfwSUzaNp0ZIswr0dEmBFGtJjHr
        +Dq4tQcvXGKewKg0C8ljs5B8MwvJN7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yf
        u4kRmPRO/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuH9VvMxQYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjhv0pY18UIC6YklqdmpqQWpRTBZJg5OqQYm4d2HpaS3LA/ZLlusUOx6sHbipuMhFx/8bp82
        uct7yvftc2MfiyVtWTd9lpHUFHXjZ18Egyy/HhP4rndP7tmv7t4J+zhqpfbv47oko+0st1b8
        t4i0xtZV8qGSDzfX9xjtUDOOU/Dcff5p5dy9BfHztdx71gb977795Xj31wVKW7T9dZb1Vm29
        Oql3Yvg6QUH31O79c1Z5Xp/oovh/x8OV68xSFN2ffL62QXO9jDCH2GzFbaGyb/cXzJw80X3N
        dGslBi+r5FOXM6P3HHV07Fj9kWuWZIvz3IdHJd5NX/OA94f2Ecnkw9tWXfPljDIXkOZhUN2+
        WuS/oX3789LDHj8+PAm92sf3+LAu2/TDMTcSPyixFGckGmoxFxUnAgB6ue696QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+917d70mo9uc+EPKar2DNu9y605KhF5XKnpY0IPYlt3Ucpvt
        bj2kYJEILnI2QXSpxXpYOa2m5rQgN8sHkQWVlJEZSZo91pxaTrGcK/C/D+d8PxwO5xCoYACL
        ITK0BlavVWeK8JnY04nW9yurHT5VXIlrFl16x4HTbyqKMXrY+gKnK51b6abRPox+2ViK092O
        Pzz668gNlC6zPcJod+dXQLs/dKB0oOIJoNtthVgSn5loc+BM8zcvylw89yOMueI0MlcffkEY
        5+08nHEOWsOYtuIxjLH2b2Lu1L7GGL8zdnvEPvEavc5oYOen6zjDWtF+ipaKKQUtlsYrxNSq
        1QcSpDKRJHHNITYz4zirlySqxOm95028rLbYk10F3ZgJdEMzCCcgGQ9HOoYQM5hJCMjrAE60
        W8JCjTmwvcjEC3EkHO8046GQF8BAXeFUI5LcCN2v6rAgC8kl0F9hBcEQSjah0PXI889oQKCr
        bxAPpnCSgubv5inmk4nw6dtPSJAxcjEMVD+bqkeRqTB/qACEMrNhe0nv5ASCCCd3wMELh4Nl
        lJTD8pqPaIjnwfrvpf84Gnb1XkYKgMA2zbZNU2zTFNs05QrAbgMha+Q0aRqOEnNqDWfUpolT
        dRonmDz6/ZbRGhcoH/CJPQAhgAdAAhUJ+SOnfSoB/5D6VDar1yn1xkyW8wDZ5DoX0ZioVN3k
        12gNSkoeJ6Pi5Yo4mUK+ShTNrytzKAVkmtrAHmXZLFb/30OI8BgTgvy4NLuI7RBGj2w6UNef
        YN+1KCF3w6uqe225uNnaGvjNG/M6cUmLp2tI7orYI9EOW2qTH3d4NyYX733/5FpzninqgWBW
        Df9bbSEhnzvwJeBbcWJUuqss+c0Np6+6PuVIoPLuhdU/b42jSMLudUnrI97m9inl/q3CxhLN
        cuvOFErt+2QZ6jMfOyPpb6V6qn75e4Saj+P2s3ZVXPTxxoLO5IHNB5fm5yMtVWf3LMshM2L9
        z7O3KWa4SinXGLXobnNDVrZFlvd57v2FPfZUuLzynqWJc0cO5xQtyG+8eWJxTq9Euj+b591n
        V8WvLG/oT0l65wm7SivVrSJ5vbuM2CLCuHQ1tQLVc+q/wT8gnH0DAAA=
X-CMS-MailID: 20210716155838eucas1p20b34d742a9a7bbf27eb9571d97d9e945
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210716150353eucas1p2c9ad1d1021ee584de587e5ec10b8467b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210716150353eucas1p2c9ad1d1021ee584de587e5ec10b8467b
References: <20210714013948.270662-1-shakeelb@google.com>
        <CGME20210716150353eucas1p2c9ad1d1021ee584de587e5ec10b8467b@eucas1p2.samsung.com>
        <20210714013948.270662-2-shakeelb@google.com>
        <78005c4c-9233-7bc8-d50e-e3fe11f30b5d@samsung.com>
        <CALvZod5SONQ6=ewesLhMSampu=sxbA3iDS3f+rsHkEUY5G2Cyg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 16.07.2021 17:14, Shakeel Butt wrote:
> Hi Marek
>
> On Fri, Jul 16, 2021 at 8:03 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi,
>>
>> On 14.07.2021 03:39, Shakeel Butt wrote:
>>> At the moment memcg stats are read in four contexts:
>>>
>>> 1. memcg stat user interfaces
>>> 2. dirty throttling
>>> 3. page fault
>>> 4. memory reclaim
>>>
>>> Currently the kernel flushes the stats for first two cases. Flushing the
>>> stats for remaining two casese may have performance impact. Always
>>> flushing the memcg stats on the page fault code path may negatively
>>> impacts the performance of the applications. In addition flushing in the
>>> memory reclaim code path, though treated as slowpath, can become the
>>> source of contention for the global lock taken for stat flushing because
>>> when system or memcg is under memory pressure, many tasks may enter the
>>> reclaim path.
>>>
>>> This patch uses following mechanisms to solve these challenges:
>>>
>>> 1. Periodically flush the stats from root memcg every 2 seconds. This
>>> will time limit the out of sync stats.
>>>
>>> 2. Asynchronously flush the stats after fixed number of stat updates.
>>> In the worst case the stat can be out of sync by O(nr_cpus * BATCH) for
>>> 2 seconds.
>>>
>>> 3. For avoiding thundering herd to flush the stats particularly from the
>>> memory reclaim context, introduce memcg local spinlock and let only one
>>> flusher active at a time. This could have been done through
>>> cgroup_rstat_lock lock but that lock is used by other subsystem and for
>>> userspace reading memcg stats. So, it is better to keep flushers
>>> introduced by this patch decoupled from cgroup_rstat_lock.
>>>
>>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>> This patch landed in today's linux-next (next-20210716) as commit
>> 42265e014ac7 ("memcg: infrastructure to flush memcg stats"). On my test
>> system's I found that it triggers a kernel BUG on all ARM64 boards:
>>
>>    BUG: sleeping function called from invalid context at
>> kernel/cgroup/rstat.c:200
>>    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 7, name:
>> kworker/u8:0
>>    3 locks held by kworker/u8:0/7:
>>     #0: ffff00004000c938 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
>> process_one_work+0x200/0x718
>>     #1: ffff80001334bdd0 ((stats_flush_dwork).work){+.+.}-{0:0}, at:
>> process_one_work+0x200/0x718
>>     #2: ffff8000124f6d40 (stats_flush_lock){+.+.}-{2:2}, at:
>> mem_cgroup_flush_stats+0x20/0x48
>>    CPU: 2 PID: 7 Comm: kworker/u8:0 Tainted: G        W 5.14.0-rc1+ #3713
>>    Hardware name: Raspberry Pi 4 Model B (DT)
>>    Workqueue: events_unbound flush_memcg_stats_dwork
>>    Call trace:
>>     dump_backtrace+0x0/0x1d0
>>     show_stack+0x14/0x20
>>     dump_stack_lvl+0x88/0xb0
>>     dump_stack+0x14/0x2c
>>     ___might_sleep+0x1dc/0x200
>>     __might_sleep+0x4c/0x88
>>     cgroup_rstat_flush+0x2c/0x58
>>     mem_cgroup_flush_stats+0x34/0x48
>>     flush_memcg_stats_dwork+0xc/0x38
>>     process_one_work+0x2a8/0x718
>>     worker_thread+0x48/0x460
>>     kthread+0x12c/0x160
>>     ret_from_fork+0x10/0x18
>>
>> This can be also reproduced with QEmu. Please let me know if I can help
>> fixing this issue.
>>
> Thanks for the report. The issue can be fixed by changing
> cgroup_rstat_flush() to cgroup_rstat_flush_irqsafe() in
> mem_cgroup_flush_stats(). I will send out the updated patch in a
> couple of hours after a bit more testing.

Right, this fixes the issue on my test systems. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

to the fixup patch if the target kernel tree won't be rebased and the 
original patch (42265e014ac7) stays.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

