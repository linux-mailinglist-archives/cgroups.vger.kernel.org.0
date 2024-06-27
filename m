Return-Path: <cgroups+bounces-3424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0791B125
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 23:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3B1284DE3
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C652D19DFBF;
	Thu, 27 Jun 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bndtml/I"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A313FF9
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522197; cv=none; b=qg2GQOEr7ssbpw+7Vi6e4lJBSGTIBzRK9WJZ8PqiEnWe/KlH2WwiFeq4p+wCLCGV07ytallOubjVPLGkvK14BKgQ158W9dErdfttARBmIKav4i7O1YE4DQfLRcisVGmWI6OeJRiOaJgw5BZEGKPZZ28BrV++6TVmyzixeepeAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522197; c=relaxed/simple;
	bh=nJXTZf9jRv1GnZD10q0JXGqfPKCB/2lBaGZFcH1SZdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJgMIRXb2NMejmq1HwsI/uO+5jYqfbXxIeYQFSdG2DGVvq15wP7SntLK5n/fVTX9Ja574pk1c1IQZ7C5+Vrzv+2v29xQMf5gYSThmO6baPXeMhF22tJJ/ELsTYkGzvTTDf7k93JqVchJyHk7jJtvOR7XTa7LiaHGONcGKvO/r/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bndtml/I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719522194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92YjF2bxhqUCuV4ioUxntWjtFuSZxgrPxjvmc9Xi/h0=;
	b=bndtml/IyaPwsEzd1q7hHe5VB25KF2acLMSOjmaB+y/8qpFfjTApAih7vrrsv19y6RqXVJ
	hVuWqRSH34uE3mYRt0lz5DVk6s479Ksg6sfDcuy5puH8d++m7qwBBLwbz1ag2BF80HRHVH
	SyVxRlEC95mJnJsASIJwXBY9bSB+cpg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-Hben552dPBiXr5huvMhcjg-1; Thu,
 27 Jun 2024 17:03:09 -0400
X-MC-Unique: Hben552dPBiXr5huvMhcjg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17AE41955DC1;
	Thu, 27 Jun 2024 21:03:06 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7946E1955BE0;
	Thu, 27 Jun 2024 21:03:02 +0000 (UTC)
Message-ID: <66095664-5a14-422a-a703-dec437577a3d@redhat.com>
Date: Thu, 27 Jun 2024 17:03:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: don't clear stat in blkcg_reset_stats()
To: Li Lingfeng <lilingfeng@huaweicloud.com>, tj@kernel.org,
 josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk
Cc: ming.lei@redhat.com, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, lilingfeng3@huawei.com
References: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 6/27/24 05:08, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>
> The list corruption described in commit 6da668063279 ("blk-cgroup: fix
> list corruption from resetting io stat") has no effect. It's unnecessary
> to fix it.
>
> As for cgroup v1, it does not use iostat any more after commit
> ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup v1"), so using
> memset to clear iostat has no real effect.
> As for cgroup v2, it will not call blkcg_reset_stats() to corrupt the
> list.
>
> The list of root cgroup can be used by both cgroup v1 and v2 while
> non-root cgroup can't since it must be removed before switch between
> cgroup v1 and v2.
> So it may has effect if the list of root used by cgroup v2 was corrupted
> after switching to cgroup v1, and switch back to cgroup v2 to use the
> corrupted list again.
> However, the root cgroup will not use the list any more after commit
> ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup io.stat").
>
> Although this has no negative effect, it is not necessary. Remove the
> related code.
You may be right that it may not be necessary in the mainline kernel, it 
does fix the issue on distros with older kernels or some stable releases 
where commit ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup 
v1") may not be present.

>
> Fixes: 6da668063279 ("blk-cgroup: fix list corruption from resetting io stat")
I don't think there should be a fixes tag or it will be backported to 
stable releases.
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   block/blk-cgroup.c | 24 ------------------------
>   1 file changed, 24 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 37e6cc91d576..1113c398a742 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -629,29 +629,6 @@ static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
>   	}
>   }
>   
> -static void __blkg_clear_stat(struct blkg_iostat_set *bis)
> -{
> -	struct blkg_iostat cur = {0};
> -	unsigned long flags;
> -
> -	flags = u64_stats_update_begin_irqsave(&bis->sync);
> -	blkg_iostat_set(&bis->cur, &cur);
> -	blkg_iostat_set(&bis->last, &cur);
> -	u64_stats_update_end_irqrestore(&bis->sync, flags);
> -}
> -
> -static void blkg_clear_stat(struct blkcg_gq *blkg)
> -{
> -	int cpu;
> -
> -	for_each_possible_cpu(cpu) {
> -		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
> -
> -		__blkg_clear_stat(s);
> -	}
> -	__blkg_clear_stat(&blkg->iostat);
> -}
> -
>   static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>   			     struct cftype *cftype, u64 val)
>   {
> @@ -668,7 +645,6 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>   	 * anyway.  If you get hit by a race, retry.
>   	 */
>   	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
> -		blkg_clear_stat(blkg);
>   		for (i = 0; i < BLKCG_MAX_POLS; i++) {
>   			struct blkcg_policy *pol = blkcg_policy[i];
>   

If you are saying that iostat is no longer used in cgroup v1, why not 
remove the blkcg_reset_stats() and its supporting functions and 
deprecate the v1 reset_stats control file. The file should still be 
there to avoid userspace regression, but it will be a nop.

Cheers,
Longman


