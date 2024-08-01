Return-Path: <cgroups+bounces-4064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC094495D
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 12:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D46B23498
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0316D4C0;
	Thu,  1 Aug 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPeoJ5zb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B93BBE5;
	Thu,  1 Aug 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508534; cv=none; b=uHdW3ctsOOPeec1xN32Ynaq9UMqqiI8AdA7HtDnT1d9IFkTkWHrkRG3ny18CoRTBkO69sAYbtAfyzV8F+H71dbNCSZ6T8BLWKIIobfLrIF6k8lrCHSvM+AKIB5aSciyulmX4k7ztq4l3uwgWJ2tzKznuymj8Ak/up/fcRU7aYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508534; c=relaxed/simple;
	bh=FTOFv8FAFGdvJC8md3mZcio/JkgfWJnUswLaH3sTGG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/wm5VS2IXlMWz+quBxQu/r8m2buOGeoF4k5tZAw115yv/XO/LC1/tpZ7+tpl+fgVCdNfrWU+Uijh6bvlkJkqZPu0Lxdv2/1pPEdlGbKbcTz/1WxZo1RDykye+xeReFJi5VUH11MBFRCLonuWwBsr7IeqEU2ndRt9E8DVMpYaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPeoJ5zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A51DC4AF09;
	Thu,  1 Aug 2024 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722508533;
	bh=FTOFv8FAFGdvJC8md3mZcio/JkgfWJnUswLaH3sTGG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CPeoJ5zbd6feDjrEsdIAG+7qGMeInbIcjgdlQxJFPuN4hOsN9eV0wsEWFph65UyLb
	 0QG0mI8FAQ2tb6U6xzg8Fgaj38jAVg5V+c561skLABCbS/ALjgWlh+1A8i4VdlFqHY
	 +kozrCY1KafV9AZV8g2QEQXX3CeddCM3TwO3GYv36uNnQSH+FIOrP7LjYxLrUuCdZ+
	 ciL/QzPxwqoln7f6MA2EOuQKU6n++6AzRfDduzZ+NfhcRXuKcp6Y+MLD6frTbVJJ1I
	 iYOY+mkhhAcFZZU6/aMQEJE8nOE66NIGSJBKdcSHz640rDxHO1KcYObGgvfuicxISR
	 3Ku1tpzSnCztA==
Message-ID: <2527d5a4-de1f-4c93-b7ee-fdd6fbe2a6f0@kernel.org>
Date: Thu, 1 Aug 2024 12:35:27 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] mm/cgroupv2: memory.min may lead to an OOM error
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, ryan.roberts@arm.com, david@redhat.com,
 shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>
References: <20240801045430.48694-1-ioworker0@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240801045430.48694-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/1/24 06:54, Lance Yang wrote:
> Hi all,
> 
> It's possible to encounter an OOM error if both parent and child cgroups are
> configured such that memory.min and memory.max are set to the same values, as
> is practice in Kubernetes.

Is it a practice in Kubernetes since forever or a recent one? Did it work
differently before?

> Hmm... I'm not sure that whether this behavior is a bug or an expected aspect of
> the kernel design.

Hmm I'm not a memcg expert, so I cc'd some.

> To reproduce the bug, we can follow these command-based steps:
> 
> 1. Check Kernel Version and OS release:
>     
>     ```
>     $ uname -r
>     6.10.0-rc5+

Were older kernels behaving the same?

Anyway memory.min documentations says "Hard memory protection. If the memory
usage of a cgroup is within its effective min boundary, the cgroup’s memory
won’t be reclaimed under any conditions. If there is no unprotected
reclaimable memory available, OOM killer is invoked."

So to my non-expert opinion this behavior seems valid. if you set min to the
same value as max and then reach the max, you effectively don't allow any
reclaim, so the memcg OOM kill is the only option AFAICS?

>     $ cat /etc/os-release
>     PRETTY_NAME="Ubuntu 24.04 LTS"
>     NAME="Ubuntu"
>     VERSION_ID="24.04"
>     VERSION="24.04 LTS (Noble Numbat)"
>     VERSION_CODENAME=noble
>     ID=ubuntu
>     ID_LIKE=debian
>     HOME_URL="<https://www.ubuntu.com/>"
>     SUPPORT_URL="<https://help.ubuntu.com/>"
>     BUG_REPORT_URL="<https://bugs.launchpad.net/ubuntu/>"
>     PRIVACY_POLICY_URL="<https://www.ubuntu.com/legal/terms-and-policies/privacy-policy>"
>     UBUNTU_CODENAME=noble
>     LOGO=ubuntu-logo
>     
>     ```
>     
> 2. Navigate to the cgroup v2 filesystem, create a test cgroup, and set memory settings:
>     
>     ```
>     $ cd /sys/fs/cgroup/
>     $ stat -fc %T /sys/fs/cgroup
>     cgroup2fs
>     $ mkdir test
>     $ echo "+memory" > cgroup.subtree_control
>     $ mkdir test/test-child
>     $ echo 1073741824 > memory.max
>     $ echo 1073741824 > memory.min
>     $ cat memory.max
>     1073741824
>     $ cat memory.min
>     1073741824
>     $ cat memory.low
>     0
>     $ cat memory.high
>     max
>     ```
>     
> 3. Set up and check memory settings in the child cgroup:
>     
>     ```
>     $ cd test-child
>     $ echo 1073741824 > memory.max
>     $ echo 1073741824 > memory.min
>     $ cat memory.max
>     1073741824
>     $ cat memory.min
>     1073741824
>     $ cat memory.low
>     0
>     $ cat memory.high
>     max
>     ```
>     
> 4. Add process to the child cgroup and verify:
>     
>     ```
>     $ echo $$ > cgroup.procs
>     $ cat cgroup.procs
>     1131
>     1320
>     $ ps -ef|grep 1131
>     root        1131    1014  0 10:45 pts/0    00:00:00 -bash
>     root        1321    1131 99 11:06 pts/0    00:00:00 ps -ef
>     root        1322    1131  0 11:06 pts/0    00:00:00 grep --color=auto 1131
>     ```
>     
> 5. Attempt to create a large file using dd and observe the process being killed:
>     
>     ```
>     $ dd if=/dev/zero of=/tmp/2gbfile bs=10M count=200
>     Killed
>     ```
>     
> 6. Check kernel messages related to the OOM event:
>     
>     ```
>     $ dmesg
>     ...
>     [ 1341.112388] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/test,task_memcg=/test/test-child,task=dd,pid=1324,uid=0
>     [ 1341.112418] Memory cgroup out of memory: Killed process 1324 (dd) total-vm:15548kB, anon-rss:10240kB, file-rss:1764kB, shmem-rss:0kB, UID:0 pgtables:76kB oom_score_adj:0
>     ```
>     
> 7. Reduce the `memory.min` setting in the child cgroup and attempt the same large file creation, and then this issue is resolved.
>     
>     ```
>     # echo 107374182 > memory.min
>     # dd if=/dev/zero of=/tmp/2gbfile bs=10M count=200
>     200+0 records in
>     200+0 records out
>     2097152000 bytes (2.1 GB, 2.0 GiB) copied, 1.8713 s, 1.1 GB/s
>     ```
> 
> Thanks,
> Lance
> 


