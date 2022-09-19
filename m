Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8A5BD475
	for <lists+cgroups@lfdr.de>; Mon, 19 Sep 2022 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiISSHZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiISSHJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 14:07:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F14621F;
        Mon, 19 Sep 2022 11:06:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l10so28586838plb.10;
        Mon, 19 Sep 2022 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=gEJQAVOMzbt4PPx+Qy3opmg3geJE7rZvH1CdGnwIjt0=;
        b=nbulrSye1Ljiu3ZTZKiIiuL+PXrsz2uUKYqD8NYqbUSgSm3Vi0gErRmMJ0GPmvae9i
         uFrQSoh1Dekn6R4JT7YM9d2sB+smEUc5gTVkoLOgpOXTfVVq5yRmFpBMPNiY+OWHd1Kj
         7sFgW+7uvTFADWLZukSZmOygnPnhuEFahpb4O1RUVtEByOp/h4uLCqIzCz2MARhjf316
         CrtqEu1wm2L0h+YlZ0T1jzFRka98lhHFmUQAsoubRrqiucMdFSGJUbf948tBw19kEGIp
         Y1ZOXVA7Lx/gNKOo6xHFKUxWeh3vBVe2/ypemZtIy0k2iK3bg1qmnklw+AkaME+BTNKX
         jTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gEJQAVOMzbt4PPx+Qy3opmg3geJE7rZvH1CdGnwIjt0=;
        b=f4f+eq/Hhb5uvxU++sijjfDyz0LsyRYBz3u2tVOne0lnkCMB41qjCbTJYrhu/ODQ/e
         CHnB/l41AOx+gnHf5KBNF09gRLQm+V50T3mbtFtGVbLENoLoU2avaAZCRBN+xhOsk1qR
         fWbQrCuc0Z7qIg16wE8DkxV35yugPcFUGOn9h+1juNEVEVxgRl4WDonU+zjS0ikQtlzs
         qhcgkqd/rMUidUTuYkIKjHEs8WGFh+wBYwtsbV1GFfpq7wVmg0czlFytQcSKs5btJrUZ
         7ym8QDlNGP7tnUugoaePqDjvf2+zzjoFnUs8uRMHPzFLaeoiVCloXGQyv4RPBgyuxUjj
         4gZQ==
X-Gm-Message-State: ACrzQf1tMXE6zh/K1CkGvCNQRY0AELq76Au3bl1OrhhRuw6dlWG0bv4W
        XLZFh5a1MTdSNFEiFwk2xNrwVCNG8ux+K3Rx
X-Google-Smtp-Source: AMsMyM5kYJs2A7dAyc++tZB14m9oF8eF+ZjYUe5y9ruXb2TlBiIiCmYHqKap33TnVIIvXllSCIIZfg==
X-Received: by 2002:a17:903:41c9:b0:176:b9df:c743 with SMTP id u9-20020a17090341c900b00176b9dfc743mr967826ple.162.1663610809289;
        Mon, 19 Sep 2022 11:06:49 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([115.171.41.135])
        by smtp.gmail.com with ESMTPSA id u21-20020a632355000000b0041c30def5e8sm14176654pgm.33.2022.09.19.11.06.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Sep 2022 11:06:48 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/2] mm: memcontrol: cleanup and optimize for two accounting params
Date:   Tue, 20 Sep 2022 02:06:32 +0800
Message-Id: <20220919180634.45958-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

V2 of "[PATCH 0/2] mm: memcontrol: cleanup and optimize for accounting params".

Patch 1/2 is a minor cleanup for kmem accouting path.

Patch 2/2 optimizes some hot paths by making cgroup_memory_noswap a
static key, benchmark shows swap paths now have a ~5% lower overhead.

Update from V1:
- Collect Acked-by for patch 2/2 from Michal Hocko, Thanks!
- Simplify patch 1/1, don't drop mem_cgroup_kmem_disabled and only
  change one call site as a minor clean up, update commit message
  for patch 2/2, as suggested by Michal Hocko.

Kairui Song (2):
  mm: memcontrol: use memcg_kmem_enabled in count_objcg_event
  mm: memcontrol: make cgroup_memory_noswap a static key

 include/linux/memcontrol.h |  2 +-
 mm/memcontrol.c            | 27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.35.2

