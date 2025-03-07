Return-Path: <cgroups+bounces-6899-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61DA57100
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 20:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337713B8F09
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61024A051;
	Fri,  7 Mar 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/7+0u34"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F823BD0C
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374017; cv=none; b=fWr8Uv7S+CoK+3I4gCvJhRn0l5D25kWrUyn+bCwdRznDTlXXepvboDNN7HPLh7fOhX2eGBiwzmziIi0BjZThG6aSl+Hbek2102+T6d/PIQIDAIC3Ce6p6nIX6lru+QAxxWoXj/00f5EWbWyEi5asGVKfW3vmDSFvxO9zniyNEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374017; c=relaxed/simple;
	bh=gEdITdBQkxBcEo+xf0PTFVBaDxaG0wYNsG1JOV1teRc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z5A+7V+EuLjIFP/oBczT0sqYGeaB+lEgFxw3jWfIGGAdQKn7H+vnBty1PR2lJecwDjgOO4B8l3UiOu6RZw0TUg/zZoWIwwmGItP54HKuF/AAhf4AdReED/oIfUKkvt0smCfdNtP0IyoXVFvRynLUsGgFf0ADk7qDlLnmO7u4N8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/7+0u34; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741374015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGL2mElf4pWcuuOVu/32c+R0ECrqVcIsm2yeFgp2v0k=;
	b=c/7+0u34WVIYHIR9e9BCCTkLIBbyV97scefF0pN8vEHrBBQkBlBfWqB/De/+0ErzC9UFGq
	r0Kd/t3rU16JElMPXHGIy5uOK39yatiurBmcU6y5bSoD6x5TSOE36sPl2WYdFMkZE5Xz+3
	mlova1UNlLPOAYIusNVIx0MCmT2V6Do=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-YXFtCrK7PGy17vM6CVOtzQ-1; Fri, 07 Mar 2025 14:00:13 -0500
X-MC-Unique: YXFtCrK7PGy17vM6CVOtzQ-1
X-Mimecast-MFC-AGG-ID: YXFtCrK7PGy17vM6CVOtzQ_1741374013
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8993deec9so52460016d6.3
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 11:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741374008; x=1741978808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGL2mElf4pWcuuOVu/32c+R0ECrqVcIsm2yeFgp2v0k=;
        b=EWqNpusoP2/HUJqQUDxKsrzK2TrZ/7ZFZKbBj8GVDGV52tGMkcuVUxhDM9p9bSasOc
         ej01zJLyAyuZuozCBO0eyE8Spk562TiLjeA3MgSrUXU8GjzqEFss/T+3CeGpVJbJayOK
         dmXvyG58Z8pl7w6zs2d0VkGzvD2LskYN/pdmb+TfSCMRXB/YjNo6C4K3TxftUSt6/6kj
         RHMwGDfkJqHpHkrrUgQ1afv+t4f2gy/YpNdK0cmBZluVXmpBm0h1W7OcPADe7x7HNWna
         VBnVYq6sJ+9ESLmJHN0k5nlVjugnj6TW7F4qbKpM/U7yILMUH5ow+LrCwQ4DKU3l/7Wx
         C5nw==
X-Forwarded-Encrypted: i=1; AJvYcCXtYrltBU26bYjGG/hdAVc7++yE9VNBRgu4noqaGV4CSUPRcN24gNwoH9y3T4gzHhLRGF4Nwesh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vtV13WEiyz9aPWJw56pQ0TVDBrEhyyronnsZqQTnRVDf2A25
	+NDwHYGpy4JZDs8QpJXK3+3uYvsQMgQ49ec/037L0UYA56EqLZHusoCK6SukIZqE8Fy4cqxOtM4
	srkYGyxOsExDcjrbiGgsJjlztxNR926ycJJUhFSogW2XRb01XjqLfFFg=
X-Gm-Gg: ASbGncscR3ia+8lkq22iXdT4t7kQ4/cyChHlnUq0LhiJoblDSGUzdO7zd/oP06Q551U
	l3PL9X7DWQLi2NWinYMAi8GoKOa9nT1Mk1mAhrj67VbVu8jbiAs7jFhjY+phnpglCjdrZ+mU6Kd
	ou/Z6Uz3q84cI569joMB1vSMI8nUAd7nk7e9md50LBz3O9AonDnRpS43jApYA/isW11m8SpFCqH
	FC+ZOnnS/HrhYuqUJYjPLQBdoNeRB9RTzKOROEnZFr5QZo1vqvQq0Mhsr/kPzQVeM8SuxS7CjP8
	jkPmp+vm9m6yEHPn0UOYPP1SK8YPADGS6wc2BAgZ8f+JOGT5nvHWXSuPKvw=
X-Received: by 2002:ad4:5f85:0:b0:6e6:64a5:e18d with SMTP id 6a1803df08f44-6e9006060b9mr58690706d6.17.1741374008392;
        Fri, 07 Mar 2025 11:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5N9D50+NdtUHWHhWFcEiZ7MMlPprhjKEs/UhN9BLkC+eLvO3qMbCq10Xpj6qdcevGBpMctg==
X-Received: by 2002:ad4:5f85:0:b0:6e6:64a5:e18d with SMTP id 6a1803df08f44-6e9006060b9mr58690156d6.17.1741374008020;
        Fri, 07 Mar 2025 11:00:08 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b798sm22445896d6.80.2025.03.07.11.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 11:00:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <93c3f9ac-0225-429a-807c-d11c649c819e@redhat.com>
Date: Fri, 7 Mar 2025 14:00:05 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 9:10 AM, Juri Lelli wrote:
> Hello!
>
> Jon reported [1] a suspend regression on a Tegra board configured to
> boot with isolcpus and bisected it to commit 53916d5fd3c0
> ("sched/deadline: Check bandwidth overflow earlier for hotplug").
>
> Root cause analysis pointed out that we are currently failing to
> correctly clear and restore bandwidth accounting on root domains after
> changes that initiate from partition_sched_domains(), as it is the case
> for suspend operations on that board.
>
> This is v2 [2] of the proposed approach to fix the issue. With respect
> to v1, the following implements the approach by:
>
> - 01: filter out DEADLINE special tasks
> - 02: preparatory wrappers to be able to grab sched_domains_mutex on
>        UP (remove !SMP wrappers - Waiman)
> - 03: generalize unique visiting of root domains so that we can
>        re-use the mechanism elsewhere
> - 04: the bulk of the approach, clean and rebuild after changes
> - 05: clean up a now redundant call
> - 06: remove partition_and_rebuild_sched_domains() (Waiman)
> - 07: stop exposing partition_sched_domains_locked (Waiman)
>
> Please test and review. The set is also available at
>
> git@github.com:jlelli/linux.git upstream/deadline/domains-suspend
>
> Best,
> Juri
>
> 1 - https://lore.kernel.org/lkml/ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com/
> 2 - v1 https://lore.kernel.org/lkml/20250304084045.62554-1-juri.lelli@redhat.com
>
> Juri Lelli (8):
>    sched/deadline: Ignore special tasks when rebuilding domains
>    sched/topology: Wrappers for sched_domains_mutex
>    sched/deadline: Generalize unique visiting of root domains
>    sched/deadline: Rebuild root domain accounting after every update
>    sched/topology: Remove redundant dl_clear_root_domain call
>    cgroup/cpuset: Remove partition_and_rebuild_sched_domains
>    sched/topology: Stop exposing partition_sched_domains_locked
>    include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h
>
>   include/linux/cpuset.h         |  5 +++++
>   include/linux/sched.h          |  2 ++
>   include/linux/sched/deadline.h |  7 +++++++
>   include/linux/sched/topology.h | 10 ---------
>   kernel/cgroup/cpuset.c         | 27 +++++++++----------------
>   kernel/sched/core.c            |  4 ++--
>   kernel/sched/deadline.c        | 37 ++++++++++++++++++++--------------
>   kernel/sched/debug.c           |  8 ++++----
>   kernel/sched/rt.c              |  2 ++
>   kernel/sched/sched.h           |  2 +-
>   kernel/sched/topology.c        | 32 +++++++++++++----------------
>   11 files changed, 69 insertions(+), 67 deletions(-)
>
>
> base-commit: 48a5eed9ad584315c30ed35204510536235ce402

I have run my cpuset test and it completed successfully without any issue.

Tested-by: Waiman Long <longman@redhat.com>


