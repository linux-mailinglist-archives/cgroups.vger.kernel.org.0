Return-Path: <cgroups+bounces-5999-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9687D9FB82C
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9B164686
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64F1FDD;
	Tue, 24 Dec 2024 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX3bPFoe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31517D299
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002863; cv=none; b=eaAQR3JcGRWciwqRZsdEYdmU7ReGj6XQCOH9t0GH7dBXcsOokYgmf6C8cgKBDxjaQsSXUZAGBfYgQcxAMHB7hGLkMQiekKzQnf9uFfnHlA054NpSbl9LPcqlHiel5k/xCraZ5rGuSEg6cy0tt+ayD2wdbWVr6a7lOeKndqsG1ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002863; c=relaxed/simple;
	bh=VFEeIpBNH9iGwvMWic0tCdbGa0GeUXb8dNk6YvO7jWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xoicq8t+HKRxVQRXv3JbNFmiE/HkeQ0IzXvKHnY3dRsR6xm0Ngpgu8EwzZGLnZGcNtq74r1gSbVgJZzSPXOSOwDMZgDIy85X18RoN+Nqe1fCxaraDtAWZciOd0jjqBDSh2v4T3jPq0OjBmGujdPNd09IQTGdupY9371xypj+Xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX3bPFoe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166022c5caso40021915ad.2
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002857; x=1735607657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL2jgd7riB8bL0/y/2MxSvAIl3x85Oo9zvXWGx0Vk6k=;
        b=QX3bPFoeI2OJk6BtE/HyHKPoVV/UFYBFdHgookXUvxkpbgaVatCxkU9xOMpvhtuek5
         Mt4dpkETTUkZQhgqO1RYoRrbpDU4vifWOXPMF4IFoguloGBux0HsLzMb1IsYWp80ir4W
         nOrgTs2F9LTmaBGmuhoOsF45YG+Ng0aex26d+Uyfko1fLBTH+63Trr0+/U7G2FfsH3HN
         cYTq0YoMb6NQIq9iLQKjN5bmsbMNYQ6JRYM25Lfj89YjVnVRcpdAzCNP9pZD+lJfROe9
         NDh9WqQeWF55lyTsAMt0AN8zZsbK90GkR2XmK4kq7ZHx6zyP74KRzs1TcEwojByiRSN1
         saHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002857; x=1735607657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL2jgd7riB8bL0/y/2MxSvAIl3x85Oo9zvXWGx0Vk6k=;
        b=S3feTHLBRuuLH1CiH6rSioliyoC+XwpUF6dkHL43kVufF2dh0BPv9MvtJe2PV0E2gk
         CWoCpieReujm3GIsny25tjFj4tOMQvt8TE8OaO0UAcRICNh2nw2oBthMdR4wAavYNmVi
         naNJHEOOBKl98aDXOSjNmbc3xBOu96LIhOchmZsv82S2/KzbBKgFIr6A+o3nYrSfsYif
         rhgrBetU9QcE/ZzjxSSBIb4HRc5bEqeWZ0qY1uJiA3jAwjQn/ykt36FnklCFvzMXRN9G
         diTUbGflpeGBodcnEjPAAgAQGJHgmOaAEpvRsG0Ol7rkA2jxDmJEkfbmhsASu6OAMtAV
         j3gg==
X-Forwarded-Encrypted: i=1; AJvYcCUzr9o8Mb6wILnuSRl/dXX6gYzvYV10gJiYEhYkFVyrF877A1XvF/S3BPMhmHIB2Q84X7mDzubL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsg64VxVUzFPhDIF0Y8+DWGcx1m55mncSpsy1uqvjYNegN31vl
	knK+xoSFBWc0HACFy4jFbvrHEF+T2ZdzOMYzxaq4EBFpZSUr71s5
X-Gm-Gg: ASbGncumSsCUQVTBpUzQmZFem0sPZKjngnNrXnZRyaDuThhv/7MTI7KIcO03I2QUu9d
	vn1IhGuS0xqsqyWSefZ+tcmrjdiYaX1HBtHktHh+h6w0DYwZMrp6nUjH+Ubsi0yVBI8kYR1cfW9
	NdJyUVd6olX5RfmXJQ0BcbO3ALar5Wn7v4h/Y69PvkewvyyQK+dKYAJ+GFrg8DE2EwhQBjWZG6P
	UC1pvchTdYsMWrHQXnl4vzfSAuLprknfBLi9yUClEnbaPv1VIej2UAyk+ypfUu0upJR9VNOn5dy
	JcsIb8m3vaBgJGZEhQ==
X-Google-Smtp-Source: AGHT+IE3QHLwg9ReNpugqbcBsAF2fSOEsH+CCNMaVbUB+N1MFpxZaa07QtuA97SwYcItxeQb83M4Xw==
X-Received: by 2002:a17:902:c943:b0:216:6d48:9177 with SMTP id d9443c01a7336-219e6e8c7e8mr225018355ad.11.1735002857492;
        Mon, 23 Dec 2024 17:14:17 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:16 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 3/9 RFC] cgroup: change cgroup to css in rstat init and exit api
Date: Mon, 23 Dec 2024 17:13:56 -0800
Message-ID: <20241224011402.134009-4-inwardvessel@gmail.com>
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

Change API calls to accept a cgroup_subsys_state instead of a cgroup.

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


