Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD9646C4B
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLHJ5E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 04:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLHJ5D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 04:57:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3FA654ED;
        Thu,  8 Dec 2022 01:57:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E613261E61;
        Thu,  8 Dec 2022 09:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE15C433C1;
        Thu,  8 Dec 2022 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670493421;
        bh=0YONDyXSVa33MyT3Y1l44dW3jNZREl8JU1hVtA1zMfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCSyXRUaBuN5Gfn5yMzGv4WNYwCtUjmYth2dtuI2WPqWJmXCbUCNNo4MJjxsRQ7ml
         25QzxXJWThQe16pB9msMXeV0V57sqf/XAySKr4f75hUXFY2JcCfdIksFAZ/ZPyTy26
         6qk6jXvM50+/jZ+dD8dNsPtT0HPYua0aq+PQDwRZz6q6DFvr05138ugmelxchXQVBM
         iG2Mjy+BK5qKg/aunxPyWAWnPDMNRYj4WmIDc3a/B5trq9ndv5eGo2WT+/23TAmAr8
         nqalOGJABkT5Y9hC3StQq0HehSbsEBdrd71JX42YX0hF4I0DK6mFYiNbhKJsxb2Tpc
         OeVJD4rNFw2Ng==
Date:   Thu, 8 Dec 2022 09:56:57 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 13/18] x86/sgx: Add helper to grab pages from an
 arbitrary EPC LRU
Message-ID: <Y5G06eSnWRAOJMty@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-14-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-14-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:49AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Move the isolation loop into a standalone helper, sgx_isolate_pages(),
> in preparation for existence of multiple LRUs.  Expose the helper to
> other SGX code so that it can be called from the EPC cgroup code, e.g.
> to isolate pages from a single cgroup LRU.  Exposing the isolation loop
> allows the cgroup iteration logic to be wholly encapsulated within the
> cgroup code.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 68 +++++++++++++++++++++-------------
>  arch/x86/kernel/cpu/sgx/sgx.h  |  2 +
>  2 files changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index c947b4ae06f3..a59550fa150b 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -280,7 +280,46 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>  }
>  
>  /**
> - * sgx_reclaim_pages() - Reclaim EPC pages from the consumers
> + * sgx_isolate_epc_pages() - Isolate pages from an LRU for reclaim
> + * @lru:	LRU from which to reclaim
> + * @nr_to_scan:	Number of pages to scan for reclaim
> + * @dst:	Destination list to hold the isolated pages
> + */
> +void sgx_isolate_epc_pages(struct sgx_epc_lru_lists *lru, int *nr_to_scan,
> +			   struct list_head *dst)

Why not instead return the number of pages scanned, and pass
'int nr_to_scan'?

That would just be more idiomatic choice.

BR, Jarkko
