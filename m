Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD98641018
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiLBVjq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLBVjp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:39:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F4DF610;
        Fri,  2 Dec 2022 13:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017184; x=1701553184;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x3lQwjwLht49M/jM4Z/ZUC2yG9PXyBbEO1YpDGLZO68=;
  b=Nn4+NRSNTy0rVF8PpJEIqUxtTiGeYmhuMIjRfJQXYHN+BCEtwZe0da/Q
   JntlgbJwaI81aibynFCw/GL7p6ZrXY/ocJWnCwNj16qLTqLNdSjQ36EKO
   1+dNMUCbFj8n5aVdV1ToBMi3cnWo2rgvGK5nKf5AiBNR0GFcx3V3yw0io
   i+B8iQm31V0pChiJwDk2RAHVdJTkXvHwsP8V0P/vxecObkPpWhQrp5ssD
   gBxeva1uQNXjMXdHK/72q9Jy2FaJb2DS4fyor+fyOSUGP6S9Y0BvnAI27
   POv4QfO+x3SpNTCMZB/zahVRb3sYVIsL4op+M44XrXPW1gQBO7BpVexuQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="402329971"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="402329971"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:39:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="677743028"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="677743028"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:39:43 -0800
Message-ID: <cfdfd5df-9b5d-f4c1-91fe-e0443819fa7e@intel.com>
Date:   Fri, 2 Dec 2022 13:39:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 03/18] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-4-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221202183655.3767674-4-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> Introduce a data structure to wrap the existing reclaimable list
> and its spinlock in a struct to minimize the code changes needed
> to handle multiple LRUs as well as reclaimable and non-reclaimable
> lists, both of which will be introduced and used by SGX EPC cgroups.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

Tiny nits: Let's also allude to the fact that this doesn't do anything
with the new helpers or structures for now.

I also think it's probably a sane idea to mention that the core VM also
has parallel LRU lists for cgroups.

> +static inline struct sgx_epc_page *
> +sgx_epc_pop_reclaimable(struct sgx_epc_lru_lists *lrus)
> +{
> +	return __sgx_epc_page_list_pop(&(lrus)->reclaimable);
> +}

Are those '(lrus)' parenthesis doing anything useful?
