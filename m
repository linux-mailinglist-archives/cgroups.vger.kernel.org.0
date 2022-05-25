Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A265334B5
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 03:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiEYBbU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 21:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiEYBbT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 21:31:19 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE2412AF5;
        Tue, 24 May 2022 18:31:17 -0700 (PDT)
Date:   Tue, 24 May 2022 18:31:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653442275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVjueIe9mhvrA27ww7AR0v74gWv/I98eGtND8IZl3vg=;
        b=VyeEk+zQVrAX1dIxFiZr77PDfHCvUjewxtS5IhtduYYDn5AqfvWy60/KZVUPwogYGH2TRW
        kTsnAIrSGT+1YJBn+jOgwjZRcYRaOargixCYaEvGQsgsk8LkNNJeTEwc4YfWesQ/W18lCL
        +/5ggn+QKpfcJrCA07Vjk4tVSQq3s68=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 6/9] memcg: enable accounting for percpu allocation
 of struct cgroup_rstat_cpu
Message-ID: <Yo2G3mVlu6+/zXtP@carbon>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d01d6e-530c-9be3-1c9b-67a7f8ea09be@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 21, 2022 at 07:38:31PM +0300, Vasily Averin wrote:
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

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

