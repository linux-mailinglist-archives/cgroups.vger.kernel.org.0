Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4407A2DE1
	for <lists+cgroups@lfdr.de>; Sat, 16 Sep 2023 06:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjIPEL5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Sep 2023 00:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbjIPELd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Sep 2023 00:11:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E088A1BD1;
        Fri, 15 Sep 2023 21:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694837487; x=1726373487;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Ocjm2Eh/KArqUPzrkBFSGZbna2Rd/Mr3+qd+5IcYzMg=;
  b=hm53PeNLgISk7VJdD+DxIEMCA2h1q1e4JNWNyU6FVfDSHNGMainxQ/a0
   k7XRP+n7SD/l4PdsWPbdlbdY7Nlk0oOSrtJqrJpDF6Vx8VlBAor9Fuzq+
   e6ASLpo2DqmArUbLaUvXDo5SZountN8EmwvEv/AXLPpuaN5xm8sUazyiB
   A4tZNPBM4JkKMh+L2N5TU3JrqAsoZQMwi0R1kBoykZJQvUS1y1g32eoK3
   X/STtGaQJj5YXt+fhaykOt4IveiGPpP0/22jsY0yedWX3abxATiS8IMLa
   DglhymxuxkhfG9lPBlvySR29mnLUHWa9+A85+Cs2fBMNUuvmj3eJToqcU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="376714351"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="376714351"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 21:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="748403825"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="748403825"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Sep 2023 21:11:25 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v4 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-2-haitao.huang@linux.intel.com>
 <CVHOU5G1SCUT.RCBVZ3W8G2NJ@suppilovahvero>
Date:   Fri, 15 Sep 2023 23:11:24 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2bci9anpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CVHOU5G1SCUT.RCBVZ3W8G2NJ@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jarkko

On Wed, 13 Sep 2023 04:39:06 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Consumers of the misc cgroup controller might need to perform separate
>> actions for Cgroups Subsystem State(CSS) events: cgroup alloc and free.
>
> nit: s/State(CSS)/State (CSS)/
>
> "cgroup alloc" and "cgroup free" mean absolutely nothing.
>
>
>> In addition, writes to the max value may also need separate action. Add
>
> What "the max value"?
>
>> the ability to allow downstream users to setup callbacks for these
>> operations, and call the corresponding per-resource-type callback when
>> appropriate.
>
> Who are "the downstream users" and what sort of callbacks they setup?

How about this?

The misc cgroup controller (subsystem) currently does not perform resource  
type specific action for Cgroups Subsystem State (CSS) events: the  
'css_alloc' event when a cgroup is created and the 'css_free' event when a  
cgroup is destroyed, or in event of user writing the max value to the  
misc.max file to set the consumption limit of a specific resource  
[admin-guide/cgroup-v2.rst, 5-9. Misc].

Define callbacks for those events and allow resource providers to register  
the callbacks per resource type as needed. This will be utilized later by  
the EPC misc cgroup support implemented in the SGX driver:
- On cgroup alloc, allocate and initialize necessary structures for EPC  
reclaiming, e.g., LRU list, work queue, etc.
- On cgroup free, cleanup and free those structures created in alloc.
- On max write, trigger EPC reclaiming if the new limit is at or below  
current consumption.

Thanks
Haitao

