Return-Path: <cgroups+bounces-16423-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNTaDUWFGWouxQgAu9opvQ
	(envelope-from <cgroups+bounces-16423-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:23:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99B602352
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7490F30524FB
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BB3C9890;
	Fri, 29 May 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mCkTiPo2"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41D3DFC93;
	Fri, 29 May 2026 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057178; cv=none; b=C1j3GMqJbfJdL7yIBwT7s4qZzlIjZYyntlJVCczBGDktfT3Ud52WUNAlW1w6RVBHhmbKCdzGpwbQcajO7SMR53mxyDGNAHoebhe34xdsngIb/tMDIqbWybvW2/J26g8dNjveYxWylZWqZ6txTgLMkIpAAH287S5JIoPMWaWIVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057178; c=relaxed/simple;
	bh=7jLMGW+raRr9jRp/zuJHoM7n9LG+68alAMBMXxBd+uo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qDkI5DHzY+U0xD7pgQ5mi7LdDEFKDDfpLNjPZG4R+QfEOfywYS8i/BySrcQxuyTxlm+y4UaqBoyVD/3yt4QVFhsn9qbcq6ykOftY9gCstScORnfTXw22pOOB5UAm+m7aW3x4lbFsoW+iLcT2zc6Y4ZMW2cr54jCTFhJ0l2kkcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mCkTiPo2; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780057172; bh=bVdSFaRs3+EuMAnxIy5DMxxMx3cOnErIMJI6trzSpzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCkTiPo2IHFozwt8DpBgCjFjySFOUCuCqTBoaeJIrfHDNtKRvPSy8ga8RIIhXoGD1
	 +Vp+23K9Y/9cO0wv9B05pN4RsbWvBjmiFM6f2UqnZxxpT5BPdEDwYq0/0pvLDMdxkT
	 ZT7UMm7mvMFjuQvpNyL+8DmLq55Qmg1UFp/uDPHI=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4DC10017; Fri, 29 May 2026 20:19:28 +0800
X-QQ-mid: xmsmtpt1780057168tzjwrsgd1
Message-ID: <tencent_C78A02F3C41E15233C371816825C7DCF8708@qq.com>
X-QQ-XMAILINFO: Mi3PnGw1zbXUjsp55hP//2TzDYS0KqexQwEQGN+M9bSC/Uz/t0z4g0+EhjTtIp
	 aeC+9AOG4QF1yU3MizVH6jsjooanTR/YImuIOHMLZtLBWkfeahthNaouMCgnkq+4hSzD3tgQh2XG
	 cqRup5WSheqyiCFxk21Z3mbwtSfMbOQMHLRbr+E/+chvZheENv8ppzUeBEI8UCEzfG1/jxZiFxyF
	 JE7xjP8ub2ACuhw+tODKS062CDu4/T9QD8F4NdlKhcTl3Jc8EeTjr2kYsRQ5UK5Hk0KLHSrKMFhu
	 mZLyoxhqmL1jKhtZL3fx+CpZe3qVa7BYYlggv4aTQdCjfE+gPcyezlNIe/RqbynSqgetnZZgsqdf
	 tQ8sNXkXnO3Pz3ypFtgl71X/b7TsQgVV6YKTEJiTObQezFUY9yhVU03QB06s1/56FkU5WR5nm+6k
	 3TV8h2C14/FRkpGI5zAxZguRacsR3epJaRo/i1fKKeTOOPLil7pQc6nrJsPOiHluEG5RqdTLXO4K
	 cgqOd1uaAA1UEPNoiFIryuDsv+ioAjdNf0nRomgnDn/v2ha5Wcum3JEmj3UAPnSUaFL2CuEuSlGP
	 XxQyizk8zeTOLyKJkYZbh1FIGsZ91Az/F18jOPCi5v1DxHim6oBqViPSqpO7QmKOeE1j2abubHlh
	 Y0UD9hZObBOFfAZXXADZ7j85B5bFiXwYoJHkkTLrlRokRx1srF81L9m1TLVDMmlmsyIGNkAICdLj
	 qlyDS0lRnH9L7NG1iBiExGC8Ys3vKHoeQjs5L9X+64zilXWEn2oOeXYVxAO44Edo9KYIjEU4G/BR
	 l3jySsFO94cRwP9qfuxfnK1oYgBx7kzjFWri8MeLRAwaFANb0AcvRqLz5lw4qtItsg613ZSgXNIK
	 IreARaqnQ0WTnkMJIBgyoZtL9itkNwxPi4V0HTRNt3cp4cMpSceA6PZyfd/wLkKN4HugFzokiodR
	 yP0IMUMzY+oT7YKZlNRnMy7NsctfIbfvyV93nAb6jwA1Un3gbA9m8YXxYjEZLOj7Ox9RtHkiWbd9
	 6tpV34wAsTreBbqm/Hw9CMLzwYvmtSTm/70HLX2IrRJayVsRbBlEiEnUB8qygbYNw9XXJA8d9Vpt
	 DNjywgVE4gVz9JYNTNHYobOfd5IKqB8kxs12z+UbOK0fU3j6uV6lOBmLn2hw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: fujunjie <fujunjie1@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@meta.com>,
	Kairui Song <kasong@tencent.com>,
	Usama Arif <usamaarif642@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 1/9] mm/zswap: expose range state for swapin policy
Date: Fri, 29 May 2026 12:19:20 +0000
X-OQ-MSGID: <20260529121928.4115683-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16423-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,gmail.com,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:mid,qq.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C99B602352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Large folio swapin needs to know whether a candidate swap range is fully
backed by zswap before it can choose an order. That decision should stay
in common swapin code, not inside zswap.

Export two zswap facts for that caller: a lockless range occupancy snapshot
and the current zswap reclaim-pressure state. The range state is
advisory only. Writeback or invalidation can change the backend after the
snapshot, so users must recheck before issuing large-folio IO.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 include/linux/zswap.h | 26 +++++++++++++++++++++++++
 mm/zswap.c            | 44 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 30c193a1207e..8f9aee97517c 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -9,6 +9,18 @@ struct lruvec;
 
 extern atomic_long_t zswap_stored_pages;
 
+/*
+ * Advisory zswap occupancy snapshot for a swap range. This is not a complete
+ * backend classifier; callers must recheck before depending on ALL_ZSWAP for
+ * large-folio IO.
+ */
+enum zswap_range_state {
+	ZSWAP_RANGE_NEVER_ENABLED,
+	ZSWAP_RANGE_NO_ZSWAP,
+	ZSWAP_RANGE_ALL_ZSWAP,
+	ZSWAP_RANGE_MIXED,
+};
+
 #ifdef CONFIG_ZSWAP
 
 struct zswap_lruvec_state {
@@ -27,6 +39,9 @@ struct zswap_lruvec_state {
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 int zswap_load(struct folio *folio);
+enum zswap_range_state zswap_probe_range(swp_entry_t swp,
+					 unsigned int nr_pages);
+bool zswap_pool_reclaim_pressure(void);
 void zswap_invalidate(swp_entry_t swp);
 int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
@@ -49,6 +64,17 @@ static inline int zswap_load(struct folio *folio)
 	return -ENOENT;
 }
 
+static inline enum zswap_range_state zswap_probe_range(swp_entry_t swp,
+						       unsigned int nr_pages)
+{
+	return ZSWAP_RANGE_NEVER_ENABLED;
+}
+
+static inline bool zswap_pool_reclaim_pressure(void)
+{
+	return false;
+}
+
 static inline void zswap_invalidate(swp_entry_t swp) {}
 static inline int zswap_swapon(int type, unsigned long nr_pages)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index 761cd699e0a3..da5297f7bd69 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -506,6 +506,19 @@ unsigned long zswap_total_pages(void)
 	return total;
 }
 
+/*
+ * Expose whether zswap reclaim pressure is active. This is a backend fact:
+ * zswap_check_limits() sets the state once the pool reaches the hard limit and
+ * keeps it set until the pool falls below the accept threshold.
+ */
+bool zswap_pool_reclaim_pressure(void)
+{
+	if (zswap_never_enabled())
+		return false;
+
+	return READ_ONCE(zswap_pool_reached_full);
+}
+
 static bool zswap_check_limits(void)
 {
 	unsigned long cur_pages = zswap_total_pages();
@@ -1559,6 +1572,37 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
+enum zswap_range_state zswap_probe_range(swp_entry_t swp,
+					 unsigned int nr_pages)
+{
+	unsigned int type = swp_type(swp);
+	pgoff_t offset = swp_offset(swp);
+	bool present = false, missing = false;
+	unsigned int i;
+
+	/*
+	 * This is an advisory, lockless snapshot for common swapin admission.
+	 * Callers must recheck before depending on an all-zswap range for IO:
+	 * concurrent writeback or invalidation can change the backend state.
+	 */
+	if (zswap_never_enabled())
+		return ZSWAP_RANGE_NEVER_ENABLED;
+
+	for (i = 0; i < nr_pages; i++) {
+		struct xarray *tree = swap_zswap_tree(swp_entry(type, offset + i));
+
+		if (xa_load(tree, offset + i))
+			present = true;
+		else
+			missing = true;
+
+		if (present && missing)
+			return ZSWAP_RANGE_MIXED;
+	}
+
+	return present ? ZSWAP_RANGE_ALL_ZSWAP : ZSWAP_RANGE_NO_ZSWAP;
+}
+
 /**
  * zswap_load() - load a folio from zswap
  * @folio: folio to load
-- 
2.34.1


