Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF017BAA30
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjJETdp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJETdo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 15:33:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF7AE9;
        Thu,  5 Oct 2023 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696534423; x=1728070423;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=AkXmQnpHWoYF6nWm1cn+DVlsyjxP8MZslasgHj950dc=;
  b=mRq4YxviAt+Pi0dtl7coKL8reXE40KjDer/wcwVSYiaahAmeJ3senyVb
   IbvPV0SOPVOrhzDHfrASGl9vALi1zVvCc8VT4GXLV16hTW7CNbffz4AJQ
   /8YcfEknseblMgCBth+GXXmWSlQNFs+OnHHIusags75HFnf+6ilZH0DZr
   oD9xdaHoklEf7phkEqF3pfuhvjjBBLZ1rfO/T6DyV1/1MZ2zykPPyGnOn
   IL4HRUbWi3d+nmaBHkrl2WGZXKg9HUadelh4hqLIoEtEMBOhVm0KE+JZX
   D5rm8+inqu3SbHcZ0gQgFu+Eoy84NtnU0U6kB+RjfcPkXj5ggZOFd5cU1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363877648"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363877648"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755596090"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755596090"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Oct 2023 12:33:40 -0700
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
Subject: Re: [PATCH v5 15/18] x86/sgx: Prepare for multiple LRUs
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-16-haitao.huang@linux.intel.com>
 <6f71642624812da126b900e94e76a72166d9aecd.camel@intel.com>
Date:   Thu, 05 Oct 2023 14:33:38 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ccwmcljwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <6f71642624812da126b900e94e76a72166d9aecd.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 05 Oct 2023 07:30:46 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> +static inline struct sgx_epc_lru_lists *sgx_lru_lists(struct  
>> sgx_epc_page *epc_page)
>> +{
>> +	return &sgx_global_lru;
>> +}
>> +
>> +static inline bool sgx_can_reclaim(void)
>> +{
>> +	return !list_empty(&sgx_global_lru.reclaimable);
>> +}
>> +
>
> Shouldn't sgx_can_reclaim() also take a 'struct sgx_epc_lru_lists *'?
>
> I thought we also need to check whether a cgroup's LRU lists can be  
> reclaimed?

This is only used to check if any pages reclaimable at the top level in  
this file. Later sgx_epc_cgroup_lru_empty(NULL) is used in this function  
to recursively check all cgroups starting from the root.

Haitao
