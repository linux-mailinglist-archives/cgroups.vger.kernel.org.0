Return-Path: <cgroups+bounces-10764-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F1BDD461
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365021922664
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C435F2C21F6;
	Wed, 15 Oct 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og9uLp3d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885D2BEFF0
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515256; cv=none; b=HkVwdPCUD8mwPHM66h8qXt6curvOkbIzGBWnzDCSxSnKb3+oUv3hcP9P56Yzi5vFGGoOXkyPQuYQ7L1QNefRwzBKNFrNTnPK7yRmSKIPGFKFZQpXt2633d2j4WwW9979leA6keqnkp+k7VVYPmLi5C7Utf+dC/n9Dmnj/h2TMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515256; c=relaxed/simple;
	bh=fO/xo0y2BCcpgjvIsWqIfok2SsEQ56oWMOaClJaUkFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D76rhySMO4/EAsBVkeOrLwEleFz5iS+luOdcqWUaOESp/0257v3krLS3zjE4Zrn0f8629jI4pwX5skjXuwYd0CnXt9o2ejzdgKnsRrgTYOmedmVuwbzxAsyoT2rdK1mTsy/TLqkIQXTpwsvOsILRZKZjzeR7pT/8C57LwvreG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og9uLp3d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2e363118so52407585e9.0
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760515253; x=1761120053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW4LqkdBRdyjIzBlwSlPKXpQF5rxKjZXPRGr6XSfKtw=;
        b=Og9uLp3d4F8RXP+svPKuYbrw8j0d5bLDwHIOMinSQlRQuc1OXgxUZOCXhqW8UE20LF
         INBXU3NLqh439NM3NNT0n12K+uVZGioMP/59osMDyo+DeXS6U792IQWdcEH+8e10tiV0
         3uTG1Ro17i+hNIpbxsDv1waLNzay5z1q+r2HbK5I0ulfnJqVqoTdQf2F9axfUpwcRISY
         kvAeTsLe4+Tk+H4+mLSP+IBbMzOzT4nlyoO3GFbpwim/Y2gRyPWHSCbIvASz0c1+WjWU
         +eUWQmven1Rg3YFPfAcdweeQ4rJpLV4oiqz7b0PjJz6ygBsT/hbfhUMFzDZRPx83FJKS
         JUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515253; x=1761120053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW4LqkdBRdyjIzBlwSlPKXpQF5rxKjZXPRGr6XSfKtw=;
        b=Vd+V/xSLUAYDMyX+rMHZPMxwsqddFnmY1vh9rf10G8Hd7hKvZUyknCz8lJ5eDa0SQh
         TmayrhrYerIKML65grW2/I6dvtA0vk6A17iMmvFwvTlJ3yzrpeJlvxB2cn193hZG0R5S
         bEYndehqvKdcMklVGOWo2i4XbtzrJtOIHOybSeSLedxwdcOlZ+SSo/2sf8X2uvo5tyBM
         FD9c+xgXCb71vMvlLnSzPpSIIjp57fivzWVIyg1j8EB7J8eGD3diBgeDUlP7YLlLHt+Q
         ELQAP4o3/zVR4CZEm0E3AVZ7LJoeEGdVzkv9DyPLRfV78aDWY4pUigRF6MBuJREK3CXS
         KNBg==
X-Gm-Message-State: AOJu0Yw06JkpWbKmqP1PpDtPrfJwWxUlGK1K/Z0g4iZ0UpqVAH5iasQu
	x6XT1ePBa5Y4rrf8E+fa9TG+gU9hATZ3Rmec03uvLfZj+J+SzxRxKG2p1W8tqA==
X-Gm-Gg: ASbGncuNgLW03VukQ865PKb01Qno0E9Z07IDmQpMkQJBOPzQ+6JCovxKmKNUh5rOfqN
	WOAJ0pekp5sgIu/JMC0ne4i4/PRpO0HYXCIfYhpi4CN9xyb0S+hGx7cWFR9Hey/5y8VPfdNJ+R1
	t+GmSMiJehHZ6e46ZAzqQ+UvJ/qelPgDxVz2V1YXGG2psqBwVpvpvPerMuvyI621bfB7xZh3RYJ
	BIcpq8E5jqmd47qYDnmIGqKDmKq1sAyB6d/vMuMytHcrzuwBa647J+8ac18xxElI3RRKHYewJY4
	FgrYNF8BHxXvAlz6zSLiHh+fhhi+HiJkVJeFYDpfhjn9M3csRW+42Y7VVGPrH6ebJgNjc8WuCPm
	Idy0n2IQb6WqxJhf2ENESuVheAw8WXxH0Tr3cw8r95m3OvKL/2ymkTOYgHFm1FC7g0rspGE6RDj
	Mv8lzaMxbhJdGV3uQ=
X-Google-Smtp-Source: AGHT+IHAUPMMlL9GxedlofFjXKt07x5bjy7a2bWw5k56kprfJ64+YVqsdM931d2XPpMSH9AQMv4xfw==
X-Received: by 2002:a05:600c:4ed1:b0:46f:b42e:e393 with SMTP id 5b1f17b1804b1-46fb42ee481mr131224355e9.40.1760515252583;
        Wed, 15 Oct 2025 01:00:52 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm27520095f8f.42.2025.10.15.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:00:52 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: tejun@kernel.org,
	mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH v2 1/2] selftests: cgroup: add values_close_assert helper
Date: Wed, 15 Oct 2025 10:00:21 +0200
Message-ID: <20251015080022.14883-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015080022.14883-1-sebastian.chlad@suse.com>
References: <20251014143151.5790-1-sebastian.chlad@suse.com>
 <20251015080022.14883-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some cgroup selftests, such as test_cpu, occasionally fail by a very
small margin and if run in the CI context, it is useful to have detailed
diagnostic output to understand the deviation.

Introduce a values_close_assert() helper which performs the same
comparison as values_close(), but prints detailed information when the
values differ beyond the allowed tolerance.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../cgroup/lib/include/cgroup_util.h          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 9dc90a1b386d..7ab2824ed7b5 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -25,6 +25,26 @@ static inline int values_close(long a, long b, int err)
 	return labs(a - b) <= (a + b) / 100 * err;
 }
 
+/*
+ * Checks if two given values differ by less than err% of their sum and assert
+ * with detailed debug info if not.
+ */
+static inline int values_close_report(long a, long b, int err)
+{
+	long diff  = labs(a - b);
+	long limit = (a + b) / 100 * err;
+	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
+	int close = diff <= limit;
+
+	if (!close)
+		fprintf(stderr,
+			"[FAIL] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
+			"tolerance=%d%% | actual_error=%.2f%%\n",
+			a, b, diff, limit, err, actual_err);
+
+	return close;
+}
+
 extern ssize_t read_text(const char *path, char *buf, size_t max_len);
 extern ssize_t write_text(const char *path, char *buf, ssize_t len);
 
-- 
2.51.0


