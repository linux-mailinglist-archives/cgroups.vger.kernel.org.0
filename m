Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806E7B601C
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbjJCEtw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 00:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJCEtw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 00:49:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D8A4;
        Mon,  2 Oct 2023 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696308590; x=1727844590;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=E8tc/R+/OkMXWfpnzaO1qr4nhCDXJTuo1ZnSC3tCpro=;
  b=Ezi3S/s4DtRPOb8WwUB7nfik2+FzpNcNIC97X4fV9DA6e3D3+wBG85g7
   zHyWIbA9c7Vbo9dd+XzpXYIPaNbQyjQFiEy+L9ZS5NJe+UYgQkUbsFeSY
   jg5zuXC+b0EZPthCgX4a0lxZRMEBfjPdDtH40fAYkI0lYEYPURwPEhIu7
   2sJDb+Miv35FZaXJwDmHX/0DUCJxZCRoHPKHTDCy7xXE+hZuiRL5W0Te6
   w1a7Tn/1GQpeAgAJSMrpFwCCFzXRnKfnbThfbueS0WUrghpbnEcMdWMYo
   p06HldxEsAecBcYOX1p7DEn2DVl+ZXHgQOX3/XLnOFXaOiWdJpVKMErHa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1379595"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1379595"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 21:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997857606"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="997857606"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Oct 2023 21:49:46 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-7-haitao.huang@linux.intel.com>
 <b1d7199262b9da496a04a36447541e9166f35f19.camel@intel.com>
Date:   Mon, 02 Oct 2023 23:49:42 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b72c4brwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <b1d7199262b9da496a04a36447541e9166f35f19.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 27 Sep 2023 05:28:36 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> Use the lower 3 bits in the flags field of sgx_epc_page struct to
>> track EPC states in its life cycle and define an enum for possible
>> states. More state(s) will be added later.
>
> This patch does more than what the changelog claims to do.  AFAICT it  
> does
> below:
>
>  1) Use the lower 3 bits to track EPC page status
>  2) Rename SGX_EPC_PAGE_RECLAIMER_TRACKED to SGX_EPC_PAGE_RERCLAIMABLE
>  3) Introduce a new state SGX_EPC_PAGE_UNRECLAIMABLE
>  4) Track SECS and VA pages as SGX_EPC_PAGE_UNRECLAIMABLE
>
> The changelog only says 1) IIUC.
>
I don't quite get why you would view 3) as a separate item from 1).
In my view, 4) is not done as long as there is not separate list to track  
it.
Maybe I should make it clear the "states" vs "tracking". States are just  
bits in the flags, "tracking" is done using the lists by ksgxd/cgroup. And  
this patch is really about "states"
Would that clarify the intention of the patch?

> If we really want to do all these in one patch, then the changelog  
> should at
> least mention the justification of all of them.
>
> But I don't see why 3) and 4) need to be done here.  Instead, IMHO they  
> should
> be done in a separate patch, and do it after the unreclaimable list is
> introduced (or you need to bring that patch forward).
>
>
> For instance, ...
>
> [snip]
>
>> +
>> +	/* Page is in use but tracked in an unreclaimable LRU list. These are
>> +	 * only reclaimable when the whole enclave is OOM killed or the  
>> enclave
>> +	 * is released, e.g., VA, SECS pages
>> +	 * Becomes NOT_TRACKED after sgx_drop_epc()
>> +	 */
>> +	SGX_EPC_PAGE_UNRECLAIMABLE = 3,
>
> ... We even don't have the unreclaimable LRU list yet.  It's odd to have  
> this
> comment here.
>

Yeah, I should take out the mentioning of the LRUs from definitions of the  
states.

Thanks
Haitao
