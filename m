Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E9782B93
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjHUOVk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbjHUOVj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 10:21:39 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1F127;
        Mon, 21 Aug 2023 07:21:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 4332B1866B0F;
        Mon, 21 Aug 2023 17:21:17 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nmMrT0FTAkwZ; Mon, 21 Aug 2023 17:21:16 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id D56661865CA5;
        Mon, 21 Aug 2023 17:21:16 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EwXuEzTsToRB; Mon, 21 Aug 2023 17:21:16 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.13.132])
        by mail.astralinux.ru (Postfix) with ESMTPSA id B6EF518668CE;
        Mon, 21 Aug 2023 17:21:14 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] mm: memcomtrol: add warning in case of rtpn = NULL
Date:   Mon, 21 Aug 2023 17:20:51 +0300
Message-Id: <20230821142051.31889-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kzalloc_node may return NULL. So rtpn should be
checked before dereference in mem_cgroup_init.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 95a045f63d98 ("mm: memcontrol: consolidate memory controller initi=
alization")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..7998dbf3c7cd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7377,6 +7377,7 @@ static int __init mem_cgroup_init(void)
 		struct mem_cgroup_tree_per_node *rtpn;
=20
 		rtpn =3D kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
+		WARN_ON(!rtpn);
=20
 		rtpn->rb_root =3D RB_ROOT;
 		rtpn->rb_rightmost =3D NULL;
--=20
2.30.2

