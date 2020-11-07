Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B292AA3DA
	for <lists+cgroups@lfdr.de>; Sat,  7 Nov 2020 09:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgKGIZB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Nov 2020 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgKGIZB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Nov 2020 03:25:01 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B28EC0613CF
        for <cgroups@vger.kernel.org>; Sat,  7 Nov 2020 00:25:01 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so3890385pfc.2
        for <cgroups@vger.kernel.org>; Sat, 07 Nov 2020 00:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JHHlZp1uRQshZtVOevTd8kVtiW2laSXxZhJcCQo5cWA=;
        b=F6LWRqEvicBf2UN13VB/7aC+ImV1y7V/8eAIjVqjWAEwNwPrnYcDIfH2BaMMj9E2ip
         IflIZc+QBAEB8h6loN1v83UhaNc84Af6eIT42giwMAUXHbeaUCGX3rvDIVgUelI71jU+
         95Jh1Grak51pUzoFZ4LI4Vi2g93k8rgEUr6wh2iThMlZmZvmLUv0KCPtyI+4jtS+TTdp
         m80cSSptzouL5UKP3d7FEzyvu7akyhNQ5VXuct/ShmWhKWc8X8jMpsMecOLELB9aK9Qh
         bYlpdLiVGoJBXeZN1pEepSPZpxe39XZmEGZ5UqhbBadEAWx0ymNvUZc00wJs00Ln99R2
         aYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JHHlZp1uRQshZtVOevTd8kVtiW2laSXxZhJcCQo5cWA=;
        b=L/8l9YT4DI5ZyUWTYmpQBorIqJIrAsCpRnSr8QBJJIDQaycQqDq+kGD4OAb+KZn41B
         QGCkZmc1T6CWHNSt9T9s5DMrSdsUIU9LpU/m/ASrV7sKYtqeAJYP01U3EpPNrwGDahg6
         lyR9vyQziLZ1KWFg2Y4jdTENtx4yCxveiBmAGMV3QDfliiaNZe/waFfBavhM1KEKYl4t
         bINis8Z1+T5YT1zc7Egstbi//m8nvAK29tUiRBkg6si0xGmdiLhE1ITEF5Pj7hX8jY2/
         wl2CcrReuBAVrCGiVyRrXYwhSnUgKJYTzGJt/s6cd5TTMp84+VRsgxihGfCGjJeAFMix
         1m+A==
X-Gm-Message-State: AOAM530tJABq2FlQAPM2FLzBcDWtou7fdVwWD3QVKWrxShjoeDjE07Py
        3umRo+GgFROOBDf1bF+mlA==
X-Google-Smtp-Source: ABdhPJwgcSJr0lc2iZQEQUsRw6j98V2iYoW2P9biBW6H0rb5fe0tan/UdtmeBx4VYA5GihB80p4Rrg==
X-Received: by 2002:a63:205c:: with SMTP id r28mr4838182pgm.100.1604737501216;
        Sat, 07 Nov 2020 00:25:01 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id m9sm4800543pfh.94.2020.11.07.00.25.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 00:25:00 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm: memcontrol: Assign boolean values to a bool variable
Date:   Sat,  7 Nov 2020 16:24:55 +0800
Message-Id: <1604737495-6418-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle warnings:

./mm/memcontrol.c:7341:2-22: WARNING: Assignment of 0/1 to bool variable
./mm/memcontrol.c:7343:2-22: WARNING: Assignment of 0/1 to bool variable

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3dcbf24d2227..60147cf9f0c0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7349,9 +7349,9 @@ bool mem_cgroup_swap_full(struct page *page)
 static int __init setup_swap_account(char *s)
 {
 	if (!strcmp(s, "1"))
-		cgroup_memory_noswap = 0;
+		cgroup_memory_noswap = false;
 	else if (!strcmp(s, "0"))
-		cgroup_memory_noswap = 1;
+		cgroup_memory_noswap = true;
 	return 1;
 }
 __setup("swapaccount=", setup_swap_account);
-- 
2.20.0

