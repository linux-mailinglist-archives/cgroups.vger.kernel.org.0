Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F95F314E
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJCNce (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJCNcb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 09:32:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1434724
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 06:32:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A00D1F93B;
        Mon,  3 Oct 2022 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664803945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SXYAxH1bjpXJNmDeNrO3jdecyDEt6cOF5K7wMtb61kM=;
        b=AvbdyVLxq5Z+EcCLLFioU+L7qcQqOl6LtbzQtgHMAeZUNT1RktaGG38nHYaoIIgTqMnKxB
        Svp4jswK4lj9pjzH1Xf0AHptLGE5E+UGrB534Y8XlDAUoWJX+X8X84YJiCsjdx7ad4Ylvi
        2ozg5D51XZN1MRCwfFcDUk6sw0JV618=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BBD11332F;
        Mon,  3 Oct 2022 13:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1B7dG2nkOmNzVAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 03 Oct 2022 13:32:25 +0000
Date:   Mon, 3 Oct 2022 15:32:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Fedorov <halcien@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
Message-ID: <YzrkaKZKYqx+c325@dhcp22.suse.cz>
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
 <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
> On 02.10.2022 19:16, Roman Gushchin wrote:
> > On Sat, Oct 01, 2022 at 03:38:43PM +0300, Alexander Fedorov wrote:
> >> Tested READ_ONCE() patch and it works.
> > 
> > Thank you!
> > 
> >> But are rcu primitives an overkill?
> >> For me they are documenting how actually complex is synchronization here.
> > 
> > I agree, however rcu primitives will add unnecessary barriers on hot paths.
> > In this particular case most accesses to stock->cached_objcg are done from
> > a local cpu, so no rcu primitives are needed. So in my opinion using a
> > READ_ONCE() is preferred.
> 
> Understood, then here is patch that besides READ_ONCE() also fixes mentioned
> use-after-free that exists in 5.10.  In mainline the drain_obj_stock() part
> of the patch should be skipped.
> 
> Should probably be also Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> but I am not sure if I have rights to add that :)
> 
> 
>     mm/memcg: fix race in obj_stock_flush_required() vs drain_obj_stock()
>     
>     When obj_stock_flush_required() is called from drain_all_stock() it
>     reads the `memcg_stock->cached_objcg` field twice for another CPU's
>     per-cpu variable, leading to TOCTTOU race: another CPU can
>     simultaneously enter drain_obj_stock() and clear its own instance of
>     `memcg_stock->cached_objcg`.
>     
>     Another problem is in drain_obj_stock() which sets `cached_objcg` to
>     NULL after freeing which might lead to use-after-free.
>     
>     To fix it use READ_ONCE() for TOCTTOU problem and also clear the
>     `cached_objcg` pointer earlier in drain_obj_stock() for use-after-free
>     problem.
> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Alexander Fedorov <halcien@gmail.com>
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c1152f8747..56bd5ea6d3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		stock->nr_bytes = 0;
>  	}
>  
> -	obj_cgroup_put(old);
> +	/*
> +	 * Clear pointer before freeing memory so that
> +	 * drain_all_stock() -> obj_stock_flush_required()
> +	 * does not see a freed pointer.
> +	 */
>  	stock->cached_objcg = NULL;
> +	obj_cgroup_put(old);

Do we need barrier() or something else to ensure there is no reordering?
I am not reallyu sure what kind of barriers are implied by the pcp ref
counting.

-- 
Michal Hocko
SUSE Labs
