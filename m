Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3117B837F
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbjJDPZB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243197AbjJDPZB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 11:25:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74C2C4;
        Wed,  4 Oct 2023 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696433098; x=1727969098;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Bomi4kzf2KeSu2vh9eC6kg5R2KFl6PGra2rvntBV690=;
  b=DO+WejJCHWl5RUu5mo1B9yU4sRmoikSifWFiroKNfUYUTsBxFo9sE1eB
   9Oc81YOs44bQO95izVgJevdkJZqC7QIfsw4iaBTcoyyWMMoqOBXpL1hWA
   R5nteFVSyXhI8vSTHdaRhhDcD9jGkS3LXegiuCce6JYNJXY8ZcIjXDkBu
   kSrvHX1qqodYvrEFZgObVO2H4JX6QpiwSiIF3Sf7RnpCsGt/8vrjPMvku
   SjWKwfKSRX8Er+1SCkD/ywLiE66CusF9y6mySFmwdVyv5+aIoikjtF8ok
   KDLtGcz5Ei7br6tTLyPCgPm/GmERuoNm77HLQj6yKrWPFeQRdBImMzlRi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="4764601"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="4764601"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="867428246"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="867428246"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Oct 2023 08:24:45 -0700
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
Subject: Re: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-7-haitao.huang@linux.intel.com>
 <b1d7199262b9da496a04a36447541e9166f35f19.camel@intel.com>
 <op.2b72c4brwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <0c296ec0011afc51b90d77db7a2b1ae0a239aff6.camel@intel.com>
Date:   Wed, 04 Oct 2023 10:24:43 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2caqfhkawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <0c296ec0011afc51b90d77db7a2b1ae0a239aff6.camel@intel.com>
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

On Tue, 03 Oct 2023 15:03:48 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Mon, 2023-10-02 at 23:49 -0500, Haitao Huang wrote:
>> On Wed, 27 Sep 2023 05:28:36 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> > On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> > > Use the lower 3 bits in the flags field of sgx_epc_page struct to
>> > > track EPC states in its life cycle and define an enum for possible
>> > > states. More state(s) will be added later.
>> >
>> > This patch does more than what the changelog claims to do.  AFAICT it
>> > does
>> > below:
>> >
>> >  1) Use the lower 3 bits to track EPC page status
>> >  2) Rename SGX_EPC_PAGE_RECLAIMER_TRACKED to SGX_EPC_PAGE_RERCLAIMABLE
>> >  3) Introduce a new state SGX_EPC_PAGE_UNRECLAIMABLE
>> >  4) Track SECS and VA pages as SGX_EPC_PAGE_UNRECLAIMABLE
>> >
>> > The changelog only says 1) IIUC.
>> >
>> I don't quite get why you would view 3) as a separate item from 1).
>
> 1) is about using some method to track EPC page status, 3) is adding a  
> new
> state.
>
> Why cannot they be separated?
>
>> In my view, 4) is not done as long as there is not separate list to  
>> track
>> it.
>
> You are literally doing below:
>
> @@ -113,6 +113,9 @@ static int sgx_encl_create(struct sgx_encl *encl,  
> struct
> sgx_secs *secs)
>  	encl->attributes = secs->attributes;
>  	encl->attributes_mask = SGX_ATTR_UNPRIV_MASK;
> +	sgx_record_epc_page(encl->secs.epc_page,
> +			    SGX_EPC_PAGE_UNRECLAIMABLE);
> +
>
> Which obviously is tracking SECS as unreclaimable page here.
>
> The only thing you are not doing now is to put to the actual list, which  
> you
> introduced in a later patch.
>
> But why not just doing them together?
>
>
I see where the problem is now.  Initially these states are bit masks so  
UNTRACKED and UNRECLAIMABLE are all not masked (set zero). I'll change  
these "record" calls with UNTRACKED instead, and later replace with  
UNRECLAIMABLE when they are actually added to the list. So UNRECLAIMABLE  
state can also be delayed until that patch with the list added.

Thanks.
Haitao
