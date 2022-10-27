Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5047960F157
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 09:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiJ0Hp5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiJ0Hp5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 03:45:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4C8E71D;
        Thu, 27 Oct 2022 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666856756; x=1698392756;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=OCW40ZbCm1Tk3tTV/GsPHE+LH/8n92DVVvxKQTSwmrw=;
  b=FY+s2jVshivBRu8478Wu0wi3PCfaiz6rqsSrGkNddpS7ZrIhgV/67fus
   /5Lw/mxBOT/HNo1BrUwjP8SXYmKMX1+3bo+S3JNS9rc3k6/vTY8p58OeZ
   x5wdOc4BHRfvU1hp+mp0QXaAz/Na8Ae48Mu9akTLrxH89K6It0xl+e+zb
   kIaCD8VF/uRiOObewR4+VKBEjYxAKqU62Au+Gok65XDKEOGf1dloPg/Yv
   USMqOZ36arwy3T/QbaNkRoBRTjzXP7m4tCKIrArFdaFZfVEUXInaILGs6
   bNFG7i272DVrmiiyrECfiY+4S+WgLkwa174Z8ZBZrUajONo4QEm1IVew2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309247706"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="309247706"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:45:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="610259267"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="610259267"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:45:52 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, "Hocko, Michal" <mhocko@suse.com>,
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
References: <20221026074343.6517-1-feng.tang@intel.com>
        <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
        <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
        <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
        <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
        <Y1ovOeEPXT1fxCuc@feng-clx>
Date:   Thu, 27 Oct 2022 15:45:12 +0800
In-Reply-To: <Y1ovOeEPXT1fxCuc@feng-clx> (Feng Tang's message of "Thu, 27 Oct
        2022 15:11:53 +0800")
Message-ID: <87k04lk8vr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:

> On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
>> On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
>> > > > This all can get quite expensive so the primary question is, does the
>> > > > existing behavior generates any real issues or is this more of an
>> > > > correctness exercise? I mean it certainly is not great to demote to an
>> > > > incompatible numa node but are there any reasonable configurations when
>> > > > the demotion target node is explicitly excluded from memory
>> > > > policy/cpuset?
>> > >
>> > > We haven't got customer report on this, but there are quite some customers
>> > > use cpuset to bind some specific memory nodes to a docker (You've helped
>> > > us solve a OOM issue in such cases), so I think it's practical to respect
>> > > the cpuset semantics as much as we can.
>> >
>> > Yes, it is definitely better to respect cpusets and all local memory
>> > policies. There is no dispute there. The thing is whether this is really
>> > worth it. How often would cpusets (or policies in general) go actively
>> > against demotion nodes (i.e. exclude those nodes from their allowes node
>> > mask)?
>> >
>> > I can imagine workloads which wouldn't like to get their memory demoted
>> > for some reason but wouldn't it be more practical to tell that
>> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
>> > policies explicitly?
>> >
>> > > Your concern about the expensive cost makes sense! Some raw ideas are:
>> > > * if the shrink_folio_list is called by kswapd, the folios come from
>> > >   the same per-memcg lruvec, so only one check is enough
>> > > * if not from kswapd, like called form madvise or DAMON code, we can
>> > >   save a memcg cache, and if the next folio's memcg is same as the
>> > >   cache, we reuse its result. And due to the locality, the real
>> > >   check is rarely performed.
>> >
>> > memcg is not the expensive part of the thing. You need to get from page
>> > -> all vmas::vm_policy -> mm -> task::mempolicy
>> 
>> Yeah, on the same page with Michal. Figuring out mempolicy from page
>> seems quite expensive and the correctness can't be guranteed since the
>> mempolicy could be set per-thread and the mm->task depends on
>> CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
>
> Yes, you are right. Our "working" psudo code for mem policy looks like
> what Michal mentioned, and it can't work for all cases, but try to
> enforce it whenever possible:
>
> static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
> 		unsigned long addr, void *arg)
> {
> 	bool *skip_demotion = arg;
> 	struct mempolicy *mpol;
> 	int nid, dnid;
> 	bool ret = true;
>
> 	mpol = __get_vma_policy(vma, addr);
> 	if (!mpol) {
> 		struct task_struct *task;

                task = NULL;

> 		if (vma->vm_mm)
> 			task = vma->vm_mm->owner;
>
> 		if (task) {
> 			mpol = get_task_policy(task);
> 			if (mpol)
> 				mpol_get(mpol);
> 		}
> 	}
>
> 	if (!mpol)
> 		return ret;
>
> 	if (mpol->mode != MPOL_BIND)
> 		goto put_exit;
>
> 	nid = folio_nid(folio);
> 	dnid = next_demotion_node(nid);
> 	if (!node_isset(dnid, mpol->nodes)) {
> 		*skip_demotion = true;
> 		ret = false;
> 	}

I think that you need to get a node mask instead.  Even if
!node_isset(dnid, mpol->nodes), you may demote to other node in the node
mask.

Best Regards,
Huang, Ying

>
> put_exit:
> 	mpol_put(mpol);
> 	return ret;
> }
> 	
> static unsigned int shrink_page_list(struct list_head *page_list,..)
> {
> 	...
>
> 	bool skip_demotion = false;
> 	struct rmap_walk_control rwc = {
> 		.arg = &skip_demotion,
> 		.rmap_one = __check_mpol_demotion,
> 	};
>
> 	/* memory policy check */
> 	rmap_walk(folio, &rwc);
> 	if (skip_demotion)
> 		goto keep_locked;
> }
>
> And there seems to be no simple solution for getting the memory
> policy from a page.
>
> Thanks,
> Feng
>
>> >
>> > --
>> > Michal Hocko
>> > SUSE Labs
>> >
>> 
