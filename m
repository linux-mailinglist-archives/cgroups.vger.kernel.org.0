Return-Path: <cgroups+bounces-16167-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJyXIUcnD2paGgYAu9opvQ
	(envelope-from <cgroups+bounces-16167-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:39:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1F5A8812
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C0CF36A88E7
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC63672A9;
	Thu, 21 May 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="gNbx8Jg0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5273655C4
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375828; cv=none; b=omct5y4DTaUMbEDd5BuTovmVLYJNlgtTMaYDo66XGOECCGc1l1mng2tbjP6d1RAlaObcPa8Tm557QqNSmKh0Lov27PrUWt86y6hOUMUADxwBzzUNHKkxhr7wNMpZ6Y578kUhipNsQSR8tsc/42nlJjFIIRn14Ru1xsl54esGf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375828; c=relaxed/simple;
	bh=7vbHWCiV+CF1x1UjKtGMwHGjchNHDlG16hVGTCF4ge0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcN1sg25/FUdMZA90z5kfXbDCP3257D8UBw61DeyBYujhIgHv1U2toARSYv/2Arwd850tEgvvkd7ANbcnqiLjTvHU8CVORlZ70CGeU9zJU7N/ZVcxQZi/OcBtz6wxJAUXym+MeTTmKYGAhCaYOuiZKDUtYxtT0qdn2c+tbIMTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=gNbx8Jg0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516cc5471bdso6790941cf.2
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375826; x=1779980626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn9mXwqyXlTnHz6VCNHiXrEOY97snOle2kaY6Iy8PrM=;
        b=gNbx8Jg0alMVz9JNUPXbPoGIZ3SHR5Jro41ueL12iC3N0cugFsxoj5gN15arKmwObG
         DQZ5cBwNdLrzKbY4YOivqpHx7Qq1PIJ/kpKAy+2Gp53pkyLitjiafP0ggaEjs2q2hrQS
         fDlTiBKyDN4zweU4Sap6EkZL60Z6Dd1HxUJe3NXLvmQOgrXwv5S1/kfdtfScRQ7SJpqD
         scVUjeKp8cAhSRUhHAg512oQ4TDei0NX7gXEV+ZY/TUSpCuRAaey3+x2jKC1xrmBBjT1
         N1SEIlEtbN832hogAMHA+pxWy2JLVfzYNnfE06YwDBULRtBAXIaXc/9R0927RfDffuNi
         49wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375826; x=1779980626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vn9mXwqyXlTnHz6VCNHiXrEOY97snOle2kaY6Iy8PrM=;
        b=pLwk6l02svn/Z1V/kHNyouMTMJjtQtgR1YYn0RZqInw3FQDJAkgDDFJatgpofIMz2E
         9QnkdOgL+HKjoi/Kq4a7Lqv1dwyJSa8Ht9MExNtBCQ+wtDdaS+iI+UBInLGv60GGe65I
         oy8BNI7WveOpbBOFpO4TbwGjuAVMQbcaBLoWKmw+92Mj36FP26qVfpZHjeS4mMQUYPnk
         exobfIuUS6gHWtdOLXxCkJzMhw+6osv7g23XIZSI4+vgPjlIJ75yif0VGbIqjsZdUCYI
         97GYNjqO9E3EPcsalVn5ZhfRNdqjRoKaVUmS5GSVDQVEUzvPBm8HXJVUmWLxrOdYKgfR
         thfA==
X-Forwarded-Encrypted: i=1; AFNElJ+86TGjeUGi3Eh+ngYWGNO/bFf8BITrOlrSMVnzgJnaowHLalQRq9X4Nq5pT3qpRZIWR3f2prX2@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaje+K/C2GrGiyDH/j5l0ifr57U6mOXQVay5Gk4laKwU2MEnz
	OMp6NOAIacTDTchxh9ln9W6w8YVMHhiG4jgTwrQpH9nXquLWbaomHoQNGLa1FvlO6x4=
X-Gm-Gg: Acq92OGHCXnsHSWr/cuVRBu2sjA4qt6bLLuHo0tPXJYhT/sJarZSLBXn5r0RnHw1lfK
	nKcCt2Y8fI96WHyNFjygJ/uaBx6ODq01fOnpyDJ+rwMcT7bb6avsjWvYDGxoHcFg74fKygu6FF+
	mJwz6FNuo7IyqOaCSoBRIh2uL/zwMgZVqomQpiKLkMZPUgP8ODRcMNsgwi8YjdeShNpUQigpMFr
	uqYsEZVn6yL1G3a5o5PEM577fKY/y2w/Blnctj/IHd/38hsrYhbg3sUb8pj3fMp5kPhWyfJ032C
	MwMn611xQ0N+rF2gixEAoK+g7q+fpDoZGkQbhsQ4ebli7YCBsThD3CfDcr89sosRH8dHG0+iE5B
	5C0koEFy/SlPRgkINKZ3d6WEOeem8Rz0gMreH8w7gsTX7IQ7qPjJ/eyKYgTpcFQi4vj4J3fOJZF
	TBAX4NcM/61O4R9ntqWPhUsQ==
X-Received: by 2002:a05:622a:4296:b0:4f1:ab79:fb18 with SMTP id d75a77b69052e-516c54e89a9mr45144641cf.25.1779375825779;
        Thu, 21 May 2026 08:03:45 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516cce01aafsm8868781cf.21.2026.05.21.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:44 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] mm: list_lru: deduplicate unlock_list_lru()
Date: Thu, 21 May 2026 11:02:08 -0400
Message-ID: <20260521150330.1955924-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150330.1955924-1-hannes@cmpxchg.org>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16167-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 01A1F5A8812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MEMCG and !MEMCG variants are the same. lock_list_lru() has the
same pattern when bailing. Consolidate into a common implementation.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/list_lru.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index d3619961a7ac..9a68177619bf 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -15,6 +15,14 @@
 #include "slab.h"
 #include "internal.h"
 
+static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
+{
+	if (irq_off)
+		spin_unlock_irq(&l->lock);
+	else
+		spin_unlock(&l->lock);
+}
+
 #ifdef CONFIG_MEMCG
 static LIST_HEAD(memcg_list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
@@ -67,10 +75,7 @@ static inline bool lock_list_lru(struct list_lru_one *l, bool irq)
 	else
 		spin_lock(&l->lock);
 	if (unlikely(READ_ONCE(l->nr_items) == LONG_MIN)) {
-		if (irq)
-			spin_unlock_irq(&l->lock);
-		else
-			spin_unlock(&l->lock);
+		unlock_list_lru(l, irq);
 		return false;
 	}
 	return true;
@@ -101,14 +106,6 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	memcg = parent_mem_cgroup(memcg);
 	goto again;
 }
-
-static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
-{
-	if (irq_off)
-		spin_unlock_irq(&l->lock);
-	else
-		spin_unlock(&l->lock);
-}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -147,14 +144,6 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 
 	return l;
 }
-
-static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
-{
-	if (irq_off)
-		spin_unlock_irq(&l->lock);
-	else
-		spin_unlock(&l->lock);
-}
 #endif /* CONFIG_MEMCG */
 
 /* The caller must ensure the memcg lifetime. */
-- 
2.54.0


