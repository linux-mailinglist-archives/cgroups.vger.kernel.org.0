Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90754647327
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiLHPd2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 10:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiLHPdH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 10:33:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB90AD98F;
        Thu,  8 Dec 2022 07:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A4CE61F81;
        Thu,  8 Dec 2022 15:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C4C433C1;
        Thu,  8 Dec 2022 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670513504;
        bh=WZTPhqweYb/o6ohDAJocfkA2T1w/HsjxsO2NnvlkgdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kscGXX+bagLK+Geq93D1CijqPItQ/7f7ftpfSh/tZtfprhKu5Q2x0/FeeQuT7yuac
         j8wTZVA47CE//1Xy7LszG7CNWIXF4LrXf3GUUfQ021xIK5P2m56u9aXHuel30JK+lU
         rJBOrA/6o1BN8bqjjMtDEZ+BPC+M/2r2DCYLTOACAugpWB6CcKO+AQS4CJUmDX5FOv
         0+rGZv3NADk+PapxLVsWnEFWTp1fZvf6Lyt3Czf9sYo6A0ARdrDVY/TM5KZSZ733E/
         UYG1/FXw5pUGZzTt6n23kKFkpHEsUjeDI5c1Vau7JU6QqTBwYwGwiVNFev4a7/RvzR
         NIh65xjOZciPA==
Date:   Thu, 8 Dec 2022 15:31:40 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 03/18] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
Message-ID: <Y5IDXF+6GmURxbYF@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-4-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-4-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:39AM -0800, Kristen Carlson Accardi wrote:
> Introduce a data structure to wrap the existing reclaimable list
> and its spinlock in a struct to minimize the code changes needed
> to handle multiple LRUs as well as reclaimable and non-reclaimable
> lists, both of which will be introduced and used by SGX EPC cgroups.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/sgx.h | 65 +++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index 39cb15a8abcb..5e6d88438fae 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -90,6 +90,71 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
>  	return section->virt_addr + index * PAGE_SIZE;
>  }
>  
> +/*
> + * This data structure wraps a list of reclaimable EPC pages, and a list of
> + * non-reclaimable EPC pages and is used to implement a LRU policy during
> + * reclamation.
> + */
> +struct sgx_epc_lru_lists {
> +	spinlock_t lock;
> +	struct list_head reclaimable;
> +	struct list_head unreclaimable;
> +};
 
Why this is named like this, and not sgx_epc_global_rcu? Are there
any other use cases?

BR, Jarkko
