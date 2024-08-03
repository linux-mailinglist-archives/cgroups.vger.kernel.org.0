Return-Path: <cgroups+bounces-4076-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31589469F1
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2024 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E88A281B5D
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB514F9D1;
	Sat,  3 Aug 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhXdJUQ9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988414EC43
	for <cgroups@vger.kernel.org>; Sat,  3 Aug 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693555; cv=none; b=PHmMKnYF5wHCcHPyWCKk424tzVNO6nkDp5Djf9mSfNkBmTgv6tXQLAO0Rw1Z57K6ISX6q6TntTDsrL3gsE0d9CKV78oBgSFDfjvuBUPflmo0gDeTyr6KtdXXVSvQNsWfKSD0j3eCSgtNyA1AUKiScdxnduFUbd3RUfg01LZvzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693555; c=relaxed/simple;
	bh=mkLVXCVtvsYqEZncqittbYiuqAWUMNXxPjor+ZbpaXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js3f8tGPZsx9jYLuoPuysp4r0qXXQv+4BXS1XpFiebzZw1QZe3fkpOTDIYJsmCeLAf5mi75iH5hDNMXXRSL36Mlcx/yVRGQhhZFk7DPwD+Yn+MQ1ngAomnqqjf0nHSGHvRyo8b9L+1iclzIAyo7gaUlda0DCdEQq2usw1LCaxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhXdJUQ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722693552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mLPhQ/MtlB+/ouj1vXRLPvV+K/e1JH2NhKIPSu91PM=;
	b=PhXdJUQ92XlKJooiawcjOBsxvaMu12fqqx/i5KGnJGjRCvIdpABo7mAUv9rtKk6M4ts3rS
	ussxcYyAO8Lmhzs0axKsMdOjDZ5batXBxY52Pf4cMnZb4nnGLqZ07ynWUhBjslrDbsxDS0
	6emoMLBVzLbHMrhBfOrwDUvQenszFrk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-quiLfFzKPea876jzJCuoeg-1; Sat,
 03 Aug 2024 09:59:08 -0400
X-MC-Unique: quiLfFzKPea876jzJCuoeg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59CB119560A2;
	Sat,  3 Aug 2024 13:59:06 +0000 (UTC)
Received: from [10.2.16.12] (unknown [10.2.16.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C6EB1955D42;
	Sat,  3 Aug 2024 13:59:03 +0000 (UTC)
Message-ID: <309c8d74-a51f-42f7-b526-f5e74c0ac22c@redhat.com>
Date: Sat, 3 Aug 2024 09:59:03 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/pids: Remove unreachable paths of
 pids_{can,cancel}_fork
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiujianfeng@huawei.com
References: <20240803061607.50470-1-xiujianfeng@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240803061607.50470-1-xiujianfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 8/3/24 02:16, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>
> According to the implement of cgroup_css_set_fork() and the usage in
"implementation"?
> the cpuset controller which also has .can_fork and .cancel_fork hooks,
> the argument 'cset' for these two hooks must not be NULL, so remove
> the unrechable paths in thse two hooks.

It is primarily due to cgroup_css_set_fork() will fail if cset cannot be 
found and the can_fork/cancel_fork method will not be called in this case.

Cheers,
Longman

>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/cgroup/pids.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
> index 34aa63d7c9c6..8f61114c36dd 100644
> --- a/kernel/cgroup/pids.c
> +++ b/kernel/cgroup/pids.c
> @@ -272,15 +272,10 @@ static void pids_event(struct pids_cgroup *pids_forking,
>    */
>   static int pids_can_fork(struct task_struct *task, struct css_set *cset)
>   {
> -	struct cgroup_subsys_state *css;
>   	struct pids_cgroup *pids, *pids_over_limit;
>   	int err;
>   
> -	if (cset)
> -		css = cset->subsys[pids_cgrp_id];
> -	else
> -		css = task_css_check(current, pids_cgrp_id, true);
> -	pids = css_pids(css);
> +	pids = css_pids(cset->subsys[pids_cgrp_id]);
>   	err = pids_try_charge(pids, 1, &pids_over_limit);
>   	if (err)
>   		pids_event(pids, pids_over_limit);
> @@ -290,14 +285,9 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
>   
>   static void pids_cancel_fork(struct task_struct *task, struct css_set *cset)
>   {
> -	struct cgroup_subsys_state *css;
>   	struct pids_cgroup *pids;
>   
> -	if (cset)
> -		css = cset->subsys[pids_cgrp_id];
> -	else
> -		css = task_css_check(current, pids_cgrp_id, true);
> -	pids = css_pids(css);
> +	pids = css_pids(cset->subsys[pids_cgrp_id]);
>   	pids_uncharge(pids, 1);
>   }
>   


