Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280FC6ACB9A
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 18:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCFR4Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 12:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCFRzs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 12:55:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE5A65133;
        Mon,  6 Mar 2023 09:55:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 866081FDEB;
        Mon,  6 Mar 2023 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678125312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aqp8n+ynFi9vKD6/elu4xNwffzRLPo64QpS6Aa5j97A=;
        b=TiNZbQ/PxLX68w8zNSn4wPJDgq8upb8V6Tt94jaRKTf0BYZNGSyPXKcFFpJ6QtTbcJdKga
        7SLRqkL+wTzLjA7qEW6sJMYohde4FYtAEzSD0djEAKp1z7kPp9ySONPRSrCmJoZcnB6Baz
        +A2dH+HFDYlEDKHDbuEm7Hmx/a0Xlzg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E2C813513;
        Mon,  6 Mar 2023 17:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7XTzCwApBmQyAgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 06 Mar 2023 17:55:12 +0000
Date:   Mon, 6 Mar 2023 18:55:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yue Zhao <findns94@gmail.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH v2, 4/4] mm, memcg: Prevent memory.soft_limit_in_bytes
 load/store tearing
Message-ID: <ZAYo/ztYBgY0Tx9I@dhcp22.suse.cz>
References: <20230306154138.3775-1-findns94@gmail.com>
 <20230306154138.3775-5-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306154138.3775-5-findns94@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 06-03-23 23:41:38, Yue Zhao wrote:
> The knob for cgroup v1 memory controller: memory.soft_limit_in_bytes
> is not protected by any locking so it can be modified while it is used.
> This is not an actual problem because races are unlikely.
> But it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
> doing anything funky.
> 
> The access of memcg->soft_limit is lockless,
> so it can be concurrently set at the same time as we are
> trying to read it.

Similar here. mem_cgroup_css_reset and mem_cgroup_css_alloc are not
covered.
> 
> Signed-off-by: Yue Zhao <findns94@gmail.com>
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 26605b2f51b1..20566f59bbcb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3728,7 +3728,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	case RES_FAILCNT:
>  		return counter->failcnt;
>  	case RES_SOFT_LIMIT:
> -		return (u64)memcg->soft_limit * PAGE_SIZE;
> +		return (u64)READ_ONCE(memcg->soft_limit) * PAGE_SIZE;
>  	default:
>  		BUG();
>  	}
> @@ -3870,7 +3870,7 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
>  		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  			ret = -EOPNOTSUPP;
>  		} else {
> -			memcg->soft_limit = nr_pages;
> +			WRITE_ONCE(memcg->soft_limit, nr_pages);
>  			ret = 0;
>  		}
>  		break;
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
