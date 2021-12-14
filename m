Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C594739BA
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 01:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbhLNAqS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 19:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhLNAqS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 19:46:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8DC061574;
        Mon, 13 Dec 2021 16:46:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so57295671edd.13;
        Mon, 13 Dec 2021 16:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kSriUcr2RHlsa/k2Omom4FRrCUVVZTUaNFBbTKOcsT8=;
        b=naxeXMBFCpq38O3k+pVvJGj0gGYcPhbWVAT8G7ARuCaUZ7Tce88QMVO47ld3Coh+tB
         /NKR85ihfLqmLPynGBFUnqrTrCHNmyLhBtr6uEVplKhcb2a3HKQEglQFSgEzXKMuMLc7
         3wXCIXOYljRLJLErKfHoJb4JlfqZMcTC5NO17wzxzTTTroAMPD5FG7QwOq1R7w+YrPfY
         2mRBRK4O2csy9BCUYb6fNJEuGjCFEjf1skmdwOvJN6lZ8Bst2eqtJYB5gTUxuyUKeuDQ
         LpLUm8QkHCI3zoNm9Mt1uOSaUmnCOOzpkgDqkhYes9XbMqkyE12Tof6Xto/sLPIgprQn
         FoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kSriUcr2RHlsa/k2Omom4FRrCUVVZTUaNFBbTKOcsT8=;
        b=eIdRSHqto8AfaBTw22BEMqakAZgfH8QuYB7ozFyXT7UP/RnSBLKY0b/0myq3lXLI2E
         w2jfrIew3mtsQsi2vknHMG+5FivIEOqxTHdBZPfroEZ0FvCic3G9Dsr6ZQf3cGDTDXF6
         H1cxGmCBwQJk+ss1Pq3rWcc9IZF7Tlse+tYCFYTS5yy5A33AecteAHs9cUsj4KUg6PXn
         1d68GQJgG6oTSVQxGFe9PavWXcf+xdSqXbDqDbfwu8m1SJpY9GvwtW7WYmLHWTvr8S0l
         0ZKlRCfXb/N85O+ZWyNQXh0mOJLhTPIOa1RzzA8Qb4LaZGaUF0VlAHshLxYUNdeKMM8M
         4iPw==
X-Gm-Message-State: AOAM531oBmnuQczgyFvs04bSuLmUrSpBKJVfLHQ86aemxtMqavILVwnR
        EXCBP2dOqp4w6VOMIPmSr5U=
X-Google-Smtp-Source: ABdhPJw06wXHR3finWEK0/mvxeqdKv0gWk14DzAQ39jyZ4YVt8/WtVRmE8InfiPMBIRhLSlz24aiWA==
X-Received: by 2002:a17:906:7954:: with SMTP id l20mr2091942ejo.143.1639442776392;
        Mon, 13 Dec 2021 16:46:16 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5sm627671ejm.132.2021.12.13.16.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Dec 2021 16:46:16 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2] cgroup: return early if it is already on preloaded list
Date:   Tue, 14 Dec 2021 00:46:07 +0000
Message-Id: <20211214004607.9296-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If a cset is already on preloaded list, this means we have already setup
this cset properly for migration.

This patch just relocate the root cgrp lookup which isn't used anyway
when the cset is already on the preloaded list.

[tj@kernel.org: rephrase the commit log]

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: rephrase commit log
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 452a723d4a36..2cf729afe834 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2648,11 +2648,11 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
 	if (src_cset->dead)
 		return;
 
-	src_cgrp = cset_cgroup_from_root(src_cset, dst_cgrp->root);
-
 	if (!list_empty(&src_cset->mg_preload_node))
 		return;
 
+	src_cgrp = cset_cgroup_from_root(src_cset, dst_cgrp->root);
+
 	WARN_ON(src_cset->mg_src_cgrp);
 	WARN_ON(src_cset->mg_dst_cgrp);
 	WARN_ON(!list_empty(&src_cset->mg_tasks));
-- 
2.33.1

