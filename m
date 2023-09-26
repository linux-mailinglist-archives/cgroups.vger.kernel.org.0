Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5467AE3E9
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 05:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjIZDE3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 23:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIZDE3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 23:04:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA19F;
        Mon, 25 Sep 2023 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695697462; x=1727233462;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=2bxMWcQV7aRui1UuOAzcGKmeuETYed3NCdfqWTKxnPg=;
  b=JPLuIhdHmuourxB5ObKfx0tP7nrIY/angXy3i0My69HXDH6ZwGLyEXie
   E9j6gR6TAPHmTG1WI9aEpPPLcfcqd+RppM+XAJRakBxIsaSLthBHOkmQ0
   QNNEvrYyjzjmHIEEWtrX/wVv8I5GwdpQ8IzbbbX3qTjChjD5e/yHxT6f6
   tJqSkH3uqyUdaW6VNhaOCaA5Pgi7suX7Fs99kLXeT/dGV/dAi1oXa6+bk
   lD+S/QYJou7pUsXg6uvdF2aPt/jBbOogart+NXz3/yjSBAttGkxhK3gDh
   YcFEDf3Z8ZRqNCdk0kZlErMKm8vyjrMppZiNzN4/GCP4dL21orLUaXfgt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366527778"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="366527778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 20:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748646739"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="748646739"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.93.65.124])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 25 Sep 2023 20:04:18 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
 <CVS5XFKKTTUZ.XRMYK1ADHSPG@suppilovahvero>
Date:   Mon, 25 Sep 2023 22:04:17 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2buytfetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CVS5XFKKTTUZ.XRMYK1ADHSPG@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jarkko

On Mon, 25 Sep 2023 12:09:21 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Sat Sep 23, 2023 at 6:06 AM EEST, Haitao Huang wrote:
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
>>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V5:
>> - Remove prefixes from the callback names (tj)
>> - Update commit message (Jarkko)
>>
>> V4:
>> - Moved this to the front of the series.
>> - Applies on cgroup/for-6.6 with the overflow fix for misc.
>>
>> V3:
>> - Removed the released() callback
>> ---
>>  include/linux/misc_cgroup.h |  5 +++++
>>  kernel/cgroup/misc.c        | 32 +++++++++++++++++++++++++++++---
>>  2 files changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
>> index e799b1f8d05b..96a88822815a 100644
>> --- a/include/linux/misc_cgroup.h
>> +++ b/include/linux/misc_cgroup.h
>> @@ -37,6 +37,11 @@ struct misc_res {
>>  	u64 max;
>>  	atomic64_t usage;
>>  	atomic64_t events;
>> +
>> +	/* per resource callback ops */
>> +	int (*alloc)(struct misc_cg *cg);
>> +	void (*free)(struct misc_cg *cg);
>> +	void (*max_write)(struct misc_cg *cg);
>>  };
>>
>>  /**
>> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
>> index 79a3717a5803..62c9198dee21 100644
>> --- a/kernel/cgroup/misc.c
>> +++ b/kernel/cgroup/misc.c
>> @@ -276,10 +276,13 @@ static ssize_t misc_cg_max_write(struct  
>> kernfs_open_file *of, char *buf,
>>
>>  	cg = css_misc(of_css(of));
>>
>> -	if (READ_ONCE(misc_res_capacity[type]))
>> +	if (READ_ONCE(misc_res_capacity[type])) {
>>  		WRITE_ONCE(cg->res[type].max, max);
>> -	else
>> +		if (cg->res[type].max_write)
>> +			cg->res[type].max_write(cg);
>> +	} else {
>>  		ret = -EINVAL;
>> +	}
>>
>>  	return ret ? ret : nbytes;
>>  }
>> @@ -383,23 +386,39 @@ static struct cftype misc_cg_files[] = {
>>  static struct cgroup_subsys_state *
>>  misc_cg_alloc(struct cgroup_subsys_state *parent_css)
>>  {
>> +	struct misc_cg *parent_cg;
>>  	enum misc_res_type i;
>>  	struct misc_cg *cg;
>> +	int ret;
>>
>>  	if (!parent_css) {
>>  		cg = &root_cg;
>> +		parent_cg = &root_cg;
>>  	} else {
>>  		cg = kzalloc(sizeof(*cg), GFP_KERNEL);
>>  		if (!cg)
>>  			return ERR_PTR(-ENOMEM);
>> +		parent_cg = css_misc(parent_css);
>>  	}
>>
>>  	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
>>  		WRITE_ONCE(cg->res[i].max, MAX_NUM);
>>  		atomic64_set(&cg->res[i].usage, 0);
>> +		if (parent_cg->res[i].alloc) {
>> +			ret = parent_cg->res[i].alloc(cg);
>> +			if (ret)
>> +				goto alloc_err;
>> +		}
>>  	}
>>
>>  	return &cg->css;
>> +
>> +alloc_err:
>> +	for (i = 0; i < MISC_CG_RES_TYPES; i++)
>> +		if (parent_cg->res[i].free)
>> +			cg->res[i].free(cg);
>> +	kfree(cg);
>> +	return ERR_PTR(ret);
>>  }
>>
>>  /**
>> @@ -410,7 +429,14 @@ misc_cg_alloc(struct cgroup_subsys_state  
>> *parent_css)
>>   */
>>  static void misc_cg_free(struct cgroup_subsys_state *css)
>>  {
>> -	kfree(css_misc(css));
>> +	struct misc_cg *cg = css_misc(css);
>> +	enum misc_res_type i;
>> +
>> +	for (i = 0; i < MISC_CG_RES_TYPES; i++)
>> +		if (cg->res[i].free)
>> +			cg->res[i].free(cg);
>> +
>> +	kfree(cg);
>>  }
>>
>>  /* Cgroup controller callbacks */
>> --
>> 2.25.1
>
> Since the only existing client feature requires all callbacks, should
> this not have that as an invariant?
>
> I.e. it might be better to fail unless *all* ops are non-nil (e.g. to
> catch issues in the kernel code).
>

These callbacks are chained from cgroup_subsys, and they are defined  
separately so it'd be better follow the same pattern.  Or change together  
with cgroup_subsys if we want to do that. Reasonable?

Thanks
Haitao
