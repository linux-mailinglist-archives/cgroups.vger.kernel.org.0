Return-Path: <cgroups+bounces-5910-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94189F3461
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3507016215F
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D225145FE8;
	Mon, 16 Dec 2024 15:23:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA081ACA;
	Mon, 16 Dec 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362596; cv=none; b=Lo2nLw7WqsMSEIaV/vT86VeokQjOc+2737mI9gm6hjNai7R6D86RNFHZFCPOnF1AT7p9nrEuzSNfNhboLozcCMZjGph0jeT5wcWogQ+/LDCgiVBFhXn7rME9iKjb9C9sgMs2ItWHEL5m9FDpZkRzUzL2fcm1djweIeMSn/D9kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362596; c=relaxed/simple;
	bh=X+6Euz+YRO3cFSrjBuxH+jB845sPJQlAgYntR4V7fCE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0e56h1sb09RNkvGFGxXdlBceQ0yYgRHrYYb1nonhx5KwLkQZcytpuLC+RCnau1OKQ6sHceo80OoGdHLLTE2zXe3c+F2rbU3Hkm5eYOo25BDoZPjb439cAuroE1dvdqxsFlzwuPdu9MvilsyzI3Js+ce1e0HbQQaZ6o+Fi9+Gwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBkBj6Sctz6K5VY;
	Mon, 16 Dec 2024 23:19:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5067E140445;
	Mon, 16 Dec 2024 23:23:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 16:23:11 +0100
Date: Mon, 16 Dec 2024 15:23:10 +0000
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
Subject: Re: [PATCH v3 7/9] driver core: Correct parameter check for API
 device_for_each_child_reverse_from()
Message-ID: <20241216152310.0000166a@huawei.com>
In-Reply-To: <20241212-class_fix-v3-7-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
	<20241212-class_fix-v3-7-04e20c4f0971@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 12 Dec 2024 21:38:43 +0800
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
Given that 'from' implies continuation of an iteration I can see why
it might not ever be relevant to check parent.  It's harmless, but to
my mind unnecessary.

Jonathan

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


