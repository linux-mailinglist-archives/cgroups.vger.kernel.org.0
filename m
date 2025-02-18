Return-Path: <cgroups+bounces-6580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8AA39130
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACF33A6BB5
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B7E14A4E0;
	Tue, 18 Feb 2025 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk/In9G2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0291684AC
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848511; cv=none; b=Pox7MkhUrgfa4EXgvhtlj/uKUB7H804LGOv/fetckeQyEa5UMipKoEl2PZSgsUmRvenKp7LKBfpRoH8yyFrexfVpEWoB2zwWNO+E/HClSS0ns18nmPSQgai+PlMPwa7pcIk6N6BI/DuElRF9WYNlPLJkIcVUzBBk59W0DJ50hFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848511; c=relaxed/simple;
	bh=DJ0vYg2jAKTJCubn7i45H8Z/LFKJRz4V7zoYicLQ7XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu6UMyg0b0Pyngu5YYQk0+mv8DphIYaG22ZH+dUF4q2A29cMgc6/VuXGS2bU7Syc65MMBBCNeMwsH0MCAb43kkraQJ0IfvWoI26n7CFLe0aQ29IpLUapkISQCe19Duc399njKVQBVhzIcat8unVhRqGwYqRYvp400wGd2L1DsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk/In9G2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so9268478a91.3
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848510; x=1740453310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO3hb/+vVe+5fAxNnnDqDkFO7GypFlKfFguhCd8DtOs=;
        b=Tk/In9G2qXXcQp3N7nT61HtzP+7OgfyImtXyy63ohUVnNQcy6LHEvnjp8FmvmqPE3M
         ti6801FjH7LAUc/Kj12RSKhf+k2UBdgb/J9oGvQ1bHh1Hh4xGo7vdVMSlQqcB95af/V0
         eSEzB0ai75sPNKftbCwHnlfFKgtU7ndD0bEOu+HQxjZ+d3T33vCeiJSJ4rf4TqrPR5OS
         E12My2+DfmLd0IP7pXvgPv77sFav/3Kh5WPKDMNPXrr3B52DrmojWPDtsX97sKgK6bmZ
         GcbuecUpaCzk+ZyplRALujbekuYdkg+h9mt4K2nexz6M+TLlQsOwHtoaA7LuWbFU1ml5
         dTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848510; x=1740453310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO3hb/+vVe+5fAxNnnDqDkFO7GypFlKfFguhCd8DtOs=;
        b=KTJd07cdSwB4GNlvbLprzEnfeQRNpzvSCwjBpOfgW7GSZ9IRDWN2jU9JhKPhaH3tDz
         RgxfXzt3/zzS093zwZ7lKIs4fkzo/akJOFKfCnyqZ0g9WvCWF5hhCzj7wclR7akXU7CK
         J70KzxWmyKOn8DtxnAYvih5ebIPp07vSNeetTAIpjaLh1zvoziDYkThhDaaa660KcgeL
         KCKtvnxMj+XKdKdA1VXCsnISSNj/O3DiO3Q5cDqqGDuHYgzMqWLAOk7QXpoae8HNXlnT
         zZ1lGV2H6BcEpJQoe9Oimc/eimUrMDq14Y0h/+kHAvyIQdrI9IzvXWj9hFfM3b+Juzbm
         rYag==
X-Forwarded-Encrypted: i=1; AJvYcCUIQn9cIj1cdIaFwTHE7FmlvHrgLgK1wRpTyrH08sllsToOA2cOCANhaIGNOs6el8W5gz1jN3Vv@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXmsXp6CDcxV4bZrpmFzLi2Kt0VEHce33myIpJ6qMROk2hfxv
	G1tOaHtJWA2rOR+jU8km58tdg8mfkzXmH/eGcVY1uuimnOkx6fEG
X-Gm-Gg: ASbGncujl1/RQCgK30RbF27xfYTMbOEFBGM1G3JmcLYW/mQ8kMMvaWMmt4FOfPw/2wj
	H5PBi0LUQOV1kBwxS0lad+S3EREmrwRtA4TeN33W/sYyCbfq0ImekOi+KI8xgGRLtTD9cL2E5Uo
	UOq8dcB92U+slOKUuhERfsK50g71oeljuIHDQ0Z6lWiXgdthUAK/Zrr9BJUKr0F9+m7MPzSSpyE
	AeXUJZ0jjsTkxm9APFnIzqEgU4kz9umMcJoEiHFchMD2M4NrhcefOnThZ2R3Cum1aTsRIo1KiqV
	96lyIzbjlFRXdclA9X8/Do/ShEAeHgvbI8b1YdD+hzrAw+nRx3TR
X-Google-Smtp-Source: AGHT+IHcdvcOMi0AxH886B36LGeN6TPfeRO/YTGzu+no+b1L3ofR6FaqviJ5YbkBRETnjOFBfr1SiA==
X-Received: by 2002:a05:6a00:198c:b0:730:8a0a:9ef9 with SMTP id d2e1a72fcca58-7326190d9edmr18330498b3a.22.1739848509625;
        Mon, 17 Feb 2025 19:15:09 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:09 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 06/11] cgroup: rstat lock indirection
Date: Mon, 17 Feb 2025 19:14:43 -0800
Message-ID: <20250218031448.46951-7-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of accessing the target lock directly via global var, access it
indirectly in the form of a new parameter. Also change the ordering of
the parameters to be consistent with the related per-cpu locking
function _cgroup_rstat_cpu_lock().

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 14dd8217db64..26c75629bca2 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -385,7 +385,7 @@ void bpf_rstat_flush(struct cgroup *cgrp, struct cgroup *parent, int cpu)
 __bpf_hook_end();
 
 /*
- * Helper functions for locking cgroup_rstat_lock.
+ * Helper functions for locking.
  *
  * This makes it easier to diagnose locking issues and contention in
  * production environments.  The parameter @cpu_in_loop indicate lock
@@ -393,24 +393,26 @@ __bpf_hook_end();
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
@@ -434,10 +436,10 @@ static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat,
 			struct cgroup *cgrp;
 
 			cgrp = ops->cgroup_fn(rstat);
-			__cgroup_rstat_unlock(cgrp, cpu);
+			__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, cpu);
 		}
 	}
 }
@@ -449,9 +451,9 @@ static void __cgroup_rstat_flush(struct cgroup_rstat *rstat,
 
 	might_sleep();
 	cgrp = ops->cgroup_fn(rstat);
-	__cgroup_rstat_lock(cgrp, -1);
+	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
 	cgroup_rstat_flush_locked(rstat, ops);
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
 }
 
 /**
@@ -487,7 +489,7 @@ static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat,
 
 	might_sleep();
 	cgrp = ops->cgroup_fn(rstat);
-	__cgroup_rstat_lock(cgrp, -1);
+	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
 	cgroup_rstat_flush_locked(rstat, ops);
 }
 
@@ -516,7 +518,7 @@ static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat,
 	struct cgroup *cgrp;
 
 	cgrp = ops->cgroup_fn(rstat);
-	__cgroup_rstat_unlock(cgrp, -1);
+	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
 }
 
 /**
-- 
2.48.1


