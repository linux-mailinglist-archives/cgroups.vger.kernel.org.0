Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0299F7CB745
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 02:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjJQAJL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 20:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQAJK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 20:09:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48D92;
        Mon, 16 Oct 2023 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697501349; x=1729037349;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=156Vrx2+XHjHglrddNuXHYlGZ2Y4gw7x8LsBHYyeQQw=;
  b=XCcd8jxYaNl/CFoFVJmsVvi/WpC8LYZQTKBlORWu0L1YGan2PNg3mjkY
   6TP58q6cHtKMNPn0RzDSvyzZl6f4a3am1Vo4kz+eUd+/4uuGV+px/0EtF
   hiP35Z/+P9ENgugeZi1wvOGmkpnwv/q5wij4zIch2XK6oI9Fs8+JV7FqD
   0lPaLnNuqGuWlTHvK6LmJae0V3il9t8xYkuSNoXli9LVXZSulaoh6i62i
   lrlEIf2bMD6gGFmYzsFVNzvcpvScPYVr3lPaWOyvG+V/DVhiaUF7QbU+B
   pmy2AFfSuNeWU9RmFWjm6zGW4OGnspUMJxHSG+pmY3Okb1Q1lOo/+dEyT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376036887"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="376036887"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="755882542"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="755882542"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 16 Oct 2023 17:09:06 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Sean Christopherson" <seanjc@google.com>
Cc:     "Kai Huang" <kai.huang@intel.com>,
        "Bo Zhang" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Zhiquan1 Li" <zhiquan1.li@intel.com>,
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
References: <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
 <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ZS2r7-EAEovpV4BN@google.com>
Date:   Mon, 16 Oct 2023 19:09:04 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cxmpe1awjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ZS2r7-EAEovpV4BN@google.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Sean

On Mon, 16 Oct 2023 16:32:31 -0500, Sean Christopherson  
<seanjc@google.com> wrote:

> On Mon, Oct 16, 2023, Haitao Huang wrote:
>> From this perspective, I think the current implementation is  
>> "well-defined":
>> EPC cgroup limits for VMs are only enforced at VM launch time, not  
>> runtime.
>> In practice,  SGX VM can be launched only with fixed EPC size and all  
>> those
>> EPCs are fully committed to the VM once launched.
>
> Fully committed doesn't mean those numbers are reflected in the cgroup.   
> A VM
> scheduler can easily "commit" EPC to a guest, but allocate EPC on  
> demand, i.e.
> when the guest attempts to actually access a page.  Preallocating memory  
> isn't
> free, e.g. it can slow down guest boot, so it's entirely reasonable to  
> have virtual
> EPC be allocated on-demand.  Enforcing at launch time doesn't work for  
> such setups,
> because from the cgroup's perspective, the VM is using 0 pages of EPC at  
> launch.
>
Maybe I understood the current implementation wrong. From what I see, vEPC  
is impossible not fully commit at launch time. The guest would EREMOVE all  
pages during initialization resulting #PF and all pages allocated. This  
essentially makes "prealloc=off" the same as "prealloc=on".
Unless you are talking about some custom OS or kernel other than upstream  
Linux here?

Thanks
Haitap
