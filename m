Return-Path: <cgroups+bounces-4772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C55972016
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 19:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77EEB21000
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB016DECB;
	Mon,  9 Sep 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G72779+A"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4928DCC
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901910; cv=none; b=fyIm1llUbpAe2bihkBDGydSupsT4Ny+u+idWaBMw35nSOrXSq9mZg6cVmfqMZMQWPeHYgrsW4E5XB0eTCekzzw+/68XRiTR1V+Do8ybuuhC9r/IUUCKt011EWjbAAYV2v2aW8uHxJYUjvHKJnYd1hGrfVkO5Kdo3hbl2xA3tR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901910; c=relaxed/simple;
	bh=r+ZU8gNNLR/8chxxYc09PyuYjlJr/F3ojm4v2CmNguY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnkyPQ85l7GCid9I0EcC5zoU6Kns9ZWYqI+XcJ9mexPNWBihDhtD0B5OypshGSHCQPCvWwRdptC9eBoONixxbWfem5Il0ZEbjt31E/kv7rmWyTBKMHyIJ85EquBfxjJuKgHGsQniS/QR32DqneiVuDAYMfKXQ9BvRL7atsjqaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G72779+A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725901907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPmyMHMjUgK4J6uH/6k3HGCVCNeoH/3DSKZDu28dDeM=;
	b=G72779+A2LE1OiiNygyoeHF8rRSpL3kbEdyGv/JVq45tXQR89pKbTXQyBNUCycqQ+hiKM7
	VAkogVY7hZTd0boSiRR44txj/WYOqcItciW13iSkfcGWCS/iavst3qROmOl6PzIso6qhmf
	d4kEm6tRbcitiE7lRtKNjvrEE+S7A6c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-ZqL4uUw_MMKYOfI5xKuowA-1; Mon,
 09 Sep 2024 13:11:46 -0400
X-MC-Unique: ZqL4uUw_MMKYOfI5xKuowA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B98AC19560AE;
	Mon,  9 Sep 2024 17:11:43 +0000 (UTC)
Received: from [10.2.16.126] (unknown [10.2.16.126])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBEA81956048;
	Mon,  9 Sep 2024 17:11:40 +0000 (UTC)
Message-ID: <8d1440af-bf06-43e9-b7c3-10b2ce8ce7d2@redhat.com>
Date: Mon, 9 Sep 2024 13:11:39 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Ridong <chenridong@huawei.com>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-5-mkoutny@suse.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240909163223.3693529-5-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 9/9/24 12:32, Michal Koutný wrote:
> This is a followup to CONFIG-urability of cpuset and memory controllers
> for v1 hierarchies. Make the output in /proc/cgroups reflect that
> !CONFIG_CPUSETS_V1 is like !CONFIG_CPUSETS and
> !CONFIG_MEMCG_V1 is like !CONFIG_MEMCG.
>
> The intended effect is that hiding the unavailable controllers will hint
> users not to try mounting them on v1.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cgroup-v1.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 784337694a4be..e28d5f0d20ed0 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -681,11 +681,14 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
>   	 * cgroup_mutex contention.
>   	 */
>   
> -	for_each_subsys(ss, i)
> +	for_each_subsys(ss, i) {
> +		if (cgroup1_subsys_absent(ss))
> +			continue;
>   		seq_printf(m, "%s\t%d\t%d\t%d\n",
>   			   ss->legacy_name, ss->root->hierarchy_id,
>   			   atomic_read(&ss->root->nr_cgrps),
>   			   cgroup_ssid_enabled(i));
> +	}
>   
>   	return 0;
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


