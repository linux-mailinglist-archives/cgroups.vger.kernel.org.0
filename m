Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5655AE14
	for <lists+cgroups@lfdr.de>; Sun, 26 Jun 2022 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiFZB4O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jun 2022 21:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiFZB4N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jun 2022 21:56:13 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F913CF6;
        Sat, 25 Jun 2022 18:56:12 -0700 (PDT)
Date:   Sat, 25 Jun 2022 18:56:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656208570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjZI8DTIvucVtX5WQZE5x3xoKYG/ekTnBVDG7567Nww=;
        b=vBWYqIw/oxs4LrYOucwfyC44hX5VSaebHW971hVyDMn4SEhSuSadnHtg1E+KN4TGyCzs+z
        F3S9YtDszUv1h9nslGbXgumAJzW5MRY9w5oYa8exaPjre30t7l24VyPOJ07n3IC4FsnYVH
        qgisoDutY8/3V8XvFjIsNgz7E4Ru4eU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH RFC] memcg: notify about global mem_cgroup_id space
 depletion
Message-ID: <Yre8tNUY8vBrO0yl@castle>
References: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
 <c53e1df0-5174-66de-23cc-18797f0b512d@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53e1df0-5174-66de-23cc-18797f0b512d@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 25, 2022 at 05:04:27PM +0300, Vasily Averin wrote:
> Currently host owner is not informed about the exhaustion of the
> global mem_cgroup_id space. When this happens, systemd cannot
> start a new service, but nothing points to the real cause of
> this failure.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d4c606a06bcd..5229321636f2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5317,6 +5317,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
>  	if (memcg->id.id < 0) {
>  		error = memcg->id.id;
> +		pr_notice_ratelimited("mem_cgroup_id space is exhausted\n");
>  		goto fail;
>  	}

Hm, in this case it should return -ENOSPC and it's a very unique return code.
If it's not returned from the mkdir() call, we should fix this.
Otherwise it's up to systemd to handle it properly.

I'm not opposing for adding a warning, but parsing dmesg is not how
the error handling should be done.

Thanks!
