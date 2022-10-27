Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FE60F741
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiJ0MaQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiJ0M3w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 08:29:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A41147C;
        Thu, 27 Oct 2022 05:29:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D54682189E;
        Thu, 27 Oct 2022 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666873789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLCHdSoF5LvMGX21jAzxWFCsbeXpnvlMNpAzGikriy4=;
        b=RJeUztS7r094eW6OujV+pvkgja9wTiwyiRHoJsanxtMjnKblu1Vdp8ONKpkwEDNh0nwPON
        YxHuTG3JWccRnJ0scqKJnDuIQQ4uHszEKCvFn9HTC3xLLjUOUmiWCaBSfKomhXO8mWZzgO
        y8Ub5T1ot7toA2QaS58/EAn5MTRavKk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0336134CA;
        Thu, 27 Oct 2022 12:29:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M7RMJ715WmOGSAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 27 Oct 2022 12:29:49 +0000
Date:   Thu, 27 Oct 2022 14:29:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Message-ID: <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
References: <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
 <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
 <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 27-10-22 17:31:35, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 27-10-22 15:39:00, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> >> 
> >> > On Thu 27-10-22 14:47:22, Huang, Ying wrote:
> >> >> Michal Hocko <mhocko@suse.com> writes:
> >> > [...]
> >> >> > I can imagine workloads which wouldn't like to get their memory demoted
> >> >> > for some reason but wouldn't it be more practical to tell that
> >> >> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> >> >> > policies explicitly?
> >> >> 
> >> >> If my understanding were correct, prctl() configures the process or
> >> >> thread.
> >> >
> >> > Not necessarily. There are properties which are per adddress space like
> >> > PR_[GS]ET_THP_DISABLE. This could be very similar.
> >> >
> >> >> How can we get process/thread configuration at demotion time?
> >> >
> >> > As already pointed out in previous emails. You could hook into
> >> > folio_check_references path, more specifically folio_referenced_one
> >> > where you have all that you need already - all vmas mapping the page and
> >> > then it is trivial to get the corresponding vm_mm. If at least one of
> >> > them has the flag set then the demotion is not allowed (essentially the
> >> > same model as VM_LOCKED).
> >> 
> >> Got it!  Thanks for detailed explanation.
> >> 
> >> One bit may be not sufficient.  For example, if we want to avoid or
> >> control cross-socket demotion and still allow demoting to slow memory
> >> nodes in local socket, we need to specify a node mask to exclude some
> >> NUMA nodes from demotion targets.
> >
> > Isn't this something to be configured on the demotion topology side? Or
> > do you expect there will be per process/address space usecases? I mean
> > different processes running on the same topology, one requesting local
> > demotion while other ok with the whole demotion topology?
> 
> I think that it's possible for different processes have different
> requirements.
> 
> - Some processes don't care about where the memory is placed, prefer
>   local, then fall back to remote if no free space.
> 
> - Some processes want to avoid cross-socket traffic, bind to nodes of
>   local socket.
> 
> - Some processes want to avoid to use slow memory, bind to fast memory
>   node only.

Yes, I do understand that. Do you have any specific examples in mind?
[...]
> > If we really need/want to give a fine grained control over demotion
> > nodemask then we would have to go with vma->mempolicy interface. In
> > any case a per process on/off knob sounds like a reasonable first step
> > before we learn more about real usecases.
> 
> Yes.  Per-mm or per-vma property is much better than per-task property.
> Another possibility, how about add a new flag to set_mempolicy() system
> call to set the per-mm mempolicy?  `numactl` can use that by default.

Do you mean a flag to control whether the given policy is applied to a
task or mm?
-- 
Michal Hocko
SUSE Labs
