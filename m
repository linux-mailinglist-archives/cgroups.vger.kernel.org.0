Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBE07CB37F
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJPTwf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 15:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjJPTwe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 15:52:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA78F;
        Mon, 16 Oct 2023 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697485952; x=1729021952;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=MggiAk4RnmF8RUencBb93AiXjdxf5PvxYAIUeWm3Oho=;
  b=DPynDWUtImTpucq0bYCB8rOe4/1j+CsE47T1J4qmabedR6fW2g+1S2u1
   2H5df9N+BOA8Fo2d5ybSJ08GNxNIed8dpuvxB8dJc4f/5FqyBIfRbdebX
   ixYDgkgZK18L5Eh6cJ5NWH5F5fgI7xD4ozGKfNLKrKTOSGmLm9lclBWMS
   uV95E3zS1/+E7az8m0Hh6CqFQBVzY4K3ZPEUpGnKnufL4dZx3gtXE7vBi
   kzF23suJKWfAkoX65YsA8DcJFV4LeVusHVIGyueR6KdGwPfoMUbqJw6ad
   p9untLpwSq+XFiAhEgyo0A9g+7Ll9Wh6T+LaLqJghlgz0B2ZHT2gx9Hgv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388485872"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="388485872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 12:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821693902"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="821693902"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 16 Oct 2023 12:52:29 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "Zhang, Bo" <zhanb@microsoft.com>,
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
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
 <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
Date:   Mon, 16 Oct 2023 14:52:23 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 16 Oct 2023 05:57:36 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Thu, 2023-10-12 at 08:27 -0500, Haitao Huang wrote:
>> On Tue, 10 Oct 2023 19:51:17 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>> [...]
>> > (btw, even you track VA/SECS pages in unreclaimable list, given they
>> > both have
>> > 'enclave' as the owner,  do you still need SGX_EPC_OWNER_ENCL and
>> > SGX_EPC_OWNER_PAGE ?)
>>
>> Let me think about it, there might be also a way just track encl objects
>> not unreclaimable pages.
>>
>> I still not get why we need kill the VM not just remove just enough  
>> pages.
>> Is it due to the static allocation not able to reclaim?
>
> We can choose to "just remove enough EPC pages".  The VM may or may not  
> be
> killed when it wants the EPC pages back, depending on whether the  
> current EPC
> cgroup can provide enough EPC pages or not.  And this depends on how we
> implement the cgroup algorithm to reclaim EPC pages.
>
> One problem could be: for a EPC cgroup only has SGX VMs, you may end up  
> with
> moving EPC pages from one VM to another and then vice versa endlessly,

This could be a valid use case though if people intend to share EPCs  
between two VMs. Understand no one would be able to use VMs this way  
currently with the static allocation.

> because
> you never really actually mark any VM to be dead just like OOM does to  
> the
> normal enclaves.
>
> From this point, you still need a way to kill a VM, IIUC.
>
> I think the key point of virtual EPC vs cgroup, as quoted from Sean,  
> should be
> "having sane, well-defined behavior".
>
> Does "just remove enough EPC pages" meet this?  If the problem mentioned  
> above
> can be avoided, I suppose so?  So if there's an easy way to achieve, I  
> guess it
> can be an option too.
>
> But for the initial support, IMO we are not looking for a perfect but yet
> complicated solution.  I would say, from review's point of view, it's  
> preferred
> to have a simple implementation to achieve a not-prefect, but  
> consistent, well-
> defined behaviour.
>
> So to me looks killing the VM when cgroup cannot reclaim any more EPC  
> pages is a
> simple option.
>
> But I might have missed something, especially since middle of last week  
> I have
> been having fever and headache :-)
>
> So as mentioned above, you can try other alternatives, but please avoid
> complicated ones.
>
> Also, I guess it will be helpful if we can understand the typical SGX  
> app and/or
> SGX VM deployment under EPC cgroup use case.  This may help us on  
> justifying why
> the EPC cgroup algorithm to select victim is reasonable.
>


 From this perspective, I think the current implementation is  
"well-defined": EPC cgroup limits for VMs are only enforced at VM launch  
time, not runtime. In practice,  SGX VM can be launched only with fixed  
EPC size and all those EPCs are fully committed to the VM once launched.  
Because of that, I imagine people are using VMs to primarily partition the  
physical EPCs, i.e, the static size itself is the 'limit' for the workload  
of a single VM and not expecting EPCs taken away at runtime.

So killing does not really add much value for the existing usages IIUC.

That said, I don't anticipate adding the enforcement of killing VMs at  
runtime would break such usages as admin/user can simply choose to set the  
limit equal to the static size to launch the VM and forget about it.

Given that, I'll propose an add-on patch to this series as RFC and have  
some feedback from community before we decide if that needs be included in  
first version or we can skip it until we have EPC reclaiming for VMs.

Thanks
Haitao
 
