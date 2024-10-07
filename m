Return-Path: <cgroups+bounces-5050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E203C99312D
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686361F212CA
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BF1DB528;
	Mon,  7 Oct 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV4ByXZ5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7D1DB35A;
	Mon,  7 Oct 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314943; cv=none; b=QVelFO6VADw5Ku5EW8//VTCJz4ezuhZYaNk9mEnGaNMHC/XmPXZyulChl5PlOoIoZPva7cv8C9oiP/TzuwMINVQmi6AWWxubogGif3Fijj2m+E31OfOBSn7VS60V7yvtVS6NT+NJBdpP4diHhkSoFH9rfPkN5vxE834cw+NgpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314943; c=relaxed/simple;
	bh=OMtfmt7UZCIHfOf7KAR4/uFdCOm7TfQjEgGNpTHnfL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gwzgvfe+ugNd5gnwEFYGhDZbjSPzKX8/RhMl/WSKEDMAgO7840OjSA6rdkV981NeEarqJw3oNkbZENdeFAI9vN3G5k3FbKaMuvJymue5gDytDXQJKBHQpRfeZguuWTt/dHTXEpsWPJ3NKLuntU2tb+fOLZSuURkA7oNIMpOhza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV4ByXZ5; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e045525719so2843289b6e.2;
        Mon, 07 Oct 2024 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314941; x=1728919741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUEA4tpkfLGZlVDysJGJlt9DafoclzzPF7zKuIYvfmQ=;
        b=OV4ByXZ59kpI/G6LMUXx7St8TuvbCMpJdYwahud8TZ38RWvVV4RK3+FQp5xmoINDrl
         Fto2aB1cswNXMxWBxegZi3jrwyT+n4OKjYzPQKfjWU9SyS8HojjA16gbVwyYulmbxKzz
         91hVsM3QBcShN+SSx2J3ykoJ3klq0BfpHtDyiZhRzwxAIGIM2gCh1hLIsf3/Y1xb/XQs
         Eg4zLreUXr9uP1/73IC1PYiY0mKqEn+syDkyampcgwZT8tn6g77vqyrbiFJDk9lpsdUT
         h2n90R5sfSZNFckQ5qUGl39Sh9yeNhGqMH0lwffrtO+7IQBtlozjqX1SD20buNYHDBki
         UECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314941; x=1728919741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUEA4tpkfLGZlVDysJGJlt9DafoclzzPF7zKuIYvfmQ=;
        b=gtU4uUY4YW9YJloBZeznltJAdlqo5pOT6q4J/V+FPxMlb3AkhMYPY9YM+RaVVFghVI
         j19QidLx6g8LmyKFm8w8JYAlC47XHsuTgMepBdkAvBiX6hAxN34eP/VeGgKmeE3ZjjOl
         0Ap4P18G9ciFOgKaAu5ikRmlc5LGcEL6DQyzPXSz/mMueQbluPekEAiv075tS/Z98rlB
         OSderh8algRtoaRXquwoUD/KJxA329/mrTFSzbe7+94e/hy14CENlrFszhJmT7zVbMCH
         2j91QYkrjuvNabTANQEFz4rqi5fu6wLBwUVor7vqp0Y/ks5Eu8/aZcQ8ckOaQoBrHeqo
         Qxvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfqco+PE4CsUILSYsYsyH/xdI35SFmwRH7uwDvfqeP4bnWse8xfhZmUSrKsrXcC4PIIEgP8nq17VHYRCyg@vger.kernel.org, AJvYcCX6suzzdKSW9cvctMho2ioCNG2p3tVQ4Ru3uri66Yk5/rKaPQs1nKwbCpS9sCK8qG2melu2Kkdh@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeFnExeEMQ6pnWiB1cS06nk3LS7WSre5KG1hvofWH5pYLiIy3
	XPyraGK9ZPI3ZfbVRAhOKrZaNEx+7/By2yif64jvpy8Bf+EayVTZliGcCA==
X-Google-Smtp-Source: AGHT+IEbsvR2Q7CP/P+iNUTYbqnLzzq8TPA6J0V2in9TiXF4gmOs+v8wadba5eKZVpOf1AV5HpKv4A==
X-Received: by 2002:a05:6808:3a10:b0:3db:3303:834c with SMTP id 5614622812f47-3e3c156c02emr7865565b6e.39.1728314941113;
        Mon, 07 Oct 2024 08:29:01 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4360337a12.84.2024.10.07.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:29:00 -0700 (PDT)
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
Subject: [PATCH v2 5/6] cgroup/cpuset: Optimize domain counting using updated uf_union()
Date: Mon,  7 Oct 2024 23:28:32 +0800
Message-Id: <20241007152833.2282199-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007152833.2282199-1-visitorckw@gmail.com>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the efficiency of calculating the total number of scheduling
domains by using the updated uf_union function, which now returns a
boolean to indicate if a merge occurred. Previously, an additional loop
was needed to count root nodes for distinct groups. With this change,
each successful merge reduces the domain count (ndoms) directly,
eliminating the need for the final loop and enhancing performance.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Tested with test_cpuset_prs.sh

Side note: I know this optimization provides limited efficiency
improvements in this case, but since the union-find code is in the
library and other users may need group counting in the future, and
the required code change is minimal, I think it's still worthwhile.

 kernel/cgroup/cpuset.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a4dd285cdf39..5e9301550d43 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -817,6 +817,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	if (root_load_balance && (csn == 1))
 		goto single_root_domain;
 
+	ndoms = csn;
+
 	for (i = 0; i < csn; i++)
 		uf_node_init(&csa[i]->node);
 
@@ -829,17 +831,11 @@ static int generate_sched_domains(cpumask_var_t **domains,
 				 * partition root cpusets.
 				 */
 				WARN_ON_ONCE(cgrpv2);
-				uf_union(&csa[i]->node, &csa[j]->node);
+				ndoms -= uf_union(&csa[i]->node, &csa[j]->node);
 			}
 		}
 	}
 
-	/* Count the total number of domains */
-	for (i = 0; i < csn; i++) {
-		if (uf_find(&csa[i]->node) == &csa[i]->node)
-			ndoms++;
-	}
-
 	/*
 	 * Now we know how many domains to create.
 	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
-- 
2.34.1


