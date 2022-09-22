Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF45E6B80
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 21:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiIVTIH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiIVTIF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 15:08:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38040100A81;
        Thu, 22 Sep 2022 12:08:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so10053856pgb.13;
        Thu, 22 Sep 2022 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=DvLvACHlAehE0+/VISWaqhZ6RLsIF/LLtwXH5V+If6Y=;
        b=I3mXtIhfq/vSa3NTg9CoLzXQ4wtZVzpkQp4NFGSLsGHabPDFNmdDQhjyHZNrA1OgTk
         pWJaRnAyD3Ifad+db9xlYczOmpeVFRVLSh2dfe6AKDry63Lg+WCDmv2K3GfmPfEv2beM
         XTNX3BXFx8VAYtLQpp5zpoPNdxyvFG41hNXWU/9IKYPzIG7jUdXAseS6TR+C1indYYr7
         wEoZwGA7DkPFttTQ0hTeIAKJrzIrBrJEffyEU3na7PJUGkFqejc80iapPhMRAwyA8R9l
         xOBt/YBpqs9lfKSx0R3TmKlOGxft9wmmx7QupyLi+TNkgWF6HCbtudeBA4PnZlK3OxgF
         s3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DvLvACHlAehE0+/VISWaqhZ6RLsIF/LLtwXH5V+If6Y=;
        b=28UZ1UTc+SQBywy0g24VgNqZi8zRE+UKynZ8xN6ri0WTEVRPKA+p4utSuiW+GuAi+1
         z8YY3/NICvum7x3D78gUNYAXVI3pNsPzEyd2azwcAlhRjALrFcsssrot6Ls9S8dxb8Av
         GdkOMPIQtPe8kRYDXXQiK2Wnpr0aZOptZRfBKeYcfaEFpYuMjB4YTVfOS5md8xQFxZlS
         YM4xL+t5UBi1xAip9saRikt7orpvI+yIVh9HLLXZGWokf4Q4NYDLgyNfhVkfBFolav2B
         8w5IAkyUz0EiW//iAjom4CXZWWQ+Hz/+YXnjFSg5RnrsxJFX0UjlM6n4oa/1m7S2eK4W
         +qYA==
X-Gm-Message-State: ACrzQf0Mpr6LC7K0QuoCtVJVQz/xPhQXHxyU/jTMJ2t5+/5K8iJ2Y6ow
        lSgMXcRYtdhKyM0oHK1S3K0=
X-Google-Smtp-Source: AMsMyM7LHAIy4I7fv30uoFplBqBIc93VYZkJZR/ze72izqH9c5B+bkVQdsnkKY3Pw9+o0FEQXVrWdQ==
X-Received: by 2002:a05:6a00:1c98:b0:540:d461:f9d8 with SMTP id y24-20020a056a001c9800b00540d461f9d8mr5137009pfw.29.1663873683096;
        Thu, 22 Sep 2022 12:08:03 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w190-20020a6282c7000000b0053b723a74f7sm4818105pfd.90.2022.09.22.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:08:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 22 Sep 2022 09:08:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
Message-ID: <YyyykUJQtYbPVctn@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <YyyeSVSk/lWdo/W4@slm.duckdns.org>
 <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Sep 22, 2022 at 11:59:14AM -0700, Kristen Carlson Accardi wrote:
> Thanks for your question. The SGX EPC memory is a global shared
> resource that can be over committed. The SGX EPC controller should be
> used similarly to the normal memory controller. Normally when there is
> pressure on EPC memory, the reclaimer thread will write out pages from
> EPC memory to a backing RAM that is allocated per enclave. It is
> possible currently for even a single enclave to force all the other
> enclaves to have their epc pages written to backing RAM by allocating
> all the available system EPC memory. This can cause performance issues
> for the enclaves when they have to fault to load pages page in.

Can you please give more concrete examples? I'd love to hear how the SGX EPC
memory is typically used in what amounts and what's the performance
implications when they get reclaimed and so on. ie. Please describe a
realistic usage scenario of contention with sufficient details on how the
system is set up, what the applications are using the SGX EPC memory for and
how much, how the contention on memory affects the users and so on.

Thank you.

-- 
tejun
