Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCE420793
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJDIvY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhJDIvY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 04:51:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539AFC061746;
        Mon,  4 Oct 2021 01:49:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p11so8759661edy.10;
        Mon, 04 Oct 2021 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N3sruM3usLkej2geppAhAsEmxswQsSvrfu16yvAY3QU=;
        b=PUaJh/0D5EDmWmLJIGwBb0YRcdlZP3U8HbZzUs3GyO0byzRLKQxiftuiNqVZbLBwuW
         l127GSCaYwwQl5xI2Y5dZIp+b9IYz9tfkMa+YU6/gIaehp3tdwlDGUDPFPogiM9rUug+
         2wlne4vBEDBYaQdGCT+3uSRLFEGa/GoE1uP8oRxe4yL5t843uxXb6sCodhsaYN3xyojx
         fA053an6P3pQdpBwdzFna2bAHSpF2dWNY8IafpXYKRL4qZjqL09eICf2kDgUDcqPfU4p
         vGOwDCsx4xZNVwtjMMCVA8pMFnPis+jJziABbBJpcIVGwAxcsViE/tgAos3uzkJdWhru
         z4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N3sruM3usLkej2geppAhAsEmxswQsSvrfu16yvAY3QU=;
        b=46VXZrGombrMZdhWgFQLiM8I+LJ4b9YEOsBLYfvYhgb+YNBoLQdeOGXOclkm6n3AV5
         Lp3az68cpfeKsVnK4qyNzc9hEmxfTIZVvFzwBb0xwsZvUTCL4z6aGbS6JGYBsF9lYZfY
         zmpNDHY/PhE3YZC2miNnas97Aj+v6o0UynrOUWTwI+OI0Pwt+Y07Y88r+1DUXqYKuXea
         FIz95sKW4zkrWcHQew4xK5vAgz+tBip6QfT2G3SQVAcAx4cd+OZ9RUDgewRsQp1ZWYjk
         0UUJ0/aZDEXOZ2LP4ST+jDEm6UX5v4n2XwD270EswwHr0tZaIeSSXsPJhBMJ0o71GJnX
         lxIQ==
X-Gm-Message-State: AOAM532QLM+n9edI4nbmlfsGlY+p6jmWLVSecjtOV+W2BL3yv8gTH8iw
        XVi4KoajZAOAqYge5jwZGrA=
X-Google-Smtp-Source: ABdhPJx7Mbke8TVbWBomxBAixftUdthCJz5LzjlO2IG2FahQhmg5Yxzv47T1Vy4R8+yG9QKqQ2Kcug==
X-Received: by 2002:a17:906:e4b:: with SMTP id q11mr15556083eji.234.1633337373904;
        Mon, 04 Oct 2021 01:49:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s18sm6253137ejc.52.2021.10.04.01.49.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Oct 2021 01:49:33 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/4] cgroup: reorder cgroup_subsys fields to save 8 byte
Date:   Mon,  4 Oct 2021 08:49:26 +0000
Message-Id: <20211004084928.17622-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211004084928.17622-1-richard.weiyang@gmail.com>
References: <20211004084928.17622-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 64bit platform, struct is aligned by 8 bytes by default.

By moving cgroup_subsys.depends_on, we fit these adjacent fields into
8 bytes alignment.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/cgroup-defs.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f6d80896daab..4649d09396fd 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -672,6 +672,15 @@ struct cgroup_subsys {
 	 */
 	bool threaded:1;
 
+	/*
+	 * A subsystem may depend on other subsystems.  When such subsystem
+	 * is enabled on a cgroup, the depended-upon subsystems are enabled
+	 * together if available.  Subsystems enabled due to dependency are
+	 * not visible to userland until explicitly enabled.  The following
+	 * specifies the mask of subsystems that this one depends on.
+	 */
+	u16 depends_on;
+
 	/* the following two fields are initialized automatically during boot */
 	int id;
 	const char *name;
@@ -698,14 +707,6 @@ struct cgroup_subsys {
 	struct cftype *dfl_cftypes;	/* for the default hierarchy */
 	struct cftype *legacy_cftypes;	/* for the legacy hierarchies */
 
-	/*
-	 * A subsystem may depend on other subsystems.  When such subsystem
-	 * is enabled on a cgroup, the depended-upon subsystems are enabled
-	 * together if available.  Subsystems enabled due to dependency are
-	 * not visible to userland until explicitly enabled.  The following
-	 * specifies the mask of subsystems that this one depends on.
-	 */
-	u16 depends_on;
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
-- 
2.23.0

