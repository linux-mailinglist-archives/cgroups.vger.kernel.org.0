Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBB53412C
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiEYQPK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbiEYQO7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 12:14:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82AB8BE0;
        Wed, 25 May 2022 09:14:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B29D51F45B;
        Wed, 25 May 2022 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653495296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nveNkbQd0lCAXKeId3LcmC7N6UTtx563GjLwBF9X3SM=;
        b=IqhqwHV+le8KctKpt3p8cJ+ogCgAU4pKENhjX5Pv9JiWbXpf195OZuQCuuaL/71y7/p9qq
        Kf09Y01qolu5EvvwJFMPsy/pMLgibwaAAOagge4fmclEhR8S3HlHpHh4ddog+TuFDht1mY
        n4qnfke5MirTxUxXRHLUwQFkJ39v7Ds=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DF7513487;
        Wed, 25 May 2022 16:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id minBHQBWjmL8IAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 25 May 2022 16:14:56 +0000
Date:   Wed, 25 May 2022 18:14:55 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <20220525161455.GA16134@blackbody.suse.cz>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525151517.8430-3-mkoutny@suse.com>
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

On Wed, May 25, 2022 at 05:15:17PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> // ref=1: only base reference
> kill_css()
>   css_get() // fuse, ref+=1 == 2
>   percpu_ref_kill_and_confirm
>     // ref -= 1 == 1: kill base references
>   [via rcu]
>   css_killed_ref_fn == refcnt.confirm_switch
>     queue_work(css->destroy_work)               (1)
>     [via css->destroy_work]
>     css_killed_work_fn == wq.func
>       offline_css() // needs fuse
>       css_put // ref -= 1 == 0: de-fuse, was last
>         ...
>         percpu_ref_put_many
>            css_release
>              queue_work(css->destroy_work)      (2)
>              [via css->destroy_work]
>              css_release_work_fn == wq.func

Apologies, this is wrong explanation. (I thought this explains why
Tadeusz's patch with double get/put didn't fix it (i.e. any number
wouldn't help with the explanation above).)

But the above is not correct. I've looked at the stack trace [1] and the
offending percpu_ref_put_many is called from an RCU callback
percpu_ref_switch_to_atomic_rcu(), so I can't actually see why it drops
to zero there...

Regards,
Michal
