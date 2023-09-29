Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21D17B3653
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjI2PGR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2PGR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 11:06:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FFAF7;
        Fri, 29 Sep 2023 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695999975; x=1727535975;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=qj0eh55UwGPngvSahx/UIAzAqFq0pQb7yzApIYUtOY4=;
  b=BRE41RjQBTNMmwb8tpnOFwW1wWMpN7EvzwD/IELFxJ/G40jd57XdIUOz
   +ANJbGasMNMTnMzJNssgEj4I2WDESrbfnFas54euY2K1vW8mxzsZj3KWp
   GF8Ke+aoV8xDn/c9BWcduxph4RXNtiSWS0LEeF33AEdd/NJ0HMONhxnlZ
   OtZbkmpPPpFnIv+YOOYblgcTi5p/Kkpma/y4gfuaaZl1OspWYiWRrcWdO
   jvzaB8if4NDy5xwDK28v83s0Fvu7Zb/RhM+O7gQ69HQ2nuSYtr6DLyD79
   AIssbRvQe728TXX5FSgNzXtWAJ8b9VCamMOnSuFS5Hu9yHW6eL4hiqm+H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385136058"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="385136058"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="840294789"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="840294789"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 29 Sep 2023 08:06:10 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhang, Bo" <zhanb@microsoft.com>
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-10-haitao.huang@linux.intel.com>
 <46fecb95ae2c4cd156ad7bda99522214fcfe5774.camel@intel.com>
 <op.2bxr9aj7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <fd2049b46a2e508a90006731a5d0cd2b90db9e45.camel@intel.com>
Date:   Fri, 29 Sep 2023 10:06:09 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b1f8j1bwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <fd2049b46a2e508a90006731a5d0cd2b90db9e45.camel@intel.com>
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

On Wed, 27 Sep 2023 16:21:19 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2023-09-27 at 10:35 -0500, Haitao Huang wrote:
>> > > +
>> > > +	/* Possible owner types */
>> > > +	union {
>> > > +		struct sgx_encl_page *encl_page;
>> > > +		struct sgx_encl *encl;
>> > > +	};
>> >
>> > Sadly for virtual EPC page the owner is set to the 'sgx_vepc'  
>> instance it
>> > belongs to.
>> >
>> > Given how sgx_{alloc|free}_epc_page() arbitrarily uses encl_page,>  
>> perhaps we
>> > should do below?
>> >
>> >  	union {
>> >  		struct sgx_encl_page *encl_page;
>> >  		struct sgx_encl *encl;
>> >  		struct sgx_vepc *vepc;
>> >  		void *owner;
>> >  	};
>> >
>> > And in sgx_{alloc|free}_epc_page() we can use 'owner' instead.
>> >
>>
>> As I mentioned in cover letter and change log in 11/18, this series does 
>> not track virtual EPC.
>
> It's not about how does the cover letter says.  We cannot ignore the  
> fact that
> currently virtual EPC uses owner too.
>
> But given the virtual EPC code currently doesn't use the owner, I can  
> live with
> not having the 'vepc' member in the union now.

Ah, I forgot even though we don't use the owner field assigned by vepc, it  
is still passed into sgx_alloc/free_epc_page().

Will add back "void* owner" and use it for assignment inside  
sgx_alloc/free_epc_page().

Thanks

Haitao
