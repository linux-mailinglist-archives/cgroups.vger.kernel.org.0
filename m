Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0AC641072
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiLBWNh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiLBWNX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:13:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE8E8E12;
        Fri,  2 Dec 2022 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670019200; x=1701555200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tc0Asi9Ns/Uw80N6VM1uFJ98uRlF+kEfqeF5kPM3m/M=;
  b=n02GLvs84dzVV6fFBHSt2M5wLkwPLNR6SSwh9B1xW7w14Ax+WEt+wqAh
   lmbVakgBmrEty0YacXH7iQzP6DqaFlcLBWOHuELkwaCz7DxsWIPsuKufy
   kFrV0KJv/JyqdONyTEjUZavVmRbl1b4lKgIrhFT8q6SI3gMpNEHtdjdNW
   7Zs6FrxJzsPeREjUO4k545q4C7sulnLExzjp0M8uNDVgm4qh+gYG0o+e/
   oEVAXoETJUmR+Q6kqV1hoSE6QVEh4SWIdEKEdH/HTgUnhgcdPHqRQ54N0
   e7bzmvoIt+ZiDtqubYshBp255YWu4a4jVqi0C+58oKDsglfX1Kl9uWF4+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="316082121"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="316082121"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:13:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="638891537"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="638891537"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:13:20 -0800
Message-ID: <1dccd2ec-cad8-b9d2-d66b-aebad21cdb44@intel.com>
Date:   Fri, 2 Dec 2022 14:13:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 05/18] x86/sgx: Track epc pages on reclaimable or
 unreclaimable lists
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-6-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221202183655.3767674-6-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> Replace functions sgx_mark_page_reclaimable() and
> sgx_unmark_page_reclaimable() with sgx_record_epc_page() and
> sgx_drop_epc_page(). sgx_record_epc_page() wil add the epc_page
> to the correct "reclaimable" or "unreclaimable" list in the
> sgx_epc_lru_lists struct. sgx_drop_epc_page() will delete the page
> from the LRU list. Tracking pages that are not tracked by
> the reclaimer in the sgx_epc_lru_lists "unreclaimable" list allows
> an OOM event to cause all the pages in use by an enclave to be freed,
> regardless of whether they were reclaimable pages or not.

This might be more a comment about Sean's stuff, but could you please
start using paragraphs in these changelogs?

Also, on the content, I really prefer that patches start off talking in
English as much as possible and not just talk about the code.

	Right now, SGX has a single LRU list.  The code is transitioning
	over to use multiple LRU lists.

I'd also prefer that _this_ patch do the:

> -	sgx_mark_page_reclaimable(entry->epc_page);
> +	sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);

bits and then *another* patch do the unreclaimable side.  This patch
could be a straight replacement which is easy to audit.  The
unreclaimable one needs more thought.

I also think this ends up looking a bit weird:

> -	sgx_epc_push_reclaimable(&sgx_global_lru, page);
> +	WARN_ON(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
> +	page->flags |= flags;
> +	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
> +		sgx_epc_push_reclaimable(&sgx_global_lru, page);
> +	else
> +		sgx_epc_push_unreclaimable(&sgx_global_lru, page);
>  	spin_unlock(&sgx_global_lru.lock);
>  }

I think that would be better with a single "push" helper and then let
the callers specify the list:

	if (flags & SGX_EPC_PAGE_RECLAIMER_TRACKED)
		sgx_lru_push(&sgx_global_lru.reclaimable, page);
	else
		sgx_lru_push(&sgx_global_lru.unreclaimable, page);
