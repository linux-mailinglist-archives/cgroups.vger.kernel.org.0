Return-Path: <cgroups+bounces-3602-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815792DB60
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 23:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FD1B215E8
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBED13D886;
	Wed, 10 Jul 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebpiPj9i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB41422A6;
	Wed, 10 Jul 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648754; cv=none; b=MToc1pP6MAg3pKOiP1O1WsZBwjsyYY/Kobq2DHgvr8Tw1uMS2uv9icnn2GpIFHHkSs4hCLX/T2b3X5Xeck8uCR9UrbetHKEhaTGINASk9GIbCsPWpCyux6c6J3u0WVeMeDB+pB1DxonW4qRzW/xZIlvwpp2kzIIT4SF9ujqeRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648754; c=relaxed/simple;
	bh=Ra/VIa64a9p2aYTQXs9tDQX3Jnsk5wN9WeKtgaRSi1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfqYlFn5Rmoqi5dsohS8tZySeOBGr7bFeey7SHZR4dWa3vD6XrC8tGiHc3a51j4s9dyVs8AaMdEC5gBmPufdG4y7ZMoYc7pGT9EfzJtjhxjdPBGaZ9kZF0KJgpiPodU+dCTmO3VkQCpc5XUT50BMrZzHHBRiqCoYYw2kaLGMK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebpiPj9i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fbc0a1494dso1318155ad.3;
        Wed, 10 Jul 2024 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720648752; x=1721253552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTTWyfxS94vQpEADrnP7Gp6YumoVUZyuscVkMSUtAEU=;
        b=ebpiPj9iBuaXfwRp2VKnw9ittm1xNmtq2fHx5paI38KvV8jMqt9OlN9ThlMCmVCcRk
         YEp1dy3YbH6mFN7gh/mIFxGBler5gvz1XxtshpGpLTvNknBqTu0yrqylVXpF8bwfBgdT
         JB/0xtfWTcXABtte0GtfnyBAMdgGxOTP4CIa5pzefruItUpDPyy/2J1gm/7Sf+HeL7P6
         BmZSprdc4+K8Ijb9HyZCImQ3TAWhBcDjkuEnj5IczjpYGASPTlyG46B/A4Hg3Z901m1s
         3mN4AmK8g+CuENbbGJqVnJeQv174xQCkibfpImKN5SlAYB/QeflehAZTkS2httLV+yBl
         gWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720648752; x=1721253552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTTWyfxS94vQpEADrnP7Gp6YumoVUZyuscVkMSUtAEU=;
        b=uaTLr2brm23WmSj+DX8+QFamdXisS2nE4UpkSGgXnD0NT7D2EQXI+QSm+CFf5fXRaq
         I0M3HJMvACtihHzP1McSvRF/MPqnWr7RqCZv1VBCCdgpvIEiZbhBwNDNdFGwgsRZjZZQ
         YEDBV7fIM2I5eFqaVYufiH5C8hnTTMONpali5ulLVKcUsHwVNB6sma8SxuPqkA+Ip7QN
         L+SwXa3KIpGjUFctHR7Q1YQwjX67UAmbdJnkWExbwCI9xKdztpx3jA2UzhqW54uMleGn
         3TNkvjFuv7MBodObk1nK9Qx2Avp7uP33M+Eid66vr/HnOM9VY85DeeRlJ04hUhM+jC3X
         E2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlDEBTr6N1f/YZIhTm0qFiDhUc/zk3aEEDYmzT2HcQRIbxxN7rhoJjdCRlCP8WMBXjF6ypo+7N2VkyEozTgGf+bBzC6chqftrXRIMaHF0CfAqjSFdxeT2ZzoQPdxruS20jm1ovKbLSefoJzn8cYduxoCtxCv3g3Cqn5pYKIOvbEg==
X-Gm-Message-State: AOJu0YzADNmnYaBGLmM02FLy7XQcvzLCi8kLmdMuPb4HsdhD92zaEiAH
	hRXFCU+iDs8A/2snS6HhtWzxSZ7tMwWtyBQxF5oUQhsItrfj6RrW
X-Google-Smtp-Source: AGHT+IEqnjYk2qahj3yH9sWC93FInUzPpcHeoyzJ98VlBS9kOCuu28w45p08diAdXUOLMyIuw/UdGw==
X-Received: by 2002:a17:902:e74b:b0:1fb:4a8e:7673 with SMTP id d9443c01a7336-1fbb6ec4f06mr56068765ad.68.1720648752222;
        Wed, 10 Jul 2024 14:59:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad0387sm38335425ad.274.2024.07.10.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:59:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jul 2024 11:59:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <Zo8ELsGOyFwkpKUj@slm.duckdns.org>
References: <20240710182353.2312025-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710182353.2312025-1-longman@redhat.com>

Hello,

On Wed, Jul 10, 2024 at 02:23:52PM -0400, Waiman Long wrote:
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 54
> 	nr_dying_descendants 44
> 	nr_cpuset 1
> 	nr_cpu 40
> 	nr_io 40
> 	nr_memory 54
> 	nr_dying_memory 44
> 	nr_perf_event 55
> 	nr_hugetlb 1
> 	nr_pids 54
> 	nr_rdma 1
> 	nr_misc 1

So, css may be too specific a name but this looks a bit disorganized. How
about using controller as the common prefix? Maybe something like:

	nr_controllers_cpu 40
	nr_controllers_io 40
	nr_controllers_memory 54
	nr_controller_perf_event 55
	...
	nr_dying_controllers_memory 44

If controllers is too long, we can shorten it somehow or use subsys, maybe?

Thanks.

-- 
tejun

