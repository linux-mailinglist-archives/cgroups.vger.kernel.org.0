Return-Path: <cgroups+bounces-10739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E2BDA03F
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 299FE4FA746
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E02DECA0;
	Tue, 14 Oct 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf7xqg+w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FE2DA760
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452332; cv=none; b=LEzkidNt3xeTuXPICrbPuILTSRh777foZgCdNlWx7mSftiDryU54mJWT5xMMsslz951xcG6pSVllcuwUL+BbY1Hty+FGJcStgNXkID93my9+rHDIrq72jDKNy5SP56/Ayxs+F74TwY1HPth5jeTnf81ZMoWkFc4e9xCPkALaNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452332; c=relaxed/simple;
	bh=CGpdY9mj7i13RcmCY1pYnp7mKQmK1bqT3bOz7kIvSkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVR09+PseAl/jPDwsK5vN8+0FBaF0uG32GarNzUhUqO3LqlRG2XsvkH82TstsMoXa/2Mg2qgudDvc7SItDcavDa+M/G66Es3MkOdLT+rInwXWXxyOY6Rq4pjybOh7PizCbd3aCh20Ba5skIiZTe4+FjrAcfkzzKtcN4wbDvA1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf7xqg+w; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ece1102998so3474809f8f.2
        for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452328; x=1761057128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq1ZdT58+kAlBHAzYJeARvc77Dy3a7gDAx3JIEmCCeg=;
        b=Mf7xqg+wRpGJmcwBPzTon41UPkp4ovuEsW0OTcj9OgTR3Mh1J+NxR3MjVe8v5GXkoh
         oqoXT8L2QFaac+YvOaqFQ2aUje6lZvcpC+ROZYcoh1WSU8nXpQZYmLrLqPxurZ1X5TfU
         P1g8m9kW02RudGcYjInE0ZVO5ngmKv3XPCzypveEep09orS8YJYQtKS5Y/ndgxidLwLt
         Xygd6I01r9DyampV51zc0RgmBTYZeV6OLrgp+5RXuU1K6oi0cHaOl4bukxZ1ixUPnajs
         QRx4AhPuu+4S+fQ78kYa+War1YgCbhxstyl6ZQHHCSka71shVRLE9/LbUYhEnFGycJjJ
         YfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452328; x=1761057128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lq1ZdT58+kAlBHAzYJeARvc77Dy3a7gDAx3JIEmCCeg=;
        b=F6UeUcIZhFUW6Uh9Ap6mgBXg929zxRA4F8YwcqMjk0IA1zF3dP9Wx2ig6EQxqwl7xX
         U052/sLDR6ggi67ssqf8e+kVrL2EuoOcNriQSTx0iKAND0ytM6efsQ/XufA140FDDesf
         qBR3H4w7HILhZ5qygZhNjt+sXB+NdplkrF2/3WnDCo5fxrty+MdeffogPnWZcaNNHvLv
         EEzrA83NfV3c+868oFoIPGoEoonwfrgqICNuz4XgnP2Jp58fW9bEPoqaxM/HH0CM+ODe
         PFTLEQiXChHMU/jNobu6HeUhKWWT5gnN24k6KEyGrJu5TSwV5sMbIgE5vgiCIyG5UBeU
         UGTw==
X-Gm-Message-State: AOJu0YxpBtfyjfC+gqOdFe7tK35ZaY3SMUtpj7ylSwEPAFaIQp3po6Hg
	JTpPtc4KvqL/C5Y/gJ7afNKH5PX4xsKyLvYONcpLWMrC7CFXCG/+XS7RpnpAlw==
X-Gm-Gg: ASbGncuoyVzC8G1IMUhKWcBVRwCR201nIhiy8+W1NnQpPVzpAbo2s1lIGiO/CBsSyyR
	txmKOiEuZ5+Bucqs3pmStpVcRVab7R/E6ELPN358lLzJN/SZa9UxLZXwSmKhIese3yfwseh+W3b
	nS2gIk4WKOaXioTxlL9BBh0NWS/q51mIVcnensAeshJXdssAgZgfgf8BuBGAtE4iIKOSneGFcoI
	RguOFS6dn2D+TvNNsw/KidF29r7UziKZIUX4JoBcwzxyZMhNIeKb0S1wb8wWrvko1NcVkQ8u4J5
	qX2V0adJ5lOKzfgkSFq5qkf6d+uRLYHqqbdZJCMJug9yAtoGEvoMEY5Grkj6wzvAYh3zES/ClYW
	JfSX9jtM4QKY9G9xU/WKA4PuQ6b1bv0mwT+G5Ks1qaPqrZgs7/77uOrybWMm+8gTEzqpS31zPrJ
	5wLy6arrSnW5Ja+d4=
X-Google-Smtp-Source: AGHT+IFV632wvYerc+Zt6jMamCQo8duq0kdLMs0PXT31JSgfPAnEtXrYO5HJHChAeH5bJGUvq56kBQ==
X-Received: by 2002:a05:6000:18a3:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-42666aca1dcmr15807959f8f.14.1760452328220;
        Tue, 14 Oct 2025 07:32:08 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e13b6sm24044431f8f.44.2025.10.14.07.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:32:08 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 2/2] selftests: cgroup: Use values_close_assert in test_cpu
Date: Tue, 14 Oct 2025 16:31:51 +0200
Message-ID: <20251014143151.5790-3-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014143151.5790-1-sebastian.chlad@suse.com>
References: <20251014143151.5790-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert test_cpu to use the newly added values_close_assert() helper
to print detailed diagnostics when a tolerance check fails. This
provides clearer insight into deviations while run in the CI.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 2a60e6c41940..b411684791f2 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -219,7 +219,7 @@ static int test_cpucg_stats(const char *root)
 	if (user_usec <= 0)
 		goto cleanup;
 
-	if (!values_close(usage_usec, expected_usage_usec, 1))
+	if (!values_close_assert(usage_usec, expected_usage_usec, 1))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -291,7 +291,7 @@ static int test_cpucg_nice(const char *root)
 
 		user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
 		nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
-		if (!values_close(nice_usec, expected_nice_usec, 1))
+		if (!values_close_assert(nice_usec, expected_nice_usec, 1))
 			goto cleanup;
 
 		ret = KSFT_PASS;
@@ -404,7 +404,7 @@ overprovision_validate(const struct cpu_hogger *children, int num_children)
 			goto cleanup;
 
 		delta = children[i + 1].usage - children[i].usage;
-		if (!values_close(delta, children[0].usage, 35))
+		if (!values_close_assert(delta, children[0].usage, 35))
 			goto cleanup;
 	}
 
@@ -444,7 +444,7 @@ underprovision_validate(const struct cpu_hogger *children, int num_children)
 	int ret = KSFT_FAIL, i;
 
 	for (i = 0; i < num_children - 1; i++) {
-		if (!values_close(children[i + 1].usage, children[0].usage, 15))
+		if (!values_close_assert(children[i + 1].usage, children[0].usage, 15))
 			goto cleanup;
 	}
 
@@ -573,16 +573,16 @@ run_cpucg_nested_weight_test(const char *root, bool overprovisioned)
 
 	nested_leaf_usage = leaf[1].usage + leaf[2].usage;
 	if (overprovisioned) {
-		if (!values_close(leaf[0].usage, nested_leaf_usage, 15))
+		if (!values_close_assert(leaf[0].usage, nested_leaf_usage, 15))
 			goto cleanup;
-	} else if (!values_close(leaf[0].usage * 2, nested_leaf_usage, 15))
+	} else if (!values_close_assert(leaf[0].usage * 2, nested_leaf_usage, 15))
 		goto cleanup;
 
 
 	child_usage = cg_read_key_long(child, "cpu.stat", "usage_usec");
 	if (child_usage <= 0)
 		goto cleanup;
-	if (!values_close(child_usage, nested_leaf_usage, 1))
+	if (!values_close_assert(child_usage, nested_leaf_usage, 1))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -691,7 +691,7 @@ static int test_cpucg_max(const char *root)
 	expected_usage_usec
 		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (!values_close(usage_usec, expected_usage_usec, 10))
+	if (!values_close_assert(usage_usec, expected_usage_usec, 10))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -762,7 +762,7 @@ static int test_cpucg_max_nested(const char *root)
 	expected_usage_usec
 		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (!values_close(usage_usec, expected_usage_usec, 10))
+	if (!values_close_assert(usage_usec, expected_usage_usec, 10))
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.51.0


