Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27F1259EC6
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgIAS40 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbgIASx0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B983C061245;
        Tue,  1 Sep 2020 11:53:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t20so1744358qtr.8;
        Tue, 01 Sep 2020 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/aOqugodrjwVnz0DE4cksx9JmSppPabXXJ/nxfNtZc=;
        b=jev6cNZQ2D4dT1yLxz8wo59LUTrlGT9NjwNMYlSaOJupdSMIHQqhqkGoiFnV5DcNBK
         82fbqwvwQMUFuLRqhPkGGSwvv3LKRacsAvrU2//oJojY6uQjwKHPXl4oUzd6bvZUPwDM
         5mtWTRwLS1V9vgjxQMw5mx7y1Z/lRFe/g8xJUSHQvu9tZ41DR28jl9G6tgQ/LcBfbZug
         +Hqz6m94YZD2hYkG3Mxwrl2UcEUDSvls530wuFIPHkJAERESWx63gKPLBCstHpfDOBxc
         6oSzXm8fSrDVGHwA73FrNH0qrXs6X3t9b5TcerJ5aWpH8hk95SH+OeiI7iaouB4ZNTcm
         ndAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=x/aOqugodrjwVnz0DE4cksx9JmSppPabXXJ/nxfNtZc=;
        b=W06OJedFn/2VFnOw8zHlU/D28K5Bkdppku9nDGJ2qS/87Vjs2tOjJ7VDdpWOL4371A
         DJRrLppkcDte9ygiKCMHMMsobWHjQYb3x/xqT6a1UevMfWGnSpDKjrw9e+2yxifIdOtn
         VsamXHdSMUNBfU4zqEJCjMOxi7hKuv8giGgsQJrq7HP7Cihi5rErfQtDVxhHTWCQfhbJ
         AtkZiDA7KKnIbds3MZBM363q2YxLShwl5XrfyO8zwRuWMy+YpOsa5t6LPieDWHC6va+t
         0gQbRPUa/d1W/Mh26YsK+JfZvWpTaqSVvlVFilpsCkidnfoXyuPdWMcnvfB8b0CYg4Yg
         /mgA==
X-Gm-Message-State: AOAM532IbNgw4gYFkgrZEM/x72HcQpXhVNF76gMiVXA7ZlsJWlGdX4ZO
        OChUwdWzirsuIxJtklCs8t8=
X-Google-Smtp-Source: ABdhPJxuQLCLuiS/N4X1Xuj6Bvtd+9llMRvUZvvhogAR26Hlt/0RlGF0I1t/CoxqSkdfpZujCjJ4Bw==
X-Received: by 2002:ac8:691:: with SMTP id f17mr535054qth.241.1598986405405;
        Tue, 01 Sep 2020 11:53:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id k64sm2597259qkc.105.2020.09.01.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:24 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/27] blk-iocost: make iocg_kick_waitq() call iocg_kick_delay() after paying debt
Date:   Tue,  1 Sep 2020 14:52:37 -0400
Message-Id: <20200901185257.645114-8-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

iocg_kick_waitq() is the function which pays debt and iocg_kick_delay()
updates the actual delay status accordingly. If iocg_kick_delay() is not
called after iocg_kick_delay() updated debt, unnecessarily large delays can
be applied temporarily.

Let's make sure such conditions don't occur by making iocg_kick_waitq()
always call iocg_kick_delay() after paying debt.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ac22d761a350..b2b8dfbeee5a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1226,6 +1226,8 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, struct ioc_now *now)
 		atomic64_add(delta, &iocg->vtime);
 		atomic64_add(delta, &iocg->done_vtime);
 		iocg->abs_vdebt -= abs_delta;
+
+		iocg_kick_delay(iocg, now);
 	}
 
 	/*
@@ -1383,7 +1385,6 @@ static void ioc_timer_fn(struct timer_list *timer)
 		if (waitqueue_active(&iocg->waitq) || iocg->abs_vdebt) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, &now);
-			iocg_kick_delay(iocg, &now);
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
 			iocg->last_inuse = iocg->inuse;
-- 
2.26.2

