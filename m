Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1FA516B31
	for <lists+cgroups@lfdr.de>; Mon,  2 May 2022 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358566AbiEBH2B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 May 2022 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358534AbiEBH2A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 May 2022 03:28:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2AC15734
        for <cgroups@vger.kernel.org>; Mon,  2 May 2022 00:24:33 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f4so15283350iov.2
        for <cgroups@vger.kernel.org>; Mon, 02 May 2022 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U3yK116U7QtcL5LqxzCgKsq8iaHrCKZT63ym/sXbAKc=;
        b=Bzi+R0R7QaC+1bjX2bo/eUhZOcarNK1lhHQK3BnkDNsZ/YQ2kF65HgubGNE1g9QjAF
         VClt8yFpYSC5oht9s5BVdGzylLx1SGefdWn/yZSkP43v9ZQ/U115ldRP4mIaned4xy+i
         XIOYoMJFeLcWOEhr5AxcXnBEpdEmwdLfO6uO7xJ6U4GX4NaQbgjWU8WH2H/DzUzqOLnG
         Y07pCf3IIYshAUYH77brXREcB5+CeW72v1d84nST1hyzetu4eMbN4GXW/ybvmO2gKA4z
         6cXwi4THka5cWO2I5lnhUndPk6YD5GJn9zIhAtE8MWZojqFyir63YUwehSgoAGHPtqPb
         sMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3yK116U7QtcL5LqxzCgKsq8iaHrCKZT63ym/sXbAKc=;
        b=c14rMpa6Up0RvV0YgD5JCU8V3tyHRjBWG+WppyWHfkLJlM8OoCFfJ82KdLa3ogUGNv
         KagKp6t9GgAeCDTCUNMWzkFAfeUUGlB8nMpAFyejv1VBzsIdbTD3vCfKeLB4f9oX8RGt
         tsz64I0qSU3URgAUFyyjNhZFAf1BIXAHuxDYBRN/UsMyIY+TB1WLJD45e6uLhFjA9Dml
         7IkbY9S7hHLdSubnkxBjsQhfB1D0DVEKaVF9V5B+CG1QQ5DuWC+CQ3lBdbZjXCkE9Td0
         dHF6R81PTTpj4DRLSyazl8NHOsjbU8AZ3iqoK5W8htKsJO8Ts4vRQh3keFccb5eJfKpD
         8C3A==
X-Gm-Message-State: AOAM530A/fnfnGaMroeUNUdM//CpikqGgnpS4+pmGbA16fDge39MkdEL
        eGtGoZ1cAG0KPx1R9LS1ydcmTw==
X-Google-Smtp-Source: ABdhPJxeI2hWA90VpSmXaKqPppDo5J6dwWDCrTz4glAq2DiVVqCq9f3COwPcysvhW/KDXqg9MvY5ZQ==
X-Received: by 2002:a05:6638:2643:b0:323:c3e3:fcec with SMTP id n3-20020a056638264300b00323c3e3fcecmr4517508jat.289.1651476272267;
        Mon, 02 May 2022 00:24:32 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id z7-20020a926507000000b002cde6e352e5sm2494262ilb.47.2022.05.02.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:24:31 -0700 (PDT)
Date:   Mon, 2 May 2022 07:24:28 +0000
From:   Oliver Upton <oupton@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 4/4] KVM: arm64/mmu: count KVM s2 mmu usage in
 secondary pagetable stats
Message-ID: <Ym+HLD/U0wwrxtaB@google.com>
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429201131.3397875-5-yosryahmed@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yosry,

On Fri, Apr 29, 2022 at 08:11:31PM +0000, Yosry Ahmed wrote:
> Count the pages used by KVM in arm64 for stage2 mmu in secondary pagetable
> stats.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 53ae2c0640bc..fc5030307cce 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -92,9 +92,13 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>  static void *stage2_memcache_zalloc_page(void *arg)
>  {
>  	struct kvm_mmu_memory_cache *mc = arg;
> +	void *virt;
>  
>  	/* Allocated with __GFP_ZERO, so no need to zero */
> -	return kvm_mmu_memory_cache_alloc(mc);
> +	virt = kvm_mmu_memory_cache_alloc(mc);
> +	if (virt)
> +		kvm_account_pgtable_pages(virt, +1);

Sorry I didn't say it last time around, would now be a good time to
clean up the funky sign convention of kvm_mod_used_mmu_pages()? Or limit
the funk to just x86 :)

--
Thanks,
Oliver
