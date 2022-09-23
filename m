Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B25E7B23
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiIWMts (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 08:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiIWMt0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 08:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07FB135730;
        Fri, 23 Sep 2022 05:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB1260F95;
        Fri, 23 Sep 2022 12:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFE6C433C1;
        Fri, 23 Sep 2022 12:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663937364;
        bh=jKlwvRhlqKpZTB/gIibghWfeoMWb/cK+eUxT5ZBJaPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrhvdNPpP+JywPO2T9ln/RgYCZIbIzVq90Mx1nB2fOuCzGy1floh4sLu4wv+NoHNi
         z9HysZ2PnFFUWuZWeHR+IjcNrMaFx8irxsZO4x/aKeXQmRoZyElqN1GuxRhNgQQF8M
         EjnTOloP2xj2W/0uKhzMmth6nznNZIAw+Pb5iSOiAjRWCVf6gSzQGhdwh5AHZZ1mSx
         z63drz+QkBm3dm1tpmWhlMCY1QM1mpLroSEcE59NTY0jmxyHv8OUSfHvB0swyGyj7c
         FoFQFWicf4U0STOGrH8aLmr4G9/81GNq+Q4nroSPTl/oA4osU8REAgSRUWY3uQLrIF
         SnX/XMeHtavAw==
Date:   Fri, 23 Sep 2022 15:49:20 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC PATCH 02/20] x86/sgx: Store EPC page owner as a 'void *' to
 handle multiple users
Message-ID: <Yy2rUH7i05qEoOIx@kernel.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-3-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922171057.1236139-3-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 22, 2022 at 10:10:39AM -0700, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> A future patch will use the owner field for either a pointer to
> a struct sgx_encl, or a struct sgx_encl_page.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/sgx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index 0f2020653fba..5a7e858a8f98 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -33,7 +33,7 @@ struct sgx_epc_page {
>  	unsigned int section;
>  	u16 flags;
>  	u16 poison;
> -	struct sgx_encl_page *owner;
> +	void *owner;
>  	struct list_head list;
>  };
>  
> -- 
> 2.37.3
> 

Conflicts with https://lore.kernel.org/linux-sgx/20220920063948.3556917-1-zhiquan1.li@intel.com/T/#m5c911085eb350df564db2c18e344ce036e269749

BR, Jarkko
