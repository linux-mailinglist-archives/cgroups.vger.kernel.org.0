Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848F21276B6
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2019 08:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfLTHsy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 20 Dec 2019 02:48:54 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37385 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfLTHsy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Dec 2019 02:48:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TlPlhLn_1576828129;
Received: from 30.30.208.24(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TlPlhLn_1576828129)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Dec 2019 15:48:50 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20191219112618.GA72828@chrisdown.name>
Date:   Fri, 20 Dec 2019 15:48:49 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, shakeelb@google.com,
        Yang Shi <yang.shi@linux.alibaba.com>, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1A189775-3B43-4C49-B827-15D001C2D2FC@linux.alibaba.com>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
 <20191218140952.GA255739@chrisdown.name>
 <25AA9500-B249-42C2-B162-2B8D4EE83BB0@linux.alibaba.com>
 <20191219112618.GA72828@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> 在 2019年12月19日，19:26，Chris Down <chris@chrisdown.name> 写道：
> 
> Hi Hui,
> 
> teawater writes:
>> Memory.min, low, high can affect the global shrink behavior.  They can help task keep some pages to help protect performance.
>> 
>> But what I want is the low priority tasks (the tasks that performance is not very important) do more shrink first.  And when low priority tasks doesn’t have enough pages to be dropped and system need more free page, shrink the high priority task’s pages.  Because at this time, system’s stable is more important than the performance of priority task.
>> With memory.min and memory.low, I have no idea to config them to support this.  That is why I add global shrink priority.
> 
> For sure, that's what I'm suggesting you use memory.{min,low} for -- you define some subset of the cgroup hierarchy as "protected", and then you bias reclaim away from protected cgroups (and thus *towards* unprotected cgroups) by biasing the size of LRU scanning. See my patch that went into 5.4 and the examples in the commit message:
> 
>    commit 9783aa9917f8ae24759e67bf882f1aba32fe4ea1
>    Author: Chris Down <chris@chrisdown.name>
>    Date:   Sun Oct 6 17:58:32 2019 -0700
> 
>        mm, memcg: proportional memory.{low,min} reclaim
> 
> You can see how we're using memory.{low,min} to achieve this in this case study[0]. It's not exactly equivalent technically to your solution, but the end goals are similar.
> 
> Thanks,
> 
> Chris
> 
> 0: https://facebookmicrosites.github.io/cgroup2/docs/overview.html#case-study-the-fbtax2-project

Hi Chris,

Really appreciate for your help.  I will try to use it handle my problem.

Best,
Hui
