Return-Path: <cgroups+bounces-6017-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BDF9FC054
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 17:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4661885DCF
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3CF1FF5FB;
	Tue, 24 Dec 2024 16:27:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B91494A6;
	Tue, 24 Dec 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735057634; cv=none; b=TVAVRCCZceHImazbZ+DYDehZtKZxrTL0o2FFHnLYC1GjCbdKL4BmWiK4vFQdBTomEDrYGwB7C+U+MVmvzeUHFsa+mmf1si+VfQsFtpi41JVZA7eZNh+0kd8XkZyPcPybZIJwdgI8GZeMzX0FIJH0/+eJo5oq0inNvhZn4xDHUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735057634; c=relaxed/simple;
	bh=+PNClWtcm8ydO0Y0Imjl2UfVFipC8Cokll0kFm6jpDY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq5EeKgDLhRffr7xPWbqE7aN5QX2LJgj+IG2Kdg7EOWa98pKOJ1qSff38L6sgJ9h3ZPbVy7IH+Hd2B8DLbfvrXvoBrCgR8nTZz+R0Am0BS1EkPdtFHddIhmKACIkzHAbsRuStgvRmKY8+CPQRjMc0HIx9Of9SWAZayPmcLzhO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHgHT0hdLz6LDGM;
	Wed, 25 Dec 2024 00:25:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 99356140736;
	Wed, 25 Dec 2024 00:27:10 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:27:09 +0100
Date: Tue, 24 Dec 2024 16:27:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zijun Hu <zijun_hu@icloud.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik
	<josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, Boris Burkov
	<boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v5 5/8] driver core: Correct parameter check for API
 device_for_each_child_reverse_from()
Message-ID: <20241224162707.00004e9c@huawei.com>
In-Reply-To: <20241224-class_fix-v5-5-9eaaf7abe843@quicinc.com>
References: <20241224-class_fix-v5-0-9eaaf7abe843@quicinc.com>
	<20241224-class_fix-v5-5-9eaaf7abe843@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Dec 2024 21:37:24 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> device_for_each_child_reverse_from() checks (!parent->p) for its
> parameter @parent, and that is not consistent with other APIs of
> its cluster as shown below:
> 
> device_for_each_child_reverse_from() // check (!parent->p)
> device_for_each_child_reverse()      // check (!parent || !parent->p)
> device_for_each_child()              // same above
> device_find_child()                  // same above
> 
> Correct the API's parameter @parent check by (!parent || !parent->p).
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Cost is minor and consistency is always nice event if it is
very unlikely reasonable code would call this without parent
being set.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 69bb6bf4bd12395226ee3c99e2f63d15c7e342a5..34fb13f914b3db47e6a047fdabf3c9b18ecc08cc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4050,7 +4050,7 @@ int device_for_each_child_reverse_from(struct device *parent,
>  	struct device *child;
>  	int error = 0;
>  
> -	if (!parent->p)
> +	if (!parent || !parent->p)
>  		return 0;
>  
>  	klist_iter_init_node(&parent->p->klist_children, &i,
> 


