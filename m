Return-Path: <cgroups+bounces-16371-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O1aBJxYF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16371-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F45EA2DD
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95BA930621CE
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EA3BE15F;
	Wed, 27 May 2026 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="UeJF5SHG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BD36F438
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914896; cv=none; b=tCXWLCfgnR87LeZ3SbzteyJm7/AkKuP/Aq9V8TFxAlTHWDIEWbYi7dI5ABXIKe+6BqDQcEnfv7s4BA8YLVx7DILHgGT/t/4sWkzw+a/uRpSjl8ULEEWFKsHV44URIu8wBAbrIsI52K6OJfyGTJ8lrciSp6VBNGPZ4mY81eM+XoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914896; c=relaxed/simple;
	bh=twE9vUEfezOAkp4ZHRWC6Tg0E59cYU8YT+AlrQhkxVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAQDIg1C65hrX+7ftX5FDPBo31kqcSZAq/Xm1+L/FBQ6ZSr4FRhCM7eVsostrXD9HKe1ygkFRfhreQf8Ov2mIA8sVPr0wTIK7jMMYY4mW8W8VD0hyV2nxFagE4J7syw6SBQJVSVrixT17Ryl67anSyJO0XupoRHFIT7wGjbop80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=UeJF5SHG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914db83362aso405582785a.1
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914893; x=1780519693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D0XhUH8wxuCdonGZS3m1jXTkJvh4TQTyemwB8RtUGE=;
        b=UeJF5SHGfGQkmPqjCD+y6FwDBqzvYgJH1Kz7iZIvV0wsgLLaiogeM8Zkjdv1sc3Xmi
         RnQjv87UulchFK4yR2ZVB4o8tyNhLvWI5QZ2OKgj/xIjFUNNDLKgJm0v8t1BydaiRIoV
         adLyc8TE7vnZrDHMQUJLg8nFXWfoN265DYvsiClIyPOU0eE+71obGMKujGbr+WVhI9D6
         +wLbuQox5t1zdxz87kX7K4yKJqlgJAxux2+JuGr+8ldiSlgWbL37O1KLhh7Q5327TKqy
         0Y6Cof7FSvAtEi/RcJUkqJp26GhkrZdvbqYGsYiHsQetj177PgB1wYQnnDwFE6mzGQD2
         90yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914893; x=1780519693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5D0XhUH8wxuCdonGZS3m1jXTkJvh4TQTyemwB8RtUGE=;
        b=Q/4ZbeAC9mH40KfRdCcGcc/lR7pymCURXSiOusK6fqoZWzqykFhvEeo+Lz6H/DVPdj
         IFN5cqCLBhaRPOCMxTjS/lSYmqCS+elkR4O4zcYvwX7GF2jxaBQFnh4+X7irCgPbMEIH
         XGKjyn9E6HbOK0pRQvaIIiQOO+leRjcvKYT3/T8Z8VKAlPoMcQHzS/ZSNa/RdL2ubbXB
         61XeArlR0rGkmPq6NfNt1j7QEpI2ANJHuneNuztijpq4QqovTnH70dzzF4d9GAoP9b1p
         sXQaSScpHPDLIhc5BH0r6PQxHGOfi4qu3KnPFSSvIAb62RwcFpkdK1sQL9j4p5ejWFDs
         HoKg==
X-Forwarded-Encrypted: i=1; AFNElJ8le7BOGsgOEvYpDvLJes73T5Y7YkZoJ2awQhQscH3MjjfirTIWnmu3r1AHvHbzack7kMDQnLYG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywax1zxiYbk43iTKgOIDpHdPnOlDRZSCscF/TIUSRMyby2hBNYP
	vWfJE1+LamSOcZZxKwG7Zh2/KJe1CwsNYdIIt4RdsXSLkauMsGcTy9JWnh/pdteXPCA=
X-Gm-Gg: Acq92OG7PZ0Lx67afsChi75+FUNeE9fXXz9YZj7wuYY9OOE6DGNCnA3InvpOtQj7wdB
	sbTcDA62mB4ZR36oocseoi95GFZNIjnLq5WpLYz/UQdX3of36VOe+397Tf4PN/ZQ4VlpxC4+p6J
	TUW0Mdc7B6M4bqUa9Ezl0y5iLpggJrrAxn30kTqr+/L/v1BSQx/u2hSqbV4JjdlL6kFeeKZdpCT
	Q6UZ92x4vjMzZVNWZIBZgtI7VtA6lbqMQj8EypwCgoH04Z+w5RHsFQObUPRHwfRMjfWTGCtrDvp
	8SPiZL5GZcOECp/hRT2A81Zni8RyP31mp8cRR8uxmreMNaHYjaxWRhxEcbb6ymB5EiORCkYCTsD
	ZBPESmekZYs0YinepSGULDga9oiRWNCF5S+MTWYjGcZzv9+8Lr2Kk5mwwCky2fTE69XOkkU0BVm
	+Zy6rjaD4rgs3O1m5HSwosTm3QihyjNaeN
X-Received: by 2002:a05:620a:40c5:b0:90f:786c:4a82 with SMTP id af79cd13be357-914a240d00cmr3496069885a.39.1779914893344;
        Wed, 27 May 2026 13:48:13 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f881f214sm578376685a.45.2026.05.27.13.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:12 -0700 (PDT)
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
Subject: [PATCH v5 4/9] mm: list_lru: move list dead check to lock_list_lru_of_memcg()
Date: Wed, 27 May 2026 16:45:11 -0400
Message-ID: <20260527204757.2544958-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527204757.2544958-1-hannes@cmpxchg.org>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
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
	TAGGED_FROM(0.00)[bounces-16371-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,infradead.org:email]
X-Rspamd-Queue-Id: 796F45EA2DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Only the MEMCG variant of lock_list_lru() needs to check if there is a
race with cgroup deletion and list reparenting. Move the check to the
caller, so that the next patch can unify the lock_list_lru() variants.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
---
 mm/list_lru.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 5497034e80f3..7d0523e44010 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -68,17 +68,12 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 	return &lru->node[nid].lru;
 }
 
-static inline bool lock_list_lru(struct list_lru_one *l, bool irq)
+static inline void lock_list_lru(struct list_lru_one *l, bool irq)
 {
 	if (irq)
 		spin_lock_irq(&l->lock);
 	else
 		spin_lock(&l->lock);
-	if (unlikely(READ_ONCE(l->nr_items) == LONG_MIN)) {
-		unlock_list_lru(l, irq);
-		return false;
-	}
-	return true;
 }
 
 static inline struct list_lru_one *
@@ -90,9 +85,13 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid,
 	rcu_read_lock();
 again:
 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(*memcg));
-	if (likely(l) && lock_list_lru(l, irq)) {
-		rcu_read_unlock();
-		return l;
+	if (likely(l)) {
+		lock_list_lru(l, irq);
+		if (likely(READ_ONCE(l->nr_items) != LONG_MIN)) {
+			rcu_read_unlock();
+			return l;
+		}
+		unlock_list_lru(l, irq);
 	}
 	/*
 	 * Caller may simply bail out if raced with reparenting or
-- 
2.54.0


