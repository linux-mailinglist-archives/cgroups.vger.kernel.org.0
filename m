Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E94083B2
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 07:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhIMFKd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 01:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIMFKd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 01:10:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D580C061574;
        Sun, 12 Sep 2021 22:09:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id bg1so5004685plb.13;
        Sun, 12 Sep 2021 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HNyXcYZACqdPsANRJk2PRQjj527jHromuW2y01xPu04=;
        b=TYcC/3cpnYl4dRBe8dBz15FbZuelXpYwy22omwmbevheMUwjU+VhGpGYKn19xLTl2k
         /MIDBMueGpPVyDBjzxCRafVXMZlloTUMXlZhT12HM/gSZkmafQPql5hREsO4orJLgnNH
         ArgHHRYjZ7lgXJzenIRduqXgs3tkoQCtj4r2yBAEbqlO7dabyyg3m4vSWTHc0UPRRmHl
         7Us+VcdkgFXy7/f5126iBYaEWV/d/jlZUleY0SEVklrmXM0rPnOVolKGd3Es89UqzWKO
         zwvoGx/DptZ+rbJ2R6A0Un9FF8kOYWgZzzfLL5uvJpgiFhWpZuTFPTjyez+oUQYTZbW5
         ALow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HNyXcYZACqdPsANRJk2PRQjj527jHromuW2y01xPu04=;
        b=QwtBC7dfSsw4yVZr+cSw+lalmblCD8KEYjRTJ8DXnLO0pnk0Y6B7BIQ0Ee0CTB0ugI
         9zW8b5fdkAhV0E+bra15g9efPuR6YPwfWi8LBKoQ0uDlbIpYwJ7UAOcpLGoVMaeeoLKf
         HGmutCjvmtNe8Wa+WlYNklYQI89QxIm5mURVosV1gCdJV6DTHtlyUj7mveppJTL0H4DU
         LT1dbbdYcr2Bt8nLBVpALW6pkuKNy4G7GaEzipdw85yBzdzIXp32gun8rtGNGkPKIPDK
         dEloWvQQdjShkHoYFfB7HfKQhj5vEGMQyKOHd2K2u1FwOY5oZmxvtZ0+hgMPIGFjSwei
         WLQw==
X-Gm-Message-State: AOAM532g+qvS0r+NCC6M1sq0pKpPtDXTqjuxiUpUrIdtECAUik03CFCp
        u4J1d7BKDOAjIfiPB+QXJ/U9LIGZMcc/rA==
X-Google-Smtp-Source: ABdhPJyBhRJA9mEOAUHc7S2NuJk/+E1s4xhnV/gvdscL/HkDv/kcuXoTwCMj1L9bGUhWhhk+Q+DcfA==
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr10845274pju.227.1631509757790;
        Sun, 12 Sep 2021 22:09:17 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x13sm2136934pfp.133.2021.09.12.22.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 22:09:16 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs/cgroup: remove some duplicate words
Date:   Mon, 13 Sep 2021 13:09:14 +0800
Message-Id: <1631509754-21485-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

When I tried to add some new entries to cgroup-v2.rst, I found that
the description of memory.events had some repetitive words, so I
tried to delete them.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 90a36ae..a6201a99 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1226,7 +1226,7 @@ PAGE_SIZE multiple when read back.
 
 	Note that all fields in this file are hierarchical and the
 	file modified event can be generated due to an event down the
-	hierarchy. For for the local events at the cgroup level see
+	hierarchy. For the local events at the cgroup level see
 	memory.events.local.
 
 	  low
-- 
1.8.3.1

