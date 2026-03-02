Return-Path: <cgroups+bounces-14527-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJciJa/qpWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14527-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:53:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D011DEFA5
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57982303A3E0
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C9383C62;
	Mon,  2 Mar 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="d/S0SdA2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9525315D5B
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481194; cv=none; b=QSecOZ+htEDdOzMmbrak/tOv+vquET2IASZKluvBY1NUDNA7sjDmJpVMPlL7rbWMcOmxolZ2ckv+Dl2cthUhI4GfAwApfJFZrgX3Ns+shv+RVtLxF1Jlel89b/TaUGmeBwJtYBFtZ10ocdBLq6mH0T1NEP4k577DkcgGi5ToIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481194; c=relaxed/simple;
	bh=I+F9Yqfxg7lyOH6Y6lDKdBT3X45kJ6gN2c857wyMTEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zt2uoB5FaA8lezBsZNH6RLU7BUXkZBLLa4di+6HPPnA57BD1t5q//zjBDzBLnzuEk18wKabfHvuCeXIRkcrmOtfrln8gOoFbFfv38/U9qzBBV2Q4cL4WHIw8vX46P7rNXooyxmy/EHZvAI712ciDFl/FUODN9x4cHvXXmnqzBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=d/S0SdA2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3825b0fbso466728385a.0
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772481192; x=1773085992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m4nFf6dF08qw2hzXIDF9i+2wZFYfD7fQfBYIdzHPvQ=;
        b=d/S0SdA218kpr3WEz6Jfp4A08F9qCQyZo6qWjiKGVb2TInbyyuzb3p7GjmGO/+ZzlA
         kdTQLFmDSA+z5xkDmOmcwSKXW/6ELLYBkOuwQCaT/kuTndGs/q/oRwPXbSrU6oLO0OUC
         OYS8S9CJc8s9Jq0ajufCdcuj6iR1H4vTvOZoQIrRh3cu+/vmwPzDff6AlulOnxv1ytQm
         VFVT70CH/ANernkwQMoUnmqGLqQaemujiMJXnO68s+KMCn9Sm/lD2wmcA/8hkPiYf4az
         /bfRf0gMK4hQJFkd0GqLul6A58TnQ7EY34xX4lzf+AHu69dG4fIYx/EyP8statVf+FsG
         F3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481192; x=1773085992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5m4nFf6dF08qw2hzXIDF9i+2wZFYfD7fQfBYIdzHPvQ=;
        b=BfbPff3kbvXxE5j2zEz0VRGi1RQVlaHsBpmZ6NoEFQ+5xVYx0211D0oW91d2OEWMbv
         B/Yt3HXObYtmJbdteVKbbUt3jSDJcSe/VTPLVsWvDMBW9+Nxndi1sVhES4cssBrffPQD
         NyCEoU6fn78IbtQ5CbXiik0eiGOuK4f8v+V/A/NXZlVHci94xbw6GHLUe9zhexwmx2vE
         e+yhPCq0hVY+FaXuFEmfTU3b/39UiiH/yZdSO8Be9+NdAH8myyl+w2FPaq4i7Tm/sHxU
         KZk1iUiLaW82CMhudcM3asV+fYWxU/4xLde50oEtPmm8F9Jqoo5TP6yw0YXGdRUTLnEU
         V0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUyV/kuofM/WcRChfzF6lIksOcywqTeZnTTo5aB0IE3lFP46vd2r7qfvpXS2aGfuj67QT7uoDP8@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAxqQA9sc8QZOIG1ajLGRCkz1mbvt43Asj3tnRYOoFWv8elFF
	OPYQenzPjOEXz8wE3xsGdCxUDI55Aje2+LD3HRKWZVZ7/RqJt3X1yPseAPiNaerWKCY=
X-Gm-Gg: ATEYQzwxjCT8ypTTwnPlPhe7u2AEdbzuiJx1S11Dngssw9zSrk2dNK3/nkIu3AqZjJ4
	A2RZkwp5GX5Ep7Agljr8ues4EnzebB8tK5yBT7ZNImkLO2MsX2VkyZHzpfxB09Kfcl/cM9b6UrC
	0zxp4EMsCgcy8KPpFdvZhceYEfRo9NPBn+LcUUI8FXb54Br/nuZqxuUllmFXspBrLWVadLs5jXE
	lt0wEklYjz7wrbdtKF+Y53YwCuIABBdZAPar55GSirAlE9nTVy42eJ1YWJ70946tRCYepIk+WbY
	JGgEaa1PYFBgIZWhB1i2kFmXri4sTy08bFKq4zUvYa2SQ8VwAVPucHiLSwaMMI39qsV4CU6h7PA
	X60yDsTTbl0MC8icKEFcC0rOhSYIkv41KZZbsHLuVtZPhqMKamBPVjkHuCBJ7sjSRPaLH75Oe+M
	g0lBlMQcSu6UKITrFpHwsAYA==
X-Received: by 2002:a05:620a:254b:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8cbc8d7a9camr1778134585a.18.1772481192477;
        Mon, 02 Mar 2026 11:53:12 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm1307822585a.4.2026.03.02.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:53:11 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <jweiner@meta.com>
Subject: [PATCH 1/5] mm: memcg: factor out trylock_stock() and unlock_stock()
Date: Mon,  2 Mar 2026 14:50:14 -0500
Message-ID: <20260302195305.620713-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302195305.620713-1-hannes@cmpxchg.org>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08D011DEFA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14527-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Johannes Weiner <jweiner@meta.com>

Consolidate the local lock acquisition and the local stock
lookup. This allows subsequent patches to use !!stock as an easy way
to disambiguate the locked vs. contended cases through the callstack.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 753d76e96cc6..a975ab3aee10 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3208,6 +3208,19 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	obj_cgroup_put(objcg);
 }
 
+static struct obj_stock_pcp *trylock_stock(void)
+{
+	if (local_trylock(&obj_stock.lock))
+		return this_cpu_ptr(&obj_stock);
+
+	return NULL;
+}
+
+static void unlock_stock(struct obj_stock_pcp *stock)
+{
+	local_unlock(&obj_stock.lock);
+}
+
 static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
@@ -3263,10 +3276,10 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	struct obj_stock_pcp *stock;
 	bool ret = false;
 
-	if (!local_trylock(&obj_stock.lock))
+	stock = trylock_stock();
+	if (!stock)
 		return ret;
 
-	stock = this_cpu_ptr(&obj_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
@@ -3275,7 +3288,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock(&obj_stock.lock);
+	unlock_stock(stock);
 
 	return ret;
 }
@@ -3366,7 +3379,8 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	struct obj_stock_pcp *stock;
 	unsigned int nr_pages = 0;
 
-	if (!local_trylock(&obj_stock.lock)) {
+	stock = trylock_stock();
+	if (!stock) {
 		if (pgdat)
 			mod_objcg_mlstate(objcg, pgdat, idx, nr_acct);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
@@ -3375,7 +3389,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		goto out;
 	}
 
-	stock = this_cpu_ptr(&obj_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
@@ -3395,7 +3408,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock(&obj_stock.lock);
+	unlock_stock(stock);
 out:
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.53.0


