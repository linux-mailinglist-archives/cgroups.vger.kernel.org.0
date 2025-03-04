Return-Path: <cgroups+bounces-6819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89993A4E581
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79ECE880C19
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D12862BC;
	Tue,  4 Mar 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MSKlbFbn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D92857FD
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102739; cv=none; b=HeRBqhi+7QV0ewMLoUXZQDo/6+mVuQYWx+0Sjw6CQc/asN1UydwQX+xlveCwPrFnxWsuebOTPDA/iheTt4rahUwhKyNfqzysZYWEosF1Vu2f7Qs1+EMmOWq9D7jZ01tDCIWgj39uVZ59FFuanHaOQ/Zr2OPPGvoWUVlu3oanmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102739; c=relaxed/simple;
	bh=cHns8fqxRp7euip5mPfMcCQkmw1AJFKlvqhDmvw49+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjVASjotAekdjcZNy3r1gboZZp2FzpDJCfK7PTTv7W7Fp570aLT3Hw7SwHLaSijl1HUnuuNCPgViiUFw15JfbYsgOHoovgNqJB28TZ6yQNV9uJme/4EZKIyhrdmIE4P4SGMm2yBc1FW9vq2Fxy/K1y9peOvlnPbmb3L+rLczgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MSKlbFbn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bccfa7b89so6208755e9.2
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 07:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102736; x=1741707536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBPZZxD2lIKyHp8wqmCpoZT9q9nUxOdWhcx01NnsOjw=;
        b=MSKlbFbnpfmgz5nTwVs4Oufvas/KA4uM8n/f8oKuhd0j8Cwhhr6BwiXr9DWVb5PqaX
         uY+3ytvDvyPecRbxdLSJW08F3hJ59jTE4HIBM1p295lyRMQhUvBrZfRbtdaSA4H0IEEN
         AzPXgGtJZAuHmpWFDWmX7vw8fUayakPRoU2j+gPF1Y7R/0HWxSF9p4xGonAqC8Zb9fm7
         WifCTiRhX8J4re/aRNwWYFHhSAKSaVIz9LnzB1Mn97OUs2OejYMZdWdSgCYobWz8Hhod
         C5KmKSam97nGoHYyfD9EBpXjhFXrUqnShXakh8FYTp4n6C48JTohRc2cw67bf067eug1
         fFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102736; x=1741707536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBPZZxD2lIKyHp8wqmCpoZT9q9nUxOdWhcx01NnsOjw=;
        b=nlhBilF2NKqOjwA4MMDskg+OlRWl3lxFi7tJuAzQc8mJxEAN0V+lg5f3KU7gSouRgW
         JnobJWCk4wvkiGkA6SllsZueCZJkf+Roe0L9k8QlwmeVJLZT6xSrnuE0786Mee7dzwIl
         gHYljTrm/NhcTCzXyvu/OCITiVdWlzUrUPTQi+mv6waJ+aclmetkmzuImqz0kWaoVze7
         bAiicWhWNHjizvk95sb3q5sbj5WHv+NJRme5/qlHUrgbWTX6WoETF1zpjb5fdHwviOvL
         RI88Xq2cFYLhJYxPJI1Nv9+Umxff9INek1BKQkyfytf+ZEvxC8eBPrlBcfYcHb94X3WY
         +D3w==
X-Gm-Message-State: AOJu0YzlY3Y2mwWqyHWg589mHMmK2XQUt8FyCtZiIwh3YmEOjfawvM4v
	yopfo3se9wx77lCx+dOScKDKsOWXLI4ImmsO5YfSkMhKOjFYUMzEO5wDX8S9IZ8nPIq2sm6/TPC
	lE2U=
X-Gm-Gg: ASbGnct8hhy+Oq47zygG8vWtyWpZu5hQhZNR22g3R+JIz8pB4F/R1kLBKy/P4fAbSUj
	795tF4ZQtYYmljKeR4dKf77yHgZxuZ4FCxTPzuS75PPgGF47VVciCNr/r5nlQhVsAN9hJnCBSGy
	on+VQ5r0NzZ8t5d+vTOWJQ6zXaOfc2ZINqzmMO7/uUbKpuvYVwJe0YrkOdz3/LUMppj1qDcRHrL
	2uUnYM7CGqVDp1TnQbdtWxc5Sf25adbr7EiFI5mNPyuUxWXB9jF5b6lyKaIrazLvyYF+kzT4Lep
	uTd9vlxOiwIb9Wg/PxRZLag9YPKLmBVF+dLYWKQGnPngjLA=
X-Google-Smtp-Source: AGHT+IFobiCmJ5R4HiRsL7pd40Q47J6t9IkNByEpgJJ+za6Nh1z2wpG/Yd/Pf+T6IGoi+Jf+ap0SAA==
X-Received: by 2002:a05:600c:a47:b0:439:969e:d80f with SMTP id 5b1f17b1804b1-43ba6773869mr156464875e9.31.1741102735859;
        Tue, 04 Mar 2025 07:38:55 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:55 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Paul Menage <menage@google.com>,
	Paul Jackson <pj@sgi.com>
Subject: [PATCH 5/9] RFC cgroup/cpuset-v1: Add deprecation warnings to mem_exclusive and mem_hardwall
Date: Tue,  4 Mar 2025 16:37:57 +0100
Message-ID: <20250304153801.597907-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The concept of exclusive memory affinity may require complex approaches
like with cpuset v2 cpu partitions. There is so far no implementation in
cpuset v2.
Specific kernel memory affinity may cause unintended (global)
bottlenecks like kmem limits.

Cc: Paul Menage <menage@google.com>
Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 9aae6dabb0b56..05d3622ea41e5 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -424,9 +424,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_EXCLUSIVE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEM_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_HARDWALL:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
 		break;
 	case FILE_SCHED_LOAD_BALANCE:
-- 
2.48.1


