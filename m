Return-Path: <cgroups+bounces-4474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E595FA70
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 22:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5915B22ACB
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C5199EA3;
	Mon, 26 Aug 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Opd4iwsJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F051991AD
	for <cgroups@vger.kernel.org>; Mon, 26 Aug 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703229; cv=none; b=DMXF5CaecZlXoEPOUnDqBox5bzCAgrX8YNZqabGXksQ8SeCpcbqB1pZ66Pc3HD9cqxiq2sK9wYAoULeZIZbopPMMIlGzAM5wQaI5bCHoZ50y5R9sY9BcPBtLmQ9hTO3OSMxVo73iSi1t1LOkl6s+EMeA+LaUWH5mWPBmFSh4fl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703229; c=relaxed/simple;
	bh=dWd5qv6eBqkAl29vi+ZlXsW/zewDNUzH8lPaDyWvxkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rR4G/3/scN3sVy+27vkbYK2DMc2CK4Xr922RjeMmwQuKSW+r3XSQipxuXxTALAB712I0NmNqu4RTQnq2C46SDGfu8YP887vC+q7wZcE7/jjvrdOycDTs571UPiwsGR6agbeEQUhSSQUZ24FZCcLWbRGw75PpWcgKdc+MTas+22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Opd4iwsJ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so16319845ab.1
        for <cgroups@vger.kernel.org>; Mon, 26 Aug 2024 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724703225; x=1725308025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IudeqtVAq8N+IIPnbH3rPVPQhvZk+3E2+WjQQtP0t1c=;
        b=Opd4iwsJdBchTwYeG4GURQNo1OtuoLUux/3KwpliLmLv6r12HiAl3dQHrnToFweDvh
         ObYr1fyKBhnhF1BTPn6E7WE1PVJXlmgwoU1zq7GYejcBEo5GXVhQn1LzuoOcpE13ojDy
         hxDqMiOvJdamdxwDebrYeP1dUBhYM3yPALtG273aOl78WjC3u9kmPgsV4fe2Esl2uUeU
         7Tiu4hLiwBPMwYolXMDsgGCtQI724km9rnooUgPfxqr39/IDMfYw3ctBydOAaHT9Hn/h
         PbPdjXTy/PRVHd+z9KqcohRH/zVcdElnMHLNjRa5U5pH1G9GKg5XLfSVs1X5dp9JD7hJ
         En6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703225; x=1725308025;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IudeqtVAq8N+IIPnbH3rPVPQhvZk+3E2+WjQQtP0t1c=;
        b=odK6FQm0CywRcNVIRc8SW4WheYVyqJ7Pr4dUKcBt+RrkE9RtK/f+DHpbu2mM0MiWbL
         uzDE+ATmzJrFDGUuSqStyAneDZgWaVzmXvFzVUch61qKN10WvYYhEtofYfiWdL+ejjQJ
         OKVnDIj60Cedq2YbhL6fjmXYntDB2OYx3uoDU/dBBIyE29rha3RlxKEOZyNjDsvR+fDs
         fhuEThC91s/oIIMuChlIq9lImRug9fCP3A4ZAjSk+1ifsmNnRN9YBjSCCsF6Pxi+es8d
         2+KCdOBUAN1ioPgVSIitt/GuhnFKa39FxNOB84xXOF/5lVSEst2A55ej9w0lUUox4+yz
         yLsw==
X-Forwarded-Encrypted: i=1; AJvYcCXyw90U1vsfDhmFjguS+QUCcNW+r+Onh/jW5gdqaVtsM+8KowbEIRWc721i7xYoSQ58/btReJrf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1fUNJWx1MB8x59mezN09r5SxzR7+Mnx7oFoEDXwZWscoon4Z
	kDJyibGU6tk2pm6jO6/C3Jh/af+eC2LGG9c979lfUo1ZOxwOFbk6nDSgAc3PHGg=
X-Google-Smtp-Source: AGHT+IHAFmJILxeAH8CPDsKKgho4CjhO/zttTxjz1xDlDIe16dflTQ7KHxmp24dTv/r+d7RYkXtOlw==
X-Received: by 2002:a92:cda3:0:b0:39b:3387:515b with SMTP id e9e14a558f8ab-39e63dd8e0dmr10459335ab.1.1724703225554;
        Mon, 26 Aug 2024 13:13:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f5ca7csm2361772173.63.2024.08.26.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:13:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, Konstantin Ovsepian <ovs@ovs.to>
Cc: leitao@debian.org, ovs@meta.com
In-Reply-To: <20240822154137.2627818-1-ovs@ovs.to>
References: <20240822154137.2627818-1-ovs@ovs.to>
Subject: Re: [PATCH] blk_iocost: fix more out of bound shifts
Message-Id: <172470322478.220079.4635873970554219426.b4-ty@kernel.dk>
Date: Mon, 26 Aug 2024 14:13:44 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 22 Aug 2024 08:41:36 -0700, Konstantin Ovsepian wrote:
> Recently running UBSAN caught few out of bound shifts in the
> ioc_forgive_debts() function:
> 
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:2142:38
> shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
> long')
> ...
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:2144:30
> shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
> long')
> ...
> Call Trace:
> <IRQ>
> dump_stack_lvl+0xca/0x130
> __ubsan_handle_shift_out_of_bounds+0x22c/0x280
> ? __lock_acquire+0x6441/0x7c10
> ioc_timer_fn+0x6cec/0x7750
> ? blk_iocost_init+0x720/0x720
> ? call_timer_fn+0x5d/0x470
> call_timer_fn+0xfa/0x470
> ? blk_iocost_init+0x720/0x720
> __run_timer_base+0x519/0x700
> ...
> 
> [...]

Applied, thanks!

[1/1] blk_iocost: fix more out of bound shifts
      commit: 9bce8005ec0dcb23a58300e8522fe4a31da606fa

Best regards,
-- 
Jens Axboe




