Return-Path: <cgroups+bounces-8284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D17ABEA7D
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 05:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29831BA7E61
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 03:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F222E41D;
	Wed, 21 May 2025 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P7v13+kA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2319F464
	for <cgroups@vger.kernel.org>; Wed, 21 May 2025 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747799137; cv=none; b=EJHVlmGBAWXSsFsD7npDK+O00aQrCgH7ywsmItDqK0vo5sKPsPXcvFpOAYN87GXKnakWMPZZn+5iS80AOg8NAvgfKFmo92prIKzEQFBR5o/wr/ho8S+ezY9GzjFSY3TmIm504hXBwM9M3VHqaklCTN/h9blbAi7xcef3PO4Gt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747799137; c=relaxed/simple;
	bh=PEn7/p/2ID7VX5alpq6i8B6TuYpR+cleLVIeijpUp1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CxQV37lDZgMqSh1ztxZtYaXtxs52SZRbct7khTdd6YmtmlCcaN502/0bu18EiUgEBDMRd5rw6QJF0dEZHD0TMT5I/NDL8iecGQduYlvQ9goYkIwROFRPIQzFC7RQEB1GbGZHNBZlvoDx5dveKvVFECE1kowRvgcExMeosVwrUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P7v13+kA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b074d908e56so4114724a12.2
        for <cgroups@vger.kernel.org>; Tue, 20 May 2025 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747799135; x=1748403935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSYSGk10lQFipJHdwa6GaputkvUrU/XWqX4rq4bUxCg=;
        b=P7v13+kAk/9Dgf8x0IjYZThuGo9XAaYF8QvF4bY2kGeOoDmTrNlI9JVzx4qoI4hyYw
         R8wzQN0me1KSUhe7idlsIcNZzXNaEheZ/Y28ofvICy9uovxC/Vc4Lx/fsMO07C8tm9zV
         7YGjeRwerwlIi5vRofSG2oazWblZOSYwh94ap0IabkGkK+NL3Qkmj6cdPlDFZSs8VvLb
         U4uaQVDSePqP7oitkf+mGHJqUXTNj243cU8cKoxshNQDRpP5GuR6HDoWSmYwloJKPm3V
         LW377YlFKJsJJCZhy6Q60cGBntjCbXt9XcO9qUtWQz5vYyeAERuXT1sXo8hazo6DwjEZ
         VZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747799135; x=1748403935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSYSGk10lQFipJHdwa6GaputkvUrU/XWqX4rq4bUxCg=;
        b=abBqW6LV/gd9mNTiSuZXV8b9F6j446m7Bl/Qid0LEwgOhzFdMo117ouY8i+f+tDSgi
         xUA2LVXC5gzBodL2fwajRbjIShm26CyGmJceHBQZ1WoMM7voogg+ihoYbpUd9kASe2TV
         u57FuVhEZjo2a2+yIZCvSl7clja1U9YZiExmliqAFhEIgygJM63FDvMvfsLkvOirMPA3
         4ynkf6gX4wDmYTFPiQ2k/z9PvWfWWXlbcbGRH7ZzvEbSyebSaFXsU03uT3c5Z0jxNNTN
         RTEFWMimuJwUEbRWNsnSGkQKGals9EorqZ51Kg1bZJ8KU1iXzEwe+UL2QpKnaaGlDhip
         Ov0A==
X-Gm-Message-State: AOJu0YwmrzQUWLz1h9gAJGonXji41+7GTMgCasDcliT6OBMNkes4cT+x
	XePn/SIQ51SymX7Wg37zzCntnJWqrnrePQ0jecQfxKUuGcI4q8Eb30FEc4h3CNd96LQ=
X-Gm-Gg: ASbGncuF8/H/Uu4NJ1gx5bIyGF9gjgZ6ITXX3B0mWUiy1BpzUDZBL6Fy1hWI6oOfg/D
	wFMC9TtdT9jBAKnZ6L3EC5Gnk8gQ/I4y2RDiv+TuHsQuYH1Dom56Q/83TvUZvRe8c84F59AgcKb
	7g5brNnYSbyLDHTjVxg03Ktss0woSKN6QcywAhO0JR4P/2Hg42UG5DBfvr3QN2ZLpWYRGQqcQSJ
	M200RBKldlFinndYgTJaDt6gLuaf0s3/QGDDIPLrquHm7aCJg70N1Bo+BxIBm9xMI455j4uaAmL
	07+dizNHKAjc5V+64IVCXUHqyPKk0vCrLBeHSNCK2MpxEkQaYmI8x61swoa8WbNyLd2p0DFxqTh
	LXzFbL0+363Q=
X-Google-Smtp-Source: AGHT+IGEDPGW19IeB4THURy4MB0k11h80ID7APMtvrmYBJx9IjRj12iA8ft3N/+V2XCppbFXcMPXaA==
X-Received: by 2002:a17:903:230b:b0:224:10a2:cae7 with SMTP id d9443c01a7336-231de370f6bmr291221015ad.40.1747799135190;
        Tue, 20 May 2025 20:45:35 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4b04a52sm84268125ad.91.2025.05.20.20.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:45:34 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
Date: Wed, 21 May 2025 11:45:27 +0800
Message-Id: <20250521034527.3476332-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the cpuset.mems in cgroup v2 can trigger memory
migrate in cpuset. This behavior is fine for newly created
cgroups but it can cause issues for the existing cgroups.
In our scenario, modifying the cpuset.mems setting during
peak times frequently leads to noticeable service latency
or stuttering.

It is important to have a consistent set of behavior for
both cpus and memory. But it does cause issues at times,
so we would like to have a flexible option.

This idea is from the non-blocking limit setting option in
memory control.

https://lore.kernel.org/all/20250506232833.3109790-1-shakeel.butt@linux.dev/

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 7 +++++++
 kernel/cgroup/cpuset-internal.h         | 6 ++++++
 kernel/cgroup/cpuset.c                  | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1a16ce68a4d7..d9e8e2a770af 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2408,6 +2408,13 @@ Cpuset Interface Files
 	a need to change "cpuset.mems" with active tasks, it shouldn't
 	be done frequently.
 
+	If cpuset.mems is opened with O_NONBLOCK then the migration is
+	bypassed. This is useful for admin processes that need to adjust
+	the cpuset.mems dynamically without blocking. However, there is
+	a risk that previously allocated pages are not within the new
+	cpuset.mems range, which may be altered by move_pages syscall or
+	numa_balance.
+
   cpuset.mems.effective
 	A read-only multiple values file which exists on all
 	cpuset-enabled cgroups.
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 383963e28ac6..5686bb08c4fe 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -162,6 +162,9 @@ struct cpuset {
 	/* partition root state */
 	int partition_root_state;
 
+	/* Do not migrate memory when modifying cpuset.mems this time */
+	bool skip_migration_once;
+
 	/*
 	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
 	 * know when to rebuild associated root domain bandwidth information.
@@ -227,6 +230,9 @@ static inline int is_sched_load_balance(const struct cpuset *cs)
 
 static inline int is_memory_migrate(const struct cpuset *cs)
 {
+	if (cs->skip_migration_once)
+		return 0;
+
 	return test_bit(CS_MEMORY_MIGRATE, &cs->flags);
 }
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 24b70ea3e6ce..f43d7b291cde 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3208,7 +3208,14 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 		retval = update_exclusive_cpumask(cs, trialcs, buf);
 		break;
 	case FILE_MEMLIST:
+		if (of->file->f_flags & O_NONBLOCK)
+			cs->skip_migration_once = true;
+
 		retval = update_nodemask(cs, trialcs, buf);
+
+		/* Restore skip_migration */
+		if (cs->skip_migration_once)
+			cs->skip_migration_once = false;
 		break;
 	default:
 		retval = -EINVAL;
-- 
2.39.5


