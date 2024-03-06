Return-Path: <cgroups+bounces-1978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D5873ECB
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AEB1C215EB
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133D1448D9;
	Wed,  6 Mar 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ey2Q77cW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F3144035
	for <cgroups@vger.kernel.org>; Wed,  6 Mar 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749507; cv=none; b=a5GkqiaNkGMPuzMOt+uLnWUux6cg+jv+VMBl5n2ZC/D+KfeeubS516q48QiWO+PNXp4da+NSA1obutirPXi+0htp3HaoKaGaj12RfvAMCTKrho5Zkr5gmRj1yI1MNVyuxqfn64beNOclvqaVPaG/8mCDHqC5kLb7yv76zMV2TM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749507; c=relaxed/simple;
	bh=1sxQZmjy1XEQBwtwWVa15MZq646rnX7fSBToqhzHkTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzA7YZYe2i3vHu95rEx3orOdkloHm3vtXNbe4i/IwxOalluu0XXDNMOPJlabZxciD9efxIaNjr/PNVxrXdPEx0VoXTkwl82T7YWh0yBOAVU43CbhRu4bfOnRZWJiP/x6gyBgdLR0b5wsvOPEU4WtdmCt2bqTNBVT4lVWeUutB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ey2Q77cW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60810219282so548407b3.0
        for <cgroups@vger.kernel.org>; Wed, 06 Mar 2024 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749504; x=1710354304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRHB/CGZyDTcWTfW8LE9qYpRlSe4g56CTtmfKB0L28A=;
        b=Ey2Q77cW8vE9BwLvEaKVvY6+/R96rv/n2InDHh2N5DPm0uQ+RVOqiuCV23FEFIacqn
         mPD1OdUNiIGSsjPn2FPlH3n4EGSWvtV9HbaUSNxDQLp8UlyVJMBMHqhNCaENE+aekLkB
         Y2KXAO4SF1hjhZmFVQPGcGbt9IviGYhsatHvDZAW/kvL2CCuZ+NxZhgWZBh1OJqc34YZ
         yXX1WUelLt63hRuZHvvDJ4yo7Zl+CxG+r11A9/T0Q9nQyBN+DRn623U9OMdSoDeBcNl3
         538q5R6EUNEr6WehWElPKeLU10it0JVPXN8WrkOkR2O5fpE88Jx2/TFuBiQhRgcH3Yx7
         ZuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749504; x=1710354304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRHB/CGZyDTcWTfW8LE9qYpRlSe4g56CTtmfKB0L28A=;
        b=IAQz/iD+bH8G1dlYUYK5J1fWGmMbJQctU/Y4yRq8TDfSgADujS7iks+naST2odGzVz
         X6mJSvpljdzze/b2kY1H8T8up78nQnM8FzcNOAvLWgtQ53uR7nVmgj91+WtF3rKyzPB/
         hk/8aFyYMr4z4lsk6E4JoAbNa4wjG9nhRlKRWBV2Vc7J6ZIxlks/lrplAPCUAs+ueZXI
         Ui/zBryOv+puhbxbZG0qzZT/bwmxHIX+2OvwlzYzggDcdmj6tKADo9+Wqrgx/dco03Au
         6NmEvGFRKaxpRbcnarP2J79ZUEfqpCk21R5GNunKDLUp35vS4ptVobCJ+gKGGpgcb6Pz
         aajA==
X-Forwarded-Encrypted: i=1; AJvYcCWI2aH6WYz+q/9E9Jof4eAUCrPkVDJlfiEfoqSCCP4+8v/UnpMuMlwumge1V8edxVceYP07ZpJ1F1qjL3Gk5pZEoLE/j5dr0g==
X-Gm-Message-State: AOJu0YwVro/6z9a8vxZLoAZoTuFYBozyFtaUn2EHEeR/IHOzK/qOAfv1
	9QqVTVbKxoaYDGAQzLz0Q47Xablu5tapspQlZ/63xoxDC8JRJwq9y5komn12CtCzrSS+4iO5FAc
	DLQ==
X-Google-Smtp-Source: AGHT+IFUSmekR0M1FVWzKb1jjXcJpGUE8Fd5c5LGEWBTD5HNNgZzfSlizaoDyWgDdYfuybzaLrnil2CkymA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:690c:ed3:b0:609:3c46:1885 with SMTP id
 cs19-20020a05690c0ed300b006093c461885mr3528012ywb.10.1709749504202; Wed, 06
 Mar 2024 10:25:04 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:07 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-10-surenb@google.com>
Subject: [PATCH v5 09/37] slab: objext: introduce objext_flags as extension to page_memcg_data_flags
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce objext_flags to store additional objext flags unrelated to memcg.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 29 ++++++++++++++++++++++-------
 mm/slab.h                  |  5 +----
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9a731523000d..7709fc3f8f5f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -357,7 +357,22 @@ enum page_memcg_data_flags {
 	__NR_MEMCG_DATA_FLAGS  = (1UL << 2),
 };
 
-#define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
+#define __FIRST_OBJEXT_FLAG	__NR_MEMCG_DATA_FLAGS
+
+#else /* CONFIG_MEMCG */
+
+#define __FIRST_OBJEXT_FLAG	(1UL << 0)
+
+#endif /* CONFIG_MEMCG */
+
+enum objext_flags {
+	/* the next bit after the last actual flag */
+	__NR_OBJEXTS_FLAGS  = __FIRST_OBJEXT_FLAG,
+};
+
+#define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
+
+#ifdef CONFIG_MEMCG
 
 static inline bool folio_memcg_kmem(struct folio *folio);
 
@@ -391,7 +406,7 @@ static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 /*
@@ -412,7 +427,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
 	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
-	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct obj_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 /*
@@ -469,11 +484,11 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 	if (memcg_data & MEMCG_DATA_KMEM) {
 		struct obj_cgroup *objcg;
 
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 		return obj_cgroup_memcg(objcg);
 	}
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 /*
@@ -512,11 +527,11 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 	if (memcg_data & MEMCG_DATA_KMEM) {
 		struct obj_cgroup *objcg;
 
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 		return obj_cgroup_memcg(objcg);
 	}
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
diff --git a/mm/slab.h b/mm/slab.h
index 0e61a5834c5f..c8504574f8fb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -559,11 +559,8 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS),
 							slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
-
-	return (struct slabobj_ext *)(obj_exts & ~MEMCG_DATA_FLAGS_MASK);
-#else
-	return (struct slabobj_ext *)obj_exts;
 #endif
+	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
 }
 
 #else /* CONFIG_SLAB_OBJ_EXT */
-- 
2.44.0.278.ge034bb2e1d-goog


