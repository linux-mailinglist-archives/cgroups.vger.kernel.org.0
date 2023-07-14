Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86091754388
	for <lists+cgroups@lfdr.de>; Fri, 14 Jul 2023 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjGNUBn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jul 2023 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjGNUBm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jul 2023 16:01:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11636E5C;
        Fri, 14 Jul 2023 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689364899; x=1720900899;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Lj8vg8jOLaTsAXgSd3nRi5F4zpkFRbSIEM4qtfnHOws=;
  b=cfLVZ4eqHzOIGdPJ/UY03nKCHQgerGBRuHEC+aq5YilvzHEgDSIPerUy
   p5LMB98Et8abcw/1oOLjJcYSkfYk8X83iJlG8WNRjwFvA4ZTZ93nTvi/M
   lBMkoAZxq3IBJgPNRebFh+CpcfiQpfO1g0HqOiHsgsZ7Lk46O6K6syDBs
   e0rHhuQS/Ld1foBoTAUDK68eeMO40V5lHxrr1eowjW7rfu8EUZRYK0ew+
   ou66mUsW2QiONrkq6TeMbE/hlXultsJCbmH8DVDoPMz30LEOSvz9BIpN1
   4M4K9JU+e7rH7mf4JFA4Yd4dhjVQgHPXUOqzliJBcXFiCb9w8mQldhHg+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="365603460"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="365603460"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="672820930"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="672820930"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.18.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 14 Jul 2023 13:01:33 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Randy Dunlap" <rdunlap@infradead.org>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        zhiquan1.li@intel.com, seanjc@google.com, bagasdotme@gmail.com,
        linux-doc@vger.kernel.org, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com
Subject: Re: [PATCH v3 22/28] Docs/x86/sgx: Add description for cgroup support
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-23-haitao.huang@linux.intel.com>
 <f0dddc1a-6070-7e11-0458-b0db1f5ea671@infradead.org>
Date:   Fri, 14 Jul 2023 15:01:32 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.1728kukvwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <f0dddc1a-6070-7e11-0458-b0db1f5ea671@infradead.org>
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

On Wed, 12 Jul 2023 19:10:59 -0500, Randy Dunlap <rdunlap@infradead.org>  
wrote:

>> +
>> +
>> +Cgroup Support
>> +==============
>> +
>> +The "sgx_epc" resource within the Miscellaneous cgroup controller  
>> regulates
>> +distribution of SGX EPC memory, which is a subset of system RAM that
>> +is used to provide SGX-enabled applications with protected memory,
>> +and is otherwise inaccessible, i.e. shows up as reserved in
>> +/proc/iomem and cannot be read/written outside of an SGX enclave.
>> +
>> +Although current systems implement EPC by stealing memory from RAM,
>> +for all intents and purposes the EPC is independent from normal system
>> +memory, e.g. must be reserved at boot from RAM and cannot be converted
>> +between EPC and normal memory while the system is running.  The EPC is
>> +managed by the SGX subsystem and is not accounted by the memory
>> +controller.  Note that this is true only for EPC memory itself, i.e.
>> +normal memory allocations related to SGX and EPC memory, e.g. the
>> +backing memory for evicted EPC pages, are accounted, limited and
>> +protected by the memory controller.
>> +
>> +Much like normal system memory, EPC memory can be overcommitted via
>> +virtual memory techniques and pages can be swapped out of the EPC
>> +to their backing store (normal system memory allocated via shmem).
>> +The SGX EPC subsystem is analogous to the memory subsytem, and
>> +it implements limit and protection models for EPC memory.
>> +
>> +SGX EPC Interface Files
>> +-----------------------
>> +
>> +For a generic description of the Miscellaneous controller interface
>> +files, please see Documentation/admin-guide/cgroup-v2.rst
>> +
>> +All SGX EPC memory amounts are in bytes unless explicitly stated
>> +otherwise.  If a value which is not PAGE_SIZE aligned is written,
>> +the actual value used by the controller will be rounded down to
>> +the closest PAGE_SIZE multiple.
>> +
>> +  misc.capacity
>> +        A read-only flat-keyed file shown only in the root cgroup.
>> +        The sgx_epc resource will show the total amount of EPC
>> +        memory available on the platform.
>> +
>> +  misc.current
>> +        A read-only flat-keyed file shown in the non-root cgroups.
>> +        The sgx_epc resource will show the current active EPC memory
>> +        usage of the cgroup and its descendants. EPC pages that are
>> +        swapped out to backing RAM are not included in the current  
>> count.
>> +
>> +  misc.max
>> +        A read-write single value file which exists on non-root
>> +        cgroups. The sgx_epc resource will show the EPC usage
>> +        hard limit. The default is "max".
>> +
>> +        If a cgroup's EPC usage reaches this limit, EPC allocations,
>> +        e.g. for page fault handling, will be blocked until EPC can
>> +        be reclaimed from the cgroup.  If EPC cannot be reclaimed in
>> +        a timely manner, reclaim will be forced, e.g. by ignoring LRU.
>> +
>> +  misc.events
>> +	A read-write flat-keyed file which exists on non-root cgroups.
>> +	Writes to the file reset the event counters to zero.  A value
>> +	change in this file generates a file modified event.
>> +
>> +	  max
>> +		The number of times the cgroup has triggered a reclaim
>> +		due to its EPC usage approaching (or exceeding) its max
>> +		EPC boundary.
>
> The indentation here (above) is a little confusing.
> Is this formatted the way that is intended?
>
max here is an entry in the misc.events file. So it needs be indented a  
subsection.
But I see spaces are used for indentation in sections above(misc.max,  
misc.current and misc.capacity), and tabs are used in this section. So I  
think maybe that's causing the confusing?
I'll fix them using all tabs.

Thanks
Haitao
