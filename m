Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3122AF785
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKKRqf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 12:46:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:58660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKRqf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 12:46:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A8E8AB95;
        Wed, 11 Nov 2020 17:46:33 +0000 (UTC)
Subject: Re: [PATCH v21 17/19] mm/lru: replace pgdat lru_lock with lruvec lock
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
Cc:     Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-18-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <337c6223-a469-123e-7f53-963b0a1cc164@suse.cz>
Date:   Wed, 11 Nov 2020 18:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-18-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/20 9:55 AM, Alex Shi wrote:
> This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
> each of memcg per node. So on a large machine, each of memcg don't
> have to suffer from per node pgdat->lru_lock competition. They could go
> fast with their self lru_lock.
> 
> After move memcg charge before lru inserting, page isolation could
> serialize page's memcg, then per memcg lruvec lock is stable and could
> replace per node lru lock.
> 
> In func isolate_migratepages_block, compact_unlock_should_abort and
> lock_page_lruvec_irqsave are open coded to work with compact_control.
> Also add a debug func in locking which may give some clues if there are
> sth out of hands.
> 
> Daniel Jordan's testing show 62% improvement on modified readtwice case
> on his 2P * 10 core * 2 HT broadwell box.
> https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/
> 
> On a large machine with memcg enabled but not used, the page's lruvec
> seeking pass a few pointers, that may lead to lru_lock holding time
> increase and a bit regression.
> 
> Hugh Dickins helped on the patch polish, thanks!
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Rong Chen <rong.a.chen@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>
