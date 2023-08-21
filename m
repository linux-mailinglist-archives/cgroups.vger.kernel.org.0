Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06328782BD3
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjHUOah (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjHUOag (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 10:30:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC02FF;
        Mon, 21 Aug 2023 07:30:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF70222C36;
        Mon, 21 Aug 2023 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692628232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55pk6v33OK9OzwCS+RZYme2GhdpxeZdl+Vots/3Gr40=;
        b=NFNkWou9yCKMtM4A+fTSD3pJcYqSXNQY8TuZxWTgaoRkSpFUW609I//QIv5RPncrQuugYP
        aC2zhVzsiaZyfZal4hA0+E6VzWOEbuZQr1pfsrInz2dmgn1akTWs+mDFG8G0y4q92YtzEm
        CvVXAIlgPY5z3Vrc8u4B0kTMm7K9GRY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0DB51330D;
        Mon, 21 Aug 2023 14:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h+VNJAh142ROAQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 21 Aug 2023 14:30:32 +0000
Date:   Mon, 21 Aug 2023 16:30:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mm: memcomtrol: add warning in case of rtpn = NULL
Message-ID: <ZON1B73mUMbAecvO@dhcp22.suse.cz>
References: <20230821142051.31889-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821142051.31889-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 21-08-23 17:20:51, Anastasia Belova wrote:
> kzalloc_node may return NULL. So rtpn should be
> checked before dereference in mem_cgroup_init.

I do not think this is an appropriate fix. If the allocation really
fails (which is essentially impossible as this is an early boot code and
failing 24B req. this early means the system will likely die anyway)
then we will crash on NULL ptr dereference right afterwards so WARN will
not give us anything usefull on top. So either this needs a graceful way
to deal with the allocation failure or considering the previously said
just keep the code alone and teach the tooling that this should be
ignored.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 95a045f63d98 ("mm: memcontrol: consolidate memory controller initialization")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Nacked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..7998dbf3c7cd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7377,6 +7377,7 @@ static int __init mem_cgroup_init(void)
>  		struct mem_cgroup_tree_per_node *rtpn;
>  
>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
> +		WARN_ON(!rtpn);
>  
>  		rtpn->rb_root = RB_ROOT;
>  		rtpn->rb_rightmost = NULL;
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs
