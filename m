Return-Path: <cgroups+bounces-3570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C192A918
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F8BB20DAF
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9314A62B;
	Mon,  8 Jul 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXyjvGhK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF415A8;
	Mon,  8 Jul 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464174; cv=none; b=LIlVOsH8e12vIOAzyPufES08D8XmETTN4K45gSiZyC4kclZVL36zRg1tZRY4hLCv32j9M5VhprBBMBwe5uuXOFzc/3IO/XpyvpuKc5PuA/Fceionvt22d44tSsl7P09qCH1Lg0o9zt0lCs5E9CvYVg0F1bEiGhu74KQmYqLzgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464174; c=relaxed/simple;
	bh=PqWR/XpYZLsU6vTMMkvsPIraFSabYOwpSu0zP4jX3fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrih4mA16Ntx0fvqLSRRISHH4I2FTqEw4xQXNzozD/XPxkJVlV5S183N5Mr6XJtL/ovGgpM/rHiq7H1GzQEK2zC0+hgjqaa8YOTj1ahUNyl1mERCGDCrUqfFX8p1nn1txIW0uFaxiZvqU3TpKKpUUMxKQukhlY8np+UuX6M9h6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXyjvGhK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3037b47dso26856115ad.2;
        Mon, 08 Jul 2024 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720464173; x=1721068973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZzA0S2/rv89abjucy/FgCQUzwmKcMTY+mKFOMol4bQ=;
        b=JXyjvGhKbRxDOccMLUQ0QjNjz+UJzACzsO38kJnjmeoRFjN7G2R4kNc9eE3vOxMmbV
         EkwqzVxHUMIwdczfYSsllfU3xXky5YgEKVimdxzqY7j+1EK6VAj6W8Lw+EyxzetPJCbY
         nT317IGZC8ncZ6093zKR9o3ykYw9QFGCr5+9SvQp5tQFRlb53xrtguKRzo2ZngNgvVq8
         SOnYhAUiW1iF9wcsZ6wpCvSuoeGodOQcJPYLCPLk515ZQJcxU/05CPjzRDjtuPwOD4eA
         SCvowxf0AOhnIPvbs3dNB8/rP/Rj/rtP9fB1Xkc3ZPsZLfvBk7j2VVnO6YVDAsJioYWb
         +ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464173; x=1721068973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZzA0S2/rv89abjucy/FgCQUzwmKcMTY+mKFOMol4bQ=;
        b=N7M7jIPAEBHyBwgWc0aU3K0ESUW3CDiVg+ugr3bx5woiGZiTyZEI3EiP4syzKMT8Ap
         tYs8zcIXpYu8i4IeRaK1QZ0rX4NZe42lDhEtpO9PAiUBAoXGVXlsH8Zykp8ePAESoLXm
         RWiDRFfIbeMkFD8OrNMETiwwpXdm5/UxkRBP6p+wp0DLwu8v+a/8j8a9v/9sP4Bipxsn
         LROvTRXvREkzrnWarM0Dj9FZu+b30qkkzjWZE+2lp3kMdxxlQm7WjlHvOk1R3Ns/68VU
         ATce5pu/z++s+qAv1KgdYuGPrALMkHvqjOKCkd2wTZRhbMIPx6ptMB0dC8mYSmmoYs1L
         9DKg==
X-Forwarded-Encrypted: i=1; AJvYcCXzIW9KjeDxLGSo+kgLhBpuItuvnThb5X6BsuOkEx4U94IokXaGC68XGEOi3wrQtk6Et+FZ3gkCmlXvsXQyl+z+TbYczJxUMPvrF8nW3nhfp2OXvSGlIxyD2b3hP77WtMpvKgbGlw==
X-Gm-Message-State: AOJu0YypLXm2/MkfYlIGG8suyiUbHa+gieIrHFh8DOfmCloyf3TPGbf4
	7+JxCHEq3uNhn3mc46Y9a+oIcawiSdo1ACm8EZ6qV8O1wh1ZZZmAR0UoLA==
X-Google-Smtp-Source: AGHT+IH11dwyfadqrAazoe+vTxbRqv5fiKoIhn4AnxNS5zaZgaIAuN33hNIdooE9n1VVNB4I3SMn0w==
X-Received: by 2002:a17:902:eccb:b0:1fb:a38b:c5ab with SMTP id d9443c01a7336-1fbb6d2509dmr2951515ad.12.1720464172618;
        Mon, 08 Jul 2024 11:42:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2accasm1859285ad.75.2024.07.08.11.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:42:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:42:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: distinguish name and legacy_name when show
 /proc/cgroups
Message-ID: <ZowzK7T50fGtgFtW@slm.duckdns.org>
References: <20240706113830.1612319-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706113830.1612319-1-chenridong@huawei.com>

Hello,

On Sat, Jul 06, 2024 at 11:38:30AM +0000, Chen Ridong wrote:
> Subsys_name may be different between v1 and v2. In cgroup v2
> blk subsys_name is io, while it is named blkio in cgroup v1.
> It better to distinguish name and legacy_name when we cat /proc/cgroups.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cgroup-v1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index b9dbf6bf2779..b29252ad91b6 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -677,7 +677,8 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
>  
>  	for_each_subsys(ss, i)
>  		seq_printf(m, "%s\t%d\t%d\t%d\n",
> -			   ss->legacy_name, ss->root->hierarchy_id,
> +			   ss->root == &cgrp_dfl_root ? ss->name : ss->legacy_name,
> +			   ss->root->hierarchy_id,

No matter what we do, this is a user visible change and the file isn't all
that useful for cgroup2 anyway. I'd much rather leave it as-is and let it
wither away.

Thanks.

-- 
tejun

