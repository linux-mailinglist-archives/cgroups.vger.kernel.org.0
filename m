Return-Path: <cgroups+bounces-7530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBDA88CBC
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 22:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0503B3388
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31D1DE3C1;
	Mon, 14 Apr 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oc7bcXHc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246A1DA31F
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661377; cv=none; b=YmVVfJdi9sFKdTVl1H5cZX0HUguMhkfaQhlEXZPd8wupTjuNzyRKTry9AcLUda41EPORNZHEz62pkx1S+pW0vEGoQfxQgPpUQcfX1Nra+oA2XnHNCi9hfqB/WbQzqY8wQQCFnmQdki4simhZwM/3faUXOaUxMqU3B6FHhaaAlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661377; c=relaxed/simple;
	bh=BF/n3ojsyDlB1gEPdRnL42H4qr9IhToSWAUvHs9sZWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bu1Qd3XJpvM/fo5ztOXp7De1ptaVUzzbysG7V+LORLZGfSvw1XaYo5lqpBEaZoCN05M6ViuEyoPEEyRpnmPTxiKYVw1xD4nPXRC6A+6QQgPHCn1kbEgMlDDG/Q/DEimoARZwf+wvtsxIEe11VhmO04oUnkOByFJ1oWB3ugm3y1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oc7bcXHc; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4767db0bae2so81739981cf.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744661375; x=1745266175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OmKBQBv9lPDr6Lz0gJXTMJ6j2uWNIUBa5L40UsL5lc=;
        b=Oc7bcXHcG9z7rt1Rjos2AJ+ExWT5XEUkOuFEHoIlAq44c4ng5LCT90c5Jc/XTGrHpm
         kRlwpLDgG9igWApzW0w+8F35iiRSp9PL1FJkIDxH5200DyIR9oYB4sw7VlE2zOarH9EI
         XhPBjqD5dnjNg1IBctn2DaAXkASwxmHmBcQAnyfzRBtuU8Qnv2+fTcsnDs6sBgUtDRNk
         WTvA+CgaltkK6uCmAk1FPNx7awmpGZBigL9X/0714Yl+HnFAaPhNbHYNYTb8j55t0Fin
         fBg/540N3pQYzcuyTFrDx3fG4F8zkEkMD0w54GuUBaotzqlwa0c/P7wPCcheQAyRumac
         ckVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661375; x=1745266175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OmKBQBv9lPDr6Lz0gJXTMJ6j2uWNIUBa5L40UsL5lc=;
        b=GYpE5Pgk2JhkOiEuUhKgOv86f5yS7lBf4PU5Uc0d2ovDmR72LIoC8CBJ7E5GfY9fCR
         2ZmKGENxFJ5gdHJZcm55R7d+O8f6PNPRY1EbF79lW2XtgBULcEpLL6dLMhg0MBAFpUXB
         PHiByNzwTglrD0tBwTfGUStij9z6we+iQn4D/rpLmu8MehvzR6BeQHpXbV2FQ5Qq9qZ8
         zt9v30YUg0czlBGs5ivmx4dvA8j2OU2N6fj+SDCjrKLvi8LP9V6G0jJTSBxoxOBTSdPS
         B/BBkrnZM3lqbopVdvbWJsdgkfHZOPsnvaSYnZHC3I9mCzbMHaNhP0HEeIgHKLv5QHk7
         m7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVF7Gj7tdy9RdCPeRzdPt5dH7+dCDkA9UXzHTy4+ibk7nak/D3D4wx7fviVmy+76Rifr20Vbg@vger.kernel.org
X-Gm-Message-State: AOJu0YxWY7c4vgyceokXc3D8jevWmAauGJo/zSIF/DVK3qJJ8S2L4kNg
	6OwialzFwXWpaegEzyfrgJod/MYGUSkuj3Unmy+286Mv4MD5kX6gySGyYW5Xi4tzabcDS1zvOrb
	JvWPyTDlvqu7hBCsYlA==
X-Google-Smtp-Source: AGHT+IGpM6NeNiCFi/bkPo1rMtQTc/NqEW2YkK8IB9Rf0x2rTDTCkmJztPeQBYp1ihD6g6OodTF5TA9C2YCT7W+w
X-Received: from qtbhg22.prod.google.com ([2002:a05:622a:6116:b0:477:677d:45b8])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a8f:0:b0:476:9ec4:5006 with SMTP id d75a77b69052e-479775d5e5fmr206159171cf.37.1744661374947;
 Mon, 14 Apr 2025 13:09:34 -0700 (PDT)
Date: Mon, 14 Apr 2025 20:09:25 +0000
In-Reply-To: <20250414200929.3098202-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414200929.3098202-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414200929.3098202-2-jthoughton@google.com>
Subject: [PATCH v3 1/5] KVM: selftests: Extract guts of THP accessor to
 standalone sysfs helpers
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Extract the guts of thp_configured() and get_trans_hugepagesz() to
standalone helpers so that the core logic can be reused for other sysfs
files, e.g. to query numa_balancing.

Opportunistically assert that the initial fscanf() read at least one byte,
and add a comment explaining the second call to fscanf().

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/lib/test_util.c | 35 ++++++++++++++-------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae8373..3dc8538f5d696 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -132,37 +132,50 @@ void print_skip(const char *fmt, ...)
 	puts(", skipping test");
 }
 
-bool thp_configured(void)
+static bool test_sysfs_path(const char *path)
 {
-	int ret;
 	struct stat statbuf;
+	int ret;
 
-	ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
+	ret = stat(path, &statbuf);
 	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
-		    "Error in stating /sys/kernel/mm/transparent_hugepage");
+		    "Error in stat()ing '%s'", path);
 
 	return ret == 0;
 }
 
-size_t get_trans_hugepagesz(void)
+bool thp_configured(void)
+{
+	return test_sysfs_path("/sys/kernel/mm/transparent_hugepage");
+}
+
+static size_t get_sysfs_val(const char *path)
 {
 	size_t size;
 	FILE *f;
 	int ret;
 
-	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
-
-	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
-	TEST_ASSERT(f != NULL, "Error in opening transparent_hugepage/hpage_pmd_size");
+	f = fopen(path, "r");
+	TEST_ASSERT(f, "Error opening '%s'", path);
 
 	ret = fscanf(f, "%ld", &size);
+	TEST_ASSERT(ret > 0, "Error reading '%s'", path);
+
+	/* Re-scan the input stream to verify the entire file was read. */
 	ret = fscanf(f, "%ld", &size);
-	TEST_ASSERT(ret < 1, "Error reading transparent_hugepage/hpage_pmd_size");
-	fclose(f);
+	TEST_ASSERT(ret < 1, "Error reading '%s'", path);
 
+	fclose(f);
 	return size;
 }
 
+size_t get_trans_hugepagesz(void)
+{
+	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
+
+	return get_sysfs_val("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size");
+}
+
 size_t get_def_hugetlb_pagesz(void)
 {
 	char buf[64];
-- 
2.49.0.604.gff1f9ca942-goog


