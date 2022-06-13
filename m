Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6D547F01
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 07:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiFMFfZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 01:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiFMFfG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 01:35:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889112D24
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:34:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so7115142lfa.6
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=RTfZfeDWSN9OZfR7Sv1ydjBOr9B3JdsI1X9ofrvtdxQ=;
        b=bWa4lC6WVgrmLNdVVYMdTBcNm6a37vG8B+DS8jzdCwMcANuwtYv2akgfv285oN78T2
         hGpMT+t/LTTVWpKQnVj0/aM+JgR5Oh5UyiTAKL2+NhTokEU6RX7MOnZ1JqaP6Qqly3Oi
         RWPyrXa0GwAdQQOS9/WV9nnhUOMaVi16RHFGXrIBxHCjBbb2YAkHTmraXFOmXYTEHNA4
         tp7Wbni7gfyRw0y7l/9Wbu+zCozeGy9fQ28Q7pz1XTQbq6w1stc6kRO0Y3maWPmE8ax/
         ftgTMltKXboV+qctvSYXMHSXpAckaHfR4UYMMhnsCOTnwHbekGj/wOzwXhUHZM81/YGW
         l+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=RTfZfeDWSN9OZfR7Sv1ydjBOr9B3JdsI1X9ofrvtdxQ=;
        b=Bz/gy5cw2+p76dnB7hVjh2yWv+ROEgmuCrWk1pF9UkRiK08cxavkSwExyiABdXLDlF
         9qcyyn7B6EeO4YNLFohL+xvKwUqzoMQ0mKGyomypHCTHeFs2nWTQZg9MuJWh0A4W2yo1
         TQbsRIfGz8Bn0ML+25AEO4k7ie77LNGdW5DdIiN9oUMSRn7euy6BG6fuh1kNpf88W25E
         KrdA7upUS+GbhZaaV+noFLC+cjTPAWb5OW/+JAxvg72R/9XvJFPlX0djx/+8tuXWxDuU
         VEUBIBcnaFCtAxbiC66U8FExkHUaZmmUlOiapm/zKmNVXBTMUL2anBHo54FYmdecVcTt
         8koA==
X-Gm-Message-State: AOAM530NxQ+0JbB099oP+beEmJvbhCrUxTWecFA7fbOH7oZiBDwwOt3B
        dwAxNjsFZdIIvnbWEs0yVnZtNg==
X-Google-Smtp-Source: ABdhPJxaTScRvzktio8CGbYDVlIrmnxIimKUk3Ms7a00oEpJtPaXGohF/YVkPrgTtrJu3rtgSJSSQw==
X-Received: by 2002:a19:645c:0:b0:479:10e0:72c2 with SMTP id b28-20020a19645c000000b0047910e072c2mr31921225lfj.237.1655098473738;
        Sun, 12 Jun 2022 22:34:33 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id c22-20020a056512325600b0047255d2110fsm847962lfr.62.2022.06.12.22.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:34:33 -0700 (PDT)
Message-ID: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Date:   Mon, 13 Jun 2022 08:34:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 0/9] memcg: accounting for objects allocated by mkdir
 cgroup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
Content-Language: en-US
In-Reply-To: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
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

In some cases, creating a cgroup allocates a noticeable amount of memory.
This operation can be executed from inside memory-limited container,
but currently this memory is not accounted to memcg and can be misused.
This allow container to exceed the assigned memory limit and avoid
memcg OOM. Moreover, in case of global memory shortage on the host,
the OOM-killer may not find a real memory eater and start killing
random processes on the host.

This is especially important for OpenVZ and LXC used on hosting,
where containers are used by untrusted end users.

Below is tracing results of mkdir /sys/fs/cgroup/vvs.test on 
4cpu VM with Fedora and self-complied upstream kernel. The calculations
are not precise, it depends on kernel config options, number of cpus,
enabled controllers, ignores possible page allocations etc.
However this is enough to clarify the general situation.
All allocations are splitted into:
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

v4:
 1) re-based to linux-next (next-20220610)
   now psi_group is not a part of struct cgroup and is allocated on demand
 2) added received approval from Muchun Song
 3) improved cover letter description according to akpm@ request

v3:
 1) re-based to current upstream (v5.18-11267-gb00ed48bb0a7)
 2) fixed few typos
 3) added received approvals

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
  memcg: enable accounting for perpu allocation of struct rt_rq

 fs/kernfs/mount.c      | 6 ++++--
 fs/xattr.c             | 2 +-
 kernel/cgroup/cgroup.c | 2 +-
 kernel/cgroup/rstat.c  | 3 ++-
 kernel/sched/fair.c    | 4 ++--
 kernel/sched/psi.c     | 5 +++--
 kernel/sched/rt.c      | 2 +-
 mm/memcontrol.c        | 4 ++--
 8 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.36.1

