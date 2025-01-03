Return-Path: <cgroups+bounces-6027-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE97A00283
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F3A3A3B1A
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CCA14A614;
	Fri,  3 Jan 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpYSwZ1h"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDA14D2B7
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869037; cv=none; b=elpu/VphRfm8gzmLsbm2r1fAM84QaI7u3ZgGDclnSVIazlOmIzhFOlhalfUGb9SJLSyjrRR59HZFET0rq57dbuqMxpyrDcYk/x/NG0qZdm/sKQcwaZAf6XbSMI/DJ9CyVnmPFeZwq4b0+I5TyYK29XQ/XFpqXk8HsCdYfLhpiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869037; c=relaxed/simple;
	bh=SK6fSSW5RYVn1W7MpA9r36xCKpbAs9oQp1LcBkra2aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quRBzFE00UK6Au/Rqlxnjsk++pEuBzF1g6I3ETX9WHtZzoF6XPgVebpCcsvhCWWUE9aRqCnQxb8yyk2VyqQBc63/+B9b7PIThpxVpRmbITwW9cmcOb8rfJ+OTohkEZ7bSbHTbWMvSG7GHyNvWdrstBkrKpKtULKdOjqtST5gUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpYSwZ1h; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f8263ae0so119922205ad.0
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869035; x=1736473835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fygAlv7C86dgt6jCWO9W9TZivz+mHpPPlFRRnfsUsg=;
        b=GpYSwZ1hSfiR0FHVm/De04mh18HX5jUOLXtcwuZdVK0OuflwoVTCIwWncj4Mon3HWS
         VJ1Q6DgM8F9fvxJHr/qmLymskxjcZvPevPReKvntHryaQ/UCqxso+NucBHfx5j7X5UKC
         JDTJ19HURupL0l8FwNvEmmK6fARuqqzAVSoYvy5JN5jIR/asM9aFWDTT+nMLXAqfDbg/
         dPzQti8IAVP7HJioy5eBz2rTfFFCMgFBamBbwagG2Lcvo27yzDcH+C3y488mJGB14wd3
         5ZvuBRIaEcBsE2yzMa89GNLgU/IlRQnT8m3zSoTsCu5DwWF0k4gimE5rXG/LdRsIexP5
         WPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869035; x=1736473835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fygAlv7C86dgt6jCWO9W9TZivz+mHpPPlFRRnfsUsg=;
        b=QGwSx3tTWthXyABmK6w+HwGHMuQOBi6D8YegKAXC+y6GeU5QPm5VQap4qVfpfzfJ5r
         9CAl3RgZHVHMe+Cv9CyPQ5EfR5NQn7/wQvQEQ15hZOZgKhS8m5/iIo8fnXh92du4K0JD
         WwUaxvo17CKPyXFKlIvPWKItfdF1DWfcZ0tigq86xFf/aMam4QmoWtNKOLvmlOy5Djr2
         gSvTQEiB4Na9C+Sr8G7OQuqdhlvMRkIee7JJ84akrWYLVepKel45m76PdfnqwqM9hs+7
         dG3E6q+e3qkXOGCqSm6YeKcLJAFL80KYOPMO1d5cOzEHdzp7HTCTK5NctWZtTUDjxJZQ
         saDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVdb8tiV8JAPFvKUCQ/S0epXCtMXlJ0chH1VaBqtCsYoBaAT8MuuA/+vZOuZH7WR0vrF24jrbi@vger.kernel.org
X-Gm-Message-State: AOJu0YyQATiXRJ0iYSQ40NlNHz8vhme6h+3ep4CyFfDWoesnSMtpStCZ
	u7ZuO/5TXCpFTYnzk29wIBTJbrgNqhMP681W5m7VLAABkbjrTiZ9
X-Gm-Gg: ASbGncu6v4a9kNp83nIWMKOC/Pq38T8RhEfaBH2aImpdhxgQtFF3bZH1HE/U2oyUTD3
	yEKPGmZ+AKAl23QEA/n8UP6kZwO4ZEJ12ZcQmLSOi0fdhgyHZlSVL9oE3YNTA8tZI8ctLhjjHGs
	WuoOHfiAeybfvByJWTdlwDOZ+AWPqvsuIgxYhHXtMSQMSQrnh5qgCYWCkWuOtEJxNcootHSBKUT
	9905HNV54yqvOSGZn8CzBvaCYebyd2Xa4Fv0OkHWcfsIC8u6AjXUA7JkElMDbNLBeMAy5LH2G3S
	FSEz+iqAr7CV1cSfkA==
X-Google-Smtp-Source: AGHT+IFUq6pIKACZFu16YUBj6vJ2nI7etocge0+ZlELfgHcsYpw2HURYCpbJolc7uELa/ETm08W0tQ==
X-Received: by 2002:a17:902:c951:b0:215:a039:738 with SMTP id d9443c01a7336-219e6e8928emr709570885ad.5.1735869034959;
        Thu, 02 Jan 2025 17:50:34 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:34 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 3/9 v2] cgroup: change cgroup to css in rstat init and exit api
Date: Thu,  2 Jan 2025 17:50:14 -0800
Message-ID: <20250103015020.78547-4-inwardvessel@gmail.com>
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

Change rstat init and exit API calls to accept a cgroup_subsys_state instead of
a cgroup.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/cgroup-internal.h |  4 ++--
 kernel/cgroup/cgroup.c          | 16 ++++++++++------
 kernel/cgroup/rstat.c           |  6 ++++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c964dd7ff967..87d062baff90 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -269,8 +269,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 /*
  * rstat.c
  */
-int cgroup_rstat_init(struct cgroup *cgrp);
-void cgroup_rstat_exit(struct cgroup *cgrp);
+int cgroup_rstat_init(struct cgroup_subsys_state *css);
+void cgroup_rstat_exit(struct cgroup_subsys_state *css);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index fdddd5ec5f3c..848e09f433c0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1358,7 +1358,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_unlock();
 
-	cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(&cgrp->self);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -2132,7 +2132,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = cgroup_rstat_init(root_cgrp);
+	ret = cgroup_rstat_init(&root_cgrp->self);
 	if (ret)
 		goto destroy_root;
 
@@ -2174,7 +2174,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	cgroup_rstat_exit(root_cgrp);
+	cgroup_rstat_exit(&root_cgrp->self);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -5435,7 +5435,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			cgroup_rstat_exit(cgrp);
+			cgroup_rstat_exit(css);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5686,7 +5686,11 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	ret = cgroup_rstat_init(cgrp);
+	/* init self cgroup early so css->cgroup is valid within cgroup_rstat_init()
+	 * note that this will go away in a subsequent patch in this series
+	 */
+	cgrp->self.cgroup = cgrp;
+	ret = cgroup_rstat_init(&cgrp->self);
 	if (ret)
 		goto out_cancel_ref;
 
@@ -5779,7 +5783,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
-	cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(&cgrp->self);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1b7ef8690a09..01a5c185b02a 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -390,8 +390,9 @@ void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 	__cgroup_rstat_unlock(css, -1);
 }
 
-int cgroup_rstat_init(struct cgroup *cgrp)
+int cgroup_rstat_init(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	/* the root cgrp has rstat_cpu preallocated */
@@ -412,8 +413,9 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 	return 0;
 }
 
-void cgroup_rstat_exit(struct cgroup *cgrp)
+void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 {
+	struct cgroup *cgrp = css->cgroup;
 	int cpu;
 
 	cgroup_rstat_flush(&cgrp->self);
-- 
2.47.1


