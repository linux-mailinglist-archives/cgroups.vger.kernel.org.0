Return-Path: <cgroups+bounces-7551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675AA8920E
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C7817D2A1
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505B2206A6;
	Tue, 15 Apr 2025 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iPUM5rEr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D032206BC
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685184; cv=none; b=b7Ran8n9ovXBLEYTiynnMj000oLOm4gmbDf09zRhWuaZ25hNw0fL24RNQRgKVfNgFj2Pq+slkXcAQeaRyVlCqGcyES0FmFOfUpD1x7W1R/+cCiBkX8/V40OGixIRjMa5AXTci/4Mk3mUo2otSfITdR4h77y1aftrHfzKB/AubiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685184; c=relaxed/simple;
	bh=hQOJab4kVrFQvrssWHzPZOIBnHti4kboAWzr5RL2/NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hyIlJeUmaLDCrID+In5YMwVbl945yeKHDzqHdsuKNEvMRbcAVtuGMMIGg/gcUNTZwVALUClthtBSzjau4yLsAiHTu/Wheaq4dUyLMCwNB6977Uoi0dHkSPeR5UuAlwCv2zY0CPjuSc+egjkRKaTgXOIKK5K6sUIHfNrc1V34q4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iPUM5rEr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2241053582dso69114475ad.1
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685182; x=1745289982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HknBZVJEEwldsJF0essNl26exDom/3YV3flikzCNEqI=;
        b=iPUM5rEr/GGKMpqJ3O3V/CgT/8xGPNFm2D9Dk5Lbl1S/JDn2b0Vrqrrupmn6ScBgUc
         OQAn+tNj965RFcbbOSd4/0kXpvNZPsECiPL3P0DSPLTgsYDHTGC4CdXhmMwiSpq+ngEl
         fxT+GlQguoMrEnDoDZidaIidCX0Ep2qbB2eZEgOB8p25eIQu35U0TfrgBTA5IlgJPlna
         vzAIKjRLlUTGzqYm3sDpspbZ5E0S+yytWuhm4ixC/7ev9nZuQMDdFFquok8F7nM1wPNG
         uyKoh+MFLq80mCig10xfzbILSxSRsCeoo4LUIy+fPV05O4agQzsex/S1h0A9t6NZPaBm
         rd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685182; x=1745289982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HknBZVJEEwldsJF0essNl26exDom/3YV3flikzCNEqI=;
        b=t0D+TcuWSiCBKa83at2oiPtcT6Jqz7tzKqymHRGk1IHFMMYLQn7m8kvKekXvZhLjUZ
         fNvsRquEd5TWBJh77lgwag+jM88H//ERd0Ax4Bm/m8Y7/NwPBqE9ToDDs9eOmy/pIxw8
         t+JiUBqCICyj+lxwdn85Ev+pLN7G+3xVfVMcM+1PK9MYIUVfsUw8j9Cs1cj7Qbsi3A8x
         YUMlvr+XkkAYpOY1xPtOKkL7w9XviO+44oIKK8RElbKkp23Tdyveudt7USvPZ64Zd0E+
         wqKk3f2Gf0nyjgPbGW3co8E6CVuKGGay32YuNQ0SfWBCFnOCgPqtkljBXPG7abys9slE
         fYIA==
X-Forwarded-Encrypted: i=1; AJvYcCUdVRsf1wNxHlrmmoQW7pZ7chWMi2plkAhV7D2erpoq4PAjmfH92d321rjJzo0YvT157HkMSybN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfj3cLzIA/1OX9dQqnuQ41cVC4NLF90I/WsmRO761y0vMqs2qf
	ZA0XzJIkSEbgECgWKnSGAqynMXzsHWKr3r/y2f6CAurOgY3Qi1dWJb209bktp5M=
X-Gm-Gg: ASbGncvAp19AKrexMhGaMxuvrQvz0l7F9ummyoLc3tmcbLAlAu2aYBEKC6z9/pIH3qm
	JArR/vmy5+xUdkj74lH3bLGfzYufE94RTpfJOCoXSyTZwTY6FJSEK0RbQQiUmNrkrHtK5u1n++P
	QKS6aJ3BLdgf/fyFu+VLWfFsSwp+ttA17bvPh99mxFkT/hS/VaPih7qumCNvipnqQUyXo5VpK1c
	gCgObwTrkRAXVOwq6hpixMpAgWcAz8vS5ukH/9NSxQtrs5fkZXXceS7HFCerE00Tg8YAlbbJRzP
	cpMCmX8KLrC0BM5Id23IbPje7IdVzxR30DsPWw9iQfq6XqxfFoJmIgaQuDRFZ7TLamwb19bY
X-Google-Smtp-Source: AGHT+IF9USZi2XhF57yhEEp9osrqi/g5DdA8y8Taoi4iL31Fzh+/3YgFBVfEBC6Bksa7uUzxyxne4g==
X-Received: by 2002:a17:903:3c44:b0:223:f408:c3e2 with SMTP id d9443c01a7336-22bea4b6136mr205639305ad.14.1744685182592;
        Mon, 14 Apr 2025 19:46:22 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:22 -0700 (PDT)
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
Subject: [PATCH RFC 05/28] mm: thp: replace folio_memcg() with folio_memcg_charged()
Date: Tue, 15 Apr 2025 10:45:09 +0800
Message-Id: <20250415024532.26632-6-songmuchun@bytedance.com>
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

folio_memcg_charged() is intended for use when the user is unconcerned
about the returned memcg pointer. It is more efficient than folio_memcg().
Therefore, replace folio_memcg() with folio_memcg_charged().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index df66aa4bc4c2..a81e89987ca2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4048,7 +4048,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	bool unqueued = false;
 
 	WARN_ON_ONCE(folio_ref_count(folio));
-	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
 
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-- 
2.20.1


