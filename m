Return-Path: <cgroups+bounces-7145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3FA6853C
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B02424AFE
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2524EF72;
	Wed, 19 Mar 2025 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJUXalLS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C324F5A7;
	Wed, 19 Mar 2025 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366559; cv=none; b=ExWyxuAANho7IMZ8t/fTN+Q9qeDCgYWXlw+q7AkabnEIhs2HXlTmsif20HlpLqdaKDq23B/dN+2iUiCogxTJ/Qsh7LEyOKUfOs07bb2EjpJ58cZjOwbEXPSttEkeW2sTVvFMpcV/Wwcr2qSLTBUiExL5X9turJBbmPdZnChYOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366559; c=relaxed/simple;
	bh=B4KPy69TLaat/OJIeIvbTEHk/4yGu3xdBIlXrsUqLaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtrVJ4LRAGJL2B171qQKDsTS23ROhE8WmOInjhk4hD7Q4aYcguI6KFP7v73GzCpla92Hb8b3zSdTxiR8JtiK5xCqBpfWtn30y14cHF8xPXxcpgGs/nTsQBibyYP3Fd2EJIxlnkz08iJKCqOAXZxl8n13KRcXNr3iWjdYFNLiVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJUXalLS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c91576aso54871155ad.3;
        Tue, 18 Mar 2025 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742366557; x=1742971357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VG3Wd02sYbLjjRpwudjxDazboXof3Wg+sHi5kNrgZhE=;
        b=FJUXalLSAOTmP4Xdbwhs7Mc4gZNPWiG3Z2br4U6uHXow6ccCEK28USZQFVdOnXdsMr
         wCm1o0w3X5LznjN1nPAMDQoNkmxuXUcGtSJ8Rrp3xqXAwRS1ci//rP5j6O6zEDY+udzk
         HJLaJgAnOoYlCJ45krgKPNmBeBjP7VzEXdDrXSQZdCrVurCLdw4B7zvRUhCwBZN+7oNr
         V6IU6lARUgRfH7/UItytKNmzWT50A+1BW9pwUZELU9dBBk+B+aV+mwmHWhzz9Z/VWl1G
         7qlsRPM1zXFF3a4PyO8QPWASVfmEbW8X1LUe2njq59DfbQHWO9sxvTMz0+Jr7uFKjmdF
         IUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366557; x=1742971357;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG3Wd02sYbLjjRpwudjxDazboXof3Wg+sHi5kNrgZhE=;
        b=CWM3e1Pkv59KB/oeGT62Ve8xKqoiIGoPYuAm9EioyskKE7DyTSe0FryTp3dysv0wN2
         6Mi81V3/YmlP9/6uGX1rXkwQU3fUcwkCH019k+TwH4CGxlDo+J+8dMn3b5FcVrBY57Mn
         NvbDS8nQmgcVuDFU33Iv3inT6ewb04m6wiqpWE+maJJTtu3ZiGOBCdHewCYj7X3YFjUX
         kKXxU4QEshKS1NJ22yfq3T5hjF1VxXe2WZh/Ldy9Ue/10Lalj+/1ou8ptfrZGwLaFGvO
         sNxKTMUUNN8ImK6PXwx1ppqV48XC/WAot5mQYggvbim2+zsyPtkyXD2gDKIOvdTjpSwi
         dJgg==
X-Forwarded-Encrypted: i=1; AJvYcCW5n0p7jamYM04Mh3Bsg0M1mx8tqlkbx3J6EAwlUMA8TNAyfpcQKHxMZ5/3nuHyuTVKT+K/yJfLg2I+fTWh@vger.kernel.org, AJvYcCWDYimMaTzKQqGLd3PO/i6mVxeu9Ez9OdPdQN58oqG8r3klxZfbVX3U6R6h97pPKv91P7efTGQi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1rUwz//4sdNsUeAid6MIfucp4hGI1RupUC0/MoITl3dgTXaN
	7PKNXpUwiuDoHFRZqfloPxfeWJxDnjYyF7USkB722txyx60Y1c1J
X-Gm-Gg: ASbGnctQaY69NRvwhADmGcmm9GmuXbjZXXRMYxNYGxoQCTO9M+Rh4LDjKWhACStEHL6
	K1GWuhCQZNoRt8OyDXrcz4LgAKidgIRnY6xy8OD7Pehx1PoENiKejRiQQ8QDXB+yHCrwS4+lp9A
	Gnv/u1v/XfH55P0mTuhNKBkK0l/WrwiBV9RDf5v+v4vVWRpzRG/dnJjU6yP9kbMTxuPyObXbOi5
	b/syEiR5SU4oMIuWrPbHIq4j/gcxtHR9nKB+SRYJHaCr7XfrH+qwO+MXVkGlaZiykpxSfphWQYB
	56Bzi7LsS27grU2Fln+vuWbaMvIyOLHqi89Sadj+7lmYqXBr6GCV8NpW+69N8SNXhtfsJRakLpr
	R0YhKIpRx20A02Q==
X-Google-Smtp-Source: AGHT+IFoC/rsafExGZdoPrX7mXfBQRLZqX5ES4/CB7dhcohKP3VkaXzbs3HPOAlBNSQGytmkp2y/BA==
X-Received: by 2002:a17:902:cec6:b0:224:26f2:97da with SMTP id d9443c01a7336-22649a3d6a3mr21556305ad.29.1742366556960;
        Tue, 18 Mar 2025 23:42:36 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm106191835ad.70.2025.03.18.23.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:42:36 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [RFC 4/5] mm/memcontrol: allow memsw account in cgroup v2
Date: Wed, 19 Mar 2025 14:41:47 +0800
Message-ID: <20250319064148.774406-5-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

memsw account is a very useful knob for container memory
overcommitting: It's a great abstraction of the "expected total
memory usage" of a container, so containers can't allocate too
much memory using SWAP, but still be able to SWAP out.

For a simple example, with memsw.limit == memory.limit, containers
can't exceed their original memory limit, even with SWAP enabled, they
get OOM killed as how they used to, but the host is now able to
offload cold pages.

Similar ability seems absent with V2: With memory.swap.max == 0, the
host can't use SWAP to reclaim container memory at all. But with a
value larger than that, containers are able to overuse memory, causing
delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
out of balance, especially with compress SWAP backends.

This patch restores the semantics of memory.swap.max to be consistent
with memory.memsw.limit_in_bytes and the semantics of
memory.swap.current to be consistent with memory.memsw.usage_in_bytes
when MEMSW_ACCOUNT_ON_DFL config or cgroup.memsw_account_on_dfl
startup parameter is enabled.

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 mm/memcontrol-v1.c |  2 +-
 mm/memcontrol-v1.h |  4 +++-
 mm/memcontrol.c    | 29 +++++++++++++++++++----------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index c1feb3945350..3344d5e25822 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1436,7 +1436,7 @@ void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked)
 
 static DEFINE_MUTEX(memcg_max_mutex);
 
-static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
+int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 				 unsigned long max, bool memsw)
 {
 	bool enlarge = false;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..7f7ef9f6d03e 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -36,10 +36,12 @@ struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 
+int mem_cgroup_resize_max(struct mem_cgroup *memcg,
+				 unsigned long max, bool memsw);
 /* Whether legacy memory+swap accounting is active */
 static inline bool do_memsw_account(void)
 {
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) || do_memsw_account_on_dfl();
 }
 
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 623ebf610946..d85699fa8a90 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5205,9 +5205,12 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	xchg(&memcg->swap.max, max);
+	if (do_memsw_account_on_dfl())
+		err = mem_cgroup_resize_max(memcg, max, true);
+	else
+		xchg(&memcg->swap.max, max);
 
-	return nbytes;
+	return err ?: nbytes;
 }
 
 static int swap_events_show(struct seq_file *m, void *v)
@@ -5224,24 +5227,28 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static struct cftype swap_files[] = {
+static struct cftype swap_files_v1[] = {
 	{
 		.name = "swap.current",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = swap_current_read,
 	},
-	{
-		.name = "swap.high",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = swap_high_show,
-		.write = swap_high_write,
-	},
 	{
 		.name = "swap.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = swap_max_show,
 		.write = swap_max_write,
 	},
+	{ }	/* terminate */
+};
+
+static struct cftype swap_files[] = {
+	{
+		.name = "swap.high",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_high_show,
+		.write = swap_high_write,
+	},
 	{
 		.name = "swap.max.effective",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -5473,7 +5480,9 @@ static int __init mem_cgroup_swap_init(void)
 	if (mem_cgroup_disabled())
 		return 0;
 
-	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
+	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files_v1));
+	if (!do_memsw_account_on_dfl())
+		WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
 #ifdef CONFIG_MEMCG_V1
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
 #endif
-- 
2.41.1


