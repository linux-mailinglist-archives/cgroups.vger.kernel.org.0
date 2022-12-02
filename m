Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741B641075
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiLBWPb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiLBWPa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:15:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC0B5D84;
        Fri,  2 Dec 2022 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670019329; x=1701555329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=92uGNmRJkAcu57w2u9eAhtAlnFIYwslsgNeTh2w/P8s=;
  b=jHYIrC2FZXxCgEPS1UltEJXS9yJAr0ZpaAdvHjE3MjfGj2Bu0+CVP6ME
   0E1U037CNfNzFk0uEM+unJrrODtH4dsb01Xr6wrAHwxdsIPa/tlUl6HHl
   y+5VxM+QWkTiTweAODveTjxgmL7tLYODYQOdCuTsvtXXHcfZQHshZFqD9
   Scmw+kZodetL7Of5MukXd5TN30N90QS+6E2EIIZQeykgJe24maEkJ8jjM
   DbfFk2DunMv8vJlwBiAacZLtoOMt9Wgzz3O0NbrHqt85RZizrbHmruBAT
   AIIgjZs2fMAL23Dx8uE0qkcGfuN4fpDl/aR+Y1Hq5hkeh4Nv5PootzT6K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="296414586"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="296414586"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:15:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="647325647"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="647325647"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:15:28 -0800
Message-ID: <371249f3-88b6-0bb0-ac69-0cf28f006da0@intel.com>
Date:   Fri, 2 Dec 2022 14:15:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 06/18] x86/sgx: Introduce RECLAIM_IN_PROGRESS flag for
 EPC pages
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-7-kristen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221202183655.3767674-7-kristen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> When selecting pages to be reclaimed from the page pool (sgx_global_lru),
> the list of reclaimable pages is walked, and any page that is both
> reclaimable and not in the process of being freed is added to a list of
> potential candidates to be reclaimed. After that, this separate list is
> further examined and may or may not ultimately be reclaimed. In order
> to prevent this page from being removed from the sgx_epc_lru_lists
> struct in a separate thread by sgx_drop_epc_page(), keep track of
> whether the EPC page is in the middle of being reclaimed with
> the addtion of a RECLAIM_IN_PROGRESS flag, and do not delete the page
> off the LRU in sgx_drop_epc_page() if it has not yet finished being
> reclaimed.

This never really comes out and tells us what problem is being addressed.
