Return-Path: <cgroups+bounces-12045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E2C6539C
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 17:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7044A4ECF2A
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174592E03EC;
	Mon, 17 Nov 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RC6bobC4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF472DF3D9
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397755; cv=none; b=SnG5Mc4ABjVFXgo5ltroQUoZ7rCtKK6dI7FPOndpvSaSkQcXkh+5tiQmhRr81eVPGM53z/XJwK6uGUu29PMZTgMvJzblte2W6356Yr39z7mo3V27iix60PQOp7hMu/4vm6Smy+M5/JpTAE5PnBlLzUEPUj2p5PnEKKp1YllKJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397755; c=relaxed/simple;
	bh=pMxEm4NUjUGTpHRKv7d5LLStUvt+joOsQt6SvZeQ/aA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bL8OkVO/zrEE2y/8rm6wZz8p3ldAc85oq6ZmgFgYuS2wFhTbD1qofTbd+8GphZy/dmfa09py7tYupYwhZHCgdX5yojVv6tTWbj41VMyOH/+ybmdQPAVy1lbd87r+NQcJvLQdgqUalkOCkxAtrb6ls1GR2Knrh89mhQ5R4X+WFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RC6bobC4; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-949031532f9so65446039f.0
        for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763397753; x=1764002553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPLj/39ZpulhoDTDGoazpNeOK1ByBZpHBDDVSHE4zmc=;
        b=RC6bobC4+TovrvaGkyyJWnIYG9UfB2Q2nRY2/nVuq2FL1hwFL0YESAY7qDvSH+DKdg
         Yrpfw25/6XVrDtxSVSqQSLeiU7qSKAf0cZ2mO9ry+HTactxFvCZmb2sbzUBNLvOhsMEg
         i2mpQHBOqZfkBDBQ9xk6iwAKqQ4VPx8UiEHUwokBOwzHaaNEDXOPSAVWua8rNdu4OR+6
         MpV7Y/x9GZ1bM2AjRI/WuPc94cBkTR6xTMaUTtvz5LdIsHUkFnw3jkJVmIk9uzQQC6cZ
         wPw5bI/pIBkhFo0cTEptoscv3eVRhUl266rQ8JgD+HWQYMSbjFfUPrDJLJ1fXzoDigKo
         nceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763397753; x=1764002553;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPLj/39ZpulhoDTDGoazpNeOK1ByBZpHBDDVSHE4zmc=;
        b=QwgYe/uQLd8NDx74NxCz/ZjBoqRJdu7qc3cesF9r2KeZsrxsRqsoLTgWsSljnOeICU
         K0gpbOGyzXIaSDYqe7pw4d7ALiVE7SIJsrVpWLi3H0nb9bxba1lqxPiMD3pnkAGUz7Br
         Htj0PkcPL0EShH9L+ctvqX2DTzOfWIJ9QojKv+aEjklj6A2ZjZ61FkSr7DqR2wL/6AkW
         YR3G1nL56OqPlssvy2rAniftgSTeiY5UNrd+hUkQLmPoj8u/Ode/+g59v6JBD+rXJYfZ
         AI/I1inziVYvIL3VqWQ0UHZQCDMexQTEbPN9Ym59L+jvJv1zvV1HVzZNb1nwcVWkpdU5
         3dwA==
X-Gm-Message-State: AOJu0Yz9ROMydpjhAU384sK/rjk/v7FA7SR6IUvqL8Aek/9Ttwq9F1WZ
	Zb5LFd3JFwA2pHmdg+fLUZ4Kq/xiSBwH/iqqhDwgkT9grJUJqJYmz4h/HGBuZMGTupw=
X-Gm-Gg: ASbGncu0HYc/5GFgilaYnMeacWt1KK9kj5i73IHSK8wtkig3eIO/jafYGlnidS8TL4O
	goOQHRwfRa0jFCl7ShH7bAH1GP0ut61C4+k274z5yjc2H1cW8jLYb/Rl1gjqoTXPQsDvRUWe6MI
	8B255qg3A1qrcANGjAztL+Gbl7PKxQjm/AIOzqAjZ+vPTplcqoIub7dTleB5VMBHhmtvLlDEpq3
	FYzfTzd0spPNaSIqYuhjYsXdZPrPebzJR0qO61oFXlwjeRSFMXzPHF6XFw1ufyf94FB5Gb7+LJf
	KrPdFkN2mhsiRlUKuCzcz6TI4NHA/Z7UqB7hJM61Uo8JTIVrJRko1lNdO5HiiryWRE5DzXj1VpC
	lYRd8Rg5NCdVvNB1l1SOEm004CJSsMFwLqr6B09uTcl8ZbZcl3LNrFCHHiJcNxHewveBYeHvPTI
	9pag==
X-Google-Smtp-Source: AGHT+IExXiO+QkYrKnmU03Fq6LXoF/sRtqr6FyMgEi0OFyE/Cj1hbgnilLpBLKEEKN9vWUKT3aE/kg==
X-Received: by 2002:a05:6638:9823:b0:5b7:d710:6632 with SMTP id 8926c6da1cb9f-5b7d7106816mr9931097173.11.1763397753282;
        Mon, 17 Nov 2025 08:42:33 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd26e131sm4924100173.20.2025.11.17.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:42:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Khazhismel Kumykov <khazhy@chromium.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>
In-Reply-To: <20251114235434.2168072-1-khazhy@google.com>
References: <20251114235434.2168072-1-khazhy@google.com>
Subject: Re: [PATCH v2 0/3] block/blk-throttle: Fix throttle slice time for
 SSDs
Message-Id: <176339775226.116629.17706508995359561190.b4-ty@kernel.dk>
Date: Mon, 17 Nov 2025 09:42:32 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 15:54:31 -0800, Khazhismel Kumykov wrote:
> Since commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"),
> the throttle slice time differs between SSD and non-SSD devices. This
> causes test failures with slow throttle speeds on SSD devices.
> 
> The first patch in the series fixes the problem by restoring the throttle
> slice time to a fixed value, matching behavior seen prior to above
> mentioned revert. The remaining patches clean up unneeeded code after removing
> CONFIG_BLK_DEV_THROTTLING_LOW.
> 
> [...]

Applied, thanks!

[1/3] block/blk-throttle: Fix throttle slice time for SSDs
      commit: f76581f9f1d29e32e120b0242974ba266e79de58
[2/3] block/blk-throttle: drop unneeded blk_stat_enable_accounting
      commit: 20d0b359c73d15b25abea04066ef4cdbc6a8738d
[3/3] block/blk-throttle: Remove throtl_slice from struct throtl_data
      commit: 6483faa3938bfbd2c9f8ae090f647635f3bd2877

Best regards,
-- 
Jens Axboe




