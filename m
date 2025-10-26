Return-Path: <cgroups+bounces-11180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A30C0A16B
	for <lists+cgroups@lfdr.de>; Sun, 26 Oct 2025 02:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393E93B671A
	for <lists+cgroups@lfdr.de>; Sun, 26 Oct 2025 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1712040B6;
	Sun, 26 Oct 2025 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Iy9f2T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6E190685
	for <cgroups@vger.kernel.org>; Sun, 26 Oct 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440733; cv=none; b=TETo99RJh/tI+NMMUTzAPlaffEd6YDiMMddcP4LM4G+pRKSONPf2k3WY6wY7PgeWNDLByLqYYeQRc6hvKhMuaBqMn8CV/V3LbjGnGBZquHfU59qhrGrGSw8ZdosMoQuNNWjhFQvRXX0/rsabmj7pdGV/ierAgHWlgUyVHzEcLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440733; c=relaxed/simple;
	bh=U5EN1inT/kWM5m4A5MzxqH+G+G2lk8n2GRDVD/piabQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLBKq350AIeoIGOt0WrB6iuYV5YTIyV5o8DtZP2y/gHMuLQNQ2HWhoveQtXKENNGoIhV7NhJmNahSk71vfIbmGA8KhE4OUEVWzsgaL6/Ipx2+XE1dCDkeVpOYvTZ05iABF8mqYL+PPYxh7oGCHDaKe55Hh0nPvEewn9YZ8ctIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Iy9f2T; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af743c232so3184919b3a.1
        for <cgroups@vger.kernel.org>; Sat, 25 Oct 2025 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761440731; x=1762045531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N36vhbRkSG6GC2TdNjzZ1OMz+RKJl4mIAfGLbGj75+A=;
        b=j1Iy9f2TPRyMJwkKPAyvnPC1tYWEIeFChtNr/s6cVRRys/vLihi499e2NJ7oHEyHrN
         KGrGbLXQGwxWQlbckgT1uODniyVUWl/g4hdoTb3PRsxO8yXa+U0XSVWckRqDAxUXaXMJ
         N/tRdXqjaGCtUDlU4B/KI2KLSBKNgQVMZlkJFumzr4P436F4/CEkBW9MozD8CN0kUVdJ
         zV0f0hsHgpzJzBDk5Uf/uoj/W2QTCyyx4ZmGfT0jRzcbwbU0VeMbN2Pd6oXWcnIJ2pRH
         v7syxewPeEEjzsHCVtpvLxSL37pmn5RUQL3Kt1Ae6ge3+8w7CiFTiWQgV6neqZ26gNdU
         jaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440731; x=1762045531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N36vhbRkSG6GC2TdNjzZ1OMz+RKJl4mIAfGLbGj75+A=;
        b=id1sbL+jYmpEuxkt79DwnthOsvLVM6/qIliv9uAWYPe6HH/DPYgnuHufFKSV6qipGR
         gVHKokV73TRoxt7ojnMdX1X9zjuQ2CD3x6V8a0BmyZcoz9S+wiB+uajbPNiQDhy9HuQk
         JK4EG2O+fRMjrp7qSywH2CWw87qjZnrDZNPwKQ+ExCMUKA4BoiNS4nBZc/kCagyS6NkY
         IK7N/Ky9EAxsvirB3FewYEogZCGh4ySavVPSmjmJa0rTgm2N32W2hP3Fj1TgnjXaA9d2
         tybRL5Cye6oMR5FVOstTWwFWoSshPmm+ga9JcXV2aBD+/iG+5ABy+pj/bceTJPbGuHmS
         giRg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3LuomUdbjgenUbWANFt1a0nnO8vUpNbZut6WiCwM9QJ0cPKfuY5QE5se7x7rKmeJwPMEJE4N@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHh5ol1d75ZknQY/jqqmHBe1QTcpBfZpr79d+naZTzsbGSiUy
	sX0tkdyvKs7uo2HcOpwMyx8P8ydv3N+SbRYghFDwe27Ig9CQpwQLQBsg
X-Gm-Gg: ASbGncuS4VBQWeQ26BJj6eEKqu5FAAPTQk9GiImnCUJqGXACgxAuOpxi3veLDcLv+0d
	YVxHrDHk/vW5x0/X8HX2zJgIEncM17bhBMRSMbDzEsYlFFbHsIchsjS/K2yPIOAEmO8XKKcgTiu
	HHtb440VlalIz9T6SbSfBMJiev5u+SDq09IFoHgIB3H7FUIE9WUhLPkTNif2oUOhD1xwf9H+/xt
	Es6+08F+yr+5ra6Dwux0PQQ9OW+wdNeSq7RCZf1G1Ng/qhlE+RymdmFeJuXx+EH0qgg7mkkSmXV
	hBzIWSL3837UGi/IWAp+iFOnLfwxX6sHny3RgjIod9D0eP/aq26K25snB3LI1wxGWSivFX0sQf7
	jzMVCG2Bn/We0mHtXtvcKPn+Lp7YUe6arjVJ+Tfls/dt2Pz0iHYWXVDZoZCCaG08aTEJaHXRsrR
	zKMx8=
X-Google-Smtp-Source: AGHT+IFqnGHut/11Suj2FeTeWv27UHLAlLr0nFmnErIj4agIj4rm3uNWP4XEpAPa8D23/k1s6P6wnQ==
X-Received: by 2002:a05:6a21:4cc5:b0:340:6a50:7e9d with SMTP id adf61e73a8af0-3406a50809cmr6289528637.54.1761440731426;
        Sat, 25 Oct 2025 18:05:31 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm3371597b3a.36.2025.10.25.18.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 18:05:31 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	axboe@kernel.dk,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	terrelln@fb.com,
	dsterba@suse.com
Cc: muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	zhongjinji@honor.com,
	liulu.liu@honor.com,
	feng.han@honor.com,
	jinji zhong <jinji.z.zhong@gmail.com>
Subject: [RFC PATCH 1/3] mm/memcontrol: Introduce per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:08 +0000
Message-ID: <18d8e6b876ea3ae98bff710474423a9a530f4a8a.1761439133.git.jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Android, applications have varying tolerance for decompression speed.
Background and lightweight applications tolerate slower decompression
better than large, foreground applications. They are suitable for
algorithms like ZSTD, which has a high compression ratio but slower
decompression. Other applications may prefer algorithms with faster
decompression.

This patch introduces a per-cgroup compression priority mechanism.
Different compression priorities map to different algorithms. This
allows administrators to select the appropriate compression algorithm
on a per-cgroup basis.
---
 include/linux/memcontrol.h | 19 +++++++++++++++++++
 mm/memcontrol.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..a91670b8c469 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -228,6 +228,9 @@ struct mem_cgroup {
 
 	int swappiness;
 
+	/* The priority of the compression algorithm used by the cgroup. */
+	int comp_priority;
+
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
 	struct cgroup_file events_local_file;
@@ -523,6 +526,22 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 	return memcg;
 }
 
+#define DEF_COMP_PRIORITY 0
+
+/*
+* get_cgroup_comp_priority - Get the compression priority of the memcg
+* @page: Pointer to the page.
+* Returns the compression priority of the memcg the page belongs to.
+*/
+static inline int get_cgroup_comp_priority(struct page *page)
+{
+	struct mem_cgroup *memcg = folio_memcg(page_folio(page));
+	if (!memcg)
+		return DEF_COMP_PRIORITY;
+
+	return memcg->comp_priority;
+}
+
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
  * @folio: Pointer to the folio.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..436cbc8ddcc2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5356,6 +5356,31 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int swap_comp_priority_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->comp_priority));
+	return 0;
+}
+
+static ssize_t swap_comp_priority_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int comp_priority;
+	ssize_t parse_ret = kstrtoint(strstrip(buf), 10, &comp_priority);
+
+	if (parse_ret)
+		return parse_ret;
+
+	if (comp_priority < 0)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->comp_priority, comp_priority);
+	return nbytes;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5388,6 +5413,12 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.comp_priority",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_comp_priority_show,
+		.write = swap_comp_priority_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.48.1


