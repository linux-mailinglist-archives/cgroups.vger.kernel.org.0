Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445ED7311DC
	for <lists+cgroups@lfdr.de>; Thu, 15 Jun 2023 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjFOIPB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jun 2023 04:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjFOIOm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jun 2023 04:14:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7801BD4;
        Thu, 15 Jun 2023 01:14:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5697A1FDDA;
        Thu, 15 Jun 2023 08:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686816880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7K1dHo3suajr80VD6qXH9vvOWaAMLy7kkTVGXspF0U=;
        b=NqJM711WfcvRab2CCaoqcmrc5nGT/TblaFgad0EStN8zcLon2DOpDqyckZfG0d1tMo9TYO
        njZ+Dt7dQ6Vq0Buvu34Dj+dF0oXQ+hHimcR/YKbjQMAexlPM/zyPJ2g0Pwlw9fMTyzXqLD
        YLlR1w9ba2JUdWw9auY99dxXXZMSTDk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46BBF13A47;
        Thu, 15 Jun 2023 08:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zuOQEHDIimQnKAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 15 Jun 2023 08:14:40 +0000
Date:   Thu, 15 Jun 2023 10:14:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memcontrol: do not tweak node in mem_cgroup_init()
Message-ID: <ZIrIb7pgRXln27nv@dhcp22.suse.cz>
References: <20230615073226.1343-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615073226.1343-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 15-06-23 07:32:25, Haifeng Xu wrote:
> mem_cgroup_init() request for allocations from each possible node, and
> it's used to be a problem because NODE_DATA is not allocated for offline
> node. Things have already changed since commit 09f49dca570a9 ("mm: handle
> uninitialized numa nodes gracefully"), so it's unnecessary to check for
> !node_online nodes here.

How have you tested this patch?

I am not saying it is wrong and it looks like the right thing to do. But
the early init code has proven to be more subtle than expected so it is
definitely good to know that this has been tested on memory less setup
and passed.

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/memcontrol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b27e245a055..c73c5fb33f65 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7421,8 +7421,7 @@ static int __init mem_cgroup_init(void)
>  	for_each_node(node) {
>  		struct mem_cgroup_tree_per_node *rtpn;
>  
> -		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
> -				    node_online(node) ? node : NUMA_NO_NODE);
> +		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
>  
>  		rtpn->rb_root = RB_ROOT;
>  		rtpn->rb_rightmost = NULL;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
