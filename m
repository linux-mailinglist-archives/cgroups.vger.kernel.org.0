Return-Path: <cgroups+bounces-16168-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOc0Mo8tD2oiHgYAu9opvQ
	(envelope-from <cgroups+bounces-16168-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 18:06:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155A5A8E0B
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E97833B61ED
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA2368D48;
	Thu, 21 May 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="hiS8Hizj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605A3672B1
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375830; cv=none; b=q6puz9PGAo+dngIFS1+HdIvhhZhVFsqmc5cOnh9qy02FvWUufR8i2jAfgohbRuZXPDdDQJ3mph+vtQOq54oA2h2L0MoYK1yvBedDstBut/4KzAxEg2y8hLvAW/vRHaUDwgzVr+IPQBhtx1o96M6XKXUT4ggM0x4A7QoMC0jXjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375830; c=relaxed/simple;
	bh=0c1+pP8SAG7u+WBWdlkZnBVO4585VjMZzm3levEOLwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcMFo1wXeODzchrSCvBAXSZWx6db2KPxiu23uxxdG7sVtkh3b3NWtLRzT5PCPIOqlIABH2wr0gdm27giMazopJ1Qj0ZWPcfqwr9vtg92wIQD3BU5sAgxI+YxgVMlIS4oG784M8xm5FOJv6zChi2w3CuBj248+jKIoV2HN2zlN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=hiS8Hizj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90b2fcf90a0so871224185a.1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375828; x=1779980628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJv7QOlxyTdHx0IQuT1IvjERhQqwxSN8j0WlihPGf50=;
        b=hiS8HizjDgDC+cgfCUmN1YcM4hJ/xRmwlwKHYzRrYmFK2CIki00iFM6eM+/B6AORNo
         jyYbQusNCa5Hy3hPmrHr7LZtrdp00HzYEq/hz71NIk11dob8AszeYC08EJYoA0e4es/z
         GYhmCtFwP7YkkjwDM9ik9cKqoFlrGmOckjP9Emx4fJWkPpxboS2O9UUWQcMS3247I6ax
         X8kl+SkegB1e2ReZeGpqzkjRBdDDUyEg09t8SQcoUDPVGbIkzRe3NyMM4LCtik7UcsLE
         V0S/broZx+ZoIJA/qfNG+eqpFftVHNfSeG1ObZ+1YTTfEon2nw+sbfPIvRFd4Ek0qNwl
         szPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375828; x=1779980628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJv7QOlxyTdHx0IQuT1IvjERhQqwxSN8j0WlihPGf50=;
        b=im9yzO1QQhT6gQ9IrzojNufcM+9MSEExS6+0Rcr4FkY9HoseZzvREUhkXJ8PVmfjql
         AEkkSA9qszJq6g6WZiuR1g4NurWLmCNrFf9Jg98R5Q9OQKLzcJ7LfCJbe8CHEvjffx8a
         vVnuBoANtqXLWdRcaskHsLGLQLZU9tNvOrM4dWESXda4Z46YzBqA+m2TlEb68l5IcdFz
         GX6Pm4nljAP9KL2lexNsPryFIu4ZYRYok26w+vfhqZoeU/T9jpSsIq0rwKty0yq2KQIZ
         9hN+1aL9u16Ylj4mMocJ9Khc9dy/DOByXpW/kzIVaeC2qer9Iq/7COPS+0WWfThNitXm
         0wCg==
X-Forwarded-Encrypted: i=1; AFNElJ9xLw+99sE30DQ+aIZxIPcJeCwLIRWS3VdDlhNjJqGzRFPH8ABvt3vxeGpsHZxAgsNN7gtm/tf0@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdCz4oVnZEKV930Iv4k/Bj04gF8kQEQX/J+4ePx1kP9V1PRO+
	GRKqW0jiOSqv0o6DGYzTpjLUrWXQSsREa9ennREdeVasf0wzbZQJUvyOBpL6UkR4OMk=
X-Gm-Gg: Acq92OHaC4GMJFrv1ZVfBo4AHAr1oBVDLA0QcZlABvOr6Fl5IKH5mwT/hgjLcakPXvo
	e5SGFef2Mjh4JNafu0LrLips8/xZCMudpVlMvhFmigH08Q4iAUj2a8REwuaMXmftYc9IfpFp6cu
	sk6geuXMzVtFEHC/BmP4dpHPvb+3kWoqBIb/9cTXTBSambvmidEu3JkjUnYhTWfpQGZLVAqRJVs
	onWXxRixow86KWFiZfQfktZuwi9Lh8sY/UCRNf8Rafo9bv2EbyB+YtbenZgMUrMg0IlvWZFSiXU
	YXJJybmc4uSCXcDr+IBus/LwAhjhyyghnnnsMGiw9oHW8TmECkKiA+eow9UGmbQx0Bg7Oi3hx0R
	Eeu6wUghCqOLG+sC4vIw/L4wSuXL9gKkQvs7rwTJn5fAnkr2OlVXnaIhDBjlp+lN3AwGAX+F1qT
	IcA7aMvdqkeFusXUc5gQd+ZlLUM3Iiao5e
X-Received: by 2002:a05:620a:47ae:b0:914:a824:6695 with SMTP id af79cd13be357-914a8246d0bmr214593485a.37.1779375827591;
        Thu, 21 May 2026 08:03:47 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914ab9faed2sm114273485a.6.2026.05.21.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:46 -0700 (PDT)
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
Subject: [PATCH v4 3/8] mm: list_lru: move list dead check to lock_list_lru_of_memcg()
Date: Thu, 21 May 2026 11:02:09 -0400
Message-ID: <20260521150330.1955924-4-hannes@cmpxchg.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16168-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 3155A5A8E0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Only the MEMCG variant of lock_list_lru() needs to check if there is a
race with cgroup deletion and list reparenting. Move the check to the
caller, so that the next patch can unify the lock_list_lru() variants.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/list_lru.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 9a68177619bf..9da6fce19832 100644
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
@@ -90,9 +85,13 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	rcu_read_lock();
 again:
 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
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


