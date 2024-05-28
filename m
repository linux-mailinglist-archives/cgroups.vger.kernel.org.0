Return-Path: <cgroups+bounces-3024-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1C8D21BC
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8AA1F251A2
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E543170826;
	Tue, 28 May 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/1j5USv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B416C86F
	for <cgroups@vger.kernel.org>; Tue, 28 May 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914256; cv=none; b=Lu2HVdEanIfDZfKm8getjYiFu/BkTFS4KcQMpaU0mpZXDB7hFdhhQ5ZBiH+CXbWGvy7YQDl5YrxW2bdECP/XpEFYetWJ7fgWqEqsiqpyzCrLnsFXCcWZi6v8FL9qaE8JokR6ym+m6qg3pRmrZgu3ahHyRnjVScCTavYKWtEJcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914256; c=relaxed/simple;
	bh=/r/SLL08HjdI46x3LF0p3F/u9Isqs916m5IdhjUo0RM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ICp6x+rofB6X7PIpejbsf1BPtC/sw8pRXU0xa7Yr4rwMnf8VnWT2OjWSlUrSsDi7pqThnfJQ1H8ZhpdOIMAU9fdCkaNFRU99Q/NokMulhE2j/j1eTTKlqn8xfadlE+3c6vtYQ5/o65eC/sAbsgNw7n40hLormwzdakY5InLT62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/1j5USv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df777ba71e2so1736363276.0
        for <cgroups@vger.kernel.org>; Tue, 28 May 2024 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716914254; x=1717519054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6GEC5jqmiiBW2QPmiEul4IbzhqqHXLiTP01MQ0qoF6U=;
        b=H/1j5USvXTvJmWhwuOmLQmLvHdkM1QA1Yt5EkrBom21ZMXsaobXqIvximIHr4pIvzY
         AFpA9EjUNSeJeRveYgHTrvsz1MAkhGVR7bGra7fVK5OfpjPYNQ4Tl7Ol1Bs07WxqFp5x
         3bOseOJaSUmMSr1HHAJdHkhr5j5Ml2kCDwDOO3K3PES15sZjSGQ8V4qkd205rgw0BkKG
         HUfx5HrrQNkRa5RF6aCii//d2Se+BublsMptqKOqKKnWAZy5ciXvmNvzr1zAgy6Fk1N2
         wl71h1PIRqXQSNzFS79DwWA/b2SYk2FlcX/ZJjMBVWUWlYnlLzsiaSnHOpIex6zMYAvI
         pMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914254; x=1717519054;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GEC5jqmiiBW2QPmiEul4IbzhqqHXLiTP01MQ0qoF6U=;
        b=hM92E+GzjE4KCACgZmbUpXUzSVnwumLd6jffwuFXGdZmBHsZumHObBAzuzISoW0L3S
         e0Lzt4MYTPnrAMFLRVwstjmwx043ztczG2TcHUyBm2yemiq9Zx5pv6hXvsyltn5Fm6ad
         5Y+au1yVgKACRycz3euOa2+LYURQ4NBEQT8fDpBjIqfyWG8iY4pEqYo/938dsQgzXfhO
         s9MoE7wDSfDWzW2xgQACkRlPVipFmigyFyz5Th1tcFVtFT4jB9C9frvEpPIhukmd1SMz
         LvZoHldlkFXfiHpEQ23EhI9l8NkEiTRneQpQR5CNdIq4qcw5o0FVycLedci8QAg4ulxI
         V9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVyAgFcyWyufCMx5Hyo4Oj6l7bUup8T+WMxMhPz13R1KM6r7iwpbC2YxvR0x0sSHwmsrS5j3sxXVJmLskOfijsIts12Rk3l+A==
X-Gm-Message-State: AOJu0YzASLNpyEChEmZIHQKWJV1uYETVsBn20rAuddsd/poaKtPTU77G
	fj46iyLOxNP2+EoTRa7nYf8Ep57rh7c0YhVaDVrS+QUh2LgKKLVl5M1ioQZgvgwdbvN3hZdVFwx
	0AptLdNvsajqCMQ==
X-Google-Smtp-Source: AGHT+IFCM8agQwohlgmz/X20yI5XC7cbVbMVjBbNM657wC++i+TlAhU6zWE3+cMrzjDCjID8rBD8gKeQnEhFQnM=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6902:f85:b0:de6:166f:3250 with SMTP
 id 3f1490d57ef6-df7721c1a20mr3534064276.2.1716914254444; Tue, 28 May 2024
 09:37:34 -0700 (PDT)
Date: Tue, 28 May 2024 16:37:12 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528163713.2024887-1-tjmercier@google.com>
Subject: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, mkoutny@suse.com, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The /proc/cgroups documentation says that the num_cgroups value is,
"the number of control groups in this hierarchy using this controller."

The value printed is simply the total number of cgroups in the hierarchy
which is correct for v1, but not for the shared v2 hierarchy.

Consider:
controllers="cpuset cpu io memory hugetlb pids rdma misc"
for c in $controllers
do
  echo +$c > /sys/fs/cgroup/cgroup.subtree_control
  mkdir /sys/fs/cgroup/$c
  echo +$c > /sys/fs/cgroup/$c/cgroup.subtree_control
  for i in `seq 100`; do mkdir /sys/fs/cgroup/$c/$i; done
done
cat /proc/cgroups

cpuset	0	809	1
cpu	0	809	1
cpuacct	0	809	1
blkio	0	809	1
memory	0	809	1
devices	0	809	1
freezer	0	809	1
net_cls	0	809	1
perf_event	0	809	1
net_prio	0	809	1
hugetlb	0	809	1
pids	0	809	1
rdma	0	809	1
misc	0	809	1
debug	0	809	1

A count of 809 is reported for each controller, but only 109 should be
reported for most of them since each controller is enabled in only part
of the hierarchy. (Note that io depends on memcg, so its count should be
209.)

The number of cgroups using a controller is an important metric since
kernel memory is used for each cgroup, and some kernel operations scale
with the number of cgroups for some controllers (memory, io). So users
have an interest in minimizing/tracking the number of them.

Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
Changes from RFC:
Don't manually initialize the atomic counters to 0 since they are
kzalloced - Michal Koutny

Also return the CSS count for utility controllers instead of the cgroup
count - Michal Koutny

 include/linux/cgroup-defs.h | 6 ++++++
 kernel/cgroup/cgroup-v1.c   | 8 ++++++--
 kernel/cgroup/cgroup.c      | 2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ea48c861cd36..bc1dbf7652c4 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -579,6 +579,12 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
+	/*
+	 * Number of cgroups using each controller. Includes online and zombies.
+	 * Used only for /proc/cgroups.
+	 */
+	atomic_t nr_css[CGROUP_SUBSYS_COUNT];
+
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index b9dbf6bf2779..9bad59486c46 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -675,11 +675,15 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 * cgroup_mutex contention.
 	 */
 
-	for_each_subsys(ss, i)
+	for_each_subsys(ss, i) {
+		int count = cgroup_on_dfl(&ss->root->cgrp) ?
+			atomic_read(&ss->root->nr_css[i]) : atomic_read(&ss->root->nr_cgrps);
+
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
-			   atomic_read(&ss->root->nr_cgrps),
+			   count,
 			   cgroup_ssid_enabled(i));
+	}
 
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e32b6972c478..1bacd7cf7551 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5362,6 +5362,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
+		atomic_dec(&ss->root->nr_css[ss->id]);
 
 		if (parent)
 			css_put(parent);
@@ -5504,6 +5505,7 @@ static int online_css(struct cgroup_subsys_state *css)
 		atomic_inc(&css->online_cnt);
 		if (css->parent)
 			atomic_inc(&css->parent->online_cnt);
+		atomic_inc(&ss->root->nr_css[ss->id]);
 	}
 	return ret;
 }

base-commit: 6fbf71854e2ddea7c99397772fbbb3783bfe15b5
-- 
2.45.1.288.g0e0cd299f1-goog


