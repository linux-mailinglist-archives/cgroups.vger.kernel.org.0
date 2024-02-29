Return-Path: <cgroups+bounces-1916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D5986CB74
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA091F26641
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACF137779;
	Thu, 29 Feb 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqGlTl2p"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BD12E1E3
	for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216706; cv=none; b=pWVzcHtICvD7S3lyd/DS2JzdwDyQNsPJ0KJ8qaFHUCQRBasmUTWmj0rAfcVhyZ2fN4P/MQ+FpoI20yQD4DQ1M2cOQr1Kk1gJ4Vlow1704j+HmnLoBnhrkHWG8hzX8rTfX6V/K36ok2jesW1fWxk5L0Egftk0QdXxfIEvt+uESSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216706; c=relaxed/simple;
	bh=N+5moBTraylCNNTWb3cy+j7uayzPyE60qSB2vr31vOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEyxokh2CSD6lIK0F1FUJgcb+LxLiN3wt/jXxoM0KiNgWmuwGKr/kisGiQLoId2i15FW8UyrTJ9NJ/QgEAHh2ii70uCBzOCDsSK3xs04XltJ0wq0ydk/tV/yKlFc9+8pfoPSDlEQRe7hV9MTb05o6IFhG61WQk6q8YF/DSKCjiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqGlTl2p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709216704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGDq1NUIAIPOPbfxiL7bhWCZkKjKYVk+M07BdvjqBpI=;
	b=NqGlTl2pT3moAe+zVOqItRyWI5c5CbXAaU2nWD+bku2+x3qXZ4LTMiCJuXK6k3Td9Ti62N
	Qyyew3Fo31972mMHcARWjdHYCCtp/9qqcz5sk5TDE93cfxh+PXcZG22ksaNSNi8VEMU/61
	KKKp7UnP7SMQhFqE74iZIMCnBDS2h1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-cGc6HtCCNtOQhgf5F6uljQ-1; Thu, 29 Feb 2024 09:24:59 -0500
X-MC-Unique: cGc6HtCCNtOQhgf5F6uljQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFF9B1020210;
	Thu, 29 Feb 2024 14:24:58 +0000 (UTC)
Received: from [10.22.8.117] (unknown [10.22.8.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67CC18CED;
	Thu, 29 Feb 2024 14:24:58 +0000 (UTC)
Message-ID: <52f842b8-2907-4eb0-ad0a-3784d54daa12@redhat.com>
Date: Thu, 29 Feb 2024 09:24:58 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Fix retval in update_cpumask()
Content-Language: en-US
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
 Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229101116.60043-1-kamalesh.babulal@oracle.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240229101116.60043-1-kamalesh.babulal@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 2/29/24 05:11, Kamalesh Babulal wrote:
> The update_cpumask(), checks for newly requested cpumask by calling
> validate_change(), which returns an error on passing an invalid set
> of cpu(s). Independent of the error returned, update_cpumask() always
> returns zero, suppressing the error and returning success to the user
> on writing an invalid cpu range for a cpuset. Fix it by returning
> retval instead, which is returned by validate_change().
>
> Fixes: 99fe36ba6fc1 ("cgroup/cpuset: Improve temporary cpumasks handling")
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---
>   kernel/cgroup/cpuset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ba36c073304a..2ddbfaa4efa9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2562,7 +2562,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		update_partition_sd_lb(cs, old_prs);
>   out_free:
>   	free_cpumasks(NULL, &tmp);
> -	return 0;
> +	return retval;
>   }
>   
>   /**
>
> base-commit: cf1182944c7cc9f1c21a8a44e0d29abe12527412

LGTM, thanks for the fix.

Reviewed-by: Waiman Long <longman@redhat.com>


