Return-Path: <cgroups+bounces-3529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13369268C0
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B47928B6AA
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E331891DC;
	Wed,  3 Jul 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJpW1Ve9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27D1822E5;
	Wed,  3 Jul 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033185; cv=none; b=quN80t9Va7db8617UfgldcPkncLN+hQx7/5rfETobQUEgnjqW0kdsvEFPNddcXXPGw9eV1sFU/AyJygjt5aErz7bTP/1uX58JVnT5WLycC/e/rQFxIFs/Io8QkqEXeMamkQEadPqbP5eabGJ9Tk4yeMUivHEjt3YUt7B1mkwH/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033185; c=relaxed/simple;
	bh=xZ0tMr2lgtIQKAJ+nZbTyo4OVAyOdQQFAHj/Cu8JXaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcehFNM5ychDaapjUvddUxQovgp2fkIU9oFYevDtgF6qsLMc9J6S24RcE9wL4TO3+CBVGKMw/EKagU9AkNWIQuEDsfmE/9oLzqrZSc64gSvnKzduhNfgnlE6GLaJmICpX4eFUh7NSecaZmlSjgeoNPIAM32HaJ1xpG0ZRDDOhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJpW1Ve9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4a5344ec7so7981345ad.1;
        Wed, 03 Jul 2024 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720033183; x=1720637983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IohLYANlTWt9Y373TRe3rnVr5G7ZnH8yifT/Euy+kEI=;
        b=FJpW1Ve97mp61jKTII0vegvRmrdETxX8aZhKcsFBcupwcWLC/+rIVd0ON7MzXeN0Mp
         nb+SVAPxxAox9y6etNSJ/wRam8ikxtEJ44KOuUMuY4iqyM4dxZoGL1zzyx4FmYdpXEvm
         bKbkvOl35sYTzCV+a4ztAAobTv2h6ufKvRMMFuKHTwfdhCkOxCOOWN3xFVfS0tVsnUiW
         RBKh4dZFl0/gwHosCo4z6ylMMbJSt7QnC5X5XYMV9XEHTW3dKy7sBYoaXjrD/QmWOeC6
         5rXwuYeyM1/TcUIheP60TTo+F1vnIXOM24YncGgSVeS9XyVQv+JfGCzgtsOuBJGXcBfc
         T/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033183; x=1720637983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IohLYANlTWt9Y373TRe3rnVr5G7ZnH8yifT/Euy+kEI=;
        b=SdaZ93M03ch+uocSgELhNQ74I/Xb/W11a90uxnbPc5cBc6ipOJSR/Y45FbrGFGLafX
         mBFLpiJqanQVi4prhWfEUbhaNU2VHwPCIQuSEbypdXJng9iCuJteVPwQglG4KqodIu2b
         lnlPumTXbSWlNB7/4onFstqM+o9OnCOS881ZRuWDUN6Gw6hQvT1xjtWEjOOonWhUWQbQ
         l/l/G/6xYbuBPnjpBFXa3ccwzvq92gl5oajntAHnY0aNxpyGVUnebwXIP8kgt+xbCo0v
         eJmHNpYSHfrhcbjFyURchV3olOKk1qjmfzYeNQbX9GiU/Ct8VbC0ZcHyShea96pPkViY
         2wmg==
X-Forwarded-Encrypted: i=1; AJvYcCVaaFM9R4otqfSe/VsbKSNm8R9Gt8A6GD3RLLSZGtYbWj5D8F/rJmq1Ul7YH4NFo+fkMmP6FKywYRLGIbL9tNI8I3Dcc0RRNp2PS90aBAVSK/HH50BixKTXuhJi1Ldc0YZJcMpzhA==
X-Gm-Message-State: AOJu0YwwH0NAn9sw/Dk8ciG2pcXJLJmTam1YiiE6k8cXrHbGnQj+MBR1
	RUNVTdly/Zsp2dqW5pGXGtAmh6SzJeyAbtiPb8lTDDaFZm4onqxA
X-Google-Smtp-Source: AGHT+IEbEaBFtEXU4deGZ4B50xeYx5XmQJjG8Ta1vR2LiGo/9hMeoxcCltD4gV69DA99e8ul9Ktm4g==
X-Received: by 2002:a17:902:f543:b0:1f9:9b6d:e3f9 with SMTP id d9443c01a7336-1fb1a0c6d7dmr40739135ad.29.1720033183131;
        Wed, 03 Jul 2024 11:59:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb0c2e10dasm25676355ad.223.2024.07.03.11.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:59:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Jul 2024 08:59:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Protect css->cgroup write under css_set_lock
Message-ID: <ZoWfnS6NvEoNckGO@slm.duckdns.org>
References: <20240703185229.1849423-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703185229.1849423-1-longman@redhat.com>

On Wed, Jul 03, 2024 at 02:52:29PM -0400, Waiman Long wrote:
> The writing of css->cgroup associated with the cgroup root in
> rebind_subsystems() is currently protected only by cgroup_mutex.
> However, the reading of css->cgroup in both proc_cpuset_show() and
> proc_cgroup_show() is protected just by css_set_lock. That makes the
> readers susceptible to racing problems like data tearing or caching.
> It is also a problem that can be reported by KCSAN.
> 
> This can be fixed by using READ_ONCE() and WRITE_ONCE() to access
> css->cgroup. Alternatively, the writing of css->cgroup can be moved
> under css_set_lock as well which is done by this patch.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.10-fixes.

Thanks.

-- 
tejun

