Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F752E183
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 03:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbiETBHN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 21:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiETBHM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 21:07:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6491566
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 18:07:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ff40ee8109so57448177b3.14
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 18:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G6gtvqYNjnVwht1zFDxId2+CvU+SMvS0Nm0E4p7o9cM=;
        b=Gq0rw+MrvLWVPrWEBXryZB1jQV/V1G9kqtZ5HVH9URkE6LQh50hBnHJMNqkGngRE1B
         OKQFxrvMTob/C1c6Prc225WuKjE8WCTLx3fHin7rlnzNSeIOtlGLTu74nl6iciYuNa6V
         wKGClUZev9JgvVbePXUNUNBu7Uz1/J49jE9sWsl47yg7HwP0TiOqv882QwVKD+FEXZY5
         VRHfGsaPeQ8uLVWv02vR138ZcXZ+G+eh5CxwWdQnlEieVAYcg1VZgbsIj+VW85zoNOBM
         wo1vIABj/7CfTuXAAnloVwGNjfYF36gl6mrEArXq+HVLQCpFYG1ejzHnmXk3KpUV9HEj
         Th3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G6gtvqYNjnVwht1zFDxId2+CvU+SMvS0Nm0E4p7o9cM=;
        b=VzP0miOBxINBQ7Rv35GMlXpqBv4YMTfNFeLyNV8m8LZKnYNoPDSFXbuznjMbqlqfTG
         KVFqAEdAUY6WLrEU9i6M/7rQskAThmrqT45BaUSoblXmWs4NrpzmzaiYaVdnjADMRBMo
         UuBdZvDk6fAxFWFGBvi7uGvd90g5Ceq3HnsRN47ra0LMcUXl3r37XUcwXeTmgucNIr45
         hVdXn4D2N5WuKkzaVGa8vzUNVheKtYAt5/OHGMsDLTRrqqf836TBwF0+BL3qoXew5eyv
         aYVOvisLQ9dteu1HkxkcTGfjNs6CSao6Pj7Wlc6SAOgNAgkZ64k0fa2GdgLV1lsIn9Ms
         wXAg==
X-Gm-Message-State: AOAM532U8FcRNsPDySr8hm4NQw1tUiP57g2Bu5CfrTEy0pXyvJHgIv32
        EobvZnB4AJ7st5CWSWqHYMNIOhiA3QT09Q==
X-Google-Smtp-Source: ABdhPJyR9Z86DoOKmunyVf1W/6GIyEHZTsm6haOiAELQ00SfT9U7iHEZekEdan2CrSC96iDk6GNAkAcC4XrGfQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:2f16:0:b0:64c:b761:b440 with SMTP id
 v22-20020a252f16000000b0064cb761b440mr7560583ybv.359.1653008830081; Thu, 19
 May 2022 18:07:10 -0700 (PDT)
Date:   Fri, 20 May 2022 01:07:07 +0000
In-Reply-To: <212f1b74-7d4e-29f2-9e92-2a1820beff61@openvz.org>
Message-Id: <20220520010707.77z5blxpbsddwmyo@google.com>
Mime-Version: 1.0
References: <Ynv7+VG+T2y9rpdk@carbon> <212f1b74-7d4e-29f2-9e92-2a1820beff61@openvz.org>
Subject: Re: [PATCH 1/4] memcg: enable accounting for large allocations in mem_cgroup_css_alloc
From:   Shakeel Butt <shakeelb@google.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 06:51:41PM +0300, Vasily Averin wrote:
> cgroup mkdir can be misused inside memcg limited container. It can allocate
> a lot of host memory without memcg accounting, cause global memory shortage
> and force OOM to kill random host process.
> 
> Below [1] is result of mkdir /sys/fs/cgroup/test tracing on VM with 4 cpus
> 
> number	bytes	$1*$2	sum	note	call_site
> of	alloc
> allocs
> ------------------------------------------------------------
> 1       14448   14448   14448   =       percpu_alloc_percpu:
> 1       8192    8192    22640           (mem_cgroup_css_alloc+0x54)
> 49      128     6272    28912           (__kernfs_new_node+0x4e)
> 49      96      4704    33616           (simple_xattr_alloc+0x2c)
> 49      88      4312    37928           (__kernfs_iattrs+0x56)
> 1       4096    4096    42024           (cgroup_mkdir+0xc7)
> 1       3840    3840    45864   =       percpu_alloc_percpu:
> 4       512     2048    47912           (alloc_fair_sched_group+0x166)
> 4       512     2048    49960           (alloc_fair_sched_group+0x139)
> 1       2048    2048    52008           (mem_cgroup_css_alloc+0x109)
> 	[smaller objects skipped]
> ---
> Total			61728
> 
> '=' --  accounted allocations
> 
> This patch enabled accounting for one of the main memory hogs in this
> experiment: allocation which are called inside mem_cgroup_css_alloc()
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Link: [1] https://lore.kernel.org/all/1aa4cd22-fcb6-0e8d-a1c6-23661d618864@openvz.org/
> 

Acked-by: Shakeel Butt <shakeelb@google.com>
