Return-Path: <cgroups+bounces-4769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D4A971F4B
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F64F1C23471
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877516DEA2;
	Mon,  9 Sep 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FskJ6rvq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D9166F07
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899550; cv=none; b=hfSzb5IDk+xvofxOhJiBQjZQbJVBrIZyO0rGzbo4vhKJa5W81nb9Ofu1VA7zWUHBjpBPAiy7i0Iv+Xg9H3btzVgC9e63Wy8zbDrnwsUOff3OpfhukWi6GgLDIercAkl9yvWm8QpFh2xYc4889FjiE3Sg2speKzICIYyZGFU9Fjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899550; c=relaxed/simple;
	bh=+jtKQ79qkwGmLZ8LQTtUxHvnXR3dvvYB7R64gvm9pY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TES0mPizJ3kBWeRLT0mGZl2dGoIw5Eu+mpGj2hTAdKVpZCHGK+pEl0XVh5tovb7eFsVBC6X+Oep5OmbXmNzeljTx1hpTSQ9yRn+SvudEl1En2yNJas68CcCSGdfA4Qx5R8A9MLXsjSfS8dpsRfzy9kyvhIZDvLLi0K3kQHd9DLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FskJ6rvq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so39201965e9.2
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725899547; x=1726504347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hN1sbdsSr5xjIEEi3K2BOZrBarvDPImrotZrDBVesU=;
        b=FskJ6rvqV30OtSq5ORuDrKCtWIsRsc0tXF7IEf2hODbR3mflHq2pG7cUyrPIosnYA8
         2h7Ic1tgRdK+lMUaN6qcSPdM8xL5cnzzGf2nV2FIlKBXdsP6FMx116HOv+b4PYSaAcws
         Ebvr31DGnXeKLnTolVvFqT/bUE8eCdRmvPO6PW/2VEPD/fS6QUfWaXS2s6LbHBBkTGiL
         7XhgCyoC1B0oSFq9EWZsXrRR0cXL/c6Iu3YrUBaGdGTAKkWuGu7a9aptd4mWBPVXLW3Q
         n0vv+EyMbMHdIXXdZgWH/p5JJwV0hsRY0DdnZJwQMkD4L7VXUOIiVxGprAYhrNekxjl1
         PI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899547; x=1726504347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hN1sbdsSr5xjIEEi3K2BOZrBarvDPImrotZrDBVesU=;
        b=o5zYkFRBL2U8OqtLgM3DD3TeetmQpIgPcv97+PpTErxTQCo466BsB7XJVO/5nV9ZNa
         CvWtPqCUQt0EDekI24KFO0ez+RqXoF0H/VBKoPEp91FW3r3hY31hkfOUFX8ywSZp9rbT
         HhTz6IhSiL6CUt4gppc6BzTCDY0vULKiDqPAFOBLjGwRbsHTbpgmTndF3jgUMXya0Jq2
         UwSpU0GBx0Wd5/LVVSuwwsZ9pRBWlg+XsE0sPTQxN7+nHW8dPNzwITQQuq8l9xUHvIyX
         rFwVltbolXWOFmr8XMdkAx8CWT2s2nM03A5pe/5TL7lvIJzz9FUvafRuhbcF/TKcMbDQ
         HXkw==
X-Gm-Message-State: AOJu0YyelxdxDF613IIzkxEQQ6mTrHSLgJ9FQ5DYNiTm8U1Qr5+kjKBB
	btBcPbgkM7g1sGjMAV9S0ng8Iw9oXw+Cg4iSeNhSz/cek+VQUhNr30FL8dunAgFa1ChYzdaVR4C
	l
X-Google-Smtp-Source: AGHT+IGxjAbrDtFXLx+iO1e9KJ4se6OA7eld34L5kuJJJmD5mvX5+Dcs4EKLQGfBldRlsEeQGM6bsA==
X-Received: by 2002:a05:600c:1e02:b0:42c:b949:328e with SMTP id 5b1f17b1804b1-42cb949341dmr21798805e9.31.1725899547259;
        Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a072sm6478606f8f.2.2024.09.09.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:32:27 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH 3/4] cgroup: Disallow mounting v1 hierarchies without controller implementation
Date: Mon,  9 Sep 2024 18:32:22 +0200
Message-ID: <20240909163223.3693529-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909163223.3693529-1-mkoutny@suse.com>
References: <20240909163223.3693529-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The configs that disable some v1 controllers would still allow mounting
them but with no controller-specific files. (Making such hierarchies
equivalent to named v1 hierarchies.) To achieve behavior consistent with
actual out-compilation of a whole controller, the mounts should treat
respective controllers as non-existent.

Wrap implementation into a helper function, leverage legacy_files to
detect compiled out controllers. The effect is that mounts on v1 would
fail and produce a message like:
  [ 1543.999081] cgroup: Unknown subsys name 'memory'

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index b9dbf6bf2779d..784337694a4be 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -46,6 +46,12 @@ bool cgroup1_ssid_disabled(int ssid)
 	return cgroup_no_v1_mask & (1 << ssid);
 }
 
+static bool cgroup1_subsys_absent(struct cgroup_subsys *ss)
+{
+	/* Check also dfl_cftypes for file-less controllers, i.e. perf_event */
+	return ss->legacy_cftypes == NULL && ss->dfl_cftypes;
+}
+
 /**
  * cgroup_attach_task_all - attach task 'tsk' to all cgroups of task 'from'
  * @from: attach to all cgroups of a given task
@@ -932,7 +938,8 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		if (ret != -ENOPARAM)
 			return ret;
 		for_each_subsys(ss, i) {
-			if (strcmp(param->key, ss->legacy_name))
+			if (strcmp(param->key, ss->legacy_name) ||
+			    cgroup1_subsys_absent(ss))
 				continue;
 			if (!cgroup_ssid_enabled(i) || cgroup1_ssid_disabled(i))
 				return invalfc(fc, "Disabled controller '%s'",
@@ -1024,7 +1031,8 @@ static int check_cgroupfs_options(struct fs_context *fc)
 	mask = ~((u16)1 << cpuset_cgrp_id);
 #endif
 	for_each_subsys(ss, i)
-		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i))
+		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i) &&
+		    !cgroup1_subsys_absent(ss))
 			enabled |= 1 << i;
 
 	ctx->subsys_mask &= enabled;
-- 
2.46.0


