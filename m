Return-Path: <cgroups+bounces-5013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C1C98D44A
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB7FB20B6D
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F291D0418;
	Wed,  2 Oct 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="taTGbIF7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97C1CF284
	for <cgroups@vger.kernel.org>; Wed,  2 Oct 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875051; cv=none; b=ApaNqyESUqFpTgSvUI7JnDjyRm038uj5dUOKnkWucm3HuJGkp26+gqD9l9tDSiU6iDZJpVXVNGORd6qzSaqtdV6QSACmwGOXnL7pUxIBCTTKCXlib91YzbKUkXpXdtmJtcyrzzsUzKOeKv+PKeyUS0zxcp8MaZ0y9OsXTXred2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875051; c=relaxed/simple;
	bh=36nWme8y4GZ94wWNug6vyCXS0wdvEP/HfW+1E7YCpRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dizGQaAd832iSl0D4YIwF79PoIkjMdQii9UTeSJEhKK+Ock8KsXrTBRUB4shwf+nNHyK26Ji+8dE1g0hIw0BdY3wr4CIIUt6FTkXooBX3Kff1yJL/d4XPNbHWnAoQrpyp+mmmAubJJhdsDL1V+/jNdSKUUh9m+o+z/gqe2/NUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=taTGbIF7; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a1a3090f39so32692275ab.3
        for <cgroups@vger.kernel.org>; Wed, 02 Oct 2024 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727875048; x=1728479848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRW4Cz/ZHbTxTOnb6ZoyufUiDwCoy63jco0zbwWoTDE=;
        b=taTGbIF7EiUE3jZ3URAk+jvyHeVim7xQQaRKn/zR65NBAQWKIUMYdfxiZy0KTvwJtt
         SnCYzkb3g1dGoOK57Ub5atfiySbTLC6hqNl3+3WaGhcUst0iuMfo+AAr1gWV1owl5Z3T
         qCEObT9Ic+lU441t+f0eFlwZB6XCX3j5KmeSYrk31kO8JfRhljVuMRuBnE2lCdbav7sZ
         VgX0eoxh4T471MFLMQR5I67Ji7OsRef5o6FKMMFucWBLzyd9zrVYPz8nl5VeWiO6DdFn
         ytkMHqPkmDfkAhGdFW4af1m+sL9FsjehaQD+A5dunq+3NC3ZCrUn1a9/nZ4UYmzoIxY1
         QoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875048; x=1728479848;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRW4Cz/ZHbTxTOnb6ZoyufUiDwCoy63jco0zbwWoTDE=;
        b=vcCtjwF+NVlFoees9JlvF4fVTSkzGePz8KasbGsqoXnOxWtDKRK1X78vcPprIseQDv
         TeGll5Lv6nV8XMQA/quaDHjRq0IYcTb4x/VHKEvNSJ1C4fy0SEbEUH7MTdQZo230Yg2E
         5fJQu6IWi2h0Px0SrDw36UhqxKilr6J5gUWZf0VZzKMijxVyWmGdQ3O9kv1FrlG+KdYU
         T3N4/EQLNrxd1v7qFwU/zf1ofgWsO6kqq/aL4hWHhBnGGVABX9I3HrEIzPuNc40yBfIE
         hDguP2MZDKHb57SBajRn99WUc/lqBczutE/ilT5JWY7bPuMMt9tDgT2aT9a4gT1rD18j
         au0w==
X-Forwarded-Encrypted: i=1; AJvYcCXdITCY6tSm1i9xnhEly1O+85dhe0DQd7R+0lhQWjWtCVAPu67izUOvc9FyJR5DscyC3LVVHz6S@vger.kernel.org
X-Gm-Message-State: AOJu0YzostI4OtAFHFfd1ajMp5QSTPPZ6GedRoYoHFOvs+AQLMtrtcaK
	QXIx0cu+gbB8RDTZqnmlFJm9Jd4SYSVkHxt9ApOFYg/n9rITB9PXvdCboMmz3Sw=
X-Google-Smtp-Source: AGHT+IHuxaPoCYtm3L1Gav3Ro6gdyVRIy6bPAZVe7gjGl0fcZClv9KzDyZ1fxfNnKo1x1TzHZQxr+Q==
X-Received: by 2002:a05:6e02:1a8f:b0:3a3:6045:f8bd with SMTP id e9e14a558f8ab-3a3659156b1mr26379705ab.5.1727875048142;
        Wed, 02 Oct 2024 06:17:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3678e3ea3sm3490625ab.87.2024.10.02.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:17:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai3@huawei.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <Zv0kudA9xyGdaA4g@stanley.mountain>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq
 disable/enables
Message-Id: <172787504695.64996.11187205888353360431.b4-ty@kernel.dk>
Date: Wed, 02 Oct 2024 07:17:26 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Wed, 02 Oct 2024 13:47:21 +0300, Dan Carpenter wrote:
> These are called from blkcg_print_blkgs() which already disables IRQs so
> disabling it again is wrong.  It means that IRQs will be enabled slightly
> earlier than intended, however, so far as I can see, this bug is harmless.
> 
> 

Applied, thanks!

[1/1] blk_iocost: remove some duplicate irq disable/enables
      commit: 14d57ec3b86369d0037567f12caae0c9e9eaad9e

Best regards,
-- 
Jens Axboe




