Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F375BC8A
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 04:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGUCso (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 22:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUCsn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 22:48:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DACC;
        Thu, 20 Jul 2023 19:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689907722; x=1721443722;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=XKjWZfAaaEnKwxsr5tOMCJ5LqOzSg2spiv8E+t92fOw=;
  b=TS/CyM6o0KCtj7nPPsuesZzwRP1czDuKGKv5Awn3uUuk57lh0ZPVHxqD
   m92P1it0v+MIyh6jAfkXPz/WBu6C80NjWAxNFb/3TTC7waUyT+JxKd+N5
   xnbNH7LieWUs+uXgC0B0fRdL7Zs3zUwvEd2Te3crFBsjDbJOuOY0BDdnY
   83ThfpgeGfX5E+qlWkIjchq6gtjAojNN4zZNjUi9MnbhRtcdYffznDRAF
   4HMcOn1cuB2G/M9LoLr0rmzaG5KF/huZhftoLH9Ez4czrCt6GXpOgvTyo
   yPKt7TZ3Vqa6wJYw9qgdNJqirzSK68Q7MOVmnu1FUf9of/rPlecXRFied
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="430719046"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="430719046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 19:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724686849"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724686849"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 20 Jul 2023 19:48:40 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Tejun Heo" <tj@kernel.org>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, "Zefan Li" <lizefan.x@bytedance.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>, vipinsh@google.com,
        kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: Re: [PATCH 2/2] cgroup/misc: Change counters to be explicit 64bit
 types
References: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
 <20230718010845.35197-1-haitao.huang@linux.intel.com>
 <20230718010845.35197-2-haitao.huang@linux.intel.com>
 <ZLcXmvDKheCRYOjG@slm.duckdns.org>
Date:   Thu, 20 Jul 2023 21:48:39 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18evfdcdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ZLcXmvDKheCRYOjG@slm.duckdns.org>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi
On Tue, 18 Jul 2023 17:52:10 -0500, Tejun Heo <tj@kernel.org> wrote:

> On Mon, Jul 17, 2023 at 06:08:45PM -0700, Haitao Huang wrote:
>> So the variables can account for resources of huge quantities even on
>> 32-bit machines.
>>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>
> Applied to cgroup/for-6.6 with some whitespace adjustments. I think the  
> code
> is broken when we cross the signed boundary but that's not a new problem
> caused by your patch. I think what we should do is to treat atomic64_t  
> reads
> as u64 instead of putting it in s64.
>

Thanks. I think you meant the 'new_usage' in try_charge.
I'll send a patch.
BR
Haitao
