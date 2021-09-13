Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146BB4083A8
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 07:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhIMFC1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 01:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhIMFCZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 01:02:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B55C061574;
        Sun, 12 Sep 2021 22:01:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 5so5008366plo.5;
        Sun, 12 Sep 2021 22:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=No9Cu1y2zqzL5EFePgwVsxeseV9YVFbZD57If/1JFIs=;
        b=QPhkIP4EuaDwd0g0Cpi2Seb9O+M/uDEpUGfJLKmy39jucLuWEfQDYmlS6DG7m6hkYm
         QoECCAR3Kz8hTTgbNuquGD8HoegtSz1wuf0f4aml11Tpo4TF611EyFcfPsriGFFvP2aS
         ViYSNGgC/ZSwQLA7rPf1tibRH9yDPn21ZKVbBVEvbKKlTBIHnaepEJxNYNJmXCNy90pj
         zgnlJWcGE/Mt0aQzyaiFoMuYybsgBosa7cLKFjGnW67YUIHlRNhnXduV0Xs7pVXK1GNE
         OHsfLKp6ywHxtz91bqbXeGPlQNyLiTdidtr1d8vRyrBOcaOBrGjtcfcpLXlNE8i0vr8Z
         Wd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=No9Cu1y2zqzL5EFePgwVsxeseV9YVFbZD57If/1JFIs=;
        b=T7ppfb9Ujn4E4DnjMX87g+kG8faddjShqh1mwruWrAc0bgRh34Ysk1OZ6UtyqEu7Dh
         3orNwvCfcQrLtM6lMs6LY5XkRHYXTbVjAxoJGBHBTlz45jV9L3yvo46CG01FQ+dC/Vtn
         KGpD/ZPfA9k53kS6Q2oZGRCc3244T4h9LZ/X84y/MqV8gHgpZTtv/2YchHp2Eg4z+Trg
         XtiB9lAZxTuf1tHFRvw1NDXQBPAi5caxe2ub1WIMN8nfkOY18TEXMEr4hdkpDeXwBiUG
         mRWqk6pmiA29ZGZlfq4QUXH8TL272+OkHGcpPfdrrAJggQ1V2HhIecfV3N0MetLstf3e
         T/Lg==
X-Gm-Message-State: AOAM533IulBJxEb5zWeU4hv77hT25oqxI4nDMxrdk+we0N7bCeZSZUpz
        MEDyVQKqoxNMIHSDu1EiAS8=
X-Google-Smtp-Source: ABdhPJy4ZWVGVTo3sphzaSEAE2U404JvJ2MPxbpLgbZdIYS/9b4hJUCxO7paXWH92v5O9BSqGfjLlQ==
X-Received: by 2002:a17:90a:342:: with SMTP id 2mr10854602pjf.99.1631509269684;
        Sun, 12 Sep 2021 22:01:09 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id n38sm291879pfv.198.2021.09.12.22.01.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 22:01:09 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/3] docs/cgroup: add entry for misc.events and misc.events.local
Date:   Mon, 13 Sep 2021 13:01:01 +0800
Message-Id: <8dd0636659c55fe9db16f8d19af745c185cc4fdb.1631504710.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
References: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
In-Reply-To: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
References: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Added descriptions of misc.events and misc.events.local.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index babbe04..90a36ae 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2310,6 +2310,25 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
         Limits can be set higher than the capacity value in the misc.capacity
         file.
 
+  misc.events
+	A read-only flat-keyed file which exists on non-root cgroups.
+	The following entries are defined.  Unless specified otherwise,
+	a value change in this file generates a file modified event.
+
+	Note that all fields in this file are hierarchical and the
+	file modified event can be generated due to an event down the
+	hierarchy. For the local events at the cgroup level see
+	misc.events.local.
+
+	  max
+		The number of times the cgroup's resource usage was
+		about to go over the max boundary.
+
+  misc.events.local
+	Similar to misc.events but the fields in the file are local
+	to the cgroup i.e. not hierarchical. The file modified event
+	generated on this file reflects only the local events.
+
 Migration and Ownership
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.8.3.1

