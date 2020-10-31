Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE552A1251
	for <lists+cgroups@lfdr.de>; Sat, 31 Oct 2020 02:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgJaBPn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Oct 2020 21:15:43 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54547 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgJaBPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Oct 2020 21:15:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UDgCrVb_1604106938;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDgCrVb_1604106938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 31 Oct 2020 09:15:39 +0800
Subject: Re: [PATCH v20 02/20] mm/memcg: bail early from swap accounting if
 memcg disabled
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-3-git-send-email-alex.shi@linux.alibaba.com>
 <20201029134648.GC599825@cmpxchg.org>
 <96b6d122-df0e-dfb0-368c-6bd714fab116@linux.alibaba.com>
 <20201030140420.GB666074@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8f288275-da78-335d-e83d-7e073fcd3b88@linux.alibaba.com>
Date:   Sat, 31 Oct 2020 09:13:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201030140420.GB666074@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/10/30 下午10:04, Johannes Weiner 写道:
>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>
>>> This should go in before the previous patch that adds the WARN for it.
>> Right, but than the long ops may not weird. Should I remove the ops and resend the whole patchset?
> You mean the warning in the changelog? I think that's alright. You can
> just say that you're about to remove the !page->memcg check in the
> next patch because the original reasons for having it are gone, and
> memcg being disabled is the only remaining exception, so this patch
> makes that check explicit in preparation for the next.
> 
> Sorry, it's all a bit of a hassle, I just wouldn't want to introduce a
> known warning into the kernel between those two patches (could confuse
> bisection runs, complicates partial reverts etc.)

H Johannes,

I see, I will exchange the 1st and 2nd patch place with above comments in commit log.
I guess you could give more comments on other patches, so I am going to wait you for
more comments and send v21 as a whole. :)

Many thanks!
Alex 
