Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2005F31F0
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJCO1H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJCO1G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 10:27:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D652807
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 07:27:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54A0E1F943;
        Mon,  3 Oct 2022 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664807221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLlkpgbxGZRMNBxuPIGalwtLBIi7tqsIbhglT3gkCtE=;
        b=ZaYAqscq9DPqSdfPYl7g0L7ZKm7z8h31kFJ9l89bcayffbVyeEqX/uXywgl2u7P8wyGleU
        mYDUrIrM26hJ63fFc0/NF9Cbj2lk1J4MtvjxAvdtWDg/GwD1BadGV4D6xpGzlFyy5RM6qS
        hn/LjFfv5NyNd0Tvc2nBDbpT+D7krOw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 352FC13522;
        Mon,  3 Oct 2022 14:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DiioCjXxOmMMaAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 03 Oct 2022 14:27:01 +0000
Date:   Mon, 3 Oct 2022 16:27:00 +0200
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
Message-ID: <YzrxNGpf7sSwSWy2@dhcp22.suse.cz>
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
 <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
 <YzrkaKZKYqx+c325@dhcp22.suse.cz>
 <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 03-10-22 17:09:15, Alexander Fedorov wrote:
> On 03.10.2022 16:32, Michal Hocko wrote:
> > On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
> >> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> >>  		stock->nr_bytes = 0;
> >>  	}
> >>  
> >> -	obj_cgroup_put(old);
> >> +	/*
> >> +	 * Clear pointer before freeing memory so that
> >> +	 * drain_all_stock() -> obj_stock_flush_required()
> >> +	 * does not see a freed pointer.
> >> +	 */
> >>  	stock->cached_objcg = NULL;
> >> +	obj_cgroup_put(old);
> > 
> > Do we need barrier() or something else to ensure there is no reordering?
> > I am not reallyu sure what kind of barriers are implied by the pcp ref
> > counting.
> 
> obj_cgroup_put() -> kfree_rcu() -> synchronize_rcu() should take care
> of this:

This is a very subtle guarantee. Also it would only apply if this is the
last reference, right? Is there any reason to not use
	WRITE_ONCE(stock->cached_objcg, NULL);
	obj_cgroup_put(old);

IIRC this should prevent any reordering. 
-- 
Michal Hocko
SUSE Labs
