Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8555912CC26
	for <lists+cgroups@lfdr.de>; Mon, 30 Dec 2019 04:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfL3Dcr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Sun, 29 Dec 2019 22:32:47 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54162 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfL3Dcr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Dec 2019 22:32:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TmDf8Rf_1577676757;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TmDf8Rf_1577676757)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Dec 2019 11:32:43 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20191229140240.GB612003@chrisdown.name>
Date:   Mon, 30 Dec 2019 11:32:36 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <07AF5F95-23CB-4A7E-A9DA-8F67E22A7195@linux.alibaba.com>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
 <20191218140952.GA255739@chrisdown.name>
 <25AA9500-B249-42C2-B162-2B8D4EE83BB0@linux.alibaba.com>
 <20191219112618.GA72828@chrisdown.name>
 <1E6A7BC4-A983-4C65-9DA9-4D3A26D4D31D@linux.alibaba.com>
 <20191229140240.GB612003@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> 在 2019年12月29日，22:02，Chris Down <chris@chrisdown.name> 写道：
> 
> Hi Hui,
> 
> teawater writes:
>> In the memory-constrained and complex multitasking environment such as an Android system may require more complex performance priority.
>> For example, the tasks of app in the font, they need high priority because low priority will affect the user experience at once.
>> The tasks of app in background should have lower priority than the first one.  And sometime, each app should have different priority.  Because some apps are frequently used.  They should have high priority than other background apps.
>> The daemons should have lower priority than background apps.  Because most of them will not affect the user experience.
> 
> In general I don't think it's meaningful to speculate about whether it would help or not without data and evidence gathering. It would really depend on how the system is composed overall. Is this a real problem you're seeing, or just something hypothetical?
> 
> If there is a real case to discuss, we can certainly discuss it. That said, at the very least I think the API needs to be easier to reason about rather than just exposing mm internals, and there needs to be a demonstration that it solves a real problem and existing controls are insufficient :-)
> 
> Thanks,
> 
> Chris

Thanks!  Agree with you.

Best,
Hui
