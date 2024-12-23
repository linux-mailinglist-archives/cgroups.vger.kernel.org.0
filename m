Return-Path: <cgroups+bounces-5992-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA659FB4DF
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2024 21:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE71884DEF
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2024 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4C1C245C;
	Mon, 23 Dec 2024 20:09:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6F80038;
	Mon, 23 Dec 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984589; cv=none; b=VIScEjZ+KDTBgPZuQaxFJvzz2nJpx1ijL8nNJpFu2Y2GxemAnWFpLZR4RA9Z6BsZi+vPoIeHklPQQ8tz1ev0nORexvvueklATnvkbB2IesJdEoh9Z/9uHejKWHjjb3hrcFuj4Hud1JKqjgJze0aLKfKeAE3AX8wuE9pjbl/AGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984589; c=relaxed/simple;
	bh=81UA24LqZ8J7XSELWPUkBUYpX3qWlvv6jH/ArLGdSNo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNhZmFSJ2y4rPfbUiTpJJlNQg4lH06NdwwzM8F50eeByoLVzIei282ean86CLI5cZ8+pNj45VhZ84h160IL5cGj4NvIFzuPIGP/K7WAaR1L6JK/aiMew7b66q/LaxX973qpMXENpJ3Hy40JTQ7G7WP05zCLp57Hxv/5ltrDwQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH8Gm3lKfz6L77J;
	Tue, 24 Dec 2024 04:08:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C7B7B140B3C;
	Tue, 24 Dec 2024 04:09:44 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:09:43 +0100
Date: Mon, 23 Dec 2024 20:09:41 +0000
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
Subject: Re: [PATCH v4 1/8] driver core: class: Fix wild pointer
 dereferences in API class_dev_iter_next()
Message-ID: <20241223200941.00000111@huawei.com>
In-Reply-To: <20241218-class_fix-v4-1-3c40f098356b@quicinc.com>
References: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
	<20241218-class_fix-v4-1-3c40f098356b@quicinc.com>
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

On Wed, 18 Dec 2024 08:01:31 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> There are a potential wild pointer dereferences issue regarding APIs
> class_dev_iter_(init|next|exit)(), as explained by below typical usage:
> 
> // All members of @iter are wild pointers.
> struct class_dev_iter iter;
> 
> // class_dev_iter_init(@iter, @class, ...) checks parameter @class for
> // potential class_to_subsys() error, and it returns void type and does
> // not initialize its output parameter @iter, so caller can not detect
> // the error and continues to invoke class_dev_iter_next(@iter) even if
> // @iter still contains wild pointers.
> class_dev_iter_init(&iter, ...);
> 
> // Dereference these wild pointers in @iter here once suffer the error.
> while (dev = class_dev_iter_next(&iter)) { ... };
> 
> // Also dereference these wild pointers here.
> class_dev_iter_exit(&iter);
> 
> Actually, all callers of these APIs have such usage pattern in kernel tree.
> Fix by:
> - Initialize output parameter @iter by memset() in class_dev_iter_init()
>   and give callers prompt by pr_crit() for the error.
> - Check if @iter is valid in class_dev_iter_next().
> 
> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Your reply to earlier review made sense to me so I'm happy with this.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Alternative fix solutions ever thought about:
> 
> 1) Use BUG_ON(!sp) instead of error return in class_dev_iter_init().
> 2) Change class_dev_iter_init()'s type to int, lots of jobs to do.
> 
> This issue is APIs themself issues, and regardless of how various API
> users use them, and silent wild pointer dereferences are not what API
> users expect for the error absolutely.
> ---
>  drivers/base/class.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 582b5a02a5c410113326601fe00eb6d7231f988f..d57f277978dc9033fba3484b4620bcf884a4029f 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -323,8 +323,12 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
>  	struct subsys_private *sp = class_to_subsys(class);
>  	struct klist_node *start_knode = NULL;
>  
> -	if (!sp)
> +	memset(iter, 0, sizeof(*iter));
> +	if (!sp) {
> +		pr_crit("%s: class %p was not registered yet\n",
> +			__func__, class);
>  		return;
> +	}
>  
>  	if (start)
>  		start_knode = &start->p->knode_class;
> @@ -351,6 +355,9 @@ struct device *class_dev_iter_next(struct class_dev_iter *iter)
>  	struct klist_node *knode;
>  	struct device *dev;
>  
> +	if (!iter->sp)
> +		return NULL;
> +
>  	while (1) {
>  		knode = klist_next(&iter->ki);
>  		if (!knode)
> 


