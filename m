Return-Path: <cgroups+bounces-6731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D8FA48AE9
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 22:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497E116CD33
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092E272904;
	Thu, 27 Feb 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVe1Kbtt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEB27180A
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693360; cv=none; b=M7h9HQD1dVyevJ/Wf3h6Xi9htoXrLifxQkuvRll2nSeI1Y0V4UlSDvsDp9RrR7/OAkW7XAn1kj0pzCqUumU/21A58MLWTB5utRBlGm1LIatUXeZCXoemr6aEoGFy77MQW++STXrqheQBhHQvoDjUg2Up3MS9zLeqBNo4fmmQIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693360; c=relaxed/simple;
	bh=qBKj2R2MFJf84IL7D4YJ7hJUORA8CQd5SyeYVK1M6vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2jePOi72ZzaUn8b44nZf7djK9FjivanaN36neGsGIujI/sJsbOnBEIAdpsRxes1JlRzSlHrRxdNS/yBwmT5duN3IU1r2zFIQFf0lKhbEMith6PvIHC0udczbuwVAuMoALbE6FzwuMlaK1XSwcYRdEQ7DRpVbQLw3wXt9bfcNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVe1Kbtt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221206dbd7eso30664825ad.2
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 13:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693358; x=1741298158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzxzwt2mUUhnKAxYxNpGGBXKdjzbS8+sU15pD45zOWk=;
        b=cVe1KbttEdfPH45ZHTLWgwuIsrnx3SCRX8870z4m5jG/PZCWSr9FqUkw2xJchCzReN
         z6k9r0dOD5XRjPBWxe+sZ6rp1F1Gc5dz/5s9z1fGqU7KAKisyhLxVE9+tSeVMC2x023p
         BzMbURR6uH/XpXP5r8KTiRSW4wEeEPkUeK6BdVwZmkSwBh1uVTtz5FXwTHwauBr06K6M
         LWJBwZhrH9bzF+iT69NvK98UznjtK591Inz3Vw4flIzYullzDGY+tueOc1b26gNv3U+Z
         ZVLKDGgOFxlW1SXUBLkKJd/spkKwcp5JOWUu4OUDnO58Dlg+crEodHHRkodGaf7uHhjJ
         v+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693358; x=1741298158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzxzwt2mUUhnKAxYxNpGGBXKdjzbS8+sU15pD45zOWk=;
        b=KVuz8y89MBrew/bnqQ5Z6UUzCE+jRzLml1rImNqbUyTpQTIsYz8uooPISZqGzCefTn
         BlAbDKXK5f95rPL8RhhbTFlnWNigylsOteAwskN+P9jCBGHDhqzA5x4m0JpUgr/ncY4u
         +b/Izo0tp5qONFmId3G/jVMaVN1YZ9gCsvb9Oye+5NLObizpTAZjtiYrW+6quaXCm2K+
         pjkaITUXont28ceBytO2m+nfNXfM8XiqEFW+gzOf6JBk8Y3qdE4jxih/pXIQKLcGci6h
         wDDoS32k9CM1C01+UEHk6krrwFWpFiwglz8MYMYY1YrcFpVt1uubdUj3eyY3HVX38JdZ
         xFqw==
X-Forwarded-Encrypted: i=1; AJvYcCVj8j1cbWShLIDFyNETL4H+XrhgEEWilYN81PPCpZHZ7nkZnFk5OAzUZ32GDTkt4IT45GNEVRZ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FQZmAWWiImywKOOQtf8lFB9HGlcw/YgOr5Rg9MWg7jRXKK06
	+tbPoeyM+o+bz4NCu3mPuHm8Plq+9UWCz77Jn2hVcobouzFj+lis
X-Gm-Gg: ASbGnctt2qTGhTM94ZQuXJbbMS9WK0kkCpp290GZhBqfSkM0qyw8yykvj9fW1HXb/CC
	Z8vRErMu5PcgnUgqX945cewPlOxuTo73jlsAzknz2PSUffhY+ncZxNr28xbt7twODbYmT4NC7wQ
	/hCuIqSBFMdtiki98LnZJ3gCzRaWQLl/4Vv3T4ollZBUmPQ6T+cHXEDkYc9Q8Vyk0He/H/oqcgk
	elanRUjdMpoh3tLu9pQF00UCBnSh26zfKqFzpN7dDSoFHjWimBsdqpRTyXHdMgASAFaABt/5BWg
	qYmL2kBSn+URhEvAHpWJmXFSLzZCkRfs0S7g8FqJZXIzQO/xh2JEHg==
X-Google-Smtp-Source: AGHT+IGmCjZRC3Jlpg0kd+gq47vBuCLSQ0CSc+pP3NgcWQ95MgHTry9WY8zWNTMUBXSWfW65jZLQfg==
X-Received: by 2002:a05:6a00:b8e:b0:732:4c47:f807 with SMTP id d2e1a72fcca58-734ac4499d3mr1561671b3a.21.1740693358442;
        Thu, 27 Feb 2025 13:55:58 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:4d60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb65sm2301321b3a.149.2025.02.27.13.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:55:57 -0800 (PST)
From: inwardvessel <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/4 v2] cgroup: rstat lock indirection
Date: Thu, 27 Feb 2025 13:55:41 -0800
Message-ID: <20250227215543.49928-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227215543.49928-1-inwardvessel@gmail.com>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JP Kobryn <inwardvessel@gmail.com>

Instead of accessing the target lock directly via global var, access it
indirectly in the form of a new parameter. Also change the ordering of
the parameters to be consistent with the related per-cpu locking
function _cgroup_rstat_cpu_lock().

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9976f9acd62b..88908ef9212d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -277,7 +277,7 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 __bpf_hook_end();
 
 /*
- * Helper functions for locking cgroup_rstat_lock.
+ * Helper functions for locking.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments.  The parameter @cpu_in_loop indicate lock
@@ -285,29 +285,32 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
-	__acquires(&cgroup_rstat_lock)
+static inline void __cgroup_rstat_lock(spinlock_t *lock,
+		struct cgroup *cgrp, int cpu_in_loop)
+	__acquires(lock)
 {
 	bool contended;
 
-	contended = !spin_trylock_irq(&cgroup_rstat_lock);
+	contended = !spin_trylock_irq(lock);
 	if (contended) {
 		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
-		spin_lock_irq(&cgroup_rstat_lock);
+		spin_lock_irq(lock);
 	}
 	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
 }
 
-static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
-	__releases(&cgroup_rstat_lock)
+static inline void __cgroup_rstat_unlock(spinlock_t *lock,
+		struct cgroup *cgrp, int cpu_in_loop)
+	__releases(lock)
 {
 	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
-	spin_unlock_irq(&cgroup_rstat_lock);
+	spin_unlock_irq(lock);
 }
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
-	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
+static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
+		spinlock_t *lock)
+	__releases(lock) __acquires(lock)
 {
 	struct cgroup *cgrp = css->cgroup;
 	int cpu;
@@ -328,11 +331,11 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 		}
 
 		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			__cgroup_rstat_unlock(cgrp, cpu);
+		if (need_resched() || spin_needbreak(lock)) {
+			__cgroup_rstat_unlock(lock, cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(lock, cgrp, cpu);
 		}
 	}
 }
@@ -356,9 +359,9 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 
 	might_sleep();
 
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(css);
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
+	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
+	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
 }
 
 /**
@@ -375,8 +378,8 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 	struct cgroup *cgrp = css->cgroup;
 
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(css);
+	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
+	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
 }
 
 /**
@@ -386,7 +389,7 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 {
 	struct cgroup *cgrp = css->cgroup;
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
 }
 
 int cgroup_rstat_init(struct cgroup_subsys_state *css)
-- 
2.43.5


