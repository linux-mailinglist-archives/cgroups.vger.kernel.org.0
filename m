Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE167AAFD
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 08:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjAYHgm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 02:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjAYHgl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 02:36:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A0A49425
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVG76aWPU3FY34u+v28shR/7Qg472WeM1BX+arjDbFU=;
        b=PFCf9y1aILug4RuXuZ5VVuMIlfN+xTWii3VtkSter+AZ+IHrFtNKfLED+yybJr95iAOI+n
        GrMhDxUrRoVZrqgcv6kRf4+yLSNAuNniz2DLvBNJK5PUmo0ujYb0RsYMu2s35Qglrzitxu
        f2TRjQhFlfP6AoDIqpOz1lehtmC8YKo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-itj9fdtKMnCZhuk92i8MXQ-1; Wed, 25 Jan 2023 02:35:50 -0500
X-MC-Unique: itj9fdtKMnCZhuk92i8MXQ-1
Received: by mail-ot1-f70.google.com with SMTP id w15-20020a056830144f00b00687ec8c75cdso1275568otp.2
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVG76aWPU3FY34u+v28shR/7Qg472WeM1BX+arjDbFU=;
        b=7ypym/6H27sWVHmNEK/5ipy/fil6KznZ/CHK00H/w6m3OyGpd/WM+9MoQgfKd3cQBp
         mohi6ZOrHSc00JWSohXb98f7pcReaTadzdEb2FKNd2roQTcrcl9bl3tPcfDNG+Jgo6Jt
         hpqbj7tPItJfSeMjil1nGb0oTbZqdoaJNjvbQfYKjgr6a/WY1q7CXRmi9sWL5vf7fsmX
         +PTDVEBjd6ooFd80f46NO6lsH3wlQCwPTrOU8RtX98JUOKnjxZB8wNDL1m+YkZgmY17E
         uMAsV3rLDE7Rl6KpLtkFnFkJ1YXtv8SUklrCmQnjjqM7zJVc3eqh41dmsrSB54rN9mJW
         O3/w==
X-Gm-Message-State: AFqh2kq92TwaJuU0EvXs5vfJiAbalmHPMGBCeg7Evzn6/CNyz702aGEd
        4peKx12lA0LdTJrr9tUklKH4enLfAYgwiHMRmo/LWEWNd/vkC7EDbmPNbiRpTAsq4VGneMsko5q
        jsR2JxdFsW5FndY25NA==
X-Received: by 2002:a05:6870:8dc5:b0:15f:74b2:9168 with SMTP id lq5-20020a0568708dc500b0015f74b29168mr14415649oab.4.1674632149720;
        Tue, 24 Jan 2023 23:35:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXva0ztnWMLaJL80saQFKdei152TK3so9LzytflfDAcnAzjhuVwqsk6VSRdFSyzYlYX+q5Awzg==
X-Received: by 2002:a05:6870:8dc5:b0:15f:74b2:9168 with SMTP id lq5-20020a0568708dc500b0015f74b29168mr14415637oab.4.1674632149469;
        Tue, 24 Jan 2023 23:35:49 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id x189-20020a4a41c6000000b0050dc79bb80esm1538802ooa.27.2023.01.24.23.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:35:48 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] mm/memcontrol: Align percpu memcg_stock to cache
Date:   Wed, 25 Jan 2023 04:34:58 -0300
Message-Id: <20230125073502.743446-2-leobras@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125073502.743446-1-leobras@redhat.com>
References: <20230125073502.743446-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When a struct smaller than a cacheline has an instance that is not aligned
to cache block size, it could happen that data can be spread across two
cachelines.

For memcg_stock this could mean the need to fetch and get cache-exclusivity
in 2 cachelines instead of 1 when we bounce the cacheline between local
cpu functions and drain_all_stock(), which does remote read/write.

This could also mean some false-sharing costs being paid due to the
cacheline being shared between 2 unrelated structures.

Avoid this issue by getting memcg_stock cacheline-aligned.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ab457f0394ab6..f8e86b88b3c7a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2188,7 +2188,8 @@ struct memcg_stock_pcp {
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
 	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
-- 
2.39.1

