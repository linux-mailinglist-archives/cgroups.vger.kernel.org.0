Return-Path: <cgroups+bounces-7568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24EBA89233
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC9D3ADED0
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1307233732;
	Tue, 15 Apr 2025 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fpcKFjh9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51421D595
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685278; cv=none; b=q2Kg9TM7LyFDxzjpHAr02CtFpzl/hZsV7GkBYkGF5Cs20WK6OYR5s4aPJ8F4eRwz+MZIKniT8zNEosrHpRiezfPdwcYpw3TlQGtr737BSjvVeSbQYTZulpl5VOTH4hGb/oMA0iXgmx4yCIuHEnsbPCSwl/0iOjVN8VwUYq1bWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685278; c=relaxed/simple;
	bh=gqcWvL8puEcB8VURLE0CUOfUeKpOQO4iYFAmWiCBYCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyM8CuwBE1RSKUIaMR45Xo9UHRhlmCfPC2dOI0hVhCCUTgANYo3YstYtcT5+uB+lIqcRd0bzQBkwzodc3O6K8/CoQKji2O6i2TQTzyw8cCq/GC2UiLtFyWXxLQe1JFQePlGxVj79+kPI+Qu4e3DBC6aUirTgulrZScF+Q7yMFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fpcKFjh9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22409077c06so65956065ad.1
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685275; x=1745290075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBa3KcBA5wxUNKsQ+K1hpla3o8QIUcc8xJR0inNtMu0=;
        b=fpcKFjh9ienup1D85vtSvbp1TeT+MWhoUrsOsNiiTa/M9+staSsJXBEj/iebO1CNsZ
         4+tY6T/BYJ+Z9EzqNB5EoZvdUU5YZB/PnmFSsk8hfZZY4XCDvUF1CjiuNMZ6clk7HrmD
         q7inDR24jRI5JmJKK76Q5sGJgfUrKE8PJBjIYdPOFKKtixrvZvejpjTC5lmujZ1JPH/F
         72kGqWXE6HbyLtz6aNcpBfv4+0r6N0EoANMeJDU4RtTt2mmMrCfxOrT7ndmtJFDhXILX
         i+g47tpkmbCzZxuXKaFVTk8/EeFRbAkAj90+gz0MAUmqVwBvj04LNNDbGLT7QqiOy5Az
         22Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685275; x=1745290075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBa3KcBA5wxUNKsQ+K1hpla3o8QIUcc8xJR0inNtMu0=;
        b=lLU4jbEtaL9E9Gn0ZPA19U8lev2ijhFcGcFe2B+B/nw96NpO04zlslYEWNGWP2U/oW
         7t+MEL/1wSLyPnLKC9Sqbriya2PM1dDkWM7lZJDgRCvA0zw/tCm3M55/EnRHcNb8pFyi
         GJC/0ZmU+//Su8uMbqZaqS06oksP5Q/cZlLAOHc3Vh+6mJD4n59yqmuDf3HuVXaQA2xw
         qfLlWUt02QPyD1jDPa06TMfL31ooj9hZOFvQ10Tawaq6kmFO8Wq+EUP8LntxCETPSkho
         Jzeyx0qZCmUsVb8s7cPEQNDc9QmxQ2XseP5Ax0qw2DJUOgcpTPg/aqM7/Msp2Wxt1ElC
         /t2g==
X-Forwarded-Encrypted: i=1; AJvYcCVwIqqdE9wgq2NfKpmS7qDtmVbESiGcDiVx/5HGPvpucY7e89JlK0gadnfp4sGOsqYBM03NrGZB@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOt2v9w8rUVLoLSWW0H9OVkwcTmLMEmrcWj8xTKp/Z7bmEebd
	F/DMK5mkynSNZ2JWWdaPqBEYLiSTvgtgP6mSD+2k2gP5Q1QXKQvha8eXlVVz6jk=
X-Gm-Gg: ASbGncvKtDqgd+S6f6LCnXjoX339sNzVBtzu6VppVt7WprGcjK5GIfXTE+T1C219wnY
	KsgbSQDug4olbcQ72JV0rMCepuk5AwBr0f572PW21BREz71qymqTBs1xh29IgFr5hczA5bV0ovH
	egVbTg2sYyBtR8BXol74Z5QzzWlrngSAs10LAAZs8dtIcUMvcCpe6p5wD/8iBVnea/SP575Y3mc
	7S9IrekmpSfBH+o4pc5pWQr0ZYIS5TrBDhnxxXo27m4uUwOBUAKUe7fWKO1+3qS9Fh5fttMDBzR
	7xXSQ9a5TwNn6Gr+/F+diJWaU288+jns/39SOIDIgECITZMobFXFavqzeSps+j3q9Sne2LMi
X-Google-Smtp-Source: AGHT+IHI4hqLb4XlutpOFIzQEdrRaemLqaUdJqfYPhQI+o4uvusfdbjBRgP5q4orxhE3PLyGhMO1fw==
X-Received: by 2002:a17:903:3202:b0:224:1c41:a4bc with SMTP id d9443c01a7336-22bea4ab6c4mr253471365ad.12.1744685275144;
        Mon, 14 Apr 2025 19:47:55 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:54 -0700 (PDT)
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
Subject: [PATCH RFC 22/28] mm: swap: prevent lruvec release in swap module
Date: Tue, 15 Apr 2025 10:45:26 +0800
Message-Id: <20250415024532.26632-23-songmuchun@bytedance.com>
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
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in lru_note_cost_refault() and
lru_activate().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/swap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index ee19e171857d..fbf887578dbe 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -291,8 +291,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file,
 
 void lru_note_cost_refault(struct folio *folio)
 {
+	rcu_read_lock();
 	lru_note_cost(folio_lruvec(folio), folio_is_file_lru(folio),
 		      folio_nr_pages(folio), 0);
+	rcu_read_unlock();
 }
 
 static void lru_activate(struct lruvec *lruvec, struct folio *folio)
@@ -406,18 +408,20 @@ static void lru_gen_inc_refs(struct folio *folio)
 
 static bool lru_gen_clear_refs(struct folio *folio)
 {
-	struct lru_gen_folio *lrugen;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
+	unsigned long seq;
 
 	if (gen < 0)
 		return true;
 
 	set_mask_bits(&folio->flags, LRU_REFS_FLAGS | BIT(PG_workingset), 0);
 
-	lrugen = &folio_lruvec(folio)->lrugen;
+	rcu_read_lock();
+	seq = READ_ONCE(folio_lruvec(folio)->lrugen.min_seq[type]);
+	rcu_read_unlock();
 	/* whether can do without shuffling under the LRU lock */
-	return gen == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
+	return gen == lru_gen_from_seq(seq);
 }
 
 #else /* !CONFIG_LRU_GEN */
-- 
2.20.1


