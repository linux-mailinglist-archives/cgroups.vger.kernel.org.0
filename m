Return-Path: <cgroups+bounces-7559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF6A8921E
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3473C189B5BD
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FFC2192EF;
	Tue, 15 Apr 2025 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zge6eyoQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C631218EB9
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685228; cv=none; b=DmVCyatsUq7eDPOuwPt1klDwVBBV0mbgf3ntdp604K9khbEel+WdvHnvQ6E1HUHekY8Zo53OOW0rr24DOBDT/L9j9iLCAJl4fRwt7e0abQHx8brTNdRj+cEAeokk8EFK1mTdgso9hylh5ApZRbAP47CDyrnwMSbtWkPiZoTtKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685228; c=relaxed/simple;
	bh=siUlYavAtRsgutfSnr0p3JN+rwISg9BNgAgZ+S/EI4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lq65hCykgg3tmEErQlaSVoiTh6GoCSe9jVRAV0OLczrZ284y66ifUPNDQLeS85zUi72rCASSpTfC/UQMg1tV4BOnXMVVOvOZK/l/krusyBPcUE5ipzsV11iFtszGIxC/nuSeiZoZKpDA2iRmIUQknFBRh68uIK+wOY0Iv+0EWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zge6eyoQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225df540edcso59344615ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685226; x=1745290026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obht/6Kk0NnhGpMOiil8TzYARUGhrq+7EhlNkpnMaGs=;
        b=Zge6eyoQtTo+KWQwgZv3uVtbLgNpcW4KVrD4GgWi6glKPs3KIc5PvRSHHUYmwT0XSo
         Y8X02l5DH0DdSgBqtrVb0Ox8zH7aUPiU7I1DrL/ZYfRBHRJv9Pi8FdUJTAEG5+V7G4uR
         MdD4swA667z2qYYiU5jEpwHJu9xI4o+f0JBn0l9/6qF7FrtmTw8jTDLS0do14sUDf+Qj
         DTzDsja0xDwavFmNj/ZIsvhBE+10Yp7pyHOEg7sZ0KirT3ETo5nQSoeHFjkrpIE8VmEH
         PzBqApdV158/x5lb4qNkBMGgdu6uSqV7ZX0nDEu4Os4ykgutjbvzpzR+4hHwNDSjGx0a
         O/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685226; x=1745290026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obht/6Kk0NnhGpMOiil8TzYARUGhrq+7EhlNkpnMaGs=;
        b=M7e3nm9HIvBArl+0jKBssw8lp1WY2yy8a9DA3WzNYQ5PbdgxMBkQnchmV3JBprM9tz
         qdZ/ZwjvipDhgantCh30mEtzt232HrGWfRSl/ZHJpZFUtWdRt/htEyKe5oObKUj+DI41
         cLCBXyUB7ReYMBzLWtmIvnrNQ9PZ6/jv1agaX3XENoZcr2cms+wEFfFi1oD2XfoFCkvi
         vgQs0YdEvFqobgPgcb7d5sfP4CFApGNGpUWiSrg3essP/KskVJNxFW3RiMyqg/GeQDGY
         dWpGPR4j2fB08z5FoMv9YD4CuAT4qgCn8ovIltZ+lsPuOQZNHH0imbzT+xjlHrtmwluK
         9DZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlrYrdFO3cqie8+l7Bbosw7GPSuKx8M/BPNDrsyAZGq5vuX2I4PLTr0qvK5SuuaHE6UDJlFBJt@vger.kernel.org
X-Gm-Message-State: AOJu0YxjusmNT6bEDSyGxf1PcfqiEyWrK16IkQ6LedO7pYPFKl0OJnTt
	wiOtptV/VJ11gk9H5a76iZTV4E4QV6VnOesbgAQDKzCQ03bjWbxj8gQbQcYXHFg=
X-Gm-Gg: ASbGncuti5aeTIMj2ipJ+a5iDaZ5G7IuPdnjLTPzvrNfkUiXW0QHCklqGOxYMEqoCPA
	X74UQIwhmxZAJHhvpOKnwY6vnKYTk0TjTgXbtqemmsb6+2ULPlZ/YJl0dsvDw8z8faPhpIM07F1
	RxM21E+WVWjP6e2rCzyekPlAf+LBC0bz7eMPWWZbD8muuhFEMex8XCBt7eON+nvB0hGJOW15ozv
	efpxjQcGhv2UxWZ6f/Yvksg31M6LxFgNau06ivCNJMhDCiChvhjcl2vdijnCEkTnZngtAbn5//t
	VPx4RdI7QSyhYPr4RR3k3QIq8goNKinqn3P8Aq4TkSs7baM36qtR6tkE4yp2428UU5Jbm6yWS95
	jZILZ140=
X-Google-Smtp-Source: AGHT+IF1G++5FxihLJJNREqKO+5yf6OFv8YN+5YM0gPXaE7ee12PkODsP2jTee4zjVH6VXKddsDutQ==
X-Received: by 2002:a17:902:d490:b0:226:3392:3704 with SMTP id d9443c01a7336-22c24984d71mr24086475ad.12.1744685225787;
        Mon, 14 Apr 2025 19:47:05 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:05 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 13/28] writeback: prevent memory cgroup release in writeback module
Date: Tue, 15 Apr 2025 10:45:17 +0800
Message-Id: <20250415024532.26632-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the function get_mem_cgroup_css_from_folio()
and the rcu read lock are employed to safeguard against the release
of the memory cgroup.

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/fs-writeback.c                | 22 +++++++++++-----------
 include/linux/memcontrol.h       |  9 +++++++--
 include/trace/events/writeback.h |  3 +++
 mm/memcontrol.c                  | 14 ++++++++------
 4 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..e3561d486bdb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -269,15 +269,13 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
 
-		if (folio) {
-			memcg_css = mem_cgroup_css_from_folio(folio);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-		} else {
-			/* must pin memcg_css, see wb_get_create() */
+		/* must pin memcg_css, see wb_get_create() */
+		if (folio)
+			memcg_css = get_mem_cgroup_css_from_folio(folio);
+		else
 			memcg_css = task_get_css(current, memory_cgrp_id);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-			css_put(memcg_css);
-		}
+		wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+		css_put(memcg_css);
 	}
 
 	if (!wb)
@@ -929,16 +927,16 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
 	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
-	css = mem_cgroup_css_from_folio(folio);
+	css = get_mem_cgroup_css_from_folio(folio);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
 	if (!(css->flags & CSS_ONLINE))
-		return;
+		goto out;
 
 	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-		return;
+		goto out;
 	}
 
 	if (id == wbc->wb_lcand_id)
@@ -951,6 +949,8 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio
 		wbc->wb_tcand_bytes += bytes;
 	else
 		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
+out:
+	css_put(css);
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e74922d5755d..a9ef2087c735 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -874,7 +874,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_folio(struct folio *folio);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_folio(struct folio *folio);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1594,9 +1594,14 @@ static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 	if (mem_cgroup_disabled())
 		return;
 
+	if (!folio_memcg_charged(folio))
+		return;
+
+	rcu_read_lock();
 	memcg = folio_memcg(folio);
-	if (unlikely(memcg && &memcg->css != wb->memcg_css))
+	if (unlikely(&memcg->css != wb->memcg_css))
 		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
+	rcu_read_unlock();
 }
 
 void mem_cgroup_flush_foreign(struct bdi_writeback *wb);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 0ff388131fc9..99665c79856b 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -266,7 +266,10 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+
+		rcu_read_lock();
 		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
+		rcu_read_unlock();
 	),
 
 	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4802ce1f49a4..09ecb5cb78f2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -229,7 +229,7 @@ DEFINE_STATIC_KEY_FALSE(memcg_bpf_enabled_key);
 EXPORT_SYMBOL(memcg_bpf_enabled_key);
 
 /**
- * mem_cgroup_css_from_folio - css of the memcg associated with a folio
+ * get_mem_cgroup_css_from_folio - acquire a css of the memcg associated with a folio
  * @folio: folio of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -239,14 +239,16 @@ EXPORT_SYMBOL(memcg_bpf_enabled_key);
  * If memcg is bound to a traditional hierarchy, the css of root_mem_cgroup
  * is returned.
  */
-struct cgroup_subsys_state *mem_cgroup_css_from_folio(struct folio *folio)
+struct cgroup_subsys_state *get_mem_cgroup_css_from_folio(struct folio *folio)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg;
 
-	if (!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		memcg = root_mem_cgroup;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return &root_mem_cgroup->css;
 
-	return &memcg->css;
+	memcg = get_mem_cgroup_from_folio(folio);
+
+	return memcg ? &memcg->css : &root_mem_cgroup->css;
 }
 
 /**
-- 
2.20.1


