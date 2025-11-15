Return-Path: <cgroups+bounces-11997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B82C60822
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282083BD042
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F2C274B39;
	Sat, 15 Nov 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="3+10FsmF"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F31F0E34
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763222034; cv=none; b=QD8HG5KllrtK01KczH2QOZD3ZgB1YoeSuAukxD/hnXrFc6q4i3n6grHSwFCj3Gtuar8OKEYvMQLqDGJwezcNZb7a6KKPtpJKh3Q/JQimVwkoOli7s6jbYnRE6/S2ZbVvwe9+wMebLCCTYLNMG/5+K/HPFAPlzPEcL6dln/LsTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763222034; c=relaxed/simple;
	bh=8adI+e5YLCmDbskIfTR944x+Mj4gGEug5GGgWim+XFE=;
	h=References:Date:Content-Type:From:Mime-Version:In-Reply-To:To:Cc:
	 Subject:Message-Id; b=JJjXYuqz1Qj2FkJ7Hbk2cJX4hr29rJxpzL2D3501DYwOua+vXYw3bgOiiWHNfYIMoZ2E4bH+O88upExvy0waDZVAa6FrjXp4p26C+xaHuD3eSq8mn167cl+ygISb2W/0OAYTY9PeMjze4RYQ99DDSNlzvUUMS5AJ9KIw5g8+W/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=3+10FsmF; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763222020;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rn1YfrUUtpK18D8e9dNkroJv5PhCwNNCz3WtSyxT9Hk=;
 b=3+10FsmFiuc6fWwRWpii9+q2S5R4uVAzsE20nvPtGWtiHhIOB4xCqM+b1m/ZyOp4j+N+Ee
 0aUxJ2Z+AS+U/2CI4a9nnMQsbMxHTPosYDXRcdK2oZ/kYHsETzaUVwloZJLSkT1l3jmUng
 91r/u/ITRHzZqpZZ0HaUgAbYlvlBulV4P/qnfTsX9GeTPRHUWRUdB3lp6I98QWo9Zx7ahH
 GyOa6nHe4lU7jTjWGodLKSzt67YqF25d62I7py104Tv+YMt/gIen4GeV48x56FHw0wBJqy
 xQXPEBuIF8a461Pf0yf5rr8hPJB0i/82RIqXZrdPNHT9xUPvte3wMkdQojha/A==
References: <20251114235434.2168072-1-khazhy@google.com> <20251114235434.2168072-3-khazhy@google.com>
X-Lms-Return-Path: <lba+26918a202+5353f1+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Nov 2025 23:53:35 +0800
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <20251114235434.2168072-3-khazhy@google.com>
Reply-To: yukuai@fnnas.com
To: "Khazhismel Kumykov" <khazhy@chromium.org>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, 
	"Yu Kuai" <yukuai@kernel.org>, "Khazhismel Kumykov" <khazhy@google.com>
Content-Language: en-US
Subject: Re: [PATCH v2 2/3] block/blk-throttle: drop unneeded blk_stat_enable_accounting
Message-Id: <96c6e645-6378-47b5-bdca-25900a1b60d0@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sat, 15 Nov 2025 23:53:37 +0800

=E5=9C=A8 2025/11/15 7:54, Khazhismel Kumykov =E5=86=99=E9=81=93:
> From: Guenter Roeck<linux@roeck-us.net>
>
> After the removal of CONFIG_BLK_DEV_THROTTLING_LOW, it is no longer
> necessary to enable block accounting, so remove the call to
> blk_stat_enable_accounting(). With that, the track_bio_latency variable
> is no longer used and can be deleted from struct throtl_data. Also,
> including blk-stat.h is no longer necessary.
>
> Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"=
)
> Cc: Yu Kuai<yukuai@kernel.org>
> Cc: Tejun Heo<tj@kernel.org>
> Signed-off-by: Guenter Roeck<linux@roeck-us.net>
> Signed-off-by: Khazhismel Kumykov<khazhy@google.com>
> ---
>   block/blk-throttle.c | 6 ------
>   1 file changed, 6 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thanks
Kuai

