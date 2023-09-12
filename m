Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31379C348
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbjILCtZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 22:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbjILCtS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 22:49:18 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6593F8;
        Mon, 11 Sep 2023 19:17:38 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bd0a0a6766so3776123a34.2;
        Mon, 11 Sep 2023 19:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694485057; x=1695089857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szu4YjijCmQAPr2TZ3fba/jfaS/4RHUOM3EpMid6LKA=;
        b=C2Edk7pajxHFZ4M2Tpfgpkig8Vx0CSM1bRofaH+AgIogqiOexg8bhzJqp7S4nDEEQC
         3Ci7+l6SQfRKGAS5FzZCkoxs/7iVNG5iXbA6mkrFZQ6Bmw6cFrmPncVy4SQNEQRn80Ax
         A+96fglZyiA9ZhHY9a34ODWZafAAUPkSPse/mBIDRvWK+x4Xd/KUlQTS/IEq3Ez8W8rj
         EKbtLNu0vnHU+bSSgWIAbc32gbPdY3DwYccK8HjcQOpLE2XDAnGH/CW35U9vSmzJwQ9D
         OhAwtfcSHu8bNCMuNt2VbjvPe6+v1l9FCYJfx2IxGNKqwkBcpRU+/Kq/jyQDPMAPOuKe
         gboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694485057; x=1695089857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szu4YjijCmQAPr2TZ3fba/jfaS/4RHUOM3EpMid6LKA=;
        b=CPd8CPH2u1yVOqqIpRdpvbbKVmSgUoWoZ6uWjkMsfa/KOd2sNocRCyGuTy1Shw92Bq
         KTMPYU0fL9Ag7Ms8l1FJx/ltK7yTIGwAZy/kSRSTXJUOR6mBho7cIQPoXKayFH8teIPd
         5NdYzhht8/o7WBqSg8YMYj7jlBfhv61Jc9d26EXRhBOhG4bmHFewBDCDBxo5xU8eUKWS
         y9eCQe/BMzEAqn9iUG/XABcMs3frMukO1hRfHNkj3mLvFv3IaI/MJcBpFDMW0kyK/vux
         VZaQA6I3aRzD0HJmdZAKMDEXD60wmyg5jv1zJWhIpJU6ustZGE+9BaNZwOAEucPzzRqR
         Ymjw==
X-Gm-Message-State: AOJu0Yw1h5DM/Ul0N1VBROAhrczO2Tc+femvoVRnJ2a5E6XYzd6SkHdX
        wV4h4glbCUmEXOKsIDM0Ufg=
X-Google-Smtp-Source: AGHT+IG6eRsMjzIqfU49hP6rWFie9ekepj5lrE+HWW7v6TG8MQjgNCU9kwvahkZf3SFU8A2l9SgEnQ==
X-Received: by 2002:a05:6359:ba4:b0:140:ecf2:4c7e with SMTP id gf36-20020a0563590ba400b00140ecf24c7emr9231225rwb.1.1694485057218;
        Mon, 11 Sep 2023 19:17:37 -0700 (PDT)
Received: from VERNHAO-MC1.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id x47-20020a056a000bef00b0068a538cc7adsm6217108pfu.52.2023.09.11.19.17.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Sep 2023 19:17:36 -0700 (PDT)
From:   Vern Hao <haoxing990@gmail.com>
X-Google-Original-From: Vern Hao <vernhao@tencent.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        haoxing990@gmail.com, Xin Hao <vernhao@tencent.com>
Subject: [PATCH v2] mm: memcg: add THP swap out info for anonymous reclaim
Date:   Tue, 12 Sep 2023 10:17:25 +0800
Message-ID: <20230912021727.61601-1-vernhao@tencent.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xin Hao <vernhao@tencent.com>

At present, we support per-memcg reclaim strategy, however we do not
know the number of transparent huge pages being reclaimed, as we know
the transparent huge pages need to be splited before reclaim them, and
they will bring some performance bottleneck effect. for example, when
two memcg (A & B) are doing reclaim for anonymous pages at same time,
and 'A' memcg is reclaiming a large number of transparent huge pages, we
can better analyze that the performance bottleneck will be caused by 'A'
memcg.  therefore, in order to better analyze such problems, there add
THP swap out info for per-memcg.

Signed-off-by: Xin Hao <vernhao@tencent.com>
---
v1 -> v2
	- Do some fix as Johannes Weiner suggestion.
v1: 
https://lore.kernel.org/linux-mm/20230911160824.GB103342@cmpxchg.org/T/

 mm/memcontrol.c | 2 ++
 mm/page_io.c    | 4 +++-
 mm/vmscan.c     | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ecc07b47e813..32d50db9ea0d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -752,6 +752,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
 	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
 #endif
 };
 
diff --git a/mm/page_io.c b/mm/page_io.c
index fe4c21af23f2..73b2f2846bec 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 static inline void count_swpout_vm_event(struct folio *folio)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(folio_test_pmd_mappable(folio)))
+	if (unlikely(folio_test_pmd_mappable(folio))) {
+		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
+	}
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ea57a43ebd6b..39beb0d30156 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1928,6 +1928,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 								folio_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+					count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
 					count_vm_event(THP_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
-- 
2.42.0

