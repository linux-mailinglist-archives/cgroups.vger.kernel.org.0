Return-Path: <cgroups+bounces-11998-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B695C60837
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 16:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DDC3BC3EE
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17F28F50F;
	Sat, 15 Nov 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="HkTsJIRv"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427D22370A
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763222199; cv=none; b=CdrE0U9gDO/5eTDWLlp3M3xr4EqNSpFMGEQ0NmmfAkE6W3tYWKakgitlaWD68cWMfLAKEOCbGiz7ssOYV9CnMONyVbZzyM7RKB9kT0D0pmjkVS3i6oWIvvsEbFZ1Zhx1LG7WhfPRWHmcQc5Ggi/Ef8f7N3JQ0EQyGgNMYbp1UTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763222199; c=relaxed/simple;
	bh=8oG2jvXcoSQgG6l+ycl3M4S6AsZENjJLPQUkE+b2cOg=;
	h=Cc:References:In-Reply-To:To:From:Subject:Content-Type:Date:
	 Message-Id:Mime-Version; b=aNVvf1IPZUSbl/gMylKxaMAQWhFPPbiFQUu6zionXRyXtf4olVfQmU5nLVmVGlPkGEpZ+ji4wChCvIdExXSVZMln1xgcPWi+DSuXOdHueHt2/5hehv4AJW1mC866nDL/MPqLOZiKC0IZZJXbHN30MfWyJzLU63dhdm1uA2tZlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=HkTsJIRv; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763222192;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=XEKTOtTM0l3ze9zn+ntcfJAG62DORfYVvOb51c12gC0=;
 b=HkTsJIRvPoRIGXPt3Wt5GUSCoGa5mCIXk1ZA3Qu12W7cemmH6xVQ44L+0pCj1VTDEMOzNp
 hTjt8miLdfdQ+I3xXqlHBTpZsLIN2RNKTtB/+lwEUzcd5RyEOFOJH5IR6wtbveUxGyx1xg
 JYrO5BjAOnUZdSwaiq27mY+3pM34lg7b6ce/MfqGz01ix+0cDRS4qq7RO4VwhzGsUoATFK
 ADW0MgieIXVPt/7+ebtTmLmQK2o3XkvD3ev+rxa3C9VU3ychK9CLcpbQ7zvJk9p8IujytE
 SbomkKCxhkqoKgWUstWbMtmJE9B0XZBBpdIifjgWHHvOkVsnhGd3CR4J9NBbag==
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fnnas.com
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+26918a2ae+f87099+vger.kernel.org+yukuai@fnnas.com>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, 
	"Yu Kuai" <yukuai@kernel.org>, "Khazhismel Kumykov" <khazhy@google.com>
User-Agent: Mozilla Thunderbird
References: <20251114235434.2168072-1-khazhy@google.com> <20251114235434.2168072-4-khazhy@google.com>
In-Reply-To: <20251114235434.2168072-4-khazhy@google.com>
To: "Khazhismel Kumykov" <khazhy@chromium.org>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v2 3/3] block/blk-throttle: Remove throtl_slice from struct throtl_data
Content-Language: en-US
Received: from [192.168.1.104] ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sat, 15 Nov 2025 23:56:29 +0800
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Nov 2025 23:56:28 +0800
Message-Id: <077953d4-8f21-4203-9f85-21e8977f1298@fnnas.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

=E5=9C=A8 2025/11/15 7:54, Khazhismel Kumykov =E5=86=99=E9=81=93:
> From: Guenter Roeck<linux@roeck-us.net>
>
> throtl_slice is now a constant. Remove the variable and use the constant
> directly where needed.
>
> Cc: Yu Kuai<yukuai@kernel.org>
> Cc: Tejun Heo<tj@kernel.org>
> Signed-off-by: Guenter Roeck<linux@roeck-us.net>
> Signed-off-by: Khazhismel Kumykov<khazhy@google.com>
> ---
>   block/blk-throttle.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thanks
Kuai

