Return-Path: <cgroups+bounces-4853-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D80975CE2
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 00:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198801F23B2B
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA16183088;
	Wed, 11 Sep 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iRsCyLuu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617D145B2C
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092358; cv=none; b=AG8Eh3s20t0BtLVDk5gJ2rL4An5mj3YGOwX0Mvz/sIXUv8YsMvjjEkS2DjuELff5Mmy1CZ7G777fa3Ild+ulhCN7J4rfrmxP5RR9dSL/wrQ0xXFm5iMcEmRz6JHplcXAGa3T5kF1F+Hk9SOloX/Ds1G/UTsmHDW7FSlT2iw4r2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092358; c=relaxed/simple;
	bh=4eWae7FOAKdBlxcxq2mEpg0H5cK66+VncijT1wT9M+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c7SzXV+5Zzqjo8q7mAUY031U7GWzgF3J4TodHWViB5i4DsKQ2egLhAIy7LjzZVGQfr3hIcZZKLLgHa6E7uXMx3uGYeoB28NkV7ZZ5zUQT89iHALb8JCXogKPqcBW5HFvJMqT6FKcgRb/JQQpxrNfhrohKDOBUjlq1RoHRKSeZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iRsCyLuu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb96so232972a12.0
        for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726092355; x=1726697155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT6C3xXVFHramxKhQNyUko7uCMTmKteekD3PIenNBQQ=;
        b=iRsCyLuuQwGkgQdp1qapRKosAt5CPYIxqpf7pfpQI1tMkPOwWlBJ3uy1gTcpSo5tE2
         COq/4lqUZ/nVJ1qZjaxpt8Aym+3ZpUn5ccwOw8eA1SGzsfyff0VSsbyd4SEgUVkMPYsa
         7/Cp0gaprGFPnJDYRf8OG+l3xyTtn3oLgbte3C1oNDaJiIVDBjeA41JqHDvL4/BPpnnN
         Le1KREJjl1beqFUoeA1/JTsL2UbdaFepwR+/6ESdEK+t6F6/sOzqS6trRr/WDVQHsd1D
         IEcuRhIDghbqi38cuO00f709Chaa+NJesSj/cAAi6gMQWPXr9MQPLHo1FBf7Sx49soPZ
         hrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726092355; x=1726697155;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT6C3xXVFHramxKhQNyUko7uCMTmKteekD3PIenNBQQ=;
        b=Af8v6TrmIyFhu/BLDlrFGQAbENg0pElTT85WGTmlkNL5/d8T94Q/ne00rRBMkridHn
         2oUgSdErlqoP/oGMLH8vurvfVF5E919bDYyObrikhPB4igq2R41/jhmC5QX1U0f56eej
         mqDu27aMjTTWiDFm1g2NHM2YWRBN/cFQFRPffnXDEEedpRxoBrIU1f7qlvh/pKeMTE19
         2z7s7+KhsS7tL7QD/IhXxKf7phImWY78hIC23wm7chGI5Ev8kJuUVhr+QhvpL3Y+dV6h
         mDsAL+WEmPNUQzbjhh/2uZoWCrvysRKXbQvDJ+KdCkVYcnIJgqA8scHMNQ4K7l5cxfk0
         2cFA==
X-Forwarded-Encrypted: i=1; AJvYcCWSqltnAp8YDOwRZudloGbxCa+h92G8y0xvGhvW22MhV5asOI1O7XJ3Wqfu9lyRc2FcfwSWBEEO@vger.kernel.org
X-Gm-Message-State: AOJu0YzigmbUwkyXISOiPbL0JEnp5VGkFnuP565yWKlDtE7TeeUAqLkv
	rDNb07p1rdfdKG75qf0bOmFEhhBYTLjjLBYFII1Hl802yI3quRDatTbkhLhPu2M=
X-Google-Smtp-Source: AGHT+IEuqFEGAfJiOaQ4nh1MTrdynUjOWncE9qCeCiHOZ6JbwtAJ7RttrGToWUO/kBAcYF3XVN+a+w==
X-Received: by 2002:a17:902:f68f:b0:206:88fa:54a6 with SMTP id d9443c01a7336-2076e361a14mr10671435ad.21.1726092355362;
        Wed, 11 Sep 2024 15:05:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd4easm3908905ad.148.2024.09.11.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 15:05:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240911214124.197403-1-colin.i.king@gmail.com>
References: <20240911214124.197403-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] blk_iocost: make read-only static array
 vrate_adj_pct const
Message-Id: <172609235387.422440.3089154405009965533.b4-ty@kernel.dk>
Date: Wed, 11 Sep 2024 16:05:53 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 11 Sep 2024 22:41:24 +0100, Colin Ian King wrote:
> The static array vrate_adj_pct is read-only, so make it const as
> well.
> 
> 

Applied, thanks!

[1/1] blk_iocost: make read-only static array vrate_adj_pct const
      commit: cc089684664ebd379f1451aab65eb50f4008b381

Best regards,
-- 
Jens Axboe




