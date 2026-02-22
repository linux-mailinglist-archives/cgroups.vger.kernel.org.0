Return-Path: <cgroups+bounces-14118-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMK4MT7EmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14118-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:54:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F193D16EB4D
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABA673058AF0
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB024DFF9;
	Sun, 22 Feb 2026 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J1AoTa4b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77D24DFF3
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750201; cv=none; b=YWDnapfc+7PrWV7tw9TSF3bLepojP6mn7VIljsia9foNLXB2naWb5fBv6EEqG3TKPasN3KBqWv/ybEmCkP7GsGJCiBol9Ct5H9RgNR5Bg9Hng9vMSPUcvjPlT1ZXgP+eyPC0QHYAB4RNghi4wADxQJjTTlSGfBBrHNSfbfImwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750201; c=relaxed/simple;
	bh=Ouqj4GqJWjwYiY0gNW4BTPlwlgIunnGvFq2E9eGJsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfCCnrqPffR2Wwuz4Lzyy8CD6S5NTi8kxjrwX8/YSX6wiGetTgW06Gmyug90Yjg03vJT4gW+P3jlZlWrmLTaK+niEp9AZEY7YDCHrbxiU4CrOmQ14OzQwM1OOpAq3NfLz0JMlXR01VW2d32RlJRtrIOY0ggyh9KrEwOogd0JAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J1AoTa4b; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506984b6d83so29661071cf.3
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750199; x=1772354999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=degmio9cxdpzQuRYo2QvBbWquT2Pd1sYOKpzGMoeajE=;
        b=J1AoTa4bi2IOOhcduUTDkO0dYY6Xs0dyWF3OvN+AGw4ZVzZ71xL3XL9OmUDDclSgPz
         7WCF0lH93k1EeM+fFxODzmCZr+vccMR+N++msZ3nReP0vucfs+Dw4TEYcqkpoabhEkyO
         XQ6xWRN2LCujRzo3NwDNufq55dgjuIrXOXe7wM2g6z2A5PXcVWPaDwEWwPAtUwBDfS0h
         mw7UIY0pXHrMmyskBmhCygN3op0/sVwAjdY8U/ML4kD7aG2uSrg/hqKSBt1uQmx5fhG+
         LcyctMQsJMv7ywYj1WKRJ7KyucYsTcw1yj+/gUvfqhfPavv37YH/x9QPEwJnerneu2U+
         yiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750199; x=1772354999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=degmio9cxdpzQuRYo2QvBbWquT2Pd1sYOKpzGMoeajE=;
        b=Bqn8t4T1+AjeUXrVDyvK9JQel+LPcx+2eYxSvm5sJZ0a5r3gQx7C4HztwmfetWmNlB
         k4C6Y0/0/sBcUf9XLlvCscVtFc39IxQ+Wc/Y5uyZ6F/iVtcuXrUm/MN+yRPg9QAMvvTn
         2dC4+LxbTIR+kBtT+vXFO0uPYGdHtH6yOeuxcBiCmxnG8UntJXBhoUexNsfByo9Eo34m
         OVuw6XwFLdEFW5Ffr2RUve8kb1adw/dDx8RCkeUBUOaGftVea4+MOo0nVa/CvIVwHl/t
         thTKCqn3VE6DGYS8V5szseMtmgpatxboDnyCG7fr1lsvTcPL0GY+G+NxSRoPQpKcm586
         cmig==
X-Forwarded-Encrypted: i=1; AJvYcCVGMISW2fY6A2xVkazUfAocskSK+6OS9LtEMl2R4awuphrHIcMhlatSxObw+U+/KRBpAEfoHvPV@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkIhDb8yAI1Ih7i0e0jXmBbaRDOUh7bROzskjCjTqB+5RYSov
	URRCA+Od/7rp1V/eflJh5W2Ebf8VtJhdkxMLYSecz3kL2mOQWhP/rPfSlQUz02RMX3o=
X-Gm-Gg: AZuq6aK/7rKNCBR0NwPckuvO3aLvtx4iUGYrMIBBhr9Rb/CO2oMco/nm4UZX0MLsuV+
	vQxE5Uyx8XEVXZbLp5tBICbWfHnjaAaMfdUmXKTbZ6MmpMzO/Oh1lj6yE1b8vxJqh7npZoxANJ/
	DtXCNNmDwqbP8NqtV4UkvxOOccau7tNUT1NxR/9seBlt5YtwZVo126R6eZr2Sg6KqtL10pzephU
	Phrlo5vD+kVD5Y18rXXbeQineHuKP/4NwJrUL6hAoRQM0dSjo4hii2LF08olzqOdvqn26bcsczB
	1G5nY6kAMkmAgQ+AXlg+UbT6wThU/hHAgX8kvaMVMzuQQWjQ+rDaKhgMsZqINOYxKFMeMq7BoS2
	THwcWLqggROKWOKZB6gn1kSY3i0PCMngA942qn0Oz2+HPFzUBcfF56kXq5nBFCPnVXz3iTwnN68
	5jh9qkA+QTzhHc1sKh8TtTlNVZOhGB8wJsU0AaByS0iqDaLhJkyHErlGD1qJxFQ7LfCXeVJcPFO
	yce9KQxMz0+IkA=
X-Received: by 2002:a05:622a:1307:b0:502:9b85:a609 with SMTP id d75a77b69052e-5070bbf23bamr76760921cf.30.1771750199062;
        Sun, 22 Feb 2026 00:49:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:58 -0800 (PST)
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
Subject: [RFC PATCH v4 17/27] mm/oom: NP_OPS_OOM_ELIGIBLE - private node OOM participation
Date: Sun, 22 Feb 2026 03:48:32 -0500
Message-ID: <20260222084842.1824063-18-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14118-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F193D16EB4D
X-Rspamd-Action: no action

The OOM killer must know whether killing a task can actually free
memory such that pressure is reduced.

A private node only contributes to relieving pressure if it participates
in both reclaim and demotion. Without this check, the check, the OOM
killer may select an undeserving victim.

Introduce NP_OPS_OOM_ELIGIBLE and helpers node_oom_eligible() and
zone_oom_eligible().

Replace cpuset_mems_allowed_intersects() in oom_cpuset_eligible()
with oom_mems_intersect() that iterates N_MEMORY nodes and skips
ineligible private nodes.

Update constrained_alloc() to use zone_oom_eligible() for constraint
detection and node_oom_eligible() to exclude ineligible nodes from
totalpages accounting.

Remove cpuset_mems_allowed_intersects() as it has no remaining callers.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cpuset.h       |  9 -------
 include/linux/node_private.h |  3 +++
 kernel/cgroup/cpuset.c       | 17 ------------
 mm/oom_kill.c                | 52 ++++++++++++++++++++++++++++++++----
 4 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 7b2f3f6b68a9..53ccfb00b277 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -97,9 +97,6 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
-					  const struct task_struct *tsk2);
-
 #ifdef CONFIG_CPUSETS_V1
 #define cpuset_memory_pressure_bump() 				\
 	do {							\
@@ -241,12 +238,6 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 	return true;
 }
 
-static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
-						 const struct task_struct *tsk2)
-{
-	return 1;
-}
-
 static inline void cpuset_memory_pressure_bump(void) {}
 
 static inline void cpuset_task_status_allowed(struct seq_file *m,
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 34be52383255..34d862f09e24 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -141,6 +141,9 @@ struct node_private_ops {
 /* Kernel reclaim (kswapd, direct reclaim, OOM) operates on this node */
 #define NP_OPS_RECLAIM			BIT(4)
 
+/* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
+#define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
+
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
  *
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1a597f0c7c6c..29789d544fd5 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4530,23 +4530,6 @@ int cpuset_mem_spread_node(void)
 	return cpuset_spread_node(&current->cpuset_mem_spread_rotor);
 }
 
-/**
- * cpuset_mems_allowed_intersects - Does @tsk1's mems_allowed intersect @tsk2's?
- * @tsk1: pointer to task_struct of some task.
- * @tsk2: pointer to task_struct of some other task.
- *
- * Description: Return true if @tsk1's mems_allowed intersects the
- * mems_allowed of @tsk2.  Used by the OOM killer to determine if
- * one of the task's memory usage might impact the memory available
- * to the other.
- **/
-
-int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
-				   const struct task_struct *tsk2)
-{
-	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
-}
-
 /**
  * cpuset_print_current_mems_allowed - prints current's cpuset and mems_allowed
  *
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5eb11fbba704..cd0d65ccd1e8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -74,7 +74,45 @@ static inline bool is_memcg_oom(struct oom_control *oc)
 	return oc->memcg != NULL;
 }
 
+/* Private nodes are only eligible if they support both reclaim and demotion */
+static inline bool node_oom_eligible(int nid)
+{
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return true;
+	return (node_private_flags(nid) & NP_OPS_OOM_ELIGIBLE) ==
+		NP_OPS_OOM_ELIGIBLE;
+}
+
+static inline bool zone_oom_eligible(struct zone *zone, gfp_t gfp_mask)
+{
+	if (!node_oom_eligible(zone_to_nid(zone)))
+		return false;
+	return cpuset_zone_allowed(zone, gfp_mask);
+}
+
 #ifdef CONFIG_NUMA
+/*
+ * Killing a task can only relieve system pressure if freed memory can be
+ * demoted there and reclaim can operate on the node's pages, so we
+ * omit private nodes that aren't eligible.
+ */
+static bool oom_mems_intersect(const struct task_struct *tsk1,
+			       const struct task_struct *tsk2)
+{
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		if (!node_isset(nid, tsk1->mems_allowed))
+			continue;
+		if (!node_isset(nid, tsk2->mems_allowed))
+			continue;
+		if (!node_oom_eligible(nid))
+			continue;
+		return true;
+	}
+	return false;
+}
+
 /**
  * oom_cpuset_eligible() - check task eligibility for kill
  * @start: task struct of which task to consider
@@ -107,9 +145,10 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 		} else {
 			/*
 			 * This is not a mempolicy constrained oom, so only
-			 * check the mems of tsk's cpuset.
+			 * check the mems of tsk's cpuset, excluding private
+			 * nodes that do not participate in kernel reclaim.
 			 */
-			ret = cpuset_mems_allowed_intersects(current, tsk);
+			ret = oom_mems_intersect(current, tsk);
 		}
 		if (ret)
 			break;
@@ -291,16 +330,19 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 		return CONSTRAINT_MEMORY_POLICY;
 	}
 
-	/* Check this allocation failure is caused by cpuset's wall function */
+	/* Check this allocation failure is caused by cpuset or private node constraints */
 	for_each_zone_zonelist_nodemask(zone, z, oc->zonelist,
 			highest_zoneidx, oc->nodemask)
-		if (!cpuset_zone_allowed(zone, oc->gfp_mask))
+		if (!zone_oom_eligible(zone, oc->gfp_mask))
 			cpuset_limited = true;
 
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
-		for_each_node_mask(nid, cpuset_current_mems_allowed)
+		for_each_node_mask(nid, cpuset_current_mems_allowed) {
+			if (!node_oom_eligible(nid))
+				continue;
 			oc->totalpages += node_present_pages(nid);
+		}
 		return CONSTRAINT_CPUSET;
 	}
 	return CONSTRAINT_NONE;
-- 
2.53.0


