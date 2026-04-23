Return-Path: <cgroups+bounces-15477-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMplDjSE6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15477-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:42:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90A0457567
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62FCD307D8D1
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DDD347FC8;
	Thu, 23 Apr 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+ZGfYqX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F297345CAE
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976500; cv=none; b=t8C1Qj9ab9AbE689uHU72oXdwd4Ouz0f8Qioq5krERjSLhwZiuzhrxDBsbWVHs0P/JJ0t0DktG1yvPEy/NjzUoPPuwbO0Dn5svbtyNCcmhTmRWcOONZT7Gzo+p9OOQOeAN7OYng/LE/KtqFCsTmA59XOFXQ+7+RvxZqiSrHqY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976500; c=relaxed/simple;
	bh=v3B0kALdEcg2SGdPBM+DB4YS9GNCcUTy6UpO99PS20c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM6W1srudNET4hbeatxobnW9Kf81EmqgTgiJ0JwFXb8GXT/zKfGloSn4YI/hcTkXTdbgBfy8TGnM5ODURFcdmkjf59yqvOGiCn/L+344cpHBOMQb4rNRo9WJ60xTalxdABWfRarjDgQk+yaeR+hbbQd6MKZYUmbe3h7/WKaRDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+ZGfYqX; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-42fbf95cca8so1930568fac.0
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976496; x=1777581296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3Q1U8jtPjzBDt27pK0uFFX6FlshrkPhJlAa3Maqh/4=;
        b=R+ZGfYqXDzZ/MWC/FySsn2NTg7q+XVU+HBftg9fcyUggpBSI8cfVuR784gkbRuczxA
         NCK2z2+vA51DEW3Z+cRITtRHmKn/sQnSd2dKzthglJIicPzhTy71Airz2qfBBenaJSPO
         Tgm3L/Uqsdi2zqHsfHui1CkuZHa4XVx8ThzmEo6YAewxHURAGBucI1BjQszGO6F6+Y3O
         J3kLm1O1zzsIPtE5VzdcYDWZ1joa0le861aCTE+NOIClTCPR79oebjs1tAiIBd70u86r
         MhG+ZW3gx3dzkF0Of66nY3iZ52aOa0jokWFdFh5DVTcgT/7bpbJLxDSffiX/xrMMBrjh
         ZUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976496; x=1777581296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X3Q1U8jtPjzBDt27pK0uFFX6FlshrkPhJlAa3Maqh/4=;
        b=GZU4yXaQDWh460U45nhorXH8MxlMGOTnNTnROcpkgvBgtVVyJyDE0/eIt3a5oYl1bE
         81zFOCktVsH4a/Ol41tJXYcBXqdOE4rI0STqP7HTBa5I9vgv4bK44saMhQtJ/m+B4NtW
         V3gpH0rfvXQZZiRPA3SWQ8ci/IoHkUbQepNmskRww/F2tT5yc01ujwmjzOnU8SUkFo6N
         9Hqiv+u79/alb6ADQblAoSNhVswcGDvpAKuxJnAigf8oQ0lu4eSgmV8GdLar8DJHewbb
         6myqSLBttnl/mOLUPxwiw/QWmzuvy4cc4SE1VKvQ9V1nxXxgfU2cTZdgAQ2Fv98hUNd8
         vlTA==
X-Forwarded-Encrypted: i=1; AFNElJ+B5vaSX3Gzw/19gsRiWYdi7ZOAg2HX7L//iBbu1VUd3xxjTbvmm2q/3TWrYMvMm68Rfxr2I4sU@vger.kernel.org
X-Gm-Message-State: AOJu0YzheLPPc4xxFPOuiKhhghhgadk+j6+uKFRnXKtcdVlXgZq6ca/I
	mHq6EvV6BR1xfRuL0DLMlMMtlITrv3Yfn0KbP38k8ZSjQFWzQOMhBZyu
X-Gm-Gg: AeBDiesGna8DjMDrD7mEvkWvgdUDu0VaE+Hf0J+BwdMYRqNDu+8U0p0TMPQv+jI5qDJ
	5X+2BKLXfuiWL7rQQUy/nmqG7NbU1x7vcrNtqJhg/dwSYhaYgXpNwKniLoHmTtlivokttF/PbOI
	egUi+/TOuO7hwlaEMtwBpJPuBJyQ21hy5Vx3aNn1jfL4Wxv5+hgXsM+G6ljxoJgocj8tClr0o6O
	JVfIZb9WthU0FZE6pqECxFs2vdEE4dByZaL/iF552xT9Qxyd0JNC+NK4iZYvS3AtHBs/8so5xZ1
	sIcY4KYYzFoIfb/AOT+8pO9PebuG7iJyhfg/BGLO6+EWdYP0lQjXERPWfLPFa6wVYOq6jLugmEH
	v2e+DPiWx7z3M7vQOuQjcZsEM/0X1fu6mqQQQqZTrDpxuM8PlAXV3k9Hu2MP1EJl30tvdVkq0Go
	/7QNetuvf3EkkJSOHUCAD2izR4EHt0Fpac
X-Received: by 2002:a05:6820:298f:b0:695:a638:c6ba with SMTP id 006d021491bc7-695a638d134mr4634567eaf.7.1776976496089;
        Thu, 23 Apr 2026 13:34:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694994277a4sm5603069eaf.4.2026.04.23.13.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:55 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 6/9 v2] mm/vmscan, memcontrol: Add nodemask to try_to_free_mem_cgroup_pages
Date: Thu, 23 Apr 2026 13:34:40 -0700
Message-ID: <20260423203445.2914963-7-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,google.com,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-15477-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C90A0457567
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new nodemask parameter to try_to_free_mem_cgroup_pages to allow
selective reclaim on certain nodes. This new function signature can be
used in future patches to selectively perform reclaim on toptier and
place downward pressure when toptier limits are breached but memcg-wide
limits are not yet breached.

All callers pass NULL to the new nodemask, so there are no functional
changes with this patch.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/swap.h |  3 ++-
 mm/memcontrol-v1.c   |  6 ++++--
 mm/memcontrol.c      | 11 +++++++----
 mm/vmscan.c          | 11 ++++++-----
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1930f81e6be4d..493dd99f3165a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -367,7 +367,8 @@ extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
 						  unsigned int reclaim_options,
-						  int *swappiness);
+						  int *swappiness,
+						  nodemask_t *allowed);
 extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 433bba9dfe715..03df1cc71842c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1500,7 +1500,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
+				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP,
+				NULL, NULL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -1532,7 +1533,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP, NULL))
+						  MEMCG_RECLAIM_MAY_SWAP,
+						  NULL, NULL))
 			nr_retries--;
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3acb06388405c..3fb1ee1d18603 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2123,7 +2123,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
 							MEMCG_RECLAIM_MAY_SWAP,
-							NULL);
+							NULL, NULL);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2432,7 +2432,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options, NULL);
+						    gfp_mask, reclaim_options,
+						    NULL, NULL);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -4591,7 +4592,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NULL, NULL);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -4651,7 +4653,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL))
+					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP,
+					NULL, NULL))
 				nr_reclaims--;
 			continue;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5a8c8fcccbfc9..615aa0c899dad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6807,7 +6807,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
 					   unsigned int reclaim_options,
-					   int *swappiness)
+					   int *swappiness, nodemask_t *allowed)
 {
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
@@ -6823,6 +6823,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.nodemask = allowed,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -6848,7 +6849,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
 					   gfp_t gfp_mask,
 					   unsigned int reclaim_options,
-					   int *swappiness)
+					   int *swappiness, nodemask_t *allowed)
 {
 	return 0;
 }
@@ -7964,9 +7965,9 @@ int user_proactive_reclaim(char *buf,
 			reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
 					  MEMCG_RECLAIM_PROACTIVE;
 			reclaimed = try_to_free_mem_cgroup_pages(memcg,
-						 batch_size, gfp_mask,
-						 reclaim_options,
-						 swappiness == -1 ? NULL : &swappiness);
+					batch_size, gfp_mask, reclaim_options,
+					swappiness == -1 ? NULL : &swappiness,
+					NULL);
 		} else {
 			struct scan_control sc = {
 				.gfp_mask = current_gfp_context(gfp_mask),
-- 
2.52.0


