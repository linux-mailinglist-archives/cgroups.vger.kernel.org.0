Return-Path: <cgroups+bounces-2324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E6898CA0
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 18:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA54B23DFB
	for <lists+cgroups@lfdr.de>; Thu,  4 Apr 2024 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA43127B5C;
	Thu,  4 Apr 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePLEgrRq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F481CA84;
	Thu,  4 Apr 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249515; cv=none; b=geZy/lTAnCk7AKmllpwX+uIpoZT4Gi2bPz0M9faB6JBYtYRhrEqB26aK1Vm6Chw4XDRw3rFI1QrUg35xdjipKizRCnE6kPi2wVh4cin6ImaFU5ZFvEoTKPRyjS1FHTTno+nsSCr8PfJ3K701fbLw9C7d+ewwWYdQiQNM9yTLgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249515; c=relaxed/simple;
	bh=V2lamvqHqNnSBRfVpeT+opmreN/o/daYr1FfZVfNalI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWpcSXXD+6P5/693RsiuArRUrQlkUeo82ljs0rqwDl2aR6ptMr1aMuE0XExsh9WuZxZ3FJ5jQgUFf+LyaTUoRiqEJRC8YMKqI97xulCLK/QCA9KslOy9mDN8yEXrrylYEoiu2TachNto4yZFv5KzmilF5wCpkfqeWZAWI1xlLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePLEgrRq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso1074052b3a.3;
        Thu, 04 Apr 2024 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712249513; x=1712854313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+doro/JaQHck4vMp7NZSZdSbRh8luRKNIbrvkM3+ZI=;
        b=ePLEgrRq5qS2l4/W9QrhuGCXcuKF/PDZ+HG32kP/okLEZ1utsP5OABkrfgRq+sPQIn
         bem5E/E8izaYjVrlxxEpdPhdThzBomhv/TUylPyW1Q2MeMDDCF9mu0uFZ+RsNtU2j5FK
         NjjA+5T8+lT3+iC9ZjDcUTbFAZ8Mig/B1LHsUTmQDlSBLcRiCNdKYDKO3Ht4g1SHeOSV
         GNaovkpA/tzaN1QLy3I5yST+NsFzvLr9npixawAhAkFjYXDNr7h5oaqEARSYxOQv5g9w
         jouEICDSgpxov4fRjMmPwA8jOqaKtU9zDKsebJWCvF3OFo/BiIUrosXS/PaNULEalN7e
         rVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249513; x=1712854313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+doro/JaQHck4vMp7NZSZdSbRh8luRKNIbrvkM3+ZI=;
        b=YludtTOWiBTCPT1SfmWaPDPUYXBUhf3wYDsa/CQS9yaNsioxNd0wGra6AKPyf2U2jn
         RbkiuscqqI/DdowH4smuq+9DZbhWagVJnYcfsUhqZFZxdrsduXLYXo2vdfGQdg7IbhYb
         a9axav37xc4+9KT8pU7B17LPXJwELvfrvS6yMC1RTkYsENNtvrfDpSjcTF+zScEbigXw
         LWWxM1EZV25D/ImHwWdQo5SfWolW65dSAmE2ERipk5UNuDB5Tb2Rtd99HoLfW2d0M4SA
         JqFQUlV750k8e3AZuWRYZjeptbpNDamcyPzgBX2SmBrzFg9yOBw04Tjwl6tyI4AJ66A8
         dW4A==
X-Forwarded-Encrypted: i=1; AJvYcCWCVskRZf+SOavQ+qHVU7fKw9y7wVoXE99wsUpVXs3O3vIRAUMyW1aNd37iFUSR+sXQ6jU00kHLE+wR8Zu+INcax6nrSs/Ffo8zWB+/diBFoX3L3+C//c4xL6cJnM9r035yXbK4
X-Gm-Message-State: AOJu0YzWFUbSm4XmQAksIOcz1w7wL/c1Nhcrs799hIuJTYHi9uOeNwsg
	1+qMZ0wVo5Wrbprdq3xHabL/avfXPcze1dRJ+9Ja+AwPfoKAoDm3K8Pjp3VY
X-Google-Smtp-Source: AGHT+IHO91XJgg9Py+SH6nyLb4g4A9fUHSX9PzzPupdHWaVU0vzre6mAwZ4s5/CobU8rlBWztNbPNw==
X-Received: by 2002:a05:6a21:3403:b0:1a3:32e5:f38a with SMTP id yn3-20020a056a21340300b001a332e5f38amr2842687pzb.45.1712249513321;
        Thu, 04 Apr 2024 09:51:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id x7-20020aa784c7000000b006eae2f3c7d4sm12497975pfn.102.2024.04.04.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:51:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 4 Apr 2024 06:51:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: avoid out of bounds shift
Message-ID: <Zg7apyOjjGCdsMu8@slm.duckdns.org>
References: <20240404123253.0f58010f@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404123253.0f58010f@imladris.surriel.com>

On Thu, Apr 04, 2024 at 12:32:53PM -0400, Rik van Riel wrote:
> UBSAN catches undefined behavior in blk-iocost, where sometimes
> iocg->delay is shifted right by a number that is too large,
> resulting in undefined behavior on some architectures.
> 
> [  186.556576] ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:1366:23
> shift exponent 64 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> CPU: 16 PID: 0 Comm: swapper/16 Tainted: G S          E    N 6.9.0-0_fbk700_debug_rc2_kbuilder_0_gc85af715cac0 #1
> Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x8f/0xe0
>  __ubsan_handle_shift_out_of_bounds+0x22c/0x280
>  iocg_kick_delay+0x30b/0x310
>  ioc_timer_fn+0x2fb/0x1f80
>  __run_timer_base+0x1b6/0x250
> ...
> 
> Avoid that undefined behavior by simply taking the
> "delay = 0" branch if the shift is too large.
> 
> I am not sure what the symptoms of an undefined value
> delay will be, but I suspect it could be more than a
> little annoying to debug.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

