Return-Path: <cgroups+bounces-1923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F9686D431
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 21:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FC11F23E1E
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338601428EA;
	Thu, 29 Feb 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZx/Wzeb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0913F447;
	Thu, 29 Feb 2024 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238530; cv=none; b=DWiHfWIWkL21BSd13O3A445zlq3+f308CcdWQYrF4dGMdRC1yZQiAqv+LMnK/qlb6H6XI3mN3UHtNw1FcXW5jKQtWZyhkOC6gt/lYzHXK9kx+RDngOXtI2/eU7T9V2fE2EyI7PnS5BHRXx5WCoo77Y60htP0ODNuFI6JmzK7cz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238530; c=relaxed/simple;
	bh=KFX1TCMwnm/yL0uHJIWoMdu2yhBd4riGw+GeL8KJaF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLf6Rm0XP+wiedmqLtvkaKGEklpesdHk/N13nH8qWpYqTpSArT+FkgV5zzGVrP1qJurOaKrVwPqgQqvEKqYilokJe8/UfoWG50LsBdbiJQwN8/loJKLQ77gYo8CpoQ1VEDEjA20kWOlyKIJ+fzPlLc46qNi1bnd4DuQDaq6aMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZx/Wzeb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcafff3c50so11789845ad.0;
        Thu, 29 Feb 2024 12:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709238528; x=1709843328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VSE+Pm8C/sEK5iU2pg56gusVe39c03R2dAi7lJgdVQ=;
        b=TZx/Wzebt2rzqyXN8RSVDwErWQV+EpSbv0cWukYa+vzJ47b7HuolBnrNDuEyJJV3/8
         9PHu54xTlIYaBce/cK4XhcKrBn5fU6ecnTuwCIBf1SqTBof3UunUuOYOiye6yMGibLZ+
         MALgCvKQkKLyGd3YB+tunO8lIuHNdxHLhPksrmfTWHeHgDy/jbX3YkYfw9+SUPzFK8F4
         56CeqVlDrv/DPuPBGHrqJbNRmdxfxRzYwNIbGB8Jm6WLiRrWfpQEwCfTkWpqO877VUFB
         9xqCHl0yBqyi6xJh8YN+HaMqyzmNU/BakwraV61l5+bMZIgNP4fP32iYaJ1Vfo8d52ng
         xLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238528; x=1709843328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VSE+Pm8C/sEK5iU2pg56gusVe39c03R2dAi7lJgdVQ=;
        b=P2qFaIbgEK6UQIJRDNecCN4ewTB9QbphVH3IOd+1BEzyo/LI1Ko37ugDhz7iDZvL+o
         aMh1Th2v8XsbVlicWBB44X+dWZ8H9upF8V8GXzneWHnF8HCdk48+pMunrmXy7hLcXOs2
         bSYa8x4CIMBBbZDTu88z+3Oq6Q8m9aksSCd4X+rbwhzWfWKtBrxcYQUfK9vsHyeu8Tla
         oA9AOt+G4AGoBbMCHjCvrZzUl/sOX3hupEW3CGY3S5av8w9EzkqXVmJ78waBmtfUok5F
         g3pJFFXrCrk1ZQPzzoeA4DIKLLuDHYzHhIBDYUkKScOgMmfBlvSAAa1twzHbhE5kXbt6
         jJOw==
X-Forwarded-Encrypted: i=1; AJvYcCWscRtEyfDFGiT6+YSMKtBdWX3EkXzpTASRltdtFrF47bohggu/tqnsArvJUdEV7H53FVe3UKm6JYheer7ryNXiFrdR2t4LetVCNtUu2xEKy1jZIYRKqvkf1csxVCkWVaZijB5Y6LY9pusD9Wrksb+s/yI207OPT42s+MuckCX6yoFNayyRYI2j+i7VzHyLeHwfsyGkkXzj9xEm5Q==
X-Gm-Message-State: AOJu0Yxw79B6FghOU5npwnZwnIbONjceC24J5g8g77zAbLm1XG1fVeDD
	sKxM8HYcCgdvxzYifrklZlalDNrFo2hwjflj39kKrFDZzuvvJuQ4
X-Google-Smtp-Source: AGHT+IGRU+IzisICIwXmJa1iH8rdoES4zwYMUZNyG1kCHKTbFlaZJKAx3cqhxR9JFJXiLqyuOKk7zg==
X-Received: by 2002:a17:902:e811:b0:1dc:7856:2210 with SMTP id u17-20020a170902e81100b001dc78562210mr4168597plg.36.1709238527798;
        Thu, 29 Feb 2024 12:28:47 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id kw13-20020a170902f90d00b001dc90ac1cecsm1917293plb.284.2024.02.29.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:28:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Feb 2024 10:28:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiongwei Song <xiongwei.song@windriver.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	corbet@lwn.net, vbabka@suse.cz, yosryahmed@google.com,
	rostedt@goodmis.org, cl@linux.com, chengming.zhou@linux.dev,
	zhengyejian1@huawei.com, cgroups@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Remove cpuset_do_slab_mem_spread()
Message-ID: <ZeDo_U5j7N7sH_v0@slm.duckdns.org>
References: <20240229142007.1278610-1-xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229142007.1278610-1-xiongwei.song@windriver.com>

On Thu, Feb 29, 2024 at 10:20:06PM +0800, Xiongwei Song wrote:
> The SLAB allocator has been removed sine 6.8-rc1 [1], so there is no user
> with SLAB_MEM_SPREAD and cpuset_do_slab_mem_spread(). Then SLAB_MEM_SPREAD
> is marked as unused by [2]. Here we can remove
> cpuset_do_slab_mem_spread(). For more details, please check [3].
> 
> [1] https://lore.kernel.org/linux-mm/20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz/
> [2] https://lore.kernel.org/linux-kernel/20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz/T/
> [3] https://lore.kernel.org/lkml/32bc1403-49da-445a-8c00-9686a3b0d6a3@redhat.com/T/#mf14b838c5e0e77f4756d436bac3d8c0447ea4350
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Applied to cgroup/for-6.9.

Thanks.

-- 
tejun

