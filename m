Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ABC52F44F
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 22:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353440AbiETUQj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 16:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353449AbiETUQh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 16:16:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDDE562D0
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 13:16:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w14so16107580lfl.13
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=aK68T38jy4hw5lYnbpt+b2gdO1PhJXYxj4WBPCGDzes=;
        b=GkkL2GEE74YqAmzKBs+vNQAoc253epe10J4l9b1tbaxP5CiZnPPzwbl4Y2r3E96zOF
         BNl+IICHbkpVHsCvXrQYDr+Nz0O5PLVPx+dBPQ5Vf/ssxiZQ/ee2czGvS/w6k3ZEzcHr
         B5e9MXvf9j+x10Kpf8KZLSBlNkJH+eHVIZdEpvEMXDREHa/gogp9mZleGSAJ/CGmAfJu
         ghAkpNcSbh7vMwNBefK+ZrJy18ONHn4u6+hl2dBS7RTyDAWF/jcheVbLAtbYkS051Ct+
         71Yoa3dez7EAvuOMtZWbbuT009PkDhQmELITAGCSvkVeHxNEgC8G+piHRXhxAebth3TI
         2Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=aK68T38jy4hw5lYnbpt+b2gdO1PhJXYxj4WBPCGDzes=;
        b=GbwKM5HRuXI+q/fLwveHQeC4a+3bskpbJEDwg/rYkI/NDTn2zHs0rH3m3yzP4AitAC
         JgtaahkAG2EvqAZYFPKYgXSgy4A2l0uLFtEQv+DUl2rGdqjTtMwJNfy9IBkhA/zWI4gw
         UfH4B4i7PY1uBKPNe1hBOwPtBQNfYovPfzxD3bQZsM+3rCZe+iOu8/heCE6NYiF8X3hi
         m2RnnB5wfhf08IYu44ufy9akiDE/+JReYjLAiLVTQGc2mAsjMIEIVi2EiTRRAZJLGA4W
         8172wDBPQBiGoikv94qlr9WFqYUVO6W9GMsLNswxNUK9oz/zrNcoIvgdbHVO9QouHXz2
         WGPg==
X-Gm-Message-State: AOAM5321/MAM4e7pDClF51W0g/mvuFfIMLARiIyJKsNzcGEh28SW3StR
        yGZGng74sbIcK//roiOvFLlhQg==
X-Google-Smtp-Source: ABdhPJy7YqrgqIoJhKBa90ToOg/LsZtDwlt3CQQai7o+qxJOulpuL06VAOt5/MI7uQBMmaiPygrtuA==
X-Received: by 2002:a05:6512:e8c:b0:477:9b33:c5f4 with SMTP id bi12-20020a0565120e8c00b004779b33c5f4mr8302101lfb.342.1653077793567;
        Fri, 20 May 2022 13:16:33 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id d7-20020ac25ec7000000b00477cb368b51sm649321lfq.110.2022.05.20.13.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:16:33 -0700 (PDT)
Message-ID: <d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org>
Date:   Fri, 20 May 2022 23:16:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: Re: [PATCH 3/4] memcg: enable accounting for struct cgroup
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Ynv7+VG+T2y9rpdk@carbon>
 <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
 <20220519165325.GA2434@blackbody.suse.cz>
 <740dfcb1-5c5f-6a40-0f71-65f277f976d6@openvz.org>
In-Reply-To: <740dfcb1-5c5f-6a40-0f71-65f277f976d6@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/20/22 10:24, Vasily Averin wrote:
> On 5/19/22 19:53, Michal Koutný wrote:
>> On Fri, May 13, 2022 at 06:52:12PM +0300, Vasily Averin <vvs@openvz.org> wrote:
>>> Creating each new cgroup allocates 4Kb for struct cgroup. This is the
>>> largest memory allocation in this scenario and is epecially important
>>> for small VMs with 1-2 CPUs.
>>
>> What do you mean by this argument?
>>
>> (On bigger irons, the percpu components becomes dominant, e.g. struct
>> cgroup_rstat_cpu.)
> 
> Michal, Shakeel,
> thank you very much for your feedback, it helps me understand how to improve
> the methodology of my accounting analyze.
> I considered the general case and looked for places of maximum memory allocations.
> Now I think it would be better to split all called allocations into:
> - common part, called for any cgroup type (i.e. cgroup_mkdir and cgroup_create),
> - per-cgroup parts,
> and focus on 2 corner cases: for single CPU VMs and for "big irons".
> It helps to clarify which allocations are accounting-important and which ones
> can be safely ignored.
> 
> So right now I'm going to redo the calculations and hope it doesn't take long.

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

Results:
a) I'll add accounting for cgroup_rstat_cpu and psi_group_cpu,
they are called in common part and consumes 288 bytes percpu.
b) It makes sense to add accounting for simple_xattr(), as Michal recommend,
 especially because it can grow over 4kb
c) it looks like the rest of the allocations can be ignored

Details are below
('=' -- already accounted, '+' -- to be accounted, '~' -- see KERNFS, '?' -- perhaps later )

common part:
16  ~   352     5632    5632    KERNFS (*)
1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
1       192     192     10504   (__d_alloc+0x29)
2       72      144     10648   (avc_alloc_node+0x27)
2       64      128     10776   (percpu_ref_init+0x6a)
1       64      64      10840   (memcg_list_lru_alloc+0x21a)

1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
2       12      24      312     call_site=percpu_ref_init+0x23
1       6       6       318     call_site=__percpu_counter_init+0x22

(*) KERNFS includes:
1   +  128      (__kernfs_new_node+0x4d)	kernfs node
1   +   88      (__kernfs_iattrs+0x57)		kernfs iattrs
1   +   96      (simple_xattr_alloc+0x28)	simple_xattr_alloc() that can grow over 4Kb 
1   ?   32      (simple_xattr_set+0x59)
1       8       (__kernfs_new_node+0x30)


memory:
------
1   +   8192    8192    8192    (mem_cgroup_css_alloc+0x4a)
14  ~   352     4928    13120   KERNFS
1   +   2048    2048    15168   (mem_cgroup_css_alloc+0xdd)
1       1024    1024    16192   (alloc_shrinker_info+0x79)
1       584     584     16776   (radix_tree_node_alloc.constprop.0+0x89)
2       64      128     16904   (percpu_ref_init+0x6a)
1       64      64      16968   (mem_cgroup_css_online+0x32)

1   =   3684    3684    3684    call_site=mem_cgroup_css_alloc+0x9e
1   =   984     984     4668    call_site=mem_cgroup_css_alloc+0xfd
2       12      24      4692    call_site=percpu_ref_init+0x23

cpu:
---
5   ~   352     1760    1760    KERNFS
1       640     640     2400    (sched_create_group+0x1b)
1       64      64      2464    (percpu_ref_init+0x6a)
1       32      32      2496    (alloc_fair_sched_group+0x55)
1       32      32      2528    (alloc_fair_sched_group+0x31)

4   +   512     512      512    (alloc_fair_sched_group+0x16c)
4   +   512     512     1024    (alloc_fair_sched_group+0x13e)
1       12      12      1036    call_site=percpu_ref_init+0x23

cpuset:
------
5   ~   352     1760    1760    KERNFS
1       1024    1024    2784    (cpuset_css_alloc+0x2f)
1       64      64      2848    (percpu_ref_init+0x6a)
3       8       24      2872    (alloc_cpumask_var_node+0x1f)

1       12      12      12      call_site=percpu_ref_init+0x23

blkcg:
-----
6   ~   352     2112    2112    KERNFS
1       512     512     2624    (blkcg_css_alloc+0x37)
1       64      64      2688    (percpu_ref_init+0x6a)
1       32      32      2720    (ioprio_alloc_cpd+0x39)
1       32      32      2752    (ioc_cpd_alloc+0x39)
1       32      32      2784    (blkcg_css_alloc+0x66)

1       12      12      12      call_site=percpu_ref_init+0x23

pid:
---
3   ~   352     1056    1056    KERNFS
1       512     512     1568    (pids_css_alloc+0x1b)
1       64      64      1632    (percpu_ref_init+0x6a)

1       12      12      12      call_site=percpu_ref_init+0x23

perf:
----
1       256     256     256     (perf_cgroup_css_alloc+0x1c)
1       64      64      320     (percpu_ref_init+0x6a)

1       48      48      48      call_site=perf_cgroup_css_alloc+0x33
1       12      12      60      call_site=percpu_ref_init+0x23

Thank you,
	Vasily Averin
