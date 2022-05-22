Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB1530151
	for <lists+cgroups@lfdr.de>; Sun, 22 May 2022 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiEVGlL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 May 2022 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiEVGk4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 May 2022 02:40:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00882200
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:40:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so14812597pjp.3
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7RyeoE0RrByaysSlJBBX9kNbKUMbMSMjbmqSWxbdhE=;
        b=ydM+bNsTqjmSr8ProqeQ1dnTvVbgtRESYlEoGN63xQ08p6qUZBZ8ARuda6R7tenlb5
         PItaErd/oEcrAc1DCgdWI7LH6ZRtMNz/DoGGOCh84+YU5Q7i0ntBxSmWbmqGvHiQo/FN
         h55AoRHBS45cyBSEijmVnKUoUcL4U5C/Dj79OcFUeKx342ypQzsb5Tu085LObSQiPcCA
         5Mr9w1rlChRajAO3QRBd2B9T1KsrlmOccEpXvsNKkp2teVj8X4ySDFtSNVCLj0Ws60ln
         uUlySVvdc4029NfszkZDVLIsUDDTNP7cZ4HBLJqKBMy1o5ZV3WDwHf6TyTCZBMYi34UX
         phbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K7RyeoE0RrByaysSlJBBX9kNbKUMbMSMjbmqSWxbdhE=;
        b=c1+pQrO21m8tL67n6wGUzoAwWBRbQ0v+QFFMsSIcd1G4F/BKhJVy/He8o2/aHFqV2l
         L13Rh8cka6/aqg7m44TYJTGpQhrAJdtZTVloDsgwQfzERqNaPm00vA1X2U05GSNebL71
         qrSb7gg5kc53N/+wQVkgCGcrgvIWIo1EKMQ/Z/sUNeQL2Z8nXom5JOdf2NwsyGLNeEb3
         HqUQQzHX5QSbN/aXWyVRXcR8o3EnkIcSHkOSx8o/0vwMdVrL7YxifUvQfXIGogQTUxKj
         4Gv99l4bNNBXCwkwHLaUrOk3hyno8aGoIahp4U++Ya+dWZLJVopH6fMnGI6zZ0AUgjAF
         +Bag==
X-Gm-Message-State: AOAM532ToFXpQwIjtFZgYqp845ddcTN/6YCcC06TVvaHDJGhz9ijr8Ix
        9sqgRPu1q86HCNZ3KGA5tfDCyg==
X-Google-Smtp-Source: ABdhPJwpUpul6dsTRuSMnoO0EikK7PbWaHeM6hv3oViYFnAUKrnMhYkAz5coN0WOxWiKMdvLGvDu2Q==
X-Received: by 2002:a17:90a:c303:b0:1df:1ab6:68fb with SMTP id g3-20020a17090ac30300b001df1ab668fbmr19674804pjt.181.1653201652510;
        Sat, 21 May 2022 23:40:52 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a0000d200b0050dc76281ecsm4633827pfj.198.2022.05.21.23.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:40:52 -0700 (PDT)
Date:   Sun, 22 May 2022 14:40:49 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 5/9] memcg: enable accounting for percpu allocation
 of struct psi_group_cpu
Message-ID: <Yona8fgW1bdhq2wL@FVFYT0MHHV2J.usts.net>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <16f17021-61a3-c6f4-f60c-1acd3a0b66b9@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f17021-61a3-c6f4-f60c-1acd3a0b66b9@openvz.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 21, 2022 at 07:38:21PM +0300, Vasily Averin wrote:
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

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

