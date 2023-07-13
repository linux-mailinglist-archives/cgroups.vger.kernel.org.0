Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AA7514EB
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 02:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjGMADa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 20:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjGMAD3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 20:03:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8C1FC8;
        Wed, 12 Jul 2023 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cNlYMcVTEfy/fmVD8wCyTrFiHwmY85jTLhb7uGYkAe0=; b=CWrOGiVyZ6xotScp1dFunEvArA
        HpkAOJoRwLPjpPDqE98L4eeGySw9uYJLSkp2yyvIGRVbVFO+SdxdkuoAgbI5lKPdIZO1RAp7gcYHy
        HcA/3JvKWFixTOfSR03gYcpJgcs3NSkXZTcpHvVImevtBIy8X6Cf8PgDYSFVjisSt4V88xk5T0J7J
        y4i7EZ2QYnPa+FgZj2UljbmxCZtyTCVYZTeG51pkgXk1vn2ZQg4vq140MFL00BDzMjJ/M73BTG1/m
        vwZbTOmPpxJ5GcFRIloDi8Nc6Z2CQcylwntNM4hkzVEUD6zmJGIpPY4Px3B2fl/ogxHD4ol13MBU0
        MHVYlvOA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJjnq-001XVa-2a;
        Thu, 13 Jul 2023 00:03:26 +0000
Message-ID: <70cd3d3d-48b0-7570-850a-906a1d960bbd@infradead.org>
Date:   Wed, 12 Jul 2023 17:03:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 21/28] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        zhiquan1.li@intel.com, seanjc@google.com
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-22-haitao.huang@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712230202.47929-22-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 7/12/23 16:01, Haitao Huang wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..8a7378159e9e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1952,6 +1952,19 @@ config X86_SGX
>  
>  	  If unsure, say N.
>  
> +config CGROUP_SGX_EPC
> +	bool "Miscellaneous Cgroup Controller for Enclave Page Cache (EPC) for Intel SGX"
> +	depends on X86_SGX && CGROUP_MISC
> +	help
> +	  Provides control over the EPC footprint of tasks in a cgroup via
> +	  the Miscellaneous cgroup controller.
> +
> +	  EPC is a subset of regular memory that is usable only by SGX
> +	  enclaves and is very limited in quantity, e.g. less than 1%
> +	  of total DRAM.
> +
> +          Say N if unsure.

Use tab + 2 spaces above for indentation, please.

-- 
~Randy
