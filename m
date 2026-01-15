Return-Path: <cgroups+bounces-13232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A80D226B1
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 06:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9087130313E2
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA72D780C;
	Thu, 15 Jan 2026 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="h8/zdKfM"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4521ABD7
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768454364; cv=none; b=tos23Is7rN3T33vicGLH8HfTmwkuIbaHxniKAsXoGx/Zaonb2gndZ0YY17bOPg72VmPZhCgM2ue/UCY1Mh9ixvZwfXjGndlKRv2615tfD650KpWoFYuug+hsG/oB/S6JApVqEulL9OLIFIKufCECoIDGU1DfHZLap0lBweNFj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768454364; c=relaxed/simple;
	bh=J5+GPKKsSS70BOEa6mrDQkKtYmDlU3a6K86LcO/geAE=;
	h=To:Date:Cc:Message-Id:In-Reply-To:From:Content-Type:Subject:
	 Mime-Version:References; b=AGOqyXA2DMhhw1tjGs3TKvNhe7Qfhf+gXgO8odD5OHMkeWG9BQx5qNNmsi/Df/kgwoBukFeBw+St8vHKJ/7jqDcQA+ii3L6xpc2+8FMkkmXfVvxj+PGNnzE3LEmCCYSoNmFdlq5Zg3ebVB+Dlc3UXR6gJodncnn4lilAfSDVn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=h8/zdKfM; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1768454349;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PXjNp8bXiyilIsgVjU9MQr0q0JiVU44Qar9z6Igxt9E=;
 b=h8/zdKfMbqomEu3M6l6tOMPfB4H33O7wUChiiKCRG2MBzNbIbBGaaxexC7eM9WraWSjCVu
 QQnJvIfbvHgwsyMdYBxiOoM1kglVrNZHexzbMTnhhnPJ9W+n/30mqtxWfV8BP49XNSAws1
 91flaDvnE8aPTt+vFoeRHUPvWUJz/yU9naTQzl/2NEDhfEpIDW/tk20/Usczq7KsrVyG/j
 oNa5KTsgrjbTHtaNplpLT6ez7aEgCo0etu1zL/u603VN5JtyRRO+6s0rEwe8Sqv5gHg7DK
 pSGMxdHvHi47Z8/Srvhs2pM2KJ7ZQjCkOkbejscLTPaAVMrJo1Bg1B2Ti3rTuA==
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@infradead.org>
Date: Thu, 15 Jan 2026 13:19:05 +0800
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Thu, 15 Jan 2026 13:19:06 +0800
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <mkoutny@suse.com>, 
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>, 
	<zhengqixing@huawei.com>, <yukuai@fnnas.com>
Message-Id: <b004989f-900f-447f-a931-93c91082ca63@fnnas.com>
In-Reply-To: <20260113061035.1902522-2-zhengqixing@huaweicloud.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+2696878cb+1a2408+vger.kernel.org+yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v2 1/3] blk-cgroup: fix race between policy activation and blkg destruction
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com> <20260113061035.1902522-2-zhengqixing@huaweicloud.com>

Hi,

You are sending to my invalid huawei email address, so I didn't see this pa=
tch.

=E5=9C=A8 2026/1/13 14:10, Zheng Qixing =E5=86=99=E9=81=93:
> From: Zheng Qixing <zhengqixing@huawei.com>
>
> When switching an IO scheduler on a block device, blkcg_activate_policy()
> allocates blkg_policy_data (pd) for all blkgs attached to the queue.
> However, blkcg_activate_policy() may race with concurrent blkcg deletion,
> leading to use-after-free and memory leak issues.
>
> The use-after-free occurs in the following race:
>
> T1 (blkcg_activate_policy):
>    - Successfully allocates pd for blkg1 (loop0->queue, blkcgA)
>    - Fails to allocate pd for blkg2 (loop0->queue, blkcgB)
>    - Enters the enomem rollback path to release blkg1 resources
>
> T2 (blkcg deletion):
>    - blkcgA is deleted concurrently
>    - blkg1 is freed via blkg_free_workfn()
>    - blkg1->pd is freed
>
> T1 (continued):
>    - Rollback path accesses blkg1->pd->online after pd is freed
>    - Triggers use-after-free
>
> In addition, blkg_free_workfn() frees pd before removing the blkg from
> q->blkg_list. This allows blkcg_activate_policy() to allocate a new pd
> for a blkg that is being destroyed, leaving the newly allocated pd
> unreachable when the blkg is finally freed.
>
> Fix these races by extending blkcg_mutex coverage to serialize
> blkcg_activate_policy() rollback and blkg destruction, ensuring pd
> lifecycle is synchronized with blkg list visibility.
>
> Link: https://lore.kernel.org/all/20260108014416.3656493-3-zhengqixing@hu=
aweicloud.com/
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>   block/blk-cgroup.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 3cffb68ba5d8..600f8c5843ea 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1596,6 +1596,8 @@ int blkcg_activate_policy(struct gendisk *disk, con=
st struct blkcg_policy *pol)
>  =20
>   	if (queue_is_mq(q))
>   		memflags =3D blk_mq_freeze_queue(q);
> +
> +	mutex_lock(&q->blkcg_mutex);
>   retry:
>   	spin_lock_irq(&q->queue_lock);
>  =20
> @@ -1658,6 +1660,7 @@ int blkcg_activate_policy(struct gendisk *disk, con=
st struct blkcg_policy *pol)
>  =20
>   	spin_unlock_irq(&q->queue_lock);
>   out:
> +	mutex_unlock(&q->blkcg_mutex);
>   	if (queue_is_mq(q))
>   		blk_mq_unfreeze_queue(q, memflags);
>   	if (pinned_blkg)

Can you also protect blkg_destroy_all() will blkcg_mutex as well? Then all =
access for q->blkg_list will
be protected.

--=20
Thansk,
Kuai

