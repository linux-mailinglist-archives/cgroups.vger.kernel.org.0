Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF135DA9A
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbhDMJDb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbhDMJDa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 05:03:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0CC061756
        for <cgroups@vger.kernel.org>; Tue, 13 Apr 2021 02:03:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o16so18539483ljp.3
        for <cgroups@vger.kernel.org>; Tue, 13 Apr 2021 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SY4sqotEknC2i6pL+rlRoKqg/a1bJa4Vth62OIkfAoQ=;
        b=uxWTujCWfNBeN/O4X+ntEhKXR936PgNw8iSl4QEH+vCqE24dWezDXJ5p7WmD0nifNV
         13RPIgq8FCe5WiqzrGG9mYC+LTWfv854+V1guX2HA8czTlmwab74maIxGVos9YgK4qpp
         x6NKH75ghp5ZDs2sadWAAR67QY73AS+aI80VF8xuQyio4XnAG/0R44OutaPx04sJttVd
         Vu58VEnVDbO06/xTZsRk6fKVx2pZ7ZoQ/NjQct93M59xTtIK3naz7iG0+kuCVuIbv6nn
         2l4dGWfbawnrcCHrKNIYRNTAMVc+CoyD3I27q7JqsED7dvLrA8hKdCdmdARfnDR1WS/e
         kfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SY4sqotEknC2i6pL+rlRoKqg/a1bJa4Vth62OIkfAoQ=;
        b=B+RU3hHHnCqx9sgaLRV5Gke6HMbe2nB4mxzW5keFj+4CCTdUxzIMEPnqgagqrox2Q7
         fH8CQBlF+xRyktll3YJ/Aqf9jloHZwKD2rasqqVVac29hkqxFBdgAjvrqnP+M6yMVOMz
         rJW6WyT8x/3s7hsmV/fcs1bLM4ouWJ4zV3rtvjs6w9GxFQfUr3IEEbiRu0QKil80G9Fc
         2Qg42kMksj60E7u4MzyHHAVLRjB7aTZQMLw/S0v9jigSeR7PbBhv8wIAmqWPwk6ZesqV
         gKQ/Q+GHUhOBjiLyb10NvKtBlKV3POtntkhQgJOlAM/bH+xUHFjpHO/5jXs3K33Z/eCl
         IlLw==
X-Gm-Message-State: AOAM533IbtBcCJiMTYyQXB3mfMKMCrfG+aAQgWil5redx0plQhflu//c
        LV+FJooCWj9UbntATlHZgTeJLg==
X-Google-Smtp-Source: ABdhPJzfcDC1QmFeVBdVvPaUOSXsUyovVHa0wrWKVmzm0/16NQFzG7So3+md+TiskjTAEgulGecShg==
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr3903189ljj.245.1618304588393;
        Tue, 13 Apr 2021 02:03:08 -0700 (PDT)
Received: from xps.wlan.ntnu.no ([2001:700:300:4008:3fb5:15ad:78ca:d9c1])
        by smtp.gmail.com with ESMTPSA id o11sm3722912ljg.42.2021.04.13.02.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:03:08 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     tj@kernel.org, lizefan.x@bytedance.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 2/2] cgroup2: cpuset: Always allow setting empty cpuset
Date:   Tue, 13 Apr 2021 11:02:35 +0200
Message-Id: <20210413090235.1903026-3-odin@uged.al>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413090235.1903026-1-odin@uged.al>
References: <20210413090235.1903026-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Due to how cpuset works in v2, there is no need to disallow setting an
empty cpuset when tasks are attached. In v2, the effective cpuset of a
cgroup is the intersection between the effective value of the parent and
the cpuset.cpus value of the cgroup, with a fallback to the effective
parent value in case the intersection is an empty set.

Allowing this will make it easier to move the cpuset of a nested cgroup
hierarchy where multiple cgroup use the cpuset.cpus, since the current
solution is to manually update the cpuset of each cgroup when doing this,
causing it be quite complex to change. It also makes it possible to
disable cpuset for a populated cgroup (or one of its ancestors), without
having to manually write the effective value into cpuset.cpus.

This also applies in a similar manner on cpuset.mems.

Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/cgroup/cpuset.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f543c4c6084a..33a55d461ec3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -609,11 +609,12 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	}
 
 	/*
-	 * Cpusets with tasks - existing or newly being attached - can't
-	 * be changed to have empty cpus_allowed or mems_allowed.
+	 * On legacy hierarchy, cpusets with tasks - existing or newly being
+	 * attached - can't be changed to have empty cpus_allowed or
+	 * mems_allowed.
 	 */
 	ret = -ENOSPC;
-	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
+	if (!is_in_v2_mode() && (cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
 		if (!cpumask_empty(cur->cpus_allowed) &&
 		    cpumask_empty(trial->cpus_allowed))
 			goto out;
-- 
2.31.0

