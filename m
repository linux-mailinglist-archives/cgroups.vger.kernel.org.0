Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D9715D89
	for <lists+cgroups@lfdr.de>; Tue, 30 May 2023 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjE3Llk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 May 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjE3LlS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 May 2023 07:41:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E71114
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 04:40:51 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso4844799b3a.1
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685446851; x=1688038851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnVh2joarXNT9aj52CHZE7i4DFTKtYVUHBE2hndAHFM=;
        b=btr0FoS+C6fgN8Erg41EU1t5DJZD+PGpyR8bakM6GW+5ICYCzcrthDnH/6xVPa+R/Q
         wG33TV1SZXTSdoEBPSuVByreJr8Gqe+O51Rrgz9Y73Q9ejyvJRjXK5eIT9djyPPlFgvb
         7yjesf0wmL+VpcChkGgR+xTrD7A7FInxqIyHcX7V0kBikEvD+Gcmwvvj1tjFmu6SjTWU
         1mtHFPzNab3djs/NQuIwpZKWzAqcOIj7G4B3U0h+DRCca2OlBrJX+tqBNTydDQfcbJO7
         DKVs5NHggfUWPYEokBru5ocQ0Gp4jvD47OV3sXrkPMdZtcuktJf9yWqNjhJ2I4I7b8BW
         09mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446851; x=1688038851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnVh2joarXNT9aj52CHZE7i4DFTKtYVUHBE2hndAHFM=;
        b=gd9CzDey6rj0IU6dSQ1xMDhZ0QWJVRiovV7WpygzAA0wUpo2jUVoWicnp2b+HlwnGa
         WWh5gfbVwC7MInRT3aWNW+VsxNJyAxKMHVOte1a+ZXsnyGU5/2lFdQbNciitTlfo+wEF
         TLzZxVfOOsGsddZKHwY7LES8A2ZKKti8LS7biyCR7765xpkkR4lRSVtQ7d0tIbakBdYm
         lel2vmaV0E9MTjeRhBiARUID5wd6iVrORw9xi71T+wMyXYVLDiV95nHXw0u61GYdClzS
         whLBAGKQDhwr6wh5KE9dMcoC48mjS1Yhx8tpF+dQSEnE/xHmC1pwkHBcOXWESTHsUMuX
         kg9g==
X-Gm-Message-State: AC+VfDwEP/9GSdc0WmOgXyooinRdvafHKcD13QwhEDgHl56QnIP++XIH
        di2GmxM+ffU9q78DigdV/B1BAQ==
X-Google-Smtp-Source: ACHHUZ7/L6D/t8C+fhV1v7/kaE8Q+tmoGMGurwakklgYU2DF5zQp3EuB0WovCQ651Y9p7EeFL5iXhA==
X-Received: by 2002:a05:6a00:b81:b0:643:5d7a:a898 with SMTP id g1-20020a056a000b8100b006435d7aa898mr2408213pfj.0.1685446850941;
        Tue, 30 May 2023 04:40:50 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78dd4000000b00642ea56f06fsm1515103pfr.0.2023.05.30.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:40:50 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 4/4] sock: Remove redundant cond of memcg pressure
Date:   Tue, 30 May 2023 19:40:11 +0800
Message-Id: <20230530114011.13368-5-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230530114011.13368-1-wuyun.abel@bytedance.com>
References: <20230530114011.13368-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now with the previous patch, __sk_mem_raise_allocated() considers
the memory pressure of both global and the socket's memcg on a func-
wide level, making the condition of memcg's pressure in question
redundant.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 801df091e37a..86735ad2f903 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3020,9 +3020,15 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
+
 		alloc = sk_sockets_allocated_read_positive(sk);
+
+		/* If under global pressure, allow the sockets that are below
+		 * average memory usage to raise, trying to be fair among all
+		 * the sockets under global constrains.
+		 */
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
 				 atomic_read(&sk->sk_rmem_alloc) +
-- 
2.37.3

