Return-Path: <cgroups+bounces-17252-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lrPQH9MjPGrEkQgAu9opvQ
	(envelope-from <cgroups+bounces-17252-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:37:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB486C0C2F
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:37:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HRBoEgkD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17252-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17252-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B7AF301AF68
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD8325706;
	Wed, 24 Jun 2026 18:37:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B83093DF
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 18:37:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326224; cv=none; b=tmtJYMww8Pp9wOOwLNO0bVHjDgfz5fFzTo5CFYTVj0V3spBdgEOk8+VBGIHRFoQzU9gkPrYi6Ns0N52/D26X5nyOoIhGFWx9Hpo58WqFIQsDwPxHwVWbRd13wIzdirj1+bb6xjv3/0ADAQ9FH5OPFC65oWzl4xX+k0Rp1DiRaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326224; c=relaxed/simple;
	bh=7xHrhPBm1lpdFCVAuHbPY5cWums6C3fM22yPL1LSm68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYP3IiztD9+PiC3LpsD4m7DV9pvdK2t3zN7rRwbAdIJ8SdM905W8lcXzWJGdu8koFXlzNgqAv9LX1ez+w6FeVewPnk3g1LYauhkmd7jnjPRHT1xz/nVjZZPG9V9cDkupmveAzKBp0CkeFYlVGxNMmKurWdy/e6H7Y1ERC8k1dLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRBoEgkD; arc=none smtp.client-ip=209.85.210.48
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e93c3f1717so647953a34.2
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782326222; x=1782931022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbWIs/KwOpEaTVlvMb/98rnTZb76+gA0HeQzfXkUtFM=;
        b=HRBoEgkDLzx1sauImSgvXFB5iCBGnv2MAyTR+znQW6LsMP6hJQ4E+/jP7hzTub+V1N
         e9NzjE1rgZsy37HtWOZybZT7SNbXfH0mOeA3zLwe32FYs4ChvpgiTk5JfTVAK/Y8Org2
         anhIgqHcicE2/JU2gTkyNKuxaAkc1hJuujWovSG86z9sGELiMHyEmdH5cgMMV/YjBUJv
         eeDKf1jA49X+dLhzVZeyt0pQyPc0dBDYjjNMFOOEaNvWWWgJQmEOcQXmalg5rOwe57pj
         MAMmE4/xyn9T9QxHGV0yOPEW1rhZZLwLCR5+wGpChLH81dFmPZ4Gm425Vx2y1BT/S+Zu
         ZuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326222; x=1782931022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbWIs/KwOpEaTVlvMb/98rnTZb76+gA0HeQzfXkUtFM=;
        b=SqAe9DfGg11HssoeTVJyvobSvy1EGQXlrYAhhBZ3M7QYTNwJdTdPMcjmyeM9Cb3vhH
         xIPWeRCrj2CJRN1RgBg6EVOC4HYUrmN3locMxFGh4BgJyXQY9yk6ZzMXhw2U1CauEihc
         j/hoK29pOE5jTHf7YdB5j6aBsA0kO1h7WDX9/m4kE9X6y8hE92SeOzpI+taQ6MrfS6m9
         xEw2XIjFvw37ybjgoQB7mSKvXpvqXt2J+099hSz2tS5x4LzQJOzMj4QPKsqvKJXNKhUq
         fJF/kEoib3ie0ugqyKMabWGQDJg2FyDS+n1W3VyeFt7s47wgAIaGWpSDvFi7aoqE/BLR
         aDcg==
X-Forwarded-Encrypted: i=1; AFNElJ/KtqLBzx0GkPAdWV3esl58NHPlGSFKlHMD8MMmMLBnL3ZLcbRMV/dc7n1PnmBtV4a5i52Qm+/v@vger.kernel.org
X-Gm-Message-State: AOJu0YyzM+49mRIySm8G7CSfQaKxQGpdYTf/LBtrm47LZoxXdnLPpIed
	KAFEcjBS+M0o8+VqMo/QGSwj9JQ96W606f87MrCAYNPE4Yq/JNsz/9sz
X-Gm-Gg: AfdE7cmOymN730PYS4yyUKAQv5z5pmrQNr4fFYi3b/p7HDsS0+mwaz0kyTr815QZMx6
	CmzrM/D2wEWqkW7fZxv8/tkV8Ci1W7w3WTxg3gT4j5TOT91i+KINZM2g6RpqU/Kmlfw0Uhy5Do7
	W4XCPCLBovbLqKdUW6DLjLpeth7j0j7YN0o3kAUucoKY6o3o2Zo8Eg3GYxE4vAgCdwP+6+LrNXq
	HTLOCC/EzVN22p1y7HntL9RnEH35ZuebASP5cf2I56PDnRHfVS+HxoBsS4SUip4L33furhunX7S
	3cyKWUrMMOiZA4c0ZXimOzk7bX7jiHAl/8cclJ6+KolYYRkqk4TNaTkYmLXV7ZqQFOflD9mS3of
	xzNzIXdgPsqUuQ1QNdcKJ9cX1pAumpqj/+H2WBbUgICz4RoxMk0xNnKAidltDs8+XEh54AEKn2e
	Fis61kC2zHfu+G/bgEkhM0nr3FGZvssCQIaDvDsAkxjA==
X-Received: by 2002:a05:6830:6412:b0:7dc:dd19:7f69 with SMTP id 46e09a7af769-7e97949c243mr6906170a34.17.1782326221861;
        Wed, 24 Jun 2026 11:37:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944252015sm11789254a34.18.2026.06.24.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:37:01 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-kernel@kvger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] mm/memcontrol: remove unused for_each_mem_cgroup macro and cleanup
Date: Wed, 24 Jun 2026 11:36:59 -0700
Message-ID: <20260624183700.1152742-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17252-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@kvger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBB486C0C2F

Commit 7e1c0d6f58207 ("memcg: switch lruvec stats to rstat") removed the
last caller of for_each_mem_cgroup back in 2021, and there have not been
any new callers since. Remove the macro.

A comment in mem_cgroup_css_online has also been out of date since 2021,
when 2bfd36374edd9 ("mm: vmscan: consolidate shrinker_maps handling
code") open-coded the for_each_mem_cgroup iterator. Update the comment.

Finally, 99430ab8b804c ("mm: introduce BPF kfuncs to access memcg
statistics and events") added a second declaration for memcg_events to
include/linux/memcontrol.h, duplicating the one in mm/memcontrol-v1.h.
Let's clean that up too.

No functional changes intended.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
This is intended for the next release cycle. Thank you!

 mm/memcontrol-v1.h | 6 ------
 mm/memcontrol.c    | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index f92f81108d5ed..d3ed5b93290fb 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -17,14 +17,8 @@
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(root, iter, NULL))
 
-#define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
-
 void drain_all_stock(struct mem_cgroup *root_memcg);
 
-unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 int memory_stat_show(struct seq_file *m, void *v);
 
 struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56cd4af082326..e171fe36b0711 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4216,7 +4216,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	/*
 	 * A memcg must be visible for expand_shrinker_info()
 	 * by the time the maps are allocated. So, we allocate maps
-	 * here, when for_each_mem_cgroup() can't skip it.
+	 * here, when mem_cgroup_iter() can't skip it.
 	 */
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
-- 
2.53.0-Meta


