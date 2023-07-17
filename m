Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEBC75640A
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGQNOk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 09:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQNOk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 09:14:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44711C7;
        Mon, 17 Jul 2023 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599679; x=1721135679;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=WXAAajyq7RVwSRDzE/5hqXM57XC+7i9ZvN34rS3CqAg=;
  b=YXzQdiEr2vtr6RoAmwmzKNNKFAebqPY8Lvj0Xvk3ad6W7GDIu7ASKxu/
   m9wFW3Zdhk9Y5fw9KPmOKvuK9L+q+p/3KjP3EyoQ4vGBBqmGlAuX1LXMt
   jHabnfE1QOfOMp9kDrNcofL1K5HCpVbQJXDdiR29nfSEOBa1vjlvPv8kz
   10Sxxr42K4nrzjm0FsLLFdrmMgiDwZPaKbd5QA67Mm6eOwS/6fgIX6jK7
   J6oi6GKEAUQykH0q1T6+5qJw3zpkx1nVEPBBTXILTVOJPNerEFXQb8IAM
   LppHtpXrm7DWSbo/K3XcIdpJaZ83AMnH7kqBbnB4WemmKJO0MXhdsye8M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432095354"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432095354"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="717230049"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="717230049"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Jul 2023 06:14:34 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, cgroups@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v3 17/28] x86/sgx: fix a NULL pointer
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-18-haitao.huang@linux.intel.com>
 <CU4GJG1NRTUD.275UVHM8W2VED@seitikki> <CU4GKARPLGU5.1CVBNY9N4K28F@seitikki>
Date:   Mon, 17 Jul 2023 08:14:30 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.1779qgkdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CU4GKARPLGU5.1CVBNY9N4K28F@seitikki>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 17 Jul 2023 07:49:27 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Jul 17, 2023 at 12:48 PM UTC, Jarkko Sakkinen wrote:
>> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
>> > Under heavy load, the SGX EPC reclaimers (ksgxd or future EPC cgroup
>> > worker) may reclaim SECS EPC page for an enclave and set
>> > encl->secs.epc_page to NULL. But the SECS EPC page is required for  
>> EAUG
>> > in #PF handler and is used without checking for NULL and reloading.
>> >
>> > Fix this by checking if SECS is loaded before EAUG and load it if it  
>> was
>> > reclaimed.
>> >
>> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>>
>> A bug fix should be 1/*.
>
> And a fixes tag.
>
> Or is there a bug that is momentized by the earlier patches? This patch
> feels confusing to say the least.
>

It happens in heavy reclaiming cases, just extremely rare when EPC  
accounting is not partitioned into cgroups. Will add fix tag with the  
related EDMM patch. And move this as the first patch.

Thanks
Haitao

