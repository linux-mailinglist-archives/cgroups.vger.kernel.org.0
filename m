Return-Path: <cgroups+bounces-4356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D038E957671
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 23:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0F81C21F40
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108615A868;
	Mon, 19 Aug 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDjHpI1g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F5EEA5;
	Mon, 19 Aug 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102662; cv=none; b=PvihpDzeDCmsqA+f49fkPC3DVXlejyWH+B74UflUNTulRlVdR4bE5FFRvZvqB+EfBYRUvOg9oF10lgV6ug/Uy7LrOT2jEIrnN/HJd1sFy1rk2Cx3cnKdZ4ypMUNJAFg4YGvjLtQaaR+9s1TjPSmxT3vfetuRkumLDrSF/X6uMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102662; c=relaxed/simple;
	bh=Ul1pUdE+FyR/Ntfc73DZsDT6L/ZoszcFg+SE2fBzapo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJKLYzRmF2/M/NlwWlYODb7cvmKxGyYFLns5t0/KeTEaLOqTCbbOMOoaghjWh99Z32PHYdmbpxDbjPGp1Turhu7fHs2RXWWJijfe34iLAzcaoOXtGTFxVEcE5msOnly/A7X5RtjaJLsRd4YUu9Y37HsDGDUtsVaUMzT3lHxrF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDjHpI1g; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3c098792bso3749207a91.1;
        Mon, 19 Aug 2024 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724102660; x=1724707460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id/VfvqngaCrZo66Wcoi2BxavDIbaqdIY1sMhnSKTXg=;
        b=JDjHpI1gfTH+Hlc8RP/5nFuWLlME9yr7yXYNa+CRDgv2lVQOj7biKHeTfT4pbgjfuC
         Qpv1gDC6qXhPQQ5Cqega5jvyO9fwIIKA91Vtvp800+S7RSC5G+9mH/mOv3G/DUW8LG5/
         VS/uiziExS1TN7cw7FoGnHv9x2shmgiwzaMVVEWSNYlEek4KBlKt0BhVZ0ye1hqr0hke
         /uNtvis6ikn8Uu54OjYs+v2Z69RlQVgxiV5BF6c6ag+P9oQaon6mJBQ0zavWjqOJBODL
         V+3OjUPB4oOl8H71pmCmLm62KE6GucwORQuv0rv32AK/mIb2zZFqGgjD6NUNNV/JYBSH
         QKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102660; x=1724707460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id/VfvqngaCrZo66Wcoi2BxavDIbaqdIY1sMhnSKTXg=;
        b=oLQWce4RrtWSZ3zLGJAqlbQPNZhja5IKnmkrLctxZUVM6hiytOecG+gtiG6wvzEfAu
         e91j5Y53pN6njEr8POlVnGSHWql4WYkoDJ+Z5EsU/HXEEaGFy5feFhBsGWXg2QXQ0UWI
         3MCBUheWgawfOyGfL6QT7ie4QEUIYnCRt+X8UnAbBLMdJOZYHef4ToEGYtjg95t7b5pS
         XcN6SHbI1oQYUmH6X1JbsCDNzsGF+vk6T0hFaui0xxIPSLvDmA+X+6uDVU7cP5FPZJ9z
         TyBzfakeQWuwUQwl/aN64tA7oPytgZXztRL4WmR+HuN4yl13FdGsNruJSkQCLLMm0Z3l
         ujmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQV0gIqHBcV3UCRRuxBKQ1cTr5jCyEoPot9PDatONTnsfLz8AX22mPDCGynFZ35oMoIrJpEF7wx30kBVpyXsSbFKuH+UoeKQqZqu2RWXvrTGvvBcPr90lvrXMVxnqtASReBy7j+DY5xOxbR9y6KtSs8NHtTsNvBnCrg/nz1oR240Bj
X-Gm-Message-State: AOJu0YzfEGaqdOjk0hWb9qQj67wK6Q43SN0Zi2Qet9P2hKP25u03ELsg
	q2evREGn3PsdLgAHHRHHfEWJrMsR7zWNtHG0wkZ9PAPrjayCO+ZV
X-Google-Smtp-Source: AGHT+IEHDxDEj3j225JT0jQrBbW+qPRGaING10jfKb1b0FAiVoU7WtWO4DLXZIG8Oq9l/x9tExV2Ag==
X-Received: by 2002:a17:90a:f306:b0:2c9:5a8b:ff7e with SMTP id 98e67ed59e1d1-2d3dfc79e08mr13762099a91.25.1724102660458;
        Mon, 19 Aug 2024 14:24:20 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5c112b754sm52223a91.1.2024.08.19.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:24:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Aug 2024 11:24:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: josef@toxicpanda.com, hch@lst.de, mkoutny@suse.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
	houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	yukuai3@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
Message-ID: <ZsO4ArRKhZrtDoey@slm.duckdns.org>
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>

Hello,

On Sat, Aug 17, 2024 at 03:11:08PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> When a process migrates to another cgroup and the original cgroup is deleted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.
> 
> Refer to the process of deleting a disk to remove the restrictions and
> issue bios when deleting the cgroup.
> 
> This makes difference on the behavior of throttled bios:
> Before: the limit of the throttled bios can't be changed and the bios will
> complete under this limit;
> Now: the limit will be canceled and the throttled bios will be flushed
> immediately.

I still don't see why this behavior is better. Wouldn't this make it easy to
escape IO limits by creating cgroups, doing a bunch of IOs and then deleting
them?

Thanks.

-- 
tejun

