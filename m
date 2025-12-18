Return-Path: <cgroups+bounces-12482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3920CCAB17
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FC43050CD1
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618E322DBB;
	Thu, 18 Dec 2025 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aei7zs24"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760B2E11DC
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043385; cv=none; b=E0M21AeNfXJdkDXx53I1XtaXOaSFTObkaVa8EqQLbpyJRA/nVLHFSr+cnWPcy9lKnBiLNV11ub1t8G+ngguPpXpJ5A/MNrAU1dPLp0YsD9T/8F7hE5WDc8hSSeGQo78oMJBZe+jdDOKdFDpVfsfrAtIvOwt7rjQtr+XrGaFo7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043385; c=relaxed/simple;
	bh=4aIek/r3ZvSZ4NS7Eu0mJEJ0FiVX1NZ7Td7KyjtnmOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hhs2vfawjDBsPijFVjNuHQehg1PH5PhcVqBhFCmssnYh+MuE1CVvRUzr+G+Mi2OA8Ak7gsfj2DL9n2lWfqTUaShs/APVsX8V1CVmXYoijIm6tTx5ULJNoKN2+rD5zSI+/d4Wl0usKuew8GnGWZtXxUVuZl3EtzXteS/OedPgO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aei7zs24; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34b75fba315so368515a91.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 23:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766043382; x=1766648182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aIek/r3ZvSZ4NS7Eu0mJEJ0FiVX1NZ7Td7KyjtnmOU=;
        b=aei7zs24OinNurGYasED2tRDPjSymQPV7V0B+zO5s2YqleQpDKTcdFNusKWp/fJnlV
         M89COSjo0WFJJ5tQ/yE189GVeO421tGPiyv0caT0Qkh5/IA+6r9BAd/IlRkzJTDyRl4m
         oUQe6tWHtsDuP6SkW+8Cen8IOivg2vVaAOhEWSsR8QA0BpOF9JqYk5MhPKNvPssBihkf
         fODEOdSxNmgatBR5dI8js3HVAQro2Ai6KMAYBvQizu36iz47DwdALgitWdJ/oM3cBVal
         o1RvpdX6qaXZUhNEYINen85s2vthypzLK2nIDQ6YDZPwX+RQ1FOwRqOrsisEgaBMBlwS
         83Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766043382; x=1766648182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4aIek/r3ZvSZ4NS7Eu0mJEJ0FiVX1NZ7Td7KyjtnmOU=;
        b=jtdIQOFWCLX6PlC1PymQILVT7xCo4ZG/NioqWne5kjNPZAEhOxpKRoJ4cyf6q2jfCj
         blpitc+7L2aQZ+Flx5SASLThFRg7l+pUmpfMiTzQo0Y2I8sckj1I0q5h9zBhqw3au48+
         B66zAFW6zARRjFCHyzet1AWiz8Ub/nQuHbqMlTGgapq5wCB+9/gG8SHVeMVDMz8FnEts
         lnZ5HjvKsHkYzIIi4KRpXsZWj6HcXNW6iDVyTcXioNBuDz1VGTjTWeXmwWTBKhpjwuOA
         tQ20vIxFNM8uNA59tULvH/qe52UUBHRA3jZfIqz/d7scgtWGMol3NQihP+00y2pMEoFz
         aePQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/WM7OjulLrz9uNaYeyFvbXCCnuba/3K3z9Je6ftEDwHPBPTgDx08XX1ES8s4lJtOum+dyPizN@vger.kernel.org
X-Gm-Message-State: AOJu0YzLllPLsGAl2B4wsvv92FcDjBYLoawDMk/DZ6wmhVO+QUCJy6G6
	7nELWBmEDp3dKWEAS0tRz52F/gaJW0rm0XD0/rP1JnWpQ1UxX+2FdCLv1pyHgb+ja/A=
X-Gm-Gg: AY/fxX4ano3TdXQ/iszeJB30DtfLCi1WGAzXYOv0UfUwaIdEzENTjLPM8dYCdBslX8s
	TfyqXSYHJXlrtYriiEU7fMhds9N9A1MYqFazYfj5lqLFrjeJCCUB8eSsf/AFTasIVlqwj28SYND
	2iSi+7j+JHP3LVCaI4L+UbDI0IAMc1TQrN+yB/De4oWPa77Adk211+S9QfbR4SE8NbeFYmeTHGU
	B+svQlCkKDbRsBkFj7BmasfVCgSUaU8IxJsZ8TF/HNme6MbseYAEW2dZm70DjM84sxEfNnbaDJa
	uu9GBi3/DCS7Ih5Xsxljm0UWjLk1JiqA/I3DNjdRgzUf7Ph0gnPAfzAWvqejqdT8dFsCEPvikxU
	mMMqzKa646jQcm6513aowJKucqrMwglwyk7JwCPdo9Hzh148f/UM8GbEAwCWdODDTBsjiBmb683
	Q6zidXe8Wh
X-Google-Smtp-Source: AGHT+IFvKKZA75dhAyRaTORAr0HnIA2q74dEctLS6i9INOz8BbZ7JdbmOc07paSWeFTnByMaRQX9GA==
X-Received: by 2002:a17:90b:2b4d:b0:349:3fe8:170d with SMTP id 98e67ed59e1d1-34abe3dfe12mr16325954a91.3.1766043381960;
        Wed, 17 Dec 2025 23:36:21 -0800 (PST)
Received: from ubuntu.. ([103.163.65.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm1627169a91.0.2025.12.17.23.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:36:21 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: shakeel.butt@linux.dev
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	kdipendra88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Subject: Re: [PATCH] mm/memcg: reorder retry checks for clarity in try_charge_memcg
Date: Thu, 18 Dec 2025 07:36:13 +0000
Message-ID: <20251218073613.5145-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <hibelxfvkdvm6b2a6vmgdmwcne6e2z2hrshshacepgedduyejn@7kfdegbmwyvs>
References: <hibelxfvkdvm6b2a6vmgdmwcne6e2z2hrshshacepgedduyejn@7kfdegbmwyvs>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Why hopeless?

Because in this specific path the allocating task is already the OOM
victim (TIF_MEMDIE set). Any reclaim attempt performed by that task is
unlikely to make progress for its own allocation, since the kernel has
already decided that freeing this task’s memory is the resolution
mechanism. Reclaim may free some pages globally, but the victim itself
will still be exiting shortly, making retries for its own allocation
non-actionable.

> Why optimize for this case?

I agree this is a narrow case, but it is also a delicate one. The
motivation is not performance in the general sense, but avoiding extra
complexity and repeated reclaim attempts in a code path that is already
operating under exceptional conditions. The early exit reduces retry
churn for a task that is guaranteed to terminate, without affecting
non-victim allocators.

> Since oom_reaper will reap the memory of the killed process, do we
> really care about if killed process is delayed a bit due to reclaim?

Not strongly from a functional standpoint. The concern is more about
control flow clarity and avoiding unnecessary reclaim loops while the
task is already in a terminal state. I agree that this is not a
correctness issue by itself, but rather an attempt to avoid redundant
work in an already resolved situation.

> How is this relevant here?

This was meant to explain why exiting early does not introduce new
failure modes for the victim task. Even if the victim still performs
allocations briefly, the slowpath mechanisms already allow limited
forward progress. I agree this does not directly justify the reordering
by itself.

> Same, how is this relevant to victim safety?

Same answer here — these mechanisms ensure that the victim does not
regress functionally if retries are skipped, but they are not intended
as the primary justification for the change.

The primary intent of the patch is to avoid retrying reclaim for the
current task once it has been marked as dying, not to change OOM
resolution behavior. If this rationale is insufficient, I’m happy to
drop the patch or rework it with clearer justification or measurable
evidence.


