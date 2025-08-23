Return-Path: <cgroups+bounces-9348-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CEEB3266F
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 04:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE141CC3DCA
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2D11FE47B;
	Sat, 23 Aug 2025 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjDUF6lc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F61E5B9A
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755915694; cv=none; b=Fpc3ig5lKEDhe3CYmiFGDF59N3Bqy9dt+lr6U5CI8HiG9aYdO+u9YCQjAHPf/+L7XZiIIeB4c3S/s/ctiaJ1fe3rp/jtNmDUTdfQod9owhowSkmW6w48G4xt/lSMIruAfDjCcK8OuiaTl6LLXvsS9KE4a5OVq//A2WTrT1I99cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755915694; c=relaxed/simple;
	bh=jBj/gRayLOzCkdeez4lnYkrxU6Q3udWRM3WzLaFy8g8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SH50QVGseQAhizniQCiiEaSNUCBb9b+LbdQCg04flmIZsfYZLQrxysIIrcQsHCr+WZVF8YDadxrGTwjsUOYQjImndfXCllURsoR7gFo6WWX8UENRQb2xT8kFMckkdeJxFwW98YqGkJKujpvOx3SZJUwye11t7QtjMyRFKUk2Uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjDUF6lc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3252a37fda8so926444a91.1
        for <cgroups@vger.kernel.org>; Fri, 22 Aug 2025 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755915692; x=1756520492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yumVdUW2USkp8wMQlf1T0GfBaJuNGEtBVPiqhinpjf8=;
        b=hjDUF6lctyneeHG21hV9QPsVh7rDeQlQy86aRslv71Yorct268OuTIC9EXQw7J4jfA
         Frc0otCdwFpOjY4veeUW4/3gVRxe7gg7UtqebG1Q/ndsdhvbl4423ycX8qDODNfUoQ9+
         uy56yjEIHW+sWQrAYArpxtDEcOWMKcr7Otg28rWu1GsbtRRFNcDsddptuivsin4GyboB
         2I5uPgcQ8ZfZMsWtB0PSTqEANi/i2Glzfxnhv7mr5JRCqHXuRtb7186N5Iyzh6D7Qi5S
         qgagIWCWk45jFYmyxgXj8Nefd+cMRbLt6pp8HBEE7IUhSF+vbiu+996Vgd4CadreQ2OR
         Vpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755915692; x=1756520492;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yumVdUW2USkp8wMQlf1T0GfBaJuNGEtBVPiqhinpjf8=;
        b=TphdTpgVR8vKaSzy6+G4Pgvk85lGRByPv6iPVlgH74OhoILasZ8Z4w4i3IqQttbBQw
         fYCn5VW97bAjKme+sD9FDyy7k3I50BG1A2hJVz3BZQGLMOBYqtgJYE433hheYlQI5Bh1
         e8V0ZvUMqLUXOrQC2pPxL1fPPGl8jcdO26zPu1cZHKncIze2jjtdt+LAPO5MZCSrA4ir
         nWRpzD2K8ngFp5Khi3y7k2tqB5jlSGxJkxEzsYtD+MkCfWBqm0+Hx9LhowGBSRKP173Z
         JOZ2Yr9Rg5aLOnpV9LnRscDM/afhTgsogAUfnMV9wKqa4v2EqtK4vPwr2f76ImK+9rRb
         ek0g==
X-Forwarded-Encrypted: i=1; AJvYcCXAlFz9I7+hzV/tGwX8zgAaGrui9mFuV8ZHzApC9ZTvXB24uW7gQUTOtTOIEBrBWQitrGQ+GTCF@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPyPAEsJUY682uDw+bMiE5v4Pf4Ohbrv4NOETUnq0fldoQ4YJ
	7GSZtXc1dVJhR8TKeq0moiOKt2lCMjbPlMWYYHytd4WTtYeT1ZmZUXexDAkyaNKasISuwmukHiJ
	p1e87n0AOYQ==
X-Google-Smtp-Source: AGHT+IHQNZEBo03OP0NAw4M3VYmXUbo486ONyf4yvffGAIxAWSQi66ao04SwtLrUzQp60CzWdMWgm5NsfUkp
X-Received: from pjbss11.prod.google.com ([2002:a17:90b:2ecb:b0:314:29b4:453])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ccd:b0:321:c81b:29cd
 with SMTP id 98e67ed59e1d1-32515edd5e0mr5924068a91.1.1755915691987; Fri, 22
 Aug 2025 19:21:31 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:21:28 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823022128.3183940-1-ynaffit@google.com>
Subject: [PATCH] cgroup: Fix 64-bit division in cgroup.stat.local
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>, kernel-team@android.com, 
	Johannes Weiner <hannes@cmpxchg.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix the following build error for 32-bit systems:
   arm-linux-gnueabi-ld: kernel/cgroup/cgroup.o: in function `cgroup_core_local_stat_show':
>> kernel/cgroup/cgroup.c:3781:(.text+0x28f4): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: (__aeabi_uldivmod): Unknown destination type (ARM/Thumb) in kernel/cgroup/cgroup.o
>> kernel/cgroup/cgroup.c:3781:(.text+0x28f4): dangerous relocation: unsupported relocation

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508230604.KyvqOy81-lkp@intel.com/
Signed-off-by: Tiffany Yang <ynaffit@google.com>
Cc: Tejun Heo <tj@kernel.org>
---
This patch is based on top of tj/cgroup.git:for-6.18
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ab096b884bbc..b38d7a847ed4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3778,8 +3778,8 @@ static int cgroup_core_local_stat_show(struct seq_file *seq, void *v)
 					cgrp->freezer.freeze_start_nsec);
 	} while (read_seqcount_retry(&cgrp->freezer.freeze_seq, sequence));
 
-	seq_printf(seq, "frozen_usec %llu\n",
-		   (unsigned long long) freeze_time / NSEC_PER_USEC);
+	do_div(freeze_time, NSEC_PER_USEC);
+	seq_printf(seq, "frozen_usec %llu\n", freeze_time);
 
 	return 0;
 }
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


