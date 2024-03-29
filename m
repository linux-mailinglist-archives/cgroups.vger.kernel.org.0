Return-Path: <cgroups+bounces-2244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDF892363
	for <lists+cgroups@lfdr.de>; Fri, 29 Mar 2024 19:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A192B1F22C39
	for <lists+cgroups@lfdr.de>; Fri, 29 Mar 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8883B3AC08;
	Fri, 29 Mar 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hFjCe2Lm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EF2770B
	for <cgroups@vger.kernel.org>; Fri, 29 Mar 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737158; cv=none; b=OCXQL0CfdLZuCanxeUGIiyd2aU9y1duBTl6bLyA9v56rvdQtXM1HJcYYxwoBUCm9KD2G5fzybTIC2upKyPom3gjwiSMMfB31E+qEFSMSGdTtHlZUL3gaIfoHzg97m7KLur+R4DRB2rTIMaCRhbPZid6ssiiEdxZi5t+ZY+eheHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737158; c=relaxed/simple;
	bh=89P8xFdwNRsQGaELkVIPuf/jqJH5tKfLG5uP3475eNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pEPoSqwfM9CYYY6MarIBA9KkVVFmmg4YOiG8MaAjRC9FSwIY5XOflo5KFOSC5Bl7UWM+g4k4Gy5YaXc7uKWehp/w61YDzvTMh5TwVFP+eFXdEO6+rjGoCCVxEAAjfica8DZA88pBdAMzG+OPyh4UzM0xhFI2fJg+fKIiNOXX9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hFjCe2Lm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6ca65edc9so566660b3a.0
        for <cgroups@vger.kernel.org>; Fri, 29 Mar 2024 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711737154; x=1712341954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Tpqpd+XowKAeNmFVUx3aaouhXhfs+V2Z4XDOcPdis=;
        b=hFjCe2LmIayRK0OKDXYJl9XEEtvZbBABnd3wQLhpypjEcemRyQ01K/XezyJXqBNTLa
         bL34SiOGAFAdQ2NVTEVNIeI6c10jp/V9TTJDjZ5KlNgEhQL+L/yJDSyRRD+hkcDqZJO6
         Iv68HGqeaqsysbu+jrj2bwaxzZvUsFeoxJDWKRa6RQ1ZY2g7PceSb7+1ngrJcfov1WCg
         MulcczUq1C7bO9oFjdRc5vjLcOmubG8e/Db8XadksQbP+3dG2ZlLxz9OXWLMDdfYV5oN
         X71r7CeKax1khlCC7qKQ0LEdFV1L5Iwgl8kR48TIwfSGPxMlUSrnGl2zHuIM6t7zA68H
         uRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737154; x=1712341954;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/Tpqpd+XowKAeNmFVUx3aaouhXhfs+V2Z4XDOcPdis=;
        b=ohWaQ1s4s78gvW+NLQmSx7ezyWvaSzaWUrDGM11TdgiWBldbGR1NdcKon+tngdUfYO
         hbCwX3WXRt5C1M08i9NLURby57XeWAn/ZIX/Ckymyi7Fa+lGFYjtCapfRNvvThBiaQKY
         PsIaqyt8Vt/0qi0jZQCCKkpRl2OWSfYHwM2BxKsJ8+34wj31EHXti7fvKpgbi5vJhDZJ
         M/u6P5+nOcebt6h4GLdTvre4Ad20Yoc3E/unTtVix/n99kjMMIz1LjaSmhClzdA9g6gV
         3nXKXceedRpbtbu84Ut1j/QAUMkmU4DqTSj7ziWcN1dgIEic0EPhkCCiP9SsfAOY1YN5
         Cojw==
X-Forwarded-Encrypted: i=1; AJvYcCU+uUsZPJYBFKGDsD9Zt78bwdi2rbKVsdfrP7eY0gjJ/giS3MUETo9ooRz4UjV/YQ36hWq4hbbAOXVSOIXnYvUi+ydxOxQLkA==
X-Gm-Message-State: AOJu0YwkQ7pyMtSHABFvRS7uQFJroNJbXlhXTuFqo11C4RZBCTNIX2ep
	3t4ypZ2klQMqgOPxdDPmd3edOCQt+XGfo1lpGP5Hue53nrC/C4BxTKT9tAm7YuM=
X-Google-Smtp-Source: AGHT+IGSjkQXsoReNcWtU/6vP8JEFFqWZTeD1QWgK0mtAmmxGqQBkW918F/Y7oP7x2jW69IsjahdEw==
X-Received: by 2002:a17:902:c255:b0:1de:e8ce:9d7a with SMTP id 21-20020a170902c25500b001dee8ce9d7amr3120790plg.5.1711737154073;
        Fri, 29 Mar 2024 11:32:34 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:a5ff])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001e0c956f0dcsm3748761plh.213.2024.03.29.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:32:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Matthew Sakai <msakai@redhat.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, dm-devel@lists.linux.dev, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-btrfs@vger.kernel.org
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
References: <20240328084147.2954434-1-hch@lst.de>
Subject: Re: add a bio_list_merge_init helper
Message-Id: <171173715281.870109.4128910475529577998.b4-ty@kernel.dk>
Date: Fri, 29 Mar 2024 12:32:32 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 28 Mar 2024 09:41:43 +0100, Christoph Hellwig wrote:
> the bio_list API is missing a helper that reinitializes the list
> spliced onto another one.  Add one to simplify the code similar
> to what the normal list.h can do.
> 
> Diffstat:
>  block/blk-cgroup.c            |    3 +--
>  drivers/md/dm-bio-prison-v2.c |    3 +--
>  drivers/md/dm-cache-target.c  |   12 ++++--------
>  drivers/md/dm-clone-target.c  |   14 +++++---------
>  drivers/md/dm-era-target.c    |    3 +--
>  drivers/md/dm-mpath.c         |    3 +--
>  drivers/md/dm-thin.c          |   12 +++---------
>  drivers/md/dm-vdo/data-vio.c  |    3 +--
>  drivers/md/dm-vdo/flush.c     |    3 +--
>  fs/btrfs/raid56.c             |    3 +--
>  include/linux/bio.h           |    7 +++++++
>  11 files changed, 26 insertions(+), 40 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] block: add a bio_list_merge_init helper
      commit: 872fb30bf89598781d90bd2d6522f230cdf6494d
[2/4] blk-cgroup: use bio_list_merge_init
      commit: e19efc6e5d8ed46f407737033ffc0bdfe0b8dc67
[3/4] dm: use bio_list_merge_init
      commit: d35cd999db51da5706fc4d798b69e189b998ac4f
[4/4] btrfs use bio_list_merge_init
      commit: 5d363e4ee3cf8d4c4bc68956d89dcded30bc7e0c

Best regards,
-- 
Jens Axboe




