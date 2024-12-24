Return-Path: <cgroups+bounces-6000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC69FB82D
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3E16473E
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4137717BD6;
	Tue, 24 Dec 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp4KYPgb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A01758B
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002865; cv=none; b=hO2/ft5HdCCryRgPpb2i77/rPAuXF4Z9R8T9d07a07KicJo9e2m1xQ1R2Qw8RqNwPtbmQZd1ufutJpeRKY9OiBaDxCxJiA/rXN3Ss0pExHAcO/e8tzHLhs/ghJfjUs0tvKCYZkbzksswJSvyMEYdW3aEbfPwbWe8bIHQeHJ4JXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002865; c=relaxed/simple;
	bh=/h+qktNu9b+nsfdGbxRKuUzq0xn8wXuHAWm9HGagSnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZzezJskFMifP+OmLC+0MS+c3zyoXXiUJKxlaxf0fHk8WGvgdjSe2VNBvMjH9NsMU54hsKFDD6MMoqV4Cw5NaKlTWdXd1F/mzrZgHcGp9OgT4uAwGMroFqndZIsFkVW1bWDR2Dsw7/gf7+PTgPoFwIrTpP0JZyqLNSILUmf3mpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp4KYPgb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21636268e43so56086435ad.2
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002863; x=1735607663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZJllDXeQ8qx4y4BNkUJ894lZbTAuhDCQMxQBXIE4qE=;
        b=Jp4KYPgbNAseqjvZAWA8pd+1QSyHtwFTEa3SVh0t2q/6BTsYPXWfGZ+h9mLRX5Mpo7
         OTth+SIWfUjDEzEY4u3caykklU9JHlgWK7I0pp+l3hVM3731b5w0QI8b5KfD9RHP8OWa
         88T8l6NzomdTxbMMFmMI/pLhDo+2otM334eiCEpMRYCC/T6KD4dgYJyfuGbgr0pgo6on
         ZCmS36fgkN5Yvd+6++hXWNInbP2TfHepsCWCGCS48z8AnbPO44qcKKAMn/hfjULEIGHV
         MOLFOZ9QXNtQUwTJ1umGyUJzMDcVqTE9jeszR0FJLnsVvn9hdjEr1bKGhUOeyUvppBNI
         lGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002863; x=1735607663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZJllDXeQ8qx4y4BNkUJ894lZbTAuhDCQMxQBXIE4qE=;
        b=XXqYpjMFEdIk7b6r3f3sn/bWi0AGyMkf9rbNnYTCx5Tca6svTVc11ZlaoDGSxsSsUX
         /a+0QhxqV7LuBNUQxktz5fRtdiZSctrwvVhlCDi5Pa5Mxc5KdSChzBSbdMlD1RxS3h2L
         8VG3Rr7SCkqr6wgEZGM1neR/zeK6YC8MDtSDc+V05ZdTql8/wYj2jJoi1RufZ+ZsNQUB
         6YYwLL1/pjmR6q7kOiCaOPIx+3f4AbqbD630BXIo3sjWBW7Z/vcSFp0+KTwYnxKn+181
         +RTjkdVkiyZ9/ahJQn3ZQqVR3oUe+I//0BQPv7LlnlDV9xaTC58rpunym0ZhSLpUT6GC
         mUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmz4rGMJp6ObLYwZSWzEOdB6X1tzTtBWfjotc+aBzt9l8GXDb/0SYQgo+LXJNRMG0FrKFFh8XN@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSxGpQKKgoMpPKR38/dlYEppCoE7HHTL7rhui3D6CPwDSzQIv
	jYGcGp7QYDbErgCFSQl093F+nb4yu85RRbGyjAQkLZRGtQL1iOTU
X-Gm-Gg: ASbGncstgmvaRL8hUpF2vuovom7uEn5St6TjgkdLuTNRzMBUePs2SUOfg0piT+EDi4F
	uwc3n9gCjoV5Jn+8BtvpcuNvsp2MHlC90m9hwkemv/Lu071hJJLENJ8Ctu2sikVcS8Z7HTfXGwO
	TOU1/88zGv0s1zJcKp/r9waqx4HVKa3upMhkzcEjfgWGpWyAzOv5qjB6CSXu3bdeQRYsrkBZjFA
	hhhkAqCeBU0ABN80LS428lUwRRit6flSHBOsw/Yg6SoYYz2Uf3LF9SSPEJg7oVqj/DMewSRbLJp
	dyIbLuCCPGgGBPpeMw==
X-Google-Smtp-Source: AGHT+IGzsv3KE6G8tMJp0bteEaX1XLhMudfBrUqQxMi2wOnR+qelJ6wcB5nC0ZJLnxdCo6AT0qqnSQ==
X-Received: by 2002:a17:902:f685:b0:212:615f:c1 with SMTP id d9443c01a7336-219e6e9f98amr173127195ad.14.1735002862898;
        Mon, 23 Dec 2024 17:14:22 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:22 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 7/9 RFC] cgroup: remove unneeded rcu list
Date: Mon, 23 Dec 2024 17:14:00 -0800
Message-ID: <20241224011402.134009-8-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the cgroup_subsystem_state owns the rstat tree, the list management
previously done by the cgroup is no longer needed.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h | 11 -----------
 kernel/cgroup/cgroup.c      | 20 +-------------------
 kernel/cgroup/rstat.c       |  9 +--------
 3 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 4d87519ff023..836260c422a0 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -182,14 +182,6 @@ struct cgroup_subsys_state {
 
 	/* per-cpu recursive resource statistics */
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
-	struct list_head rstat_css_list;
-
-	/*
-	 * Add padding to separate the read mostly rstat_cpu and
-	 * rstat_css_list into a different cacheline from the following
-	 * rstat_flush_next and *bstat fields which can have frequent updates.
-	 */
-	CACHELINE_PADDING(_pad_);
 
 	/*
 	 * A singly-linked list of cgroup structures to be rstat flushed.
@@ -198,9 +190,6 @@ struct cgroup_subsys_state {
 	 */
 	struct cgroup_subsys_state *rstat_flush_next;
 
-	/* flush target list anchored at cgrp->rstat_css_list */
-	struct list_head rstat_css_node;
-
 	/*
 	 * PI: Subsys-unique ID.  0 is unused and root is always 1.  The
 	 * matching css can be looked up using css_from_id().
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 96a2d15fe5e9..a36ed3995c6f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1826,7 +1826,6 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct cgroup_subsys_state *dcss = cgroup_css(dcgrp, ss);
 		struct css_set *cset, *cset_pos;
 		struct css_task_iter *it;
 
@@ -1864,13 +1863,6 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		}
 		spin_unlock_irq(&css_set_lock);
 
-		if (ss->css_rstat_flush) {
-			list_del_rcu(&css->rstat_css_node);
-			synchronize_rcu();
-			list_add_rcu(&css->rstat_css_node,
-				     &dcss->rstat_css_list);
-		}
-
 		/* default hierarchy doesn't enable controllers by default */
 		dst_root->subsys_mask |= 1 << ssid;
 		if (dst_root == &cgrp_dfl_root) {
@@ -5491,11 +5483,7 @@ static void css_release_work_fn(struct work_struct *work)
 	if (ss) {
 		struct cgroup *parent_cgrp;
 
-		/* css release path */
-		if (!list_empty(&css->rstat_css_node)) {
-			cgroup_rstat_flush(css);
-			list_del_rcu(&css->rstat_css_node);
-		}
+		cgroup_rstat_flush(css);
 
 		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
 		if (ss->css_released)
@@ -5569,8 +5557,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->id = -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
-	INIT_LIST_HEAD(&css->rstat_css_list);
-	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
@@ -5579,9 +5565,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 		css_get(css->parent);
 	}
 
-	if (ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &css->rstat_css_list);
-
 	BUG_ON(cgroup_css(cgrp, ss));
 }
 
@@ -5687,7 +5670,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 92a46b960be1..c52e8429c75d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -347,15 +347,8 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 		struct cgroup_subsys_state *pos = cgroup_rstat_updated_list(css, cpu);
 
 		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup_subsys_state *css_iter;
-
 			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
-
-			rcu_read_lock();
-			list_for_each_entry_rcu(css_iter, &pos->rstat_css_list,
-						rstat_css_node)
-				css_iter->ss->css_rstat_flush(css_iter, cpu);
-			rcu_read_unlock();
+			pos->ss->css_rstat_flush(pos, cpu);
 		}
 
 		/* play nice and yield if necessary */
-- 
2.47.1


