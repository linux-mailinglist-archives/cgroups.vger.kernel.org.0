Return-Path: <cgroups+bounces-5907-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A097B9F3446
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BF418846B5
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7041494B2;
	Mon, 16 Dec 2024 15:18:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58913D89D;
	Mon, 16 Dec 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362334; cv=none; b=illX6Bnnwlt5aI7uzbr0JDVQeiWPL9R8ayanK9n7WeNyzP0BwYIcCCeJxTaZVeeRsdKLWkKiSEEu6itj/l3vjtZOfgIOD8wKAWQrMzoNEJDk8mRSUEQu7lTsmWuiopE1/FIoapG3eyPo2pzzFFae929O4R82YWFlfeDVkymlOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362334; c=relaxed/simple;
	bh=IsrKlm+2OUZKcqqVBC8nxFIPZLQYgWNWMK0rbRQBNIo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvQaG69bsXVJtHxyhYUgB/0SonRWvrjqdRaBIBhkfOxu8NkpSLgBUhECUUiWdaGXqThl21bQ3m3zXn5npZQdMQ0BT9EkqFIz8Con2uXbsJa8DOFwPzRMyFB3h1tA6BFcsjKOMyYklibzdyxf619oVUk3rdKN7KgN7PRzRrJFBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBk42236mz6K6jQ;
	Mon, 16 Dec 2024 23:13:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DFA751400E3;
	Mon, 16 Dec 2024 23:18:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 16:18:47 +0100
Date: Mon, 16 Dec 2024 15:18:45 +0000
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
Subject: Re: [PATCH v3 4/9] driver core: Move true expression out of if
 condition in API driver_find_device()
Message-ID: <20241216151845.000074b1@huawei.com>
In-Reply-To: <20241212-class_fix-v3-4-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
	<20241212-class_fix-v3-4-04e20c4f0971@quicinc.com>
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

On Thu, 12 Dec 2024 21:38:40 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For driver_find_device(), get_device() in the if condition always returns
> true, move it to if body to make the API's logic more clearer.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Though I think it would have been fine to have all these similar patches
as a single patch.

> ---
>  drivers/base/driver.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index b4eb5b89c4ee7bc35458fc75730b16a6d1e804d3..6f033a741aa7ce6138d1c61e49e72b2a3eb85e06 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -160,9 +160,12 @@ struct device *driver_find_device(const struct device_driver *drv,
>  
>  	klist_iter_init_node(&drv->p->klist_devices, &i,
>  			     (start ? &start->p->knode_driver : NULL));
> -	while ((dev = next_device(&i)))
> -		if (match(dev, data) && get_device(dev))
> +	while ((dev = next_device(&i))) {
> +		if (match(dev, data)) {
> +			get_device(dev);
>  			break;
> +		}
> +	}
>  	klist_iter_exit(&i);
>  	return dev;
>  }
> 


