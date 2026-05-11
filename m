Return-Path: <cgroups+bounces-15795-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I7/Fo0+AmrmpAEAu9opvQ
	(envelope-from <cgroups+bounces-15795-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:39:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB6515F3E
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AC1B302A69D
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2DF3A6EE9;
	Mon, 11 May 2026 20:37:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85D3A5427;
	Mon, 11 May 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531859; cv=none; b=sc0ZVl6cm2kKmMFO3UkLj0s8IoKWrHbvquccVhF9z6IZI7yJPT9cA3ml/DENvlF6+CNKPPGvbNarloOzTiUThCipP5drsRi1opm8yNey56v7FzLWqQYVkBYxqiT++Akosnl0EmQeEMNaktL+gQ/U2rbMZ5bv20TJC/hHqB59Pro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531859; c=relaxed/simple;
	bh=3FcJXRECXSVEy1APXMqNZLYMls8NcB/BhmQBZ2z8gm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9fn1cYK63xRLarCKYH9BuQZvm/2P+BU/HP1XQC1yeOcXvuQrzxNL0DGUzRjReIfBpq7/+tHaMNqfHI3zhQyIa7grEVuHSiNVCChkjkVljOgL0vM5r3DbK5KZIcluNzGj5hdJEqyafqqEshihcQd4Lfy87A9UpcGSav0cVzYu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 932A458161A;
	Mon, 11 May 2026 20:27:19 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A2613EC9F;
	Mon, 11 May 2026 20:27:07 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 5/8] mm: memcontrol: per-node kmem accounting for page charges
Date: Mon, 11 May 2026 22:20:40 +0200
Message-ID: <20260511202136.330358-6-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511202136.330358-1-alex@ghiti.fr>
References: <20260511202136.330358-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Cause: dmFkZTGZq0GkJau6RWVth2AkA6mXp5hevURRivnwJLaOUMsROukueZFeGriViT3+cCjdcQdQP0MXVJyz1fLtz5XFi7fYpUSG4G6HGJNwB7Iq+AffJ+iN70qPoWx4sPkTvS8S8edtNse4haP6xRwCWHJvcVy7zsnDElyg9ELyVKHPrzVc71knPq23qOqkwc4KIrg5BHucIt4/5JbUi95cV8eeMKs6lPZKscraThdxjN0ea9JVj3y6puOv/mj1bfUb5Bpth59ONuYJuZ08jwh3vLgdvYEWkwTPa3c1OOv3+xRvJspVD1HTOqkt57ReSG7Uxn9/R/VsgPJlS+GPzNYXtlpAG3mkYTAIM1ioE4A72moamTmDwfzMr293yA/XjueFmhG3Guvd1oXp42UY5s/EBvQlo8IklfJP7ZXgmBBHv0fuaxc5ZSR11W7sTucYe2ULX7DeyKejwLOWYWayEEbOR3QT1ndfJRC1QuZHm68xLVJfc3l1JzkqD75sInVtm6Ifr94ZC9m4m6NPREPzANNw/ZS5Ij0E23LBlB7sFal0c55SCgPUiHxPQWsvBvsA/jSKcq6ujg4d2NpSwuWRiJ+nzKI1wev02q9clqLO1A/AHyW09CrVi+89fOO3uSRKaEcMXp6kHM+LAcs10Whs9m8Q5VqbA8QeXSLwg1J+iFPI8jU33HH2jA
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Queue-Id: B6DB6515F3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15795-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.673];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:email,ghiti.fr:mid]
X-Rspamd-Action: no action

Update __memcg_kmem_charge_page() to use per-node obj_cgroup for
correct NUMA attribution of NR_KMEM.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/memcontrol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 979a847e542a..66d2beb1c974 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3105,17 +3105,19 @@ static void page_set_objcg(struct page *page, const struct obj_cgroup *objcg)
  */
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 {
-	struct obj_cgroup *objcg;
+	struct obj_cgroup *objcg, *nid_objcg;
+	int nid = page_to_nid(page);
 	int ret = 0;
 
 	objcg = current_obj_cgroup();
 	if (objcg && !obj_cgroup_is_root(objcg)) {
-		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
-		if (!ret) {
-			obj_cgroup_get(objcg);
-			page_set_objcg(page, objcg);
-			return 0;
-		}
+		nid_objcg = obj_cgroup_get_nid(objcg, nid);
+		ret = obj_cgroup_charge_pages(nid_objcg, gfp, 1 << order);
+		if (ret)
+			return ret;
+		obj_cgroup_get(nid_objcg);
+		page_set_objcg(page, nid_objcg);
+		return 0;
 	}
 	return ret;
 }
-- 
2.54.0


