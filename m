Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B88125D1F
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLSI7p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 19 Dec 2019 03:59:45 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47135 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbfLSI7p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 03:59:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TlL..BY_1576745976;
Received: from 30.30.208.2(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TlL..BY_1576745976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Dec 2019 16:59:37 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20191218140952.GA255739@chrisdown.name>
Date:   Thu, 19 Dec 2019 16:59:36 +0800
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com,
        Yang Shi <yang.shi@linux.alibaba.com>, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <25AA9500-B249-42C2-B162-2B8D4EE83BB0@linux.alibaba.com>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
 <20191218140952.GA255739@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> 在 2019年12月18日，22:09，Chris Down <chris@chrisdown.name> 写道：
> 
> Hi Hui,
> 
> In general cgroup v1 is in maintenance mode -- that is, excepting specific bugfixes, we don't plan to add new features.

Hi Chris,


Thanks for your review.

I will move to v2.

> 
> Hui Zhu writes:
>> Currently, memcg has some config to limit memory usage and config
>> the shrink behavior.
>> In the memory-constrained environment, put different priority tasks
>> into different cgroups with different memory limits to protect the
>> performance of the high priority tasks.  Because the global memory
>> shrink will affect the performance of all tasks.  The memory limit
>> cgroup can make shrink happen inside the cgroup.  Then it can decrease
>> the memory shrink of the high priority task to protect its performance.
>> 
>> But the memory footprint of the task is not static.  It will change as
>> the working pressure changes.  And the version changes will affect it too.
>> Then set the appropriate memory limit to decrease the global memory shrink
>> is a difficult job and lead to wasted memory or performance loss sometimes.
>> 
>> This commit adds global shrink priority to memcg to try to handle this
>> problem.
> 
> I have significant concerns with exposing scan priority to userspace. This is an incredibly difficult metric for users to reason about since it's a reclaim implementation feature and would add to an already confusing and fragmented API in v1.
> 
> Have you considered using memory protection (memory.low, memory.min) for this instead? It sounds like it can achieve the results you want, in that it allows you to direct and prioritise reclaim in a way that allows for ballparking (ie. it is compatible with applications with variable memory footprints).
> 

Memory.min, low, high can affect the global shrink behavior.  They can help task keep some pages to help protect performance.

But what I want is the low priority tasks (the tasks that performance is not very important) do more shrink first.  And when low priority tasks doesn’t have enough pages to be dropped and system need more free page, shrink the high priority task’s pages.  Because at this time, system’s stable is more important than the performance of priority task.
With memory.min and memory.low, I have no idea to config them to support this.  That is why I add global shrink priority.

Thanks,
Hui

> Thanks,
> 
> Chris

