Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F35E6B69
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIVTEb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVTEa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 15:04:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC15594;
        Thu, 22 Sep 2022 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663873468; x=1695409468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2g2t7Y1D2GeMdWECkMSTYsH2IHHAWTewLjokay44cUo=;
  b=lVUhM/67b/NktYH1cElTNNAcLmaHqBK/v7p2V0sqxRnVrjRpRbPHwWsy
   /INlP+y7iyhtCljW1R3+qTO/yixvewenkJLaxqBUmggseNVOdtIJME/KK
   8HX3WQ6yyGaz2nO1DftLiAZ1dY0AZx7VrLJXEEO5//6R3/K3QdLC6qYP5
   SYFRRyEgwYT6eGLYgfwYFqDQwHPUedm/I4V3vgsjJXUFGIjEW5Omm6bKc
   imca15LruESYQYaEACDmq+L7UUPtjNEEzaJc3F/IgYgnwwF/o5y0DeVk3
   bOX3l7+3PV+07V8mq986xxj3OHRhV3s/wLFnAXojh+sRrVLA8OAV22mwR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362200781"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362200781"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:55:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="653104789"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO [10.209.58.200]) ([10.209.58.200])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:55:37 -0700
Message-ID: <1adb03c8-1274-3898-0677-03015a1f5a5d@intel.com>
Date:   Thu, 22 Sep 2022 11:55:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 03/20] x86/sgx: Track owning enclave in VA EPC pages
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
 <20220922171057.1236139-4-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220922171057.1236139-4-kristen@linux.intel.com>
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
> -struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
> +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
>  {
>  	struct sgx_epc_page *epc_page;
>  	int ret;
> @@ -1218,6 +1219,8 @@ struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
>  		return ERR_PTR(-EFAULT);
>  	}
>  
> +	epc_page->owner = encl;
> +
>  	return epc_page;
>  }

BTW, is there a flag or any other way to tell to what kind of object
->owner points?
