Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4571FB9E
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjFBIMr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jun 2023 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjFBIMe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jun 2023 04:12:34 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C451BC
        for <cgroups@vger.kernel.org>; Fri,  2 Jun 2023 01:12:08 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19e7008a20aso1836266fac.1
        for <cgroups@vger.kernel.org>; Fri, 02 Jun 2023 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685693527; x=1688285527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiy6rp/teLKUThWdNiCcsRgTjbB074BNeS/UwKIzIT4=;
        b=FcENutYDdzs+NLTMwlqtxPI7kQe9B9F3492UNa2AvSZ3MxWSDDRKB0NjErfj07Cy+I
         lcryEwsmuLr/Rna0uvSCsg0jGws2Kih7hnkAQCxmrKEko+IRebwiaimFfWQF9D6EnRg5
         WMt2jLz+Fry5HFMXqRkTZFteE1adrdDLaaTNVhiEDH0oZFH6nmmDOxD1vED/7hp4clg7
         i5VonGkD7Z9+DL2kJT9JGCGy1JkMDhSAZbQA3e3hkKE8ho2Ne1ZAsG7XARqmAqSrku1h
         HS24GS0ml598fRcd3JAWW/6zZ4GINKyFqP9OU8xiW38noVicpGBYIs5cmmN4isHizMin
         XsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685693527; x=1688285527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiy6rp/teLKUThWdNiCcsRgTjbB074BNeS/UwKIzIT4=;
        b=R9PTOkXXSxrEHdl6sxvf3S6wDflSF4fA/XxUpjWN8ESwSeif36HQ+CEw3DnHP70LtP
         AMeLw3lgW5R9UdI/OksS/7DiKvfEdOu9vyCQ6XNc1M9BnDWULkXrfz8W/lj/gtsWteev
         HtByppqKPS4WAcawaP4XrtEghX+6USiyWCEZap/2XbhGBglDahrtufNIW6LJZhGvnMJa
         lzwxF2PCoCuzlDQEAcXgK5rrg9eV4Pd6It712B9Tf91BVXki0Cwd4fKWOisqywMg1FN+
         vI3BpSWdseq72Vv1SBrQqpm0vmHLklbhNfZmpcdxdyrT/ptB+Fsuea6EAbXbnRh/UB8X
         25YQ==
X-Gm-Message-State: AC+VfDxUHZ26eCQsdvweWVa4lUU/XillcS5cMt3V35ML6Q74hihUkEOt
        JKa8I0sg36FDwc5U4409ONVgpniek5ZO9ME+5uk=
X-Google-Smtp-Source: ACHHUZ7CNQtcusWmTYjr7kkqOWjT8K7czNAqdYl2iTFd0Z0fE8k2zcGs/Fog4KFmH0pAmQ29q/PNvQ==
X-Received: by 2002:a05:6870:a8b0:b0:163:3be0:1195 with SMTP id eb48-20020a056870a8b000b001633be01195mr1715224oab.11.1685693527679;
        Fri, 02 Jun 2023 01:12:07 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b025aba9edsm703570plb.220.2023.06.02.01.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:12:07 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/3] sock: Fix misuse of sk_under_memory_pressure()
Date:   Fri,  2 Jun 2023 16:11:35 +0800
Message-Id: <20230602081135.75424-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230602081135.75424-1-wuyun.abel@bytedance.com>
References: <20230602081135.75424-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
index ad1895ffbc4a..22695f776e76 100644
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

