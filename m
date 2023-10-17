Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D697CD10F
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjJQXwu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 19:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJQXwt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 19:52:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AC9C4
        for <cgroups@vger.kernel.org>; Tue, 17 Oct 2023 16:52:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b6559cbd74so1081679466b.1
        for <cgroups@vger.kernel.org>; Tue, 17 Oct 2023 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697586766; x=1698191566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ijNKUZrGV/QasB3HbEVN0PUNmDp0ZQ9fTyJ7U2oDSY=;
        b=odOFKQKRCbpd6C7Ejnzx3VM1Q6iAxZ3l+kMpObxGf8hjWkvbi19wt0Qwr2c3tiS6D1
         LCLCG4k12av6qNtUFvUWXs0XR8jWIfxV9FV7M796lUUcWTYlRrJo4z8wyPl59ONdtVCH
         GSJ4iEIUzGQBCBEX7y89MxmNou3bumZCH/mkX8Pqn+ZoOBW8yOKQMp/i9WhgPUExS+k8
         xP/71emdLGrp+REGBrk9R2c072rp8t4cxyEsWixRfSc8TmtzVM3q+gl9yKDRqogCscqs
         2Vaqaer67Smqknbd8kID1v6uZgrqRjE7+jSlOB6ItMXP1X8sJl7t88+sMtZZDUt94W1p
         WWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697586766; x=1698191566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ijNKUZrGV/QasB3HbEVN0PUNmDp0ZQ9fTyJ7U2oDSY=;
        b=XVCUNLHFKO1KV1cLaIOjLdD+4dJf49C3DaL4P09h2dM0LoFwXYOTYKNDnIahlZMhPy
         o+l+kA6KejTuEdsPv71BuZwobCt+smSSDIuWyhEW5dxy/O8NmKj1C6UFyGec8TFG/WEF
         /lZr5SXFEvLf38vnXOa7QU73pjmT9c/8PiZaau+rdFg/8yApyraFZFBc0gCAWjGK1q4k
         UBmVT8IMOygmoiMtchzwZP3EHUNVSZpY3hhxUc7/3I2Njihczy/7+1ba/b/Ay+7fSlnl
         wQqS2CnzS/hAPyCQtc+6ile1R6Xv5x6Z3NtJBiK7eFkid0nmzrU6+9b0NdJcOqCgm2vh
         UJ7A==
X-Gm-Message-State: AOJu0Yyq+C86fdFiIbe7qVEu2lb7h7WOljdr8pL0Iq9HPK6h9S4ZtdEN
        3LGYYAPq4dByWbYfQuGzZZRQpiWAC4AY67JTQx2ytw==
X-Google-Smtp-Source: AGHT+IEzYA1bgwAcUa3xXt5MPooJrDGhJmuxWFHodU9x0oj0lJCyt5H9ezXwDqD75m2OTGyAg6uLlLHUJW4p500RG5o=
X-Received: by 2002:a17:907:7ba0:b0:9be:ca44:87b6 with SMTP id
 ne32-20020a1709077ba000b009beca4487b6mr2683655ejc.3.1697586766359; Tue, 17
 Oct 2023 16:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
 <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
 <CAJD7tkbSwNOZu1r8VfUAD5v-g_NK3oASfO51FJDX4pdMYh9mjw@mail.gmail.com>
 <CALvZod5fWDWZDa=WoyOyckvx5ptjmFBMO9sOG0Sk0MgiDX4DSQ@mail.gmail.com>
 <CAJD7tkY9LrWHX3rjYwNnVK9sjtYPJyx6j_Y3DexTXfS9wwr+xA@mail.gmail.com>
 <CALvZod6cu6verk=vHVFrOUoA-gj_yBVzU9_vv7eUfcjhzfvtcA@mail.gmail.com>
 <CAJD7tkavJDMSZdwtfxUc67mNBSkrz7XCa_z8FGH0FGg6m4RuAA@mail.gmail.com> <20231014160831.73785b15e9b34eb6146d5497@linux-foundation.org>
In-Reply-To: <20231014160831.73785b15e9b34eb6146d5497@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 17 Oct 2023 16:52:06 -0700
Message-ID: <CAJD7tkZDarDn_38ntFg5bK2fAmFdSe+Rt6DKOZA7Sgs_kERoVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, michael@phoronix.com,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 14, 2023 at 4:08=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 12 Oct 2023 15:23:06 -0700 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > Meanwhile, Andrew, could you please replace the commit log of this
> > patch as follows for more updated testing info:
>
> Done.


Sorry Andrew, but could you please also take this fixlet?

From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 17 Oct 2023 23:07:59 +0000
Subject: [PATCH] mm: memcg: clear percpu stats_pending during stats flush

When flushing memcg stats, we clear the per-memcg count of pending stat
updates, as they are captured by the flush. Also clear the percpu count
for the cpu being flushed.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b1377b16b3e0..fa92de780ac89 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5653,6 +5653,7 @@ static void mem_cgroup_css_rstat_flush(struct
cgroup_subsys_state *css, int cpu)
                        }
                }
        }
+       statc->stats_updates =3D 0;
        /* We are in a per-cpu loop here, only do the atomic write once */
        if (atomic64_read(&memcg->vmstats->stats_updates))
                atomic64_set(&memcg->vmstats->stats_updates, 0);
--
2.42.0.655.g421f12c284-goog
