Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145852FF99
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 23:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiEUVfL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEUVfK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 17:35:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32BB3E5F8
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 14:35:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h9so2352519pgl.4
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 14:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FG27lBVQnY3sW1qr+3lTil/aSlsNAs4hsByJ/IiO+o=;
        b=Q2lvXkm8Au5J0g4yU1+wo2VFEu1ry0wpBSOZ7q+73S3WN4WezFtKZucJH875SDJTi6
         T5CXHETsQ2vlwmEZwXkIkGCnryL/12ZawPU6er9ftMQG9FPc/08GSb9/eZaBPQRBUJbZ
         Y32iam+NDnJ+IiJ3hkEuTBmE7FDIZc56kkBnrjqlsfO7NvJlbWa4NFZguZNgD5FsFh1c
         mSVAiXFqmfidCM7uzGhGxNB/iS+2oy2Rtwvh8qD5LFJoNubN6jZL4wGZhx8GYsuQnvHO
         enKb9QYI2eavJgYcBkkLsdGKB7Ye9LQMK3cGfh3YtLn/VCwihXZY0odav5rkygqfw98E
         1dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FG27lBVQnY3sW1qr+3lTil/aSlsNAs4hsByJ/IiO+o=;
        b=rDPCiurATMApni5Ghvkl6c+hjIRAug6lzUkmAAvDm1WYe/O++cpuVyMXG4ycElvKQW
         oiW5pqB0fJhC53eW0dHLChZwZIYlevAuGsU0qF/FNB438jMigNFxuNWM66jHjowNNvg4
         k0BA9dHV4gejAF/qkHD5wX8KAGcFkjwsrXfY2iAQsc1xX2LBmJFXakPWjhrulIUmS70D
         QFOimdz6jlj2nAXsh+yFUAOTsYp1Hu1Wiwmy5EarISSD7NqlcNIKkRKCu13QJ8LJe3hS
         O86UW5LzwD4m+QHfnEyt1+MOLhgRZclMB4jKbdXZzxd634miNFFo3fX/X8KIwDbO1YHI
         NRvg==
X-Gm-Message-State: AOAM533SJVuw2IHzVnKxXzU+5v23KqG3wsVuZBB3RkyHz1SjDYi5AOLG
        nMcpHpTAX578Wclxay1Oxw11vOp4RDJnyA2KiHkSfw==
X-Google-Smtp-Source: ABdhPJxt/l4bOp8SSCZDM6zebWox/h+cKICoPjL9oOZ/PSoYaM7yyml1UJAzTugs3YIo++viEP+Jmvi/5Kp7BcC1I/E=
X-Received: by 2002:a63:d4c:0:b0:3f5:cc48:9fa3 with SMTP id
 12-20020a630d4c000000b003f5cc489fa3mr10038056pgn.509.1653168908742; Sat, 21
 May 2022 14:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <Yn6aL3cO7VdrmHHp@carbon> <16f17021-61a3-c6f4-f60c-1acd3a0b66b9@openvz.org>
In-Reply-To: <16f17021-61a3-c6f4-f60c-1acd3a0b66b9@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 21 May 2022 14:34:57 -0700
Message-ID: <CALvZod4883iOgYMnHmM4F3NP-KE5c6hrOWDWnvU-hp6rkWX3Tg@mail.gmail.com>
Subject: Re: [PATCH mm v2 5/9] memcg: enable accounting for percpu allocation
 of struct psi_group_cpu
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 21, 2022 at 9:38 AM Vasily Averin <vvs@openvz.org> wrote:
>
> struct pci_group_cpu is percpu allocated for each new cgroup and can
> consume a significant portion of all allocated memory on nodes with
> a large number of CPUs.
>
> Common part of the cgroup creation:
> Allocs  Alloc   $1*$2   Sum     Allocation
> number  size
> --------------------------------------------
> 16  ~   352     5632    5632    KERNFS
> 1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
> 1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
> 1       192     192     10504   (__d_alloc+0x29)
> 2       72      144     10648   (avc_alloc_node+0x27)
> 2       64      128     10776   (percpu_ref_init+0x6a)
> 1       64      64      10840   (memcg_list_lru_alloc+0x21a)
> percpu:
> 1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
> 1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
> 2       12      24      312     call_site=percpu_ref_init+0x23
> 1       6       6       318     call_site=__percpu_counter_init+0x22
>
>  '+' -- to be accounted,
>  '~' -- partially accounted
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
