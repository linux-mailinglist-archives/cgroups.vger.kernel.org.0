Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129DE487FF4
	for <lists+cgroups@lfdr.de>; Sat,  8 Jan 2022 01:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiAHAi2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 19:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiAHAi0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 19:38:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78149C061574;
        Fri,  7 Jan 2022 16:38:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 30so26629566edv.3;
        Fri, 07 Jan 2022 16:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+thfZnjVJKWIwHVQowEtHa5pcMezvSbOgv9V4uT2rnw=;
        b=beAqvpsgAzbk5EtvsevPMK/hkrF/5AyZY+Q26XM++1/QXE1h2l/9vVcEKgLFvHqEd4
         2KjHwcqOVB2PQKWyUxsc3FBsaqmSkMPAjrWC7uENY7WiNI7uYjEfF5p6AE2wCcpf3bxP
         zyvmrvK+Ou/88nasMIAtGscl52qJopK41AIPuNX4PsE1T0izPuK0f6paZCeqNpMisLch
         oG95OnSQS96BtQ+I7BhH04JxkKmD1md4tkaOtv2In1k1beorC/qPvHckSJWb1RLoLIOV
         gtcUHo0g9sASNT1XZzeJ2pcdmT0SNqf5ug/AdvdNAAoM7kiWC+JCpH9CPYs4zlgFffu9
         DP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+thfZnjVJKWIwHVQowEtHa5pcMezvSbOgv9V4uT2rnw=;
        b=cJGyINTVne6hVSCr3CIv16vnvi/34iBvbyA2dKMLZPDLzye4UxY73QIDGSpf9R5MlT
         aHBMupRTOesvtvcknXFwl3H4jKM2fBEpNiDZP4NemHEohs9Hm2dmjVfyTeM7XwMF0vw9
         DpQUEz0+Hht1nMLqS3M8XKvkg5oicIIDx3vgxabjMfLX10qwSMteVCSJSpijz58SYftj
         bxkq5zIRgC++9WggwjjrQ2AgVyvPIgO7KIHFSGrFJoDqkUljnXt+1L2XqXw0Qi9Dpep3
         2ufxVgpcfqKiUsfmRhPfpT2E4Ivgr4qBGbVs8amx41n0Fo4Md/Jo3g0tIvvomi7CGoDb
         bESw==
X-Gm-Message-State: AOAM532Uv2Khal771NNQIAugXTZ0ajSuNO9jhImtDHZJufUyOupiAhzI
        s1SvqvYRDj1g5I+SfrEbbQc=
X-Google-Smtp-Source: ABdhPJwJWZ9UeYPbTNTfdB6NYAglMp/1dgdHF8xmR/r82IRF5TGJsFCKa7oemGjLK97Doa38oVO2sA==
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr63317621edb.318.1641602305146;
        Fri, 07 Jan 2022 16:38:25 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e4sm52958eje.103.2022.01.07.16.38.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jan 2022 16:38:24 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] cgroup: rstat: use same convention to assign cgroup_base_stat
Date:   Sat,  8 Jan 2022 00:38:16 +0000
Message-Id: <20220108003817.6619-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In function cgroup_base_stat_flush(), we update cgroup_base_stat by
getting rstatc->bstat and adjust delta to related fields.

There are two convention to assign cgroup_base_stat in this function:

  * rstat2 = rstat1
  * rstat2.cputime = rstat1.cputime

The second convention may make audience think just field "cputime" is
updated, while cputime is the only field in cgroup_base_stat.

Let's use the same convention to eliminate this confusion.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/rstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a00875375f7d..c626d5a526c4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -324,7 +324,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	/* fetch the current per-cpu values */
 	do {
 		seq = __u64_stats_fetch_begin(&rstatc->bsync);
-		cur.cputime = rstatc->bstat.cputime;
+		cur = rstatc->bstat;
 	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));
 
 	/* propagate percpu delta to global */
-- 
2.33.1

