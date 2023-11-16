Return-Path: <cgroups+bounces-455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218777EE52F
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 17:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CBC1F2117B
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3930F93;
	Thu, 16 Nov 2023 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e//oMVnh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98EE19B
	for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 08:30:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40a426872c6so91885e9.0
        for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700152203; x=1700757003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F38ipVUNvi48KLUDF7UtMFc73Zu13fPzsb7BsE5kJSc=;
        b=e//oMVnhugdxZVRTiLqPYA3eLopxTxbjUr9MetKr0aqj4vesYAxgpODZf5PWm/2gtl
         eb0ZN1YTDM1/2/DnwYayPSn+qiLJTSAB+JYEGBy5IZ67940Ohb+lG1bkusSs+SzUi826
         jbZFxK/atYbzkLP4yAsHUUJB1fBoLIyxYD4urkUbZt8X4my6ZE72b9qCQEqwVZUhe+h7
         Afx0zlQcAoWwvHpcvXtIOld/nuEJySji/8oUBE3k5mpEWfymBT3eIByofGgddzXJ/xz8
         Nd9MGpP4p5T+0cbwXQ/DPIslB1obr7TeRd9ehk+g062m9jVlwUfWe79u6i9CIpp4EZt5
         jNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700152203; x=1700757003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F38ipVUNvi48KLUDF7UtMFc73Zu13fPzsb7BsE5kJSc=;
        b=ClS3643CP+DBWvZSuFHOsHefkj2IR8WBSMAcOmFCrCuIwyjOrqruFuWnmR2lvCRQlv
         ip4dZMiLejBoWJVu1xr0YxzGugSY1v5QMdJaXaVkx0zDl80tbWChY0JHD3ndRXKH2D6/
         a7u7gbAUYI2XRavmD3WGqq9Hr10AKUfVPtYmwElT8P+sd+C6tmzrt5aeF64DdfjhfpLV
         NAvVKwJ91GEAW/44a+Ne7bmJjcODgLnt6By1kx0PvHGcvCClQ6kpcEiBvXI0EJJNAt0R
         LXeGn2lzI/VYGt0Y8B+9FatkKn6C4BL4EgYqFkIdJIoNxDAITrkp8HoGW93cibpEU5ey
         gjPw==
X-Gm-Message-State: AOJu0Ywi0noYsTueOTzT3ozcRkiFfDbTAGcO3CK4TJ0xk19MLzvB3HVS
	pcA9zmZ2btCP19a39St8492wPkJCKgWCmpNbRMwf4tD3JrAw7+3nooQ7kw==
X-Google-Smtp-Source: AGHT+IHTSAO3ZZWQEDfwlIxcr2RQHkWHxU1lY0UMFAqrwEicgTwTY4mkmAJXdjESEXa6UsOxY2NYQCZ4aKF8v3hJKeM=
X-Received: by 2002:a05:600c:3f8b:b0:3f4:fb7:48d4 with SMTP id
 fs11-20020a05600c3f8b00b003f40fb748d4mr142802wmb.3.1700152203066; Thu, 16 Nov
 2023 08:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115162054.2896748-1-timvp@chromium.org>
In-Reply-To: <20231115162054.2896748-1-timvp@chromium.org>
From: Mark Hasemeyer <markhas@google.com>
Date: Thu, 16 Nov 2023 09:29:51 -0700
Message-ID: <CAP0ea-s2QwQhKpu81b+n5Fcq7dscbwTxoFf2tpV926RXw3ca1g@mail.gmail.com>
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
To: Tim Van Patten <timvp@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tim Van Patten <timvp@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> From: Tim Van Patten <timvp@google.com>
>
> __thaw_task() was recently updated to warn if the task being thawed was
> part of a freezer cgroup that is still currently freezing:
>
>         void __thaw_task(struct task_struct *p)
>         {
>         ...
>                 if (WARN_ON_ONCE(freezing(p)))
>                         goto unlock;
>
> This has exposed a bug in cgroup1 freezing where when CGROUP_FROZEN is
> asserted, the CGROUP_FREEZING bits are not also cleared at the same
> time. Meaning, when a cgroup is marked FROZEN it continues to be marked
> FREEZING as well. This causes the WARNING to trigger, because
> cgroup_freezing() thinks the cgroup is still freezing.
>
> There are two ways to fix this:
>
> 1. Whenever FROZEN is set, clear FREEZING for the cgroup and all
> children cgroups.
> 2. Update cgroup_freezing() to also verify that FROZEN is not set.
>
> This patch implements option (2), since it's smaller and more
> straightforward.
>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
>
>  kernel/cgroup/legacy_freezer.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
> index 122dacb3a443..66d1708042a7 100644
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -66,9 +66,15 @@ static struct freezer *parent_freezer(struct freezer *freezer)
>  bool cgroup_freezing(struct task_struct *task)
>  {
>         bool ret;
> +       unsigned int state;
>
>         rcu_read_lock();
> -       ret = task_freezer(task)->state & CGROUP_FREEZING;
> +       /* Check if the cgroup is still FREEZING, but not FROZEN. The extra
> +        * !FROZEN check is required, because the FREEZING bit is not cleared
> +        * when the state FROZEN is reached.
> +        */
> +       state = task_freezer(task)->state;
> +       ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
>         rcu_read_unlock();
>
>         return ret;
> --
Tested-by: Mark Hasemeyer <markhas@chromium.org>

