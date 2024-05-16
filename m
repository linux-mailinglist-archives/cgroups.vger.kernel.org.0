Return-Path: <cgroups+bounces-2925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867148C703E
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 04:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5562838E7
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F01B1877;
	Thu, 16 May 2024 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CUcvsj5s"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929015C3
	for <cgroups@vger.kernel.org>; Thu, 16 May 2024 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826077; cv=none; b=iIW4GUKIEiFUj7kciNPu3n7AZUFJ41EeAvDL995aS5jVvn0st1qMuKFaf1DuwoXc0yUjtKrH7kd147VlXwbjB286NdsdmrrIG5glMBbA6ubvF1xmoi0YtsnJ2pVDVLch96aH9dhPbCjECvrdgGs1v86dVCUpYQNeDPuztFTC9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826077; c=relaxed/simple;
	bh=+nqrNVmYmohfUrprPzD9C57d3zHyTeg7Lioodc9p4g4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fiqIWe5myy+yIYLdThAPFegDVIMu78T9+zcuTAIowyFnQjIwaYtFQ6TKZxkbQarYnzZugVifga4JX6GijZgikW2aPmyjvYKtYoH9IgEyY2Hgbx+L5Bz8nHivOaXJQEyyGU23WsRF7eYbzrMCBYHTXngI0vB0opoAXDdNo6O/mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CUcvsj5s; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c998b36c6bso1234378b6e.3
        for <cgroups@vger.kernel.org>; Wed, 15 May 2024 19:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715826075; x=1716430875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXSD811bYryV9ebSAntCLnwE4mJzzmb6s7DeS7yDo6M=;
        b=CUcvsj5sonSvj7lF7ElggVjGiNhtZN6I94+ShduIWD8EI9vcHl33AMM4pu6K2UaIhW
         AavsrkqmmlfEeKGaDcpvVlO71jdpZv9oeGpAOVcx3b1YXazjwXmCsL9u4tUNE7W21qED
         /8+OOhWWjSBHfoMi15vSSsGwKi62gmoGv96SI1Nu7DuMGZoPmHYWszzSLEvkzecGsMtM
         YH2DcK9W4i4YkwIYhUAwDk2gxuI0LQPA/OZwiOqbhcirwRCJ//jl7CPkFZztpxr80Mh0
         T+q8+4PoyuyePihpv+3jJ7QTgJnW/9hoKdfS6iBF0w3itT8DkzO3HS2S5jFCp5BmygJE
         gyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715826075; x=1716430875;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXSD811bYryV9ebSAntCLnwE4mJzzmb6s7DeS7yDo6M=;
        b=omWpVFyV/JR6/6WocD13n5tt8HfGj2MszR7XvqLJNvmrUDivO1FOkPeO/Csz06gIGG
         fZeZfEwVWSaVn9BiR0OWQIbEYda5ehs6bhwm1I61QGq3Y1Pp2s1tp0ITqP7kG4GB1S4j
         vS8iLzaP6lP4XU4HFHcMby8Dm85IT/c0xiQ0vJLLX7+o7PtM5Mis+Cw1hZNQ/UFA++u+
         Fn3QdYndDVoSsMyC3QpBMgDBBL5GAwk2aPDMp60TBeojF40wlXtmkCB8e3+aFTjBJXJV
         waYl9nqiE61MshLPPGZMOqDwFFSwiCkmZxrQxq9QfEG1qu7nCbygwVhB9vDIG1x+LKn7
         2w/Q==
X-Gm-Message-State: AOJu0YzFoGDpB+UnfuB5/2pXlClbO62zzTLD0+bUvNMvbQWih4L5IMqt
	PtInCFicBA588spmKi/Kx/KtWjqsdY0P0Nnj/tKA/tAP1fdJuV+WIDfgaBcAmIU=
X-Google-Smtp-Source: AGHT+IE3ahqmTSWsWI6SW0+bQ2oqoZ8kOwwhZn9lRGyp4StkWsHF4AWWVqRGdIlz+iKka73bNy5xEQ==
X-Received: by 2002:a05:6830:14cd:b0:6f0:e2aa:ea49 with SMTP id 46e09a7af769-6f0e92ce674mr20305110a34.3.1715826075518;
        Wed, 15 May 2024 19:21:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634024a3eb4sm12257551a12.0.2024.05.15.19.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 19:21:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Schatzberg <schatzberg.dan@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20240515143059.276677-1-longman@redhat.com>
References: <20240515143059.276677-1-longman@redhat.com>
Subject: Re: [PATCH] blk-cgroup: Properly propagate the iostat update up
 the hierarchy
Message-Id: <171582607425.11025.1197820625337989209.b4-ty@kernel.dk>
Date: Wed, 15 May 2024 20:21:14 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 15 May 2024 10:30:59 -0400, Waiman Long wrote:
> During a cgroup_rstat_flush() call, the lowest level of nodes are flushed
> first before their parents. Since commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()"), iostat propagation was still done to
> the parent. Grandparent, however, may not get the iostat update if the
> parent has no blkg_iostat_set queued in its lhead lockless list.
> 
> Fix this iostat propagation problem by queuing the parent's global
> blkg->iostat into one of its percpu lockless lists to make sure that
> the delta will always be propagated up to the grandparent and so on
> toward the root blkcg.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Properly propagate the iostat update up the hierarchy
      commit: 9d230c09964e6e18c8f6e4f0d41ee90eef45ec1c

Best regards,
-- 
Jens Axboe




