Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF12FC5A5
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbhATAU0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbhATAT7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:59 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1702C061793;
        Tue, 19 Jan 2021 16:18:36 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c132so14053558pga.3;
        Tue, 19 Jan 2021 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=045PvP5AZFJnLagMgpduNxgCsOQAzU/2eOj/YLdBA4A=;
        b=gqrB0eAJfwpSU25eN7Jtg6+8cofftYbci8tlN7GIxkNIgv7rj4AvBL0j7a/XCcl3GO
         Uq0DU/ugxh+YaceXN20O9rqGPcixxwyGpTevGEnXTs6o1OQBc12A5KAvnEXVHDKZnYqC
         2wM80/HKZ5B6OcOp+7HpodTJNAJ3g9G7G6Z9SbomHRzWg++X4GWmO8sps++rkUH7bbQU
         6rRja8dqCgTWcsLie68NOcxgthqGPELhFwCMvA3sgu5auhckN36wl19yB3ijtOR0ToYY
         ha1QWQhbnPP+XObvf81YeXH7K/dw87nFMcC/0DRE6xDVIv5Yl7mNZxKCiM6TcjTYm+pF
         hhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=045PvP5AZFJnLagMgpduNxgCsOQAzU/2eOj/YLdBA4A=;
        b=EtKG5A27AkpUnx5mrqjMrbYlXfolm/HD0o810UUvy9bdaKsoN1g3BsPLs3MOYLSAYS
         rFqQa/4jKGvva0/dUh93J26ykpPI6KClZV5qHLZ5IVnIS7Q0rgTtfyncSrnprceTBDEc
         Nw5dxo/jhe4vlZz0zPjG5lwS3ykTQaSekyslBD9g/+pW2xzmYsD3YSYGgkSOkvjZC06x
         H1e3NiTVEOgkBwpfj86auumdAl/KKfkEZv5NFAYq6swQ0C0C5sixSw7bqH389CLjNSE7
         YBaPgW/kyfssZyXtb6fduiwCfa/7oAai3c2eKVsT9TDBBXu453jjp/cxK+dpQGJBtG0m
         LC2g==
X-Gm-Message-State: AOAM533i3NVEOMiAwqfawPyebBgcIS1p5GxV8PpxUInSopbsFRhDKcwi
        d+bKiPazWPqSEkkTihT+4HE=
X-Google-Smtp-Source: ABdhPJzTxqXNGJzyqqNbTCvTQ9HKeMZARua2qL0Q/Hhxm6FpCEVxs/il/7ZscAEpR4TuBX9sc2YEag==
X-Received: by 2002:a62:e30e:0:b029:1b9:3823:4b3a with SMTP id g14-20020a62e30e0000b02901b938234b3amr6389646pfh.15.1611101916494;
        Tue, 19 Jan 2021 16:18:36 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:35 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 08/10] doc/admin-guide/cgroup-v2: use tables
Date:   Tue, 19 Jan 2021 16:18:22 -0800
Message-Id: <20210120001824.385168-9-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These two places are rendered like a table in the source (rst) code,
but they are seen as plain text by formatters, and thus are joined
together into a single line, e.g.:

> “root” - a partition root “member” - a non-root member of a partition

This is definitely not what was intended.

To fix, use table formatting, like in other places.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index c1b6ffc286cf..6f59f13f28d0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2003,10 +2003,12 @@ Cpuset Interface Files
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
 	and is not delegatable.
 
-        It accepts only the following input values when written to.
+	It accepts only the following input values when written to.
 
-        "root"   - a partition root
-        "member" - a non-root member of a partition
+	  ========	================================
+	  "root"	a partition root
+	  "member"	a non-root member of a partition
+	  ========	================================
 
 	When set to be a partition root, the current cgroup is the
 	root of a new partition or scheduling domain that comprises
@@ -2047,9 +2049,11 @@ Cpuset Interface Files
 	root to change.  On read, the "cpuset.sched.partition" file
 	can show the following values.
 
-	"member"       Non-root member of a partition
-	"root"         Partition root
-	"root invalid" Invalid partition root
+	  ==============	==============================
+	  "member"		Non-root member of a partition
+	  "root"		Partition root
+	  "root invalid"	Invalid partition root
+	  ==============	==============================
 
 	It is a partition root if the first 2 partition root conditions
 	above are true and at least one CPU from "cpuset.cpus" is
-- 
2.29.2

