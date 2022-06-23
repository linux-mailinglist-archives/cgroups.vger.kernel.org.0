Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE9557E30
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiFWOuq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFWOup (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:50:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623446679
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:50:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t24so21555203lfr.4
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=1bcYs/tPp9DPi/Wqk7L+riaRA+D466h+ZJY4pfI0O2g=;
        b=2nVn4C1yCEydX2fk5EcrBIpk/CFe9RFSZALX8zPrL8etewPDITPil7xcCntvZB6Fay
         4zuaF9OVJOb8XEZmGQ1AZnzIrVQbR5weeT2K8jCyk8Uv4UysqcWsURbgqc2IqPni0YoM
         qqdAQo5VH8ThIirYGZTjVUKR2Le7kvoAwMNsewNWCjWTtpGMJEgMdrh5JIBpsB/YqJnG
         zttFzE0lgyM/J0O6GKeoTA7sXcWcCcBADmcMO2nyOpFCFOPOonnxG3zBV9GwSV/qwNO+
         g11zvxGlf7osZ3ONy1Ws9tsJLBwTTCv/+Pweo6JUzGspIvt8VX4SCpE75HrTIM+skuEr
         iofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=1bcYs/tPp9DPi/Wqk7L+riaRA+D466h+ZJY4pfI0O2g=;
        b=7IXd2ZGY/mLXsqrBJMpjmkxY0oEhnoMuHWmSdq8PVN4NPsiQAagrlz5A9x8GBtIW+W
         vPvmec0BGoGiZCt+q9ReNnW9pgIACWTw1/heSliAzfxoCJigNj7E0SJCKlGM4XtqErZJ
         ark/A5Q8D3ViyJGF7V6OhCmFnyo6UZmFxs7urzNT2LHafh/99ZtbAbTFREO3Qr9UgwIO
         0IdfBSqeSdD4kwHXXjKvkXMLz0er0NIQhMJCN9BhNU66wXNeyYxA3Gb2o3CgL2m1MsZa
         dz+KmD95jjRZsziLM1TK+OnUGkYFo86kFy54UxLqQqeTjUZLOsrwneH8Ww21S7Abh97H
         QcTQ==
X-Gm-Message-State: AJIora/CKbh1Zan+h11vwoGzuULCYdSad8yZ+GRL5BOaDYkbiK7Rv5/3
        hiRLh4UPCN/YGEIgOzd7WDdw6g==
X-Google-Smtp-Source: AGRyM1vrz8cgtEnvLDZrtm9xg+8BYIcCZwc6rUBAu40Yw4vy7D36HuI0qYdj/5xvJFCwwwbPdiJjWg==
X-Received: by 2002:a05:6512:688:b0:47f:5f74:de81 with SMTP id t8-20020a056512068800b0047f5f74de81mr5708499lfe.477.1655995842563;
        Thu, 23 Jun 2022 07:50:42 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id e18-20020ac25cb2000000b0047f8790085csm1017767lfq.71.2022.06.23.07.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:50:42 -0700 (PDT)
Message-ID: <0fe836b4-5c0f-0e32-d511-db816d359748@openvz.org>
Date:   Thu, 23 Jun 2022 17:50:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 0/9] memcg: accounting for objects allocated by mkdir,
 cgroup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Language: en-US
In-Reply-To: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
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

v5:
 1) re-based to linux-mm (mm-everything-2022-06-22-20-36)

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
 kernel/sched/psi.c     | 2 +-
 kernel/sched/rt.c      | 2 +-
 mm/memcontrol.c        | 4 ++--
 8 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.36.1

