Return-Path: <cgroups+bounces-7561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64DA89222
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7109617D796
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BAB22D4C9;
	Tue, 15 Apr 2025 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kIprf5Nn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA9219A95
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685239; cv=none; b=f+Pl7Qxlcv4VnWRJRdlHRG1nKi3A6Xh0xBeIWPaI1T0u/uLw8HtF8pUFUzQoyd6jX80YRUM00BaX1a8WkJr2LSTjmqnhFCEFOtS430lknFVZAvVUmQOlt7MsiAJbHlTDZEzMlmysm+dxuT+IItbIabPJLrvbTtT/Fhb5ZlMV8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685239; c=relaxed/simple;
	bh=ExRJlPFqRIPBVplhInN1J+JPDFU1q83KrxCLYkfL8vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSS7ug8A4DCWVxrA2SIE4ujOTT7DSf6q/xXTuX4hKCUtb3uEXR4PkKPpFHKtiGU4TWYr8kfvQfUC/TERQPVwlmwy4kgaaEoFocTCpi+lTuaps2hil7bZi/a9UTTeapLr5iuksNwttmOVurSC7x+ZcsRTKqSEOV89WmSJTtnMHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kIprf5Nn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso53487145ad.1
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685237; x=1745290037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=048a/COuUtmsXsXzHcibcjt0GyskIDx7SCGdBM7o194=;
        b=kIprf5NnfVr8zwBg2zKmZeWU3jQXAheHtu+IwoDTWZkhXhH0QfBkcKAEd3K5xLaFpQ
         +BDoi0eGkMluXMR9jag9hEjS/2G+8SFsbqQXhSa0iPne6Qr1fWzwH5ulU0w72AMTlkQT
         3tCF05TcFQd2Q7uRsSPQkK5aEEqLNYM+QJmo9xZfqMQPCSsIDnq4pD6waZEYPouCQiKn
         aMI9Wg9iD5TLpj9b+fEJCR/XnFwjc96qtaDjqvP4QBV4vs/gUPWzMtQXm9H7HXsXcz6E
         AN+97XoF/ousv0dN6MaD3PdlxmsUr16nX40tqbBwnoB7zB9deyiS78YQFgeYBayqtynY
         Cw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685237; x=1745290037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=048a/COuUtmsXsXzHcibcjt0GyskIDx7SCGdBM7o194=;
        b=YNqK2EqF3J9Bkaa7E+zUFRdyVeUjqEW4mgKgLm1c6yEWby+op/npk6YUuvxFRE9OAv
         NJjBMpmrFB96xIWl9TfgkLd5r7m6LPKvO3WfSIxM/qLlJ75MU6Z+YXymrR8CgeifKzP0
         +kwm72oc5U0M8XiK/Vvuf1Qs3Yp9PPuqgwp/kUn4dkgnLfeKbVN4QHj2d+2OtJuMjqdn
         NF/sFkd8rwRordjTBArcb79ugDDhkeTSifgSM4/5Jy82i47kHYyGQNp0+a52dNfHVphA
         B/q/CuTTpFykfeXne/JoSvL0IulVpKayN3Y6dSuYWXyGxJsTmk4dI17ckg5ELK0m6VJX
         GUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcwN2dskiPvXhP2mF6hbWt6vqr3g6GJjed1RQrm49bQVt3Sa8Tp5Q8eZrjOMvt3rbaltNxMv/k@vger.kernel.org
X-Gm-Message-State: AOJu0YzxwpPCiSqN0uWnMUbIgtJl+tBey6+JV2cVW8rFtT2zaDxgXXum
	qZ0rTKa2qYc3cAzy/Q8FTKC8kQvSqt2hWEQuWIwejD2HaVe1yzGvof0avxN2IlI=
X-Gm-Gg: ASbGncvxddf/zVrRFRjSShQYEr7QE5MStZZYpeyxG3CmACXSyFK0Q4s+yITatchdE0h
	sWt17LVM3j7QTM4HqaG+y08rcdYv5r7QK/n2IDnojEin4OKYNq6USJsWc8KusMxWWpJxcqp4Ex7
	E7CjgAvUIZZmiChCC5xoNP4mVmXvFdXK10V7qg/N7yo1OY7cIjyUCe22fGl9VUwIukpTKKZrHfw
	S5Ecg44DPa0qim33AmB2ghdL9TSIcutu1BIy2BA0iZEH3JOkHlm6fe2F2xU/FbN35/iVdFfQ5YW
	Xj1WKTxCh8d7ulKcdVsYmgV6SagUmSRUcK1CFYzxW+l8iL4YEnuTtQkr5EiFOTlnVYZajELQ
X-Google-Smtp-Source: AGHT+IH8mFGGtZG1eAt8IdVT2T6wuIxSclSFtYUMLbYnFcscVwUk704iXPYP1CTuJRMCglCtOnp9BA==
X-Received: by 2002:a17:902:ccc5:b0:221:7b4a:476c with SMTP id d9443c01a7336-22bea4ab854mr201964985ad.18.1744685237616;
        Mon, 14 Apr 2025 19:47:17 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:17 -0700 (PDT)
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
Subject: [PATCH RFC 15/28] mm: page_io: prevent memory cgroup release in page_io module
Date: Tue, 15 Apr 2025 10:45:19 +0800
Message-Id: <20250415024532.26632-16-songmuchun@bytedance.com>
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

In the near future, a folio will no longer pin its corresponding
memory cgroup. To ensure safety, it will only be appropriate to
hold the rcu read lock or acquire a reference to the memory cgroup
returned by folio_memcg(), thereby preventing it from being released.

In the current patch, the rcu read lock is employed to safeguard
against the release of the memory cgroup in swap_writepage() and
bio_associate_blkg_from_page().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4bce19df557b..5894e2ff97ef 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -280,10 +280,14 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_unlock(folio);
 		return 0;
 	}
+
+	rcu_read_lock();
 	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
+		rcu_read_unlock();
 		folio_mark_dirty(folio);
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
+	rcu_read_unlock();
 
 	__swap_writepage(folio, wbc);
 	return 0;
@@ -308,11 +312,11 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct folio *folio)
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg;
 
-	memcg = folio_memcg(folio);
-	if (!memcg)
+	if (!folio_memcg_charged(folio))
 		return;
 
 	rcu_read_lock();
+	memcg = folio_memcg(folio);
 	css = cgroup_e_css(memcg->css.cgroup, &io_cgrp_subsys);
 	bio_associate_blkg_from_css(bio, css);
 	rcu_read_unlock();
-- 
2.20.1


