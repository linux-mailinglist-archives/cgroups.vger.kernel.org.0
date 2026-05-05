Return-Path: <cgroups+bounces-15622-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDFOIyoQ+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15622-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:43:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5CC4D06AE
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3C6D302F539
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84EA492512;
	Tue,  5 May 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC7KU6nY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978AB48A2B8
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995579; cv=none; b=mlhx0IYCjwvn0udE0Xg7NW/LxHePVlX3Gq1blwDlhQVeVDeYYLy2Wx4tKhwLMfI/B7zweVN4qMqmF0qHMjMALQ+1ucAhlwCdgXcCgAb2eKZNlJElEVe2W5EmwWOarFLrv2TyrXtBhS+KY0QPzborrSt2FyQ5MZ2jmWvNjZZ+5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995579; c=relaxed/simple;
	bh=pUn9b9LUhmis+nxUstyTj7eYl6B+eZR5n7i3p7grHPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLvrenQUTnh+6ehq6N/1vK/j1ROiSUkhzmeyy1Do+fb9ORbQiVlLVbuVFbFlOKNv+CnfoKr7ElKC0P5yW7EiKPMhK1RC8n1/Bx7KGraaj0Y++nckYGOyl0AXhsA6Vbf2kqis8yk9LXXcmcCmJEY45BFNfGlmq+b3Fo+YmtsIFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC7KU6nY; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-696ad0c2c2dso1111439eaf.0
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995573; x=1778600373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spNG7IJraDg4T5BsvCQ+9NVFqbAOm2jy1KvenC+2iQ4=;
        b=iC7KU6nYG/tY8Ny1bm8Kpi+rZ3yzy0iLcf6xFHKPhzDCygHcclsBRTj+j8CWXrD4V0
         4OOFblwHDbetkaTTs54VPGCRZtV/ibx6fwX8jdItj5VOfanC3Qj5a1grJPHXIwQRZjgI
         /ogGxc2K+GMblW2HD4dawSW2f7v9Rrt9GeQ4ZKmo+6HYUV2bgrk/Ce+JkUdXbyobaVry
         98uvKXNfH8HgpKrKITI2K2rKRxDLz91SmtcDP5CcVG5m4007VOlPd30hfHLzqahEzOj9
         zjFL8ECPVudXzxJ+AB41c39WzHGc//X+s6TiqcSqSb2Tn/m7ooXERBwgG6NPe+QUGJy1
         RO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995573; x=1778600373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spNG7IJraDg4T5BsvCQ+9NVFqbAOm2jy1KvenC+2iQ4=;
        b=hGuOjAegMtzACG8uhB2wZNkBW5zp5gR5KQ8RaYVtm+IIADIvRuw+gnwjz+oCpiQDGK
         /JOzDl9F3wYKTsGq6Zs2F2g7QOlzka7Gpli9iJX6iiQ4vsIIQJN5WquPppv9wWn+Hncb
         aNofrGQX/87tgo2ChGTdpYmIvYS4EPgP/1YO2YB0ps9URwRtYuzFPA8XvLKvKLWpjBCb
         4LKrco5M458PItoFUPxV6EId5SAw+f/GKNYjvhZM5+eDOBkApFO8ItplxiHUste+QxBt
         g8bSqkCtiyV2QrjY182GA35c6Fkj8nZNeWwfZvfnpVJiOnE11sJf5mTbA52fiBG4nJ3e
         gHmw==
X-Forwarded-Encrypted: i=1; AFNElJ91DHUFbbFubcMHonTcdCl7aePYI3/7uoheiLIMfNYIi5OVO/P8+pQ8b3XynaMBxlpOwEAmXINu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/EXVCIu/dXytF5o5hzeDKlypLQknB7Gma8MQDLddrvn6kRXu
	ZTQoZTPsGkIWwaWS043AXsuqtU7uZwWmW+bPZTxy+CV/mueiPl4B+xWx
X-Gm-Gg: AeBDies9v+B3EJrRB24mTljPo8cuUBZm3vO1lK+umQ7XA3SfyXI+CevTam1ISBHypX/
	qVUTMvQ7HVbTv5OrcsggtSInRmnESgUddNTkFIBd69CvWeROzs4rt2v0IYFck3lpnkJhdA04Ryg
	zCzviqieRrggM5r3YUqMl0xE8VrgqlIPRgAU7pwWYOOIGSOdPosgBiqIU7KUh+ZOvV08TJWsEaK
	9zTWfrJKfniuUEJ10CYnqpS1YqAwZvl3iRRi1y6GCGhpU3ujaEQXPc9E/X/RNkd3oaT4aIm6jOa
	vJotJv04kYll/Zx3LjrilmOOiltB3CAHsEe6giLmWoZUZWUUQZUVzRtlMgeXyRPDhoJwuFeO47t
	BN5RtnOToeH3czD5UplXjgmxDTmvdzfqOPe5nwj/a9MWvUPKbBAmLDoJgk/LIGJXad1oRrsee2P
	hroKuFnd/J0HDg89+dQOrG81Q22wMLIgpJuCBQ/RwYwohFqt7sBaCvrue/AatmskMMOoY=
X-Received: by 2002:a05:6820:3109:b0:694:8ad6:245f with SMTP id 006d021491bc7-69697dd52eemr7034578eaf.43.1777995573227;
        Tue, 05 May 2026 08:39:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d324a4sm13945195fac.14.2026.05.05.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:32 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 16/22] swap: do not unnecessarily pin readahead swap entries
Date: Tue,  5 May 2026 08:38:45 -0700
Message-ID: <20260505153854.1612033-17-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A5CC4D06AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15622-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

When we perform swap readahead, the target entry is already pinned by
the caller. No need to pin swap entries in the readahead window that
belongs in the same virtual swap cluster as the target swap entry.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap.h       |  1 +
 mm/swap_state.c | 22 +++++++++-------------
 mm/vswap.c      | 10 ++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d46b2f243f83..f3f2afc6751b 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -156,6 +156,7 @@ void swap_cache_lock(swp_entry_t entry);
 void swap_cache_unlock(swp_entry_t entry);
 void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr);
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7fe4d9529e4a..39daea7bed66 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -553,22 +553,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		/*
-		 * Readahead entry may come from a device that we are not
-		 * holding a reference to, try to grab a reference, or skip.
-		 *
-		 * XXX: for now, always try to pin the swap entries in the
-		 * readahead window to avoid the annoying conversion to physical
-		 * swap slots. Once we move all swap metadata to virtual swap
-		 * layer, we can simply compare the clusters of the target
-		 * swap entry and the current swap entry, and pin the latter
-		 * swap entry's cluster if it differ from the former's.
+		 * The target entry is already pinned - if the readahead entry
+		 * belongs to the same cluster, it's already protected.
 		 */
-		swapoff_locked = tryget_swap_entry(entry, &si);
-		if (!swapoff_locked)
-			continue;
+		if (!vswap_same_cluster(entry, targ_entry)) {
+			swapoff_locked = tryget_swap_entry(entry, &si);
+			if (!swapoff_locked)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		put_swap_entry(entry, si);
+		if (swapoff_locked)
+			put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/vswap.c b/mm/vswap.c
index 01c336ae252c..195ba3520e54 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1542,6 +1542,16 @@ void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si)
 	rcu_read_unlock();
 }
 
+/*
+ * Check if two virtual swap entries belong to the same vswap cluster.
+ * Useful for optimizing readahead when entries in the same cluster
+ * share protection from a pinned target entry.
+ */
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2)
+{
+	return VSWAP_CLUSTER_IDX(entry1) == VSWAP_CLUSTER_IDX(entry2);
+}
+
 static int vswap_cpu_dead(unsigned int cpu)
 {
 	struct vswap_cluster *cluster;
-- 
2.52.0


