Return-Path: <cgroups+bounces-3455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8A91C495
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 19:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5AEB23012
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4621CB321;
	Fri, 28 Jun 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY433JNO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F11C9ED6;
	Fri, 28 Jun 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595014; cv=none; b=oxeZDyhZmODdrsIXorWlCSe0oGGcz/xVpgdoEIeAwyzd7PILlLOuOeNuGIOgRFaDDiGsmmk6qPwupBRgG1yHsIoI4ugad2kqHpM5fsQDB7d45GRoKhkO1L+2RCmKJJJZIxbvE/jzN6muawSJMifcFEmqVFwuvaOptyEwaIY0OtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595014; c=relaxed/simple;
	bh=PnSNJFMxI0eBUk/rmHNR9tDCSYkUAzwxlRBmBPkvKS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqhAy5CLXsWk1ZYDRrPvhl8AaW6Jh3NszyVwVLH6qyzF0aYUwkf/mvqq0mk8ix5ouZQTn1gwV8JnTQZGL1HNuKc5XDF+Vv8g2ZNMqTDZDvMesLqG83QA1afIWyUfNVVI6K3Yb/nnC5IFE/wGOGn4S6UXBZ4ILKYXcSZdqv1Arig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY433JNO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa2ea1c443so6505075ad.0;
        Fri, 28 Jun 2024 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719595013; x=1720199813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QkcssybePnrl4JAQOb0kLe4ztyV51oH74DZAkItL50=;
        b=HY433JNOpC0xdqoIdU1vV2zurUuq1TBwP89/+lJ4UF8y9tVxBjbC0KutozzI7qjUN2
         dhGHkEHUcKUy6FlBKzQeFlXfHmPI9JgCQbl4+LiJjiKuhIdiCQoTDyEBj6CWzP+lz3ug
         W2txzwkUwg5xAXud9mAX4fZpkEmmWg55pZLF/BEAMmbDBLYGEZpt92xHBD1XzWLctgRt
         nhiptrvaohXuVv8NDOgkwJlEOk5amnroKWtavZHBZ7N0Syp3G/y61nECI9R/cZjxGVak
         ixdr0ksN9bxBgf4ux0mST91YmcO+iveyPfHq2qt1qZ4R8K1g/MvbYBSYeidGcQTz3XE2
         LZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595013; x=1720199813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QkcssybePnrl4JAQOb0kLe4ztyV51oH74DZAkItL50=;
        b=fKuZyeHtz9KUOTC11Yn5W63uf9biFIefADMyFpShqdAlvoJb0b23F0GSos0wgAzd2N
         /6h8RE+ZWU0ewm6QJRfs6+owB6nTFkHy5NPk6ssqZimPTWO7gMayyVHWyl5P8rgDvtcS
         wqUABcLaD7NRTd10sGxPTZ0s0twlAVerL9yoQNs4Qg+onJs+vDzReSiIx6kNOSXbmXkj
         KSaUwuUs1H+G3aZ/dK566b7PWNokaajHWVJDJo6x1AGLr9c7NYNixfzNNnWB+sS08NtS
         yFeCf01PEoGwpT9YyCgOamMc6qzuQmvGmIzUauIwUDE25bEXunS6GSWyhZOQ3QHakFBH
         aijw==
X-Forwarded-Encrypted: i=1; AJvYcCWQjnP6s11bXajCB5BE12peIt9zj/hiCQhOA6Rh9d2fccCn0ky0raOuOpj8IMcG5ed3UFpkz1k8YITGmfuHsGM5lBRLBEMu1+vmMRXoMnNw8I08ZE9kMZoevKkMjQBBDuI2YBvopM3/VcFkpMoDebebhVnoiac+5eXSR3UcDnC6uX/t
X-Gm-Message-State: AOJu0Yw2pS1qgqqgivC13z9V+VW+yEUiw4lmbDupdr5Dvef8xvc78j6D
	6za5VAx7UZNEM7hbWvkUjBzUijizmAU9/YsGB0hu0hovNzT2eU2T
X-Google-Smtp-Source: AGHT+IE1nAigDirdGXsv0n03CgMxZClyloPe7+W9S5Gw9RkG4ZBwvHR4DVubB1qcbpLe8IHnzVRj/Q==
X-Received: by 2002:a17:902:e810:b0:1f9:b974:cbd6 with SMTP id d9443c01a7336-1fa238e4711mr183634555ad.1.1719595012620;
        Fri, 28 Jun 2024 10:16:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8af8sm17896355ad.34.2024.06.28.10.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:16:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 07:16:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2] blk-throttle: fix lower control under super low iops
 limit
Message-ID: <Zn7wA-C9LcjOmFe_@slm.duckdns.org>
References: <20240618062108.3680835-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618062108.3680835-1-yukuai1@huaweicloud.com>

Sorry about the delay.

On Tue, Jun 18, 2024 at 02:21:08PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> User will configure allowed iops limit in 1s, and calculate_io_allowed()
> will calculate allowed iops in the slice by:
> 
> limit * HZ / throtl_slice
> 
> However, if limit is quite low, the result can be 0, then
> allowed IO in the slice is 0, this will cause missing dispatch and
> control will be lower than limit.
> 
> For example, set iops_limit to 5 with HD disk, and test will found that
> iops will be 3.
> 
> This is usually not a big deal, because user will unlikely to configure
> such low iops limit, however, this is still a problem in the extreme
> scene.
> 
> Fix the problem by making sure the wait time calculated by
> tg_within_iops_limit() should allow at least one IO to be dispatched.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

