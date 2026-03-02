Return-Path: <cgroups+bounces-14529-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLe0GnzrpWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14529-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:56:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B914B1DF02E
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F01730B61D4
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF73112BD;
	Mon,  2 Mar 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="BLk9JKh6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7A383C82
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481198; cv=none; b=HjAL3Yp1OZErX35wTdevkvotUALZd09mFA69hYXbBnsHeqozUGQiMLf25UTDsX3n4klNtTd9BH1NrBTYw/yeieWTP8sm/7OPFdevK7TSR8wkohfi3PaLv/j2sd4SygQU8yqWrzWIOhq/AGY/XIbhjKp7CLVXxGuokMm7vQWuufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481198; c=relaxed/simple;
	bh=WXSj+9QejVVwAbxgamPZUuinqhgHMtGM4UaQbMwBBKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP8wjCWAvJLMVXXTbt+qcSK9/RFPddL0A2FVD7kXTX+jOSDUPVANqGMeqVXt5Vmr4ya0GgkJIguO4mg+v/nFpYCmcGIpiUQgr0U2qOp0c/IRkDjEDn+AlPkuxIi7Czdqyf4136YGvXIMfQy5RNp+fC/kbxy43XShSc4cV/6Y5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=BLk9JKh6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb38e86cf2so512341485a.1
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772481196; x=1773085996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SxQ/eLtCsKDNFbOz1QdWcfhbyrBVWfPJbSjku1OsMI=;
        b=BLk9JKh6cH5ymvXZgtiwZtIaJiyPJ+bv2tvqf1uDd9Rm6h0AOMzjjMfHctF8d0bMzE
         ce7x9aeo5ebc1n9Gty19rxSf9aTsyFwy+o9lYAuKvYKSZJxxEbKeJuC+p/9WkWReftMs
         2QcaFDMsM7FXJHiv6htlICaP0p8WkokiG3/5fH+G3r+mWvdKCkcg/UKdfTB8MgJUNPYS
         S8kQ0S6lNAgBst9sm/yXQRF500httNBcBzfpCTxe5DpVBsUGbELw4gg9egdfS3t4f+Gd
         xB70DJ90JjqlDS3nHfFxBK8FRl2mJjUT01PAsemzPe8cochrU6/NZDm4T/6weZ08yTmN
         8Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481196; x=1773085996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SxQ/eLtCsKDNFbOz1QdWcfhbyrBVWfPJbSjku1OsMI=;
        b=bqXiSR4e/hBSX6IvhbYNOkhG4H4t98ZFSUG9jhbpxB8ZYm/cm1A+9IYeS8GFd7mFMx
         KuHPqoLmB2EsiduykAxrY8lPAmtFBZ54DJbfDoTXZM3YMXbIBjPD8Tr0stH2m8v3Jrtf
         cHjHhu00ajbH4JRFV6WDm8dyEBOJ/cV1AeyY/EDM/XFscQTzcbALYpzjfS4eyEyi7X7+
         x46Q3bFxeocoTuQd1NeKm8/J/+For8KhXGmFDJZMCaGNwCsTyVqSms9myPAYQPQOm4VT
         O2yDtzC+TVBB7RTD7+ra/A8I+PsBFk5dOJwUE/GgtmrXCVHk/+FkwCmt3tXeyjGe0JDj
         1ifw==
X-Forwarded-Encrypted: i=1; AJvYcCXtWDXe33wgfoQ0iazg0KmfEnvzc50Hk0OW3IONhl0wmHvaBymine+nQiaatnXNc0Aaj+v3ZvcX@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGCqCDT1t8KKI/6zMl3QsEE5Rz0YbC7IHHAioaCEWxTYIh9DM
	P2pbIhckmLqQXouywbTXC/LEOaVCearbv9WeevFj+obv9DDGJxzJUFgKlMIZRezzQlU=
X-Gm-Gg: ATEYQzwClzV/Cwrxys0r9pbeiMnt0YsM4+BHVyf6dLXg4Py09TMmUT1Uthxt+x74CPL
	H5xVmDN9I3OqHygGHyxra1TEKHYAmfjJEnJw5hbxBS7viaU+o6RCQEbf00X714kB5TiBCmQZAWm
	/9asJkAFbMibBhVCu4jsBsFft22ejwqiFBvkmWNgSYBsW+0Cm8iLLmRsGXs82vzEnAK004rMG+c
	/Snlc/3xZ77h5YiQd2yDMRBl2gJ+v6k5BUzmIfT2MEf2TAr7RXHEs7zbnRiG+YC264tJKAmntOQ
	gJLjvQpaWQec9C5C+nK88GOpleAP0k13wwFhBRSGlV6CZ9xCl15dHOb2B+sb2oWkHCeZvD6vAvj
	YN8FgItkYlcctPd77DyUbxBzfLXnCoKVFj16GyUTKiCNQwIqVsP1G+Svt2wLIZg8CvyjxYp1B8p
	J4heYHFV2gC08gj17yYK1cIA==
X-Received: by 2002:a05:620a:400f:b0:8c6:ff02:d825 with SMTP id af79cd13be357-8cbc8e03048mr1741310485a.48.1772481196370;
        Mon, 02 Mar 2026 11:53:16 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6535b4sm1217544685a.9.2026.03.02.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:53:15 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mm: memcontrol: split out __obj_cgroup_charge()
Date: Mon,  2 Mar 2026 14:50:16 -0500
Message-ID: <20260302195305.620713-4-hannes@cmpxchg.org>
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
X-Rspamd-Queue-Id: B914B1DF02E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14529-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:dkim,cmpxchg.org:email,cmpxchg.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Move the page charge and remainder calculation into its own
function. It will make the slab stat refactor easier to follow.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d0a77fedb00..32c09b4d520f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3414,10 +3414,24 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
 
+static int __obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp,
+			       size_t size, size_t *remainder)
+{
+	size_t charge_size;
+	int ret;
+
+	charge_size = PAGE_ALIGN(size);
+	ret = obj_cgroup_charge_pages(objcg, gfp, charge_size >> PAGE_SHIFT);
+	if (!ret)
+		*remainder = charge_size - size;
+
+	return ret;
+}
+
 static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t size,
 				     struct pglist_data *pgdat, enum node_stat_item idx)
 {
-	size_t charge_size, remainder;
+	size_t remainder;
 	int ret;
 
 	if (likely(consume_obj_stock(objcg, size, pgdat, idx)))
@@ -3446,10 +3460,7 @@ static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t
 	 * bytes is (sizeof(object) + PAGE_SIZE - 2) if there is no data
 	 * race.
 	 */
-	charge_size = PAGE_ALIGN(size);
-	remainder = charge_size - size;
-
-	ret = obj_cgroup_charge_pages(objcg, gfp, charge_size >> PAGE_SHIFT);
+	ret = __obj_cgroup_charge(objcg, gfp, size, &remainder);
 	if (!ret && (remainder || pgdat))
 		refill_obj_stock(objcg, remainder, false, size, pgdat, idx);
 
-- 
2.53.0


