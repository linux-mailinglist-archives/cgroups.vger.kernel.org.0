Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC8E118A25
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2019 14:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfLJNtb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Dec 2019 08:49:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45148 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNtb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Dec 2019 08:49:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so9068267pfg.12;
        Tue, 10 Dec 2019 05:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GTyISog1VX8yYAJFI+c/tQ5PL+DROiS/ITcUOlh5Cs=;
        b=c0FEADODck6cpIJJgtjKYAmemgt9mpnPLYw9O4bu5TW3TNCwI8b5q6ij8BkpCd0nYy
         6WxeFlUsOR7ofa8ZCWHs2hL8pJhGd7QjnStKiCJQkdx9MmdUCP2gGFzs4F8ZOLi1AUq1
         XYKwagD4yz/ZaQSs00mW5W5UC8JxZU1zLoHRSeDLI20r60Mw+pFb95bJtmHUs87j3z6U
         7vq+E8Gwe5pO9Zd2/h8+yHu/llz8RZR6RilV1lzKEupKwljmIfGEce8rCkKB5Zg3RVrw
         eXHGyM0pFtCiBBgQELyAUveIWL7Dc/o9mCkNnlBczw5Oejrclpe54hMvdzAAl5QZ6XTQ
         nJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GTyISog1VX8yYAJFI+c/tQ5PL+DROiS/ITcUOlh5Cs=;
        b=AjF4JMdL0nM5yroqGRAs5Oi5WQKtioKacRnKhSDoFAf/yGL4CXSOglyQZUIQEcLZz+
         00BXHVJ7jcfSw4CAI2psYdNuK6WjjLUVC7IShdqVDlGcjzp/Q8atoDIT8pg8v/Q/Uv5N
         MMfGtsP8Wa1vay9B/ATxWR7kI8OBBYhGRM1wlVq8f6amWrM12dX3lseRwEcvj2MAqxAA
         1EOOREJOR9ZLnBV8V4qedqjnlcGTwGVnl7LUwI6TPSD89W7Roz6skjVPqEsV5Fr+cb5R
         IiuzAx25z8yaTPQXynzh2WnfSzX+r+bN3iUL7+UzHGg+MwctD6ssHL+3SgQz9zLITBF7
         5dMg==
X-Gm-Message-State: APjAAAVtX2iMh/UlxW5FmHBRoWS7oiHmJ7S4yXIhvkWf20S1p6mhr73T
        zgO+lfKPz8nlZU5POrYqSFg=
X-Google-Smtp-Source: APXvYqxoaZy5Ti1fGla4GQWKDnsoGwY+cdTdssY1GiH1lkSDhD5BlL6T7Wn5kwVpaMDI1nuvLkzdVA==
X-Received: by 2002:a62:486:: with SMTP id 128mr35359892pfe.236.1575985770887;
        Tue, 10 Dec 2019 05:49:30 -0800 (PST)
Received: from localhost.localdomain ([2408:8025:ad:7e20:84d1:c490:3936:fab0])
        by smtp.gmail.com with ESMTPSA id t137sm3520602pgb.40.2019.12.10.05.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:49:30 -0800 (PST)
From:   chengkaitao <pilgrimtao@gmail.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] mm: cleanup some useless code
Date:   Tue, 10 Dec 2019 05:49:10 -0800
Message-Id: <20191210134911.2570-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

There is a duplicate PageTransHuge, because hpage_nr_pages have
the same one.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 mm/memcontrol.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bc01423277c5..870284d3ee9d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6678,7 +6678,6 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 {
 	struct mem_cgroup *memcg;
 	unsigned int nr_pages;
-	bool compound;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
@@ -6700,8 +6699,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		return;
 
 	/* Force-charge the new page. The old one will be freed soon */
-	compound = PageTransHuge(newpage);
-	nr_pages = compound ? hpage_nr_pages(newpage) : 1;
+	nr_pages = hpage_nr_pages(newpage);
 
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
@@ -6711,7 +6709,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	commit_charge(newpage, memcg, false);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, newpage, compound, nr_pages);
+	mem_cgroup_charge_statistics(memcg, newpage, PageTransHuge(newpage),
+			nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
 }
-- 
2.20.1

