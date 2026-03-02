Return-Path: <cgroups+bounces-14528-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HeAH7nqpWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14528-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:53:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FC1DEFC3
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40C813012ABF
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B65383C7A;
	Mon,  2 Mar 2026 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="gdaDoVZb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B3383C89
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481196; cv=none; b=JRMMsR3rZCwp+VKlqdiUQsbTveWY9oK70mmVexHW5l5pp5iMPdchTCpNgxxZvrUtSQLXaG1spfwip26/ZTp1m3v6HeC+IfUh7NYLja68ZKY4kP9+sT2VDdv+/gCP19QNiVgeDBKfsYuBHoSxw9yH4vjW3d9qd49q6q/0YM2Nw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481196; c=relaxed/simple;
	bh=xMOOY+JO0QZspES/MoGCVCDt+stnCC4+6jDUOXw23q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS7VJD9zGv4AQYWVl3Eff988H2WuC8u/FdyyBOOEMC975Uyo9C3ZdB0At1rZdoC7U4LNKDvoEhxDKpfBA8UYmc6a/1dxhWVyjoJnrfXz+SXFwcQ24erE0YuQxG3OaUzvu0EzzpSoQuS96QLD/+9STUdukhult+LXtI54P2laE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=gdaDoVZb; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896f4627dffso68352156d6.0
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772481194; x=1773085994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpE/M8Cc0DYeAdsX8W3VyabxBIuEQ5Zyn3nZkaA1QSY=;
        b=gdaDoVZb9pIB8DDyj2ANOlDdYNRy3Vd3zTkGDmF1KiR4/jJXxgC0lHuDfKOjo4TFyA
         pXnu7rzlpVfqilqxw1x1k0y58/Gma+E64DRUuwbWMGhXxR0kvYdQjHTp9sgLonbiV4Nn
         xkWd3X01YTQSyLcWp/of/ZWllniNv71xrxBXDRiCXUc7Uxx8a3T/S+/+Cn3B1mxoOftC
         jSKjM+LYrRaL5q2YOcnvv4KdezJfU21B8RB2/x4bSEOxXDEKKUzUXRkwF+lYOqpzIGbg
         uQxmPi8OXkuidyRvNNFP09wscQaFUv/hAbymk09pPAGv3HC8jb85hRryy2ZgdCup0ORi
         hl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481194; x=1773085994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MpE/M8Cc0DYeAdsX8W3VyabxBIuEQ5Zyn3nZkaA1QSY=;
        b=maGMRXeCAknagql6HtSKJrWpAX0lP3LzKkpZ5Uf9rmO5fThV+ip7Vz+EzqUkI1TbX+
         zNAbhL0DzsCUOZN7JMbARmtsUZoXIebuCAU/M4BaC5GxISL8bSXUDMv8KP5ih9ok31P9
         774CCn72PuvL8Ro3X9/AKTFCmHAmUo+r0ZxJvZtsgQsGj8DUnod8uw7in0TNVy7AIYmJ
         GMFhJ/7B93795JE551jJQUZbd7geKm8m37S9D7ah0Yi/oWb+mYWmDV8MU7Zqefu6bnch
         Cq9UaX0ZxrJBGyhY9hsDvwiHrhVlisobptVlighR3n+f3lbx5DfmGeF7DoMBb70LTZtu
         gqFA==
X-Forwarded-Encrypted: i=1; AJvYcCVndrfhy4hDGpIj43wJxFP93lxIR2TfH5VVuOBX4khbwHWYNoVOJzeHjhBgzrUNEVEptKm+/F4h@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLmrmL7RAkw+lu0IghmExrmrf3ZytC938M0rNnQSr6KOktSmU
	EGvvqpQFXqY6JeeadkUThsKyQ3VpKEPM+furENkWdugqo07NJtDh+QgssSZRo4r8fMw=
X-Gm-Gg: ATEYQzwc0fkamEE0BS4gw7qusqMIwZGPoZ9MP2ucnaQbQf48kolEXhfVlojzqaq6Rkx
	Gpkpf763T2J+IHrpnf60woo+OZzOOa+JbuldcyQpU+FJSjZWKdXxt1EfwQWzFIwMrIsz0EQMxsV
	CkK1/meG2UsgZqVYe5ev3S1SfbRVxoGAdoJS+q8w0cKhjDOcpPLmSH1emjNAO41n/YPdBOPr0ut
	OObOOUlFNFu9MisGWAEIIBdgU/taYaYZCBqBibrS7w52WORRoCWjl8X/9IxLarqCCQUhygUpXPM
	e/3rnIVEf8ZN7BdRBbsGA+Zd3oXlGodyOgXdWUWdSw09dhXFq5ZeiqFcog2dicCgK0GX9Ah6l2b
	63l0PKswiEeLMMjKQtcPY35Aqu8jcFikZet84zqCNWuDjn2MKRuJTLEwM+5+13T0Z9qFaa8bnYH
	xTz+YlZvxZWEV2oF2qjlkUdw==
X-Received: by 2002:a05:6214:226c:b0:895:d97:a2ba with SMTP id 6a1803df08f44-899d1e9866cmr180883656d6.67.1772481194477;
        Mon, 02 Mar 2026 11:53:14 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e53a0d04sm58618466d6.1.2026.03.02.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:53:13 -0800 (PST)
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
Subject: [PATCH 2/5] mm: memcg: simplify objcg charge size and stock remainder math
Date: Mon,  2 Mar 2026 14:50:15 -0500
Message-ID: <20260302195305.620713-3-hannes@cmpxchg.org>
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
X-Rspamd-Queue-Id: 828FC1DEFC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14528-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid]
X-Rspamd-Action: no action

From: Johannes Weiner <jweiner@meta.com>

Use PAGE_ALIGN() and a more natural cache remainder calculation.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a975ab3aee10..0d0a77fedb00 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3417,7 +3417,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t size,
 				     struct pglist_data *pgdat, enum node_stat_item idx)
 {
-	unsigned int nr_pages, nr_bytes;
+	size_t charge_size, remainder;
 	int ret;
 
 	if (likely(consume_obj_stock(objcg, size, pgdat, idx)))
@@ -3446,16 +3446,12 @@ static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t
 	 * bytes is (sizeof(object) + PAGE_SIZE - 2) if there is no data
 	 * race.
 	 */
-	nr_pages = size >> PAGE_SHIFT;
-	nr_bytes = size & (PAGE_SIZE - 1);
+	charge_size = PAGE_ALIGN(size);
+	remainder = charge_size - size;
 
-	if (nr_bytes)
-		nr_pages += 1;
-
-	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
-	if (!ret && (nr_bytes || pgdat))
-		refill_obj_stock(objcg, nr_bytes ? PAGE_SIZE - nr_bytes : 0,
-					 false, size, pgdat, idx);
+	ret = obj_cgroup_charge_pages(objcg, gfp, charge_size >> PAGE_SHIFT);
+	if (!ret && (remainder || pgdat))
+		refill_obj_stock(objcg, remainder, false, size, pgdat, idx);
 
 	return ret;
 }
-- 
2.53.0


