Return-Path: <cgroups+bounces-895-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8D808F1A
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE81F21130
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C54B134;
	Thu,  7 Dec 2023 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPgQg+it"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99F12E
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 09:53:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f62fca3bso14103241fa.0
        for <cgroups@vger.kernel.org>; Thu, 07 Dec 2023 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701971611; x=1702576411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej8XOnCH2VsZ/qShm6gnD6DULhgsDhDu14Fz2jUUZmE=;
        b=ZPgQg+itvxzN5Vw5a/c662emHmOeBkmMXS1vW3e6UWjkrUKmHz1p8BtKukTJsUp+w3
         LNL+xUafOLP9JcDbxxbIwiVA+rYrtBNRPq2PjZQoDw5q45u2aa2f1e1XdI2O0FtzZr+w
         o9Htppcy1HzHCPs1x2+nsOzi6/p5fo3qJvgs6symtiueJ0qIFEoKgiOGScYmJqVjOI3h
         TVDEFDxv2Npm66IHUs/wAgkuizAEulmOQh8W+1YP0oDjuVKTWcCZiR6Nve9i+n5JN17p
         CVLlCn29aWm/5MtbD0H7gYpCk2we/FIjdEQtYP6e93fJ5QJupdZr9ieLs9MOCxklvajU
         8rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701971611; x=1702576411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ej8XOnCH2VsZ/qShm6gnD6DULhgsDhDu14Fz2jUUZmE=;
        b=TPOPwfloCh10zcH28ReJHfH3DvfPvUVbKVkdwaMegN7IeOSH/upxEzOA5nkZo8S/xw
         PmPXYRRNMZznwp3jQJBj9nOSz4J6jNh6l8YMfmW5YCvZtAo6BLS4n+pPDCZaCVXChYN8
         PWwLUwT5FgFjEFTFVA8ddzWCqw8OfyMLd9u9wkzmsy9hwnWuJ2PFfsMKddkfj517UzRu
         rlqSqxVGoVUKAmZ+mhoOsWLlL9FvFVB0MyPgCKyAYQdyotRWdUZCrvcKXBCa5zn+no/q
         OMhorv3hWG9kVLmsPjLaVZIXJLnmiql/rX8vFZyeWWu/bEMjpSNvplnAvsUoCnS3TaTe
         +aag==
X-Gm-Message-State: AOJu0Yy6iP12zzzeT+c6/FIS1mg9RDooEkNKpSwBvDfacUK8lrgGuFqP
	msJ64XstngPAiq9SCs+fc2/I2L9xWFIQE2a0LKG3MQ==
X-Google-Smtp-Source: AGHT+IFSp7ZQgdeytewdjCrCAk/6O+2n4Z6XadRtIMNXGzlOiWvtudw1L7uZcT8Tl9dY9nr57EQaBQT3y1WABj45CSI=
X-Received: by 2002:a2e:98d7:0:b0:2ca:286:4b1c with SMTP id
 s23-20020a2e98d7000000b002ca02864b1cmr1948479ljj.91.1701971610472; Thu, 07
 Dec 2023 09:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207134614.882991-1-longman@redhat.com>
In-Reply-To: <20231207134614.882991-1-longman@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 7 Dec 2023 09:52:54 -0800
Message-ID: <CAJD7tka2op5wfRKawumoGrScVRA3qD0c2N-WshcmMbPzFBe0wQ@mail.gmail.com>
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of cgroup_root
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 5:46=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
> for freeing the cgroup_root.
>
> The current implementation of kvfree_rcu(), however, has the limitation
> that the offset of the rcu_head structure within the larger data
> structure must be less than 4096 or the compilation will fail. See the
> macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
> for more information.
>
> By putting rcu_head below the large cgroup structure, any change to the
> cgroup structure that makes it larger run the risk of causing build
> failure under certain configurations. Commit 77070eeb8821 ("cgroup:
> Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
> the last straw that breaks it. Fix this problem by moving the rcu_head
> structure up before the cgroup structure.
>
> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU=
 safe")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.or=
g.au/
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

 Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

