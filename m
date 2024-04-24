Return-Path: <cgroups+bounces-2698-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D88B1706
	for <lists+cgroups@lfdr.de>; Thu, 25 Apr 2024 01:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880301C236EF
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1841C16F0DE;
	Wed, 24 Apr 2024 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDBmXtqK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA40156F5D
	for <cgroups@vger.kernel.org>; Wed, 24 Apr 2024 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001034; cv=none; b=Vbx2sfQD0H387ZRvYoo+VfGAcyO4/haRi5Yu2HIoPhbe4LVUwDfXShbf0y1rAGD05AC7byYa+twZWdf8DS+zudm0rPO2sS2NkZIex6epvQp4xkPfg25CEHWqxEKrmvTWbZ3Fj7w0lhGxS+2oYc0cHyJkJZl7xMpqMXcK81UOmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001034; c=relaxed/simple;
	bh=kWYPE52TsD9tInankw4Nl3ZO8d6bCgXJgGeWHlBI7E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhqFbxfmTGxzkaga6IE4SCgwYCueQKKFD0RaBfW9J/ZUKcd8cgvS0UVjo6GwImcptOt7O20zhjf60DQtD2798RGziNQZn9hwBmqGSiYcEaMTagr0T/Ej4493wyv2zzRE89QDW3JiuJXhecBT3rICi48AVuwDNHHaQC/0LO/6RoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDBmXtqK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so4195211fa.3
        for <cgroups@vger.kernel.org>; Wed, 24 Apr 2024 16:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714001031; x=1714605831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4Xhz5NWCXtt8nKXxeIFmhH8Oed5NRQI3JQnJYBJb4s=;
        b=ZDBmXtqKUgzM5W6Y9v/FaSWCHcLxNWr12HbqWLBMO6yf6A8OTiahKd3JK1posYwxSG
         vuMm8PFjLRvrMt5lwZUyiweQsVDVF/F62rnhi0zCE97/mNJZDsIrMMajRsNQZSWmr4og
         91mlctLys46RrYkEjgAGu3mrzHmHtO6IJiTk66weMjRoMXvW0gpylRits2TiFvcY1cMt
         BY5wd9sliMz2uIigVPYvjLwCd1a6JIZf3M2FhGr/gSilxQWrA4VkRFCwDVXgAf+hN4jo
         BJ3M7EGjRQdm3yamJoku/qFFDjGF1fVDfDEZ7VgXBFd+amcVrRPryrjanJWvvXizAaAS
         nCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001031; x=1714605831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4Xhz5NWCXtt8nKXxeIFmhH8Oed5NRQI3JQnJYBJb4s=;
        b=v6Yx/+G5lYhGjzeqX8IUfSNa9vfuQaFdUb2q7Km3DtIp0f0BkMRUGuc9HMsVSIiS6c
         I5y5FvnIZds8YsMXkKual0C8nO/7dMcLRDk+FQPiI7uedh14vmUOi6UFj+/7VqpyKvFS
         O2V8ThVTWZOePekxWMvZVWGaF/bpkuvAjObV5fbr+J17ZMn3E+82nZH3KvPTLjxSSBPM
         RMJ7dfC4x4IJggDlr82pHoH6Whgm/Hsk0r+7yMMdqRRYi9rWbSYLuQHL0QdjPRVkp2c8
         /RRAlZN0+J49phhK26AP6q2sMklnIG6xYXMcpj+fkB/VRSrawP+8OpfTzNkvsv4mWVDg
         VAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU7YWTczz135ezZAEW9OkhFPcpTMdADdEFrPfDzGEZSGq/sGgTSr9Kgjx9rYqBDWh8dHqynNZF5PuzD8ApEKeK/CZMbQzAOg==
X-Gm-Message-State: AOJu0YyJjjg9akD+WinVzOwSPZoxBQ5oLwQ2cFe7vm4qzXSQtwRtmrCc
	xuoF/Oahi38YU0PdeuqQhsU+RzC2i7b4oDxvYIm7cUCgkH+1E/M4Ot7hFVtTy7srT24OFA+3jjZ
	j+Ua4ojLYqcqCVVuJ7z59qZ2ByN0Vd+hNOEBL
X-Google-Smtp-Source: AGHT+IHPC10+jHzeG+tgpIIgUMIPE4SuCr0QvH7By3qs7yKyt3sGcnqfFcju9V2mis/w27r/UIkSloxyYeZtRuWl320=
X-Received: by 2002:ac2:4254:0:b0:519:63c1:6f45 with SMTP id
 m20-20020ac24254000000b0051963c16f45mr2385942lfl.61.1714001031354; Wed, 24
 Apr 2024 16:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424125940.2410718-1-leitao@debian.org>
In-Reply-To: <20240424125940.2410718-1-leitao@debian.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Apr 2024 16:23:12 -0700
Message-ID: <CAJD7tkaWw14fLvCKE5-3U-FLm_0bsMJHcxHEFJwgGdfsR4SzMw@mail.gmail.com>
Subject: Re: [PATCH] memcg: Fix data-race KCSAN bug in rstats
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, leit@meta.com, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:00=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> A data-race issue in memcg rstat occurs when two distinct code paths
> access the same 4-byte region concurrently. KCSAN detection triggers the
> following BUG as a result.
>
>         BUG: KCSAN: data-race in __count_memcg_events / mem_cgroup_css_rs=
tat_flush
>
>         write to 0xffffe8ffff98e300 of 4 bytes by task 5274 on cpu 17:
>         mem_cgroup_css_rstat_flush (mm/memcontrol.c:5850)
>         cgroup_rstat_flush_locked (kernel/cgroup/rstat.c:243 (discriminat=
or 7))
>         cgroup_rstat_flush (./include/linux/spinlock.h:401 kernel/cgroup/=
rstat.c:278)
>         mem_cgroup_flush_stats.part.0 (mm/memcontrol.c:767)
>         memory_numa_stat_show (mm/memcontrol.c:6911)
> <snip>
>
>         read to 0xffffe8ffff98e300 of 4 bytes by task 410848 on cpu 27:
>         __count_memcg_events (mm/memcontrol.c:725 mm/memcontrol.c:962)
>         count_memcg_event_mm.part.0 (./include/linux/memcontrol.h:1097 ./=
include/linux/memcontrol.h:1120)
>         handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622)
> <snip>
>
>         value changed: 0x00000029 -> 0x00000000
>
> The race occurs because two code paths access the same "stats_updates"
> location. Although "stats_updates" is a per-CPU variable, it is remotely
> accessed by another CPU at
> cgroup_rstat_flush_locked()->mem_cgroup_css_rstat_flush(), leading to
> the data race mentioned.
>
> Considering that memcg_rstat_updated() is in the hot code path, adding
> a lock to protect it may not be desirable, especially since this
> variable pertains solely to statistics.
>
> Therefore, annotating accesses to stats_updates with READ/WRITE_ONCE()
> can prevent KCSAN splats and potential partial reads/writes.
>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

, and or posterity:
Fixes: 9cee7e8ef3e3 ("mm: memcg: optimize parent iteration in
memcg_rstat_updated()")

