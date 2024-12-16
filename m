Return-Path: <cgroups+bounces-5912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD879F349B
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35DB7A057E
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ABE149C57;
	Mon, 16 Dec 2024 15:33:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83A14B945;
	Mon, 16 Dec 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363230; cv=none; b=MfileoIIeP06Hlksc1TDzS8cpz90X+KLSMyat2WRwQY8ONicUqRuau5CgC/d5xl6E+5EH2xPgiHuLJ3qxxc7oAHs3f4JkSQbCx/CBPCVmHkS1uw26Iee7gETv4cOlhkZbgom7YPqIDkXSGqfztqx2dVORaiAoRf9F7uAZPJ0MsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363230; c=relaxed/simple;
	bh=VpmOrkVOccri/tfO6yrqSd4TgJr8YRrd8k9AHBSfCEA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITr8pH8GIHtKom6vMyTsZGsGSJlcLCWJMFg3gJgvYSQojCQ9k8Apr1B4Nw2Z6+De8IVlFpA6VwGhs2pM0yj6jH6p7Mje55IwRFVBai6DzgDtLaN2BIhMeqeaeEaJTmUtLCddBuXvbutsAyc6paWGDdVouUx5dXTL9E4+NpfStlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBkQt0ryRz6K9Y4;
	Mon, 16 Dec 2024 23:30:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 88300140A90;
	Mon, 16 Dec 2024 23:33:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 16:33:43 +0100
Date: Mon, 16 Dec 2024 15:33:41 +0000
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
Subject: Re: [PATCH v3 9/9] driver core: Introduce device_iter_t for device
 iterating APIs
Message-ID: <20241216153341.00001867@huawei.com>
In-Reply-To: <20241212-class_fix-v3-9-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
	<20241212-class_fix-v3-9-04e20c4f0971@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 12 Dec 2024 21:38:45 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> There are several for_each APIs which has parameter with type below:
> int (*fn)(struct device *dev, void *data)
> They iterate over various device lists and call @fn() for each device
> with caller provided data @*data, and they usually need to modify @*data.
> 
> Give the type an dedicated typedef with advantages shown below:
> typedef int (*device_iter_t)(struct device *dev, void *data)
> 
> - Shorter API declarations and definitions
> - Prevent further for_each APIs from using bad parameter type
> 
> So introduce device_iter_t and apply it to various existing APIs below:
> bus_for_each_dev()
> (class|driver)_for_each_device()
> device_for_each_child(_reverse|_reverse_from)().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

I'd normally argue this wasn't worth the effort, but given you tidied
up one inconsistent case in this series, fair enough as far as I'm concerned.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

