Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CF6D0E94
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 21:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjC3TTH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjC3TSj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 15:18:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C91026F
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 12:18:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b124-20020a253482000000b00b72947f6a54so19812483yba.14
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbNC07VGnJucfMQdaVru/HWxeCTMcNM6hFkgQ/MCeFU=;
        b=PUv9MA0n+Z8fm7ErrGvHySjECm+JmVMmb7yIewlfjR/61XxilLPkk2HWdbFMTfUOaL
         VEd5S3Db2lj6fZaM1EVkiIBt/SsoMNdbAydQDGkFf9C+290T1e1uwhZ4tZ9DFf8Phq0h
         P4OVDvENTCX+3IndK3Cvs6OkRD4foG1c4Yew7PAGOLNrfjOHkmrszhM9+d8Istzt+wK/
         krUK3yorRZOqS1BM/g9ye1FRB5jRNaXtQwUxDYcXcRNeFj0C93RhkVtRFak+8MvkC/U9
         MW/LMGQgSZbJ8G2s7XbIxfyCgArJtDyQ9vNCBWNE1utNTCLeMAHTcanEcYFbU2EbD5hm
         feog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbNC07VGnJucfMQdaVru/HWxeCTMcNM6hFkgQ/MCeFU=;
        b=lMw7UrYghNW7TruoRxNjnNRAvD8/9zkN56S282mPziOkq5JeEdykSDhivPppBaYFzx
         +Eanp85NPZ3+1XEaMg3eBbWN17dqf9Ask1ETbZK9tNGe2H63mVz+9IfO6rYLrnvnQNL4
         KDCf0F7QCztZOZ4S01GNIMvlqicnC3tMvvfPlwjXVwJ8EpQqPs+ZXDCH7FCN3yXIukWu
         W/KEfFDxL67TlnkS7ZM0KhxzybfllGB6c5kC7Off5Frz2D1VPd0//1o84OItW/mhXSoV
         Y2wDvz+hSnjxWZdvApFWfw/B6jgPr1i/Tnt6Ox48MWX6WzKkybDOe1/LMU5TTk4H8W1l
         d/nA==
X-Gm-Message-State: AAQBX9filgAnBvsTJ7XHcvHdurh67TvTNp7YrRjzsihIZ9tKxt8gjXkF
        wHDZ0o9+zsSiI/VPWEkRED0rWLFQDAGsouKJ
X-Google-Smtp-Source: AKy350Z/bGsj2O9Q2OanxyiTVpU0KIn4cOhMHnfEJjh1llR4Xo1YrB6Sk31TDPAteoghtoX9TuixuaLotnLFVi3d
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:12d4:0:b0:b6e:d788:eba4 with SMTP
 id 203-20020a2512d4000000b00b6ed788eba4mr12664999ybs.6.1680203898630; Thu, 30
 Mar 2023 12:18:18 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:18:01 +0000
In-Reply-To: <20230330191801.1967435-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-9-yosryahmed@google.com>
Subject: [PATCH v3 8/8] memcg: do not modify rstat tree for zero updates
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In some situations, we may end up calling memcg_rstat_updated() with a
value of 0, which means the stat was not actually updated. An example is
if we fail to reclaim any pages in shrink_folio_list().

Do not add the cgroup to the rstat updated tree in this case, to avoid
unnecessarily flushing it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 361c0bbf7283..a63ee2efa780 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -618,6 +618,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
 
+	if (!val)
+		return;
+
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 
 	x = __this_cpu_add_return(stats_updates, abs(val));
-- 
2.40.0.348.gf938b09366-goog

