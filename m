Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23D31B1935
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgDTWMv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgDTWLy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:11:54 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFA0C061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v18so5584463qvx.9
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOOm476uJeMGLcBhM+Nnzpj1no5zTibX8MlOScPTZP8=;
        b=hioVkfM6+J8WLoqNgQvJex645fWjZjvT2/DsLybW7sYgjf412MeETUZ9sROh0R1aWj
         +PT6+SXjVnqxxmEOTA9tvabznzLoBPcJBFq4YE8hoEuzbzF40WKlwKaqtbAqUJo+/bas
         im+UJ8ycoNz8d4jRpIMsB++DBz0dnGnuMqlCB4hmyggGOAgndpABwHd17mrndefiJRwz
         Z2qXu1h9XDQmhj97BrOl/rj7HMgRojZXQSyqf2BDfruwfndNUIWs+LD73ZabCqzmMaCn
         cehSIavgIGYGeqhJF+aMCBuk7+NX/1IMdnuJyPVCfgAkX8NmPsXmgrRjB/kNROuj/5bz
         UYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOOm476uJeMGLcBhM+Nnzpj1no5zTibX8MlOScPTZP8=;
        b=rkgaf7XoSJGtseVaA3WXYHfaHQT/rOGrwE/McW00LMcBe3H+zJ1zTLcYAUnodtNOEa
         SSUyBFtA5hNEcA0L/ozrXxn2GwOaDiu+XYmrMHtw+0JYANNLjS2PFBqDd7BFX+IAQShx
         zLcd5+svvuJeVCBnM3nX9+HNnhS7tEfo6Stf0RXu92EeETgbdqU3DOAwdIgVC2y6BzXl
         ya8a7Ifmr0UxQtmH35oW5204yEJfSDfAlB05p+3ksHRxcjQsC3WpnqhFMz4bwXQvh5/s
         gyM5HPM55EO081Wldi/G2QTSc23zgy74yqhLyE9i+N4eXPzwVdMRgYtV3tjrHw0NuKS/
         SAwg==
X-Gm-Message-State: AGi0PuZPhSnGToRZ2xRSCDhkdg2Fa4miVDl5uogjVA8YJ3diKawHvcKb
        RbjGTLViGDafpnOPu67oR1GhGA==
X-Google-Smtp-Source: APiQypJrBUdXsOlvUJ5mC/Iy8jECNqCt058AfYOAro9oUqe7TXlWv/H13lObMqwJkQLwqDlREImx5Q==
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr17509081qvn.28.1587420713156;
        Mon, 20 Apr 2020 15:11:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id h3sm565816qkf.15.2020.04.20.15.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:52 -0700 (PDT)
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
Subject: [PATCH 07/18] mm: memcontrol: prepare move_account for removal of private page type counters
Date:   Mon, 20 Apr 2020 18:11:15 -0400
Message-Id: <20200420221126.341272-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When memcg uses the generic vmstat counters, it doesn't need to do
anything at charging and uncharging time. It does, however, need to
migrate counts when pages move to a different cgroup in move_account.

Prepare the move_account function for the arrival of NR_FILE_PAGES,
NR_ANON_MAPPED, NR_ANON_THPS etc. by having a branch for files and a
branch for anon, which can then divided into sub-branches.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e3e8913a5b28..ac6f2b073a5a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5374,7 +5374,6 @@ static int mem_cgroup_move_account(struct page *page,
 	struct pglist_data *pgdat;
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
-	bool anon;
 
 	VM_BUG_ON(from == to);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -5392,25 +5391,27 @@ static int mem_cgroup_move_account(struct page *page,
 	if (page->mem_cgroup != from)
 		goto out_unlock;
 
-	anon = PageAnon(page);
-
 	pgdat = page_pgdat(page);
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
 	lock_page_memcg(page);
 
-	if (!anon && page_mapped(page)) {
-		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
-		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
-	}
+	if (!PageAnon(page)) {
+		if (page_mapped(page)) {
+			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
+			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
+		}
 
-	if (!anon && PageDirty(page)) {
-		struct address_space *mapping = page_mapping(page);
+		if (PageDirty(page)) {
+			struct address_space *mapping = page_mapping(page);
 
-		if (mapping_cap_account_dirty(mapping)) {
-			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
+			if (mapping_cap_account_dirty(mapping)) {
+				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
+						   -nr_pages);
+				__mod_lruvec_state(to_vec, NR_FILE_DIRTY,
+						   nr_pages);
+			}
 		}
 	}
 
-- 
2.26.0

