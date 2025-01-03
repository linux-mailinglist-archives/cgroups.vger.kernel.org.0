Return-Path: <cgroups+bounces-6031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA9A00288
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546D9162E7A
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10E14901B;
	Fri,  3 Jan 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk2hzu0t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644501527AC
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869042; cv=none; b=gnWA/im6jkyXJIY0fsUGxX9ewcuLIs7CnbOAUDhGnxXx5lce+BViSVBCpQGavcEqCgAi/MQ8TgjxZk+G20J2jbx+tccztCMA79P9NFvbOUMxvEJf+ztduDWCL7gVR/tWnBzNOtKDDPWjDQL5ILe88bT9935Xu72jf2rbzmyNl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869042; c=relaxed/simple;
	bh=gXN3TibGv5kJZOsMfwqbVSh76NDC2QcGmd4SlDLDZbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIG4XbcdSFtS4MNrri0Ncms2nZo8l05b2MZReyZCVtjMQYCpQVEVSskK9T/95EP8q1M+ddkKi0IS1HHZbzH+vzdpI9Buyb9Tjm6QD+UUtD1NIc46x3H8X+WdjFLat4bXNkypQ3guzk9v0HwcqJmWEzA9t8frmeYcVA6gFmf+q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk2hzu0t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21654fdd5daso152566665ad.1
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869040; x=1736473840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0/95vxHq4AbTjjm1qqTnNQIEsjcgRpvj31jjZiEdxU=;
        b=nk2hzu0tmR51mQGoIqWCAhvufaULQ1zriaC4bwVpWzh71OFCPeW1+/w8WBxh3VmNpq
         WMphq0+JkA1M57pFyYmg46dAWDE0ScW9IiRBTMEXBRlbC28vRYboyhVCLgGxZmB3dnY0
         CCotISP7JkQSG7Kc3RiWrKZlLoJoErk9QPao/gCFaVp/AwjaIArqd8u44yXRX3PdNDrA
         T/L+GGD8M5ycNDaZkrGSp4I6ZTlptLeMZj/XENa55XvZVhPLSgAyAXtDD5fhd8MZXHJ+
         9Hdx3s0c7kjo+6rFzUqnJfG51ruSOLyRYcrAFtw5K1Rk4hHRK/PAicKG+1fLgezQeLqi
         CrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869040; x=1736473840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0/95vxHq4AbTjjm1qqTnNQIEsjcgRpvj31jjZiEdxU=;
        b=M1FkspvVVwuAgqUs8YMU21cTR8Yl0puBtcPOYSjs22LZLTQjzyoqG0RL2+tRqO3D9o
         thGwggwEEbYiOxyWCDd0DtmOaIICNXiwND8r7PKPX3d7kzq025ALFxcypUAxa35h5lQr
         B5lq8zu1bMEr2oAg0SW4opuV42mELkA/7HQ67Psi1IdQ1oZL6Qn6BPRQXT8kEg2G9B2q
         pnkYmysQnoW4cEr3M74FyaNsPjHjVRWq0R76Qs6MjQ3NUuQbG5Hld/D3BxQoDxazVOvE
         ubDguAopjK2Y/an1yDLGinIcXyQdnVW7xP9VIsky/l8EAYVlHGEcDrhP1tOl/W7A5ySF
         3M2A==
X-Forwarded-Encrypted: i=1; AJvYcCVOT6T+X/dQqapYgRMOcCx2dF7YqrIaYgr/LW9cl04PBJBMgjcmvH9d6M7f4tm1EuxKrsMlZAQz@vger.kernel.org
X-Gm-Message-State: AOJu0YzibmNBIBk1BxlbtbdLUW/2FjwLgDiLTdEy7yeEncB+n7swTSWn
	eXy87orGcuCqth0NNd09SrKIhTbp7RG60+DMXQMo1P40I+0sG3HX
X-Gm-Gg: ASbGncubUDDQ0be1QjGx5Vr69E3+yDTUjDliI6RuBw2erBwHFTHR43Gph0nN63hokF7
	iLPsnbUmq7CBJvOQQwQd7xq66KIxrkB4YunbMWQgf/3AyhSbf/wlp+b73QmaKjYCFfgsJhgm6jR
	3Ia9nhXxVyWLuO/YXCwXXZ+z574fdwc6g8MflEhFiCJGH4r4CL9vjRnfLhlVzWhARPPQzGLjHQg
	acR1f+I8Uuao6jO3cOPSuGYmsL4ZXFY+dBeukAWEBw3InpyWYaxdmp58p4Y0m1sHbJX371P4j73
	REQdCYEMRAp5yGXHUg==
X-Google-Smtp-Source: AGHT+IHpW6kPJoz3uQ31McNNuWFPISD9A55LMmIKwxPMCRkUhBP25MkbHaNyVJ9vNwtjAbpRrI4k1w==
X-Received: by 2002:a17:902:f64b:b0:216:779a:d5f3 with SMTP id d9443c01a7336-219e6ea1c00mr709992435ad.14.1735869040635;
        Thu, 02 Jan 2025 17:50:40 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:40 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 7/9 v2] cgroup: remove unneeded rcu list
Date: Thu,  2 Jan 2025 17:50:18 -0800
Message-ID: <20250103015020.78547-8-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the cgroup_subsystem_state now owns the rstat tree, the list management
previously done on the cgroup to keep track of which subsystem states are
participating in rstat is no longer needed.

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


