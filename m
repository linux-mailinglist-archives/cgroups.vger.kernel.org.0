Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45036464473
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 02:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbhLABVS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Nov 2021 20:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhLABVS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Nov 2021 20:21:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F553C061574;
        Tue, 30 Nov 2021 17:17:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so94548093edu.4;
        Tue, 30 Nov 2021 17:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Fq8BRlHQip6soD4MoiTVE5ZeVUWI7smXdjqRV9fIryk=;
        b=Q97bIACX7BwWm5elsSdrBYHiMGe60S4Qij+w8V3Ah60WudJSar4xv9CxK7OLbC+k35
         pCD5q9kHRg916PhilswOzQsTynUACFMsgC5K0okcihgdL6tWzDMYCDgI60NQWsdcYsmK
         3TOqHQnrF0HZW7dHv+uNSXcD45QpN1llHS4yMlwrgP0ZGAT6SPI4M/E2lNCcaXpHIaOh
         YPYhrBCR+wBfxngu6H9pwcQv5ECKm+nntQxWq46/Rm+vGCkM90qA2w4aM/mpoN6pMZwh
         bFQJBk6d+IhPcha1DrUq446O7CX8TfvT6FTqYfWXUTRtjTQX3vvv4axNHcS+GVp5cpzO
         eC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fq8BRlHQip6soD4MoiTVE5ZeVUWI7smXdjqRV9fIryk=;
        b=PRTTcoDCTBKSzi+nTrTdtO8XCBgo2BuYn0qkNAV188lZ6OrSw0mN2zWjh62v2E+i+t
         Ku4ekmWkHS8d2ZsCzt4Eo/O42b9ifujvv3MwW6XamA0QchoyYQB6C82fLfaPZCzltV7+
         ne3lE/aghGN+WiowLKd9f31GZW80Aa8PLSpABbDxCR5F8D0nIJvGqqILARQse7eFnLse
         CA1pBSHWOHnanYJKTBD2nXgWgPhS1KItN4lCo2aoBpjcyZTJX/ZWNXk+ImlGPamjOiOl
         kPFzMCG2gY3UiwViRDWzP9WUd9nVHe0eGupu2iNc6aBOb88ug54e/HLs+TsbXeorTVSp
         o2Xw==
X-Gm-Message-State: AOAM531vxCw1J3Xj2l9CqWNardczVMj5CDDVcy3/uVvFsnlHw8ZfmFiD
        GmPsdvYoh1QmC7JPe3FK1JD93NXAgh0=
X-Google-Smtp-Source: ABdhPJxFmglFuwNYRoXl2rgFQcChZdfg5Cl3wUEXTpFXwoax6vm2N8He4pXmYVGz3XnZv/EfYAOqqQ==
X-Received: by 2002:a17:906:e85:: with SMTP id p5mr3112493ejf.159.1638321476576;
        Tue, 30 Nov 2021 17:17:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y15sm13759579eda.13.2021.11.30.17.17.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Nov 2021 17:17:56 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] cgroup: fix a typo in comment
Date:   Wed,  1 Dec 2021 01:17:36 +0000
Message-Id: <20211201011736.10988-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In commit 8699b7762a62 ("cgroup: s/child_subsys_mask/subtree_ss_mask/"),
we rename child_subsys_mask to subtree_ss_mask. While it missed to
rename this in comment.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/cgroup-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 4649d09396fd..e4763c892a3b 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -413,7 +413,7 @@ struct cgroup {
 	/*
 	 * The bitmask of subsystems enabled on the child cgroups.
 	 * ->subtree_control is the one configured through
-	 * "cgroup.subtree_control" while ->child_ss_mask is the effective
+	 * "cgroup.subtree_control" while ->subtree_ss_mask is the effective
 	 * one which may have more subsystems enabled.  Controller knobs
 	 * are made available iff it's enabled in ->subtree_control.
 	 */
-- 
2.33.1

