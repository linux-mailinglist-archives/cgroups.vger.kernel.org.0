Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6241847F189
	for <lists+cgroups@lfdr.de>; Sat, 25 Dec 2021 01:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhLYAJr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Dec 2021 19:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhLYAJq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Dec 2021 19:09:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F1C061757;
        Fri, 24 Dec 2021 16:09:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f5so38054297edq.6;
        Fri, 24 Dec 2021 16:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sT/KIGohhkLRHjE3wm2QpMED803gmT90EUceteaiTMI=;
        b=Veny7lRRrWZ6cPaqOR1uySyz7YnyTWPGVAUtA23S03w2GGa/Sj2f9sCm89ozYiU3Qo
         hUhntjifTiyQxfwN7y5vW6QdTtXlhqM6U7RhP3cWSxfNm0ZfhwbUrJB/jjVdtE7jD29t
         lnPiuzVjMwD5PPwFFYR6jxA/Dijs21s2jg7TWGNf43364LTSwWT5O/A4hZRfvT2UTQgN
         PO9bf4FnsSzdsu1kM9AxU8XHitS2y1rnXZp9FL1mxEJEENOSoGuHhjCgh/+yURhmQKuW
         aEFoqMqwvq6hmOnomkBSchjGntX73QCZ86RhRytOX4U1+A8UkOh/84oejldtuLZKDRgt
         Zl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sT/KIGohhkLRHjE3wm2QpMED803gmT90EUceteaiTMI=;
        b=fiW5Dg2VoVHjzokc8nkBXCW39Pp6l6vHeP2RXvTFH2LfrHI3hOzmYhVwZ5U3/BJBYG
         qW3+sf1uHNkrO5yxGdHz90wkAL2FxEBTgbwq1eipAmKuezMIQpp05HYMrt5HLDfe4h/m
         +W7JJN6s7L0bJplovQfc348gOFAIZuKE/t0Oc4ho+40MLv5WsMCyzfb8oOCT7X5N3xeO
         DbEjHEEwP7knOFoLbPbaW4Q1pIcRPixhwaPXPNUWVwmC9IOn5VS+m08iXMDDwOXOb56d
         2APiSPVU0Mt3FsE2Tavjybb2KdLzBY8xAb6u+DbgiWdJJcJDnuOvXKtYL17UObf+ZpmS
         0j9Q==
X-Gm-Message-State: AOAM530S+ZvQpXOroTltu4/pef6IrPGzrQUV4PHn4T+ZRSloCquXFXx8
        NNdDFH5BD687QDNAJCsvB2Y=
X-Google-Smtp-Source: ABdhPJxfOJL4hEtLTz7LFV0uoWA8Zq4W7yvzwO+EDf6X5MmBwjeF9LmGUL8aDyhlKwTdW+36yEN/qA==
X-Received: by 2002:aa7:d788:: with SMTP id s8mr7503399edq.9.1640390983968;
        Fri, 24 Dec 2021 16:09:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k12sm3011051ejx.119.2021.12.24.16.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Dec 2021 16:09:43 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] cgroup: rstat: explicitly put loop variant in while
Date:   Sat, 25 Dec 2021 00:09:31 +0000
Message-Id: <20211225000932.7253-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of do while unconditionally, let's put the loop variant in
while.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/rstat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1486768f2318..a9d344e0521d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -124,12 +124,10 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 
 			prstatc = cgroup_rstat_cpu(parent, cpu);
 			nextp = &prstatc->updated_children;
-			while (true) {
+			while (*nextp != pos) {
 				struct cgroup_rstat_cpu *nrstatc;
 
 				nrstatc = cgroup_rstat_cpu(*nextp, cpu);
-				if (*nextp == pos)
-					break;
 				WARN_ON_ONCE(*nextp == parent);
 				nextp = &nrstatc->updated_next;
 			}
-- 
2.33.1

