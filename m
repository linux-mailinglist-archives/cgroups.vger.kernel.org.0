Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6D7CD332
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 06:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjJREjH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 00:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjJREh7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 00:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455EED5E;
        Tue, 17 Oct 2023 21:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697603850; x=1729139850;
  h=cc:references:subject:to:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=lIB89A9HTSI42WxpivOXWDogJZFBgaPgowbpA6kdqGg=;
  b=hwn/t0gUbNYQrhl42XDvhJHb/NQQRrSUNztGNkxP3YLK6Z8mRaF/JSMB
   rnY5OPX0uy5xdoU+D7VzFMQHWhtKvyXxqnW809V4qkS92Wf+LmmYmII6D
   lo8yGMrJVgrQCqVmoipKupBCBgVWsdJ+E9FbNSlHu74V4niNMiktx1geO
   3tm3bZ7N6PYRM9lvcqdkY1PVtsXOqVXcRfByr3pzM+xjRCIy5pesOKAhi
   7resV/5PlKenMPvJGUovvNdWyr7G6bIdpKlfSqHFFfNSgAF5GrATHRNhl
   kpc5ygticPLRzPFHsQC28zh2LwRODPOBWyDWFAkStTGte2n9a5xy/ermO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383158038"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="383158038"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 21:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791452733"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="791452733"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Oct 2023 21:37:25 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Cc:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
References: <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
 <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
 <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6lrq4xmk42zteq6thpyah7jy25rmvkp7mqxtll6sl7z62m7n4m@vrbbedtgxeq4>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
To:     =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
Date:   Tue, 17 Oct 2023 23:37:23 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cztslnpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <6lrq4xmk42zteq6thpyah7jy25rmvkp7mqxtll6sl7z62m7n4m@vrbbedtgxeq4>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Tue, 17 Oct 2023 13:54:46 -0500, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> Hello Haitao.
>
> On Tue, Oct 17, 2023 at 07:58:02AM -0500, Haitao Huang  =

> <haitao.huang@linux.intel.com> wrote:
>> AFAIK, before we introducing max_write() callback in this series, no =
 =

>> misc
>> controller would possibly enforce the limit when misc.max is reduced.=
  =

>> e.g. I
>> don't think CVMs be killed when ASID limit is reduced and the cgroup =
was
>> full before limit is reduced.
>
> Yes, misccontroller was meant to be simple, current >=3D max serves to=

> prevent new allocations.
>
Thanks for confirming. Maybe another alternative we just keep max_write
non-preemptive. No need to add max_write() callback.

The EPC controller only triggers reclaiming on new allocations or return=

NOMEM if no more to reclaim. Reclaiming here includes normal EPC page  =

reclaiming and killing enclaves in out of EPC cases. vEPCs assigned to  =

guests are basically carved out and never reclaimable by the host.

As we no longer enforce limits on max_write a lower value, user should n=
ot  =

expect cgroup to force reclaim pages from enclave or kill VMs/enclaves a=
s  =

a result of reducing limits 'in-place'. User should always create cgroup=
s,  =

set limits, launch enclave/VM into the groups created.

> FTR, at some point in time memory.max was considered for reclaim contr=
ol
> of regular pages but it turned out to be too coarse (and OOM killing
> processes if amount was not sensed correctly) and this eventually
> evolved into specific mechanism of memory.reclaim.
> So I'm mentioning this should that be an interface with better semanti=
c
> for your use case (and misc.max writes can remain non-preemptive).
>

Yes we can introduce misc.reclaim to give user a knob to forcefully  =

reducing usage if
that is really needed in real usage. The semantics would make force-kill=
  =

VMs explicit to user.

> One more note -- I was quite confused when I read in the rest of the
> series about OOM and _kill_ing but then I found no such measure in the=

> code implementation. So I would suggest two terminological changes:
>
> - the basic premise of the series (00/18) is that EPC pages are a
>   different resource than memory, hence choose a better suiting name
>   than OOM (out of memory) condition,

I couldn't come up a good name. Out of EPC (OOEPC) maybe? I feel OOEPC  =

would be hard to read in code though. OOM was relatable as it is similar=
  =

to normal OOM but special kind of memory :-) I'm open to any better  =

suggestions.

> - killing -- (unless you have an intention to implement process
>   termination later) My current interpretation that it is rather some
>   aggressive unmapping within address space, so less confusing name fo=
r
>   that would be "reclaim".
>

yes. Killing here refers to killing enclave, analogous to killing proces=
s,
not just 'reclaim' though. I can change to always use 'killing enclave' =
 =

explicitly.

>
>> I think EPC pages to VMs could have the same behavior, once they are =
 =

>> given
>> to a guest, never taken back by the host. For enclaves on host side, =
 =

>> pages
>> are reclaimable, that allows us to enforce in a similar way to memcg.=

>
> Is this distinction between preemptability of EPC pages mandated by th=
e
> HW implementation? (host/"process" enclaves vs VM enclaves) Or do have=

> users an option to lock certain pages in memory that yields this
> difference?
>

The difference is really a result of current vEPC implementation. Becaus=
e
enclave pages once in use contains confidential content, they need speci=
al
process to reclaim. So it's complex to implement host reclaiming guest E=
PCs
gracefully.

Thanks
Haitao
