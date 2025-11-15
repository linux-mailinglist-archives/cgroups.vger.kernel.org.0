Return-Path: <cgroups+bounces-11996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E76C60807
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 16:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45EB6347639
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9E29BD91;
	Sat, 15 Nov 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="s5P3v6VJ"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DE224AF0
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763221907; cv=none; b=iF6M6Uh3ZAnt0Qc8dvV5ogp7gO1EsfOF8PrvFgBLGDT1SgYPWYfd8ixWjfciYlf9NTd4i4kiaxXJkHGJh61yA+v8uv3I364b7L9uRSqBn6dW3oRQ7Okiloq8s4aLtfIUJIdeImxdcjoX7UGalIUtnGJ//GceUvtc+srVFBMa81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763221907; c=relaxed/simple;
	bh=pzWPVQ8GdreVBO816k8UADkKSCD77YskIZrpvAC4HHg=;
	h=In-Reply-To:From:To:Cc:Message-Id:Content-Type:Subject:Date:
	 Mime-Version:References; b=VKr3CO/CSEfLrR0ehyiaDYFmhYCJZb2CZlF6tlGN1PQ5wcI5HJHppzPLOc8/G3jLgqZzv4zuWhurxdZ0Q9LV+T7j9EAdPutL1s571BQkk6X0qzIAzSdSKxkJ8B7EI9a4kYKUpVmvAf22BIznU1DSuDmSIK6yDooZNYn4nhA7ohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=s5P3v6VJ; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763221892;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=eIVIqg5H76+/wW/OhmQAvmScyINJb7NcynmvVQrg6zM=;
 b=s5P3v6VJ2L/A5lonjj9bAClhcUYQWBr6uKrmSCsTxEhTBwNXLquwC7dGm6xQoMfjBt3//5
 g18Wxk85fDVC4QBnKQ5HWuoLk11jNfz2uup/giYuIuiatAzhI/+LcvCeC9kqg406f27FyV
 GVQZ/ISx5XVDZR2WZkkim2wqRJZnbO3a+ldsUUQi/MUvFmKX0Rewf79VfwQ/Hv+e2pzYYH
 xYf1NzsekRgja8B1JC13McIu5EXJF4pjyfwc3sAVLaJ8rGUu93M4EkqmudCgDcF3uWNyTI
 XF5rBKP0Rhwuf8hkvzV4RVvKkQe+JCfIN0YraFTW6T5b4ip4iGXYk6JzmEsoEg==
Content-Language: en-US
In-Reply-To: <20251114235434.2168072-2-khazhy@google.com>
X-Lms-Return-Path: <lba+26918a182+ea5146+vger.kernel.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Khazhismel Kumykov" <khazhy@chromium.org>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, 
	"Yu Kuai" <yukuai@kernel.org>, "Khazhismel Kumykov" <khazhy@google.com>
Message-Id: <2d827b93-9ffa-4767-8409-88460e64a407@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sat, 15 Nov 2025 23:51:29 +0800
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH v2 1/3] block/blk-throttle: Fix throttle slice time for SSDs
Date: Sat, 15 Nov 2025 23:51:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114235434.2168072-1-khazhy@google.com> <20251114235434.2168072-2-khazhy@google.com>

=E5=9C=A8 2025/11/15 7:54, Khazhismel Kumykov =E5=86=99=E9=81=93:
> From: Guenter Roeck<linux@roeck-us.net>
>
> Commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")
> introduced device type specific throttle slices if BLK_DEV_THROTTLING_LOW
> was enabled. Commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW") removed support for BLK_DEV_THROTTLING_LO=
W,
> but left the device type specific throttle slices in place. This
> effectively changed throttling behavior on systems with SSD which now use
> a different and non-configurable slice time compared to non-SSD devices.
> Practical impact is that throughput tests with low configured throttle
> values (65536 bps) experience less than expected throughput on SSDs,
> presumably due to rounding errors associated with the small throttle slic=
e
> time used for those devices. The same tests pass when setting the throttl=
e
> values to 65536 * 4 =3D 262144 bps.
>
> The original code sets the throttle slice time to DFL_THROTL_SLICE_HD if
> CONFIG_BLK_DEV_THROTTLING_LOW is disabled. Restore that code to fix the
> problem. With that, DFL_THROTL_SLICE_SSD is no longer necessary. Revert t=
o
> the original code and re-introduce DFL_THROTL_SLICE to replace both
> DFL_THROTL_SLICE_HD and DFL_THROTL_SLICE_SSD. This effectively reverts
> commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")=
.
>
> While at it, also remove MAX_THROTL_SLICE since it is not used anymore.
>
> Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"=
)
> Cc: Yu Kuai<yukuai@kernel.org>
> Cc: Tejun Heo<tj@kernel.org>
> Signed-off-by: Guenter Roeck<linux@roeck-us.net>
> Signed-off-by: Khazhismel Kumykov<khazhy@google.com>
> ---
>   block/blk-throttle.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thanks
Kuai

