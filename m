Return-Path: <cgroups+bounces-17694-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PHcfKCWqVGpNpAMAu9opvQ
	(envelope-from <cgroups+bounces-17694-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:04:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21E749163
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:04:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="tH/Ef7uL";
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17694-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17694-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D151300F5C2
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405C3D0914;
	Mon, 13 Jul 2026 09:04:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747133DD508
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 09:04:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933466; cv=none; b=Ub/0nBQHKvIbrOkqkSbAA2OgC9TuVyjQ3Q42a7WMWbR/9HGo8+PXEp/UmJs3IOh1Z2d+IKrpUcxJIzrLaYEdUqb9ngrh5EiXg6cvr3t3Ku4M+QLhneHTnP84o54LMv4W8ivGQsOaUiOb+fmk1ujFQ1bKoyaz9MvJKUsNg7VLSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933466; c=relaxed/simple;
	bh=Urt5wCDpVSyl/Js+pD/Iu87p8GwvhbxFGKzjla8C8C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rayIcuF12cdm0PVez1xkz5Bk6meqv4A6vBbTC+m8CY6GM0SFp/MCKsI11ie24pa8qB9nuk24VD3kWv5CJjnWI8C3QakOuO5Ruxy1XxtSSZ8jSDUDl6IKcQ5yC4i0FZxOii4jrpXuizyu1JjkpxRHoJvn6st6s6w13xUJ+b4NtjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tH/Ef7uL; arc=none smtp.client-ip=91.218.175.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783933452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k7pIu+GwSXbzd7/h5Hc0V60GatPWQdzqkR6KAvscHwA=;
	b=tH/Ef7uL2uQAR1yPyzTDywxVIArHSl57v4dm2Q6ALV5SZ5oXVIHfNp+APaWF6gi1T021Cp
	slFXbFki6xLEv8Zlor9TSgiLNN0HlPy5F5xZoDml750bS4Cjvdq3Oo//JEF+CJuM7vhKn8
	EHDmyGPGpCLjJMTuL4bXJp5DCd2KqAQ=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] mm: memcontrol: factor out memcg kmem uncharge sequence
Date: Mon, 13 Jul 2026 17:03:04 +0800
Message-ID: <20260713090304.3015329-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17694-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A21E749163

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

The kmem-uncharge sequence (mod_memcg_state(MEMCG_KMEM) +
memcg1_account_kmem + conditional memcg_uncharge) is duplicated verbatim
in obj_cgroup_release() and drain_obj_stock_slot(). Factor it into a
small memcg_uncharge_kmem() helper. The reference get/put stays at the
call sites, as they differ.

No functional change.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 mm/memcontrol.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22f55aeb94f3..86acfe55a201 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -137,6 +137,14 @@ bool mem_cgroup_kmem_disabled(void)
 
 static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
+static void memcg_uncharge_kmem(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+	memcg1_account_kmem(memcg, -nr_pages);
+	if (!mem_cgroup_is_root(memcg))
+		memcg_uncharge(memcg, nr_pages);
+}
+
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
@@ -172,10 +180,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 		struct mem_cgroup *memcg;
 
 		memcg = get_mem_cgroup_from_objcg(objcg);
-		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
-		memcg1_account_kmem(memcg, -nr_pages);
-		if (!mem_cgroup_is_root(memcg))
-			memcg_uncharge(memcg, nr_pages);
+		memcg_uncharge_kmem(memcg, nr_pages);
 		mem_cgroup_put(memcg);
 	}
 
@@ -3329,10 +3334,7 @@ static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
 
 			memcg = get_mem_cgroup_from_objcg(old);
 
-			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
-			memcg1_account_kmem(memcg, -nr_pages);
-			if (!mem_cgroup_is_root(memcg))
-				memcg_uncharge(memcg, nr_pages);
+			memcg_uncharge_kmem(memcg, nr_pages);
 
 			css_put(&memcg->css);
 		}
-- 
2.43.0


