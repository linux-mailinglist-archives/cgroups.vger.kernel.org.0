Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CFFBFFE
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 07:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKNGCZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 01:02:25 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37076 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfKNGCZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 01:02:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Ti22RJM_1573711340;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ti22RJM_1573711340)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Nov 2019 14:02:21 +0800
Subject: Re: [PATCH v2 6/8] mm/lru: remove rcu_read_lock to fix performance
 regression
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-7-git-send-email-alex.shi@linux.alibaba.com>
 <20191112143844.GB7934@bombadil.infradead.org>
 <a6bb6739-cc00-cf9f-cd69-6016ce93e054@linux.alibaba.com>
 <20191113114045.GZ3016@techsingularity.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e286a02f-f377-34a9-a195-b827c54b969d@linux.alibaba.com>
Date:   Thu, 14 Nov 2019 14:02:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191113114045.GZ3016@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/13 下午7:40, Mel Gorman 写道:
>> Hi Matthew,
>>
>> Very sorry for your time! The main reasons I use a separate patch since a, Intel 0day asking me to credit their are founding, and I don't know how to give a clearly/elegant explanation for a non-exist regression in a fixed patch. b, this regression is kindly pretty tricky.  Maybe it's better saying thanks in version change log of cover-letter?
>>
> Add something like this to the patch
> 
> [lkp@intel.com: Fix RCU-related regression reported by LKP robot]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

It's a good idea! Thanks a lot, Mel!
