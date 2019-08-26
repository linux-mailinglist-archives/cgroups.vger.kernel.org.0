Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E79D1BF
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfHZOgX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 10:36:23 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60845 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfHZOgX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 10:36:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TaX0fOW_1566830174;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TaX0fOW_1566830174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Aug 2019 22:36:16 +0800
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <20190820104532.GP3111@dhcp22.suse.cz>
 <CALvZod7-dL90jwd2pywpaD8NfUByVU9Y809+RfvJABGdRASYUg@mail.gmail.com>
 <alpine.LSU.2.11.1908201038260.1286@eggly.anvils>
 <e9ac9c8c-15c1-8365-5c39-285c6d7b07a6@linux.alibaba.com>
 <alpine.LSU.2.11.1908231736001.16920@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <507fd148-37e1-23f9-ebb3-9a29f5ee51ac@linux.alibaba.com>
Date:   Mon, 26 Aug 2019 22:35:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1908231736001.16920@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/8/24 上午9:59, Hugh Dickins 写道:
> On Wed, 21 Aug 2019, Alex Shi wrote:
>> 在 2019/8/21 上午2:24, Hugh Dickins 写道:
>>> I'll set aside what I'm doing, and switch to rebasing ours to v5.3-rc
>>> and/or mmotm.  Then compare with what Alex has, to see if there's any
>>> good reason to prefer one to the other: if no good reason to prefer ours,
>>> I doubt we shall bother to repost, but just use it as basis for helping
>>> to review or improve Alex's.
>>
>> For your review, my patchset are pretty straight and simple.
>> It just use per lruvec lru_lock to replace necessary pgdat lru_lock.
>> just this.  We could talk more after I back to work. :)
> 
> Sorry to be bearer of bad news, Alex, but when you said "straight and
> simple", I feared that your patchset would turn out to be fundamentally
> too simple.
> 
> And that is so. I have only to see the
> 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> line in isolate_migratepages_block() in mm/compaction.c, and check
> that mem_cgroup_page_lruvec() is little changed in mm/mempolicy.c.
> 
> The central problem with per-memcg lru_lock is that you do not know
> for sure what lock to take (which memcg a page belongs to) until you
> have taken the expected lock, and then checked whether page->memcg
> is still the same - backing out and trying again if not.
> 
> Fix that central problem, and you end up with a more complicated
> patchset, much like ours.  It's true that when ours was first developed,
> the memcg situation was more complicated in several ways, and perhaps
> some aspects of our patchset could be simplified now (though I've not
> identified any).  Johannes in particular has done a great deal of
> simplifying work in memcg over the last few years, but there are still
> situations in which a page's memcg can change (move_charge_at_immigrate
> and swapin readahead spring to mind - or perhaps the latter is only an
> issue when MEMCG_SWAP is not enabled, I forget; and I often wonder if
> reparenting will be brought back one day).
> 
> I did not review your patchset in detail, and wasn't able to get very
> far in testing it.  At first I was put off by set_task_reclaim_state
> warnings from mm/vmscan.c, but those turned out to be in v5.3-rc5
> itself, not from your patchset or mine (but I've not yet investigated
> what's responsible for them).  Within a minute of starting swapping
> load, kcompactd compact_lock_irqsave() in isolate_migratepages_block()
> would deadlock, and I did not get further.  (Though I did also notice
> that booting the CONFIG_MEMCG=y kernel with "cgroup_disable=memory"
> froze in booting - tiresomely, one has to keep both the memcg and
> no-memcg locking to cope with that case, and I guess you had not.)
> 
> Rather than duplicating effort, I would advise you to give our patchset
> a try, and if it works for you, help towards getting that one merged:
> but of course, it's up to you.

Thanks a lot for all infos and reminders! Yes, the page->memcg change would be a problem. I will studying your patchset and try to merge them.

> 
> I've attached a tarfile of it rebased to v5.3-rc5: I do not want to
> spam the list with patches yet, because I do not have any stats or
> argument in support of the series, as Andrew asked for years ago and
> Michal asks again now.  But aside from that I consider it ready, and
> will let Shakeel take it over from here, while I get back to what I
> diverted from (but of course I'll try to answer questions on it).
> 
I will trying to look into them. Thanks for your kindly offer. :)

Thanks!
Alex
