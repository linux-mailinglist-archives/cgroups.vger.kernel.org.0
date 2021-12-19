Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F53479EDD
	for <lists+cgroups@lfdr.de>; Sun, 19 Dec 2021 03:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhLSCmJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Dec 2021 21:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLSCmJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Dec 2021 21:42:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597CC061574
        for <cgroups@vger.kernel.org>; Sat, 18 Dec 2021 18:42:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so6614503pjw.2
        for <cgroups@vger.kernel.org>; Sat, 18 Dec 2021 18:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1fCDnzs11QBF/HgkFGJOxPwWBFoX6qDm6eKaoQut7Fg=;
        b=u385DoqLNxdGOTSHTYc/tJNFZZ1KR5LO4JfCZc8oc2ITGuRYg01B992ZOPe2SZHECt
         ucGsrko12/gWUNGpwPEqTUnUT9i75KKR2zCkUOJv+rGJ+PkuGN3LscQYCrS6ny0HS3cu
         AuhXPWp3EcbWy2hBuND6IYJp079NG7jcZUqbYrBqdrXeIlK1WCrfi/yxi+qPOdpGIZdP
         y3B5HeRMLbJ5PBxmcSRpKglfmI0mFRuGXtjqqowILph1dorR3MABpJFveEHLlYQkykHS
         ThZB44WazlXOe/rKp2DXaFy1TUTNSpd7fwlpJqzo9KnWfcvh9YfBniBJGyJ/rPhLFHD5
         wCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1fCDnzs11QBF/HgkFGJOxPwWBFoX6qDm6eKaoQut7Fg=;
        b=5KCTQj+J0PAd3z+cQljaJB/sRpGq4mvrjsS1kmAAna/t9tpAZcpaHnBNMVKKHZG8ST
         Dww/8RQVc8PcGEuAuNQEhhXL8/HVrRlP3ShunWZQn1UCM9EWPClcT4zzckBuwWo9KvYb
         jKcD2zoJ1u1CdS5Ch5Uvh9gcHBvVVMKyL/BnNUTMk07IN4NBIAaLXwhxy/WwRGWR1Ga0
         VnKBuRqbWkbCLFKoilAv6vqQbEgoj6ktpH9ppPndcAPh/QGIp2yMTUogQY5Z7zSBfg94
         m1zCOe+1zCyDPmW7mhefIh2xMhW9mo4Po1L03RUGHRVtZOg7iQq+7SuDuY3xoQ0Nr9DY
         1cyA==
X-Gm-Message-State: AOAM532oU1WlOak0PjOY1H8dmEW4kuiKsoedLTNo625HFTJQ0CQ1TaLN
        WF4rWICxgZHDG4DJeUq/nfy8Bg==
X-Google-Smtp-Source: ABdhPJxk/oVPS0gygqoiITAj+VMP6vtxy4gQJ1MgcFYsT1CEkq/FsylJcLjy2YKSwOBAC1ZGZWuhAA==
X-Received: by 2002:a17:90b:3a86:: with SMTP id om6mr5386779pjb.16.1639881728052;
        Sat, 18 Dec 2021 18:42:08 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id y191sm13223415pfb.124.2021.12.18.18.42.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Dec 2021 18:42:07 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] cpuset: convert 'allowed' in __cpuset_node_allowed() to be boolean
Date:   Sun, 19 Dec 2021 10:41:54 +0800
Message-Id: <20211219024154.28853-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert 'allowed' in __cpuset_node_allowed() to be boolean since the
return types of node_isset() and __cpuset_node_allowed() are both
boolean.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0dd7d853ed17..dc653ab26e50 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3528,7 +3528,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
 bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
 {
 	struct cpuset *cs;		/* current cpuset ancestors */
-	int allowed;			/* is allocation in zone z allowed? */
+	bool allowed;			/* is allocation in zone z allowed? */
 	unsigned long flags;
 
 	if (in_interrupt())
-- 
2.11.0

