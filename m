Return-Path: <cgroups+bounces-1109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB7827D63
	for <lists+cgroups@lfdr.de>; Tue,  9 Jan 2024 04:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BC01C22B17
	for <lists+cgroups@lfdr.de>; Tue,  9 Jan 2024 03:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E4D3FFF;
	Tue,  9 Jan 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEc/OzOn"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE3259D;
	Tue,  9 Jan 2024 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704771453; x=1736307453;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=5jyuMJax7bmYWl+lCmULXdHEsvXolm204ScVfBGcp5Y=;
  b=SEc/OzOnLEFwlyPyVwUszzInE1xla+gQQvqlQQ6VREsAUDZyDsJvA3/u
   GNmGpf4gWsR4LiGJcZxh2+IbOgCaD+bifiv96eQ1IbtbWmSmPkIUEeMgw
   G+bKI7QWFvY/ZOY5o9IolSQhfUsioecfiOxXa7QDd+fffXzk6ZE0amAxP
   3UdtMLWqimbCXLrCv8vYlR6TW0/m/QmLcOB7XyS34uqRFRHvh4pF4NbtN
   OUskKX4XXcYVycUGmdjyI6L3n6K59+1DihKo1O1SEtlJlMXZfdg6SfjKo
   xK1VnbVMKPOeq2tbr1zDySyxsQ+e0W0TA+nnynZ/4gaFZc5hBkjch5la3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5440704"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="5440704"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 19:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="731328961"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="731328961"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 08 Jan 2024 19:37:28 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com
Subject: Re: [PATCH v6 01/12] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-2-haitao.huang@linux.intel.com>
 <CWZO1RHFPIS6.P82WIOYW54YP@kernel.org>
Date: Mon, 08 Jan 2024 21:37:26 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2g9gcoz5wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CWZO1RHFPIS6.P82WIOYW54YP@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 15 Nov 2023 14:25:59 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> The misc cgroup controller (subsystem) currently does not perform
>> resource type specific action for Cgroups Subsystem State (CSS) events:
>> the 'css_alloc' event when a cgroup is created and the 'css_free' event
>> when a cgroup is destroyed.
>>
>> Define callbacks for those events and allow resource providers to
>> register the callbacks per resource type as needed. This will be
>> utilized later by the EPC misc cgroup support implemented in the SGX
>> driver.
>>
>> Also add per resource type private data for those callbacks to store and
>> access resource specific data.
>>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V6:
>> - Create ops struct for per resource callbacks (Jarkko)
>> - Drop max_write callback (Dave, Michal)
>> - Style fixes (Kai)
>> ---
>>  include/linux/misc_cgroup.h | 14 ++++++++++++++
>>  kernel/cgroup/misc.c        | 27 ++++++++++++++++++++++++---
>>  2 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
>> index e799b1f8d05b..5dc509c27c3d 100644
>> --- a/include/linux/misc_cgroup.h
>> +++ b/include/linux/misc_cgroup.h
>> @@ -27,16 +27,30 @@ struct misc_cg;
>>
>>  #include <linux/cgroup.h>
>>
>> +/**
>> + * struct misc_operations_struct: per resource callback ops.
>> + * @alloc: invoked for resource specific initialization when cgroup is  
>> allocated.
>> + * @free: invoked for resource specific cleanup when cgroup is  
>> deallocated.
>> + */
>> +struct misc_operations_struct {
>> +	int (*alloc)(struct misc_cg *cg);
>> +	void (*free)(struct misc_cg *cg);
>> +};
>
> Maybe just misc_operations, or even misc_ops?
>

With Michal's suggestion to make ops per-resource-type, I'll rename this  
misc_res_ops  (I was following vm_operations_struct as example)

>> +
>>  /**
>>   * struct misc_res: Per cgroup per misc type resource
>>   * @max: Maximum limit on the resource.
>>   * @usage: Current usage of the resource.
>>   * @events: Number of times, the resource limit exceeded.
>> + * @priv: resource specific data.
>> + * @misc_ops: resource specific operations.
>>   */
>>  struct misc_res {
>>  	u64 max;
>>  	atomic64_t usage;
>>  	atomic64_t events;
>> +	void *priv;
>
> priv is the wrong patch, it just confuses the overall picture heere.
> please move it to 04/12. Let's deal with the callbacks here.
>

Ok

>> +	const struct misc_operations_struct *misc_ops;
>>  };
>
> misc_ops would be at least consistent with this, as misc_res also has an
> acronym.
>
>>
>>  /**
>> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
>> index 79a3717a5803..d971ede44ebf 100644
>> --- a/kernel/cgroup/misc.c
>> +++ b/kernel/cgroup/misc.c
>> @@ -383,23 +383,37 @@ static struct cftype misc_cg_files[] = {
>>  static struct cgroup_subsys_state *
>>  misc_cg_alloc(struct cgroup_subsys_state *parent_css)
>>  {
>> +	struct misc_cg *parent_cg, *cg;
>>  	enum misc_res_type i;
>> -	struct misc_cg *cg;
>> +	int ret;
>>
>>  	if (!parent_css) {
>> -		cg = &root_cg;
>> +		parent_cg = cg = &root_cg;
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
>> +		if (parent_cg->res[i].misc_ops && parent_cg->res[i].misc_ops->alloc)  
>> {
>> +			ret = parent_cg->res[i].misc_ops->alloc(cg);
>> +			if (ret)
>> +				goto alloc_err;
>
> The patch set only has a use case for both operations defined - any
> partial combinations should never be allowed.
>
> To enforce this invariant you could create a set of operations (written
> out of top of my head):
>
> static int misc_res_init(struct misc_res *res, struct misc_ops *ops)
> {
> 	if (!misc_ops->alloc) {
> 		pr_err("%s: alloc missing\n", __func__);
> 		return -EINVAL;
> 	}
>
> 	if (!misc_ops->free) {
> 		pr_err("%s: free missing\n", __func__);
> 		return -EINVAL;
> 	}
>
> 	res->misc_ops = misc_ops;
> 	return 0;
> }
>
> static inline int misc_res_alloc(struct misc_cg *cg, struct misc_res  
> *res)
> {
> 	int ret;
>
> 	if (!res->misc_ops)
> 		return 0;
> 	
> 	return res->misc_ops->alloc(cg);
> }
>
> static inline void misc_res_free(struct misc_cg *cg, struct misc_res  
> *res)
> {
> 	int ret;
>
> 	if (!res->misc_ops)
> 		return 0;
> 	
> 	return res->misc_ops->alloc(cg);
> }
>
> Now if anything has misc_ops, it will also always have *both* callback,
> and nothing half-baked gets in.
>
> The above loops would be then:
>
> 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
> 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
> 		atomic64_set(&cg->res[i].usage, 0);
> 		ret = misc_res_alloc(&parent_cg->res[i]);
> 		if (ret)
> 			goto alloc_err;
>
> Cleaner and better guards for state consistency. In 04/12 you need to
> then call misc_res_init() instead of direct assignment.
>
> BR, Jarkko

Will combine these with the use of a static operations array suggested by  
Michal.

Thanks
Haitao

