Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7458F757141
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 03:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGRBLX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 21:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRBLV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 21:11:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF995;
        Mon, 17 Jul 2023 18:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689642680; x=1721178680;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Lpk4z7Si/3sJDEec7U0+YSQmEoYtkOEGFvzlCcA0Bno=;
  b=YMNzPblQmZLmAEpKO1lvk56hqWN2JrdflBG28OUUGjsMNiHAIfytH919
   UfOpwe2PYttnHpGXTtkFzU6ZcITtBu+JjVgBkEJsE0n9pQs5JaJCsLiaM
   AKu/01FF/LKsxvldrseSIQuggn3rRdnMKatjlzed9fotCiq6wwSnQ1NBD
   uYzSf9yMGGeg5VlulRzsJVDNz90CSqVGZ2T20ONZe9ki4xiUa50IMT8y0
   IF2/PT4fFcC+mNJeK90sMUZ6RN2ZF2D7I4qzEFx+lnekZVUhTd2/4t1yE
   z8zw9S1a1pRYH9+W8PBeVGr4xzHsSg6ascJMhVsqSlN4Yorm2ixJ61Tvx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366117667"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366117667"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="837086405"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="837086405"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Jul 2023 18:11:18 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Tejun Heo" <tj@kernel.org>
Cc:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, "Zefan Li" <lizefan.x@bytedance.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>, vipinsh@google.com,
        kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: Re: [PATCH] cgroup/misc: Fix an overflow
References: <20230717184719.85523-1-haitao.huang@linux.intel.com>
 <CU4OCLEHU1S5.359W394902648@seitikki> <ZLWPN_xyGFrqqJkV@slm.duckdns.org>
 <op.178pr1qewjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <op.178te0tbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
Date:   Mon, 17 Jul 2023 20:11:15 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.1786w1rxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ZLWmdBfcuPUBtk1K@slm.duckdns.org>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi
On Mon, 17 Jul 2023 15:37:08 -0500, Tejun Heo <tj@kernel.org> wrote:

> Hello,
>
> On Mon, Jul 17, 2023 at 03:19:38PM -0500, Haitao Huang wrote:
>> Actually, we are using atomic_long_t for 'current' which is the same  
>> width
>> as long defined by arch/compiler. So new_usage should be long to be
>> consistent?
>
> We can use atomic64_t, right? It's slower on 32bit machines but I think  
> it'd
> be better to guarantee resource counter range than micro-optimizing  
> charge
> operations. None of the current users are hot enough for this to matter  
> and
> if somebody becomes that hot, the difference between atomic_t and  
> atomic64_t
> isn't gonna matter that much. We'd need to batch allocations per-cpu and  
> so
> on.
>
>> ditto for event counter. Only max is plain unsigned long but I think it  
>> is
>> also OK as it only compared with 'current' without any arithmetic ops
>> involved.
>> Did I miss something here?
>
> I'm saying that it'd be better to make everything explicitly 64bit.
>

Thanks for the explanation. I think I got it and sent it as a separate  
patch now just to be sure.
BR
Haitao
