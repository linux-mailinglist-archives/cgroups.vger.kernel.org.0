Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552084714AD
	for <lists+cgroups@lfdr.de>; Sat, 11 Dec 2021 17:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhLKQSg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 11 Dec 2021 11:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhLKQSg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 11 Dec 2021 11:18:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF99C061714;
        Sat, 11 Dec 2021 08:18:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so38786462edc.6;
        Sat, 11 Dec 2021 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IHNV5z0x2jo1zjIuAESnRBcnC6JnxrBxV+EMdX4SQgo=;
        b=Nu28QEEe5uRu/XwGNZoYPdEhWEjIkWlgSm1IZEOmtMMceXKjkm+Klsboqr7sRee6/g
         n5HHyV5kLt1mxnI6nsWOv4Yrp2Tf/39hDgzKInsrsCE50q7o42JXRS4rFqZf47rQ9tkD
         pw8A6Prm8KprY2HyQTRyxM2TLqW0zKR9kcQmdSkhrmnHdN32DSyMnCprFKAYmCVAYmL8
         UvFvY7Hcz/neuuenM4vnKmZD9bvE+HoepYYDiaR2XI8YpG0fz/MmZm2opxUzfWaABipw
         UqwzhcgEG77C1txXtucsOXrUtpqUt/GoNy/dcJn7yeku2IDHqy5/NA1T6Y3dIEtEsFG/
         e4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IHNV5z0x2jo1zjIuAESnRBcnC6JnxrBxV+EMdX4SQgo=;
        b=6trbiYDPXEsCP3EJiNRo1zLMaIPt0BKJTNv38acc8WcEsXiGA9w6nX1EyLv7r8sir8
         tWABblOf1i0p8jAPOqapyhAIds4FZf5kS1TcH1VmQ6XRpi9IHrw1p6y6WTunXze0zgCD
         96HCvzcHoGR96v0tEBo3/RR9g0+/SrDqWOPbWppx7zlaFOowaUpR7jswvY68hy23sHN5
         Ua2wPOiewRxf/5+bZFR1oAbGwJ9toJnrchWBGuv4BRk4PF+D3dpI3pHy65j3nXrJwRfP
         2KYGYDpnLMpwx8S0wsrGpiI4ythhjBX3UaZ4AUlfW5olUOZjjTxhrValOKj7ILuGjmqv
         Gt7A==
X-Gm-Message-State: AOAM532rxijuXFSKQbLUFq4b9hpQw6RvoRSqhYexilbA5t3UelFXinGt
        Ofkmfl8CRa9Aa9WgRBJ8QDE=
X-Google-Smtp-Source: ABdhPJxyIBZMZsCCK0duAvZ0ixgnC4EypXkY3eKOxl5TuHtQdFy1O0RX/2diHlJgKUYAeqoprPjRjA==
X-Received: by 2002:a17:907:72c7:: with SMTP id du7mr32246201ejc.424.1639239514568;
        Sat, 11 Dec 2021 08:18:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e8sm3576032edz.73.2021.12.11.08.18.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Dec 2021 08:18:34 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] cgroup: return early if it is already on preloaded list
Date:   Sat, 11 Dec 2021 16:17:29 +0000
Message-Id: <20211211161729.10581-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If it is already on preloaded list, this means we have already setup
this cset properly for migration.

Let's skip this cset on this condition.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 452a723d4a36..2cf729afe834 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2648,11 +2648,11 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
 	if (src_cset->dead)
 		return;
 
-	src_cgrp = cset_cgroup_from_root(src_cset, dst_cgrp->root);
-
 	if (!list_empty(&src_cset->mg_preload_node))
 		return;
 
+	src_cgrp = cset_cgroup_from_root(src_cset, dst_cgrp->root);
+
 	WARN_ON(src_cset->mg_src_cgrp);
 	WARN_ON(src_cset->mg_dst_cgrp);
 	WARN_ON(!list_empty(&src_cset->mg_tasks));
-- 
2.33.1

