Return-Path: <cgroups+bounces-9012-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C8B1CFD0
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 02:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA3818C19B5
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D484437A;
	Thu,  7 Aug 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoByfNYR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0727470;
	Thu,  7 Aug 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754526841; cv=none; b=lSGYTy0zCzaHWLH0rJGpJUEbMwknMNqLIKyPY3haqBlYmiXl3kypoyrg80FDxXWzhTmxeWX0ThZw9OVydOcXx24yjyWjkrD4X0LpGBH9PQVqM1itMyYBe2Ihmw7LruwGzRYqGH2FfpXK4ws3TdMNh0fDh/Mcve49B0hUYTwDEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754526841; c=relaxed/simple;
	bh=VYOWZtdzQ4tDaLIX+qMsbEoWjZ/bfKPNAwSCFCJ6PqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=er4MsnQBrpV3DsRlZ4vQiY/6d/tUd7aGcYOs6q2VH1wYuNafSC0QF4HmKVONKrLdgx5VEDdYIafEkGP+bMKgQRw0nlGlrZHaNqAs9xH9SJRPyMAUvwy9RRt4sCY3wutX9pTDEWy2zai8emN2rLBzTgX3L4NECf+2Qc1KOAx1Bms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoByfNYR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bd202ef81so657105b3a.3;
        Wed, 06 Aug 2025 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754526839; x=1755131639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tiTku60k8p5ImM/pvxipR4naXM/OfAJgGMmWTFEOoZM=;
        b=MoByfNYRpCed4cRzKr+6VizJEXZgfmWpczrlFGavPX/TtyBXZE8IhUwTaxsps7lr3O
         Zmxy9CUHD0BMyWarpuMwGwmRWEFd5o+6K1SgHUj3Byoz9//57mBFU5xlASObcGMxOcrz
         CiupTZA1YB6bsmfG4xQMPqBNC8LIH2Fqu3m/50wlE7NdTcr4bcPG3WQ5X1ZxLW3w7Xgb
         dL5T1wg6ImEYpMSR0dHU0I9rCHaoQILl6COy8gLN7D9HCp6UMMxcygK2s2bUtaDN94uh
         60Qjuq4IWIOk1KFFm//MHxjb5JFGmV8HYNDL0n3LIcuba/8pitvE4cYPSaroHbYqTk5X
         pEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754526839; x=1755131639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiTku60k8p5ImM/pvxipR4naXM/OfAJgGMmWTFEOoZM=;
        b=QbSag1oqNwz9TpCHjybYive9KEUp8xci829mnQCCV8Q/gOCwbn3auyY93hL/axQlAC
         uaaH55CjziUePrwGJjwTNUATrfrt83TUM5olegsjq0fewYTpD911uz7meqrpvkKCDND9
         cnna3wZCLMRed+3KFos8cFrXdN6kWuWnfJQwMFJWqbosQbGznPjI9ztqQC89fDGLYWvh
         cXQpUilMYWquzNfoY9aEW35z4gNNT8BA6zKBAUkKakG3kOP/k53bjww4ApJM9FlA2tDH
         tYaEuLwf/PtjL/3UAAqG7ys7ew1u3uZSgfTdOw7EykaoMPTME0RlAz4hIy2o/tnIIf2K
         5DqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpSXH6vEbvr3T+s4C0gVANz3VlPp1PdyghYi6fRXnSKUi378ytThryrKyUnxo1Ro/gF9wxZSlg@vger.kernel.org
X-Gm-Message-State: AOJu0YwTurJLNrK69rXCVgs/Wz0k7lxzac0E6/jsgeuL33/UG6FuMSKx
	i0TmPuxeRshWZr+JWLXZ0zDnLz5jCgoaJlHlEpZw/+G3kyJjX1dmyTBg
X-Gm-Gg: ASbGncuRpx2UP3bYcplG1fj7+O600Ig17aFYBHkdRRNIWAvN9zptePHQ9ReYuJwwKUB
	0vqIIJ4fbovjqxihktyH1IoadJAbTVNMQj89KUwldf1zPSah5LmCwq8bDQ188fV/cZ21worjC4n
	X1BIo3vzWIAFijdJAjTcyaE9u/lCOUJVAJ21583sgChJIG/xhsV2SpjHONcZT1z1MqBhsbpuL1c
	YJYOPRw40Da4uzBhc+albp9T1WdpcXCl4dLh8QgQF1tOjAm50dB709M7pSMwTPVXRZtsuCZ3tWZ
	BL+DQsIN60MI5jcoR7hxgEmm/uydlK8lWoTuh1yzEJhiHVeZWX3s5VbNBl3lmGqKPlemztyIbku
	vo4sM9Eji/vwMyUscqIlubnN66uDmyR83HX+QkrfxRZtCKY1Q/Q==
X-Google-Smtp-Source: AGHT+IFkx9FaMxtb3ZDaH/NZJA8swkUqI8b8EmnoezDxiSjWtNg5Xw2NMoRjlvtptj9Gyp77pCA6Qw==
X-Received: by 2002:a05:6a20:3946:b0:230:8b26:9d47 with SMTP id adf61e73a8af0-24031252281mr7173471637.10.1754526838796;
        Wed, 06 Aug 2025 17:33:58 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:b5a3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8ebbsm16635973b3a.102.2025.08.06.17.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 17:33:58 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH cgroup/for-6.16-fixes] cgroup: avoid null de-ref in css_rstat_exit()
Date: Wed,  6 Aug 2025 17:33:50 -0700
Message-ID: <20250807003350.178160-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

css_rstat_exit() may be called asynchronously in scenarios where preceding
calls to css_rstat_init() have not completed. One such example is this
sequence below:

css_create(...)
{
	...
	init_and_link_css(css, ...);

	err = percpu_ref_init(...);
	if (err)
		goto err_free_css;
	err = cgroup_idr_alloc(...);
	if (err)
		goto err_free_css;
	err = css_rstat_init(css, ...);
	if (err)
		goto err_free_css;
	...
err_free_css:
	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
	return ERR_PTR(err);
}

If any of the three goto jumps are taken, async cleanup will begin and
css_rstat_exit() will be invoked on an uninitialized css->rstat_cpu.

Avoid accessing the unitialized field by returning early in
css_rstat_exit() if this is the case.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Suggested-by: Michal Koutný <mkoutny@suse.com>
Fixes: 5da3bfa029d68 ("cgroup: use separate rstat trees for each subsystem")
Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/cgroup/rstat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index cbeaa499a96a..408e52d5f7a4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -488,6 +488,9 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
 	if (!css_uses_rstat(css))
 		return;
 
+	if (!css->rstat_cpu)
+		return;
+
 	css_rstat_flush(css);
 
 	/* sanity check */
-- 
2.47.3


