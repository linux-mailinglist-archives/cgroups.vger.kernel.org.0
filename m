Return-Path: <cgroups+bounces-7548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCDA89209
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10DA7AA6E5
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556121E08B;
	Tue, 15 Apr 2025 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hbl4yyBt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3121A437
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685169; cv=none; b=fQ/ScsF+iK7qrWVgyeCw1xBLIGIu5KtPB5cNhRKjg3WtxPpGhSK1WXpRL+t7fH9S4HTjQEjFhPKTcG2zkmlEnAI7ha7Vutn37JaEWCulQPnk0EcfCB0u9B2zjRePeHldq/yvuyN4LFpuq6hc96ezPbUHRldnBXh5ZaUc021fDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685169; c=relaxed/simple;
	bh=SmGY8uUfPfu4APqtxCqC7OBXU35g8mxz82QCGYM/o0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSElc3ctOopUou42Lnku/r3Lkb3TVxPgNeYUJeK8aMkoP9a2lV80nRBlAvXcW+jTISu9Aq5oaYiF0VUPDjEXCbS6tcXB3fQaTZ44LLcbYEmYgXlUobSaALL6QH8iBjZUjVSaGLoDSYp+rAV+pOZQe9i/BziRzLaN3gDCYBkLfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hbl4yyBt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af9a6b3da82so3300230a12.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685167; x=1745289967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvWIGpHR+GW9zZlduzgMx/Do9egOoQOFfamShBDZoJg=;
        b=hbl4yyBtfmMe5vGr9HAqp5ANdG+B/Z+HV15Y+4Q48zqDXXWTy0Qh5bYW8syDEQHU6a
         vBTq/zubKEbTrtbZV29I0avu89C6TCvLHLPEeL3C2pcBKHEezszA5myLsV4kh/aVvBbe
         ++mMDcbfe0JtVt/Nn1WMGh+qFC2h8HAGEaz4IfA8WZ6EpJ0ptLx6+2MbENJjPEp7dMX7
         Z8udqVvMrbjV8HKaAmbRq3u0JF/90N4NqziVKrKj429rVSbuMJ1G6+7rbucbhCmMAiZ5
         lzitCQd3mGibykn903yHqMMtCGjjUI+cu6a2Fo2kKLWYFut85bfz7beFFDCOBOjwV033
         +BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685167; x=1745289967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvWIGpHR+GW9zZlduzgMx/Do9egOoQOFfamShBDZoJg=;
        b=v87GGsYyE9lKSZkWjlKy5BDdrwTVy0TE6tHV1+0UvzvQkv+COp6mf3roE+0vpcEK+P
         vooRyrLFt3+ca29ftbf+PuAVs5NTC2wfxMettpJY/r0pa7gPbIY2PWduQgHENszhCvEl
         9sgwtNRq7vwyjBp/rA86GqYG9TUseNUODyAw2SStoAQk0gZpK8MjRo5QGj6tsVJaEo3b
         EIl9dBPQDAk7OVO28phC3yX9fFDdMOidZhZwl8FwDwTyhenW/scxb8lrKD67s8E0S7YE
         O46WWGWMacrpCI1AbIePmEpRuDfAtRUULFkyVTe0FlEt0KxAyX7QVGa+Mh9Ri6O2LM4P
         oSfw==
X-Forwarded-Encrypted: i=1; AJvYcCWjsy8+XCZtIFdYNXyKv0tjB//2ZnI5aDDHWY0DQQeOkLOPRpwcyqvosj5alW/1NUG6nc0Yhfiz@vger.kernel.org
X-Gm-Message-State: AOJu0YxzX69sRq0KjV9RlJWNi/tFqbhx/P5rTJWweDZS5vfr1OI+ZZ42
	L0hn1lBVLmaTx38Hy85DbAgQwWxoPkZdOnehp8/KUxiyIQN4N1Qis17S0YmNnlo=
X-Gm-Gg: ASbGncso8DilR22kWwqhMqdEgJXBg8I3siq7sg/k+G0pOSYWAbUrG5lpAufPSkcDVBe
	aFdIz1w7Yxytrh2V4iHlW08aJ5rVODUwGMe7JllH/qem3ysEtNUUBwb+g27DlShbDcvrLNrtse6
	c7lH57ggwioAio68i1Zg6F3qo+WBPKD8e6aVqXkFKvQLnDfZo/uURi9WxPcjCsi+Qfq8iCgFVzp
	s4XsT8y4PW4GBy/TYhU7HEsS2N+FyimvxFCe98cV51A7oPY9BGi/s0tW3ac/VwCBPBP/DDajR0C
	/L2mmg3QDM9vPDeyAIsz0y9WP7kfEowTn/kCeewnIYbzq0xgIrtFBMNIWuWVN8FI1GfeQFdK
X-Google-Smtp-Source: AGHT+IH8Y9q5TPLiC8967x/6BZ0skn8uSLHYwF2c4d9LznyXXEA3aGsij5atdYTxBM4bP93XVTR95w==
X-Received: by 2002:a17:90a:c105:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-30823676374mr19082580a91.5.1744685166974;
        Mon, 14 Apr 2025 19:46:06 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 02/28] mm: memcontrol: use folio_memcg_charged() to avoid potential rcu lock holding
Date: Tue, 15 Apr 2025 10:45:06 +0800
Message-Id: <20250415024532.26632-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a folio isn't charged to the memory cgroup, holding an rcu read lock
is needless. Users only want to know its charge status, so use
folio_memcg_charged() here.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 61488e45cab2..0fc76d50bc23 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -797,20 +797,17 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 			     int val)
 {
-	struct mem_cgroup *memcg;
 	pg_data_t *pgdat = folio_pgdat(folio);
 	struct lruvec *lruvec;
 
-	rcu_read_lock();
-	memcg = folio_memcg(folio);
-	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg) {
-		rcu_read_unlock();
+	if (!folio_memcg_charged(folio)) {
+		/* Untracked pages have no memcg, no lruvec. Update only the node */
 		__mod_node_page_state(pgdat, idx, val);
 		return;
 	}
 
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	rcu_read_lock();
+	lruvec = mem_cgroup_lruvec(folio_memcg(folio), pgdat);
 	__mod_lruvec_state(lruvec, idx, val);
 	rcu_read_unlock();
 }
-- 
2.20.1


