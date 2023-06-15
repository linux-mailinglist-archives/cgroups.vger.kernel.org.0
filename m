Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1273121D
	for <lists+cgroups@lfdr.de>; Thu, 15 Jun 2023 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbjFOI0Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jun 2023 04:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjFOI0Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jun 2023 04:26:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDE1A3;
        Thu, 15 Jun 2023 01:26:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8080D223EB;
        Thu, 15 Jun 2023 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686817582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kF+hByK4Y76JqlJkiSCw3idVqJKv+Bhlb9OYXECSA6o=;
        b=Oi4Rr4D7LwzZKXtZXhTOqPefALupc8O9w/CwxHH5AgGPnY3ErZvy9xW+Ziw24qxE8SdmYh
        FXRzzAYYdOOuSL3vasWHumh5F/H9BINWWmQKBiaMYzbqAxtmLNhgW2CVeBAFivdKknMnRb
        UnCzHpZFD3YrqLYxeUYH3gDniCrGbJg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74A8413467;
        Thu, 15 Jun 2023 08:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Fb0Gy7LimT7LwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 15 Jun 2023 08:26:22 +0000
Date:   Thu, 15 Jun 2023 10:26:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/memcontrol: add check for allocation failure in
 mem_cgroup_init()
Message-ID: <ZIrLLmb+o77Wy2sY@dhcp22.suse.cz>
References: <20230615073226.1343-2-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615073226.1343-2-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 15-06-23 07:32:26, Haifeng Xu wrote:
> If mem_cgroup_init() fails to allocate mem_cgroup_tree_per_node, we
> should not try to initilaize it. Add check for this case to avoid
> potential NULL pointer dereference.

Technically yes and it seems that all users of soft_limit_tree.rb_tree_per_node
correctly check for NULL so this would be graceful failure handling. At
least superficially because the feature itself would be semi-broken when
used. But more practically this is a 24B allocation and if we fail to
allocate that early during the boot we are screwed anyway. Would such
a system have any chance to boot all the way to userspace? Woul any
userspace actually work?

Is this patch motivated by a code reading or is there any actual
practical upside of handling the error here?
 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c73c5fb33f65..7ebf64e48b25 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7422,6 +7422,8 @@ static int __init mem_cgroup_init(void)
>  		struct mem_cgroup_tree_per_node *rtpn;
>  
>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
> +		if (!rtpn)
> +			continue;
>  
>  		rtpn->rb_root = RB_ROOT;
>  		rtpn->rb_rightmost = NULL;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
