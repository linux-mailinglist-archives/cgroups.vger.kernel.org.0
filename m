Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358AC13A3CF
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANJau (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 04:30:50 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:59301 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgANJau (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 04:30:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TnibyCd_1578994246;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnibyCd_1578994246)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 17:30:46 +0800
Subject: Re: [PATCH v7 00/10] per lruvec lru_lock for memcg
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Hugh Dickins <hughd@google.com>, hannes@cmpxchg.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org>
 <944f0f6a-466a-7ce3-524c-f6db86fd0891@linux.alibaba.com>
 <d2efad94-750b-3298-8859-84bccc6ecf06@linux.alibaba.com>
 <alpine.LSU.2.11.2001130032170.1103@eggly.anvils>
 <24d671ac-36ef-8883-ad94-1bd497d46783@linux.alibaba.com>
 <alpine.LSU.2.11.2001131157500.1084@eggly.anvils>
 <641e4c96-c79f-fbdd-9762-f4608961423c@linux.alibaba.com>
Message-ID: <39a72184-c864-4a40-49fd-c27893dd2002@linux.alibaba.com>
Date:   Tue, 14 Jan 2020 17:29:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <641e4c96-c79f-fbdd-9762-f4608961423c@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/1/14 下午5:14, Alex Shi 写道:
> Anyway, although I didn't reproduced the bug. but I found a bug in my
> debug function:
> 	VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
> 
>  if !page->mem_cgroup, the bug could be triggered, so, seems it's a bug
> for debug function, not real issue. The 9th patch should be replaced by
> the following new patch. 

If !page->mem_cgroup, means the page is on root_mem_cgroup, so lurvec's
memcg is root_mem_cgroup, not NULL. that trigger the issue.


Hi Johannes,

So I have a question about the lock_page_memcg in this scenario, Should
we lock the page to root_mem_cgroup? or there is no needs as no tasks
move to a leaf memcg from root?

Thanks
Alex
