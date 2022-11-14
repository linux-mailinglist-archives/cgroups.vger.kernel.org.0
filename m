Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49758628C2C
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKNWiN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKNWiM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:38:12 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C52517AB2;
        Mon, 14 Nov 2022 14:38:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p12so11459938plq.4;
        Mon, 14 Nov 2022 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaW/R8iCCS/1A9BRN+LwDCOTY1xF4tsj+qzK35G6lZo=;
        b=Du8ZgVPp1AWEAef+8v0/Eoa/chpMPJcieUAPGH8sq0fGNMyoeliA2PAtXVrauYlDze
         l7TMbcvmc0PivKE+xSYRMj9EgfCxVDwWln8ZmZjTZQ+5gQIMomP8cQnLLnpb95htQAqj
         FjfXo6JxllvkuUdDkm+lGbsWLqdWI85x5JU7eVDIt+A19yqGA0T0U/x9PhZmkX6ly6HS
         M89z53VsSzEN1gIiVQNvWb9nV56EEl+oyUu+3s4mPsM3twqjZHepWNcwKJC0mHH0ifax
         wrrUwqxlVTpfQhTpIulQnO1RDPDRCle7oJMCeYrXSibwot30ousvSP+0Jk1rgln0LUHD
         y0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaW/R8iCCS/1A9BRN+LwDCOTY1xF4tsj+qzK35G6lZo=;
        b=H7WfudgKgZxpdNXnBa3DrId98Q5t2aSZeIzLQAGnn8KAjR8eqBnSZr7gsHK+r3QLMy
         CEK0bWNThAbEWGn2ySAqAiIrzXfgvUCNVaHo0bJHwSxAK2knjFehoAOp+ejWYnZ9bmpT
         JdQzg8BLjhs8CMyKr1ibBuXfaU0sBWsx/TVtRiGO7ZYfxRX+gyiLpC2nhszFRgM/W3BF
         UCym5KZG5bXj1O9kOjDErNMBgrvOTd1OkHO41NsuxcjT7815Ygb39qWIbpVsb8Va9D1r
         QTU5MrLOYHtdPgWiHBP5Iuu1qXcujnEkiSkWf77ty1SgEq8rrHao58MdRRrAG9lkolkK
         y4lQ==
X-Gm-Message-State: ANoB5pnKX6FTr1oa5Qana9BT1ETx1Rh9tiPwqg7qwIRXp/V2fISOjrnx
        oH++07pYRZRPIryYJItIMLI=
X-Google-Smtp-Source: AA0mqf45mjyLWSp3OLd3HxD0VWWQ807WLHhoje31zIpehijz58V7J05xH0InkmKmt5vo/0NokAcf+Q==
X-Received: by 2002:a17:90b:3d10:b0:212:ed36:fc74 with SMTP id pt16-20020a17090b3d1000b00212ed36fc74mr15995820pjb.172.1668465490674;
        Mon, 14 Nov 2022 14:38:10 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm7235733pfa.9.2022.11.14.14.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:38:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:38:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, zhiquan1.li@intel.com,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 25/26] x86/sgx: Add support for misc cgroup controller
Message-ID: <Y3LDUaQ5fuLCuAhD@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-26-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-26-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:30AM -0800, Kristen Carlson Accardi wrote:
> Implement support for cgroup control of SGX Enclave Page Cache (EPC)
> memory using the misc cgroup controller. EPC memory is independent
> from normal system memory, e.g. must be reserved at boot from RAM and
> cannot be converted between EPC and normal memory while the system is
> running. EPC is managed by the SGX subsystem and is not accounted by
> the memory controller.
> 
> Much like normal system memory, EPC memory can be overcommitted via
> virtual memory techniques and pages can be swapped out of the EPC to
> their backing store (normal system memory, e.g. shmem).  The SGX EPC
> subsystem is analogous to the memory subsytem and the SGX EPC controller
> is in turn analogous to the memory controller; it implements limit and
> protection models for EPC memory.
> 
> The misc controller provides a mechanism to set a hard limit of EPC
> usage via the "sgx_epc" resource in "misc.max". The total EPC memory
> available on the system is reported via the "sgx_epc" resource in
> "misc.capacity".
> 
> This patch was modified from its original version to use the misc cgroup
> controller instead of a custom controller.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

This looks fine from cgroup POV.

Thanks.

-- 
tejun
