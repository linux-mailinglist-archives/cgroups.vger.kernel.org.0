Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63DC5379C4
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiE3LZw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiE3LZu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 07:25:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EC97DE08
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:25:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br17so16290623lfb.2
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=IK1h75QrK4dLAeCcHF6vHO4eDXNyXwLtZQJf9O+8m78=;
        b=XPNvq5NbB2kQePetWgiJpCVF9J44XxrjS/Fy/stHVxJC8lmeUymcBCUm67p4d1i4cZ
         qnXlnY6v2ktg2Yxt9sZ7Qb5LQooZmoGKsQkH4KxqykKI/mPw6t3xpTHDkwkG0hWfB4mS
         6P7rjpWQ/xXC3Uj/qVEsuI/XpPeotY6Mon2SrfSTES1WWK2jh5LcRYYuBCaW3sA28sqB
         /7wJCIyZKMIn86gR9iZ0rN0ZrA2wz5667OJEMKgDBsFCR5bK6mo5YOtmADsqmMBbeoZ0
         X9zJe7NDh4yO3uILPz/BLIkNy0JCVPgedXFPhYxZ51dXuoXgH1/QHI+8g9nl2zeyeQco
         88hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=IK1h75QrK4dLAeCcHF6vHO4eDXNyXwLtZQJf9O+8m78=;
        b=l113s5nhvyxm47xbAsdw7qEApyGL34yLZ1OfTDO7XWL5/e/2eenE1lOrpr64WKibxK
         ypCFSD2DqDiQvppB4Er46ECZH19haKW4yZjJlflJ5rAO+Pjs8D8UZB7C8RYkWinFd0Fc
         gOpq72pV1q5479DZKX6ux3HY06XA6B5tjTaerNIIwTrP5DWViVE3g0/CnX4xA3n/rMB6
         5PYqYBal5qabbxlyrUGs9gXKSJ0qqrCRQOilv9U3P4Ne124DAPtyFMY2iVVwik7WRNuj
         MjTZvpPY+evMivMtNBveCQ1TKvkCREcvXFGyKNMC4LN6rBp33zj4xM0GcCf5BMYsD2zC
         Kq3Q==
X-Gm-Message-State: AOAM532Acx7rGfC5YlMqGbMG9R0xondQyZJpaaGQeMvoeJfv5cGq6fNO
        UkCKQvMTT7wxrQRHpqv6U1+w0Q==
X-Google-Smtp-Source: ABdhPJwzelp6MGsEyWHyl4Z2g5aIy6KrZEDZy0z+0yaQvfyUvpeFNqJr0TUTIBw8RZ8X8rhaKsnU6Q==
X-Received: by 2002:a05:6512:3092:b0:478:786f:9fc0 with SMTP id z18-20020a056512309200b00478786f9fc0mr25734944lfd.562.1653909947060;
        Mon, 30 May 2022 04:25:47 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id y26-20020a05651c107a00b00253bb2564cbsm1404094ljm.134.2022.05.30.04.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:25:46 -0700 (PDT)
Message-ID: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
Date:   Mon, 30 May 2022 14:25:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 0/9] memcg: accounting for objects allocated by mkdir
 cgroup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
Content-Language: en-US
In-Reply-To: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
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
 kernel/sched/psi.c     | 3 ++-
 kernel/sched/rt.c      | 2 +-
 mm/memcontrol.c        | 4 ++--
 8 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.36.1

