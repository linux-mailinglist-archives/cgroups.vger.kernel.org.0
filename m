Return-Path: <cgroups+bounces-5038-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFF991AF3
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3511F227B5
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAF1662E5;
	Sat,  5 Oct 2024 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyRIP+fM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8A1BC58;
	Sat,  5 Oct 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165002; cv=none; b=ZvCHQVrnzcDCNVk4QBuFoZ8Sj2xwwFymb1jUZXwwnTj5nzq5/cgAixq03C/Rz5aCnlT/fLN2Buj++5oL10SD+IcK8TCEAzWJKemCd6p83a2r3BGSci1pTldYYrHs+EN/ymE43lGzanFoil+jN19zwZwCmTRwt2ocgotwO5xRDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165002; c=relaxed/simple;
	bh=AugDlfv+b6hscDAkW1E1n2aZ4MUkiHLw9DH7oM9tob8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTuAg4A1YilQJYKLp1H82VTI4BAlOTqT7AKWQDykZJ1vJzP7+097SQgutI1OHL4emCDE9ntKIuNv77X4pk6tpZbKTGBBEctexw1/XMpwwXBk0L6SgdriD8jdape++n5rZdtPz5UR8avvtaMfR1cU+cVvICE3zu3u5G5D14CbxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyRIP+fM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so2861045a12.0;
        Sat, 05 Oct 2024 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728165001; x=1728769801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26n6rwkz8EuDUCSAPaRiQZLssj+wWU8kRKUT3JvSvtc=;
        b=LyRIP+fMVu3quP/Tn9bH+2Vt7CsPNNsMCksw1sMvDJ5APRVNv6MbhTiYjf+Gn++W/D
         4rCCdIgC0kLNaHqcFhBPaMiL94A6wZIY6j4gN/NZ5Uxm/opUto81WrxDyCFWl19SWN5b
         o5SdYWDNrS75M8IneDy5gm7smNXpBSt5R/LPwfZ6KU0gza2vAMOX6yj72Ez+wHOVclTJ
         Ueuqkgp5cnwnM4vqzub8JwZCfts/59boAH2N89uCPG8ywNLBjmiCBaUYLsnYOQtmlpXk
         +yNfgSCNC6B8QbT3Io+AYYB4MoQZAU/prz1RcpzY8nVTQ7CsjA790ZbcAmQgWyv9O+6O
         rSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165001; x=1728769801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26n6rwkz8EuDUCSAPaRiQZLssj+wWU8kRKUT3JvSvtc=;
        b=TXLHrNJGQbRhHE6G0WzV2oy0zKIkypxUVoSsf7JzRCR6JOiADcSUZNAvj6WF3QcSH5
         wlQf1/2yHZWmbTFFzl1nYRG827dskrTCRFp6S7NewaigW70JVuq6Iq+/p9Tdg9nbV9ZC
         2LfZ2gxua4MThyxGMoEYYb33tHzoUP/wcsAFEh39wWWff1+aGG0mx8IFMdy2pEGXQ3JE
         p5HcOrT9PB5HmgArFh6xW4CMaT2YCrGg8YChrMiSEpmvO9Nz8TgBRL/1zRwU7/Nymbyi
         W3xCJlGRUkb2uHcXIoHIJTHpB9woRqlbOW8T1pO9M3jyBwFK3tuS+S11IPH4pjjyIEGH
         qNsw==
X-Forwarded-Encrypted: i=1; AJvYcCUIM51oVuOnx97Pk6lhRIpXLl+MbYLYQvPKCQHycVp7geKY5EYlSa2qFazJ9TPdFo+Cbe2I3ZxyTk3AB40G@vger.kernel.org, AJvYcCWPfenUcCKYTRevl6dlO7kD/wfC9KYNuNJac7cJen/gLBYdCDiOLFjeGcJ+j8OsjdPs5m8z4s9l@vger.kernel.org
X-Gm-Message-State: AOJu0Yxam+I2fvBks2FXJavgyOM1c/R5LERoMkRSIYSyhKm8yLL6CYHC
	01ssf3jN258pLF02N1+w3pUPapHWD4w6XSosk2s3voIkxJpHEB9e
X-Google-Smtp-Source: AGHT+IEmG/yE6dQLY9qvFtGWv6Tot6sO+NFQmFItWrLf5jPrMwhdviMrD/l26lrg3ajLSABPXkl9lg==
X-Received: by 2002:a17:903:2309:b0:20b:723a:cba1 with SMTP id d9443c01a7336-20be18731fbmr184103205ad.1.1728165000683;
        Sat, 05 Oct 2024 14:50:00 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13931055sm17165135ad.139.2024.10.05.14.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 14:50:00 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: xavier_qy@163.com,
	longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/5] lib/union_find: Add EXPORT_SYMBOL() for uf_find() and uf_union()
Date: Sun,  6 Oct 2024 05:49:34 +0800
Message-Id: <20241005214938.2147393-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241005214938.2147393-1-visitorckw@gmail.com>
References: <20241005214938.2147393-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EXPORT_SYMBOL() for the uf_find() and uf_union() functions to allow
kernel modules, including the KUnit tests for the Union-Find data
structure, to use these functions. This enhances the usability of the
Union-Find implementation in a modular context, facilitating easier
testing and integration.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/union_find.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/union_find.c b/lib/union_find.c
index 413b0f8adf7a..c9fd30b8059c 100644
--- a/lib/union_find.c
+++ b/lib/union_find.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
 #include <linux/union_find.h>
 
 /**
@@ -21,6 +22,7 @@ struct uf_node *uf_find(struct uf_node *node)
 	}
 	return node;
 }
+EXPORT_SYMBOL(uf_find);
 
 /**
  * uf_union - Merge two sets, using union by rank
@@ -47,3 +49,4 @@ void uf_union(struct uf_node *node1, struct uf_node *node2)
 		root1->rank++;
 	}
 }
+EXPORT_SYMBOL(uf_union);
-- 
2.34.1


