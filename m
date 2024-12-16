Return-Path: <cgroups+bounces-5908-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006079F344B
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB871168433
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04532145A16;
	Mon, 16 Dec 2024 15:19:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A8140E30;
	Mon, 16 Dec 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362378; cv=none; b=V2bWBTcH0nwG1R8J0oBbwFf4vbfGyzMd9kyxvepz+MVGjONwTW8KnMTEy16zw4OcnIdhYDcHnRu8UnpmV72VQUQxSmhGH0z97XE6VeWH+aj3WxsmwYc8APPdbqghZlH/QMjSeoR+5+Lkfj7xwmc9DFuSJ7VBw3TRC2vznrwwToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362378; c=relaxed/simple;
	bh=lagOO5sDXuuSCCNoTaB1Jk6FpFJAVvwfO8ybd8xx2Mk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Db9/AejqRoLHaQ+QN+ITJkV0kLE7bwrO3OPjMdGIjQVQjZNFwEd9JGLoHYLoD0ygd+i+SDwQk8vujCZ3H2aUEgOha9auCq7FHQ9854H2mU26QDrv6ZuFgX7aaRGMu+8GIrvJfwEtcH2fR0iiNcBk9WEHUsqusZtoywxwyynedm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBk4w3Vywz6K6wk;
	Mon, 16 Dec 2024 23:14:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A67F1408F9;
	Mon, 16 Dec 2024 23:19:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 16:19:33 +0100
Date: Mon, 16 Dec 2024 15:19:31 +0000
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
Subject: Re: [PATCH v3 5/9] driver core: Move true expression out of if
 condition in API device_find_child()
Message-ID: <20241216151931.00006519@huawei.com>
In-Reply-To: <20241212-class_fix-v3-5-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
	<20241212-class_fix-v3-5-04e20c4f0971@quicinc.com>
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

On Thu, 12 Dec 2024 21:38:41 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For device_find_child(), get_device() in the if condition always returns
> true, move it to if body to make the API's logic more clearer.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'd squash with previous 2.  They are all the same change in the same
area of the kernel.

Jonathan

> ---
>  drivers/base/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8bdbc9e657e832a063542391426f570ccb5c18b9..69bb6bf4bd12395226ee3c99e2f63d15c7e342a5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4089,9 +4089,12 @@ struct device *device_find_child(struct device *parent, const void *data,
>  		return NULL;
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
> -	while ((child = next_device(&i)))
> -		if (match(child, data) && get_device(child))
> +	while ((child = next_device(&i))) {
> +		if (match(child, data)) {
> +			get_device(child);
>  			break;
> +		}
> +	}
>  	klist_iter_exit(&i);
>  	return child;
>  }
> 


