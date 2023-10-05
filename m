Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529597BA13D
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbjJEOmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjJEOhF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 10:37:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB351478AF;
        Thu,  5 Oct 2023 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514586; x=1728050586;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=ThNNe93ib7OIhxR0ZiNJ4iUr7y5MyJc/8/7ws16q7sI=;
  b=QB1FGsDEheiTUbHV7LcVgzgTU2102iQJR5kHdSojzsI9Pgt7T+AHUrLz
   4OG9zUm5K+8gn+g6uqptC03k6GB95qdHz0QxZgOwKereb4ArM1YGTNzwq
   aVwuDI/StMF7WEXPWVzovTaS/c9k8inZkzamSovUEevVAXhcAI5yfWJqM
   BZ13F42jG3Dk7X6oEsNLof5rhbTSA+CVTftYrUK+oFcu1B99SMihDx5co
   fhd6GcibLIek4maMBEvKTgUPHQEnOelKMjvnw0i4bdYQ+ZbB+nDvlQZJ3
   mUrGJEWF/bz+pYk1ar49LNi+2aJOc1APUnz/yXDO7RoePbVCSY/eN5902
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="380673771"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="380673771"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 21:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="895281677"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="895281677"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Oct 2023 21:21:12 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "tj@kernel.org" <tj@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-10-haitao.huang@linux.intel.com>
 <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
 <op.2b77pp0wwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <0953e4fac90921ff53570e2e6ebd2689fc1cd8fa.camel@intel.com>
 <op.2capgplewjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <34ec0ef5fda43e4b08e1e8352e5198e9e8a783ca.camel@intel.com>
Date:   Wed, 04 Oct 2023 23:22:38 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cbqf0nkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <34ec0ef5fda43e4b08e1e8352e5198e9e8a783ca.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 04 Oct 2023 16:13:41 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2023-10-04 at 10:03 -0500, Haitao Huang wrote:
>> On Tue, 03 Oct 2023 15:07:42 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> > On Tue, 2023-10-03 at 01:45 -0500, Haitao Huang wrote:
>> > > >
>> > > > Btw, probably a dumb question:
>> > > >
>> > > > Theoretically if you only need to find a victim enclave you don't  
>> need
>> > > > to put VA
>> > > > pages to the unreclaimable list, because those VA pages will be  
>> freed
>> > > > anyway
>> > > > when enclave is killed.  So keeping VA pages in the list is for>
>> > > accounting all
>> > > > the pages that the cgroup is having?
>> > >
>> > > Yes basically tracking them in cgroups as they are allocated.
>> > >
>> > > VAs and SECS may also come and go as swapping/unswapping happens.  
>> But
>> > > if acgroup is OOM, and all reclaimables are gone (swapped out), it'd
>> > > have toreclaim VAs/SECs in the same cgroup starting from the front  
>> of
>> > > the LRUlist. To reclaim a VA/SECS, it identifies the enclave from  
>> the
>> > > owner ofthe VA/SECS page and kills it, as killing enclave is the  
>> only
>> > > way toreclaim VA/SECS pages.
>> >
>> > To kill enclave you just need to track SECS in  the unreclaimable  
>> list.
>> > Only when you want to account the total EPC pages via some list you
>> > _probably_
>> > need to track VA as well.  But I am not quite sure about this either.
>>
>> There is a case where even SECS is paged out for an enclave with all
>> reclaimables out.
>
> Yes.  But this essentially means these enclaves are not active, thus  
> shouldn't
> be the victim of OOM?
>

But there are VA pages for the enclave at that moment. So it can be  
candidate for OOM victim.

>> So cgroup needs to track each page used by an enclave
>> and kill enclave when cgroup needs to lower usage by evicting an VA or
>> SECS page.
>
> Let's discuss more on tracking SECS on unreclaimable list only.
>
> Could we assume that when the OOM wants to pick up a victim to serve the  
> new
> enclave, there must be at least another one *active* enclave which still  
> has the
> SECS page in EPC?
>
No, at a given instant when OOM happens, "active" enclave's SECS may not  
be in EPC, but lots of VAs.

OOM := "no reclaimable pages left in the cgroup to reclaim and total usage  
is still at/near limit".



> If yes, that enclave will be selected as victim.
>
> If not, then no other enclave will be selected as victim.  Instead, only  
> the new
> enclave which is requesting more EPC will be selected, because it's SECS  
> is on
> the unreclaimable list.
>

You can't assume the requesting enclave's SECS is in unreclaimable list  
either. Think the request is from #PF in the scenario we fixed the NULL  
pointer of SECS by reloading it.

> Somehow this is unacceptable, thus we need to track VA pages too in  
> order to
> kill other inactive enclave?
>

If we know for sure SECS will always be in EPC, thus tracked in  
unreclaimables, then we probably can do it (see below).
I hope the reason given above is clear.

>> There were some discussion on paging out VAs without killing enclaves  
>> but
>> it'd be complicated and not implemented yet.
>
> No we don't involve swapping VA pages now.  It's a separate topic.
>
Only mentioned it as a kind of constraints impacting current design.

Another potential alternative: we don't reclaim SECS either until OOM and  
only track SECS pages for cgroups. But that would change current behavior.  
And I'm not sure about other consequences, e.g., enclaves theoretically  
can allocate pages (including VA pages) in different cgroups/processes, so  
we may still end up tracking all VA pages for cgroups or we track SECS  
page in all cgroups in which enclave allocated any pages. Let me know your  
thoughts.

>>
>> BTW, I need clarify tracking pages which is done by LRUs vs usage
>> accounting which is done by charge/uncharge to misc. To me tracking is  
>> for
>> reclaiming not accounting. Also vEPCs not tracked at all but they are
>> accounted for.
>
> I'll review the rest patches.  Thanks.


Thank you!
Haitao
