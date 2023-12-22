Return-Path: <cgroups+bounces-997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF881C4A7
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 06:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9FE2874D1
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FE53A4;
	Fri, 22 Dec 2023 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3csyLWMQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C81539F
	for <cgroups@vger.kernel.org>; Fri, 22 Dec 2023 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so34895e9.0
        for <cgroups@vger.kernel.org>; Thu, 21 Dec 2023 21:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703223157; x=1703827957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aei49JaNshkuJJzrb21/FHbkROcvggHQaKMtSVNdNfI=;
        b=3csyLWMQHZj8+S7+DD/W2J95An+k5Mco4O/Vwiz3LRe647IDsjMFk5sU5sqWVqc8jT
         n2obgHvv/AH/YuK/dRKrmQ8Lvv0H1zHcHJl0MyaLjYqQZ2laNvpD5BhMm/5IaS6CtZ2c
         RZp2PAWEs0Vje5nGKoxfweFUERgTsqwFVFj7lxzDFka21fILAuFHj36t6FzIlMLcUgP5
         Q+FrdjCs80pPjrZJxTto4PeNWx8UZYfAV9HtL+DUfORYQTdgJyY5zpxrkHh1sGF7jPdH
         kicJQ/8GCoLfOm6goEmdWsefJgRuhvmjDz/e0f+ctXOiSJV1v9+LzFv/H1TflhncdWfZ
         XQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703223157; x=1703827957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aei49JaNshkuJJzrb21/FHbkROcvggHQaKMtSVNdNfI=;
        b=ZJpexLqj+gyMgPHKNb1NcjLPDYCEnouHbqfrQB9UrW7Zm8S5ZySaTHgTTCQpWMAR7N
         3AaqaKFqKZhrLulH3IRJ9MpMmGn4Orve3KFMOHAKQJqO6dpgBd04U9vVDYm92EvFDL9I
         dJSbs/Gzgb1ow8L/6aJ51Q5ghJO2LLc/6oZ/4kpy2m0Ze4wZZAlT9EtfZtz+Fl9Lbx5T
         ZAd2qExmniDk4E4gdPv2C7pEginMgm9FiUBvo6UGX/hABDFCWL88sLTI7TkXcpzA1EzL
         SqedIxA22ee+Dhq0NNDtTbdg9j4WNNiWqJo9oVoApmGXRGeP0ZfZlBXPauNCv/136YgR
         sn+Q==
X-Gm-Message-State: AOJu0YzEMNDosRwwWWCUR2IrniVs2OrTvUgHGS/drxJe22QvStFtAgzh
	iVxOY/+7VSHJiDJ7r3TTl/uiCUJ2Z4JzFevwX/jv8eDU9f5W1Cqp0qdteMSoyth9
X-Google-Smtp-Source: AGHT+IFtz4p23N7qFQyJ8bmGETMjPxi+UsXnIB0l2LyxDlv5gRmgh40FQ/h5BJF9BFQu01W4sbr5+rn5xst7zCPNa6g=
X-Received: by 2002:a05:600c:1c85:b0:40b:4355:a04b with SMTP id
 k5-20020a05600c1c8500b0040b4355a04bmr70112wms.6.1703223156969; Thu, 21 Dec
 2023 21:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com> <20231220152653.3273778-3-schatzberg.dan@gmail.com>
In-Reply-To: <20231220152653.3273778-3-schatzberg.dan@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 21 Dec 2023 22:31:59 -0700
Message-ID: <CAOUHufYwPzZ7k=ecFkxaw+26hUkiTODEnmKM8b3=Lk=n+bm29w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, SeongJae Park <sj@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Yue Zhao <findns94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 8:27=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> Allow proactive reclaimers to submit an additional swappiness=3D<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
>
> For example:
>
> echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
>
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
>
> Userspace proactive reclaimers use the memory.reclaim interface to
> trigger reclaim. The memory.reclaim interface does not allow for any way
> to effect the balance of file vs anon during proactive reclaim. The only
> approach is to adjust the vm.swappiness setting. However, there are a
> few reasons we look to control the balance of file vs anon during
> proactive reclaim, separately from reactive reclaim:
>
> * Swapout should be limited to manage SSD write endurance. In near-OOM
> situations we are fine with lots of swap-out to avoid OOMs. As these are
> typically rare events, they have relatively little impact on write
> endurance. However, proactive reclaim runs continuously and so its
> impact on SSD write endurance is more significant. Therefore it is
> desireable to control swap-out for proactive reclaim separately from
> reactive reclaim
>
> * Some userspace OOM killers like systemd-oomd[1] support OOM killing on
> swap exhaustion. This makes sense if the swap exhaustion is triggered
> due to reactive reclaim but less so if it is triggered due to proactive
> reclaim (e.g. one could see OOMs when free memory is ample but anon is
> just particularly cold). Therefore, it's desireable to have proactive
> reclaim reduce or stop swap-out before the threshold at which OOM
> killing occurs.
>
> In the case of Meta's Senpai proactive reclaimer, we adjust
> vm.swappiness before writes to memory.reclaim[2]. This has been in
> production for nearly two years and has addressed our needs to control
> proactive vs reactive reclaim behavior but is still not ideal for a
> number of reasons:
>
> * vm.swappiness is a global setting, adjusting it can race/interfere
> with other system administration that wishes to control vm.swappiness.
> In our case, we need to disable Senpai before adjusting vm.swappiness.
>
> * vm.swappiness is stateful - so a crash or restart of Senpai can leave
> a misconfigured setting. This requires some additional management to
> record the "desired" setting and ensure Senpai always adjusts to it.
>
> With this patch, we avoid these downsides of adjusting vm.swappiness
> globally.
>
> [1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.s=
ervice.html
> [2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins/S=
enpai.cpp#L585-L598
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

The cover letter says:
"Previously, this exact interface addition was proposed by Yosry[3]."

So I think it should be acknowledged with a Suggested-by, based on:
"A Suggested-by: tag indicates that the patch idea is suggested by the
person named and ensures credit to the person for the idea."
from
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-t=
ested-by-reviewed-by-suggested-by-and-fixes

>  Documentation/admin-guide/cgroup-v2.rst | 18 ++++----
>  include/linux/swap.h                    |  3 +-
>  mm/memcontrol.c                         | 56 ++++++++++++++++++++-----
>  mm/vmscan.c                             | 13 +++++-
>  4 files changed, 69 insertions(+), 21 deletions(-)

...

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d91963e2d47f..aa5666842c49 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -92,6 +92,9 @@ struct scan_control {
>         unsigned long   anon_cost;
>         unsigned long   file_cost;
>
> +       /* Swappiness value for reclaim. NULL will fall back to per-memcg=
/global value */
> +       int *swappiness;

Using a pointer to indicate whether the type it points to is
overridden isn't really a good practice.

A better alternative was suggested during the v2:
"Perhaps the negative to avoid unnecessary dereferences."
https://lore.kernel.org/linux-mm/dhhjw4h22q4ngwtxmhuyifv32zjd6z2relrcjgnxsw=
6zys3mod@o6dh5dy53ae3/

Since only proactive reclaim can override swappiness, meaning it only
happens if sc->proactive is true, I think the best way to make it work
without spending much effort is create a helper as Michal suggest but
it should look like:

sc_swappiness()
{
  return sc->proactive ? sc->swappiness : mem_cgroup_swappiness(memcg);
}

In this patchset, sc->swappiness really means
sc->proactive_swappiness. So it should be renamed accordingly.

