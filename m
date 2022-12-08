Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0820A646BF3
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 10:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLHJaU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 04:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiLHJaT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 04:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702075FBA5;
        Thu,  8 Dec 2022 01:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F2F61E04;
        Thu,  8 Dec 2022 09:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC104C433D6;
        Thu,  8 Dec 2022 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670491817;
        bh=KvDZ6QK3ZFSOs+gv7yHb4EU7Ui4QQ9oYslj/0R5XduM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJtrzXc2jp78dAEJI54yfardbIC81q390prkd+5L8QNe/LbFbhqmoT18F+gAuZUp6
         JnwpeICGIWmpXw5dq2ylyazPdFRLEwqQCLvK/g96V9hB9yCdR7agb77GU87KrjYRt3
         vQlKv/ZmwAqeYBg7lP4o7z/8M5hJNnLjRq0NIYUnUzz9dIArnNfO+rNQ1KiwJdULF+
         iZTXzuN9Pf8J7YeWVxCfNG8GohARLfeqQRk3ej5I+l9RMfHeNM2b1NBKboSj1LrIWC
         6y0140hbVaIo6wXA+s7Uw+nMn4GK5g5nsuUZ0KBwGs5gf8BJNUW0p789Y4wX6T9xnK
         xAaHlFUmaOf8w==
Date:   Thu, 8 Dec 2022 09:30:13 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 09/18] x86/sgx: Return the number of EPC pages that
 were successfully reclaimed
Message-ID: <Y5Gupbkb7BmCJlGn@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-10-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-10-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:45AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Return the number of reclaimed pages from sgx_reclaim_pages(), the EPC
> cgroup will use the result to track the success rate of its reclaim
> calls, e.g. to escalate to a more forceful reclaiming mode if necessary.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index f201ca85212f..a4a65eadfb79 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -291,7 +291,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>   * problematic as it would increase the lock contention too much, which would
>   * halt forward progress.
>   */
> -static void __sgx_reclaim_pages(int nr_to_scan)
> +static int __sgx_reclaim_pages(int nr_to_scan)

Nit: I wonder if we should use ssize_t here?

If nothing else, it would document better than 'int'.

BR, Jarkko
