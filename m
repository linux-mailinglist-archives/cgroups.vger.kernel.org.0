Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEFB646BD9
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 10:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLHJ0i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 04:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiLHJ0i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 04:26:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45425E3E4;
        Thu,  8 Dec 2022 01:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 548BC61E37;
        Thu,  8 Dec 2022 09:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366D0C433D7;
        Thu,  8 Dec 2022 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670491596;
        bh=TNqJerM9UR1fg07xX3h23a2j69g0XEpwAAYXPgA4ZEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6CZZHIqy2xxLR3jpTBP+mtBdBxj+rY6+ATpzcxHIKjvPsU3xfYS23x1cuKm0NQk+
         e968/2VYe1r14ryWx5aHvjSKkXQ4zjUGk7Hgtk/Hzv8hDAuO+++M1V1bQydOn6A/N0
         2W/r+n3CWFatZLQsHsAuP4sjEd2PJlz+jkd6B62gzFpcAeYYBeoKWUqbWjvfnZ1ni7
         yF2MmE2sGvH57azEdUviynHwYkog9ABiYbMYnpbBLFPbzauFUeeOsRoXkF+ATDOjY/
         aDptE0IvKxRc/b5rhT68YTFEMuVzo7jJ4aXGihkgIMomwPzb5CTZeY/8KO3gUGZwM9
         zquRZ/oh754XQ==
Date:   Thu, 8 Dec 2022 09:26:32 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 08/18] x86/sgx: Allow reclaiming up to 32 pages, but
 scan 16 by default
Message-ID: <Y5GtyM92jE5/UJT3@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-9-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-9-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:44AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Modify sgx_reclaim_pages() to take a parameter that specifies the
> number of pages to scan for reclaiming. Specify a max value of
> 32, but scan 16 in the usual case. This allows the number of pages
> sgx_reclaim_pages() scans to be specified by the caller, and adjusted
> in future patches.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 83aaf5cea7b9..f201ca85212f 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -18,6 +18,8 @@
>  #include "encl.h"
>  #include "encls.h"
>  
> +#define SGX_MAX_NR_TO_RECLAIM	32

SGX_NR_TO_SCAN_MAX

BR, Jarkko
