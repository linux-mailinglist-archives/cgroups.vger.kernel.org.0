Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1660F1B7
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiJ0IBk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiJ0IBh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 04:01:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE480C34DD;
        Thu, 27 Oct 2022 01:01:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0382322889;
        Thu, 27 Oct 2022 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666857694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qa6sD3OJX290NYnGc0ulUW01Mac/lvuPb2vaepZWVak=;
        b=GOfRQdi/m0WYSTD5CYAhkOmN4NswRTwudSaHgtIJ1oHw16QVwyrpau8AnA+4eYPePOcGhe
        4VPRB2hWHIuofx9bzVfEvuQ+PfHUE5qM3DhDGpewPt3/bELf+bC3WB+x4DEvQu67yIfq1O
        IKDmab7lHY5SApO2WVHdJr/goa+3CBw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFE08134CA;
        Thu, 27 Oct 2022 08:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RhNlL906WmNTNAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 27 Oct 2022 08:01:33 +0000
Date:   Thu, 27 Oct 2022 10:01:33 +0200
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
Message-ID: <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx>
 <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <Y1kl8VbPE0RYdyEB@feng-clx>
 <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
 <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 27-10-22 15:39:00, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 27-10-22 14:47:22, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> > [...]
> >> > I can imagine workloads which wouldn't like to get their memory demoted
> >> > for some reason but wouldn't it be more practical to tell that
> >> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
> >> > policies explicitly?
> >> 
> >> If my understanding were correct, prctl() configures the process or
> >> thread.
> >
> > Not necessarily. There are properties which are per adddress space like
> > PR_[GS]ET_THP_DISABLE. This could be very similar.
> >
> >> How can we get process/thread configuration at demotion time?
> >
> > As already pointed out in previous emails. You could hook into
> > folio_check_references path, more specifically folio_referenced_one
> > where you have all that you need already - all vmas mapping the page and
> > then it is trivial to get the corresponding vm_mm. If at least one of
> > them has the flag set then the demotion is not allowed (essentially the
> > same model as VM_LOCKED).
> 
> Got it!  Thanks for detailed explanation.
> 
> One bit may be not sufficient.  For example, if we want to avoid or
> control cross-socket demotion and still allow demoting to slow memory
> nodes in local socket, we need to specify a node mask to exclude some
> NUMA nodes from demotion targets.

Isn't this something to be configured on the demotion topology side? Or
do you expect there will be per process/address space usecases? I mean
different processes running on the same topology, one requesting local
demotion while other ok with the whole demotion topology?
 
> >From overhead point of view, this appears similar as that of VMA/task
> memory policy?  We can make mm->owner available for memory tiers
> (CONFIG_NUMA && CONFIG_MIGRATION).  The advantage is that we don't need
> to introduce new ABI.  I guess users may prefer to use `numactl` than a
> new ABI?

mm->owner is a wrong direction. It doesn't have a strong meaning because
there is no one task explicitly responsible for the mm so there is no
real owner (our clone() semantic is just to permissive for that). The
memcg::owner is a crude and ugly hack and it should go away over time
rather than build new uses.

Besides that, and as I have already tried to explain, per task demotion
policy is what makes this whole thing expensive. So this better be a per
mm or per vma property. Whether it is a on/off knob like PR_[GS]ET_THP_DISABLE
or there are explicit requirements for fine grain control on the vma
level I dunno. I haven't seen those usecases yet and it is really easy
to overengineer this.

To be completely honest I would much rather wait for those usecases
before adding a more complex APIs.  PR_[GS]_DEMOTION_DISABLED sounds
like a reasonable first step. Should we have more fine grained
requirements wrt address space I would follow the MADV_{NO}HUGEPAGE
lead.

If we really need/want to give a fine grained control over demotion
nodemask then we would have to go with vma->mempolicy interface. In
any case a per process on/off knob sounds like a reasonable first step
before we learn more about real usecases.
-- 
Michal Hocko
SUSE Labs
