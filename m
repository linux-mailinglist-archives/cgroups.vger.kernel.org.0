Return-Path: <cgroups+bounces-3559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD4929AA3
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8568B28122F
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A93C30;
	Mon,  8 Jul 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6nvNs5R"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAD1C06
	for <cgroups@vger.kernel.org>; Mon,  8 Jul 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720404006; cv=none; b=brNRI0NnV6pf+GtDm8Vbvnh+Yc0s5hfGuQGytbgYCnYTpcdIKirotydR5BsWg9+8/gvYtY5u0zfpmu4qH5e1F/xJrD2+1dWFuLwwh8N60QZlDY4qJ8+hgcuekv1Hfo7XM9m+xx9Lz+1hnSMgXAs6M9g73OqrMsxvVcTIvytLsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720404006; c=relaxed/simple;
	bh=LlA/3GAJ5wvbCSm90yM6sbqlqIJjTgzFZneKVFUtO/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPwgvgmLtffc8IQ0WOOTjE0kMGPWugBrAQAngoLCDi+1OHz56EWYfinezUCt6i43lURzktgzKQB5diOMY/13qyPA5fh8XK8x2AThKfPdi1kOZTKv7Udf8y3fchMSCWR2uuxhGhExVQA4iZMUlRjxcqraRFS7t1j0UCtgZxRgYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6nvNs5R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720404003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSfMHQSmOc5Vh79BFfeAEvzYPOHKnCP9fG6tTA2Zpp0=;
	b=D6nvNs5RfyF2Z2IbArFk1x/qQ2Q/rTEaKtFCHdRpdwm/bl7Fc5UFmcConCO+GNDAX2+Qwr
	pK4vnMtE9kJoQQTpiVqaI7DPKgrj6tpciyCSIykmiTYh8RGDjc6Ncj4RVxexORD5HG6VC0
	ElRSoYxVW7wW8ZixItbg0bct+CcOWPU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-sH3elOerNLK3bvsefJdFwg-1; Sun,
 07 Jul 2024 22:00:00 -0400
X-MC-Unique: sH3elOerNLK3bvsefJdFwg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A415C1956088;
	Mon,  8 Jul 2024 01:59:58 +0000 (UTC)
Received: from [10.22.8.31] (unknown [10.22.8.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C91219560AE;
	Mon,  8 Jul 2024 01:59:56 +0000 (UTC)
Message-ID: <e20fe0dc-a3ef-4f55-a991-6efe1a9ddecd@redhat.com>
Date: Sun, 7 Jul 2024 21:59:55 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cpuset v11 0/2] Add Union-Find and use it to optimize
 cpuset
To: Xavier <xavier_qy@163.com>, tj@kernel.org, mkoutny@suse.com
Cc: akpm@linux-foundation.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org
References: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
 <20240704062444.262211-1-xavier_qy@163.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240704062444.262211-1-xavier_qy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 7/4/24 02:24, Xavier wrote:
> Hi all,
>
> Based on Michal's suggestion, the following changes were made:
> 1. Changed Union-Find to union-find in all places except the title.
> 2. Optimized the logic of the uf_union function.
> 3. Modified places where csa[i]->node.parent was used directly.
>
> To Longman,
> Regarding the modifications for supporting cpuset merging in both cgroup
> v1 and v2, do you mean that you will continue to complete them after my
> patch is merged?
Yes.
>
> Kindly review.
>
> Xavier (2):
>    Union-Find: add a new module in kernel library
>    cpuset: use Union-Find to optimize the merging of cpumasks
>
>   Documentation/core-api/union_find.rst         | 102 ++++++++++++++++
>   .../zh_CN/core-api/union_find.rst             |  87 +++++++++++++
>   MAINTAINERS                                   |   9 ++
>   include/linux/union_find.h                    |  41 +++++++
>   kernel/cgroup/cpuset.c                        | 114 +++++++-----------
>   lib/Makefile                                  |   2 +-
>   lib/union_find.c                              |  49 ++++++++
>   7 files changed, 333 insertions(+), 71 deletions(-)
>   create mode 100644 Documentation/core-api/union_find.rst
>   create mode 100644 Documentation/translations/zh_CN/core-api/union_find.rst
>   create mode 100644 include/linux/union_find.h
>   create mode 100644 lib/union_find.c
>
The patch series looks good to me. However, it is a still major change 
in the domain generation algorithm and it is too late for v6.11. I would 
also like it to spend more time in linux-next as I don't have a good set 
of cgroup v1 test. I will support merging this for v6.12.

Acked-by: Waiman Long <longman@redhat.com>


