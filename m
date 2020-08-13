Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29C243525
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHMHpn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 03:45:43 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60653 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgHMHpm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 03:45:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U5dIbAA_1597304727;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5dIbAA_1597304727)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Aug 2020 15:45:29 +0800
Subject: Re: [RFC PATCH 1/3] mm: Drop locked from isolate_migratepages_block
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040224.13054.96724.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4403f572-03c3-3061-6fc4-f56e3b6d7b67@linux.alibaba.com>
Date:   Thu, 13 Aug 2020 15:44:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200813040224.13054.96724.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/13 下午12:02, Alexander Duyck 写道:
> -		rcu_read_lock();
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -
>  		/* If we already hold the lock, we can skip some rechecking */
> -		if (lruvec != locked) {
> -			if (locked)
> -				unlock_page_lruvec_irqrestore(locked, flags);
> +		if (!lruvec || !lruvec_holds_page_lru_lock(page, lruvec)) {

Ops, lruvec_holds_page_lru_lock need rcu_read_lock. 

> +			if (lruvec)
> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>  
> +			lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> -			locked = lruvec;
>  			rcu_read_unlock();
>  

and some bugs:
[  534.564741] CPU: 23 PID: 545 Comm: kcompactd1 Kdump: loaded Tainted: G S      W         5.8.0-next-20200803-00028-g9a7ff2cd6e5c #85
[  534.577320] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 1.0.PL.IP.P.027.02 05/29/2020
[  534.587693] Call Trace:
[  534.590522]  dump_stack+0x96/0xd0
[  534.594231]  ___might_sleep.cold.90+0xff/0x115
[  534.599102]  kcompactd+0x24b/0x370
[  534.602904]  ? finish_wait+0x80/0x80
[  534.606897]  ? kcompactd_do_work+0x3d0/0x3d0
[  534.611566]  kthread+0x14e/0x170
[  534.615182]  ? kthread_park+0x80/0x80
[  534.619252]  ret_from_fork+0x1f/0x30
[  535.629483] BUG: sleeping function called from invalid context at include/linux/freezer.h:57
[  535.638691] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 545, name: kcompactd1
[  535.647601] INFO: lockdep is turned off.
