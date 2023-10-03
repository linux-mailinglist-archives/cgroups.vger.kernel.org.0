Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA977B61F3
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbjJCHCX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 03:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbjJCHBy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 03:01:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B131FCE;
        Tue,  3 Oct 2023 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316482; x=1727852482;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=C7bs14VoUMvgVSpFL051pm8lwqwqcZ/sI1LfU1fFcrI=;
  b=JxTxvbToHrbpn6svgyw8EaC3ukh+752HkwHOLJAJ8M4HNWXHMmQs6+db
   SeGYGxAg17PVPMhk9nW89yf/JT1SUYpIgGiPk0N0ir6ctlmQAgqPkZPv0
   XXPBj1sVGDlKgAQQiKQEseOrCD+y6eJ29ncwYdnBy4gTHc5ag90bldiMS
   KEbwqC6jvwSLsfy7Ob6eS4CglABqnn52id+dzWvOkqJI+3n4n03tieLCj
   PjUEWb0SEc8VlRLMIJ4RfAgzWt3/9LKCe7fOcDaGoENjrcRhKzgO4Xk6Y
   AuSuGoX0BODuYortWkNgQY8yPldP2k8k4NEq3Ds0rg1qluP3DjJNkPCB+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="363077286"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="363077286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 00:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="866761584"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="866761584"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 03 Oct 2023 00:00:06 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 02/18] cgroup/misc: Add SGX EPC resource type and
 export APIs for SGX driver
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-3-haitao.huang@linux.intel.com>
 <0b24d7ad4de129681a8783f930f48962e572b653.camel@intel.com>
Date:   Tue, 03 Oct 2023 02:00:04 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b78ee0awjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <0b24d7ad4de129681a8783f930f48962e572b653.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 27 Sep 2023 22:59:12 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Add SGX EPC memory, MISC_CG_RES_SGX_EPC, to be a valid resource type
>> for the misc controller.
>>
>> Add per resource type private data so that SGX can store additional per
>> cgroup data in misc_cg->misc_cg_res[MISC_CG_RES_SGX_EPC].
>
> To be honest I don't quite understand why putting the above two changes  
> in this
> patch together with exporting misc_cg_root/parent() below.
>
> Any reason why the above two cannot be done together with patch ("  
> x86/sgx:
> Limit process EPC usage with misc cgroup controller"), where these  
> changes are
> actually related?
>
> We all already know that a new EPC misc cgroup will be added.  There's  
> no need
> to actually introduce the new type here only to justify exporting some  
> helper
> functions.
>

I think previous authors intended to separate all prerequisite misc  
changes from SGX changes.
I can combine them if maintainers are fine with it.

>>
>> Export misc_cg_root() so the SGX driver can initialize and add those
>> additional structures to the root misc cgroup as part of initialization
>> for EPC cgroup support. This bootstraps the same additional
>> initialization for non-root cgroups in the 'alloc()' callback added in  
>> the
>> previous patch.
>>
>> The SGX driver, as the EPC memory provider, will have a background
>> worker to reclaim EPC pages to make room for new allocations in the same
>> cgroup when its usage counter reaches near the limit controlled by the
>> cgroup and its ancestors. Therefore it needs to do a walk from the
>> current cgroup up to the root. To enable this walk, move parent_misc()
>> into misc_cgroup.h and make inline to make this function available to
>> SGX, rename it to misc_cg_parent(), and update kernel/cgroup/misc.c to
>> use the new name.
>
> Looks too many details in the above two paragraphs.  Could we have a more
> concise justification for exporting these two functions?
>

This was added to address Jarkko's question, "why does SGX driver need to  
do iterative walks?"
See: https://lore.kernel.org/all/CVHOU5G1SCUT.RCBVZ3W8G2NJ@suppilovahvero/

> And if it were me, I would put it at a relatively later position (e.g.,  
> before
> the patch actually implements EPC cgroup) for better review.  This also  
> applies
> to the first patch.
>

I was told to move all prerequisites to the front or separate out.

https://lore.kernel.org/linux-sgx/CU4H43P3H35X.1BCA3CE4D1250@seitikki/


