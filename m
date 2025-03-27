Return-Path: <cgroups+bounces-7236-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9456A72815
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 02:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CA47A56B9
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 01:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947CD128816;
	Thu, 27 Mar 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDgnPe2H"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B178F4B
	for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743038695; cv=none; b=LwrpXCZ7Rx/1b9bg1teMF/G+GqDgvhpf2kwpDdk7KOUYGEtq7DOu1ecfMFehYnRNNnjHHs6vHawW0S+/q9eXECYtOb9V0wnRcKe6z6pmKluA+UFvTrO96d0Zth0+5Gkr3lkLe6JsRVHnEQAv0gN/1HO3PzNP7daReFF+6LvLeUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743038695; c=relaxed/simple;
	bh=sVPmJtk+M0QFe2DpgpAtXxhYDfGr4TqJUl6HVgYb1yE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BM5Pt5OJ/R5zyPGEFgnC7OOAHkykXCHTe/BFWZNq7RumJ9ZSgF21Z4svrej/SWAd4/YG7oZtxdMjiDKh5m/mc51Of6ZXnTF1WPCrw+JrPCTKtnlroPN7YR+K71yFaiBNJSdJIYbzADL5ety/BXmuLQNw1KITucT8sooJdRIG9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDgnPe2H; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6eada773c0eso11744726d6.3
        for <cgroups@vger.kernel.org>; Wed, 26 Mar 2025 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743038691; x=1743643491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=liGs0zsmCzXyApDpxJa5hQb5aVWUAwjiM/fW15pHclY=;
        b=NDgnPe2HKi3P7wPlUM9MeskIM3MiwgVMz+sUgld+TwKnpcFg4vxMhlQlm6JNALCqxh
         iDl29Crucip5+l6BRze2apweoyfR9Y8/+zmeqBSH/JkTWM6jSAO1k1PScLGINCsaouTu
         AGuVD31gTbGOixL4Pk25AqwEFc4ebX2u219f43uHEoKmCziX0QJNSzIWEaYQODc+kC3j
         LpVpkp6NiuN7Vmhhoc5zXaTU9kDWK8tE5VTub6ugCCJKuUPX0ac2XGYYLiZy2vXYP/VY
         A1pKSrDIO87df6y5UIOYhHO22Ci98A/H7/jkw7UGw5Z+xeNX4qWJ74+UdgqcLeryPlcX
         wk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743038691; x=1743643491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liGs0zsmCzXyApDpxJa5hQb5aVWUAwjiM/fW15pHclY=;
        b=j/5ZbEVeS5ZfXog6QWKr8dxjtZL/xELvoM/cjbRdntJbtiEd8rmqLmhKRMDlioEMeW
         zrjJJRklIAF+ounQqFAhI0P386bkc2WwnxDMJpOf4BZj0g2hZWli3+mGWicxlbbdw8xU
         jBDktut41YketOze94tUtLCccG3VMx/OwyJJofp6kjUeyvMRtk5pOrtmq+FustKxRCn7
         0JZ0x7VUJb/+e/ifZxkdzEYCAha5u3f4nwy+af8xU07K4VWwlc+LaORZbEUq4wufebZi
         75qGw5mexw2Wz17IBwJoey7dQRqvorPQ/Nyxow2I2xhfKgFHxZSto4T8Px27nKkWQVNY
         Ov/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWbThq/nviR8ZP/otisN9VV0niEoUSqw7cDYYyYlzVSExY72Cg4M1k1Fh3NHEZeQePE5L6G5DN@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqDGG5pGaGbpnEYGVVwnf6noeftJ4RzAvHbVHOlA/W0+UbKgT
	GNFD9LlO3uqr5MHKMxU9lFUIQ8Rmetfm8O4g5pE/fRsvF/0HhXBzGioUkv0tkn6f18W6GV/8J76
	hyDnIwaJNeYmRzluB8g==
X-Google-Smtp-Source: AGHT+IH7BAFDxR8LyIf/cCmDc14HH7jyC//3aG9i1kJW7Fvp8ZskK6kVxOKCBos5v4Y1+Vq5kmrmwnBeThHJhsNb
X-Received: from qvbrf3.prod.google.com ([2002:a05:6214:5f83:b0:6ec:dd52:e52c])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2585:b0:6e8:fbe2:2db0 with SMTP id 6a1803df08f44-6ed23912adfmr23153566d6.30.1743038691331;
 Wed, 26 Mar 2025 18:24:51 -0700 (PDT)
Date: Thu, 27 Mar 2025 01:23:46 +0000
In-Reply-To: <20250327012350.1135621-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327012350.1135621-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250327012350.1135621-2-jthoughton@google.com>
Subject: [PATCH 1/5] KVM: selftests: Extract guts of THP accessor to
 standalone sysfs helpers
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yu Zhao <yuzhao@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Extract the guts of thp_configured() and get_trans_hugepagesz() to
standalone helpers so that the core logic can be reused for other sysfs
files, e.g. to query numa_balancing.

Opportunistically assert that the initial fscanf() read at least one byte,
and add a comment explaining the second call to fscanf().

Signed-off-by: Sean Christopherson <seanjc@google.com>
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
2.49.0.395.g12beb8f557-goog


