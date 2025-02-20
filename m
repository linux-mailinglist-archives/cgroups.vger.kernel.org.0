Return-Path: <cgroups+bounces-6616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B1A3DED1
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C5D1890997
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB61F5849;
	Thu, 20 Feb 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NutQ096x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FC1C5F34
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065877; cv=none; b=YeHcllI8uk0Wk76jmCxVT17hValeZNYA/t+dRnrkFWZzRVS8/p/mbnD2vRW+UCuGZ9/fvG5FFy+pQc3MGlqro6EU0G+oY/XGi+YLMf3PAmgFBZoQBczWOJapakJo47z5pmeow1qhbDyoVrYgzIHwmsEyqxdxl5PcmuNJyw+h8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065877; c=relaxed/simple;
	bh=jHv7Xusneu9CcGC6gYOF9bzS4h5Y2fvc7aOb+dNB7XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9AQT2dAU8N1uDQ35uMyyYqNiJpoUJ09llwjZIWJRj0tu1KVnwHthwkQ2kCBtRvnSy+C69SOnzCVYE06+JOUktd1c4d25/eh3fHH5zSdnRdckThmbK98O2qWhnJbbU+oxf+R0tZzvSnK5dlGTYEJ+214gSIUh+mcjoVoSFUWZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NutQ096x; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6df83fd01cbso5085356d6.2
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 07:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740065873; x=1740670673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIhju5VbOnCPzyQKlcCT5jMfOJKAXyz0TX6VSDMcljc=;
        b=NutQ096xM0U0DHbtNMtj1hRhOQlk7JvnsFfZKFfF1HNV1Fs8vwGlJVeZxqbiz/F/sd
         oPVyFLXGgaMRUkUgtN8O9EjKirWzmzagBRFT/N+L/FGK+LoZe9VqX7097z0hV6IOOuc3
         Vq6agqxczG6mxbhWAOD9qOIAcBmSNS5SF9cFj0c7r/eQhJImGR7NBfE/4ahc/kJIHhAX
         hgdLpkD3MMiZe9g2zV8yKGUMnWlbEkBU48Qf9TX/sr0OTQj1FUSSqAIpt/kTymvTsCp/
         eaFJ+hVhJqHYfuybpOZqi2cEC36RJMZ20OdxvSB380Zk5v1Sk0qOX3apZizBnXwiNJXd
         ASdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065873; x=1740670673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIhju5VbOnCPzyQKlcCT5jMfOJKAXyz0TX6VSDMcljc=;
        b=hB6Qr/rTMadipaVmmwNHrpX0XcspgCm20x++baX2JlcVrN+1RUlmM+brO0nbO5pWoq
         rWiZnW+BMGaHQYzyLGxYvGpU/xK41hNc6qlxI69q0KE6gsRRW4N2W0emOSMvhOSpFfyT
         EKNFfkOSAZY5eZIJ5COwAo2ZEvrU4sYi6lMDBuk99wK6nGtP2VffkVmpjBvlEOsEZbSg
         cyCqrBlue2IbkIGcVccHMV/a2trrZXhqqFuAI6cIgKVXA8PN59ICtABdBrPGcxSm2yi0
         So2TSJqte9BP/xFbQBl2wPyGLdAkNGLeve/KMvb1ZibPCPDbDfCWvYafL7EkOBhcjB7p
         +Vgg==
X-Forwarded-Encrypted: i=1; AJvYcCVVuyoaRdlZTiqZzAFnJDT05felCG/SIvSDJUYiRz2Hn7daI+mZsqcCN399oBib0PYdnsTuder1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+OMNt9RDRS1yHMpR2P3GSoQLH8s0T4WUj7tRpvOvdwqDamVd
	hArQUlJTSHptrSGW4kzYjWZv6ylSeeiFaU1r80/7Ir6nvcNIR2fyG1SuaD0UYSE=
X-Gm-Gg: ASbGnctCOQYJF7tn78kQHUG9DMM0opg7pF7wA/46eHHBnnrAaYhNtGyCWSGdqQ8ylPC
	gAynM/Izj6+YZzhkLmYE5QJTvUpZpDLuw4DXcvCplmPUPkRRfrKtHYxdxhnJNf2193tCMlZTr0b
	xqkhoR0q65n87Kb1y5EratyzawQnzZE86Y3Wd95NXCgIcVTgwVsJx5hkBawpSWIejJH57rKBVC4
	lDJ4RPBdvAIqxzrKKWiV7hp1Q4/cILX6gbua+pxfofA7Irv8N2eH4U0qQ/4sVjQHB6iGw7MNe1N
	kLqBQxB8j0Y9nQ==
X-Google-Smtp-Source: AGHT+IFcIm7KN2/kYyHI5w4jBjyHNX4kq0DRfJRG5JubjcBZrPYm8p9wZWeE5aKd+xtJNfQyZ49tZg==
X-Received: by 2002:a05:6214:29e1:b0:6e2:55b5:91d1 with SMTP id 6a1803df08f44-6e697413d1fmr120862276d6.0.1740065873655;
        Thu, 20 Feb 2025 07:37:53 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d9f3498sm86868896d6.84.2025.02.20.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:37:52 -0800 (PST)
Date: Thu, 20 Feb 2025 10:37:51 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH] MAINTAINERS: Add entry for DMEM cgroup controller
Message-ID: <20250220153751.GA1276171@cmpxchg.org>
References: <20250220140757.16823-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220140757.16823-1-dev@lankhorst.se>

On Thu, Feb 20, 2025 at 03:07:57PM +0100, Maarten Lankhorst wrote:
> The cgroups controller is currently maintained through the
> drm-misc tree, so lets add add Maxime Ripard, Natalie Vock
> and me as specific maintainers for dmem.
> 
> We keep the cgroup mailing list CC'd on all cgroup specific patches.
> 
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Acked-by: Natalie Vock <natalie.vock@gmx.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

