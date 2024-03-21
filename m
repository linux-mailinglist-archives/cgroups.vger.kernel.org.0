Return-Path: <cgroups+bounces-2134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E9188629F
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D285F281CDE
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410B133402;
	Thu, 21 Mar 2024 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="zSqd56SX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58C288AE
	for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057201; cv=none; b=SwD5MNnhX5lzlbnc3tc+RVMtahwVrjYO0udn+bJf/d8cCGMBEcFu0fwAKGl9kfoHM6yP23I7AetHuwSskuggexzA2dQPucoUCufJCZNLg81Sa/DrdxJ7nRZ3XoEFoJ70ivtgWeibeZSTB2COGjGxW5uPRhmjZ1YiqwdAQG/vbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057201; c=relaxed/simple;
	bh=9JpS6KAXEOFmQTtT13jK0VIbwgLcizERBsznmhtbmnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLCek7DY/RuyPJCLIsCGpIxc949Lfu71S1ko7JNxH1SwKmXXK7TBTHodi/jCPfoRCZy2hTE7gbsIg3Y8zPn85g8jl8i3WmhSTHw7mOEQKT624IqnRHGJWa8AiEz6k3jXNekRa2QkHi6dPARZOJaCJx2Cw6F9ToZ8nVaZ1vu1kyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=zSqd56SX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4707502aafso260072766b.0
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1711057196; x=1711661996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwhdyN7AsQYzSI5E0ACkhQQKRIaxkJYTdHVc6saznAU=;
        b=zSqd56SX33UuVK7g779iP3bq2AFniIvls0uzRsEvRSsni3Tn7rT+0Cm8MBmDk6jm4Q
         QQBIweXX08mSCp6dOrcVIwH01ANY8M7DWEb6b/k2gNkvlO5fmpUJNYyvQUUa9Ia/wMnO
         xzxm2LYxEvbwvHgGeaPiFUEvwg34S35/9eyCuuZbkPYGNiZnNoUdAPA94URheo69xlDo
         8HjrRPLWXMfUuSxfT1GidezjtpxdZ52n7j8U9HDx7xIjE85+fzbycM+DmXRZsd4kQWfD
         UWraz3ijkV7NWq26sTlcUIpFDQj0ZYoQqsYnahai0PhkfBBUOzqERP/42CIYn2NmRR1v
         Uq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711057196; x=1711661996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwhdyN7AsQYzSI5E0ACkhQQKRIaxkJYTdHVc6saznAU=;
        b=i3hKaUgpHBO0rffZhXIueFsX5NoyXl/jTY+ANhxDnQh6s5W1mmkf00+OOwyVuYLzH/
         zqNTtY5eggaSQpSESWAZjSnDwwqHQDO0h5bxgQ32A3fXMmkucyJFINXvGoEgzMlvpJW2
         NodIIWLtj5/j1ZqiTBrwTdxnR0SJef8/dKTHp/OwIuscpnHmH6b1icjuaO608f47542V
         Q+rxPt4O2GO4shfBjAgt7ALoapbe0ZH4ebAcF3XGALxgY90839wNjtS0xsOCPWxDRuRW
         dhramdG00lZ7xks86IuGrcICFFVaP3A1NtD2vbCdDAG5gefcxPz8z9umtIm02Z76GdYy
         oakw==
X-Gm-Message-State: AOJu0YxnB6Hrql0B5pceZ7F/xTFNYk577E8GIhuOPCmmniTfJOSlIUVy
	0V7ThsssfvD1rAxUUHiHJezV85OmadKRceCEB6drP8RNpox2wQaN/oYkrQFHPYNTJADgk53Dtyw
	H6Q==
X-Google-Smtp-Source: AGHT+IGxtWbfq2Qz+ACrx7qKgAfQFexGvP/hfMcQgp7x3zSd+gluN/nIJp04+Hd92FzaQjglJrKH5g==
X-Received: by 2002:a17:906:c10d:b0:a46:bde9:c868 with SMTP id do13-20020a170906c10d00b00a46bde9c868mr188268ejc.26.1711057196376;
        Thu, 21 Mar 2024 14:39:56 -0700 (PDT)
Received: from localhost.localdomain ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id f6-20020a1709062c4600b00a469604c464sm325806ejh.160.2024.03.21.14.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:39:56 -0700 (PDT)
From: Petr Malat <oss@malat.biz>
To: cgroups@vger.kernel.org
Cc: tj@kernel.org,
	longman@redhat.com,
	Petr Malat <oss@malat.biz>
Subject: [PATCH] cgroup/cpuset: Make cpuset.cpus.effective independent of cpuset.cpus
Date: Thu, 21 Mar 2024 22:39:45 +0100
Message-Id: <20240321213945.1117641-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requiring cpuset.cpus.effective to be a subset of cpuset.cpus makes it
hard to use as one is forced to configure cpuset.cpus of current and all
ancestor cgroups, which requires a knowledge about all other units
sharing the same cgroup subtree. Also, it doesn't allow using empty
cpuset.cpus.

Do not require cpuset.cpus.effective to be a subset of cpuset.cpus and
create remote cgroup only if cpuset.cpus is empty, to make it easier for
the user to control which cgroup is being created.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 kernel/cgroup/cpuset.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b8000240a1476..72ec7ef0eabc8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1459,7 +1459,7 @@ static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
 		xcpus = cs->effective_xcpus;
 
 	if (!cpumask_empty(cs->exclusive_cpus))
-		cpumask_and(xcpus, cs->exclusive_cpus, cs->cpus_allowed);
+		cpumask_copy(xcpus, cs->exclusive_cpus);
 	else
 		cpumask_copy(xcpus, cs->cpus_allowed);
 
@@ -2987,18 +2987,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * cpus_allowed cannot be empty.
 		 */
 		if (cpumask_empty(cs->cpus_allowed)) {
+			if (remote_partition_enable(cs, &tmpmask))
+				goto out;
 			err = PERR_CPUSEMPTY;
-			goto out;
+		} else {
+			err = update_parent_effective_cpumask(cs,
+					partcmd_enable, NULL, &tmpmask);
 		}
-
-		err = update_parent_effective_cpumask(cs, partcmd_enable,
-						      NULL, &tmpmask);
-		/*
-		 * If an attempt to become local partition root fails,
-		 * try to become a remote partition root instead.
-		 */
-		if (err && remote_partition_enable(cs, &tmpmask))
-			err = 0;
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
-- 
2.42.0


