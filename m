Return-Path: <cgroups+bounces-296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DA7E73A8
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42646B20F21
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BA38DE6;
	Thu,  9 Nov 2023 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqMAEtXx"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887738DDE;
	Thu,  9 Nov 2023 21:36:27 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA83C30;
	Thu,  9 Nov 2023 13:36:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6be0277c05bso1313175b3a.0;
        Thu, 09 Nov 2023 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699565786; x=1700170586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvWGeAzGUIZytQg+FG+y9b06sq8rOCVnBwaDbkRKajQ=;
        b=OqMAEtXxQN2t1RJq4kJyDzFspCS8UyUowVk4uCdXDGepO5LvqoLjHcCgTQKNqI2a2r
         5Grf1BP3+P/qPGcKe+ZgiEougdNbphcpO342QGnfHGPKJ5OqWeVM8+lXi8CgcNfdKoFw
         AXOx7Er84k8YhChJiJLZIYFGqAPoC2m5dgdnCs0kWllMwprJ7MNWSj2iCVJK6t9091IQ
         RUKuggAaStSQeJv86WhPccqbyme8UebsSq3x2BARlwtur53wHET+YRKSXsDo4qeizLgZ
         7UPaBbF1obfZno5wPDBNroZygTT2gNefmwL3gVdpNinyn+6BczciD/cbq1AQz5un6jhI
         hO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699565786; x=1700170586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvWGeAzGUIZytQg+FG+y9b06sq8rOCVnBwaDbkRKajQ=;
        b=gCKn6j26uTMh+RhQGast4/r1hzH7Tzkputnoginy2v1zdkYiPQDeSWlhb9GQh3Hha1
         xbFYscOsHwReqEnWoodvHqg8LJARbK7sVUULR3JR8Gfkmu2FtPkGHDCEueJO9BWbm+fu
         CPTWdUBk4GmT4x5TEMFsWLCQKGpK/F6qO2fwG7CSvX72r2NSlkoP5ncSxtgBy1GOQbVj
         4e3KvLeBDlDTiYNksjp8DypSOzN5ACtmynQPAvJevSIZiRyHq5y77lMn5BkmdWyea71Q
         PlmSGPlwZ7RsCBPRi1tYAgn+fJx6SsZk5LEVlKDm3JzYJinIo5x5oFfS38XQFiTBw7rs
         IaPA==
X-Gm-Message-State: AOJu0YzXxFbS7U8zVfvB33UMhF1qYhiK41JhvcUMOzY9vxe6a6UpeilG
	WHrtF3bYfp06xMEDx45niKIbUhbXrE0=
X-Google-Smtp-Source: AGHT+IFnNtLJyHcVB4yZ7UgwomkMbSJZ3E9d/YfEwgLH3dH9O3tN0hWa7aMej1XbeQHL1FyALqByjg==
X-Received: by 2002:a05:6a00:2395:b0:6c2:cb9a:885a with SMTP id f21-20020a056a00239500b006c2cb9a885amr6171072pfc.27.1699565786062;
        Thu, 09 Nov 2023 13:36:26 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b006be7d407a11sm11543131pff.178.2023.11.09.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:36:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:36:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 00/11] bpf, cgroup: Add BPF support for
 cgroup1 hierarchy
Message-ID: <ZU1Q2CEGwbGNxJNy@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>

Hello,

On Sun, Oct 29, 2023 at 06:14:27AM +0000, Yafang Shao wrote:
> - [bpf_]task_get_cgroup1
>   Acquires the associated cgroup of a task within a specific cgroup1
>   hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.
> 
> This new kfunc enables the tracing of tasks within a designated container
> or its ancestor cgroup directory in BPF programs. Additionally, it is
> capable of operating on named cgroups, providing valuable utility for
> hybrid cgroup mode scenarios.

Sans minor nits, the whole series looks good to me. I can take the cgroup
prep patches through cgroup tree but it's also fine to route them through
the bpf tree with the rest of the series. Please let me know how folks want
to route the series once the minor issues are addressed.

Thanks.

-- 
tejun

