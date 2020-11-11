Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0733E2AF0B6
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 13:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgKKMgr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 07:36:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:34164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKKMgq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 07:36:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3CC0ABDE;
        Wed, 11 Nov 2020 12:36:44 +0000 (UTC)
Subject: Re: [PATCH v21 05/19] mm/vmscan: remove unnecessary lruvec adding
To:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-6-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c07810ed-31b7-7b9b-9638-cfc7574f4a2d@suse.cz>
Date:   Wed, 11 Nov 2020 13:36:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-6-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/20 9:55 AM, Alex Shi wrote:
> We don't have to add a freeable page into lru and then remove from it.
> This change saves a couple of actions and makes the moving more clear.
> 
> The SetPageLRU needs to be kept before put_page_testzero for list
> integrity, otherwise:
> 
>    #0 move_pages_to_lru             #1 release_pages
>    if !put_page_testzero
>       			           if (put_page_testzero())
>       			              !PageLRU //skip lru_lock
>       SetPageLRU()
>       list_add(&page->lru,)
>                                           list_add(&page->lru,)
> 
> [akpm@linux-foundation.org: coding style fixes]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nice cleanup!
