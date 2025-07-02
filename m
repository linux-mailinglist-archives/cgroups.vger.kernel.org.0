Return-Path: <cgroups+bounces-8668-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A9AF5931
	for <lists+cgroups@lfdr.de>; Wed,  2 Jul 2025 15:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4569B4E2F21
	for <lists+cgroups@lfdr.de>; Wed,  2 Jul 2025 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A22882BB;
	Wed,  2 Jul 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMNKJRCP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3342877E8
	for <cgroups@vger.kernel.org>; Wed,  2 Jul 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462628; cv=none; b=kQEykaN/R6Wjzw6ophtehlhbUf+muoQQh93cxAb6hpQbnLvbbliHEzGY0KvYtc86FyJYRgWALleq/Oo4dpGXBdmCORPU5i5X5IL9GV95YUCNhC97UxFlVoiHtAkTw17HAOk61z/RvZiuVnto1sXLSSd6Qjb3KCpwWsB5ETtuxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462628; c=relaxed/simple;
	bh=aPKulmtNb2SBclwjfQfDlZDtM3lt/PsVtakgVEEgNPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VORvKkCe9mNP+nR/rJamW5JkVcDWMOO3hHeXug8LA92JGMWERBRwdJRDu4M2vlSRT4ReB8cY1pyTOoqlWc5/d8JT6sl/obODISuXe+rdfsgY770wtKK5XknZli7lWwbiADXMJWscXpgAZoWmtJTACyYrGrTE1g6192FjlSPA/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMNKJRCP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso46298455e9.0
        for <cgroups@vger.kernel.org>; Wed, 02 Jul 2025 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751462625; x=1752067425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlWu/swEcCVMRt/dYJiEnIA9F/yPS0lLV18ASuFkAZQ=;
        b=WMNKJRCPzOGweA4QY7pcLZxT6/J//ZfVczYjbLxtHmRDsZo692y80rjo7vfCUbg7Z+
         qDO63eHAaOpgA+kOffrUuSADkk4oRJRD29aHbOrO+Zry2WbeMfDkV2DWT4gK+sDf2rG/
         AUqfsOsaCr+Q5Uip4yRQfoLlv1LkJaw0V5arPbh8BYqTyn+7r690TyIJ0rq2uZbEezzE
         vDwpJLKt0E+m5qm1R1xJTg9KtkX9tGtp3pZRo7zEeY4mxVwju6zRUDm7fAVFjgl0DkjX
         hAw8E9FPEtpYBMPYo7a837/CU4RxhLdtIlFo6HOFxHIreRQ5OTW77BYSkG58A88scsCw
         Yvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751462625; x=1752067425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlWu/swEcCVMRt/dYJiEnIA9F/yPS0lLV18ASuFkAZQ=;
        b=S25qTGLTDbQxJf4x9hmul66Cp3voqIH7wnyrhvImdfX2/Zhc3jnCweXZGzU5mScQpa
         KwNCt6623WmVpjEBahVTMDD2h/g7PTchAGSbRvyVXB4ScYomjjJ7DBQ/ORLL705BYmhI
         rqPfG1cV58SsV9T6ykl72FvmjIqUFYGgK2m1IP4zZ4nUZZdJEBl883juceIhMyizvLey
         jjG9GV4r3htQ6Qr6ly87Z6pf5Ti89y9r2elJIuU3ISg8r8ZnLnu+1vyXfbpaz+oUhFWO
         H9F9T9QYEDrBEbRpGa+3UnsA9hXF/cfmizb5ksFW/CdTv55CXollrgFwg06Zbz+MHnBb
         u8Ag==
X-Gm-Message-State: AOJu0YyuiPS/sYN7XbpOprs6rpN/VTpHK/diQCy8OEXbDe2ECfMIBsmY
	DOTg2cq5nKymVs84qsYhoTjEK9qcrDDmjsLpczH5J9g+KU+SkjEoovTb3lzpKw==
X-Gm-Gg: ASbGncudaVHzOg6ujr2Gqp1XRFIhC6YybdMr3lPkqW7sE5sxAG9EcP+A1c1GQ8G0Sn2
	5rMVAOrW9voMYq+/r5srke6YZUjiChGBrXuBJHtibo2gQwTni23Kg1wPK7d5+H/9YcC6Me/rL86
	CaEX/22v2E03aZeaiDxgTvHUxrcVelApk9huqIFkuJ2KhILkljfc5J9NXJQzz26wjWcQAT2I/ZA
	dypkCQkOPokcXsVKblZ67zZ8yntosgPCdNtodMwPXBQ7cAV3X3/cv9EbBYa5bqrhbqIYlP/iwrp
	k439D0J0n8lzpsnGKbveuuTI2920yffg3lwxD6w9kiYpym9VTh6OQzK33enaiF8ZtkfE6OSDhVc
	=
X-Google-Smtp-Source: AGHT+IFhkaKZg3/Pn0ud9hF5kAo+HC29USXkXnONyT4EYFGchNazB3qbAovtcl4NaYzEoqtdz4jG5g==
X-Received: by 2002:a05:600c:1546:b0:453:ec2:c7b2 with SMTP id 5b1f17b1804b1-454a3c251cfmr29234565e9.7.1751462624450;
        Wed, 02 Jul 2025 06:23:44 -0700 (PDT)
Received: from localhost.suse.cz ([37.109.164.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453b8f298c6sm24704365e9.1.2025.07.02.06.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:23:44 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@suse.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH] selftests: cgroup: Allow longer timeout for kmem_dead_cgroups cleanup
Date: Wed,  2 Jul 2025 15:23:36 +0200
Message-Id: <20250702132336.25767-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test_kmem_dead_cgroups test currently assumes that RCU and
memory reclaim will complete within 5 seconds. In some environments
this timeout may be insufficient, leading to spurious test failures.

This patch introduces max_time set to 20 which is then used in the
test. After 5th sec the debug message is printed to indicate the
cleanup is still ongoing.

In the system under test with 16 CPUs the original test was failing
most of the time and the cleanup time took usually approx. 6sec.
Further tests were conducted with and without do_rcu_barrier and the
results (respectively) are as follow:
quantiles 0  0.25  0.5  0.75  1
          1    2    3    8    20 (mean = 4.7667)
          3    5    8    8    20 (mean = 7.6667)

Acked-by: Michal Koutny <mkoutny@suse.com>
Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 96693d8772be..63b3c9aad399 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -308,6 +308,7 @@ static int test_kmem_dead_cgroups(const char *root)
 	char *parent;
 	long dead;
 	int i;
+	int max_time = 20;
 
 	parent = cg_name(root, "kmem_dead_cgroups_test");
 	if (!parent)
@@ -322,7 +323,7 @@ static int test_kmem_dead_cgroups(const char *root)
 	if (cg_run_in_subcgroups(parent, alloc_dcache, (void *)100, 30))
 		goto cleanup;
 
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < max_time; i++) {
 		dead = cg_read_key_long(parent, "cgroup.stat",
 					"nr_dying_descendants ");
 		if (dead == 0) {
@@ -334,6 +335,8 @@ static int test_kmem_dead_cgroups(const char *root)
 		 * let's wait a bit and repeat.
 		 */
 		sleep(1);
+		if (i > 5)
+			printf("Waiting time longer than 5s; wait: %ds (dead: %ld)\n", i, dead);
 	}
 
 cleanup:
-- 
2.35.3


