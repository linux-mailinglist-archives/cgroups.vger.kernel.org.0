Return-Path: <cgroups+bounces-6016-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA099FC01B
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 17:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9AC16372D
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89051D90DC;
	Tue, 24 Dec 2024 16:21:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4501C5CC1;
	Tue, 24 Dec 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735057285; cv=none; b=n0i9/rEjRhhsj2rHgRuAanxL1J6hL/7b+qcnO+76PnQvXvp+3Acxi3l61/KZEpOOvnhg/O0NZapTYMT+MjkrohXLcL1KmKbkYYdHMDkaT/K2ADxeRiC8paFFi37K1nShbogpVbuOecJdpYCPdnFUDiHwLGB3IlaLHNTYg4yzMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735057285; c=relaxed/simple;
	bh=KfZtNr4kE7RM2R26YfZHfYWXZWYmcV+liWw8IEqXESQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYviECDZS97cl+Q5HaJBVEM/zYq0pmI++sVMuwMXT+TwPUocfREe9JH612mQvWGLMDGQpzZjpaONpEwj212aWsCLNSNj7OPL/Yv0I2kwahvoybqfXa1WhMLWFCUbP2zcjOM/BFK4SdG8UPBgtsRHbfFPrZa31JBO5RZHqaIh+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHg9m4qd4z67hlH;
	Wed, 25 Dec 2024 00:21:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C2559140C72;
	Wed, 25 Dec 2024 00:21:20 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:21:19 +0100
Date: Tue, 24 Dec 2024 16:21:17 +0000
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
Message-ID: <20241224162117.000046e7@huawei.com>
In-Reply-To: <39bb2acb-b003-43b1-af6d-81c99f6b47eb@icloud.com>
References: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
	<20241218-class_fix-v4-8-3c40f098356b@quicinc.com>
	<20241223201152.000012d1@huawei.com>
	<39bb2acb-b003-43b1-af6d-81c99f6b47eb@icloud.com>
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

On Tue, 24 Dec 2024 20:33:44 +0800
Zijun Hu <zijun_hu@icloud.com> wrote:

> On 2024/12/24 04:11, Jonathan Cameron wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> The following device finding APIs only have one line code in function body
> >> device_find_child_by_name()
> >> device_find_any_child()
> >>
> >> Move them to header as static inline function.  
> > Why drop the docs?
> >   
> thank you Jonathan for code review.
> 
> will add these comments back in next revision.
> 
> i do not notice the comments include important info, and think the API
> name prompts what the API does, so remove the comments. my mistake.
I don't mind that much, just that you should state your reasoning in the
patch description.

Jonathan

> 
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>  
> 
> 


