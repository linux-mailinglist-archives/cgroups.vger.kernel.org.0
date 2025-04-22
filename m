Return-Path: <cgroups+bounces-7697-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B7A95A7D
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 03:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34261885413
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE1817A2F7;
	Tue, 22 Apr 2025 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jE58Wm2c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9612E7E
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285183; cv=none; b=gp8y5Hlajfbg8aPP7dbF12aSWG5eiCyCDEDqPoRuURce40lcNLbJrtCa21BeMMR5g8gBJLrcqac7eQGLSaqX27pu2Jo9+aBYIsYZDm8aLnJ4KTLi0jeYjupUQ6SWMuYNHhNQA3I4VxFBRTXwu5SR44IfiUsptJNhMRmzyqWx6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285183; c=relaxed/simple;
	bh=ZXS1Ugxdib21vsYVjEPkJZvWOpqCDSOCHmByvy/LywQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5G9utnP6tk0e+fBQQ19iXyu5jT76vYg5wiTMAvfLtlcESBHUGZmaz8Qw/jfasoYhUG2vmtMeFG7ui2nPO65m8H/sLv33KGhQUoDd6av/Lio6LdiMfk4/dAAVVs8uFDhJ/oWVGlQ0y8g2Y/zqzNILKQe47XXA3XGua6D5YLNJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jE58Wm2c; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c55b53a459so459214185a.3
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 18:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745285180; x=1745889980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1mPVA4cXPg0N1mX+v1sOAvzy+p3OvMqYnhewp9Uhag=;
        b=jE58Wm2ciC9VU6K0JoSWEbV4Esf7PvCZ+G9e9AdyepwpGXq+0mT/SMTD8n4lO2XAWN
         jVWvjDTLkPxX84hTNHAGNMdenDoPlCxxCHsbZao15Lpqdn8sV5KD0u55LOD4UF2ht+mK
         Lkt5Z8e/FSpj+DRXYGqGM+6xUe+mR6tv8otKuNLrIHd7smQce5Hvg66D1PURFghgWiNi
         YFvaPltZn+bkl6FCFzJekYdH7Es4ghrMmO0Zozhkx6k4RrI41vtYGUWQTuKETI5y4c5G
         K/FGbRPwYTejaTpKoKchEhSpv1zKcP2tI60o7XyymrbEDoqmHDCwcJPxG73CCUwiHrPe
         2Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745285180; x=1745889980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1mPVA4cXPg0N1mX+v1sOAvzy+p3OvMqYnhewp9Uhag=;
        b=EVcXJ4iiiRrGBp3pRW73T0Ai4Sr6mYM+GidkIF6Z4JJCdfWauRuEdTqi6eMZRxLYpM
         KllH9UbQU2d8UtWrkbxNhYW6BXgOAzTnTxpy3nCbqM1xpKZsNCKbHUt9QZ8MYsZQRiZm
         DvfHG2AtiKG6l+tWrhAnZvAaIb0SvyXXHdf5rGoY2BHvRjR5XGjfyEAU4PMboq6eWCSA
         0wPQ4c/S3M8ESnkRgvJgnuPZjpgf22MJmPRb2URk4zsPKC7Ht06iixrKPK2zDIFIIGAy
         I98Ec3PqMAIgwxNs99UWmdMVWjIS1+Vz+UwbT7saZuhKl8RNDD3sGUYG5Rw0zUWmGs5N
         zTAA==
X-Gm-Message-State: AOJu0Yydp4SXsLsJB66z/5lAdLHzBpfEgy2e2Ihw+1w/qk+SRW/7hl9d
	u3eODGpub/CpFkVCxP7IKljatkjlXCPAI2zhe65BehfQvInSJVJ4oI1LrusyHp02013Nh/b2voQ
	w
X-Gm-Gg: ASbGncur4YJqU4rLeC9Ivob1xOZeXOy+9aLm3LY3thIMpf2s/rgEOV5Y5W87kw6c8xP
	UssIgv+xKN8IBLwyh+uC4Jnxr/zqMSG7rouPE2hqPCFQoiuPddnuDqLVe95C5bFoRa99JAlNJYl
	TDZlj7GfXbzA47Tr5JjmJNan0X/IA77/HbMZWIsYqQNB+jjW3/vYWGOktq5XNryF21cMTV4Xcg0
	OOPGKbj7XfttqMsvcwhR32fxU7qUGew9urEP/1E1G5Mc7IS52LtTbElwBM8zFI6n+QEyVnJmSMr
	ZJRbIh+prYiyewMPNJet78JZs9FreKujIxBbLZO6kcTu6uaIn3HLL0xrhPN1nX56zPAvoI5VpXH
	OsHQyXjERdoFhojMXbGp+qnDv+h6Y
X-Google-Smtp-Source: AGHT+IGPO18DH4WOgXP7cL3OCDqBNIt/HyTq16JBra9RvS5NgW2B0W0WDaXjFUz6XK3UscEHnrDmXg==
X-Received: by 2002:a05:6214:5081:b0:6f2:b7d9:689b with SMTP id 6a1803df08f44-6f2c4687f17mr226624926d6.35.1745285179659;
        Mon, 21 Apr 2025 18:26:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c00d78sm50985746d6.79.2025.04.21.18.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 18:26:19 -0700 (PDT)
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
Subject: [PATCH v4 1/2] cpuset: rename cpuset_node_allowed to cpuset_current_node_allowed
Date: Mon, 21 Apr 2025 21:26:14 -0400
Message-ID: <20250422012616.1883287-2-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422012616.1883287-1-gourry@gourry.net>
References: <20250422012616.1883287-1-gourry@gourry.net>
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


