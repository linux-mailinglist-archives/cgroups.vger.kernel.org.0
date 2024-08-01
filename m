Return-Path: <cgroups+bounces-4058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DAF9441DB
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 05:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A991F20C80
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 03:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6407143746;
	Thu,  1 Aug 2024 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fczU7LHr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AD13C818
	for <cgroups@vger.kernel.org>; Thu,  1 Aug 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722482576; cv=none; b=WG/1N19Ss91Pvm0eZn4oj8sFw2RwHg5R6SP765lLTabvfM5yBARVFC2aB/CQanFDVTg/yXIHqS+LB1LvgCx+Q14b5uwS44k8FDBL2Hdp4ppdtZOcGYkUXMwFReRvzD/DrCfk4H3f27uObOXPCFx75u8EAsdlhXHc4lWPAJ2agE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722482576; c=relaxed/simple;
	bh=kaWU0UtEMwQ1O7iXzGFMx10qiNwA/UUpCQN/mZbLUYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udeJr0yPmxQepu8g988RfK4YeEPvh85vOvIiQEOyuKueHYDNfSnUSdGHqVqrdv0qfwQ5ToKEXXkPv/sPQzgr1WiJnOgTSreMkKny7ItfB8ttxNt1CevzCaF/Rh4CTB7qNdPoxvKc9cnoB8LBUYgKmpObLDcDa0W75syazYxS/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fczU7LHr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722482573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSRz3A6ElKt7l6qd6qwvIoB/IVcQJsavNnaNqcf8XME=;
	b=fczU7LHrCK9SZQGKPi2PmZsd6YwrzPfgoSJbdk4d6ZhbnyQ5qpIN2S2F12elA8adRfBJAB
	AFfSmPHTq2Rlu4VyAS4/YHkIfha9FI7qX5iFdQrytF3W7IC2FGXGN9SS0OJIEw9OrW/W6i
	uqVeYkINKP94a6s8vtdoRo+sFg+O9dY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-DZ8zIapOM3CnhW-bjWuYAw-1; Wed,
 31 Jul 2024 23:22:49 -0400
X-MC-Unique: DZ8zIapOM3CnhW-bjWuYAw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B90D719560B0;
	Thu,  1 Aug 2024 03:22:47 +0000 (UTC)
Received: from [10.2.16.2] (unknown [10.2.16.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABAD4300019E;
	Thu,  1 Aug 2024 03:22:45 +0000 (UTC)
Message-ID: <6a79b50a-ad74-4b1b-a98c-7da8ef341b24@redhat.com>
Date: Wed, 31 Jul 2024 23:22:44 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Do not clear xcpus when clearing
 cpus
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731092102.2369580-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240731092102.2369580-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/31/24 05:21, Chen Ridong wrote:
> After commit 737bb142a00d ("cgroup/cpuset: Make cpuset.cpus.exclusive
> independent of cpuset.cpus"), cpuset.cpus.exclusive and cpuset.cpus
> became independent. However we found that cpuset.cpus.exclusive.effective
> is cleared when cpuset.cpus is clear. To fix this issue, just remove xcpus
> clearing when cpuset.cpus is being cleared.
>
> It can be reproduced as below:
> cd /sys/fs/cgroup/
> mkdir test
> echo +cpuset > cgroup.subtree_control
> cd test
> echo 3 > cpuset.cpus.exclusive
> cat cpuset.cpus.exclusive.effective
> 3
> echo > cpuset.cpus
> cat cpuset.cpus.exclusive.effective // was cleared
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a9b6d56eeffa..248c39bebbe9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2523,10 +2523,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 * that parsing.  The validate_change() call ensures that cpusets
>   	 * with tasks have cpus.
>   	 */
> -	if (!*buf) {
> +	if (!*buf)
>   		cpumask_clear(trialcs->cpus_allowed);
> -		cpumask_clear(trialcs->effective_xcpus);
> -	} else {
> +	else {
>   		retval = cpulist_parse(buf, trialcs->cpus_allowed);
>   		if (retval < 0)
>   			return retval;

Yes, that is a corner case bug that has not been properly handled.

Reviewed-by: Waiman Long <longman@redhat.com>


