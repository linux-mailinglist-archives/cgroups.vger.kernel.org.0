Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D560526683
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381380AbiEMPvf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiEMPve (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 11:51:34 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7097F1C194C
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:51:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l19so10759590ljb.7
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=IP/MtSVvzJ/bhLb4+LDG0mt6t+bR404YNxnNxB9WXdQ=;
        b=ZTvGUxx+bqs7G43Y9J4k2N8IGv8khnio1qYn73SlayvQ/r5mHllE/Sy5bWspDy75+V
         0lkyLZxZH6SBi0h1QvAuKgIQwbzRZYg7U2FVccpAuIqUudZREn6QZm9qKhGvKCTbDUf7
         o+LcxzmL6UhIhpU0wy8Z7zr5GGP7jDjXXaWZAng491tXujgLFJlXtI+UKliaXD/7qT3Q
         sUwNYuZYH0uydXxiSLJ877S6Nwbe4nykxICtiszOZjT8cjeNN6gaI7vYHXGYANxUUwjm
         17TK1DSD8svCjMszKVJBHJdLdSf7cOJAJ6drnnILi4L3kYZ2r+XG2CIWf/6Z3njSOQ5Q
         nwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=IP/MtSVvzJ/bhLb4+LDG0mt6t+bR404YNxnNxB9WXdQ=;
        b=zvYBUyunXmRaCF/xL1iQllj1hyql3s69pWUGwLxMDCxwTE7R8fzgn1lMb2tvcCg6bJ
         aXLFcqcXfh0CzL0WG+cGnwh4HVmE9BHdDrxARqdPv5bXlVcUTrszb5DlUZBGGrzd/Qkc
         DtuAMvui06/kA4RHjmLKnOVkpHPkn00WFQ90Vp2h8pWPu5MWHd8FhYnaiS6JjThzgvUC
         oggJnEs12Wq2eso9mEgpKkSO/DvqXhVIOXkihE4x5AYGENME4H54plLtC6xX7qj+4tpH
         NQLSYuHO22qaw3dYrcZJXiOy2k/ZvTVoTADiyaIgTxe2jaNVs/GARj2e+duy5Gxrfgkb
         o8vg==
X-Gm-Message-State: AOAM530faT7Cf31Geet8kT8V/eQcOvCZuiI+cB6H60OW2miJ2Cr6sQ3a
        RljLcAQibsFLJK+E4QNdny/PFGpauRswnA==
X-Google-Smtp-Source: ABdhPJwrvykw6QdUYYMuVpIWH5OvKCp0SSrH1ihEFC1j+7Pas6+1y0I6URHagNnY+VYb4mVCWaYihA==
X-Received: by 2002:a2e:b5d1:0:b0:24f:331d:f9b6 with SMTP id g17-20020a2eb5d1000000b0024f331df9b6mr3416060ljn.302.1652457091718;
        Fri, 13 May 2022 08:51:31 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id g1-20020a19ac01000000b0047255d211f4sm412119lfc.291.2022.05.13.08.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 08:51:31 -0700 (PDT)
Message-ID: <1c14dce9-1981-2690-0e35-58e2d9fbc0da@openvz.org>
Date:   Fri, 13 May 2022 18:51:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 0/4] memcg: accounting for objects allocated by mkdir cgroup
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Ynv7+VG+T2y9rpdk@carbon>
Content-Language: en-US
In-Reply-To: <Ynv7+VG+T2y9rpdk@carbon>
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
However this is enough to clarify the general situation:
- Total sum of accounted memory is ~60Kb.
- Accounted only 2 huge percpu allocation marked '=', ~18Kb.
  (and can be 0 without memory controller)
- kernfs nodes and iattrs are among the main memory consumers.
   they are marked '+' to be accounted.
- cgroup_mkdir always allocates 4Kb,
   so I think it should be accounted first too.
- mem_cgroup_css_alloc allocations consumes 10K,
   it's enough to be accounted, especially for VMs with 1-2 CPUs
- Almost all other allocations are quite small and can be ignored.
  Exceptions are percpu allocations in alloc_fair_sched_group(),
   this can consume a significant amount of memory on nodes
   with multiple processors.
- kernfs nodes consumes ~6Kb memory inside simple_xattr_set() 
   and simple_xattr_alloc(). This is quite high numbers,
   but is not critical, and I think we can ignore it at the moment.
- If all proposed memory will be accounted it gives us ~47Kb, 
   or ~75% of all allocated memory.

number	bytes	$1*$2	sum	note	call_site
of	alloc
allocs
------------------------------------------------------------
1       14448   14448   14448   =       percpu_alloc_percpu:
1       8192    8192    22640   +       (mem_cgroup_css_alloc+0x54)
49      128     6272    28912   +       (__kernfs_new_node+0x4e)
49      96      4704    33616   ?       (simple_xattr_alloc+0x2c)
49      88      4312    37928   +       (__kernfs_iattrs+0x56)
1       4096    4096    42024   +       (cgroup_mkdir+0xc7)
1       3840    3840    45864   =       percpu_alloc_percpu:
4       512     2048    47912   +       (alloc_fair_sched_group+0x166)
4       512     2048    49960   +       (alloc_fair_sched_group+0x139)
1       2048    2048    52008   +       (mem_cgroup_css_alloc+0x109)
49      32      1568    53576   ?       (simple_xattr_set+0x5b)
2       584     1168    54744		(radix_tree_node_alloc.constprop.0+0x8d)
1       1024    1024    55768           (cpuset_css_alloc+0x30)
1       1024    1024    56792           (alloc_shrinker_info+0x79)
1       768     768     57560           percpu_alloc_percpu:
1       640     640     58200           (sched_create_group+0x1c)
33      16      528     58728           (__kernfs_new_node+0x31)
1       512     512     59240           (pids_css_alloc+0x1b)
1       512     512     59752           (blkcg_css_alloc+0x39)
9       48      432     60184           percpu_alloc_percpu:
13      32      416     60600           (__kernfs_new_node+0x31)
1       384     384     60984           percpu_alloc_percpu:
1       256     256     61240           (perf_cgroup_css_alloc+0x1c)
1       192     192     61432           percpu_alloc_percpu:
1       64      64      61496           (mem_cgroup_css_alloc+0x363)
1       32      32      61528           (ioprio_alloc_cpd+0x39)
1       32      32      61560           (ioc_cpd_alloc+0x39)
1       32      32      61592           (blkcg_css_alloc+0x6b)
1       32      32      61624           (alloc_fair_sched_group+0x52)
1       32      32      61656           (alloc_fair_sched_group+0x2e)
3       8       24      61680           (__kernfs_new_node+0x31)
3       8       24      61704           (alloc_cpumask_var_node+0x1b)
1       24      24      61728           percpu_alloc_percpu:

This patch-set enables accounting for required resources.
I would like to discuss the patches with cgroup developers and maintainers,
then I'm going re-send approved patches to subsystem maintainers.

Vasily Averin (4):
  memcg: enable accounting for large allocations in mem_cgroup_css_alloc
  memcg: enable accounting for kernfs nodes and iattrs
  memcg: enable accounting for struct cgroup
  memcg: enable accounting for allocations in alloc_fair_sched_group

 fs/kernfs/mount.c      | 6 ++++--
 kernel/cgroup/cgroup.c | 2 +-
 kernel/sched/fair.c    | 4 ++--
 mm/memcontrol.c        | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.31.1

