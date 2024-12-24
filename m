Return-Path: <cgroups+bounces-5996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA59FB829
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A8D1646F2
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A3C8CE;
	Tue, 24 Dec 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDnIW0Bz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698F946C
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002858; cv=none; b=L1KUpmWfITDb2zu0iOgsphQjH5e2hxLnz2acKBwgIl44GXHT0Ojxm8xwL2Hj7hBibmNyHU63HYknKdTJlFdjWWiFDGKz6LHkLZ95jNaXa6glaj21KY3X9vkg8JwZsDtB9Waqw2lziOj/fEnTotqQqgkxKULVUwZ/VUZc+8dfWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002858; c=relaxed/simple;
	bh=ooKjEt/GVsAvHGFIw9to7MKjne52k4Lsk8N888O364U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUPq01PpVKuJaZSuyF5RAR1WapgW/cZOc41P1clD9xmWAouo4X4xjmmyiGt+HxrrcObEu+GfplHnqG9gPe2pntLqgRtqYCZ8ASnqUqPO28/K/7kwbi2Jv52VA+/wiF8/oZRwRVyNkEx8K03lTFhO0X5ub+XvveH2K7nFkWa1VZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDnIW0Bz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21644e6140cso47073835ad.1
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002856; x=1735607656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWty/mMu5b89nU3pRLtKHkGxN7KspqZ/3bLWyjMFJcg=;
        b=eDnIW0Bzgl2ParEgsLJnoBd4q+C7JBMhvHMOPlICaR3EJpd2NvHNfOjUp5Xp5kF6lv
         md19WjlUr5uG5pfyV4E/JHg4hpAy7kulsoaRURJBGkUDp9W/8kTnMaQSGyd04HCXnAF+
         N8gbQ2lDrhfXSI+0GEkhJN0YjsE4tHjNxbVvD+JmguDS/d8+Gw0itq2nU7KZVsa4AEj0
         6sr/3QtqCxcEwUh8c5vcpS5u5Y5I4/ZMtddYP3GIoyUw8nUEFEzIMFB5RESxaZnzcGqo
         k885Lk4GLCWZfRasyVa0cCdQ7R+BrJUM1LB0f0lLtUaO5SLYNIQbBZ1P84wJKpDoe8Rj
         meaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002856; x=1735607656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWty/mMu5b89nU3pRLtKHkGxN7KspqZ/3bLWyjMFJcg=;
        b=ZZyqO82Lu0npW8foIkBVNn9rvxWyozIwXi8YLGdrQUQi0JWy5UgX5ybM6XuD5O87qq
         xfR+hJpw588S1JgClrYPBxgsfi9JO+zfuhwmbf6RBKHvFsvbyUGp2+DLepY8iGoj5j/B
         CwKNAGfEANvjRZWFOA3Y8Htdt1Mb0jvcQ7993vggyjvZkNohzh8pfUaAjGAePGOJM/JK
         WKFxeXrIoqAZMxZN2sTD3+HabtEo2zoWb6CmN6Pfe6jTuaENC9cHiobxOLx5fY2hjsYd
         Z1ptRJS6PpJf1plgsoXlkJnRvXkzt2iSHamDc/BMMNw0gfeL0jxGWm4aQ0nDIHWt8kAa
         JRIg==
X-Forwarded-Encrypted: i=1; AJvYcCVS7V489z+nAloLpy8l+J9gYOxwzfazQaOmgbZZA5Cla4Xwrma4iX5t+3M4cSRwfTZ5Zr/fchzW@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBS46UeqrGlzYqU9YHEg3ctaRSLQMvBvVr3O03/9YBoFLDAgN
	e3Bb4ZVKgDN9fUtd4wglah7/iOXOI+OdyS2ZWuCRBAtcvuDjodvK
X-Gm-Gg: ASbGncvA98E3O/0oZAJv9TlFkv9KsUxyK+wbiW7xw/hXdIwi+iZYzAjxz8rRnCxeMOP
	wFn5BeyLhH1ElMSgHuXIiG0LD3mcOK5mK1LkwKy9kZzOSkKWGvhkzxgPn5QudIiqPdTT0ypJXOR
	QcKf4N204S+LjcNe1JpmN1UA8VVUX4BzvvaSWuRMUbu9TJVQajxd7oUf4vUUN/Omy9uVHkRsdSp
	PPiAkOg/RTcSuqgnV5u+MgvypeBu5LqV7kzHjhiAEp9Th8SLoIdRa7NC44VAJX10at2omD3rcjv
	mW1M8XXeMeYdBHPaCg==
X-Google-Smtp-Source: AGHT+IGWsap+rf81uOwV/i5d8iA2KStdKUOzB7fbhzdvPn0+dAjQ8cTLglNwC2zy+of0DesGiNk7zA==
X-Received: by 2002:a17:903:2444:b0:215:4a4e:9260 with SMTP id d9443c01a7336-219e6ea1c34mr187867835ad.14.1735002855905;
        Mon, 23 Dec 2024 17:14:15 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:15 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 2/9 RFC] cgroup: change cgroup to css in rstat internal flush and lock funcs
Date: Mon, 23 Dec 2024 17:13:55 -0800
Message-ID: <20241224011402.134009-3-inwardvessel@gmail.com>
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

Change select function calls to accept a cgroup_subsys_state instead of a
cgroup.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 45 ++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1ed0f3aab0d9..1b7ef8690a09 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -201,8 +201,10 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
  * within the children list and terminated by the parent cgroup. An exception
  * here is the cgroup root whose updated_next can be self terminated.
  */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
+static struct cgroup *cgroup_rstat_updated_list(struct cgroup_subsys_state *root_css,
+				int cpu)
 {
+	struct cgroup *root = root_css->cgroup;
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
 	struct cgroup *head = NULL, *parent, *child;
@@ -280,9 +282,11 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
+static inline void __cgroup_rstat_lock(struct cgroup_subsys_state *css,
+				int cpu_in_loop)
 	__acquires(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
 	bool contended;
 
 	contended = !spin_trylock_irq(&cgroup_rstat_lock);
@@ -293,15 +297,18 @@ static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
 	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
 
-static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
+static inline void __cgroup_rstat_unlock(struct cgroup_subsys_state *css,
+				int cpu_in_loop)
 	__releases(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = css->cgroup;
+
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
+static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
 	int cpu;
@@ -309,27 +316,27 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
+		struct cgroup *pos = cgroup_rstat_updated_list(css, cpu);
 
 		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup_subsys_state *css;
+			struct cgroup_subsys_state *css_iter;
 
 			cgroup_base_stat_flush(pos, cpu);
 			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
 			rcu_read_lock();
-			list_for_each_entry_rcu(css, &pos->rstat_css_list,
+			list_for_each_entry_rcu(css_iter, &pos->rstat_css_list,
 						rstat_css_node)
-				css->ss->css_rstat_flush(css, cpu);
+				css_iter->ss->css_rstat_flush(css_iter, cpu);
 			rcu_read_unlock();
 		}
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			__cgroup_rstat_unlock(cgrp, cpu);
+			__cgroup_rstat_unlock(css, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(css, cpu);
 		}
 	}
 }
@@ -349,13 +356,11 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
-	struct cgroup *cgrp = css->cgroup;
-
 	might_sleep();
 
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_lock(css, -1);
+	cgroup_rstat_flush_locked(css);
+	__cgroup_rstat_unlock(css, -1);
 }
 
 /**
@@ -370,11 +375,9 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 	__acquires(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = css->cgroup;
-
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+	__cgroup_rstat_lock(css, -1);
+	cgroup_rstat_flush_locked(css);
 }
 
 /**
@@ -384,9 +387,7 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 	__releases(&cgroup_rstat_lock)
 {
-	struct cgroup *cgrp = css->cgroup;
-
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_unlock(css, -1);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
-- 
2.47.1


