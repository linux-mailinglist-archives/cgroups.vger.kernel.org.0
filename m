Return-Path: <cgroups+bounces-10738-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE2BDA02A
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82C704FFAE8
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637562D6E44;
	Tue, 14 Oct 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6YWKz5g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC1188713
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452328; cv=none; b=bIiQbfncSrfdO0+yy3i35KoYgG7ehEmwEhNk/7HMZdl7LXiSopcl2nyE31P7VBe4ajgYfUnxJYmyoVOYQcwhyhCDIFItZW/rwFh2RpBDyvVxL528vIrM56IO9uH3uiew3ICY/jPhZx+iLjA+32jKWj2QdPG4SWt17SHHYo19Rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452328; c=relaxed/simple;
	bh=QJUgNDL3zcgtU2P/oVaJyfXK2uykP9Y85HZuJm8RTwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FklJ+IQx8kKGwkm+zijnbDSi2we0ek+QCk3btk2lwtP5zzptbwkPGNwJMOX3Pxf26AQXGcQm4+gX+u+P1+p5eqs0uZeWLQCjDlZAsnHkE+PfVHABSLMqYLbRP5edti/8rHEgYIZg4TE3SQftiKo95ynSS4CUENNu5WuENzteHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6YWKz5g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so4730021f8f.0
        for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452324; x=1761057124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXVsz8VkpTvzpaEYvhw1ipnTu5LY9oY5ACRJKHTvB28=;
        b=c6YWKz5gQsAqFt6RfNwn1ZLoGSYIg/NiMqKFQRHZfrGOuoLx8r5AWk6SQt5m4uL62/
         CLz9Vy5YeRP3+U4JTnoGvuvQb7ov8u7StYwlUTiTxZcsNrFEFqKEt4RCLNvJCWhwC6cr
         ocIRtN5b81a92RLeFZB7Eu60lCIcMheIXYuHYMboUGGhYbe0PTjGj2ra10SP2cLHQelj
         eGTtDNSv4wMo8WA7Rme1QMxM10v5oniY0h6A1Shr/uB+fNFuW6gENpP892KliMAWfGiQ
         dgNmp1KqhMsKXDzdt9llEH8jWO3ERKforQB13CNWN/q1SYXtVYazrq89Vxl7v7STjUIK
         hwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452324; x=1761057124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXVsz8VkpTvzpaEYvhw1ipnTu5LY9oY5ACRJKHTvB28=;
        b=PRyJmQKDkl7ZnDXOL7H7sNnY1zfU7i3AUvoGb6dOY0+b5Fb7dGjSjexQDIe0d+VtMW
         jP9nBqZvAU3vZ9UQ6REDSLCZdR8HEZdYyBqh0BDBvTMfo+ethgizTlh8AMqr3aTpH2VB
         5xjeNIhsKDvlVZ7JvSMvtDOHGTPS0QrCZkPMLPNXDbnsRiOvUgSEg9EBnMvdfwXkcC0x
         SS/KFuSfmGEL9oYNpWZFxYWfU2dMnM5uHxYcFScP22Q3bXGN1Tftb0UKLmbpiQh/YSpI
         w6xqHzecDOm/nAgkp4xrFYwiEc+yy97+Wj+DrHyJams4p/CScj3bGYwLBKStEWFCBvax
         MYLQ==
X-Gm-Message-State: AOJu0YzRv82+oI9GuM75GogXQLY3BDyPviSGkEfQ8dBUS2UCtPG4EW+l
	yWAOeGY0s4MAPzRCBVpZAoPEMdWKOz7n07ZBne7CNik/q+/01+nifeY9cb8Pkw==
X-Gm-Gg: ASbGncspTJAUFtsa7wV215wqmm44U080ikzX+dtAqK8U1Uve51G9bZYMny7nXpAigYw
	RMvlP07N2UI/qNZo9XSaI7dmwe2Kz2Xd9jLXRz8SLmOyTTVxISAEMyQl/Ozo/ebjoD5mSP6ksx0
	S2yjC21Y9mJ0fcJn+Jcbr7phthlX4LXRMTsDlVa0LGxRQ16jGorE0bsWKMeodMwkAJz0Tixrdca
	YHFl6YQnjU6jqwU4m37RWfEgBF9fsqB9DcNp+D3sWju37e73a3u1Fmyttrxjf2ycYGEKxlsi7n3
	MpZg7AxZAGJQvKLoMVBefeveAo6qTxm+jDOW/jRzyfLNNzqZ66odQD/j2DGRbSL+eZXOTWS3jmG
	o2sGcbSY4a+OXGbz6OZJh1D5lMZOkqObcpv5QNjwKKxxAOKG4g6bqbC/9sy0zYO2VoMy9OZ92ua
	rq/hme1iVVM4ChIvlxmJtI8Yomdw==
X-Google-Smtp-Source: AGHT+IGg8Aa2/UKTALUVr2TPJ0Q+E63R4QrkrhQZ0IGCVr84WPbV6/OD3/AcKgR2lZvjsvAPb85gcw==
X-Received: by 2002:a05:6000:2c0c:b0:3e0:a5a2:ec9b with SMTP id ffacd0b85a97d-4266e8dd3b6mr16745947f8f.52.1760452324381;
        Tue, 14 Oct 2025 07:32:04 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e13b6sm24044431f8f.44.2025.10.14.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:32:04 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 1/2] selftests: cgroup: add values_close_assert helper
Date: Tue, 14 Oct 2025 16:31:50 +0200
Message-ID: <20251014143151.5790-2-sebastian.chlad@suse.com>
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

Some cgroup selftests, such as test_cpu, occasionally fail by a very
small margin and if run in the CI context, it is useful to have detailed
diagnostic output to understand the deviation.

Introduce a values_close_assert() helper which performs the same
comparison as values_close(), but prints detailed information when the
values differ beyond the allowed tolerance.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../cgroup/lib/include/cgroup_util.h          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 9dc90a1b386d..1ed0c6d96c66 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -25,6 +25,27 @@ static inline int values_close(long a, long b, int err)
 	return labs(a - b) <= (a + b) / 100 * err;
 }
 
+/*
+ * Checks if two given values differ by less than err% of their sum and assert
+ * with detailed debug info if not.
+ */
+static inline int values_close_assert(long a, long b, int err)
+{
+	long diff  = labs(a - b);
+	long limit = (a + b) / 100 * err;
+	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
+	int close = diff <= limit;
+
+	if (!close) {
+		fprintf(stderr,
+			"[FAIL] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
+			"tolerance=%d%% | actual_error=%.2f%%\n",
+			a, b, diff, limit, err, actual_err);
+	}
+
+	return close;
+}
+
 extern ssize_t read_text(const char *path, char *buf, size_t max_len);
 extern ssize_t write_text(const char *path, char *buf, ssize_t len);
 
-- 
2.51.0


