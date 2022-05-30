Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4653854E
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbiE3Psm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbiE3Ps2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 11:48:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68D168D1F
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 08:04:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s68so10346254pgs.10
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQ1N4ofCE0FRNNVNz7Ejwc9uv4RLnDojLdDFtHXcOM0=;
        b=UOHCjQRYQOJ0d8oQ+coX3IGMta5po6IRFVkKXGGERa09qLlnww35pEhAE8RFYrvNEh
         g7dl3TBpN01zrH5w5Zvj/2osjLNrGYpnrF9cEuKJeUXwkLw/zFQKawreydVtAfmquOS7
         pEQ9G6R2UHElwNduZlhMaxByqfcylwAddIOiNAmxaZUSJdz731a33yBDZaNPZGCG95NC
         BEyraIJD/cZIDOFfNMSocvxckFWaPV2m0vem4wSHCyuSyKvVoshHU98nZTlvuOrRBj0/
         uVu9qLUcJ/D8TMv/L6Pssqa/NsNKCjJOaM0Nj3hQ1oM47X9rz7ZFyURx+hREhnYIxMZl
         TQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQ1N4ofCE0FRNNVNz7Ejwc9uv4RLnDojLdDFtHXcOM0=;
        b=BqzEgbkZ3BSkLlHfuG6v0oCLkzU3mjXJlro3ndhIS7iDDpeAaj4x2iGXuj2wCLUlC+
         D+BIGYOf/auik6CnpV6UX0HKu1tBjy7jfxl1JhruE3cNlLj74LD8O95o2yPLnxB+0zD2
         OdPUfWDB6mMz7Inc0XY5xs0YekPrWjq0g1T1iw+pTSrOTQtRTaOPu3YatKf9xGX8330W
         SH88FNwmOdeWMKsa0Of3NpfzW3FGRIECA2cUeiQGM3uafUiUPnD872cmGgwUa8aIEiQw
         3eNK4ZPBjqSnHsBix6DibG4oK753MIbjOZ7rke2RjkKj3Zz0cXV0cc0TfDWeu0zywyfp
         Ppyg==
X-Gm-Message-State: AOAM530e7dCh/4QnsyJMU2CuMeTo7bwvZygBegSHnU5xyIjaK5etxxb0
        ztMShH1wzk0WEgMelsF5EWbDqA==
X-Google-Smtp-Source: ABdhPJx8IDuNFYLfdmyWIjTqL/G5fyCSXwYWny/jWfJoXNed1Z33IwfQHJWhlx+y7KmjBv/Hrqwi+Q==
X-Received: by 2002:a62:e819:0:b0:518:6a98:b02 with SMTP id c25-20020a62e819000000b005186a980b02mr50782621pfi.74.1653923068523;
        Mon, 30 May 2022 08:04:28 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id p6-20020a62ab06000000b0051843980605sm8908344pff.181.2022.05.30.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 08:04:28 -0700 (PDT)
Date:   Mon, 30 May 2022 23:04:21 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v3 6/9] memcg: enable accounting for percpu allocation
 of struct cgroup_rstat_cpu
Message-ID: <YpTc9Xww7Y09HkD8@FVFYT0MHHV2J.googleapis.com>
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <cover.1653899364.git.vvs@openvz.org>
 <2fbede88-6ef7-4ce7-b3a3-ec349bc2cc06@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fbede88-6ef7-4ce7-b3a3-ec349bc2cc06@openvz.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 02:26:36PM +0300, Vasily Averin wrote:
> struct cgroup_rstat_cpu is percpu allocated for each new cgroup and
> can consume a significant portion of all allocated memory on nodes
> with a large number of CPUs.
> 
> Common part of the cgroup creation:
> Allocs  Alloc   $1*$2   Sum	Allocation
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

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
