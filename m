Return-Path: <cgroups+bounces-1222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC70A83948D
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 17:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA4F28A702
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781564A8A;
	Tue, 23 Jan 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SB7sFiAG"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A446281F;
	Tue, 23 Jan 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026760; cv=none; b=q+feC5LvqDJDadZyXqsBl3vdfr1t8kYsmIXKD6p5lc4KQOp/n/twVr81N6RXpWP33JDWBdSB/s3gsfN53VcuhsbuEFAD25fOOs4F/C81bhQkQYtUoapZdtxF7VeAHfvMFg0be27SgFYGU6JIs7fv+1dc5BeZ4eTB0O7jKzIQm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026760; c=relaxed/simple;
	bh=/ApKXRNT1KVzfZ6kukPu6+bsMy5rMlGsIXDqu39eeD0=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=LJud2HBqPv4ydoSrakrUPjIiE1TWPfOMbLEF8FxES0CeJoQD5mCXFK7C6ktNbdtMJ3ord5jFh09v0rg4thpqj1LoSKe2iCDfIXjVICGBRtqzARDCkBVEG2/WEBahIxPuvKaLQHTuTXjBVLBrWUS9degV8AUAfjmhBgKQFjxvYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SB7sFiAG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706026758; x=1737562758;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=/ApKXRNT1KVzfZ6kukPu6+bsMy5rMlGsIXDqu39eeD0=;
  b=SB7sFiAGg2GIzzEjnxSQT/Wbv3WaQhF3gTN9j48AZG7Z9sN8UOpPfPcQ
   MNZo8y8EeJcUl9bbf6dz/jLy3rxuXOCNmJSGhdh3bGI8d1sTr+kmigTom
   u4To5fIQj3t4vMB/yikFB1xz5hWDXr5XFPXtwH88XcS7TQb4xdHMNWmfF
   +tIWcHqxxrTzTGmcmwFzgpeX90vvm6EC36lnfrAMG6MgsifD1eYptvHhM
   wgJ2uk97X0LJv9OTWfOOQ6B041IvI13ncvrPiqayyL8Gzy80HZdbLcEg6
   BlXlIQOrICXzdzxCZrb8fGLGMDF4jCygJMOrVgKIk2NNRIJnIDVbGOqJg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15086993"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="15086993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 08:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="34455278"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 23 Jan 2024 08:19:15 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com
Subject: Re: [PATCH v7 01/15] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-2-haitao.huang@linux.intel.com>
 <CYLIDNAH2GKZ.2GZXE5Z7EXKSI@suppilovahvero>
Date: Tue, 23 Jan 2024 10:19:11 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2h0cx9pdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CYLIDNAH2GKZ.2GZXE5Z7EXKSI@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 22 Jan 2024 14:14:01 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Jan 22, 2024 at 7:20 PM EET, Haitao Huang wrote:
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
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V7:
>> - Make ops one per resource type and store them in array (Michal)
>> - Rename the ops struct to misc_res_ops, and enforce the constraints of  
>> required callback
>> functions (Jarkko)
>> - Moved addition of priv field to patch 4 where it was used first.  
>> (Jarkko)
>>
>> V6:
>> - Create ops struct for per resource callbacks (Jarkko)
>> - Drop max_write callback (Dave, Michal)
>> - Style fixes (Kai)
>> ---
>>  include/linux/misc_cgroup.h | 11 +++++++
>>  kernel/cgroup/misc.c        | 60 +++++++++++++++++++++++++++++++++++--
>>  2 files changed, 68 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
>> index e799b1f8d05b..0806d4436208 100644
>> --- a/include/linux/misc_cgroup.h
>> +++ b/include/linux/misc_cgroup.h
>> @@ -27,6 +27,16 @@ struct misc_cg;
>>
>>  #include <linux/cgroup.h>
>>
>> +/**
>> + * struct misc_res_ops: per resource type callback ops.
>> + * @alloc: invoked for resource specific initialization when cgroup is  
>> allocated.
>> + * @free: invoked for resource specific cleanup when cgroup is  
>> deallocated.
>> + */
>> +struct misc_res_ops {
>> +	int (*alloc)(struct misc_cg *cg);
>> +	void (*free)(struct misc_cg *cg);
>> +};
>> +
>>  /**
>>   * struct misc_res: Per cgroup per misc type resource
>>   * @max: Maximum limit on the resource.
>> @@ -56,6 +66,7 @@ struct misc_cg {
>>
>>  u64 misc_cg_res_total_usage(enum misc_res_type type);
>>  int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
>> +int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops  
>> *ops);
>>  int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,  
>> u64 amount);
>>  void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64  
>> amount);
>>
>> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
>> index 79a3717a5803..b8c32791334c 100644
>> --- a/kernel/cgroup/misc.c
>> +++ b/kernel/cgroup/misc.c
>> @@ -39,6 +39,9 @@ static struct misc_cg root_cg;
>>   */
>>  static u64 misc_res_capacity[MISC_CG_RES_TYPES];
>>
>> +/* Resource type specific operations */
>> +static const struct misc_res_ops *misc_res_ops[MISC_CG_RES_TYPES];
>> +
>>  /**
>>   * parent_misc() - Get the parent of the passed misc cgroup.
>>   * @cgroup: cgroup whose parent needs to be fetched.
>> @@ -105,6 +108,36 @@ int misc_cg_set_capacity(enum misc_res_type type,  
>> u64 capacity)
>>  }
>>  EXPORT_SYMBOL_GPL(misc_cg_set_capacity);
>>
>> +/**
>> + * misc_cg_set_ops() - set resource specific operations.
>> + * @type: Type of the misc res.
>> + * @ops: Operations for the given type.
>> + *
>> + * Context: Any context.
>> + * Return:
>> + * * %0 - Successfully registered the operations.
>> + * * %-EINVAL - If @type is invalid, or the operations missing any  
>> required callbacks.
>> + */
>> +int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops  
>> *ops)
>> +{
>> +	if (!valid_type(type))
>> +		return -EINVAL;
>> +
>> +	if (!ops->alloc) {
>> +		pr_err("%s: alloc missing\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!ops->free) {
>> +		pr_err("%s: free missing\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	misc_res_ops[type] = ops;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(misc_cg_set_ops);
>> +
>>  /**
>>   * misc_cg_cancel_charge() - Cancel the charge from the misc cgroup.
>>   * @type: Misc res type in misc cg to cancel the charge from.
>> @@ -383,23 +416,37 @@ static struct cftype misc_cg_files[] = {
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
>> +		if (misc_res_ops[i]) {
>> +			ret = misc_res_ops[i]->alloc(cg);
>> +			if (ret)
>> +				goto alloc_err;
>
> So I'd consider pattern like this to avoid repetition:
>
> 			if (ret) {
> 				__misc_cg_free(cg);
> 				return PERR_PTR(ret);
> 			}
>
> and call __misc_cg_free() also in misc_cg_free().
>
Will change to do that.
Thanks
Haitao

