Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB6338B2D
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhCLLJ0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhCLLJP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:09:15 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B44C061574;
        Fri, 12 Mar 2021 03:09:15 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so15626994pgm.9;
        Fri, 12 Mar 2021 03:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZEYL/pbFIoRQQHylJZyb6mvpBG/vJ0CzVs8U+fDkQms=;
        b=fDVgcd6CradPpZOVQhUMVl1zY6XDbhFqMkk4LY+ex6E56v/JqmtuN+XcpqYkN0QxU8
         eOv3acgR/VQTPgS+YCZlSYLiwXSLKMSCBcguGL40LJ6EOBXrvWHegtWndkARFq8ZVQ1Q
         rcJ99csDt8f0DX2tAYsw0iJ4T2CAGL66fx6rvQx6PEz0Nkzo/KfWE0Gam//0TeEtYzZQ
         xvyYfViiR6iAuln08vPKuT+id9NBl+Zwu2JJxZEkOEZ8/RXIKj9UtpWHvAv0zuLkfupT
         Elq1xJxBCFfVQidEQUGLC1gcHQbQXy/EIcmK0WTWhplSm0Ak+/hgpJf3MjptOgn7T/fg
         O07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZEYL/pbFIoRQQHylJZyb6mvpBG/vJ0CzVs8U+fDkQms=;
        b=r8dwvgH859MKwKA+yF3D25/3QMLoE5SujAqE8T3I05iJgZ0bwh800j9aTfzp+aAQVP
         r5vrCuUu0GrcEakO/7YxMKqeGAKbLXxIXpiP9b37FoazsJVqu1B/Rpi1GolX7GlOxgHm
         Tb1+B2I0b5IBMy6uleq2N+hGr1w+JdePQ//wIVn612XjbcVEiutmQ6luL3KjqRQQxJJc
         DvFd5Um7grbDZFctHjczssSeZx1DQDk6MOGTvic2ttA7oyeTHK6HCbpG/YVpKgs72bH8
         rW8IPpkK4hyv7rgzasucGVonkO/Ie9ixtpMa20spxQ5V5EBHpfA3qT0WQJMRXjtJrTom
         7thg==
X-Gm-Message-State: AOAM532g7GNAtEv7UYh+uyrc2VOzVLZ0BuI5vBDuR4Yg6B3I2js63pem
        2hwG3Y1apcdzcl/AROr0roP9TEiz5pMwfw==
X-Google-Smtp-Source: ABdhPJw+YrsbC3H4O1aCuj7GJv0goHt0TbNgi6zhIsUyNlKRzie8i1hXPGLPWMgqibDXPP5xGFEvbw==
X-Received: by 2002:a63:b1c:: with SMTP id 28mr11292784pgl.165.1615547354950;
        Fri, 12 Mar 2021 03:09:14 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.09.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:09:13 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 11/11] bfq: optimize the calculation of bfq_weight_to_ioprio()
Date:   Fri, 12 Mar 2021 19:08:45 +0800
Message-Id: <29efad299fd111b38ad215dcbc6eb506290e7937.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The value range of ioprio is [0, 7], but the result of
bfq_weight_to_ioprio() may exceed this range, so simple
optimization is required.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-wf2q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index f6c67a80e454..86558a8fede1 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -536,8 +536,9 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
  */
 static unsigned short bfq_weight_to_ioprio(int weight)
 {
-	return max_t(int, 0,
-		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+	int ioprio = IOPRIO_BE_NR  - weight / BFQ_WEIGHT_CONVERSION_COEFF;
+
+	return ioprio < 0 ? 0 : min_t(int, ioprio, IOPRIO_BE_NR - 1);
 }
 
 static void bfq_get_entity(struct bfq_entity *entity)
-- 
2.30.0

