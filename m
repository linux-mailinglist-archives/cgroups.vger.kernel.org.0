Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974217B6B97
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbjJCOaS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbjJCOaQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 10:30:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B31D7;
        Tue,  3 Oct 2023 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696343412; x=1727879412;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=UCQJOYqv97Otv7CHu/YgGsnF34DQhXKpnmZyn56+66U=;
  b=VMrvM8Cv7VaaPHf1EpcL7duora/oBx5Mvin/jI0/pjMw466UNxkbylwj
   a0iBhuSMEyp0+oHUBhb4cE4f0IAnSe9biuQuaGBkfut2wxH12sAFRaduu
   nVdT5uIExE96FPaX8vj6EXFWw7pf9IN3NtpdCHjHJrf6aE0ZPalKqwp0S
   eVXtFYUCZePWRo/0mhCsmiPZrwtNV/D9qot9Dl65Ycfa5YZpX0XuSNSo/
   VjVzGu6jKyfMGvBwGFKvUerfCoSr83jroLgsgMFin8+y7fpLdYaYRpf6Q
   sGBmPvyBF44gpKYNZeKzEbrKTbzCGFrd7aKl0BqULfM3lCGeykuAN9YD6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413798077"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="413798077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082038574"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082038574"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 03 Oct 2023 07:29:49 -0700
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
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
 <8f08f0b0f2b04b90d7cdb7b628f16f9080687c43.camel@intel.com>
Date:   Tue, 03 Oct 2023 09:29:48 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b8s7yzawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <8f08f0b0f2b04b90d7cdb7b628f16f9080687c43.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 27 Sep 2023 04:20:55 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> The misc cgroup controller (subsystem) currently does not perform
>> resource type specific action for Cgroups Subsystem State (CSS) events:
>> the 'css_alloc' event when a cgroup is created and the 'css_free' event
>> when a cgroup is destroyed, or in event of user writing the max value to
>> the misc.max file to set the usage limit of a specific resource
>> [admin-guide/cgroup-v2.rst, 5-9. Misc].
>>
>> Define callbacks for those events and allow resource providers to
>> register the callbacks per resource type as needed. This will be
>> utilized later by the EPC misc cgroup support implemented in the SGX
>> driver:
>> - On css_alloc, allocate and initialize necessary structures for EPC
>> reclaiming, e.g., LRU list, work queue, etc.
>> - On css_free, cleanup and free those structures created in alloc.
>> - On max_write, trigger EPC reclaiming if the new limit is at or below
>> current usage.
>
> Nit:
>
> Wondering why we should trigger EPC reclaiming if the new limit is *at*  
> current
> usage?
>
> I actually don't quite care about why here, but writing these details in  
> the
> changelog may bring unnecessary confusion.  I guess you can just remove  
> all the
> details about what SGX driver needs to do on these callbacks.
>
>
Okay, I'll remove the three bullets on the SGX drive implementation  
details.

Thanks
Haitao
