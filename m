Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C37C57A8
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjJKPCf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjJKPCf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 11:02:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCD592;
        Wed, 11 Oct 2023 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697036553; x=1728572553;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=rcaM/QXDjeb5pjruo3uYNr3IKZQ2KQs7ApHKV/3WpXM=;
  b=iqd82FuhnxYDwVQQP70P18aHwlOHipKJJSY2jHtIa+C5qQDN2CwsPf0s
   xajHocPqD4ObDZ7KLbpKxIhB8QKSYAftK0PlNA4fcDC6f+hxkX5oTiduu
   s8MvNJX2mvElph/Vhox58KJkr694/J+Me87vkMSb6ZzCxuTA95nBFXvT8
   G0TWuaflFp8upZDFOc1Ly0B4tdfoxg7Pt5+xrDoxEN7ef4KFYuB4oYidp
   Mlz2XTTnbpWfX6wVKvDg1dQHnP5iuoYI269/N9RNS//2MgxOTE0MV2Dci
   w451h7cwwEzyekvnymdhWqjG+hh9l7MUuHY8dFkRjyBlaRuKuBGUeY/5y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="383550872"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="383550872"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 08:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="897655926"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="897655926"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 11 Oct 2023 08:00:42 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Sean Christopherson" <seanjc@google.com>
Cc:     "Kai Huang" <kai.huang@intel.com>,
        "Bo Zhang" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhiquan1 Li" <zhiquan1.li@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
 <op.2cksdjamwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <548d2ab828307f7d1c6d7f707e587cd27b0e7fe4.camel@intel.com>
 <op.2clox2zewjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ZSXl1VXTM0c8qpZj@google.com>
Date:   Wed, 11 Oct 2023 10:02:25 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cnn2bplwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ZSXl1VXTM0c8qpZj@google.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 10 Oct 2023 19:01:25 -0500, Sean Christopherson  
<seanjc@google.com> wrote:

> On Tue, Oct 10, 2023, Haitao Huang wrote:
>> On Mon, 09 Oct 2023 21:23:12 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> > On Mon, 2023-10-09 at 20:42 -0500, Haitao Huang wrote:
>> > > Hi Sean
>> > >
>> > > On Mon, 09 Oct 2023 19:23:04 -0500, Sean Christopherson
>> > > <seanjc@google.com> wrote:
>> > > > I can see userspace wanting to explicitly terminate the VM  
>> instead of
>> > > > "silently"
>> > > > the VM's enclaves, but that seems like it should be a knob in the
>> > > > virtual EPC
>> > > > code.
>> > >
>> > > If my understanding above is correct and understanding your  
>> statement
>> > > above correctly, then don't see we really need separate knob for  
>> vEPC
>> > > code. Reaching a cgroup limit by a running guest (assuming dynamic
>> > > allocation implemented) should not translate automatically killing
>> > > the VM.
>> > > Instead, it's user space job to work with guest to handle allocation
>> > > failure. Guest could page and kill enclaves.
>> > >
>> >
>> > IIUC Sean was talking about changing misc.max _after_ you launch SGX  
>> VMs:
>> >
>> > 1) misc.max = 100M
>> > 2) Launch VMs with total virtual EPC size = 100M	<- success
>> > 3) misc.max = 50M
>> >
>> > 3) will also succeed, but nothing will happen, the VMs will be still
>> > holding 100M EPC.
>> >
>> > You need to somehow track virtual EPC and kill VM instead.
>> >
>> > (or somehow fail to do 3) if it is also an acceptable option.)
>> >
>> Thanks for explaining it.
>>
>> There is an error code to return from max_write. I can add that too to  
>> the
>> callback definition and fail it when it can't be enforced for any  
>> reason.
>> Would like some community feedback if this is acceptable though.
>
> That likely isn't acceptable.  E.g. create a cgroup with both a host  
> enclave and
> virtual EPC, set the hard limit to 100MiB.  Virtual EPC consumes 50MiB,  
> and the
> host enclave consumes 50MiB.  Userspace lowers the limit to 49MiB.  The  
> cgroup
> code would reclaim all of the enclave's reclaimable EPC, and then kill  
> the enclave
> because it's still over the limit.  And then fail the max_write because  
> the cgroup
> is *still* over the limit.  So in addition to burning a lot of cycles,  
> from
> userspace's perspective its enclave was killed for no reason, as the new  
> limit
> wasn't actually set.

I was thinking before reclaiming enclave pages, if we know the untracked  
vepc pages (current-tracked) is larger than limit, we just return error  
without enforcing the limit. That way user also knows something is wrong.

But I get that we want to be able to kill VMs to enforce the newer lower  
limit. I assume we can't optimize efficiency/priority of killing: enclave  
pages will be reclaimed first no matter what just because they are  
reclaimable; no good rules to choose victim between enclave and VMs in  
your example so enclaves could be killed still before VMs.

>> I think to solve it ultimately, we need be able to adjust 'capacity' of  
>> VMs
>> not to just kill them, which is basically the same as dynamic allocation
>> support for VMs (being able to increase/decrease epc size when it is
>> running). For now, we only have static allocation so max can't be  
>> enforced
>> once it is launched.
>
> No, reclaiming virtual EPC is not a requirement.  VMM EPC  
> oversubscription is
> insanely complex, and I highly doubt any users actually want to  
> oversubcribe VMs.
>
> There are use cases for cgroups beyond oversubscribing/swapping, e.g.  
> privileged
> userspace may set limits on a container to ensure the container doesn't  
> *accidentally*
> consume more EPC than it was allotted, e.g. due to a configuration bug  
> that created
> a VM with more EPC than it was supposed to have.
>
> My comments on virtual EPC vs. cgroups is much more about having sane,  
> well-defined
> behavior, not about saying the kernel actually needs to support  
> oversubscribing EPC
> for KVM guests.

So here are the steps I see now, let me know if this is aligned with your  
thinking or I'm off track.

0) when all left are enclave VA, SECS pages and VEPC in a cgroup, the OOM  
kill process starts.
1) The cgroup identifies a victim vepc for OOM kill(this could be before  
or after enclaves being killed), sets a new flag VEPC_NO_MEMORY in the  
vepc.
2) call sgx_vepc_remove_all(), ignore failure counts returned. This will  
perform best effort to eremove all normal pages used by the vepc.
3) Guest may trigger fault again, return SIGBUS in sgx_vepc_fault when  
VEPC_NO_MEMORY is set. Do the same for mmap.
4) That would eventually cause sgx_vepc_release() before VM dies or killed  
by user space, which does the final cleanup.

Q: should we reset VEPC_NO_MEMORY flag if #4 never happens and cgroup  
usage is below limit? I suppose we can do it, but not sure it is sane  
because VM would try to load as much pages as configured originally.

I'm still thinking about using one unreclaimable list, justification is  
simplicity and lack of rules to select items from separate lists, but may  
change my mind if I found it's inconvenient.

Not sure how age/youngness can be accounted for guest pages though Kai  
indicated we don't need that for first version. So I assume we can deal  
with it later and add separate list for vEPC if needed
for that reason.

Thanks a lot for your input.
Haitao
