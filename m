Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8687B0593
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjI0NhB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjI0NhA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 09:37:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DFFC
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 06:36:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FD182187E;
        Wed, 27 Sep 2023 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695821817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7Idmtu02QxC4J8MQAv/PYEFXdZAAEtQqz7PpTqRFdg=;
        b=GSrPzI/mGR0aGY9Vy3vDNvNTbmKRpRiWEXFjj/ZHOWwvx5sUzEdHREesizQmkM77ygBX/T
        AWC6fMGPjIwkZT1FeiKEh1RTtMegD5IBwhb7ZeV9HsZzvWQzuL4dKQ1UK9Sgd96TaiJ4yq
        6ab9X3T98PD5WWbSTjAfeF0dmboLxC8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 451E613479;
        Wed, 27 Sep 2023 13:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AMWoEPkvFGX9JgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 27 Sep 2023 13:36:57 +0000
Date:   Wed, 27 Sep 2023 15:36:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
Message-ID: <ZRQv+E1plKLj8Xe3@dhcp22.suse.cz>
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
 <ZRE9fAf1dId2U4cu@dhcp22.suse.cz>
 <6b7af68c-2cfb-b789-4239-204be7c8ad7e@shopee.com>
 <ZRFxLuJp1xqvp4EH@dhcp22.suse.cz>
 <94b7ed1d-9ca8-7d34-a0f4-c46bc995a3d2@shopee.com>
 <ZRF/CTk4MGPZY6Tc@dhcp22.suse.cz>
 <fe80b246-3f92-2a83-6e50-3b923edce27c@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe80b246-3f92-2a83-6e50-3b923edce27c@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 26-09-23 22:39:11, Haifeng Xu wrote:
> 
> 
> On 2023/9/25 20:37, Michal Hocko wrote:
> > On Mon 25-09-23 20:28:02, Haifeng Xu wrote:
> >>
> >>
> >> On 2023/9/25 19:38, Michal Hocko wrote:
> >>> On Mon 25-09-23 17:03:05, Haifeng Xu wrote:
> >>>>
> >>>>
> >>>> On 2023/9/25 15:57, Michal Hocko wrote:
> >>>>> On Fri 22-09-23 07:05:28, Haifeng Xu wrote:
> >>>>>> When application in userland receives oom notification from kernel
> >>>>>> and reads the oom_control file, it's confusing that under_oom is 0
> >>>>>> though the omm killer hasn't finished. The reason is that under_oom
> >>>>>> is cleared before invoking mem_cgroup_out_of_memory(), so move the
> >>>>>> action that unmark under_oom after completing oom handling. Therefore,
> >>>>>> the value of under_oom won't mislead users.
> >>>>>
> >>>>> I do not really remember why are we doing it this way but trying to track
> >>>>> this down shows that we have been doing that since fb2a6fc56be6 ("mm:
> >>>>> memcg: rework and document OOM waiting and wakeup"). So this is an
> >>>>> established behavior for 10 years now. Do we really need to change it
> >>>>> now? The interface is legacy and hopefully no new workloads are
> >>>>> emerging.
> >>>>>
> >>>>> I agree that the placement is surprising but I would rather not change
> >>>>> that unless there is a very good reason for that. Do you have any actual
> >>>>> workload which depends on the ordering? And if yes, how do you deal with
> >>>>> timing when the consumer of the notification just gets woken up after
> >>>>> mem_cgroup_out_of_memory completes?
> >>>>
> >>>> yes, when the oom event is triggered, we check the under_oom every 10 seconds. If it
> >>>> is cleared, then we create a new process with less memory allocation to avoid oom again.
> >>>
> >>> OK, I do understand what you mean and I could have made myself
> >>> more clear previously. Even if the state is cleared _after_
> >>> mem_cgroup_out_of_memory then you won't get what you need I am
> >>> afraid. The memcg stays under OOM until a memory is freed (uncharged)
> >>> from that memcg. mem_cgroup_out_of_memory itself doesn't really free
> >>> any memory on its own. It relies on the task to wake up and die or
> >>> oom_reaper to do the work on its behalf. All of that is time dependent.
> >>> under_oom would have to be reimplemented to be cleared when a memory is
> >>> unchanrged to meet your demands. Something that has never really been
> >>> the semantic.
> >>>
> >>
> >> yes, but at least before we create the new process, it has more chance to get some memory freed.
> > 
> > The time window we are talking about is the call of
> > mem_cgroup_out_of_memory which, depending on the number of evaluated
> > processes, could be a very short time. So what kind of practical
> > difference does this have on your workload? Is this measurable in any
> > way.
> 
> The oom events in this group seems less than before.

Let me see if I follow. You are launching new workloads after oom
happens as soon as under_oom becomes 0. With the patch applied you see
fewer oom invocations which imlies that fewer re-launchings hit the
stil-under-oom situations? I would also expect that those are compared
over the same time period. Do you have any actual numbers to present?
Are they statistically representative?

I really have to say that I am skeptical over the presented usecase.
Optimizing over oom events seems just like a very wrong way to scale the
workload. Timing of oom handling is a subject to change at any time and
what you are optimizing for might change.

That being said, I do not see any obvious problem with the patch. IMO we
should rather not apply it because it is slighly changing a long term
behavior for something that is in a legacy mode now. But I will not Nack
it either as it is just a trivial thing. I just do not like an idea we
would be changing the timing of under_oom clearing just to fine tune
some workloads.
 
> >>> Btw. is this something new that you are developing on top of v1? And if
> >>> yes, why don't you use v2?
> >>>
> >>
> >> yes, v2 doesn't have the "cgroup.event_control" file.
> > 
> > Yes, it doesn't. But why is it necessary? Relying on v1 just for this is
> > far from ideal as v1 is deprecated and mostly frozen. Why do you need to
> > rely on the oom notifications (or oom behavior in general) in the first
> > place? Could you share more about your workload and your requirements?
> > 
> 
> for example, we want to run processes in the group but those parametes related to 
> memory allocation is hard to decide, so use the notifications to inform us that we
> need to adjust the paramters automatically and we don't need to create the new processes
> manually.

I do understand that but OOM is just way too late to tune anything
upon. Cgroup v2 has a notion of high limit which can throttle memory
allocations way before the hard limit is set and this along with PSI
metrics could give you a much better insight on the memory pressure
in a memcg.

-- 
Michal Hocko
SUSE Labs
