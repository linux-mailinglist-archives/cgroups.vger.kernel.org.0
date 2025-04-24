Return-Path: <cgroups+bounces-7810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459EAA9B92C
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6587A436F
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E91280CCE;
	Thu, 24 Apr 2025 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CZBszlmN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F7223DC3
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526495; cv=none; b=JW10Zm9BLbeniPecwEIKdrcQl1pqupGtRCbZ4IFY1m+Q2e3AVlJr8iicoPeMrR5NvFarw5oHdxjh71H9rD5EKGQ8nD+DIHWoNkCtPsiU8li6o1Xy7Sj4OVbW3DnWGeCzb0HvcCKhucABPkl5ZW6jRQP1fBqbpBAQ8qc9D0HilFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526495; c=relaxed/simple;
	bh=QemlZRsMnReDRXGr7XlMMBNDMS1lFareGFcDixhJSmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT+ViFfS/69EEHkcNmWwFz9grXPHC1MWlOc7kN4GFq5SpYwVlNLiqut6knxHj63zwQYBT7/BF2yV6kDQZJSBAuxnZ+TBZbgy5oCc7CKV9UfuHEtBbhQwIfozKX+eyKJxfO7uu6H6FQRnHT2TMu9IvLLz/3lFi8snJRpkhL5XAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CZBszlmN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-477296dce8dso17635891cf.3
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745526492; x=1746131292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djWz5UXPAr8AyfZCTcoqGVabcC1mywuVV3L68VCKfXA=;
        b=CZBszlmNFDWYgC3H7GR3Bv1WyrdB3xqLre+N5KOhZ9F96rSLtHDq60zrsVfsfbvG0i
         EDpntc0aI3tJijpfPl11AEFgGx+i5paawmB4/CGYrtM3dRhhSMXRHeY8R26zA91Yb3vf
         rGMF+vKidnzjnNtMpQSHSupIKNB1ZmEZTHT5xk9yFnnN7wzBdaGeZQWGlmfWw/GvBCOB
         4avDDlPdXNlq+Zmm+X5jxM9OveiIl9mrOkftm6FHpk72r3JluoTv8CUjKWTOs9mTiLgD
         RswqhzEu8cHZ8MF5WKpAOV7JYCU4lCfOSOwu67yGFPd+hhiAKWSJIc6nQ2gr3mc+Scrn
         1qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526492; x=1746131292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djWz5UXPAr8AyfZCTcoqGVabcC1mywuVV3L68VCKfXA=;
        b=Rc0Dqme81Onlu3a+LWbLRyEHAREaXcNLr2r1Tm+vdyaqDeFogWmD3eKZRQ0cEVmJq0
         OzLiP7zYmnkSt9A+cSytgkm764qw+vEAWxP5/bldXHxjM47xa13nU/Ri34ZSO4FgicxX
         Q2Q5JD3fpGgQdNsUZ0Le12VCT0Y2rm5MnKUenOuaxtBueL/LU9hWPXmx0LckynKo/gJg
         qx8R0qSEKZVktY/yicq56I7LEuRvUXftmVPEOz5n/+/+8sTPqjw8kK2I2Xsp/Xr03XmR
         v9qnP1sOvw02eIqKGIOMibltpOmWqZegA94ziOpslBmV2W2af/ncp79ypHbP093S1k6X
         GFig==
X-Gm-Message-State: AOJu0YxcNj92tfo4wQ/V2OCfa0AKwXQOybNAjtTTOi++Zz0ksBQs6I5J
	UpMwToBQtoDV1nQfthiyHVgAeD2DUaw7XTRDs6lMe7YTeyxqSsR0aqYqvE09JuM=
X-Gm-Gg: ASbGncvI00AZTGfcQKT6qe+KydmHoUOR6ANHnKcGT1kdufdFGr8vdAxKjH7ABaZ02xS
	roIxbSBYxoJOSPq6OCCDDAPugT4uw3Kj8awvQtwTlKqu6D8/DFBA6Olt0TygGJd7B8EsKnkur6x
	RvquqnzgTWaBQQ4VNUwjRCGXqxY0gGXZ2eOMVJriPGXw1VBAJQrT79t0h2vRL1an1SAecKFZ5/p
	VR+HM3Aix0cPxtuqZaEev4S61KZ+zjfXgE29AjhxQNI6HUCNs8ZBk5hPdP37jUbFacHAZydzFKI
	ZAxMouwprzv47EFSRaVt+faZAQk9+BdQuQ2vlUPXOnTGVnSVHa670L8joqugdDoXOyLWAmcBArY
	y5MTy+xviQzjbZIb/NVwUeCJHkbQX
X-Google-Smtp-Source: AGHT+IHroQuwjDqOCLRne8dm8Vp0grLAYCc6/tWBne433mx8sIvfwNe35yRvYQ6+/dZJK943JOTBUA==
X-Received: by 2002:a05:622a:178e:b0:477:6e69:6436 with SMTP id d75a77b69052e-47eafaecab9mr51761201cf.0.1745526491826;
        Thu, 24 Apr 2025 13:28:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9ebeb870sm16091691cf.5.2025.04.24.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:28:11 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Subject: [PATCH v5 1/2] cpuset: rename cpuset_node_allowed to cpuset_current_node_allowed
Date: Thu, 24 Apr 2025 16:28:05 -0400
Message-ID: <20250424202806.52632-2-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424202806.52632-1-gourry@gourry.net>
References: <20250424202806.52632-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename cpuset_node_allowed to reflect that the function checks the
current task's cpuset.mems.  This allows us to make a new
cpuset_node_allowed function that checks a target cgroup's cpuset.mems.

Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cpuset.h | 4 ++--
 kernel/cgroup/cpuset.c | 4 ++--
 mm/page_alloc.c        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 835e7b793f6a..893a4c340d48 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -82,11 +82,11 @@ extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
 
-extern bool cpuset_node_allowed(int node, gfp_t gfp_mask);
+extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
 
 static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 {
-	return cpuset_node_allowed(zone_to_nid(z), gfp_mask);
+	return cpuset_current_node_allowed(zone_to_nid(z), gfp_mask);
 }
 
 static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973..f8e6a9b642cb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4090,7 +4090,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
 }
 
 /*
- * cpuset_node_allowed - Can we allocate on a memory node?
+ * cpuset_current_node_allowed - Can current task allocate on a memory node?
  * @node: is this an allowed node?
  * @gfp_mask: memory allocation flags
  *
@@ -4129,7 +4129,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
  */
-bool cpuset_node_allowed(int node, gfp_t gfp_mask)
+bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 {
 	struct cpuset *cs;		/* current cpuset ancestors */
 	bool allowed;			/* is allocation in zone z allowed? */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5079b1b04d49..233ce25f8f3d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3461,7 +3461,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 retry:
 	/*
 	 * Scan zonelist, looking for a zone with enough free.
-	 * See also cpuset_node_allowed() comment in kernel/cgroup/cpuset.c.
+	 * See also cpuset_current_node_allowed() comment in kernel/cgroup/cpuset.c.
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
 	z = ac->preferred_zoneref;
@@ -4148,7 +4148,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		/*
 		 * Ignore cpuset mems for non-blocking __GFP_HIGH (probably
 		 * GFP_ATOMIC) rather than fail, see the comment for
-		 * cpuset_node_allowed().
+		 * cpuset_current_node_allowed().
 		 */
 		if (alloc_flags & ALLOC_MIN_RESERVE)
 			alloc_flags &= ~ALLOC_CPUSET;
-- 
2.49.0


