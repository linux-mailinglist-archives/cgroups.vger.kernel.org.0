Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18B04228F4
	for <lists+cgroups@lfdr.de>; Tue,  5 Oct 2021 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbhJENzu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Oct 2021 09:55:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:57734 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236218AbhJENyc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 5 Oct 2021 09:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=wDI2KAde98v08hZLs6870emZXeENggnRAUE1+E9iwPs=; b=oe9Kw+Jm7+nbWFTV/Mq
        f4d5MqyA4aoEKGe4haLjvSTVgBY5nmczJxUHvbdrhMOPYTZI26Ez+l+IEUw0f2RoKpUIFqrnSdWjN
        b1hryhqynKHFg0wMWtCGJYS2T/TUUGi9X2qQwEowdyg8ogYZJAPcVQdAYmZSTLnKnjTaLsdCpv4=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mXks4-0054Uo-N0; Tue, 05 Oct 2021 16:52:40 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH mm v2] vmalloc: back off when the current task is OOM-killed
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YVGmMSJ3NrQZjLP8@dhcp22.suse.cz>
Message-ID: <83efc664-3a65-2adb-d7c4-2885784cf109@virtuozzo.com>
Date:   Tue, 5 Oct 2021 16:52:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVGmMSJ3NrQZjLP8@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Huge vmalloc allocation on heavy loaded node can lead to a global
memory shortage. Task called vmalloc can have worst badness and
be selected by OOM-killer, however taken fatal signal does not
interrupt allocation cycle. Vmalloc repeat page allocaions
again and again, exacerbating the crisis and consuming the memory
freed up by another killed tasks.

After a successful completion of the allocation procedure, a fatal
signal will be processed and task will be destroyed finally.
However it may not release the consumed memory, since the allocated
object may have a lifetime unrelated to the completed task.
In the worst case, this can lead to the host will panic
due to "Out of memory and no killable processes..."

This patch allows OOM-killer to break vmalloc cycle, makes OOM more
effective and avoid host panic. It does not check oom condition directly,
however, and breaks page allocation cycle when fatal signal was received.

This may trigger some hidden problems, when caller does not handle
vmalloc failures, or when rollaback after failed vmalloc calls own
vmallocs inside. However all of these scenarios are incorrect:
vmalloc does not guarantee successful allocation, it has never been called
with __GFP_NOFAIL and threfore either should not be used for any rollbacks
or should handle such errors correctly and not lead to critical
failures.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
v2: tsk_is_oom_victim() check replaced by fatal_signal_pending(current),
    removed check inside __alloc_pages_bulk(),
    according to feedback from mhocko@.
    Updated patch description.
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604c..71706f5447f0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2860,6 +2860,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		struct page *page;
 		int i;
 
+		if (fatal_signal_pending(current))
+			break;
+
 		page = alloc_pages_node(nid, gfp, order);
 		if (unlikely(!page))
 			break;
-- 
2.31.1

