Return-Path: <cgroups+bounces-189-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818B87E2BFB
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 19:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CF31C20D2D
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD82D056;
	Mon,  6 Nov 2023 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQEAu/8T"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23B2D029;
	Mon,  6 Nov 2023 18:32:06 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AABD49;
	Mon,  6 Nov 2023 10:32:05 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c3077984e8so4053981b3a.0;
        Mon, 06 Nov 2023 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295525; x=1699900325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKTpKLeSBdUqUozne8dOLG7XHxiGHFR4EgqMwDuCKlY=;
        b=DQEAu/8T6Zlvmk8QXgJb+oVwN1lFWiAgQOtG7oTLgE1ZxOtDfHeodJk9Cn4bjZGGk6
         y7ThCkWVBjkbDUHInA/cNizKDmk3bFaEtOqsu59AlgQoMeIlimbwtr5unijvmHuct2Vm
         a7FNUxcWLeYX+QZAfVpWCNxBV6YZwCw601B7Ju4iT854fJuRKaaysVOxBDBPhktKZw2D
         K9JbGPzPZteaccjDLGvkx2556K20tfRVetEiRRFUj2QQrORyk8tWEVapQY+bsmfiUtEm
         BsaS254XNN6zZDg9kuEHBiCXeBCGAVW+wBV3KEBHwWCVukc9tTf0svfADm9znEPzl6sH
         bRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295525; x=1699900325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKTpKLeSBdUqUozne8dOLG7XHxiGHFR4EgqMwDuCKlY=;
        b=UbHiq0lBH/wSkMsiVzQWE5BQRgckF/oVh12lpFWAV5nAErJKQSaHCxZxhm9YRXDqRq
         PztjEzjmIDeUF18gHK0HQZeJ7VpgKpYcBNw7Gd7zVkJVMPCyTG7CLfNUc5mx1tiJGujk
         m+s3SuoSy2EFtaB4LLFnRl/mYQuuHCD9XskjPyeUYhMrcVSKz/TjyJS/VKfKND+cV0am
         kQGpf8nJmyH0yd3r+rD6KLQ725bzJUeqGh8jPG26gCDvrg3nT/bHeMru7cmUWL8UwG8J
         tAejssRgyhoAr2wFgFIB7EXoAvX5ogDzT4jivpUHuB0la+1BbDzLNxqC51ONZTYEd6nT
         qEeQ==
X-Gm-Message-State: AOJu0YyRkQEH1r4GLPa5uMMDNhLoK/jBBg7cZyYYd5yfpqb951iSdK8A
	wC2aZFOABemMiOT9MNWzut4=
X-Google-Smtp-Source: AGHT+IEajdjXne5TgvRI7wLvY5VaXI1+x16n9o7YmP2T+LGhqO+wFg1B1TlhqVvjHYOcgf56WSD/SA==
X-Received: by 2002:a05:6a20:914e:b0:172:83b8:67f8 with SMTP id x14-20020a056a20914e00b0017283b867f8mr26904604pzc.29.1699295524682;
        Mon, 06 Nov 2023 10:32:04 -0800 (PST)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b001c9d968563csm6161658plh.79.2023.11.06.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:32:04 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v5 4/6] mm: memcg: add per-memcg zswap writeback stat
Date: Mon,  6 Nov 2023 10:31:57 -0800
Message-Id: <20231106183159.3562879-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106183159.3562879-1-nphamcs@gmail.com>
References: <20231106183159.3562879-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Since zswap now writes back pages from memcg-specific LRUs, we now need a
new stat to show writebacks count for each memcg.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/vm_event_item.h | 1 +
 mm/memcontrol.c               | 1 +
 mm/vmstat.c                   | 1 +
 mm/zswap.c                    | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..3153359c3841 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -145,6 +145,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_ZSWAP
 		ZSWPIN,
 		ZSWPOUT,
+		ZSWP_WB,
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ef49b471a16..e43b5aba8efc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -593,6 +593,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	ZSWPIN,
 	ZSWPOUT,
+	ZSWP_WB,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..5e5572f3b456 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1401,6 +1401,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_ZSWAP
 	"zswpin",
 	"zswpout",
+	"zswp_wb",
 #endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index 2654b0d214cc..03ee41a8b884 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -755,6 +755,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	}
 	zswap_written_back_pages++;
 
+	if (entry->objcg)
+		count_objcg_event(entry->objcg, ZSWP_WB);
+
 	/*
 	 * Writeback started successfully, the page now belongs to the
 	 * swapcache. Drop the entry from zswap - unless invalidate already
-- 
2.34.1

