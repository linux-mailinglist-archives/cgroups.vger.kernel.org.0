Return-Path: <cgroups+bounces-14122-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJCqEsrEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14122-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:56:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F311116EBC9
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FF7E30C6909
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C123D7E6;
	Sun, 22 Feb 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZSsseRur"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174E2609FD
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750216; cv=none; b=M/fLAhkz1gVbUFZeLm1mTDwhzecdaIvjGoPY/AZefxuM2y6pbzS+xdmbLBbpchJZ4dBmIjt1U9U+U1R3Fg0y8aorwxLXtOJM7Ln0YtnQN48RCGLBFdOBwyaSdQ5T1dUJ+QHVXRiX8CMHbfLntt5E6EQjkJi/itGVt3l6ikyuDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750216; c=relaxed/simple;
	bh=244yDtSyFVbK83TYYa36HIEQwZx1d31NEEAoZWs7XP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnLFMlOMv5GUnbR+BOPkOGVp4AudyRTkl20x77TopUcKlRMhIMfvHn2LAs4NhDL0O+ZguwWTRtk3mP4Q8bRiWsrlMJaUB7HizUcD1uZuD2at7Mb+WFQ6ZyAaFaUL7O6dAVvr0vDCPapo6wFLtUtJNqNz0BGmZzMRxS+OVQTCyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZSsseRur; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a1b23c05so43291411cf.0
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750214; x=1772355014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqXt+gXrz4jwbWr1GpuXze54uGQtZjiwIpwqUhqliWw=;
        b=ZSsseRurZipjzhbnIpwLXt+nRR66anrop8z0XJHW+ZDaD/Va8PKodL5a/mYWGhnfJ0
         0TKUBSYJCjdc8wyQiEnTzu2h6694bpTicZ8mzL1agkPMmgQAn2bdtP+gOyd6DklaHvN0
         Y3ZWl+kmUtJcpuLpuP5iNgoAtBuRd1zXN4tdMIsLuusXHCmRcqr1vJDgNyGhffES1kyj
         xRiyUWIak4M3jGfwu/jC0TkTkyGoP4oJOeA5m9l3Xt1ZLEo39EO8+j5hFc3RYsJkuV4Z
         3G6w1rKwsJ5H9CtSSCkBOtHHEIBUAYYBde6lXq86/1TjLJW5lj8SHRf2H/ASgSyy+uOM
         pr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750214; x=1772355014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqXt+gXrz4jwbWr1GpuXze54uGQtZjiwIpwqUhqliWw=;
        b=JX3stFQorZaM/9JN5NS01L/mQ34SCNZ7a4yhoEYbhebMLwc+D7XqeKqfnDGAJI+z+d
         vvApKc0C+ezIW9LkRe5SQ6u474ZYrhCZJDCEVW+PF5KLDt0eTDJOotBGXAxMafvIDD1F
         /vsKUo1Pbph+PYnEkWIHcj8JP782Ojwcg2gSdEG58+MMqvtxrcAYZHGdBzVfVDvMJcCY
         cqTErwD7hfiayDBwC+AgJ0Xj94lExgUI9JGPs6sGqzYtwxcQNm2S31YdAd75X03Zi7dH
         ZS+oNuwgU8U+ufn4XFkdiypnR6CO8IfsqT6D0lpoMMFvfignK8GloMpkOsC1q1YE+NGU
         j3ag==
X-Forwarded-Encrypted: i=1; AJvYcCWiq6WrGl1956VuHhw6qCVkn/1y3m2Ao+/voXImBYXxSuBJPa5kjx6ikMPnZjBG0UkkPZ34va8D@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Rzf55a7Juyys6bXZI6JGn9HbG2P5AuYGrbXxjGzGWaUV2REg
	UCZGTy4+Nw11w09Im5zJqK/b6dTVhOPYP55Gc7nXTbTi8+HEXqN918vJZAzJREJELTo=
X-Gm-Gg: AZuq6aIVe58KBXAoYu3YB3UmySv98OqoPnuMm+EitD+VGlKJ60L3DRgWTk90QO1uhB3
	FX+NK5p2QEAwwG1ZXIm5alf/6x/dFbozAPvgzt5FRwekGJNMsegigNZbC2EfJHvZp6PyUTN5ji1
	9BY3CwkvVRbhaztsniPBB1rk2LJefA82qlIVlRuG5vYJWWeaS88xGp1nM3D7o6oxDmxRxr5jNrW
	f012EtLf1kSk0KlqT2YrAahx/A45PNQa7znmBxG+S4v5Rsafwp98tVnpQlS17N8iXC2Wqsy0pg/
	B3eeG1BfM15Qx0tBXZ1WHs2mO3HlZYijy/uQoIZLs4xJqgqhC3q44Xg7vIEanUrU/lt+wg3eJU1
	QwhIg0KVHcbkLaOOtCjYOJl16xuJqXZj9kflltgQ9Y7iftxmwCfys7OS/f8qGB7U5cnCzlY2Mqv
	/axOL0zbcPLnPzYb8BvzDlbYDyj8jz0C2RJpp6HYcC/UUqIABjB0eLcz+GpKHvdhQ6UUbDiCOhR
	uzkdU35+HyQGCw=
X-Received: by 2002:ac8:58c3:0:b0:501:4b96:466d with SMTP id d75a77b69052e-5070bc97e29mr62373271cf.50.1771750214354;
        Sun, 22 Feb 2026 00:50:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:14 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 21/27] mm/memory-failure: add memory_failure callback to node_private_ops
Date: Sun, 22 Feb 2026 03:48:36 -0500
Message-ID: <20260222084842.1824063-22-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14122-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: F311116EBC9
X-Rspamd-Action: no action

Add a void memory_failure notification callback to struct
node_private_ops so services managing N_MEMORY_PRIVATE nodes notified
when a page on their node experiences a hardware error.

The callback is notification only -- the kernel always proceeds with
standard hwpoison handling for online pages.

The notification hook fires after TestSetPageHWPoison succeeds and
before get_hwpoison_page giving the service a chance to clean up.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h |  6 ++++++
 mm/internal.h                | 16 ++++++++++++++++
 mm/memory-failure.c          | 15 +++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 7a7438fb9eda..d2669f68ac20 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -113,6 +113,10 @@ struct node_reclaim_policy {
  *   watermark_boost lifecycle (kswapd will not clear it).
  *   If NULL, normal boost policy applies.
  *
+ * @memory_failure: Notification of hardware error on a page on this node.
+ *   [folio-referenced callback]
+ *   Notification only, kernel always handles the failure.
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
@@ -127,6 +131,8 @@ struct node_private_ops {
 	vm_fault_t (*handle_fault)(struct folio *folio, struct vm_fault *vmf,
 				   enum pgtable_level level);
 	void (*reclaim_policy)(int nid, struct node_reclaim_policy *policy);
+	void (*memory_failure)(struct folio *folio, unsigned long pfn,
+			       int mf_flags);
 	unsigned long flags;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index db32cb2d7a29..64467ca774f1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1608,6 +1608,22 @@ static inline void node_private_reclaim_policy(int nid,
 }
 #endif
 
+static inline void folio_managed_memory_failure(struct folio *folio,
+						unsigned long pfn,
+						int mf_flags)
+{
+	/* Zone device pages handle memory failure via dev_pagemap_ops */
+	if (folio_is_zone_device(folio))
+		return;
+	if (folio_is_private_node(folio)) {
+		const struct node_private_ops *ops =
+			folio_node_private_ops(folio);
+
+		if (ops && ops->memory_failure)
+			ops->memory_failure(folio, pfn, mf_flags);
+	}
+}
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
 				     unsigned long vm_flags, unsigned long start,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c80c2907da33..79c91d44ec1e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2379,6 +2379,15 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
+	/*
+	 * Notify private-node services about the hardware error so they
+	 * can update internal tracking (e.g., CXL poison lists, stop
+	 * demoting to failing DIMMs).  This is notification only -- the
+	 * kernel proceeds with standard hwpoison handling regardless.
+	 */
+	if (unlikely(page_is_private_managed(p)))
+		folio_managed_memory_failure(page_folio(p), pfn, flags);
+
 	/*
 	 * We need/can do nothing about count=0 pages.
 	 * 1) it's a free page, and therefore in safe hand:
@@ -2825,6 +2834,12 @@ static int soft_offline_in_use_page(struct page *page)
 		return 0;
 	}
 
+	if (!folio_managed_allows_migrate(folio)) {
+		pr_info("%#lx: cannot migrate private node folio\n", pfn);
+		folio_put(folio);
+		return -EBUSY;
+	}
+
 	isolated = isolate_folio_to_list(folio, &pagelist);
 
 	/*
-- 
2.53.0


