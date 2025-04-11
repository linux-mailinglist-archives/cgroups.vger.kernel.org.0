Return-Path: <cgroups+bounces-7487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F8A868C9
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 00:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C519A78A3
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136902BE7A3;
	Fri, 11 Apr 2025 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TdGW12g3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734629DB83
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409496; cv=none; b=sDy88Iq5rbwxzdXgKKKUiBrNtYODRMG1ndpgrA8CrxnYBYAA64xf7VSaf3iyu5D6LXZQEzczpEF/cLSsC1Nr1BpBB2Kn4zgF1nCynKVJdpmZ8eF6CvmRCe2YzM5/uVPHz7CosL0waDJVQY1Ebr8y1msP+JMSlCwkkPDS2evzTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409496; c=relaxed/simple;
	bh=kJWlhdTJTSNuYWImWmYIv1Uf59B3tlS7eTrMHq4Ex/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMYdHtbFti3fo5z2XfhVNScNUO0aSURv5W8KObkO4AgQw18FRKCP5eDXzvXDH/bXRnAfDB4Xh3buxx26p5aTc0cYyifhdEjqxP9PDTpn+4gyCz5t9XyLjzTzX2yA+z7umfvR36AlKht+LFQD8LykVqvqevOgVfF1aa9n80qnEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TdGW12g3; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5e2fe5f17so242256185a.3
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744409493; x=1745014293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIYGb9o3ZNMSFtQQpPHltGF8QRH6KOuBpYhDX4oYg1I=;
        b=TdGW12g30q3/AQsNCcS212qsR0uh5AW+C+WCWm3+v8St5raVfGJt98eir+FyBikS07
         2Rmu+Tw94+2SVk4r2ip0QSNxt4iucGxAN05XuVNqVl8okhCkztRCoGPMV6Z9I+sBQ9PN
         oFip9oo07UCfEP4ifuIv0N1Cacg+WJJweTHASNSaWCnvsTFWfadzd5T+mWYIlp0Ksset
         eZiw0iP91jAF3I8JMEdbyFNBF0fBanLUNIcJcq4HJtTV9fW0N/PQ3raNve6TB3057/5S
         wiswEzVz734cpP0VDQ2vFwjK0PS9dstkYXvtgS47/Z22eRLrwOXU0UQn60/qUJq8CLhr
         1kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744409493; x=1745014293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIYGb9o3ZNMSFtQQpPHltGF8QRH6KOuBpYhDX4oYg1I=;
        b=insLkxbUC5xFZJqKACKtbNnRE3qSJcwtITQkcBqJ5vQEarIXAoBJNvUU6WLzt3p5G0
         IoF40XYie3RY1j27MES/tsKw+q/g3pCBl/iGWXlL4vihEtPNbYd2hvprANKWu/AgrROu
         fQ2l8OqHQ4yE+98aCVUcLFZPNRsYxIBUacprmhB9uUrIgBtv6U5TUHEprM/+/AahLrRV
         +KbID6NKcEC6p1Qgz8Va1XecA2CvZNhKXGGLHqYuiRpHn2w72P8bx+ldPAR7OHHmeKif
         CH2htaoUwChX8cXqd0OLI47FSWyj8eVKGhJJMhkOMlzZXlpZtmdjs0N07xCsiXSw61QW
         o07g==
X-Gm-Message-State: AOJu0YzfTz+LqpGXEhVqnK9UJm8tiYXcMtavnbkYwq1+e9zhF/uRUo+P
	FiXIJlSgF6kVADjowdo5hJvuw0cTSob+lgkKedpUULYrlmI9AwAeONoiak9CQrw=
X-Gm-Gg: ASbGncsub9OXxGXgf4C34uKztPFJhLH+dkrY1QDa80UQptYEbSRAkgGifBxGXD4o0w6
	hUluddIBj1XOaJfjMlXeoVP86R80SUk21Pyc2choDmlwNVfd4z2DAsCo1hzNmSJRzudKTPwkMd0
	C3xE9nlTeTquXOHRDdm9+yGv9KunsdWZhNYGDTIfu69JivrIGE5SINTHoFI4eFomWnRuwlgWSg6
	kgwnIno4xuclXtNY2akL8ike4VRAH6ryqvx3opa08Sz6fhT0Coh+VavGt3qdJcvuvg0yaa7yMfw
	DblVqjTMLAg3yBDDyllCJP7IBmw+5s2PCOFAQcQc4FiMKNnTW9WD5bwfpRsQi61B/8VeIl5lrRv
	gTOSKodZMrbxeaHsbhpe9Noz6KTon
X-Google-Smtp-Source: AGHT+IFv83+YHnaxvDRk0rvRzSWriqasX5eo6zDdijLVMUUFZ6zWAcypdJ15PvWFrs2NGam5+oBtYQ==
X-Received: by 2002:a05:620a:2906:b0:7c5:5692:ee95 with SMTP id af79cd13be357-7c7af12ae32mr620115585a.51.1744409492937;
        Fri, 11 Apr 2025 15:11:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8943afcsm321264485a.16.2025.04.11.15.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:11:32 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: [RFC PATCH v4 3/6] vmstat: add page-cache numa hints
Date: Fri, 11 Apr 2025 18:11:08 -0400
Message-ID: <20250411221111.493193-4-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411221111.493193-1-gourry@gourry.net>
References: <20250411221111.493193-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count non-page-fault events as page-cache numa hints instead of
fault hints in vmstat. Add a define to select the hint type to
keep the code clean.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/vm_event_item.h | 8 ++++++++
 mm/memcontrol.c               | 1 +
 mm/memory.c                   | 6 +++---
 mm/vmstat.c                   | 2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f11b6fa9c5b3..fa66d784c9ec 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -65,6 +65,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HUGE_PTE_UPDATES,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
+		NUMA_HINT_PAGE_CACHE,
+		NUMA_HINT_PAGE_CACHE_LOCAL,
 		NUMA_PAGE_MIGRATE,
 #endif
 #ifdef CONFIG_MIGRATION
@@ -187,6 +189,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_VM_EVENT_ITEMS
 };
 
+#ifdef CONFIG_NUMA_BALANCING
+#define NUMA_HINT_TYPE(vmf) (vmf ? NUMA_HINT_FAULTS : NUMA_HINT_PAGE_CACHE)
+#define NUMA_HINT_TYPE_LOCAL(vmf) (vmf ? NUMA_HINT_FAULTS_LOCAL : \
+					 NUMA_HINT_PAGE_CACHE_LOCAL)
+#endif
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
 #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 40c07b8699ae..d50f7522863c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -463,6 +463,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 	NUMA_PAGE_MIGRATE,
 	NUMA_PTE_UPDATES,
 	NUMA_HINT_FAULTS,
+	NUMA_HINT_PAGE_CACHE,
 #endif
 };
 
diff --git a/mm/memory.c b/mm/memory.c
index e72b0d8df647..8d3257ee9ab1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5700,12 +5700,12 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	else
 		*last_cpupid = folio_last_cpupid(folio);
 
-	count_vm_numa_event(NUMA_HINT_FAULTS);
+	count_vm_numa_event(NUMA_HINT_TYPE(vmf));
 #ifdef CONFIG_NUMA_BALANCING
-	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
+	count_memcg_folio_events(folio, NUMA_HINT_TYPE(vmf), 1);
 #endif
 	if (folio_nid(folio) == numa_node_id()) {
-		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
+		count_vm_numa_event(NUMA_HINT_TYPE_LOCAL(vmf));
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index ab5c840941f3..0f1cc0f2c68f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1343,6 +1343,8 @@ const char * const vmstat_text[] = {
 	"numa_huge_pte_updates",
 	"numa_hint_faults",
 	"numa_hint_faults_local",
+	"numa_hint_page_cache",
+	"numa_hint_page_cache_local",
 	"numa_pages_migrated",
 #endif
 #ifdef CONFIG_MIGRATION
-- 
2.49.0


