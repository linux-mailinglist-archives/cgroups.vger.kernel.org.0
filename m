Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02D826F2CD
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgIRDCK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgIRDBQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2D7C06178C
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i199so3981714ybg.22
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DFpxxJ/kEtxVo0cZzaDv049JSd9o65lBb+rEHr6i344=;
        b=uhe9Xs7mtBzscpnO7yF3U+4MIVtZCHxNqpxEHtIXeMwLhLvt2SDYP0tVoo6HC4xD+W
         T8UFMl0etXGRXhZaQBsVcHy+El+zDM7QlJ0hGnUAzLF4hfhzbDInRMeYTOqjfFNd60ZH
         HhY41XfU6a8zt7cihboW9vmQ7OQqQjhicIQZpH7ToLLD9MRHD9RRhSn9bzTLe2SfDuGH
         SJIGhmFfn4ys616614QgdqfST0P7nPCOEuqaBbe/iQvvHLLJdIJy3aoLlIDve4bRxL00
         ZgRT7Jj42mdwuk8z1nzvKGSelnGbanOQescafc84VCW7x1aYLSk5nSIsMKNmEhcgP1f0
         jn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DFpxxJ/kEtxVo0cZzaDv049JSd9o65lBb+rEHr6i344=;
        b=Bp9u87tfCTy3quOZaBaWLydmBhi5s7ipnTjSScvXR8oZcihijfMDrUPN4ibqhmvBEW
         TjtMbDnu/OAyW7Z8g2UAlfrX0cblWSupK5X749UJ+cX3xtA0JVIVovs6k4ZICBjpUN4q
         Oufuqs3BmBOMHr77tiHi2biAfiDdjF8wWHJTPUrenspGHEp08wxrBRNa0Fd+BDVK3QFk
         WWQMLFhk3wqeyGXBy8JwDWXyjYcsZwVOqxZMJe4z0Idl+ZSei2jHizo3K3Knu/pySaWb
         LLC907CU6hzpHjGH8k05tSs3L+UwTSyufCZvmuSntKu1oolDzdmXgutNz7fumX4Z6QJx
         EiHQ==
X-Gm-Message-State: AOAM5300hdecyTlGESQmxziyJRs5V4evtt0mtKlczpzGyGm8dvuyuwT7
        fmVZeUByCBtXTXdenQl0cWCLWpMCEwY=
X-Google-Smtp-Source: ABdhPJxvYNBbzfpbEV/xXQvUGEXI4OEuFOhsF5B7Jlz9/8AmN6ttG/IsDz0Z+wl6pHj8lTKer6JSac8C7o8=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:55c5:: with SMTP id j188mr33342607ybb.417.1600398061369;
 Thu, 17 Sep 2020 20:01:01 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:40 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 02/13] mm: use page_off_lru()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch replaces the only open-coded __ClearPageActive() with
page_off_lru(). There is no open-coded __ClearPageUnevictable()s.

Before this patch, we have:
	__ClearPageActive()
	add_page_to_lru_list()

After this patch, we have:
	page_off_lru()
		if PageUnevictable()
			__ClearPageUnevictable()
		else if PageActive()
			__ClearPageActive()
	add_page_to_lru_list()

Checking PageUnevictable() shouldn't be a problem because these two
flags are mutually exclusive. Leaking either will trigger bad_page().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 503fc5e1fe32..f257d2f61574 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1845,7 +1845,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
-	enum lru_list lru;
 
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
@@ -1860,14 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		SetPageLRU(page);
-		lru = page_lru(page);
-
 		add_page_to_lru_list(page, lruvec, lru);
 
 		if (put_page_testzero(page)) {
 			__ClearPageLRU(page);
-			__ClearPageActive(page);
-			del_page_from_lru_list(page, lruvec, lru);
+			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
-- 
2.28.0.681.g6f77f65b4e-goog

