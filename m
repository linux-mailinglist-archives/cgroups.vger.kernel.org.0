Return-Path: <cgroups+bounces-5993-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CD9FB4E5
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2024 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318781884F1C
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2024 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F11CBEAC;
	Mon, 23 Dec 2024 20:12:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667181C8FD4;
	Mon, 23 Dec 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984719; cv=none; b=MX1VQzKqhXUWj6qJMW/D5lj80viSBaZ7jh2t6mbDpEJw8IPP+KB3QbJdKYH4p1mFnsTcvuLGmD8ST4FZ/gJjNVvzl/3pQJ7AhI9BIlm3pk3I3N7W0v4l7uG2aLSsEjW/bR2gZnRSI4bYKDQ76/Fu7EnktcWCvEstuEDh2pr4y3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984719; c=relaxed/simple;
	bh=XBbkxOifQiAr7mo2u9j1cvd2Aa4i4eRw8SG7rt1c0cg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3ICXuPmSd4zZfcs3sB5K1MklzNiLUZR1F0Y0vTEUUy4U0TufdcG7pFlug6PKl3YwzU/pitHBb6PRDNtZ/XtHwOhfGy/deTadNeHvZ+SCGPH2+GYMqcAGQ10hqV0PH/0y7t82NyRNxz93M623MYyr9Ka6hGNKf8xy6pfreFeyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH8GD4LMCz6K8yp;
	Tue, 24 Dec 2024 04:08:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 831BD140517;
	Tue, 24 Dec 2024 04:11:55 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:11:54 +0100
Date: Mon, 23 Dec 2024 20:11:52 +0000
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
Subject: Re: [PATCH v4 8/8] driver core: Move 2 one line device finding APIs
 to header
Message-ID: <20241223201152.000012d1@huawei.com>
In-Reply-To: <20241218-class_fix-v4-8-3c40f098356b@quicinc.com>
References: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
	<20241218-class_fix-v4-8-3c40f098356b@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Dec 2024 08:01:38 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> The following device finding APIs only have one line code in function body
> device_find_child_by_name()
> device_find_any_child()
> 
> Move them to header as static inline function.
Why drop the docs?

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/core.c    | 32 --------------------------------
>  include/linux/device.h | 14 +++++++++++---
>  2 files changed, 11 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 930e43a970952b20cd1c71856bdef889698f51b4..3f37a2aecb1d11561f4edd72e973a1c43368de04 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4100,38 +4100,6 @@ struct device *device_find_child(struct device *parent, const void *data,
>  }
>  EXPORT_SYMBOL_GPL(device_find_child);
>  
> -/**
> - * device_find_child_by_name - device iterator for locating a child device.
> - * @parent: parent struct device
> - * @name: name of the child device
> - *
> - * This is similar to the device_find_child() function above, but it
> - * returns a reference to a device that has the name @name.
> - *
> - * NOTE: you will need to drop the reference with put_device() after use.
> - */
> -struct device *device_find_child_by_name(struct device *parent,
> -					 const char *name)
> -{
> -	return device_find_child(parent, name, device_match_name);
> -}
> -EXPORT_SYMBOL_GPL(device_find_child_by_name);
> -
> -/**
> - * device_find_any_child - device iterator for locating a child device, if any.
> - * @parent: parent struct device
> - *
> - * This is similar to the device_find_child() function above, but it
> - * returns a reference to a child device, if any.
> - *
> - * NOTE: you will need to drop the reference with put_device() after use.
> - */
> -struct device *device_find_any_child(struct device *parent)
> -{
> -	return device_find_child(parent, NULL, device_match_any);
> -}
> -EXPORT_SYMBOL_GPL(device_find_any_child);
> -
>  int __init devices_init(void)
>  {
>  	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 36d1a1607712f5a6b0668ac02a6cf6b2d0651a2d..d1871a764be62e6857595bc10b9e54862c99dfa2 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1083,9 +1083,17 @@ int device_for_each_child_reverse_from(struct device *parent,
>  				       device_iter_t fn);
>  struct device *device_find_child(struct device *parent, const void *data,
>  				 device_match_t match);
> -struct device *device_find_child_by_name(struct device *parent,
> -					 const char *name);
> -struct device *device_find_any_child(struct device *parent);
> +
> +static inline struct device *device_find_child_by_name(struct device *parent,
> +						       const char *name)
> +{
> +	return device_find_child(parent, name, device_match_name);
> +}
> +
> +static inline struct device *device_find_any_child(struct device *parent)
> +{
> +	return device_find_child(parent, NULL, device_match_any);
> +}
>  
>  int device_rename(struct device *dev, const char *new_name);
>  int device_move(struct device *dev, struct device *new_parent,
> 


