Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E66138FC
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJaOch (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 10:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaOch (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 10:32:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F89A65A6;
        Mon, 31 Oct 2022 07:32:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D944E1F893;
        Mon, 31 Oct 2022 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667226754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVoDxS6PUHIpxcricZG+zBeWGoABJesgtPBdPuIWxgs=;
        b=ADVD/L1pGDvFfcekCmppTqkmXcU+rjMdYyhg8mHnsMS8svmtsz6Elc3Var2Zm60DaTjzoz
        6VshnsOVVIjhaLCLy9tavEkU8kFcf/5vobuAXe9oB1vvFXbqCdLYKQHoHXV6HPx6Go37d8
        /dHwaSMM3TO2m2wVYZeeokpupX5y/hs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BACA213451;
        Mon, 31 Oct 2022 14:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6UZZK4LcX2MhfQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 31 Oct 2022 14:32:34 +0000
Date:   Mon, 31 Oct 2022 15:32:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
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
Message-ID: <Y1/cgrgdVP+KdYzf@dhcp22.suse.cz>
References: <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
 <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
 <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
 <87bkpwkg24.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz>
 <Y1/XC+witPxFj04T@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/XC+witPxFj04T@feng-clx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 31-10-22 22:09:15, Feng Tang wrote:
> On Mon, Oct 31, 2022 at 04:40:15PM +0800, Michal Hocko wrote:
> > On Fri 28-10-22 07:22:27, Huang, Ying wrote:
> > > Michal Hocko <mhocko@suse.com> writes:
> > > 
> > > > On Thu 27-10-22 17:31:35, Huang, Ying wrote:
> > [...]
> > > >> I think that it's possible for different processes have different
> > > >> requirements.
> > > >> 
> > > >> - Some processes don't care about where the memory is placed, prefer
> > > >>   local, then fall back to remote if no free space.
> > > >> 
> > > >> - Some processes want to avoid cross-socket traffic, bind to nodes of
> > > >>   local socket.
> > > >> 
> > > >> - Some processes want to avoid to use slow memory, bind to fast memory
> > > >>   node only.
> > > >
> > > > Yes, I do understand that. Do you have any specific examples in mind?
> > > > [...]
> > > 
> > > Sorry, I don't have specific examples.
> > 
> > OK, then let's stop any complicated solution right here then. Let's
> > start simple with a per-mm flag to disable demotion of an address space.
> > Should there ever be a real demand for a more fine grained solution
> > let's go further but I do not think we want a half baked solution
> > without real usecases.
> 
> Yes, the concern about the high cost for mempolicy from you and Yang is
> valid. 
> 
> How about the cpuset part?

Cpusets fall into the same bucket as per task mempolicies wrt costs. Geting a
cpuset requires knowing all tasks associated with a page. Or am I just
missing any magic? And no memcg->cpuset association is not a proper
solution at all.

> We've got bug reports from different channels
> about using cpuset+docker to control meomry placement in memory tiering
> system, leading to 2 commits solving them:
> 
> 2685027fca38 ("cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in
> cpuset_init_smp()") 
> https://lore.kernel.org/all/20220419020958.40419-1-feng.tang@intel.com/
> 
> 8ca1b5a49885 ("mm/page_alloc: detect allocation forbidden by cpuset and
> bail out early")
> https://lore.kernel.org/all/1632481657-68112-1-git-send-email-feng.tang@intel.com/
> 
> >From these bug reports, I think it's reasonable to say there are quite
> some real world users using cpuset+docker+memory-tiering-system.

I don't think anybody is questioning existence of those usecases. The
primary question is whether any of them really require any non-trivial
(read nodemask aware) demotion policies. In other words do we know of
cpuset policy setups where demotion fallbacks are (partially) excluded?
-- 
Michal Hocko
SUSE Labs
