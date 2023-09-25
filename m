Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C657AD828
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjIYMhk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIYMhk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 08:37:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683489C
        for <cgroups@vger.kernel.org>; Mon, 25 Sep 2023 05:37:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DDA191F45F;
        Mon, 25 Sep 2023 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695645450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nLsSixWH3YAfP7MPArOkBvfmfGcgIYuoxbr0qN9YYMk=;
        b=bAXXeg+2WDLQbdBQmXNyDeKlSvvrApuyEFX8cWoB1Ow243Cd8s44ujYgsTNgHe0jt6MGPo
        3JKqFlye/WqmSfMQ6L4iDfC+H54s19HMlfDPRS9d2A26ormHluUQIigQamtHppg+mwqNc4
        CaRAUOwtx69KfH1vY7Q9KrpE2ePC9xg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9A3513580;
        Mon, 25 Sep 2023 12:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bfVgKgp/EWUQcQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 25 Sep 2023 12:37:30 +0000
Date:   Mon, 25 Sep 2023 14:37:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
Message-ID: <ZRF/CTk4MGPZY6Tc@dhcp22.suse.cz>
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
 <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
 <6b7af68c-2cfb-b789-4239-204be7c8ad7e@shopee.com>
 <ZRFxLuJp1xqvp4EH@dhcp22.suse.cz>
 <94b7ed1d-9ca8-7d34-a0f4-c46bc995a3d2@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b7ed1d-9ca8-7d34-a0f4-c46bc995a3d2@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 25-09-23 20:28:02, Haifeng Xu wrote:
> 
> 
> On 2023/9/25 19:38, Michal Hocko wrote:
> > On Mon 25-09-23 17:03:05, Haifeng Xu wrote:
> >>
> >>
> >> On 2023/9/25 15:57, Michal Hocko wrote:
> >>> On Fri 22-09-23 07:05:28, Haifeng Xu wrote:
> >>>> When application in userland receives oom notification from kernel
> >>>> and reads the oom_control file, it's confusing that under_oom is 0
> >>>> though the omm killer hasn't finished. The reason is that under_oom
> >>>> is cleared before invoking mem_cgroup_out_of_memory(), so move the
> >>>> action that unmark under_oom after completing oom handling. Therefore,
> >>>> the value of under_oom won't mislead users.
> >>>
> >>> I do not really remember why are we doing it this way but trying to track
> >>> this down shows that we have been doing that since fb2a6fc56be6 ("mm:
> >>> memcg: rework and document OOM waiting and wakeup"). So this is an
> >>> established behavior for 10 years now. Do we really need to change it
> >>> now? The interface is legacy and hopefully no new workloads are
> >>> emerging.
> >>>
> >>> I agree that the placement is surprising but I would rather not change
> >>> that unless there is a very good reason for that. Do you have any actual
> >>> workload which depends on the ordering? And if yes, how do you deal with
> >>> timing when the consumer of the notification just gets woken up after
> >>> mem_cgroup_out_of_memory completes?
> >>
> >> yes, when the oom event is triggered, we check the under_oom every 10 seconds. If it
> >> is cleared, then we create a new process with less memory allocation to avoid oom again.
> > 
> > OK, I do understand what you mean and I could have made myself
> > more clear previously. Even if the state is cleared _after_
> > mem_cgroup_out_of_memory then you won't get what you need I am
> > afraid. The memcg stays under OOM until a memory is freed (uncharged)
> > from that memcg. mem_cgroup_out_of_memory itself doesn't really free
> > any memory on its own. It relies on the task to wake up and die or
> > oom_reaper to do the work on its behalf. All of that is time dependent.
> > under_oom would have to be reimplemented to be cleared when a memory is
> > unchanrged to meet your demands. Something that has never really been
> > the semantic.
> > 
> 
> yes, but at least before we create the new process, it has more chance to get some memory freed.

The time window we are talking about is the call of
mem_cgroup_out_of_memory which, depending on the number of evaluated
processes, could be a very short time. So what kind of practical
difference does this have on your workload? Is this measurable in any
way.

> > Btw. is this something new that you are developing on top of v1? And if
> > yes, why don't you use v2?
> > 
> 
> yes, v2 doesn't have the "cgroup.event_control" file.

Yes, it doesn't. But why is it necessary? Relying on v1 just for this is
far from ideal as v1 is deprecated and mostly frozen. Why do you need to
rely on the oom notifications (or oom behavior in general) in the first
place? Could you share more about your workload and your requirements?

-- 
Michal Hocko
SUSE Labs
