Return-Path: <cgroups+bounces-3182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2C907EDE
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 00:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015D5B219A9
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1D14C59A;
	Thu, 13 Jun 2024 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8s0yAuL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368214036A;
	Thu, 13 Jun 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317822; cv=none; b=agTtfY2pkzBnXtcGZM1fphqJdH5vAunPjEme6netxINUzMe12VQ4B78Iwl6x1H29N7bitdRSNfBR7UBKlJtutYFBvsJjq3xD6u9R5OnS5prgTpg6TGMhMyR5F9FpRyGvk9UhVe4t6U8k4uuP8PPdURSZipUT3odRb1qCteMRa+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317822; c=relaxed/simple;
	bh=NKDalVH6Alkzs99xyNRZD+TbiSjmpgECUZoiufDwFWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Knv8XxF++lrX7IeLi4FicFZJsB4lsOtagagIFLrDUjirymtHA8dVnFHsCMQH8eFIfTe15vrYh+oAqSoWojqO+GygK3BkntM1ADfvMUD5iTJycWsVHDZVsU9aLFri5Sj6OOHq6AUFP5W2cVeWePcloy7P7PeMND6U8zbRGpp78N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8s0yAuL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c1def9b4b3so1325421a91.0;
        Thu, 13 Jun 2024 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718317820; x=1718922620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+VuzGuWCKxOWk0FlTi0998ap+SSuM6fC8aXjemEAi0=;
        b=P8s0yAuLfI4eBV+WdMh9NYM5zz9IkVMHe+qcrbnxfOCDGRAJg6hGpN+6YSFeqFx6ry
         rCmHTsi8HCGcP8vnSFVB091uqJKBKgAqGisW5pdZ0CR5HyVTqFTGeK/qgxJnEfySgqWU
         GoRD7n2jHm+a3nZ2ZTtlXPxR28dE2rLiaLVuG2bzUks7Z3wZe4f24n/3dI7MP69rWC3M
         2WJKkkYuhtC7bIabx2tTZPtYu8StrAbkozxYS6sgxnKw+26nxT+Me/iNNKpWctkjvO+M
         ZHg7lMONfLfN7pxZb3XXQsrKk2ea9GHCyhk3VPImdIjNUwIxmWT4SS45+5qvxC4FRO4Q
         /nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317820; x=1718922620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+VuzGuWCKxOWk0FlTi0998ap+SSuM6fC8aXjemEAi0=;
        b=b/pmymz29lh8pIGjczQk88LUebNcVqUHWeL7foVdVBtpFx9yPNGhzg0gquX4UOQbm7
         zk8dbQ2DgsA/nsqv91dixoUQYOOhtL3lafp2DZ8y37Mt2Ry8iFLSMOHU1Sa1zeSIg+4W
         jfu6hhBwNVBBWr/NH1mVQDl5dlH+W4u3teeBugdhNMqxggEQTxz1rikcNxI0/2ZGgq3d
         T9Q6Hgs8JtGX+qByM+3Gf/JsjHoTOlhkNQKrO06BIhqhOze9y5HYh0wUile/nUvuMnRu
         JzD0hy0IBYdvRF4czsgN6pxBvmLQGcqBVh1ud01P++ITmpC+QfUfCHJSX3JTGbwYA79j
         YnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyLDdUK6znwZc/OxyRZiWWpRr8f6ONDg46aoFGaah8185XW9gZkW6tNSOiMInkNs6N51X4bADjtSFk8PdQfj4Iwm9Fkvbin/TqzLnEBhIa8bL8015b/1emyV30BNuurZ+iXnUS71ib00ZmE0pbccAmVNQVCbcr/wYRwbI6Y0WxZQll
X-Gm-Message-State: AOJu0YwXV6sBz3FnwloMpDmk5iVFKRe9xisVLgyrhSzphproxX8ApbW1
	cRlTjKOk+ONcpQrJ2MTzp1R12Q6Jsf0KY5eZtyVqjHdiVTKDcHaj
X-Google-Smtp-Source: AGHT+IG5mhehfBNmhsizIU+P0AMlTYlCE2kduz3otyBe2Fi1criI+ix8AY43UDQbRuBGJfMoSylJRg==
X-Received: by 2002:a17:90a:43c2:b0:2c4:bbd9:83af with SMTP id 98e67ed59e1d1-2c4db24bc6fmr1219174a91.19.1718317820120;
        Thu, 13 Jun 2024 15:30:20 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769bc48sm4612029a91.38.2024.06.13.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:30:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 13 Jun 2024 12:30:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 1/2] blk-throttle: factor out a helper to get
 throtl_slice from tg
Message-ID: <Zmty-hsKsPFazkVf@slm.duckdns.org>
References: <20240513120848.2828797-1-yukuai1@huaweicloud.com>
 <20240513120848.2828797-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513120848.2828797-2-yukuai1@huaweicloud.com>

Sorry about the delay.

On Mon, May 13, 2024 at 08:08:47PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are no functional changes, prepare to use bigger slice in the case
> that iops limit is quite low in the next patch.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

