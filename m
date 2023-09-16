Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D77A2D0D
	for <lists+cgroups@lfdr.de>; Sat, 16 Sep 2023 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbjIPB1d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 21:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbjIPB1P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 21:27:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59042128;
        Fri, 15 Sep 2023 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694827630; x=1726363630;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=LSZ/Ims3Q2WIrfyaa9TBJMUmtRfQrZWhfLJol4CcGBY=;
  b=ZryqysY/1oiPe9J8CU+PFqvz3Ck8IETEaBf6jC9Mvt4JwsvLrULNivj8
   GvDstGNU/5so3AQ3+iYt5ZDDGnYnoxpnxUahtdOkzkrvbcMD5HpDOmL0X
   ObcsUcSeDlYL4qV/J7j6ZdjK+P2lcVWH7krzIlM2dtVXTvWj9Oiwu/ZJ2
   e1HvLCRfq75XXLCZvdzW95M5bwfHs3Sf+AeB0Mh0XFISI3UOpGvEq4wnC
   NveIir9QWgt0ZuLLkLVhvMTrb9Vbs+W3mT69r8p2Sw/MhTORW1DU6HYQi
   f8bUHgH5aqZZVutPw/uOiRwlcGniMVqMuln2xPrIT/RAF/YwDRn7uavdc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465734052"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="465734052"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 18:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="888407621"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="888407621"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Sep 2023 18:26:31 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Tejun Heo" <tj@kernel.org>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
        yangjie@microsoft.com
Subject: Re: [PATCH v4 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-2-haitao.huang@linux.intel.com>
 <ZQSaoXBg-X4cwFdX@mtj.duckdns.org> <ZQSbM9ItXVyeIU7F@mtj.duckdns.org>
Date:   Fri, 15 Sep 2023 20:27:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2bcbngvpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ZQSbM9ItXVyeIU7F@mtj.duckdns.org>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 15 Sep 2023 12:58:11 -0500, Tejun Heo <tj@kernel.org> wrote:

> On Fri, Sep 15, 2023 at 07:55:45AM -1000, Tejun Heo wrote:
>> On Tue, Sep 12, 2023 at 09:06:18PM -0700, Haitao Huang wrote:
>> > @@ -37,6 +37,11 @@ struct misc_res {
>> >  	u64 max;
>> >  	atomic64_t usage;
>> >  	atomic64_t events;
>> > +
>> > +	/* per resource callback ops */
>> > +	int (*misc_cg_alloc)(struct misc_cg *cg);
>> > +	void (*misc_cg_free)(struct misc_cg *cg);
>> > +	void (*misc_cg_max_write)(struct misc_cg *cg);
>>
>> A nit about naming. These are already in misc_res and cgroup_ and cgrp_
>> prefixes are a lot more common. So, maybe go for sth like cgrp_alloc?
>
> Ah, never mind about the prefix part. misc is using cg_ prefix widely
> already.
>


Change them to plain alloc, free, max_write? As they are per resource  
type, not per cgroup.
Also following no-prefix naming scheme like "open" for fops, vma_ops, etc.

Thanks for your review.

Haitao
