Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3827D756E12
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGQUTp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGQUTo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 16:19:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBEF199;
        Mon, 17 Jul 2023 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689625182; x=1721161182;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=S09jmTQ/NZNijcZ2es5DpthxzTjKbOVrCRQMBqh1UUk=;
  b=f5GI2ChHAsI/eYh7FM8FcMTumP5BAQHfsXWe1dQdv56XNEZlJnpeS2RT
   Rpgwbuv9op9jUrpox/BATorW/AX++GGElA+ApM7StOjgNTtCcZsQwrkfp
   XN3k8NgEeB00/+iPy7sivFJP6D7Lt56EHd/coOyv2OIWZuTLvyG52Kk4U
   wLkRDN5Q3iZ224BmZMn52QCA3CHUA2ZESfWnvhr32CtlNOOcZC2hO/Hj7
   e6NQVq4GCOwHcIpsq8i9M8k09Mx+JG8y+p6LI7HLHgVOYARxw1F/7DW94
   mQh79C0SZ4yr+r/Z65eq5xn+FRnNL4ZK3mCJ/KPh+aQqP+57tNEKPBvIg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452404601"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452404601"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 13:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788774525"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788774525"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Jul 2023 13:19:40 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Haitao Huang" <haitao.huang@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, cgroups@vger.kernel.org,
        "Zefan Li" <lizefan.x@bytedance.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>, vipinsh@google.com,
        kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com
Subject: Re: [PATCH] cgroup/misc: Fix an overflow
References: <20230717184719.85523-1-haitao.huang@linux.intel.com>
 <CU4OCLEHU1S5.359W394902648@seitikki> <ZLWPN_xyGFrqqJkV@slm.duckdns.org>
 <op.178pr1qewjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date:   Mon, 17 Jul 2023 15:19:38 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.178te0tbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.178pr1qewjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 17 Jul 2023 14:01:03 -0500, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:

> On Mon, 17 Jul 2023 13:57:59 -0500, Tejun Heo <tj@kernel.org> wrote:
>
>> On Mon, Jul 17, 2023 at 06:55:32PM +0000, Jarkko Sakkinen wrote:
>>> On Mon Jul 17, 2023 at 6:47 PM UTC, Haitao Huang wrote:
>>> > The variable 'new_usage' in misc_cg_try_charge() may overflow if it
>>> > becomes above INT_MAX. This was observed when I implement the new SGX
>>> > EPC cgroup[1] as a misc cgroup and test on a platform with large SGX  
>>> EPC
>>> > sizes.
>>> >
>>> > Change type of new_usage to long from int and check overflow.
>>> >
>>> > Fixes: a72232eabdfcf ("cgroup: Add misc cgroup controller")
>>> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>>> >
>>> > [1]  
>>> https://lore.kernel.org/linux-sgx/20230712230202.47929-1-haitao.huang@linux.intel.com/
>>> > ---
>>> >  kernel/cgroup/misc.c | 6 +++---
>>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
>>> > index fe3e8a0eb7ed..ff9f900981a3 100644
>>> > --- a/kernel/cgroup/misc.c
>>> > +++ b/kernel/cgroup/misc.c
>>> > @@ -143,7 +143,7 @@ int misc_cg_try_charge(enum misc_res_type type,  
>>> struct misc_cg *cg,
>>> >  	struct misc_cg *i, *j;
>>> >  	int ret;
>>> >  	struct misc_res *res;
>>> > -	int new_usage;
>>> > +	long new_usage;
>>> >
>>> >  	if (!(valid_type(type) && cg &&  
>>> READ_ONCE(misc_res_capacity[type])))
>>> >  		return -EINVAL;
>>> > @@ -153,10 +153,10 @@ int misc_cg_try_charge(enum misc_res_type  
>>> type, struct misc_cg *cg,
>>> >
>>> >  	for (i = cg; i; i = parent_misc(i)) {
>>> >  		res = &i->res[type];
>>> > -
>>>
>>> This is extra noise in the patch, please remove the change.
>>
>> Lemme just revert it. Haitao, can you instead make the resource  
>> counters and
>> all related variables explicit 64bit instead?
>>
>
> Will do.

Actually, we are using atomic_long_t for 'current' which is the same width  
as long defined by arch/compiler. So new_usage should be long to be  
consistent?

ditto for event counter. Only max is plain unsigned long but I think it is  
also OK as it only compared with 'current' without any arithmetic ops  
involved.
Did I miss something here?
Thanks
Haitao
