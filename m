Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6D52DA4C
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 18:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiESQdE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiESQdD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 12:33:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C140B68304;
        Thu, 19 May 2022 09:33:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E38221B6C;
        Thu, 19 May 2022 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652977981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9osOjg5SEQf5DXLZedr3XVR8VPlIeZRjkYt869VHRU=;
        b=TmLYAlgy/fHvdR4/9jW2UdK+5qB/knaCOzFSFXm4Nre8kfaIVOlKZrhDHEYiPK7XUFYO9N
        r2YMBlzhiFpYyOvDKK5ZrTv3+Nr4QQ21SMrv95F7Cqxb7YTWtsZoASUVfhRsAKdZFE7k2A
        iACnDNmbm/SUQTUMMkllqn+uMvoR3nE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5126C13456;
        Thu, 19 May 2022 16:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8O7YEj1xhmLdfwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 19 May 2022 16:33:01 +0000
Date:   Thu, 19 May 2022 18:33:00 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/4] memcg: enable accounting for kernfs nodes and iattrs
Message-ID: <20220519163300.GH16096@blackbody.suse.cz>
References: <Ynv7+VG+T2y9rpdk@carbon>
 <22ccf325-6aa5-9b55-4729-d03f34125650@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ccf325-6aa5-9b55-4729-d03f34125650@openvz.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 06:51:55PM +0300, Vasily Averin <vvs@openvz.org> wrote:
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index cfa79715fc1a..40e896c7c86b 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -391,10 +391,12 @@ void __init kernfs_init(void)
>  {
>  	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
>  					      sizeof(struct kernfs_node),
> -					      0, SLAB_PANIC, NULL);
> +					      0, SLAB_PANIC | SLAB_ACCOUNT,
> +					      NULL);
>  
>  	/* Creates slab cache for kernfs inode attributes */
>  	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
>  					      sizeof(struct kernfs_iattrs),
> -					      0, SLAB_PANIC, NULL);
> +					      0, SLAB_PANIC | SLAB_ACCOUNT,
> +					      NULL);

IIUC your stats report, struct kernfs_iattrs is mere 88B (per
kernfs_node), when considering attributes, I actually thought of
something like:

--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -950,7 +950,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
        if (len < sizeof(*new_xattr))
                return NULL;

-       new_xattr = kvmalloc(len, GFP_KERNEL);
+       new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
        if (!new_xattr)
                return NULL;

Again, I'd split the patch into two: kernfs_node and
kernfs_iattrs+simple_xattr for easier bisecting.

Thanks,
Michal
