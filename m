Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF75131D24
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2020 02:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAGB0W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jan 2020 20:26:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:7301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgAGB0V (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 6 Jan 2020 20:26:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 17:26:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="422314711"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2020 17:26:19 -0800
Date:   Tue, 7 Jan 2020 09:26:24 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200107012624.GB15341@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <CAKgT0Uf+EP8yGf93=R3XK0Y=0To0KQDys0O1BkG-Odej3Rwj5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uf+EP8yGf93=R3XK0Y=0To0KQDys0O1BkG-Odej3Rwj5A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 06, 2020 at 08:18:34AM -0800, Alexander Duyck wrote:
>On Fri, Jan 3, 2020 at 6:34 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> As all the other places, we grab the lock before manipulate the defer list.
>> Current implementation may face a race condition.
>>
>> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>
>> ---
>> I notice the difference during code reading and just confused about the
>> difference. No specific test is done since limited knowledge about cgroup.
>>
>> Maybe I miss something important?
>> ---
>>  mm/memcontrol.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index bc01423277c5..62b7ec34ef1a 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5368,12 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
>>         }
>>
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       spin_lock(&from->deferred_split_queue.split_queue_lock);
>>         if (compound && !list_empty(page_deferred_list(page))) {
>> -               spin_lock(&from->deferred_split_queue.split_queue_lock);
>>                 list_del_init(page_deferred_list(page));
>>                 from->deferred_split_queue.split_queue_len--;
>> -               spin_unlock(&from->deferred_split_queue.split_queue_lock);
>>         }
>> +       spin_unlock(&from->deferred_split_queue.split_queue_lock);
>>  #endif
>>         /*
>>          * It is safe to change page->mem_cgroup here because the page
>
>So I suspect the lock placement has to do with the compound boolean
>value passed to the function.
>

Hey, Alexander

Thanks for your comment.

>One thing you might want to do is pull the "if (compound)" check out
>and place it outside of the spinlock check. It would then simplify
>this signficantly so it is something like
>if (compound) {
>  spin_lock();
>  list = page_deferred_list(page);
>  if (!list_empty(list)) {
>    list_del_init(list);
>    from->..split_queue_len--;
>  }
>  spin_unlock();
>}
>
>Same for the block below. I would pull the check for compound outside
>of the spinlock call since it is a value that shouldn't change and
>would eliminate an unnecessary lock in the non-compound case.

This is reasonable, if no objection from others, I would change this in v2.


-- 
Wei Yang
Help you, Help me
