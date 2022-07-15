Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D97576104
	for <lists+cgroups@lfdr.de>; Fri, 15 Jul 2022 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiGOL7m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jul 2022 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiGOL7m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jul 2022 07:59:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF5D2E69F;
        Fri, 15 Jul 2022 04:59:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDACF1FD85;
        Fri, 15 Jul 2022 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657886379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RmIBDmA7HuVmZSyUWJ93x5lRlH/NRx1RsQwV9uMu1M=;
        b=AqIscoSlqIjk/nPYNDWwjjd9fWwuEi5DU9TQYGiCa2z4jdMdkfWhltCvjGsN96UZJW0NAs
        6L+wRg97LtJ2t5o+ij77C/gmHsm/RNCv6KvgTwiT1a08v/liV6xg053aQ9bRMAY8GzRHK8
        vQqWrDGD6pEi5J/g/siParyxrugja7U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 792A913754;
        Fri, 15 Jul 2022 11:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lTDPHKtW0WKsAgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 15 Jul 2022 11:59:39 +0000
Date:   Fri, 15 Jul 2022 13:59:38 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Shakeel Butt <shakeelb@google.com>, wsd_upstream@mediatek.com,
        lixiong.liu@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com
Subject: Re: [Bug] race condition at rebind_subsystems()
Message-ID: <20220715115938.GA8646@blackbody.suse.cz>
References: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Jing-Ting.

On Thu, Jun 30, 2022 at 06:52:10PM +0800, Jing-Ting Wu <jing-ting.wu@mediatek.com> wrote:
> Root cause:
> The rebind_subsystems() is no lock held when move css object from A
> list to B list,then let B's head be treated as css node at
> list_for_each_entry_rcu().

Nice outcome of the analysis.

> The call stack as following:
> kthread
> -> worker_thread
> -> process_one_work
> -> flush_memcg_stats_dwork
> -> __mem_cgroup_flush_stats
> -> cgroup_rstat_flush_irqsafe
> -> cgroup_rstat_flush_locked
> 
> Detail:
> static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool
> may_sleep)
> {
> ...
>    rcu_read_lock();
>    list_for_each_entry_rcu(css, &pos->rstat_css_list,
>                              rstat_css_node)
>         css->ss->css_rstat_flush(css, cpu);
>    rcu_read_unlock();
> ...
> }
> 
> Because the content of css->ss is not a function address,
> once the css_rstat_flush is called, kernel exception will happen.

I agree with your analysis. The list_for_each_entry_rcu() is not
accounting for the move from A to B and the head's rstat_css_list is
invalid in the cgroup_rstat_flush() context.

> When the issue happened, the list of pos->rstat_css_list at group A is
> empty.
> There must be racing conditions.
> 
> From reviewing code, we find rebind_subsystems() is no lock held when
> move css object to other list.
> 
> int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
> {
> ...
>    if (ss->css_rstat_flush) {
>          list_del_rcu(&css->rstat_css_node);
>          list_add_rcu(&css->rstat_css_node,
>                       &dcgrp->rstat_css_list);
>    }
> ...
> }
> 
> If we held a css object from A group list, at same time this css object
> was moved to B group list.
> [...]
> Do you have any suggestion for this issue?

The css->rstat_css_node should not be modified if there are possible RCU
readers elsewhere.
One way to fix this would be to insert synchronize_rcu() after
list_del_rcu() and before list_add_rcu().
(A further alternative (I've heard about) would be to utilize 'nulls'
RCU lists [1] to make the move between lists detectable.)

But as I'm looking at it from distance, it may be simpler and sufficient
to just take cgroup_rstat_lock around the list migration (the nesting
under cgroup_mutex that's held with rebind_subsystems() is fine).

HTH,
Michal

[1] https://www.kernel.org/doc/html/latest/RCU/rculist_nulls.html

