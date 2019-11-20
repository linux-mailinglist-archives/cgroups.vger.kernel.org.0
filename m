Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8868A103912
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2019 12:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfKTLtI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Nov 2019 06:49:08 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46325 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727619AbfKTLtH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Nov 2019 06:49:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0Tie.IxI_1574250537;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tie.IxI_1574250537)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 19:48:58 +0800
Subject: Re: [PATCH v4 9/9] mm/lru: revise the comments of lru_lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-10-git-send-email-alex.shi@linux.alibaba.com>
 <20191119161958.GE382712@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f122583d-8041-3c05-1177-1a0d43e69e4f@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 19:48:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191119161958.GE382712@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2019/11/20 ÉÏÎç12:19, Johannes Weiner Ð´µÀ:
> On Tue, Nov 19, 2019 at 08:23:23PM +0800, Alex Shi wrote:
>> Since we changed the pgdat->lru_lock to lruvec->lru_lock, it's time to
>> fix the incorrect comments in code. Also fixed some zone->lru_lock comment
>> error from ancient time. etc.
>>
>> Originally-from: Hugh Dickins <hughd@google.com>
> 
> You can resubmit a patch written by somebody else, but you need to
> preserve authorship such that git can attribute it properly:
> 
> 	From: Hugh Dickins <hughd@google.com>
> 
> in the patch header, as well as
> 
> 	Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> in the changelog tags. It should look something like this:
> 
> ---
> From: Hugh Dickins <hughd@google.com>
> Subject: [PATCH] mm/memcg: update lru_lock Doc and comments
> 
> Update scattered references from "zone_lru_lock" to "lruvec->lru_lock"
> (in low-level descriptions) or "lruvec lock" (where that reads better).
> 
> In the course of doing so, update lock ordering comments in mm/rmap.c
> and mm/filemap.c and Documentation/cgroups/memory.txt - slightly, with
> no attempt to be complete (swap_lock, in particular, left out-of-date).
> Remove allusions to set_page_dirty under page_remove_rmap: gone in v3.9.
> 
> memcg_test.txt looks quite out-of-date: just give LRU a short paragraph.
> Replaced zone by node throughout unevictable-lru.txt (except for stats).
> Leave Documentation/locking/lockstat.txt untouched this time: it doesn't
> matter if that still refers to zone->lru_lock, along with other history.
> 
> I struggled to understand the comment above move_pages_to_lru() (surely
> it never calls page_referenced()), and eventually realized that most of
> it had got separated from shrink_active_list(): move that comment back.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> ---
> 

Thanks for teaching!
