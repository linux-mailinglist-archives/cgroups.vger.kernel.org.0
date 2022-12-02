Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED14641021
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiLBVoR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiLBVoQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:44:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606E8DB6B4;
        Fri,  2 Dec 2022 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017455; x=1701553455;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zEGTLgU156UOzQQlahIl9CwmIKuBkFnhmeSW3FERkys=;
  b=iqmETKsoVlOcOh3OjFhWg+47kGFRGWGsSXvbC2+NwhhBGTkKsEpH8RKa
   EFfzjXUMu3xWjpAwNJ9gLHC0zz/wEfT3RPWEJWGQWQJOGUx8MRvUO/lJF
   YtjTJEa38vbm7HYmXuHNu6fsi5WoozgWEDQmtrtJ3G3uq9VY8LZJuSRdw
   XcUpalHTT5+tHbGgL+82W38vf3TKZcNwBWyQNjkT8N6bkUmRLroAtF7uc
   llT2vQQfkd/VgpvMpd53ZriUOWANJ4D7bmH5gVi8IWi001qOBXZSnMsL7
   FEGASX8bEBXjcYjw96cO1VqdOtl+NCFZ+3JrzCrI233WTrzMIUHH+OwBS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313688886"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313688886"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:44:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="733954994"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="733954994"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:43:59 -0800
Message-ID: <ad1bcb0f-661d-a701-2175-c8750d8af8d8@intel.com>
Date:   Fri, 2 Dec 2022 13:43:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 04/18] x86/sgx: Use sgx_epc_lru_lists for existing
 active page list
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-5-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221202183655.3767674-5-kristen@linux.intel.com>
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
> +	spin_lock(&sgx_global_lru.lock);
>  	for (i = 0; i < SGX_NR_TO_SCAN; i++) {
> -		if (list_empty(&sgx_active_page_list))
> +		epc_page = sgx_epc_pop_reclaimable(&sgx_global_lru);
> +		if (!epc_page)
>  			break;

One other nit about the structure of the patches: This introduced *both*
reclaimable and unreclaimable list_heads.  But, it has zero use for the
unreclaimable ones during the refactoring here.  I probably would have
left out the 'unreclaimable' bits for now.

BTW, this is a nice sign:

>  arch/x86/kernel/cpu/sgx/main.c | 39 +++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 20 deletions(-)


