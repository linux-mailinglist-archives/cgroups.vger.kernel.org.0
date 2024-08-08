Return-Path: <cgroups+bounces-4162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDD94B42B
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 02:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE16C281596
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 00:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4788827;
	Thu,  8 Aug 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQvtOBpL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F44A2D;
	Thu,  8 Aug 2024 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076759; cv=none; b=rD20D8MUTeGy+5Pqw3amC/IZyfPMHOYmNKqa1bsR4kQfb/m7nTTSNIv48X6rCw3OXIS3Djv/dkq8L2IkhTCRaJES1IVidTuKyVL/klny8tt4rR25q0SB7zY04uJ5FFstYu+fFSuLjrMQ/s/HMQP0ENwmRjzUaP9d337Up+uFZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076759; c=relaxed/simple;
	bh=SwWzscWvhSHwJDskPQzcUxpYv58A0vJuxdqe2EGeoVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYomv4pzdW8KW230YxzWVN5mJK3IYJItPKfCYZE2s2pzqw2AGnbManD9TP5jXRK8AzdEs/L42WmieMZfNptx8gyZ6ZrKpK4yOsH+6YczB5lZO3fTts7nEns4+2SG2KRMHnt0sTBLoNAfyFSEybUKcx4afE0q3aPAMi6dp3O+1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQvtOBpL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso386435a91.1;
        Wed, 07 Aug 2024 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076757; x=1723681557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR8y/y3faACXUg3XGox77Fv0TZHfPAzANEHW9f0MudY=;
        b=WQvtOBpL863qm0/xO5+Sr7sXvkbAN5pZml/j9vjgQX0Uv/0J8C/4GQyHjv4/gYLQz+
         oxI3SaoGK8+mjCL7PbeOXs37bZUfuZGfMdpqsAuoiIZ+h4upnk6SH1KMT/QKBqpgjmsm
         qLZC3gtkvNCxxIKusanWb85ORDTt9PqCIo/C07WCLfjCP+kxjn8eQ+ZB+GI76KIMiT9V
         Z6zlGZtncoVaKf3hBeWz3oLxWo7WZHDYvUz9bKzbTaZAWu2WeIk1dRnBD4PlILTdkGff
         yqms5kyfFotQ6q5PgQ1nRO5+Erkg4B4cOCvHb4uKHHWDCe62a5qlSztjs0yHtbPrC81v
         3w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076757; x=1723681557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KR8y/y3faACXUg3XGox77Fv0TZHfPAzANEHW9f0MudY=;
        b=PDSB6jlm1+sk5kCuDp5gN5krFP2D873GY2ckCQShLW1fOV7/EZmnGZbIq+FA4rrjHm
         qtLvWFH4fHGsWu5CwJ65IiG9WryF1j95OqK4FlaEq4bvduiIfGGFPqxSMJdbq8TqIuEt
         M+jYQ1F0dHXqvNBxzyGRiNYs1YhfB4w4u5Bq8yPDp9tnomp+0yMBX12wg8zjzryac68b
         iKPpGr3HXQeMWIryFWvddOAwtS5oasRfUZeV51fk5j59VF+6O5KPrsZbGG5IwIU4SOOY
         miyrVjP201E/tW7nPw5Sb2LDpUTeS+z+donvwglngTmAIg5dh1ANhAHuvpRHcu8nSxHl
         fHnw==
X-Forwarded-Encrypted: i=1; AJvYcCUvgukHuM21gcrpZsBZB5+45wfcsYn2AbsEXWHM8amJjYyZnqqTy9Eyr3ksVkyTLc4qWkqpsA+AO0x0L4QO9MvZPulhJNVb66N3UxuR
X-Gm-Message-State: AOJu0YzBNRzH1HH3326wS8rg71luJaGcXYTmsFGZ2+SOZwvaYlkolQac
	97NI0oPIPHQuiKK2KoWH5mTRIDvZeqnzj6s7Jy95Qs9A6vHasZ0tsN9Eiw==
X-Google-Smtp-Source: AGHT+IGl6UYUfIvMz3Ux6OGU1W6pBvXO9iYru9dRUcTaKQ+30mfOZvEL2YH6ROchXx1irn9nxot0iw==
X-Received: by 2002:a17:90b:3503:b0:2cd:2f63:a447 with SMTP id 98e67ed59e1d1-2d1c346b5ebmr292596a91.36.1723076757215;
        Wed, 07 Aug 2024 17:25:57 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b36dd511sm2218437a91.34.2024.08.07.17.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:25:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>
Subject: [PATCH 2/7] sched: Expose css_tg()
Date: Wed,  7 Aug 2024 14:25:24 -1000
Message-ID: <20240808002550.731248-3-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808002550.731248-1-tj@kernel.org>
References: <20240808002550.731248-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new BPF extensible sched_class will use css_tg() in the init and exit
paths to visit all task_groups by walking cgroups.

v4: __setscheduler_prio() is already exposed. Dropped from this patch.

v3: Dropped SCHED_CHANGE_BLOCK() as upstream is adding more generic cleanup
    mechanism.

v2: Expose SCHED_CHANGE_BLOCK() too and update the description.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 5 -----
 kernel/sched/sched.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0e64a9362aa1..c9678614e476 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8918,11 +8918,6 @@ void sched_move_task(struct task_struct *tsk)
 	}
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9373426d5aae..e38e25d00d88 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -514,6 +514,11 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 	return walk_tg_tree_from(&root_task_group, down, up, data);
 }
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 extern int tg_nop(struct task_group *tg, void *data);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.46.0


