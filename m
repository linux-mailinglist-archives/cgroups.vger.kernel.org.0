Return-Path: <cgroups+bounces-5909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5175C9F3456
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 16:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43DF1884D53
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56D145B21;
	Mon, 16 Dec 2024 15:21:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE581ACA;
	Mon, 16 Dec 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362475; cv=none; b=AgQwTbZ1PK54M70jwZ8W1hUN/9yCqSwYXyM1yzfcgBM07y2YbBOdrnogjHdBoGIg1Ux6s/yKMuMBQ6N4i7zsaSZ57shRPQCN9tnK50E5ZnKYSW08tg7XN9rrWIE5icypRo1SQi6bU6XpX5beCaZ2RAVJkVe/8Uhi+MVOGBDeO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362475; c=relaxed/simple;
	bh=aYXo5v2Yo9uzhjj6CHEdDeXbI+DPIxXZvbaUn/mWw5k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGhaYC54opbLSsgBwu03b6wfrV1zhvWJT1tX/ePQFVrV0OCCR8PZmn8uI0oY23ze1jZrWBmJ1TN2BpVHIgI/WpkHC9bG04+fjSex7n6ge+n6thgR0LAAvXaJY5Q6gP9nrH6wD7DizWft2LEByR2j+xT6PpUAqNZJuscvvSnSE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBk8N6J7Gz6K5VY;
	Mon, 16 Dec 2024 23:17:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D3181400E3;
	Mon, 16 Dec 2024 23:21:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 16:21:10 +0100
Date: Mon, 16 Dec 2024 15:21:08 +0000
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
Subject: Re: [PATCH v3 6/9] driver core: Rename declaration parameter name
 for API device_find_child() cluster
Message-ID: <20241216152108.00007f7d@huawei.com>
In-Reply-To: <20241212-class_fix-v3-6-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
	<20241212-class_fix-v3-6-04e20c4f0971@quicinc.com>
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

On Thu, 12 Dec 2024 21:38:42 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For APIs:
> device_find_child()
> device_for_each_child()
> device_for_each_child_reverse()
> 
> Their declaration has parameter name 'dev', but their defination
> changes the name to 'parent'.
> 
> Rename declaration name to defination 'parent' to make both have
> the same name.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

