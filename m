Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38D640BDB3
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 04:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhIOCUS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 22:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhIOCUR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 22:20:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725AC061574;
        Tue, 14 Sep 2021 19:18:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s11so1161218pgr.11;
        Tue, 14 Sep 2021 19:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mjJOq2l9/1TGAZpwrREsl45rYpK7gUexDrTF0O7TVOE=;
        b=FrgumB802lOc8B4BExnulAfH/g8d9tm7wO15QrXk0LDXtE47qb9MIVHVN174MQleXg
         tWy2fhx311YpXG5MN4WCSd1YFTCxkR3xcqX2GLGx+0kbULFYrkj2C7KLBGlDaB+SmLJV
         G71mBdKxZRU8psK/fl2/GL09fSFygV+APEhVrRpv3AnYiYf0g4ajh+lN3wIvfyIVvBkL
         DmSVqKOVw5LYQYY5O7b5hb4FroGN2uK/k1T9j1WvXaEJj2QpxHz+lM7hiT9Xgi5znScP
         mdY4VMueqOX1aNTYavIOHfg8gEkaAEha2x7UT29Zu9rhp17GTo9Nnx7yUsqy1uEUxWo5
         03pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mjJOq2l9/1TGAZpwrREsl45rYpK7gUexDrTF0O7TVOE=;
        b=J3AEAdYjn6TPfBphz83qiGYbAji7mbqS0DWiy3G1zfqEpV/DzuQB0rBbh666SvB9nv
         RbemexqTv3eiIPIIN/XnqdFG8rwzjWb7s813vXoBcvofV6R4rFHcgWCAcvnKdhc6An1O
         kLzqBJX5lCh/6k87gf+XkDsscCCQI9fGVfZABpwYNP+387MzGEfjJ9cidpkFSkuEtrDx
         Yw0l93/zigDz2kPEjpCaUc77gEjFXlNXf3B9dh5wINXCcDEjXgBL+Oq8+ZuMSQTCT5Rb
         Gm9trEmbGYt9IpgHu5gEH2IBtaA3mhMKvuzBjjx6Cx2DnfnsxhZBa0zaACbFBO7s3jGC
         iQ1A==
X-Gm-Message-State: AOAM532gWYpjancUIbJSy2MYMUfCY/swW40Cs2JEityBvVlZbsSc8t0z
        rsdzC8t0bnhSfll9+UBlK3s=
X-Google-Smtp-Source: ABdhPJwBlQvpjTzVeZqgq4WJCdd/i02DUHHbojD0SowAolcBIM8ObomiR0VS2ckuLKaSOaR/fClSYw==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr18023710pgj.47.1631672339408;
        Tue, 14 Sep 2021 19:18:59 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id h4sm3297645pjc.28.2021.09.14.19.18.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 19:18:59 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 3/3] docs/cgroup: add entry for misc.events
Date:   Wed, 15 Sep 2021 10:18:51 +0800
Message-Id: <7cb32b92b77188f50b46bb47eb728bcacf18c17f.1631671936.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Added descriptions of misc.events.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index babbe04..e7acc55 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2310,6 +2310,16 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
         Limits can be set higher than the capacity value in the misc.capacity
         file.
 
+  misc.events
+	A read-only flat-keyed file which exists on non-root cgroups. The
+	following entries are defined. Unless specified otherwise, a value
+	change in this file generates a file modified event. All fields in
+	this file are hierarchical.
+
+	  max
+		The number of times the cgroup's resource usage was
+		about to go over the max boundary.
+
 Migration and Ownership
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.8.3.1

