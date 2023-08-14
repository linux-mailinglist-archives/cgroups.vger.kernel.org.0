Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8612B77B217
	for <lists+cgroups@lfdr.de>; Mon, 14 Aug 2023 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjHNHJz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 03:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjHNHJv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 03:09:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C28E77
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 00:09:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565331f0736so3137609a12.0
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691996990; x=1692601790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0c3TLEEphAL5/eO0YPgnOFzgaQ5OvBXzIFtvrL+QOK4=;
        b=F1xTxqTrvmFeFiUwpFxZm3x1pFr/mDQ1sBDBqQiiQYoLeWGdyQnoRyVZk+3sIzi6FN
         aRK8HpgYM40c5hmWVDml1XrE0VoWDzs1SVzl9lbI3gEbCPKixhnm95T164E3BGz7y/fc
         nFE0Zb0/efoTC2kjjNVHUX8yawznVQg64xNDhBwHnAS6xS7BpCFnXs2mpqZYl77+RHhK
         T+HC/MQRo2R7lbzcivfMB7kvt5ifzOmX3J5HbBlZl66WmIc3vzCTENJr4WDLctWxXGHp
         owXjECGkqq1B4C1wHG18SY7DCVj0eB7hN3Wp3RI7qy6LTNpieHLJuLReiOrWMpnH1iOu
         hQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691996990; x=1692601790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0c3TLEEphAL5/eO0YPgnOFzgaQ5OvBXzIFtvrL+QOK4=;
        b=P0MvME8u3SkMY7kBERHbTtTD+zFML5DpN0W4ZDVdfqzqWHM9a/6AfVi5T45m8CBpzD
         BltRjvmIlrJaQr8aU3U8fS/xeresHHbiqZdqoVsXMuXK7gGLEy4vkD47XwYCaUjc6wlQ
         uSzDLe1kJ6AhpY2drP/+Pk91kM1qEkycSV2EPP3BK4I4EBtJJ+zRAfWwld332upFNkMw
         7z8y7xIS4A/WAkPL6zP26os8X18HcOec1NkaATBnH6c4PtH3XkQ62adK6c/u14P6+5tn
         QHVvaFi2xoahN0NvKYLznlrrvFvOrg0mWdYl/LjnZWg7+zKDTO/S94G5K+4GBUYyTBkb
         Dr9Q==
X-Gm-Message-State: AOJu0YzgtKwh478gS5RTxGbxaVRnQYYUtVoXmCZ2Rp431LTvBIK/pQmd
        e4WVfystvPAkH765P6R/LttVaQ==
X-Google-Smtp-Source: AGHT+IH3h9TjelpSKWyiOrXapoN6fmGeM/W3yxjtRhsDcuBlqtxYjfZM4msZETu6o0zwnXEsFk1Lyw==
X-Received: by 2002:a17:902:9002:b0:1b9:be2e:2b40 with SMTP id a2-20020a170902900200b001b9be2e2b40mr8522331plp.50.1691996989923;
        Mon, 14 Aug 2023 00:09:49 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001aadd0d7364sm8605394plh.83.2023.08.14.00.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 00:09:49 -0700 (PDT)
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
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH net-next v2] net-memcg: Fix scope of sockmem pressure indicators
Date:   Mon, 14 Aug 2023 15:09:11 +0800
Message-Id: <20230814070923.35769-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now there are two indicators of socket memory pressure sit inside
struct mem_cgroup, socket_pressure and tcpmem_pressure, indicating
memory reclaim pressure in memcg->memory and ->tcpmem respectively.

When in legacy mode (cgroupv1), the socket memory is charged into
->tcpmem which is independent of ->memory, so socket_pressure has
nothing to do with socket's pressure at all. Things could be worse
by taking socket_pressure into consideration in legacy mode, as a
pressure in ->memory can lead to premature reclamation/throttling
in socket.

While for the default mode (cgroupv2), the socket memory is charged
into ->memory, and ->tcpmem/->tcpmem_pressure are simply not used.

So {socket,tcpmem}_pressure are only used in default/legacy mode
respectively for indicating socket memory pressure. This patch fixes
the pieces of code that make mixed use of both.

Fixes: 8e8ae645249b ("mm: memcontrol: hook up vmpressure to socket pressure")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
v2:
 - Add a comment to clarify the scope of indicators (Roman)
 - Drop code cleanup on tcpmem_pressure (Roman)
 - Fix the lack of a Fixes: tag (Eric)
---
 include/linux/memcontrol.h | 9 +++++++--
 mm/vmpressure.c            | 8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..dbf26bc89dd4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -284,6 +284,11 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
+	/*
+	 * Hint of reclaim pressure for socket memroy management. Note
+	 * that this indicator should NOT be used in legacy cgroup mode
+	 * where socket memory is accounted/charged separately.
+	 */
 	unsigned long		socket_pressure;
 
 	/* Legacy tcp memory accounting */
@@ -1727,8 +1732,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
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

