Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1C270974
	for <lists+cgroups@lfdr.de>; Sat, 19 Sep 2020 02:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgISAdY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 20:33:24 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60155 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgISAdY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 20:33:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U9MBOmq_1600475598;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9MBOmq_1600475598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Sep 2020 08:33:19 +0800
Subject: Re: [PATCH 00/13] mm: clean up some lru related pieces
To:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200918030051.650890-1-yuzhao@google.com>
 <alpine.LSU.2.11.2009181317350.11298@eggly.anvils>
 <20200918210126.GA1118730@google.com>
 <alpine.LSU.2.11.2009181406410.11531@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <56062aa9-bec7-6757-e49b-f94da141cb2c@linux.alibaba.com>
Date:   Sat, 19 Sep 2020 08:31:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009181406410.11531@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/9/19 ÉÏÎç5:19, Hugh Dickins Ð´µÀ:
>>>> 2.28.0.681.g6f77f65b4e-goog
>>> Sorry, Yu, I may be out-of-line in sending this: but as you know,
>>> Alex Shi has a long per-memcg lru_lock series playing in much the
>>> same area (particularly conflicting in mm/swap.c and mm/vmscan.c):
>>> a patchset that makes useful changes, that I'm very keen to help
>>> into mmotm a.s.a.p (but not before I've completed diligence).
>>>
>>> We've put a lot of effort into its testing, I'm currently reviewing
>>> it patch by patch (my general silence indicating that I'm busy on that,
>>> but slow as ever): so I'm a bit discouraged to have its stability
>>> potentially undermined by conflicting cleanups at this stage.
>>>
>>> If there's general agreement that your cleanups are safe and welcome
>>> (Michal's initial reaction sheds some doubt on that), great: I hope
>>> that Andrew can fast-track them into mmotm, then Alex rebase on top
>>> of them, and I then re-test and re-review.
>>>
>>> But if that quick agreement is not forthcoming, may I ask you please
>>> to hold back, and resend based on top of Alex's next posting?
>> The per-memcg lru lock series seems a high priority, and I have
>> absolutely no problem accommodate your request.
> Many thanks!
> 
>> In return, may I ask you or Alex to review this series after you
>> have finished with per-memcg lru lock (to make sure that I resolve
>> all the conflicts correctly at least)?
> Fair enough: I promise to do so.
> 
> And your rebasing will necessarily lead you to review some parts
> of Alex's patchset, which will help us all too.
> 
> Andrew, Yu asked at the start:
>>>> I see you have taken this:
>>>>   mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
>>>> Do you mind dropping it?
> Dropping that for now will help too.

Hi Hugh & Yu,

Thanks for all your considerations! I will looking into this series after thing
on lru_lock finished.

Thanks a lot!
Alex
