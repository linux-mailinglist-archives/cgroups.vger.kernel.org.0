Return-Path: <cgroups+bounces-2447-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E128A3497
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0A61F224E3
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585514D29A;
	Fri, 12 Apr 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brjzMzrj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354A14BFB1;
	Fri, 12 Apr 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942441; cv=none; b=pxpsog50BN6hkTWJSECJc/2hx7U/Gq8whWsMjsL05XOhdHuj8sGglQrBz6TbIdbzfpATn1Niy9G/nP2L80dQfvMvsFZDK8royRxfvARf36U9K6oDm5n5wovUx/++GsvcvBXHdjaFj4wHqYux9Xq56r1EBn2jxSlRIFtVC46fmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942441; c=relaxed/simple;
	bh=a1wk1OqBciJqZ7yBicCOBHEJpruyDLFfrzUJMd6JthQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOwXZxKsRRnedfcDX3t/2Rl9Lri1bPzCVnBHh49Qb7t5HfYAd6UmDNGAGmgXFK2tQqT85oept52y2PlS3ztwiGHj1YaOBm6HleSU95rs36sklhGaFesqg9HVOP7fNAnWz6nm1eo00cjwwv72MPSTDGhZk359IEfxdEyaYX37qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brjzMzrj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so6607715ad.0;
        Fri, 12 Apr 2024 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712942439; x=1713547239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJ5C18NZDFm02iL6S1RPc4RabDu1qzQWJrryPnRBtvI=;
        b=brjzMzrj0h+srQQ4zuqhWoek8RDyjnfYdkurYkgJPcP3L2bsQNNylU734r3J3LQftY
         u5eX99dgmSwIWTrU2UudpwqEG46CqXapv/lJmRTqTdbOsmOL6pf2JW6mi9pkPSM7Xkfj
         Alr7Id3p4Qf3wEdeNkB2WRJmWHEshU4Ps8eLHHD25TCRNGg1vY2a81WjNfZ3N5yA9CF6
         O2foPKt6yXfFdKHvcimHHpHZZid/+zj8aOlGP7Io3UAtKFB9gnNDEUMWtEUXbhJQz8kY
         xuSBXX/bNeS9rO7R8bKzxujyuCjdudVvjQMiPnekLCgfXoOJu9pW4+WhnaoGOI4Kb4Vi
         1Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712942439; x=1713547239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJ5C18NZDFm02iL6S1RPc4RabDu1qzQWJrryPnRBtvI=;
        b=rWHKycjVq0IKqX6pY8z0A7wHOXskxe9gJJQ0oAeIrecZkZghaDhBQyAzoYGvtIVJbo
         4SgyFuLgQZWTvDtNWOhGCLXJL5wtkey7Sl4Fi24g3IdnHJV5I//GUnxUuuWuk+DuGo89
         UehVNz1NozyN8j8mk8JnwP0R9tBMVoRQmvl7n4S6+XudL4TZLuBrz2b06LWKF0Hlu8X5
         Ko5/+7wnYPXFqi/S+PbTgT7Ycl+ai1s2FssfyACfK4PtHqJu6MIfqvkXoW25ol7X+tAb
         KGo+cgOfZCMcqB4oGVosWTGFqJAXo7dU3x9VtcJlpbLIFq6EUj/lqeSYUfJ1CXQjxR+N
         Hl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRD/kagrTGSu/pQy/3QyvkeusucTTPlTIbZQ7MgUJlC/6LqK3g2dMSebMWALTyKr97eUHY4HNGkcBisERNO28imFXSbggfqTPZO06iOdAqPFPiqkuJZGbv7PVnIevKW8YxyhaVlw==
X-Gm-Message-State: AOJu0YwRU89VZxuhcH9zVJc5Z6I/DEr3BJF7GQnx6uSrf16OeFR3QESY
	HcJQA5R3glGo1hBc9PbQGMhipBK6nW0noXcpG4SiXsGy+2/jb3gj
X-Google-Smtp-Source: AGHT+IHIQlKworlPc8JdskXV7pjdsP4yNYr+Jkgmes8DOOAfxaMu7Ki6/4KIBuesThy1iJvrJKBtdw==
X-Received: by 2002:a17:902:e811:b0:1e3:cb8d:e28f with SMTP id u17-20020a170902e81100b001e3cb8de28fmr8232776plg.31.1712942438893;
        Fri, 12 Apr 2024 10:20:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001e2a0d33fbbsm3220724plg.219.2024.04.12.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:20:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Apr 2024 07:20:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: move proc_cgroupstats_show() to cgroup.c
Message-ID: <ZhltZYSWbKkMHmQv@slm.duckdns.org>
References: <20240412025402.780603-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412025402.780603-1-xiujianfeng@huaweicloud.com>

Hello,

On Fri, Apr 12, 2024 at 02:54:02AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Currently proc_cgroupstats_show() is in cgroup-v1.c, however it can be
> used for v2 too, so it's better to move it cgroup.c.

This isn't all that useful for cgroup2. I'd rather just leave it as-is.

Thanks.

-- 
tejun

