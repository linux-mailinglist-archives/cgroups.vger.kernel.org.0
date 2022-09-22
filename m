Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF765E6B4D
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 20:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiIVSyW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 14:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVSyU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 14:54:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C313AF1632;
        Thu, 22 Sep 2022 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663872858; x=1695408858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=18DSOnaBqd0/z4y1LvXCXFY/s8ZUIoakuUNkf0L236A=;
  b=RXKX73PXaFsIleHDlFNSkERG6zoBIGaGwZycBAmgmkaQyJU1Srb2mfBZ
   uC/KV3p6IVkeofFrHmI3QRm6mjLvYGnyG0LedQvaNXnEr3OP63nw311HT
   +lj8FcB0Azl5CfDcBpOWr/Qx3zqndoCdXONaCx2irxY2vhsG52oFAyVhn
   H3IhjkRQdSTyzkYSRSYEk6sJpomGhifeD2nrun/0YCCYXI+gpaazkQxFd
   SBOErP4KObz2ks7VNWGTRWQoMUR5w5FrS2UhmBhqqUDpvuKgmuzZ2/h1d
   aV/8NTFStq3LADqB2n3zMiwPSZOsjMqZGSZ04a7rD6sHvlNIc1t1xCSXb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="386686164"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="386686164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:54:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="653103887"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO [10.209.58.200]) ([10.209.58.200])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:54:17 -0700
Message-ID: <3b0e70bb-6e9d-d5da-8e96-d9a813d5ab3f@intel.com>
Date:   Thu, 22 Sep 2022 11:54:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 02/20] x86/sgx: Store EPC page owner as a 'void *' to
 handle multiple users
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Sean Christopherson <seanjc@google.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-3-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220922171057.1236139-3-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/22/22 10:10, Kristen Carlson Accardi wrote:
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

We normally handle these with a union.  I'd probably do something like
this instead:

-	struct sgx_encl_page *owner;
+	union owner {
+		struct sgx_encl	     *o_encl;
+		struct sgx_encl_page *o_page;
+	}
