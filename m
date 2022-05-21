Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFCF52FE24
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbiEUQhg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiEUQhe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 12:37:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2862DA91
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:37:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a23so12620353ljd.9
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=sDPyJk/btvhatfZsy9I1gg0gfPUmSvuPo0Lq5BQOpLA=;
        b=w0eAuvC1VimJE+5Y6Ul7B8d99Tt3m0U7Mq5SCjFVRP+LIrx1VAIl5jhjm9Y6ws+Nq/
         sa4C6fBJJuf1YCUpoXziOi9FVrgS20OWgmQGZGfuw/AxCksANsD4+FKblvWnSUxHi1Tm
         7YOwJ/JaXsvQt/oPBbQyRlYmMP3MapyUzce8ZV/cUMRkXPGu8IbuLLE4pbV+9jPHbT2C
         VWA+4Ws9XIxlBbstWFv+zSYUwvyPyG1miULKWiWegTq+2bjydr4NlmlTHQml0D4kD04H
         5h9akhPprZnHU2KwQ7iJq7nAqNREMH2dxVsBynUvSg+OPR/jHPuAunz9y5BrtePg2w+c
         Mvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=sDPyJk/btvhatfZsy9I1gg0gfPUmSvuPo0Lq5BQOpLA=;
        b=xdYYobHywsAsRkefDzv3FmEfrTsgHfiTKVjQmjGZnlBybAvQDvki7KrInfwUi5VwwL
         nXTDtaoxbxr+QgcOhcrfcvIalfTxtX3ot29JtodwbzqxXMOyYQYRWxXMV9pzXsWX3uDO
         rN4fU3kp7xHgwx0qC5Lr5+EWcMTv3z6ve230f1IksNYUYtrOfEVgSmyPYxENKs7D6qKJ
         opK0TM3uRJsG0BcDknopNVmAmG7TMuF1ojGWXrCM1zAJKJXdqBoe4bF+TozUFUhnabAj
         m0Omq7dhmJeDeAT8/SRuu1PbzXVYhNSS9NuMfTkYX/WFg3nKyrs9R2oYnIq4zX4T4ykh
         t+eQ==
X-Gm-Message-State: AOAM532tqD8xkuJ8E4h2IZ6mLC8qHixHmF7K1MN2TjAgc8hiED+DkS5V
        VPbkkD018Ah8Hd95PJr9CnOxuhNhewyEOg==
X-Google-Smtp-Source: ABdhPJx9bRomX57NPPN44lZtBUkGEl22UMv4x/n8IeaiMawe0gF84i1pF4KIgrhIyv32BDLaRcXD1g==
X-Received: by 2002:a2e:a585:0:b0:24f:528f:3621 with SMTP id m5-20020a2ea585000000b0024f528f3621mr8568109ljp.416.1653151051132;
        Sat, 21 May 2022 09:37:31 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id v5-20020a056512348500b004744d5f8f26sm1117380lfr.52.2022.05.21.09.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:37:30 -0700 (PDT)
Message-ID: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
Date:   Sat, 21 May 2022 19:37:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2 0/9] memcg: accounting for objects allocated by mkdir
 cgroup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Yn6aL3cO7VdrmHHp@carbon>
Content-Language: en-US
In-Reply-To: <Yn6aL3cO7VdrmHHp@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Below is tracing results of mkdir /sys/fs/cgroup/vvs.test on 
4cpu VM with Fedora and self-complied upstream kernel. The calculations
are not precise, it depends on kernel config options, number of cpus,
enabled controllers, ignores possible page allocations etc.
However this is enough to clarify the general situation.
All allocations are splited into:
- common part, always called for each cgroup type
- per-cgroup allocations

In each group we consider 2 corner cases:
- usual allocations, important for 1-2 CPU nodes/Vms
- percpu allocations, important for 'big irons'

common part: 	~11Kb	+  318 bytes percpu
memcg: 		~17Kb	+ 4692 bytes percpu
cpu:		~2.5Kb	+ 1036 bytes percpu
cpuset:		~3Kb	+   12 bytes percpu
blkcg:		~3Kb	+   12 bytes percpu
pid:		~1.5Kb	+   12 bytes percpu		
perf:		 ~320b	+   60 bytes percpu
-------------------------------------------
total:		~38Kb	+ 6142 bytes percpu
currently accounted:	  4668 bytes percpu

- it's important to account usual allocations called
in common part, because almost all of cgroup-specific allocations
are small. One exception here is memory cgroup, it allocates a few
huge objects that should be accounted.
- Percpu allocation called in common part, in memcg and cpu cgroups
should be accounted, rest ones are small an can be ignored.
- KERNFS objects are allocated both in common part and in most of
cgroups 

Details can be found here:
https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/

I checked other cgroups types was found that they all can be ignored.
Additionally I found allocation of struct rt_rq called in cpu cgroup 
if CONFIG_RT_GROUP_SCHED was enabled, it allocates huge (~1700 bytes)
percpu structure and should be accounted too.

v2:
 1) re-split to simplify possible bisect, re-ordered
 2) added accounting for percpu psi_group_cpu and cgroup_rstat_cpu,
     allocated in common part
 3) added accounting for percpu allocation of struct rt_rq
     (actual if CONFIG_RT_GROUP_SCHED is enabled)
 4) improved patches descriptions 

Vasily Averin (9):
  memcg: enable accounting for struct cgroup
  memcg: enable accounting for kernfs nodes
  memcg: enable accounting for kernfs iattrs
  memcg: enable accounting for struct simple_xattr
  memcg: enable accounting for percpu allocation of struct psi_group_cpu
  memcg: enable accounting for percpu allocation of struct
    cgroup_rstat_cpu
  memcg: enable accounting for large allocations in mem_cgroup_css_alloc
  memcg: enable accounting for allocations in alloc_fair_sched_group
  memcg: enable accounting for percpu allocation of struct rt_rq

 fs/kernfs/mount.c      | 6 ++++--
 fs/xattr.c             | 2 +-
 kernel/cgroup/cgroup.c | 2 +-
 kernel/cgroup/rstat.c  | 3 ++-
 kernel/sched/fair.c    | 4 ++--
 kernel/sched/psi.c     | 3 ++-
 kernel/sched/rt.c      | 2 +-
 mm/memcontrol.c        | 4 ++--
 8 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.36.1

