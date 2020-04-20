Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C81B190D
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgDTWLm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWLl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:11:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4715DC061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so10020339qtr.7
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0En7iea1xuMHdBkCdJ+zycx29vIdm+FB4ZhZph/8RA=;
        b=ytVzBYSdrTwoP1lGYSOvOioRHuNpY59hcJqq6rdmPp/5WO7TBcNl+19HabZo6xw4Rn
         qLw3rumZnC1nnA9CsqRYaFeBEQD6N7IHV688IAD/9h72nTicP9Z+17XYXG5QVZCsrAFM
         ACZguEsWBuUoSAgQM3X5NiaJFIpG+c+2GUyyd7eyG+fx1d+7jgnDJrGO0cezEkC0xZvM
         8nV42K2p735E7d91FlpY76Qo2jRCyJQLC/ai+GQ8n01nlL5u7xhMbp3N1ZagriVA9qSs
         aWd/SqscVR7WQIhKv6hgAz1fo5DFtX84tROp4i33h+wmrEm2cTskKSZqtiIbyvR4mzAe
         sGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0En7iea1xuMHdBkCdJ+zycx29vIdm+FB4ZhZph/8RA=;
        b=T/av5B1ByBgb+okgFw7C4HclvDX/iGYUOs+dYGqim9AyhlSBTcnICQKYZuY3WHDxke
         NaUwJiQ2KQsMCK50Alm+03MiUmE6Y6qbMQRpCpZSFdINXL0OqnPagQjk4C/QisvBQTTt
         OkC2hrUOhJkAxRvBOHBQ/6sJIHWrcsrWW08xf6v3gqk+YuRZ8m5IZj2H3bKPtYRZ51F7
         Kv+dvgTSKUAxsBnWbDbB/NK5WrUGT3uIII3EpLLjLgmYwOgobOrMfWpJqObjs1U8yACo
         7PPCu1a5Ff+0//cWGiAoMJI3I74A3j+ltHMAbD6ATN8gI4DXQ9o6ovl+74SdZDNTF7f6
         22Vw==
X-Gm-Message-State: AGi0PuaB3C11TdA2HvQpryPbf+MSbn8hgeAIqj7hCzumgMPgMKnwBubx
        8Y53V1M8zrbeqkOM8/05UQeR8w==
X-Google-Smtp-Source: APiQypLKzoHgPbDLa7+oO5wDEDUb9oDwRCiaOB5gxFiH57bM5QkTR1yyWuqBYT0pkMD09Fzw2YU/jA==
X-Received: by 2002:ac8:22ad:: with SMTP id f42mr18138503qta.292.1587420700560;
        Mon, 20 Apr 2020 15:11:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id c23sm605354qka.12.2020.04.20.15.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:39 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 01/18] mm: fix NUMA node file count error in replace_page_cache()
Date:   Mon, 20 Apr 2020 18:11:09 -0400
Message-Id: <20200420221126.341272-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When replacing one page with another one in the cache, we have to
decrease the file count of the old page's NUMA node and increase the
one of the new NUMA node, otherwise the old node leaks the count and
the new node eventually underflows its counter.

Fixes: 74d609585d8b ("page cache: Add and replace pages using the XArray")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef0f..49e3b5da0216 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -808,11 +808,11 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 	old->mapping = NULL;
 	/* hugetlb pages do not participate in page cache accounting. */
 	if (!PageHuge(old))
-		__dec_node_page_state(new, NR_FILE_PAGES);
+		__dec_node_page_state(old, NR_FILE_PAGES);
 	if (!PageHuge(new))
 		__inc_node_page_state(new, NR_FILE_PAGES);
 	if (PageSwapBacked(old))
-		__dec_node_page_state(new, NR_SHMEM);
+		__dec_node_page_state(old, NR_SHMEM);
 	if (PageSwapBacked(new))
 		__inc_node_page_state(new, NR_SHMEM);
 	xas_unlock_irqrestore(&xas, flags);
-- 
2.26.0

