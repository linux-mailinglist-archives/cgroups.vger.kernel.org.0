Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A045173
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFNB4j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:56:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32880 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNB4i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:56:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so586927pga.0;
        Thu, 13 Jun 2019 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=75WxO2o1ANUQ23e7/l2/5rNs/NOLt4FGGwCAxlIKBW0=;
        b=qx1z00X5ideAjYd6TZno/ffdD3lXZInAFbMTneAqyt87oXP1watdYXmJaxvV7i70+G
         QpegO3wNlUlp8uYvqU7gCtA0MMQ+50hw60oZ2oxmw9x2Jy4gnpJIQzra6tLSMwfBxixg
         oxoSLws8KwRRq3WsL51VV1fof5qGlk1TNyAVDX20xydqNskOTyUeGxnQn5kpTy3OzlgA
         sG0iO7FqjL8JbO7fRzeM30Ap62l7DtUtqZawypoCeMS4jDMsqiDV4AdS+fukMbglBWcy
         R7RseVVwtMQ3x41JRBOLGi1B+ojxYMpL3G6psCVFbFKe4UPn0loETZobi3dZKh3TanSo
         Ty/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=75WxO2o1ANUQ23e7/l2/5rNs/NOLt4FGGwCAxlIKBW0=;
        b=DhkHoJhAhMYOI5lhkT54dYzYAjFTctWd1611tYIl5s+vUeLFecQEJCTtFOVo0+BrBe
         UKK9pyxHNkJ/aUodlJgsi2eefPL4cV1qi7e5Ncn/ERmpjZnNGs8z619wzHhKh+yA41PD
         eAEXj4Kh39GRcVfr83SbAroVz73cnrNiNzzfXmOI/UTtopIg4JLI127npdlj1nSy2WsT
         ldJ7dueMH/IYUoHJkWsEnBIkZHVl64DK1k1GCTQ4cC8/J4kr13sYBy8GzjhWkEw0JR4Z
         K5K3fiNTrBgip/kPXe2D3X8avZ1AtwM9HUvoxhUJWmuKjCxOAnllf30KaDLHso+K4hYY
         HVXQ==
X-Gm-Message-State: APjAAAUEmOLO2kP3DPrWDSNYdT7e1hNJeD61xRdFhfMYFINst1/neMjb
        qoG+jGlU30nguaXmY5jRXyU=
X-Google-Smtp-Source: APXvYqzfHreRH8W3dhKxFdTroyccvUGMNr4JzJpAQoB6vQcwIfC9El/LMMPaw3HLqY9Qgk8R6ftpbw==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr34123441pgi.412.1560477397146;
        Thu, 13 Jun 2019 18:56:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id z11sm1029370pjn.2.2019.06.13.18.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:36 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/10] blkcg: make ->cpd_init_fn() optional
Date:   Thu, 13 Jun 2019 18:56:12 -0700
Message-Id: <20190614015620.1587672-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
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
index 30d3a0fbccac..60ad9b96e6eb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1534,7 +1534,8 @@ int blkcg_policy_register(struct blkcg_policy *pol)
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

