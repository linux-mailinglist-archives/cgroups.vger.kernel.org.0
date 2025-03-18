Return-Path: <cgroups+bounces-7139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47CA67BF0
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 19:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1231D176C41
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161821AC892;
	Tue, 18 Mar 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rzaXjIVc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765FB151990
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322747; cv=none; b=fnle6F0WmUg55jwgk1GZTw/UiblwQe/zAFuYIkmZIkUnTsEUntYd7/lIDQ+bINmfVIb49FnztybP2lZuWjyN7QwRy9u7oyZrJEtltODWRE/u3jI9YHoqpOxvJjMK7lNu+osLOObdLEZebl4gKwYkTz8wqBMO4Gu7UlBLKaPbKyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322747; c=relaxed/simple;
	bh=qrv+DU81gmi1ENITv/uf+Y+QCljkGvrsvRaZ1EA/ctg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZunY0vrMbP/zborq7KtM4+oFJZqdt7S8RsaHnRuXz7M1dRxE+pnSPqh1dwPHNv96LakgSLrCS1yWlFbBx6NL75qBGeKaeGnVK937T1/dMrP0L1+0wlburdyW0hs2hecja1AGRUWr9CRpb1Z23rFxyIRWBfavuMv0WSpGCuNF4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rzaXjIVc; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85df99da233so139063139f.3
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742322745; x=1742927545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn8c/8xY9hsur5GaIQZhhu6nfpmRkGa6zZ/5hcfFcwg=;
        b=rzaXjIVcQHYIjeJ3Xdgtk1GmciRjSBQ39CYSKJoazF5y19GOwh5x8hzUgCUKwc3wNz
         3tk666LGtdCTmIULCw6wuLliIJw9T6sWNc6uj3kFjohjvhTjLz1TI66V1BnNeLu6xwtc
         p6vXU8PVkUV1YV+C2JoUb/mpDixF/CaJgkWpTGXbspsRtxu2OclllK1TWWNxQdQbk9SM
         xUIrBEKNXqnYvxyxAneYdvucWbmkxP63w/aJUS3nQwz9O/UGPzmD9h2TMtezHmTw815K
         UUORKyNiWThlfskW/AK0SoY8YMyf48cFMjMFw8JvHTbMGwAamuZUpXacbn5NHGZ+rOn6
         XM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322745; x=1742927545;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn8c/8xY9hsur5GaIQZhhu6nfpmRkGa6zZ/5hcfFcwg=;
        b=okYGO45v6V35P3zCq/jHa0OaqWb+fkU/oLapPqErJ2T9L0CTusHLwAid69Viasvkn5
         VgtohjuZkNW3SvbIZlthrlFWBIpgFLEosjci/ouxFG0tWgdRUUdQ3dTOVJ108h1eX1f/
         jU06LVM5BYvvryy3D86yjFs06c2r5mMcVYOeTk46gb79ibPuHHSrSWoFV0IAh2Lyl31e
         DSXCWrlegV4X0vaKEYQJI+js82EesKt8NklxWxP8SpIqNeC3l8+x77MIxpzLEMh1BdVG
         3IXp5cYzv5ENI9iYN39d5KQh3o63D/YpPOFbrdJzla9tygjv1VB2EGjQ7xeFFEeu5SPS
         TLMA==
X-Forwarded-Encrypted: i=1; AJvYcCXXbNbZgmU7cm6ysXVBbKtRmxtNvx7Tgxz6d+sJEbjxrTK7OYs47e/sA72jH6AQ0WZpwUr7Q+6t@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIDqJtK+Eiezew9WQ/ZOoQJnypLO3IGCDeGokpSt8AHblpF9L
	0qE81HxwblDD+veSwil+pXUoIlg85fbEX+C09swJNCtc6aLkFYAr9aeMR8oPp0U=
X-Gm-Gg: ASbGncu6znfsXTHpvHqB4tsP7eBFks4M4sjhXl5CGIQLduLrIRf9HKgRBB29sIcyb1K
	xXBc/oxyMkiQG0AitIhtAHTOsiZHn5EZUVZUGPJ4NXqNy8VA8FjC7SETNa0ct3dKLW2L0eJZ0Hj
	SHB3N2AikIfoij8rI5YnSKdfwJGVowgAFWGC75dzTp3G2L9Ia3BQwZWqf+JKqkyQZMxpNbb8ko3
	WcIJhOYAeVKFvuHSDAPW3XJ3HovPOuU71FBGUFRr2+XKY34vkke1IA4OnDauxXFuJfoqhjfEQ7a
	MB1XFtMZnTnfnc1z5vwZ1DU9avM/V7hDgKeZ
X-Google-Smtp-Source: AGHT+IHgYCKrD3peKrbdSEm1B+JO8dbCq7dov1VEXaRpVsSj3E7NIaJGpVqJEmXprxOB8OJUpmk3kQ==
X-Received: by 2002:a05:6e02:1d8e:b0:3cf:bb6e:3065 with SMTP id e9e14a558f8ab-3d48397f585mr168752655ab.0.1742322745570;
        Tue, 18 Mar 2025 11:32:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a67e5besm33337665ab.31.2025.03.18.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:32:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
References: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration
 error handling
Message-Id: <174232274456.158569.739528900664075776.b4-ty@kernel.dk>
Date: Tue, 18 Mar 2025 12:32:24 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 17 Mar 2025 10:29:24 +0800, Chen Linxuan wrote:
> This patch improve the returned error code of blkcg_policy_register().
> 
> 1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
>    function pairs to the start of blkcg_policy_register(). This ensures
>    we immediately return -EINVAL if the function pairs are not correctly
>    provided, rather than returning -ENOSPC after locking and unlocking
>    mutexes unnecessarily.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: improve policy registration error handling
      commit: e1a0202c6bfda24002a3ae2115154fa90104c649

Best regards,
-- 
Jens Axboe




