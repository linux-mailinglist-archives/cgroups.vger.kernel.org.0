Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74717646C08
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLHJiC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 04:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLHJiA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 04:38:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709242FC23;
        Thu,  8 Dec 2022 01:37:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF7BD61E42;
        Thu,  8 Dec 2022 09:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5F2C433D6;
        Thu,  8 Dec 2022 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670492273;
        bh=wYx2MO5YR6MseoVFegS6uhUtm5jWg22S6hWITNm5BM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8HFEZSYo9pu0gboQpt9k8bdF2m9KCt5kF1ymZ/H5G65QDagLY+dzTTppFobUWtFv
         NSyEtoj1nMd8euSMT+6GAVXcfB1FjOek03/GBlFLmzduklr7BWi4RRO5eC3N41T8hZ
         S8wXuQ5t0JK8Mho1XXB7C7TrE3lXvfhcgfttHemOU+DpHQ7EEfAYnEdoe1UJfxc2sk
         A0kthGwJ7QKTrOdQEKS4JAViEvlv5C7trtTLedyaySjodl/liolDvHUDKIetuIujmQ
         OtA3wBq3T7SvvMSqE4Vr5E9l3CmP5aqn3WPTWF2rzOpjx6lsxj9l5FoaENZr+pgaE4
         couMnWNctPAJA==
Date:   Thu, 8 Dec 2022 09:37:48 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 10/18] x86/sgx: Add option to ignore age of page
 during EPC reclaim
Message-ID: <Y5GwbPu4cUs0/4Fi@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-11-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-11-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:46AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add a flag to sgx_reclaim_pages() to instruct it to ignore the age of
> page, i.e. reclaim the page even if it's young.  The EPC cgroup will use
> the flag to enforce its limits by draining the reclaimable lists before
> resorting to other measures, e.g. forcefully reclaimable "unreclaimable"
> pages by killing enclaves.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 46 +++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index a4a65eadfb79..db96483e2e74 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -31,6 +31,10 @@ static DEFINE_XARRAY(sgx_epc_address_space);
>   * with sgx_global_lru.lock acquired.
>   */
>  static struct sgx_epc_lru_lists sgx_global_lru;

Please, separate these by an empty line.

> +static inline struct sgx_epc_lru_lists *sgx_lru_lists(struct sgx_epc_page *epc_page)
> +{
> +	return &sgx_global_lru;
> +}

Should be named by the thing it returns, not by the type.

BR, Jarkko
