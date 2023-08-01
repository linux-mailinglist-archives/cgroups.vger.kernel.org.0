Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7276B9D0
	for <lists+cgroups@lfdr.de>; Tue,  1 Aug 2023 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjHAQkQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Aug 2023 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjHAQkP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Aug 2023 12:40:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB91FFA
        for <cgroups@vger.kernel.org>; Tue,  1 Aug 2023 09:40:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1f6f3884so271524266b.0
        for <cgroups@vger.kernel.org>; Tue, 01 Aug 2023 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690908013; x=1691512813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qjFUw6+lEzkCCKqkbY3T91pufwJOps9NprX6UVn+h8=;
        b=p6fiXJVO6VAT7ddDlyeNeKo0u9g75XBshHTDYQkWpxGEUOGoOVAa7lHgsGvQZ5v/+W
         OL8o5krg+sbCk3k/ILPv5kJcGtc7Hl7e/Ptk68GNbUYDFS1ZLOXSdMFbtMgISIwiBvXM
         xA5PCRA4fUyBY1hNJB6x57RpX4pHwvLO70MzF7vtOTGutOLMa2G02e6PwMjrWoV32oEH
         b6YlMDU2PYjQiFSB63POIJeR3bgDccie71bMuCrG1M0DF1oPPZLzqfczUjMBmkdzgXbl
         zrQDN3zGYffW49VbgVfFPFSdFMhkF99msYQ0hnralZcPwwvzI8CmOTzVDqdh+UFOFJjq
         Lm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690908013; x=1691512813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qjFUw6+lEzkCCKqkbY3T91pufwJOps9NprX6UVn+h8=;
        b=GSEEjc5eb5mNmpgVTZsLfn8+FFsUkuH6IGmxg4qb0342MUqJ+sFdmQI5HMDqMJOxrU
         5wcUPiffJTxDei81Pkgnzoc50X1cKVSKwHyG6i+sKCjE/e2ezDn066wLgafGbO2oN7OV
         toEL9RtlE8pBQ8PX843gRRYvWcFOfdpDL2+J9BXDAhR7Qb9WllKpYwkkXE1DMQui3Llx
         dmV2LhFO0Ywh3RjBeem7NqETMyBSGjTY4OQIN2tcQQDZQW1HF/mrv/QLqnAP7S2CiiRI
         v1RwtSsfx4HLz1VfRVTCHATJSYcR+gq+6VfqGKE43admwrZ007UAymp2ofkKri2Q56QQ
         Ji9g==
X-Gm-Message-State: ABy/qLZuqAeV6t9yh+dLJZKRewap/XCj8Y89wEUGvZYCCVinsugPDAPj
        VR+kWxWh1F8Q95nxIll7I6hb9gJLme8uuJjOIxF+ww==
X-Google-Smtp-Source: APBJJlEOr1teCw40TvLuDNBikvF5ICCk1wj7SeHDxgnRGozU1Gwr56AHW9TbZUOhBSqnj1vnRQImF4blOlMh+ybaaJ4=
X-Received: by 2002:a17:907:75d0:b0:989:450:e567 with SMTP id
 jl16-20020a17090775d000b009890450e567mr2977498ejc.65.1690908012991; Tue, 01
 Aug 2023 09:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230726153223.821757-1-yosryahmed@google.com>
 <20230726153223.821757-2-yosryahmed@google.com> <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
In-Reply-To: <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 1 Aug 2023 09:39:36 -0700
Message-ID: <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: use rstat for non-hierarchical stats
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 1, 2023 at 7:30=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 26-07-23 15:32:23, Yosry Ahmed wrote:
> > Currently, memcg uses rstat to maintain aggregated hierarchical stats.
> > Counters are maintained for hierarchical stats at each memcg. Rstat
> > tracks which cgroups have updates on which cpus to keep those counters
> > fresh on the read-side.
> >
> > Non-hierarchical stats are currently not covered by rstat. Their
> > per-cpu counters are summed up on every read, which is expensive.
> > The original implementation did the same. At some point before rstat,
> > non-hierarchical aggregated counters were introduced by
> > commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
> > memory.stat reporting"). However, those counters were updated on the
> > performance critical write-side, which caused regressions, so they were
> > later removed by commit 815744d75152 ("mm: memcontrol: don't batch
> > updates of local VM stats and events"). See [1] for more detailed
> > history.
> >
> > Kernel versions in between a983b5ebee57 & 815744d75152 (a year and a
> > half) enjoyed cheap reads of non-hierarchical stats, specifically on
> > cgroup v1. When moving to more recent kernels, a performance regression
> > for reading non-hierarchical stats is observed.
> >
> > Now that we have rstat, we know exactly which percpu counters have
> > updates for each stat. We can maintain non-hierarchical counters again,
> > making reads much more efficient, without affecting the performance
> > critical write-side. Hence, add non-hierarchical (i.e local) counters
> > for the stats, and extend rstat flushing to keep those up-to-date.
> >
> > A caveat is that we now need a stats flush before reading
> > local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> > or memcg_events_local(), where we previously only needed a flush to
> > read hierarchical stats. Most contexts reading non-hierarchical stats
> > are already doing a flush, add a flush to the only missing context in
> > count_shadow_nodes().
> >
> > With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> > machine with 256 cpus on cgroup v1:
> >  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
> >  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
> >  real  0m0.125s
> >  user  0m0.005s
> >  sys   0m0.120s
> >
> > After:
> >  real  0m0.032s
> >  user  0m0.005s
> >  sys   0m0.027s
>
> Have you measured any potential regression for cgroup v2 which collects
> all this data without ever using it (AFAICS)?

I did not. I did not expect noticeable regressions given that all the
extra work is done during flushing, which should mostly be done by the
asynchronous worker, but can also happen in the stats reading context.
Let me run the same script on cgroup v2 just in case and report back.

> --
> Michal Hocko
> SUSE Labs
