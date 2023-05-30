Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A89715D80
	for <lists+cgroups@lfdr.de>; Tue, 30 May 2023 13:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjE3LlI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 May 2023 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjE3Lks (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 May 2023 07:40:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49EC102
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 04:40:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso5062507b3a.0
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685446845; x=1688038845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMeJmdZ3LE5akFulN2YKZF3yDR93Nfz5GrpK/FAs6Mo=;
        b=MLCKl3OnqWHHyXcRdZaVayKCzY/Bl9wft7bDvD2wXODqoMTB/13VogpAknl5CPMsXy
         wPBLqktlL943IhkSBca1F/4EKfZGosHuGtUVdAkmBtNQRexyuge61JELuTrFyQTGDioc
         F0+b378M/Xr6NaH/X+q+yQL1JQ/nwwtFEKWza3rDI41G736sUwtprZHvXv+Sux07oy6G
         fAZMZSW2ZMmZCDiyKMZRxpfS15mP7ANNqmo2OSU7cqlFHCIbN4eBKRCfszo0suTUZ7wg
         rjPsmbI5Fxu5tY3g9Zhpc4nPO8DVN9OKcwpkE9piTLUZvZs5e+AEoecTNY5JWmxU1rCO
         9ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446845; x=1688038845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMeJmdZ3LE5akFulN2YKZF3yDR93Nfz5GrpK/FAs6Mo=;
        b=hu7rsqLDG9kVMpKFx68RdjMX6P9naJ7MTPp3rqwj13mnlrW2/O295z3eM9VInhYcIa
         0cG2HUXWBBwtw5CekX+jNSNn9kSmRWJHm0MQppf5qPLbx5qg/CDTZOSoltySNrT3dAsj
         y2LHflIQrmmiFk/9j00emZYJy2ob31vFagVpGKDnrQdxL2iT4HrxCKyPQi+jSbDfQ1ro
         Ljt/26g79NZfgo+jAgkVyb8hvAvUsfwVRXz7eC5q+E+SMcE5jYqcOXaoAy/I0kzsXScR
         K50lmcL/Nb3oyLTgvr1VcsD7RPUbWrTH7KWWyw3lpXilezRTi5gbAFNxGNUL1XXefJkU
         uq5A==
X-Gm-Message-State: AC+VfDxKibb4kmdDltk0BSuxDRnFClUQZUKIL0s6Wiy4sQOfEK890WvY
        khSIDp9bjnWExP1i9bGe1n7A3R/ZmSHH/9c/E6s=
X-Google-Smtp-Source: ACHHUZ4FxxxoqYMoybqsRIkoNDdsA2hhrYAf6bOI8yODoZkUkDER+ZRyPtG6yvCay1gYPFhUPVfCzQ==
X-Received: by 2002:a05:6a20:bea6:b0:10c:3cf3:ef7e with SMTP id gf38-20020a056a20bea600b0010c3cf3ef7emr1747230pzb.42.1685446845141;
        Tue, 30 May 2023 04:40:45 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78dd4000000b00642ea56f06fsm1515103pfr.0.2023.05.30.04.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:40:44 -0700 (PDT)
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
Subject: [PATCH v4 3/4] sock: Fix misuse of sk_under_memory_pressure()
Date:   Tue, 30 May 2023 19:40:10 +0800
Message-Id: <20230530114011.13368-4-wuyun.abel@bytedance.com>
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

The status of global socket memory pressure is updated when:

  a) __sk_mem_raise_allocated():

	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
	leave: sk_memory_allocated(sk) <= sysctl_mem[0]

  b) __sk_mem_reduce_allocated():

	leave: sk_under_memory_pressure(sk) &&
		sk_memory_allocated(sk) < sysctl_mem[0]

So the conditions of leaving global pressure are inconstant, which
may lead to the situation that one pressured net-memcg prevents the
global pressure from being cleared when there is indeed no global
pressure, thus the global constrains are still in effect unexpectedly
on the other sockets.

This patch fixes this by ignoring the net-memcg's pressure when
deciding whether should leave global memory pressure.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/net/sock.h | 9 +++++++--
 net/core/sock.c    | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b0e5533e5909..257706710be5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1409,13 +1409,18 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 	return sk->sk_prot->memory_pressure != NULL;
 }
 
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure &&
+		*sk->sk_prot->memory_pressure;
+}
+
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return sk->sk_prot->memory_pressure &&
-		*sk->sk_prot->memory_pressure;
+	return sk_under_global_memory_pressure(sk);
 }
 
 static inline long
diff --git a/net/core/sock.c b/net/core/sock.c
index 5440e67bcfe3..801df091e37a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3095,7 +3095,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
-- 
2.37.3

