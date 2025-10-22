Return-Path: <cgroups+bounces-10980-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2FBFA4C6
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 08:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E103B50EA
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084D82F25EF;
	Wed, 22 Oct 2025 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWApyCsY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63338FA3
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115597; cv=none; b=Rt9qz+6BON7uUmHlkGky5whecqEuzMeNA7UnGIvHACgTwdxQfq++s2St9CDxSS76if3CL6v52N3Yt1BOO5RHiW7nP4uqJJwphnlTk4+exVIbsxMkpgG1lR3q+YrVGkQ7/amaUiQxXxEiAjVhADDiytEXrNbLS7NhfUlUgYM2wlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115597; c=relaxed/simple;
	bh=og7xTHDH5mBcktzdbB/rofaROoPmvxy3RBnDnBaiIt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnrsrS24Ae7pZRaxwqRJ5FnPP9xeoeIgmFT84pb3Jv4LsryoDMKrL9qYIq4yjl3eX1/mavUyL+ujsVtrF3t71kEPaH7YEArk3qCLR0m10QB03R7qRtMlpLdosPXJ3gV9N/GenGGcLaPxjq9+aQij05QAWXU9HQWYpxERD5Bj+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWApyCsY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47495477241so14515625e9.3
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115594; x=1761720394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2ijC4VrpFrJf75N9b9AT4O05FGTcZJknkAbESqoXgY=;
        b=VWApyCsYRlgtPmodEZ1pWdi660fNpUl42wMT/Ko+1EFz3UjWSnxXsSnlLnQ8BwHsk9
         HOjPI3sf4Qa38XXtRvUZKeUIMfCmAbyzFAsgatUVrs8UcNxcabyQNFa/JgQbEWXTNiyl
         mVT3oh2Cjt5ueD7FXRk4zR76C9P9XNQ9TD6lAcnpmiOREZCtZSFlbi9npVuMPLT69eb3
         bdXIf+Xfl2iGXD9+gqy9CBRiKTuCIapahDGaHZVNRqy1GbcxXg6YPpDkGAqOcarZmVNX
         6DlO3j1MgGwbvcRL/46EOMF+3zBOGUvw2hPbXBaHqdP6kdFQGEeOK51gTgqLv3KYnzWG
         Um7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115594; x=1761720394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2ijC4VrpFrJf75N9b9AT4O05FGTcZJknkAbESqoXgY=;
        b=qH0B8laHyEuFnp/PNV6N4Dm1hGNw0paWApCfh5W+ywfZpZxCyygjauu+gtHwE7J4zr
         IXZuGtAuOh3cXVk9DveMx6Vt4+k/9AWfm28H3O9hqDM+WQ2dexgIfXBzpDNVgOgE+Xsj
         aXluSVLFSbI5D1gldo9NxFUNNhEewKMsirBM2E5KCHtFe/5B91j5NsAq2NffAbdaL0yV
         C1P0I97kBS5nuupTHsMCcjb4YpGjYstNS7tjE27a9nYfHGxBvgaB7/t/74Ccv7Fz0ZfD
         LgfWniHiRyrJnqPZ+mY89LPGtkGt9GYiSsHNFW1k2EBpSNzPXdLoDo6OiUWzH4J0jm2b
         T0zQ==
X-Gm-Message-State: AOJu0YzUF1XfozEQxQnr52BrDXrd549kxhZq+NdCVB87+KeeMjZ62ST4
	G/N/l56h7KW19LPc9zCX9qGFkFX2S4PR7qC5lrKXN04JTMcKYcVCPYyB3HJsMA==
X-Gm-Gg: ASbGncsSrDx23ecW4zgMURL/7R8QivQ87e4FFRb2MO5980vvlNG8yEfYwdI/G4BYQ3e
	slrqM0rAxuKqW+4M10hF+MF/QyMULhgwdTvS1pTYaNlIv96xUA7EKedvV4xOfZ/eQ4fYDkSvrfD
	vltNn2GS2PA6EAqYewBrp3Fkp55TVqYA8Am9BXZ9eMCAFnNE4CRv3sGtPz8vHYJnI+Ox0Q7JtQC
	7QTZS6s/7HYIpNfQr+fTk6m9kQ6+kvC8Y0BAtL6ByjOnkqBRtLaWuN4mA7kPfE701nFdZ5TXL1n
	bm7BLMKnwv4HLt8O7yvAdpFpJ6nkNIjG9Ah+mMOfSQHXpgbi4hiqMin7Bdee6E8JrGOafE+/tJ/
	9tR2xicJLE9BFrJghazdI8h/PecZ//l8MyCACxThAw+EMvw59k9pIBr/OR17x+zyguW64ctN5sY
	eIY1wlM3uAgrjiWdCI6ksM9+xolt3jUW49WVaEvUhbGvUw4MDYmw==
X-Google-Smtp-Source: AGHT+IEWkjBIYPZLZqsqx4y3xjGY5nkGcmt5IqUTUsZB0aWk4ffapvClk8vbpgs7FByR7VJPwWxZTw==
X-Received: by 2002:a05:600c:3553:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-4711789daf3mr144778625e9.9.1761115593999;
        Tue, 21 Oct 2025 23:46:33 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm29931785e9.15.2025.10.21.23.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:46:33 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 2/5] selftests/cgroup: add metrics mode for detailed test reporting
Date: Wed, 22 Oct 2025 08:45:58 +0200
Message-ID: <20251022064601.15945-3-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022064601.15945-1-sebastian.chlad@suse.com>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new "metrics mode" controlled by the environment variable
CGROUP_TEST_METRICS. When enabled, all calls to values_close_report()
print detailed metric information, even for successful comparisons.
This provides a convenient way to collect quantitative test data
without altering test logic or recompiling.

Example usage:
 CGROUP_TEST_METRICS=1 ./test_cpu

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tools/testing/selftests/cgroup/lib/cgroup_util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index a8fe54eb38d1..32ecc50e50fc 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -2,6 +2,7 @@
 
 #define _GNU_SOURCE
 
+#include <stdbool.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/limits.h>
@@ -21,6 +22,15 @@
 
 bool cg_test_v1_named;
 
+static bool metric_mode = false;
+
+__attribute__((constructor))
+static void init_metric_mode(void)
+{
+    char *env = getenv("CGROUP_TEST_METRICS");
+    metric_mode = (env && atoi(env));
+}
+
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
@@ -40,9 +50,9 @@ int values_close_report(long a, long b, int err)
 	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
 	int close = diff <= limit;
 
-	if (!close)
+	if (metric_mode || !close)
 		fprintf(stderr,
-			"[FAIL] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
+			"[METRICS] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
 			"tolerance=%d%% | actual_error=%.2f%%\n",
 			a, b, diff, limit, err, actual_err);
 
-- 
2.51.0


