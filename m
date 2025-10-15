Return-Path: <cgroups+bounces-10771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA8BDE06F
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9508D19C4052
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB131D72E;
	Wed, 15 Oct 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj6LAsaN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FF31D728
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524458; cv=none; b=SEH4wuwRI+PDalABpLpPkbSOf1Z06o+Auxo2vnkitcBUD5A/u9QqO4lWrW6OApAPeJZyX4OWYV4YgiFGk2H3muVMbVaj+jN0quebEBa3BuVrS8ysXtl+bOomXEreeDkqFlK3eiBxNKVAlLFuUubXpG5cCs/9WNHWdXX7Xxmu9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524458; c=relaxed/simple;
	bh=2x7kwzCRlP1sKi3lfGHA3U0c60f825/CorCmZ58J62w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lANAFYnhA0n3ELaTvIJAzy6ny02/2morKmLpCnP6+D03LxFFuAu+78TNoZ+6kNtUXRzm21oOBh196VBc1etsC3p8vDz1m7qKjtIVB5oL3CSCIrdMQ2V/u5jUyp6sy6M0dBdA01arDTSJVp5VCeJLA6zIdCKY0y/uq/IV9dxdvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj6LAsaN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46fc5e54cceso20412545e9.0
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524454; x=1761129254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACPNiGCPwATUeCmL/kgAQk33AK0o+H8qX9RhyfrXiNo=;
        b=Tj6LAsaNZuLNnqSGZPit7oy1cgp9R4JttOI7WfKrX/m93FL8CMtpXTXCx0ondEbybT
         6ZCKHamZ9cDizgbdMzJgJwG1kpYyKkctzxDjD2OVq4a53pX2Ky5nS+CqEkhW+3ugJTlw
         lhXZW1PyWWw/ZbKWOHQfc5xrJtowQNyzd8Rc7XAZOdZnYN6qcLkxImAQCbFPvX/b4lfD
         +wfUVu6Yi5XJ/ZsbU+02JX1fEH/D7DQYpJjVHPlNqW+dqAuHzulrOgrnq3JdrJP/EYlk
         w97HOXDi5b+xezJrGyU8TZDVarZYPEo21ZMI6xfGheiiQavyHuyvaxzBfxgSxLzeCX8J
         Ts1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524454; x=1761129254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACPNiGCPwATUeCmL/kgAQk33AK0o+H8qX9RhyfrXiNo=;
        b=qFspXUVRRj28F8Lrg9c7sv+87weQQdB8iChP8TSZ7iAEiS/YVMPgO8/0RnFohX6DJ+
         QwraDpSi9+amOQNm4zB3PfkLhRqicaKyXHfh3hOf5sm7hx2ki8SYIN47HaoaJ5kkucwu
         /IneRRxJ++BXEnRs4uXzNLFp+DESIeVK8OrrZxukq8Z/RkYrEzVw/fgBHJJREMuHukC8
         vC2m2gHSpkPKqwxBgNZePmMIAyK2kHSYzaYvRJPwLyRQ+GstdH6Poz/SRUG0tJiUzvA9
         ZFjdE5zpN4lgCHIQUFHFJ1rmNvMdp965QyKNNQY4ITMSM4bTId+82JiCjAp1in+SQ+G8
         9WSg==
X-Gm-Message-State: AOJu0Yxkrch7k8OKJZY2EsuspH9Tki+iTardGCKyBcmadWF08fhRx3Uz
	hFsLImNBBIgDanGyKVGjI2ZnG+LZHAxK6ubqUpBlbf449rp1PRlAEmpRlcF7Qg==
X-Gm-Gg: ASbGncvjpxe5yx+M3rpxdPqgML/82NwQz2ltc2Oqaiit9qw5vPonplChRPxNJPe4kKZ
	Tzua/lIcialqVTGwA0Uuky32eo5DB8tsReXUcWxTBK3J8QP1CgdH6IXULxdne2XxDogkyoE/8xg
	ieCq8ja9EaFSJn2ClVvGW9wlLTPFIoKNUm0CQJXll6QGNxI5dCzeclLqAcNr7qrTzvDc/Pxj/JI
	sDrOy91I+9kAFXmW2LSrHvmejfrM98IjCdcO/b05xHM7L89bdi+aRFSWCwA7izAEPdV+hEmWFsH
	t6EJN72KOdKEVMm8aC8b8m0HQ4BM5hWrdeGvOOUenjjdZe0hNaBDkcZFcxfMUYSVmjrYeUQCbtF
	Jkh/tS6yc1UvpCH1FFon1GZocPRmO5E4yYheXaM8uf5bMNdFYE0rcIyld7ZSFMCfv1EzhiQfEvg
	2WdHjP8Adii+nL4rqmxSmRpV4b3wk/O0S3l4+B
X-Google-Smtp-Source: AGHT+IE1tyhoccaEpgLMPSSZpWghlJ07miRWGtzFCZZn8nSHF0nmIyxis9laBLvF8bEqewdBK1+kow==
X-Received: by 2002:a05:600c:c4ab:b0:470:fcdf:418 with SMTP id 5b1f17b1804b1-470fcdf04bbmr17414485e9.27.1760524454355;
        Wed, 15 Oct 2025 03:34:14 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be4876sm26032825e9.4.2025.10.15.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:34:14 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH v3 1/2] selftests: cgroup: add values_close_report helper
Date: Wed, 15 Oct 2025 12:33:56 +0200
Message-ID: <20251015103358.1708-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015103358.1708-1-sebastian.chlad@suse.com>
References: <20251015080022.14883-1-sebastian.chlad@suse.com>
 <20251015103358.1708-1-sebastian.chlad@suse.com>
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

Introduce a values_close_report() helper which performs the same
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


