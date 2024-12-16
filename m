Return-Path: <cgroups+bounces-5911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CE9F3483
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6821B7A07F4
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F3C148FF0;
	Mon, 16 Dec 2024 15:30:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40EC55896;
	Mon, 16 Dec 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363016; cv=none; b=btSa4MylJ6qzgz8Kgx8Hyv96nL1Xh5v7nScFFMkhGJjRhoMhEUUHLZEK+J7BrvQ3B0BDkpS8PoMLhCe/Sj8o0g390lSe4S3uittgqV4LFjoBtU1tOp/X1HaSdFzGFW5j6d2vZ0Hv//TZoFiITBqTPvsE7yN86YQ/kqRDmyHCZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363016; c=relaxed/simple;
	bh=rbVq4O8G2q/FT2qMMrYKt74xiSa4+QrkHLKNGaPxJbY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R81X9qUhrk3IlZsWwPgPCrR58Jnb1RdWMLkEowNiM6y5wGJC3bx6EFufYuo/3g01fuoWNRwFIjy1YYj30tfq5x3EfERglW/bbsXGKze2zYjG1M9L2nCEs2I67klRS9K5isU60FvQZUppm6/Oh3x4udxr/zLto+y6ZK+iQDoJ9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBkLk6C8rz6K9Zg;
	Mon, 16 Dec 2024 23:26:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 429C51408F9;
	Mon, 16 Dec 2024 23:30:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 16:30:08 +0100
Date: Mon, 16 Dec 2024 15:30:06 +0000
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
Subject: Re: [PATCH v3 8/9] driver core: Correct API
 device_for_each_child_reverse_from() prototype
Message-ID: <20241216153006.000009b4@huawei.com>
In-Reply-To: <20241212-class_fix-v3-8-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
	<20241212-class_fix-v3-8-04e20c4f0971@quicinc.com>
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

On Thu, 12 Dec 2024 21:38:44 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For API device_for_each_child_reverse_from(..., const void *data,
> 		int (*fn)(struct device *dev, const void *data))
> 
> - Type of @data is const pointer, and means caller's data @*data is not
>   allowed to be modified, but that usually is not proper for such non
>   finding device iterating API.
> 
> - Types for both @data and @fn are not consistent with all other
>   for_each device iterating APIs device_for_each_child(_reverse)(),
>   bus_for_each_dev() and (driver|class)_for_each_device().
> 
> Correct its prototype by removing const from parameter types, then adapt
> for various existing usages.
> 
> An dedicated typedef device_iter_t will be introduced as @fn() type for
> various for_each device interating APIs later.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
This inconsistency is indeed weird.  So this changes seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Dan, this was your function. There is nothing about the const
in the original commit.  Did you intend it to be different from
device_for_each_child_reverse() etc?

Jonathan

> ---
>  drivers/base/core.c       | 4 ++--
>  drivers/cxl/core/hdm.c    | 2 +-
>  drivers/cxl/core/region.c | 2 +-
>  include/linux/device.h    | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 34fb13f914b3db47e6a047fdabf3c9b18ecc08cc..7be9c732bec1b060a477b362f555c3e87c8c7b91 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4043,8 +4043,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
>   * device_for_each_child_reverse_from();
>   */
>  int device_for_each_child_reverse_from(struct device *parent,
> -				       struct device *from, const void *data,
> -				       int (*fn)(struct device *, const void *))
> +				       struct device *from, void *data,
> +				       int (*fn)(struct device *, void *))
>  {
>  	struct klist_iter i;
>  	struct device *child;
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 28edd5822486851912393f066478252b20abc19d..50e6a45b30ba260c066a0781b9ed3a2f6f3462d7 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -703,7 +703,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> -static int commit_reap(struct device *dev, const void *data)
> +static int commit_reap(struct device *dev, void *data)
>  {
>  	struct cxl_port *port = to_cxl_port(dev->parent);
>  	struct cxl_decoder *cxld;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bfecd71040c2f4373645380b4c31327d8b42d095..a4cff4c266e7a7dd6a3feb1513bf14b7d3f9afa2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -778,7 +778,7 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  
> -static int check_commit_order(struct device *dev, const void *data)
> +static int check_commit_order(struct device *dev, void *data)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index a9d928398895b062094b94f2c188cbe9951d7ac1..025bac08fca7b2513acb1fbcb666be1dc64f03d1 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1079,8 +1079,8 @@ int device_for_each_child(struct device *parent, void *data,
>  int device_for_each_child_reverse(struct device *parent, void *data,
>  				  int (*fn)(struct device *dev, void *data));
>  int device_for_each_child_reverse_from(struct device *parent,
> -				       struct device *from, const void *data,
> -				       int (*fn)(struct device *, const void *));
> +				       struct device *from, void *data,
> +				       int (*fn)(struct device *, void *));
>  struct device *device_find_child(struct device *parent, const void *data,
>  				 device_match_t match);
>  struct device *device_find_child_by_name(struct device *parent,
> 


