Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49DF5334B7
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 03:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiEYBby (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 21:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbiEYBby (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 21:31:54 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62442EC7;
        Tue, 24 May 2022 18:31:52 -0700 (PDT)
Date:   Tue, 24 May 2022 18:31:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653442310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkgpgq0MLg/tjJXAvXd1NI0cnHVkERy6akx7DcAkEY8=;
        b=IckRGymn51W5KSkNLGKDTL/8V3vl12R//mkoxvsoP3gyy98tW7DHo1FA4F0p1ga9sRz5TD
        6FYxnT9//JecprFOB8jLgzbj00ug3+uTTxnUvnTh6E7aRsBziP72fgAqvxAnQoepov4Cae
        Dv4kVvVHCn1BGd7fheY1UI98MFBbRYM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 9/9] memcg: enable accounting for percpu allocation
 of struct rt_rq
Message-ID: <Yo2HAGmySUVABVkt@carbon>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <d7094aa2-1cd0-835c-9fb7-d76003c47dad@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7094aa2-1cd0-835c-9fb7-d76003c47dad@openvz.org>
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

On Sat, May 21, 2022 at 07:39:03PM +0300, Vasily Averin wrote:
> If enabled in config, alloc_rt_sched_group() is called for each new
> cpu cgroup and allocates a huge (~1700 bytes) percpu struct rt_rq.
> This significantly exceeds the size of the percpu allocation in the
> common part of cgroup creation.
> 
> Memory allocated during new cpu cgroup creation
> (with enabled RT_GROUP_SCHED):
> common part:    ~11Kb   +   318 bytes percpu
> cpu cgroup:     ~2.5Kb  + ~2800 bytes percpu
> 
> Accounting for this memory helps to avoid misuse inside memcg-limited
> contianers.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
