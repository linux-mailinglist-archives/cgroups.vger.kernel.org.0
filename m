Return-Path: <cgroups+bounces-887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C2807FD2
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 05:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164921C208BB
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 04:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E2BD280;
	Thu,  7 Dec 2023 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmmyYr5F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA610C8
	for <cgroups@vger.kernel.org>; Wed,  6 Dec 2023 20:52:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso603115a12.2
        for <cgroups@vger.kernel.org>; Wed, 06 Dec 2023 20:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701924745; x=1702529545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W1jLERIf0/mZcB/EwuwKYXs+J1GUC7lw1ozHshVhi8=;
        b=LmmyYr5FfhKtpMih88oqNC7r4uk1FsJuf40yQpeDkpL5BqCQMh+x+R13Y+I2OUadbU
         2fXh2iHSDMJrveSJtiknK74OX/5uzGyYU1fvu4pQbVysrkIKdmX+Bxw1qbgTQEIBQgU0
         OnYIb7F6dgbBnhNvSTMMjRTRrv8bsnLWSxTh0/Od1AMHynHbQtTo1RBjrxgc9+pczAmR
         MHySSdGG6OjvoOUwiVKGrQlCydV+YgoOX5sM9LiBuL6izR1G+bNi9E9d6UYXR56pN1/g
         POESlfc6bd5LVoeRKxNEYdtHJdwPQnWQodiGIypHVq9t25zDKxEWrh/B0/Go0ZWBxOgP
         kmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701924745; x=1702529545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W1jLERIf0/mZcB/EwuwKYXs+J1GUC7lw1ozHshVhi8=;
        b=pCDXWDCKC7hiBbd4a5OB461S7MJGfD+ZW3YUcoPfgojEEj1ZoRveQ4Q52b/cBhhWI5
         YqpEFA3EANOB/jweHzWnMmk/tygH/CQuQ4/TlkOjpyjP024pi4dvANuC27bnftU5IR7Y
         QE0PJcrgAggZer9xixRb5vcMVOhk/l+gUrwhodbVVUFnzOFKF9IBKOSpCXJXu24UxXQX
         PGZ4dkzSVx51zCxj2EDeifn2Ae2o8SbccsI3eJ8tCi/5F/P4k8sOg6bZ+XtqhvgM33cH
         EfmFNIYQX4x4tgmmcZBQorYJXOC1EMLZBjk4uLjcFuglLDhH/vc1lO9SZ8++pFIf3jwI
         +RkQ==
X-Gm-Message-State: AOJu0Ywo34bGU20AZbrd8k4gf85kxOYKqN+s66QCfJAzBQLcyJt0Wubx
	XsJpa5WpRkiJ171TtnPoOKB73/S3eR+eS01884hBj+yh276VmoOo9u8=
X-Google-Smtp-Source: AGHT+IEcq53OQy6kNgV3fdJ1HSf9E4kSUOmMcn5pXK0gqIExUqSsAN2/a27fT4ucmtcYxNfnFnFYH8BU2l9MNoGZbOs=
X-Received: by 2002:a17:906:ca50:b0:a02:ad84:3ab3 with SMTP id
 jx16-20020a170906ca5000b00a02ad843ab3mr1044738ejb.44.1701924745165; Wed, 06
 Dec 2023 20:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207043753.876437-1-longman@redhat.com>
In-Reply-To: <20231207043753.876437-1-longman@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 6 Dec 2023 20:51:46 -0800
Message-ID: <CAJD7tkZtt8xedBJyRns+6HpdXoBxadLUGuGNG5s1trEbRgb9hA@mail.gmail.com>
Subject: Re: [PATCH-cgroup] cgroup: Move rcu_head up near the top of cgroup_root
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 8:38=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
> for freeing the cgroup_root.
>
> The use of kvfree_rcu(), however, has the limitation that the offset of
> the rcu_head structure within the larger data structure cannot exceed
> 4096 or the compilation will fail. By putting rcu_head below the cgroup
> structure, any change to the cgroup structure that makes it larger has
> the risk of build failure. Commit 77070eeb8821 ("cgroup: Avoid false
> cacheline sharing of read mostly rstat_cpu") happens to be the commit
> that breaks it even though it is not its fault. Fix it by moving the
> rcu_head structure up before the cgroup structure.
>
> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU=
 safe")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/cgroup-defs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 5a97ea95b564..45359969d8cf 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -562,6 +562,10 @@ struct cgroup_root {
>         /* Unique id for this hierarchy. */
>         int hierarchy_id;
>
> +       /* A list running through the active hierarchies */
> +       struct list_head root_list;
> +       struct rcu_head rcu;
> +

Perhaps the comment should mention the placement requirements, and
maybe a pointer to wherever it is specified that the offset of struct
rcu_head should not exceed 4096?

