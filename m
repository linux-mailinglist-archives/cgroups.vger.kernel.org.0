Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ACB74EF31
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGKMmY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGKMmW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 08:42:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F16D9E
        for <cgroups@vger.kernel.org>; Tue, 11 Jul 2023 05:42:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3733834b3a.3
        for <cgroups@vger.kernel.org>; Tue, 11 Jul 2023 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689079341; x=1691671341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmg9w9P3JYlTE5YF/tdSGmQe9gMk9DKIlFnuajmtraM=;
        b=MQ5ty+Ms9xq2Gf8tT1u5KINp7LbCz3vSzcp6PPkar1PjXy2UOGDAONbcJWbI+E3Z1E
         ikZ8U8ait2Sr5BYSdZ0mnqv3UujdxGaHwIDateSlAtRLzEgup9mGA8YcL/qo1k0FBGy/
         FtozdxhzC6z10cVS8YU1HM4+O48pgEHDp5kJRIJNhHnzy5o1QbbQV3vpzByt9eoJCZRF
         j8KrPcF99ChxD4ntqNGXPWk8MUCnNrtMqO4RYfasM8ZE8cbOScyeoYS5plADx8+31TVK
         GOG7vI2PVHSpTcdBFa0p7rhtBHE39/Z0gT8Ap6MdmyXF7tQb0/Zbshyqv+rLDj6qHTCL
         oBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079341; x=1691671341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmg9w9P3JYlTE5YF/tdSGmQe9gMk9DKIlFnuajmtraM=;
        b=TPeHd/wJ1BOUFUsWLk8aAmCadF12tSN4QOYoMeawzot20gCJTCa0sDdwU8lNUReJB6
         w5TLPB18lSfGRmL1Q9AX6+Ia09had7rGlraIU5acbkKzZwqmpo/r7wUfV644OyvBC2Uu
         RYYstwQyC27BG7nGg9AbEVTVIYCz1asLR4tBoeajn4YZyl2zNqO7kPXZy/4i0kzpuL95
         yxdWTr87BFg8Y+eRlKOCI8Onhj97IYlRJTO/Pea02htneUuDPVFYchBBGKhojU8KcGcu
         CJlCykaWVWFx1PA9F4M2Pt/WxX3OHXJydMuFGH+5fkVkPPdPRxWP47eQzCLpd4CfE2jf
         nXzA==
X-Gm-Message-State: ABy/qLbw9Huq2V7wPYggasbodJekmnhCMnOECSDdONsqm9RWuIkgqfht
        GewjrtItC0h7KojKUWnRutK9mw==
X-Google-Smtp-Source: APBJJlHySXBwiacKDORZhjNJUBjRrtdwMto4+SpJ1LfQJNYde55u+zkHIULuNxcqHK6dl79az4tI4A==
X-Received: by 2002:a05:6a20:3948:b0:127:8833:cce3 with SMTP id r8-20020a056a20394800b001278833cce3mr15034530pzg.8.1689079341001;
        Tue, 11 Jul 2023 05:42:21 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d27-20020a63735b000000b0055c0508780asm1512222pgn.73.2023.07.11.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:42:20 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of sockmem pressure
Date:   Tue, 11 Jul 2023 20:41:43 +0800
Message-Id: <20230711124157.97169-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now there are two indicators of socket memory pressure sit inside
struct mem_cgroup, socket_pressure and tcpmem_pressure.

When in legacy mode aka. cgroupv1, the socket memory is charged
into a separate counter memcg->tcpmem rather than ->memory, so
the reclaim pressure of the memcg has nothing to do with socket's
pressure at all. While for default mode, the ->tcpmem is simply
not used.

So {socket,tcpmem}_pressure are only used in default/legacy mode
respectively. This patch fixes the pieces of code that make mixed
use of both.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/vmpressure.c            | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..5860c7f316b9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1727,8 +1727,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
-		return true;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return !!memcg->tcpmem_pressure;
 	do {
 		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index b52644771cc4..22c6689d9302 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -244,6 +244,14 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 	if (mem_cgroup_disabled())
 		return;
 
+	/*
+	 * The in-kernel users only care about the reclaim efficiency
+	 * for this @memcg rather than the whole subtree, and there
+	 * isn't and won't be any in-kernel user in a legacy cgroup.
+	 */
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !tree)
+		return;
+
 	vmpr = memcg_to_vmpressure(memcg);
 
 	/*
-- 
2.37.3

