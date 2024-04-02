Return-Path: <cgroups+bounces-2278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70BA895AB1
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF301C24323
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249815A4A3;
	Tue,  2 Apr 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpaWjP7B"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A2156F33;
	Tue,  2 Apr 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079103; cv=none; b=ls5CeWkt5HBSlZhFKLbdXeMqSQ71RzXzC9h13Zm7rfZmpZEidfNYocyfxamL1h9wIBzVl31VpMNeU1gVKZcVyjc5u9env/URyjdaV+PH9nqynIKYgvAC4BSeXMGrSEw6zriZt/5NILu0aAiqCmd+HsDhWOpRz6ENrFhEglQGVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079103; c=relaxed/simple;
	bh=R83jK+pei7GoedhpFDOHXlUw+k4/j/waYzwaI/yXZ9E=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=agkhksPXm37/p1zpFHaaL3USadRb7bAvbX0Xgf7VHbR0rJJqywB5L/2HHbMcslycuFOMNEqOIICgmGA12ooFi5/jz9ZU/yMy6+PRG6PVAHLm4NqdDZqi2Mxqoo54ztT79pOGT+gTj0o7kUbYBVkJsg/D4xeiMBKJZESmmg3JXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpaWjP7B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712079101; x=1743615101;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=R83jK+pei7GoedhpFDOHXlUw+k4/j/waYzwaI/yXZ9E=;
  b=RpaWjP7BJXfldfIvmMzKaNHnXxppENUoVnxarPX2JBdNt/kjvWtq8HVX
   e5Np3OG3otNxq8oxdP7cWGvyUBQybWjON4rMSKh9H22sfutEftmRizcih
   ZvL/v0yqFCm6DZDF/9tBE5Bes9ycU2c4YQpBNHcYnbl6x0lXLuG9PK1qm
   CPtuRYOequS0vkbTi8bOz7+2xcZaKnQERlDjJryla4dh8BWDbJ6bzyciP
   ItMd4C5rk28WFOLN9MRvNAd+3DMCRPJzYfynyA5wb14mnUxyAby5x2sxJ
   IlT0Oy3tABuzD3mtjxKsvSbzIiWkj4fBUTkTfnVfJSDYCaRL9OMSusxX2
   Q==;
X-CSE-ConnectionGUID: YulYhiNUQIaeTR9Lfm4WoQ==
X-CSE-MsgGUID: WuqoNnMESJ++g6ykzZImig==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7135691"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7135691"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:31:39 -0700
X-CSE-ConnectionGUID: jBxWQHvCSzKolXJhjJjjyg==
X-CSE-MsgGUID: ZXiH4Q3XRaGXu0t67r0oBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18255509"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 02 Apr 2024 10:31:37 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: anakrish@microsoft.com, bp@alien8.de, cgroups@vger.kernel.org,
 chrisyan@microsoft.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kai.huang@intel.com, kristen@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, mikko.ylinen@linux.intel.com, mingo@redhat.com,
 mkoutny@suse.com, seanjc@google.com, sohil.mehta@intel.com,
 tglx@linutronix.de, tim.c.chen@linux.intel.com, tj@kernel.org, x86@kernel.org,
 yangjie@microsoft.com, zhanb@microsoft.com, zhiquan1.li@intel.com
Subject: Re: [PATCH v2] selftests/sgx: Improve cgroup test scripts
References: <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
 <20240402014254.27717-1-haitao.huang@linux.intel.com>
 <D09GVMLN1O4Z.2RXQUH4ZY5IVF@kernel.org>
Date: Tue, 02 Apr 2024 12:31:36 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ll2yyfgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D09GVMLN1O4Z.2RXQUH4ZY5IVF@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 02 Apr 2024 02:43:25 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Tue Apr 2, 2024 at 4:42 AM EEST, Haitao Huang wrote:
>> Make cgroup test scripts ash compatible.
>> Remove cg-tools dependency.
>> Add documentation for functions.
>>
>> Tested with busybox on Ubuntu.
>>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> v2:
>> - Fixes for v2 cgroup
>> - Turn off swapping before memcontrol tests and back on after
>> - Add comments and reformat
>> ---
>>  tools/testing/selftests/sgx/ash_cgexec.sh     |  57 ++++++
>>  .../selftests/sgx/run_epc_cg_selftests.sh     | 187 +++++++++++-------
>>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +-
>>  3 files changed, 179 insertions(+), 78 deletions(-)
>>  create mode 100755 tools/testing/selftests/sgx/ash_cgexec.sh
>>
>> diff --git a/tools/testing/selftests/sgx/ash_cgexec.sh  
>> b/tools/testing/selftests/sgx/ash_cgexec.sh
>> new file mode 100755
>> index 000000000000..9607784378df
>> --- /dev/null
>> +++ b/tools/testing/selftests/sgx/ash_cgexec.sh
>> @@ -0,0 +1,57 @@
>> +#!/usr/bin/env sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright(c) 2024 Intel Corporation.
>> +
>> +# Move the current shell process to the specified cgroup
>> +# Arguments:
>> +# 	$1 - The cgroup controller name, e.g., misc, memory.
>> +#	$2 - The path of the cgroup,
>> +#		relative to /sys/fs/cgroup for cgroup v2,
>> +#		relative to /sys/fs/cgroup/$1 for v1.
>> +move_to_cgroup() {
>> +    controllers="$1"
>> +    path="$2"
>> +
>> +    # Check if cgroup v2 is in use
>> +    if [ ! -d "/sys/fs/cgroup/misc" ]; then
>> +        # Cgroup v2 logic
>> +        cgroup_full_path="/sys/fs/cgroup/${path}"
>> +        echo $$ > "${cgroup_full_path}/cgroup.procs"
>> +    else
>> +        # Cgroup v1 logic
>> +        OLD_IFS="$IFS"
>> +        IFS=','
>> +        for controller in $controllers; do
>> +            cgroup_full_path="/sys/fs/cgroup/${controller}/${path}"
>> +            echo $$ > "${cgroup_full_path}/tasks"
>> +        done
>> +        IFS="$OLD_IFS"
>> +    fi
>
> I think that if you could point me to git v10 and all this I could
> then quite easily create test image and see what I get from that.
>
> I will code review the whole thing but this is definitely good
> enough to start testing this series properly! Thanks for the
> effort with this. The payback from this comes after the feature
> is mainline. We have now sort of reference of the usage patterns
> and less layers when we need to debug any possible (likely) bugs
> in the future.
>
> This is definitely to the right direction. I'm just wondering do
> we want to support v1 cgroups or would it make sense support only
> v2?
> BR, Jarkko
>
I can drop v1. I think most distro now support v2.
Created this branch to host these changes so far:  
https://github.com/haitaohuang/linux/tree/sgx_cg_upstream_v10_plus


Thanks
Haitao

