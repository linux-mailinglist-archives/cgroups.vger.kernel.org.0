Return-Path: <cgroups+bounces-5906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930FD9F3429
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F401881C14
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286BB13D29A;
	Mon, 16 Dec 2024 15:14:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34851304AB;
	Mon, 16 Dec 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362048; cv=none; b=Lfkhj99sZUZxxtiVqgf3EkK3o+FTEmgd7DZ1OQBYtTcxF/27lzylJjcZYeFZycY2iI1J6YnVH/CtjzZsUMOgdSg5+/Xi1PkWvLbMSeBVTBs2n4sGeKPpkj9GJVQjvKr1IULidCWe2uHr4BEbsyFSXlln/jV0v/o0HKB2wFflneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362048; c=relaxed/simple;
	bh=UTmAQ3gsUGW+ygdC2778WAcuFjzVeA37GZ135sqL5b0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trrHWt+Xx7nWCTrG5rlBgStLqMMiwjXqLPBgh+JxHPik8PDRbKg1gsVYZRJNfDRXsaDuSABZCqRraIbrxa5pbG039DqpmeWLLlw1aaaOLjXew/q1hO3XEUgN8Pq/cOQ1JPlqkurTSfaQbWIhzR9+/M8Fh2Ab0mmSnziXkyQMy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBk303lNxz6LDXj;
	Mon, 16 Dec 2024 23:13:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B2BC140A90;
	Mon, 16 Dec 2024 23:14:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 16:14:01 +0100
Date: Mon, 16 Dec 2024 15:14:00 +0000
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
Subject: Re: [PATCH v3 3/9] driver core: bus: Move true expression out of if
 condition in API bus_find_device()
Message-ID: <20241216151400.00006242@huawei.com>
In-Reply-To: <20241212-class_fix-v3-3-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
	<20241212-class_fix-v3-3-04e20c4f0971@quicinc.com>
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

On Thu, 12 Dec 2024 21:38:39 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For bus_find_device(), get_device() in the if condition always returns
> true, move it to if body to make the API's logic more clearer.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
I agree this is easier to read and the reasoning is sound.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/base/bus.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 657c93c38b0dc2a2247e5f482fadd3a9376a58e8..73a56f376d3a05962ce0931a2fe8b4d8839157f2 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -402,9 +402,12 @@ struct device *bus_find_device(const struct bus_type *bus,
>  
>  	klist_iter_init_node(&sp->klist_devices, &i,
>  			     (start ? &start->p->knode_bus : NULL));
> -	while ((dev = next_device(&i)))
> -		if (match(dev, data) && get_device(dev))
> +	while ((dev = next_device(&i))) {
> +		if (match(dev, data)) {
> +			get_device(dev);
>  			break;
> +		}
> +	}
>  	klist_iter_exit(&i);
>  	subsys_put(sp);
>  	return dev;
> 


