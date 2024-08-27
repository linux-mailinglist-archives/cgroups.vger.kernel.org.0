Return-Path: <cgroups+bounces-4486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FBF95FE77
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 03:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B724CB2114F
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 01:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC888F58;
	Tue, 27 Aug 2024 01:45:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791E10940;
	Tue, 27 Aug 2024 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723125; cv=none; b=npwzUFaXHy3PMgOWRiNAlEtR1pmlmxZ6WrkyNI6g6QE6KMHlmc9/f21G8zN3jZ7dEiZNgvv2uBb8p6YdUTX3eBq74GmCLaLAJdH5dfStWwZM+XulguYv1Onhv8ijZ0OWTPPfYa6DlFqICxzSDudOkADk+TMWid0H6NIAX3Gil5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723125; c=relaxed/simple;
	bh=YcdCXFygTeYZfRSCx3dM34ECi2IF6ufvwaUkWhroW1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKy4UoJsG9ekCr6vEwoDClX752/B+DO7bqSOsYI9by9y967eT3OEIMK7vYXM4aZFVoYuZfNzKI0Ub3Chv1m64MQrkzLBhDktdRsHh2udbDgjZNOczkZ5DMU8dvZfum3oAz2wmq3R0iZhWNyj/RFTUdioW+4DxpuAg3tIHTSds6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wt9Mx4bHlz4f3jjk;
	Tue, 27 Aug 2024 09:45:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 87EF71A15B3;
	Tue, 27 Aug 2024 09:45:11 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgC367qmL81mtwxDCw--.21821S2;
	Tue, 27 Aug 2024 09:45:11 +0800 (CST)
Message-ID: <465d8842-d118-41a8-b571-1f79f32bbe97@huaweicloud.com>
Date: Tue, 27 Aug 2024 09:45:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 01/11] cgroup/cpuset: introduce cpuset-v1.c
To: Waiman Long <longman@redhat.com>, tj@kernel.org, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, adityakali@google.com, sergeh@kernel.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240826132703.558956-1-chenridong@huawei.com>
 <20240826132703.558956-2-chenridong@huawei.com>
 <53f17d71-c710-4720-ada7-8b81afc0c5e1@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <53f17d71-c710-4720-ada7-8b81afc0c5e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC367qmL81mtwxDCw--.21821S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW5GFyrAF1fKFyrZF4DXFb_yoW5uF15pF
	ykGFyrA3y3GF10k34vg3Wv9F95Kw48t3WUG3WqqF1kZF12q3WY9F1q934YgFyUGFs7ur48
	tFsxZrW29r1jq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/8/27 3:07, Waiman Long wrote:
> On 8/26/24 09:26, Chen Ridong wrote:
>> This patch introduces the cgroup/cpuset-v1.c source file which will be
>> used for all legacy (cgroup v1) cpuset cgroup code. It also introduces
>> cgroup/cpuset-internal.h to keep declarations shared between
>> cgroup/cpuset.c and cpuset/cpuset-v1.c.
>>
>> As of now, let's compile it if CONFIG_CPUSET is set. Later on it can be
>> switched to use a separate config option, so that the legacy code 
>> won't be
>> compiled if not required.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   MAINTAINERS                     | 2 ++
>>   kernel/cgroup/Makefile          | 2 +-
>>   kernel/cgroup/cpuset-internal.h | 7 +++++++
>>   kernel/cgroup/cpuset-v1.c       | 4 ++++
>>   4 files changed, 14 insertions(+), 1 deletion(-)
>>   create mode 100644 kernel/cgroup/cpuset-internal.h
>>   create mode 100644 kernel/cgroup/cpuset-v1.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 82e3924816d2..3b5ec1cafd95 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5698,6 +5698,8 @@ S:    Maintained
>>   T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
>>   F:    Documentation/admin-guide/cgroup-v1/cpusets.rst
>>   F:    include/linux/cpuset.h
>> +F:    kernel/cgroup/cpuset-internal.h
>> +F:    kernel/cgroup/cpuset-v1.c
>>   F:    kernel/cgroup/cpuset.c
>>   F:    tools/testing/selftests/cgroup/test_cpuset.c
>>   F:    tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
>> index 12f8457ad1f9..005ac4c675cb 100644
>> --- a/kernel/cgroup/Makefile
>> +++ b/kernel/cgroup/Makefile
>> @@ -4,6 +4,6 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o 
>> freezer.o
>>   obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
>>   obj-$(CONFIG_CGROUP_PIDS) += pids.o
>>   obj-$(CONFIG_CGROUP_RDMA) += rdma.o
>> -obj-$(CONFIG_CPUSETS) += cpuset.o
>> +obj-$(CONFIG_CPUSETS) += cpuset.o cpuset-v1.o
>>   obj-$(CONFIG_CGROUP_MISC) += misc.o
>>   obj-$(CONFIG_CGROUP_DEBUG) += debug.o
>> diff --git a/kernel/cgroup/cpuset-internal.h 
>> b/kernel/cgroup/cpuset-internal.h
>> new file mode 100644
>> index 000000000000..6605be417e32
>> --- /dev/null
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#ifndef __CPUSET_INTERNAL_H
>> +#define __CPUSET_INTERNAL_H
>> +
>> +#endif /* __CPUSET_INTERNAL_H */
>> +
>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> new file mode 100644
>> index 000000000000..ae166eb4f75d
>> --- /dev/null
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -0,0 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +#include "cpuset-internal.h"
>> +
> 
> Don't leave a blank line at the end of a file. You will get the 
> following error when applying the patch.
> 
> 0001-cgroup_cpuset-introduce-cpuset-v1.c.patch:70: new blank line at EOF.
> 
> All your patches except the last one have this problem.
> 
> Cheers,
> Longman

Thank you, will fix it.

Best regards,
Ridong


