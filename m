Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB282F46E4
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 09:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbhAMIvh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jan 2021 03:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbhAMIvh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jan 2021 03:51:37 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B4AC061575
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 00:50:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id r4so673825pls.11
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 00:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7bLM0SCOKHe/fCiUaodu2A32W/TBhIHCOkDztDbBVPw=;
        b=OVDbUIK/40/4Bmxe//hY97Zk9F8gvprX3CooRRdOK52T50X2qY2nkMmNxudovLCQTp
         dJyO3hcd45gfuloJGvUi4pgVbARR6OQLuhFjR0FM47Ie4+M84e0zXnZYDUgzZdh7YDt6
         FwWSeh7UPC6Z6w4BGTyiqQ+cv1b83DKZm6vAojXOk7pD1np4wsbSRgOqCVOyZpCnyTaq
         cAPH6T6i5nhKYXJM5XeUFP8Fqs5bDrSszPonUJQb4uhUXrr26xHqs1DIAy3OT9OlhNpg
         k+M6M1JU952L+lvwwb+OIDh3+POJ2nEnHX2s6MkB2sBOgS9BHGIGtS7RCKBtKyWAXr10
         XMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7bLM0SCOKHe/fCiUaodu2A32W/TBhIHCOkDztDbBVPw=;
        b=fOWOaRwYtJ0XpV3yGOulR0/PNPgWlMs6lXHx2ALDQyFov+ZrdIVxtKa7x1n+p8ZyXO
         sUEozuASiAOYtY/1JOId+9dkoDz4306J97XEHwzJevQipXFtJX+X7dFnRUIIgikfnEDb
         XPXQShjaK0uQTvYH6h+D3Qbq8lRLa3JNBemxx6e9wiq1KomXGmazworykzsTH3ctALV2
         kiMHLy/e0B3BB8i1CXkY+PEELegqqFJA00KdbTvugE1ued7YdDvToWpAfN/M2EPogG7f
         r4bCPKTTaTH6jfEpWrVhvwd9XRh8k2qWKM8v9Ha7J5ibpX+EGaklqwcClt+vmkgnjXCY
         YBew==
X-Gm-Message-State: AOAM530svOUCnxsXeHYR0aO9HveJdW1Iib3rr+WzhNuU7x+OoJzkKZ0D
        PBugU8mM6ReWnJaagpZoDxKi
X-Google-Smtp-Source: ABdhPJwtlt5eGAFtoCmviu66YjPNKJORCJpDH0gGgSTGtHjw+yxMYSDtMO5opqIFJzzyCd8ok3WeEg==
X-Received: by 2002:a17:902:c1c4:b029:dc:2836:ec0e with SMTP id c4-20020a170902c1c4b02900dc2836ec0emr1097560plc.11.1610527856639;
        Wed, 13 Jan 2021 00:50:56 -0800 (PST)
Received: from [10.85.112.53] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x7sm1907649pga.0.2021.01.13.00.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:50:56 -0800 (PST)
Subject: [PATCH 2/2] MAINTAINERS: Update my email address
From:   Zefan Li <lizefan.x@bytedance.com>
To:     tj@kernel.org
Cc:     Steve Wahl <steve.wahl@hpe.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Message-ID: <d09fd675-00fa-21e4-00b6-1cc4c2533a94@bytedance.com>
Date:   Wed, 13 Jan 2021 16:50:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Signed-off-by: Zefan Li <lizefan.x@bytedance.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 89140540aa8d..bc38f36f257c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4467,7 +4467,7 @@ F:	include/linux/console*
 
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
-M:	Li Zefan <lizefan@huawei.com>
+M:	Zefan Li <lizefan.x@bytedance.com>
 M:	Johannes Weiner <hannes@cmpxchg.org>
 L:	cgroups@vger.kernel.org
 S:	Maintained
@@ -4491,11 +4491,11 @@ F:	block/blk-throttle.c
 F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
-M:	Li Zefan <lizefan@huawei.com>
+M:	Zefan Li <lizefan.x@bytedance.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
+F:	Documentation/admin-guide/cgroup-v0/cpusets.rst
 F:	include/linux/cpuset.h
 F:	kernel/cgroup/cpuset.c
 
-- 
2.25.1
