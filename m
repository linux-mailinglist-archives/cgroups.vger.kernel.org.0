Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40360108417
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2019 16:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfKXPtS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 24 Nov 2019 10:49:18 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:49446 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbfKXPtS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 24 Nov 2019 10:49:18 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 4D9A92E0E7E;
        Sun, 24 Nov 2019 18:49:14 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id wIrsB3SOSP-nD2u1akc;
        Sun, 24 Nov 2019 18:49:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1574610554; bh=xtZMdOlBBD6/tHCSTsT3VJTA4BP38M0wqgm8PCbdSww=;
        h=In-Reply-To:References:Date:Message-ID:From:To:Subject;
        b=MBoMvaPppgK0GxCmI2p5BcEvddMbXZWFVzL7R2jU6Eyf7NVspC2cX7UWwhdzVP/dj
         WCX5ndwJ78ehhcYOrRzg5mBqGOgU0BM2QfVThrsXhkDu8RSu9GuxtwK15PTx3z7EpO
         2mNysXX3J3U24MmLaOkzECiCW8l76VStCEApt11g=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8807::1:a])
        by iva4-c987840161f8.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Ve10tljpUq-nDV4v2Wh;
        Sun, 24 Nov 2019 18:49:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v4 0/9] per lruvec lru_lock for memcg
To:     Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <aa5499cd-7947-39a5-fc17-bd277be25764@yandex-team.ru>
Date:   Sun, 24 Nov 2019 18:49:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 19/11/2019 15.23, Alex Shi wrote:
> Hi all,
> 
> This patchset move lru_lock into lruvec, give a lru_lock for each of
> lruvec, thus bring a lru_lock for each of memcg per node.
> 
> According to Daniel Jordan's suggestion, I run 64 'dd' with on 32
> containers on my 2s* 8 core * HT box with the modefied case:
>    https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> 
> With this change above lru_lock censitive testing improved 17% with multiple
> containers scenario. And no performance lose w/o mem_cgroup.

Splitting lru_lock isn't only option for solving this lock contention.
Also it doesn't help if all this happens in one cgroup.

I think better batching could solve more problems with less overhead.

Like larger per-cpu vectors or queues for each numa node or even for each lruvec.
This will preliminarily sort and aggregate pages so actual modification under
lru_lock will be much cheaper and fine grained.

> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought the same idea
> 7 years ago. Now I believe considering my testing result, and google internal
> using fact. This feature is clearly benefit multi-container users.
> 
> So I'd like to introduce it here.
> 
> Thanks all the comments from Hugh Dickins, Konstantin Khlebnikov, Daniel Jordan,
> Johannes Weiner, Mel Gorman, Shakeel Butt, Rong Chen, Fengguang Wu, Yun Wang etc.
> 
> v4:
>    a, fix the page->mem_cgroup dereferencing issue, thanks Johannes Weiner
>    b, remove the irqsave flags changes, thanks Metthew Wilcox
>    c, merge/split patches for better understanding and bisection purpose
> 
> v3: rebase on linux-next, and fold the relock fix patch into introduceing patch
> 
> v2: bypass a performance regression bug and fix some function issues
> 
> v1: initial version, aim testing show 5% performance increase
> 
> 
> Alex Shi (9):
>    mm/swap: fix uninitialized compiler warning
>    mm/huge_memory: fix uninitialized compiler warning
>    mm/lru: replace pgdat lru_lock with lruvec lock
>    mm/mlock: only change the lru_lock iff page's lruvec is different
>    mm/swap: only change the lru_lock iff page's lruvec is different
>    mm/vmscan: only change the lru_lock iff page's lruvec is different
>    mm/pgdat: remove pgdat lru_lock
>    mm/lru: likely enhancement
>    mm/lru: revise the comments of lru_lock
> 
>   Documentation/admin-guide/cgroup-v1/memcg_test.rst | 15 +----
>   Documentation/admin-guide/cgroup-v1/memory.rst     |  6 +-
>   Documentation/trace/events-kmem.rst                |  2 +-
>   Documentation/vm/unevictable-lru.rst               | 22 +++----
>   include/linux/memcontrol.h                         | 68 ++++++++++++++++++++
>   include/linux/mm_types.h                           |  2 +-
>   include/linux/mmzone.h                             |  5 +-
>   mm/compaction.c                                    | 67 +++++++++++++------
>   mm/filemap.c                                       |  4 +-
>   mm/huge_memory.c                                   | 17 ++---
>   mm/memcontrol.c                                    | 75 +++++++++++++++++-----
>   mm/mlock.c                                         | 27 ++++----
>   mm/mmzone.c                                        |  1 +
>   mm/page_alloc.c                                    |  1 -
>   mm/page_idle.c                                     |  5 +-
>   mm/rmap.c                                          |  2 +-
>   mm/swap.c                                          | 74 +++++++++------------
>   mm/vmscan.c                                        | 74 ++++++++++-----------
>   18 files changed, 287 insertions(+), 180 deletions(-)
> 
