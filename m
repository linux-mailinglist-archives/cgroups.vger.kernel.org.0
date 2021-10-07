Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7939A425CB0
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhJGT5h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 15:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232829AbhJGT5g (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 7 Oct 2021 15:57:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F1C360F6E;
        Thu,  7 Oct 2021 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633636542;
        bh=l66xkvwo5JDJqPQgPip89gZwXEOnO407CqbFPpfYp94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NSeYGN3XXLrQYf0fPcCt6hWBohOXv+xiotZkcXFQ7+M4XEPsvno7qUvSzhInEfkdm
         na9gMTTn3OoaSGuNFnHSOIEs1c+kqJVJe+nyBfC4krIYIcGU/spgPCxbMvUP/9futO
         kEDwoSwwNI8UT31HhqEGNTNN+DhPwAyl8Aej+Ruo=
Date:   Thu, 7 Oct 2021 12:55:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH mm v2] vmalloc: back off when the current task is
 OOM-killed
Message-Id: <20211007125541.db0f3ff2bdbd8fa7dc1db03d@linux-foundation.org>
In-Reply-To: <83efc664-3a65-2adb-d7c4-2885784cf109@virtuozzo.com>
References: <YVGmMSJ3NrQZjLP8@dhcp22.suse.cz>
        <83efc664-3a65-2adb-d7c4-2885784cf109@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 5 Oct 2021 16:52:40 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:

> Huge vmalloc allocation on heavy loaded node can lead to a global
> memory shortage. Task called vmalloc can have worst badness and
> be selected by OOM-killer, however taken fatal signal does not
> interrupt allocation cycle. Vmalloc repeat page allocaions
> again and again, exacerbating the crisis and consuming the memory
> freed up by another killed tasks.
> 
> After a successful completion of the allocation procedure, a fatal
> signal will be processed and task will be destroyed finally.
> However it may not release the consumed memory, since the allocated
> object may have a lifetime unrelated to the completed task.
> In the worst case, this can lead to the host will panic
> due to "Out of memory and no killable processes..."
> 
> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
> effective and avoid host panic. It does not check oom condition directly,
> however, and breaks page allocation cycle when fatal signal was received.
> 
> This may trigger some hidden problems, when caller does not handle
> vmalloc failures, or when rollaback after failed vmalloc calls own
> vmallocs inside. However all of these scenarios are incorrect:
> vmalloc does not guarantee successful allocation, it has never been called
> with __GFP_NOFAIL and threfore either should not be used for any rollbacks
> or should handle such errors correctly and not lead to critical
> failures.
> 

This needed a little rework due to
https://lkml.kernel.org/r/20210928121040.2547407-1-chenwandun@huawei.com.
Please check and retest sometime?

--- a/mm/vmalloc.c~vmalloc-back-off-when-the-current-task-is-oom-killed
+++ a/mm/vmalloc.c
@@ -2887,6 +2887,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 
 	page = NULL;
 	while (nr_allocated < nr_pages) {
+		if (fatal_signal_pending(current))
+			break;
+
 		if (nid == NUMA_NO_NODE)
 			page = alloc_pages(gfp, order);
 		else
_

