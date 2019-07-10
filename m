Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8584264DC0
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2019 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfGJUvk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jul 2019 16:51:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37760 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfGJUvj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jul 2019 16:51:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so1809163plr.4;
        Wed, 10 Jul 2019 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XFh42r4xNNDnKj1zoXVhN66idRikWSnd44I9jtIogT8=;
        b=myn7c+wAv6aqdY+Lq3Y+dXFf6vNr1cjq2qmjuWFHefy8B5VaVPpKh1Zen3sG5yyIau
         S+fHXCHIHZK62ZZZQl4GKYZx3aqVkisP3cvekm3Q2t6MsiYuNCz6lFoZZVErcPhI5YZV
         snwp1Si+NXJ6E0KkySFS60F7xP2MZCSzvuNezrwuELLs11zfq6G+U57lKx0qEXGH6Qme
         qdfnP7ElPrZVbfMFcyH7L8UlwlmnfQtiId0n8Gqx/bAFzRnEaucNrTNvzxXthawnlvdj
         8A7r/XaX0aXuYCbPy/wXIVRykURG6GzFcY3gU3eCkjiM7Ob/nxMrMiezEJGx/7EQkEsq
         ClHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XFh42r4xNNDnKj1zoXVhN66idRikWSnd44I9jtIogT8=;
        b=iDekIL77flmAUKZ7tzAk0mpdULFWI3E0f2pu0c4h8ySDVrECh+T4QK6ZeOy8hBRoOp
         zDj40tz8quFZr+xcEGEEkpP55+fbJLz1tap8FIrZdjdCoOjmg5tpXFsv5cgLfkrwnOBV
         lYfFAzU7d20XnZBJEhrlH572By59TIj975KgSn/y0+7dhlzhQKYhpRZ56lOpwZl3wjSx
         +34f00OjhIjUH/HBHzqZ+NbmBwGQynpHpMaJKwgIE5vzYpTcIewmrHOY5k8TlT6tFE8f
         R/+xZ08xq7IpkjlMxPUvkZRi1Ly4Ytsu5v6Pf6j44QljMPWL6qTmgj5g63C7k6WvxyNd
         c/Kg==
X-Gm-Message-State: APjAAAXSjR9MIV7cmkdhHeG6sALIStLinMRKHIAmJ6evv8GFRFDs0jBg
        6LKECwaCSd/cuNi0DG5iZEk=
X-Google-Smtp-Source: APXvYqyMYaCesHjDSO3tjziUf1/tTJyoPpCfWQ3N184VItnK3jQutxIpIKeI/r2/yV4cIxE32ikmsg==
X-Received: by 2002:a17:902:26c:: with SMTP id 99mr216067plc.215.1562791898990;
        Wed, 10 Jul 2019 13:51:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id q36sm2936037pgl.23.2019.07.10.13.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:51:38 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/10] blkcg: make ->cpd_init_fn() optional
Date:   Wed, 10 Jul 2019 13:51:20 -0700
Message-Id: <20190710205128.1316483-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710205128.1316483-1-tj@kernel.org>
References: <20190710205128.1316483-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For policies which can do enough initialization from ->cpd_alloc_fn(),
make ->cpd_init_fn() optional.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 75f7f78b87b2..818e50b4cc7a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1478,7 +1478,8 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
 			cpd->plid = pol->plid;
-			pol->cpd_init_fn(cpd);
+			if (pol->cpd_init_fn)
+				pol->cpd_init_fn(cpd);
 		}
 	}
 
-- 
2.17.1

