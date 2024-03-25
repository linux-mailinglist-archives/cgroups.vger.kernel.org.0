Return-Path: <cgroups+bounces-2155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0F88B102
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DD302997
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C841C79;
	Mon, 25 Mar 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htJqKgRZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F14CB54;
	Mon, 25 Mar 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397463; cv=none; b=RCZxZEtKljvmLortnzit262z666ZovgTqxIFhSGUt3ZlcPTv9UV6xx4UjcZeAWaUDGPfHVhlXzIVBh6gTAKhjYZaDpW1RSMVOGWDzGQMmfK7gmaj51o4j+zz4lz/UjQF5Fm5xiLS1yGydnKruXCPnRRRML76yHKKbUAagKmtF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397463; c=relaxed/simple;
	bh=PNkdq8pr+5/0BOac7guOZWZ/0739SWPnMQvt5yz3G5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOO+nMlIWfMaq4WsHm7PuatKZfmuRH2BxwgwbGKm1NAxrIXSb8em7CGpFg6h1tHIt+sXFlqVmZ5XArltXK/4JcfG10wdEDfR89XaYdXGURsDZD81Qq2WLY773dPjJr+I6/UfArhD+3v792175t9Go+2hX4hgg/wXf9CYTXi00zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htJqKgRZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so1760774b3a.3;
        Mon, 25 Mar 2024 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711397461; x=1712002261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJoOIB0fogtvrTT+C8zAsHm4ytpCrvGQJ9GOYtKix3E=;
        b=htJqKgRZx3V1DGh5I/fzR1tNWFFdfVqhk/3Gd/ynlpye879RmXXoObSGauZoyVkS4P
         PmoHrOJgH6AuGyXYYFjNcYKElP+Z0MbyfX5wa0ywA9sVMhhItKxxntiq6j7z0qxcS13w
         bxpWLvexHuL0MvTTnUpyNBa1itUMSeG9Gxd2EzB8Tactst5CXA/zWZEjOdNy9YVQHtAy
         JKcgne4Adx3IlLPkwMOtKrGbVFL7fELhqRN1W2wf955O3VikPCJ83KGU/WEef070jVh9
         Zui1lAWcbK+go3SQE11dLs3HPc76gLtxhtieoLEck83NXnWUemG12yhpY+D+mJ/Zui+x
         3P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397461; x=1712002261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJoOIB0fogtvrTT+C8zAsHm4ytpCrvGQJ9GOYtKix3E=;
        b=D6Gk0Nf9w8cmZNCXCDnavJgTm1zPb/zQaXHukYsjINCkI5jpS2bVHanumf1z3/J1Vl
         zSzyTcWvMp2xLaC6rZgl4LzEQ7uWKIltdxG9KaO3sZrlrSeclEbsrSoL8eMYaQoCn6vD
         xGH/G2h6U/Uk9qqHW4CAk1GNm+KqUrQmWwfiHcAm+7AhYKZdZRyGXU/SMO2yT276pEyk
         qmQpVihpwd1D8SWXcxNsvYY+ogYtXgL/fO3Sv1ArOyKNZgp1v01DIWSBsfLkKXf1p8vH
         JlVIzxMSqMAU89qO29sbX9AI/wDkSvAlYWZQrpuQ+dDc4kXp66Kz4hsPd9uXVGjXhuum
         TpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWa55PeQxgxSaRTH8LgulHVcleNoiZlLqHqJgWNvad5oR+vN8kXaZOVeS8iGt430QM1aBW7+ic8C6Svxh1rGYTC7MuLo0i4DNzYdmHXlpoftBACVy5go6Eo87kL7x6a4vxvk6Gz1xUQqLtmlTR5MOw6EcZ2S4hWtDZQ15o3ik9/DA==
X-Gm-Message-State: AOJu0YzQrfvZqTVBEk6hppqL1feYPfBmaAA4rUpW/JOJtJ6DQ36EtOj5
	6yLRjpeBmCBHUzlNa0DiZAmkeNtpetFW5nWeKGVGGgPoehAJvUAy
X-Google-Smtp-Source: AGHT+IG6+23l+DCHgviNH8KCgnuW/5vBLq+wX6KAos6vs6ZBRaL8uWkZFNVZAIOAqs4YRBdPtwvOWQ==
X-Received: by 2002:a05:6a20:3ca2:b0:1a3:6dbb:f072 with SMTP id b34-20020a056a203ca200b001a36dbbf072mr7584599pzj.8.1711397460946;
        Mon, 25 Mar 2024 13:11:00 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id o18-20020a639a12000000b005cfc1015befsm6146297pge.89.2024.03.25.13.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:11:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 10:10:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brent Rowsell <browsell@redhat.com>,
	Mrunal Patel <mpatel@redhat.com>, Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH] cgroup, docs: Clarify limitation of RT processes with
 cgroup v2 cpu controller
Message-ID: <ZgHaUyeIcS0w_udY@slm.duckdns.org>
References: <20240320142302.1790171-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320142302.1790171-1-longman@redhat.com>

On Wed, Mar 20, 2024 at 10:23:02AM -0400, Waiman Long wrote:
> The limitation that all RT processes have to be in the root cgroup
> before enabling cpu controller only applies if the CONFIG_RT_GROUP_SCHED
> option is enabled in the running kernel. If a kernel does not have
> CONFIG_RT_GROUP_SCHED enabled, RT processes can exist in a non-root
> cgroup even when cpu controller is enabled. CPU sharing of RT processes
> will not be under cgroup control, but other resources like memory can be.
> 
> Clarify this limitation to avoid confusion to users that are using
> cgroup v2.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

