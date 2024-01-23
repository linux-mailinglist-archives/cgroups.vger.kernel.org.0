Return-Path: <cgroups+bounces-1219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CD8390A6
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 14:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341DCB260BF
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE135F840;
	Tue, 23 Jan 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Twv+Y4Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354915F565
	for <cgroups@vger.kernel.org>; Tue, 23 Jan 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018299; cv=none; b=iHEx9HnJS97mQiN7FQDQjxd2JU71DN+x9jCq4Ux+ix/0HhfGUH+r+25d+kVeMcZQQLEkG6wjBsoFJFuoWgORy7suwDNs1URcj9sUz9J4w4bJFKhV1aYvq5C7av19A0B3dGz8BVXhrG7cMg/kwhWx1IoWt3n6nwSotY41FJQqPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018299; c=relaxed/simple;
	bh=MS6bYrlmg0t1k95bdrFkYhGX+I6eMjeZeyKcqKwleE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2uewN3n9ptBVg4llZJRJiSIifB/k0H1EIp3CcvTNkiUWszJEJlWNk30Y5Gbfg1lGrLJZ2tCTbBV/+Xc9xbdAJ1sNYq68MKm+ccCpghgN36btlnWTuuWeFoWh+mIUXAxSXeC+lNprOD054UMoa15rO8VSv4SRGPazXQRLGaghHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Twv+Y4Y; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff7a098ab8so34577277b3.3
        for <cgroups@vger.kernel.org>; Tue, 23 Jan 2024 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706018297; x=1706623097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Unn/XUQhMtWV3m5yOooWqaet1YVy9czMl29ZsBMY8K0=;
        b=0Twv+Y4YDQOI97H6c99AC3CHrW0Pp1o/zZOPWqbU7TjUP7yhclHcXscZuf2Nqnf+id
         qR1zhi8PFpeDTRvUdHjZF5bNUFXizXyY3v1rXkSJEUhEIDQ6a+JPY672NEYN4urdXklq
         Le3BXd9pfp6A7Tu+mtkwJQwxpGgwN1jirjZxOI1PWleN+DH9TPwTvRcUyAn4EUXGOwqE
         bp6nlGdJO6GiwTh/2jMF8+bNX6cshFCSM9hyPhGMc432TjYi9DlG7wFXXeVZrs67/J5O
         NYUPn79HhauzTjVRAc5r4gjDrLamSa1kX8GZWsRgy8+F2n6CtchVd6i2jsa02oy2uiZ0
         xQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018297; x=1706623097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Unn/XUQhMtWV3m5yOooWqaet1YVy9czMl29ZsBMY8K0=;
        b=sI9wLh/ICLVeErlo/1/MCRBkPt0ur0OM01CVDazVC/SWLGbXPxQjYJW/E+99GTfKSg
         TqsgIILqMV0SPTlXp5ApFvZ0OCGQBCOYthRqfvKxTld6Ww3+RpDYthk4Mo8VKG890zQ1
         Ip4mgW87vOeCfhTox9puModANqSNR1GKYsfJ3WJkNcbye5aTiKd/yAcR0kDaXkARZn5I
         lMldwqnA71l88MgFV5c/xl6ogwF412eOEJRsqaOq7xogKWaHxd9VNd0iXtQhOTl1Lpzn
         z8V0B+tgl1joiuzM+mz9YGLRGmfB9DEPnxCLug5sy5a0jWpIiOi178ArK8fw5rmgYMlf
         DPYg==
X-Gm-Message-State: AOJu0YwI+GyNy3ajdN3zsXKfbJQGJ45a8jbMmx28bBds7OfY+27vmlpj
	3V6nkSQDkKCJUNgVp5UBHt15qqnVWo+jp0I6uNvKjWde3KGTpketAFTFLkUk9EDvlvzWsHmxQSE
	HCl9CCuQNsJy1P2yC0B6t/XQaXs3CKT3AsviA
X-Google-Smtp-Source: AGHT+IHY/qLbl37tVuFXj90DELM5aSYNnxau4XIsFG7zlEDgdKDus8DEj9COcAlaZJwjLiawQKFxgWu4UxLMxlUfQSY=
X-Received: by 2002:a81:840b:0:b0:600:769:179f with SMTP id
 u11-20020a81840b000000b006000769179fmr2815522ywf.17.1706018296914; Tue, 23
 Jan 2024 05:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121214413.833776-1-tjmercier@google.com> <Za-H8NNW9bL-I4gj@tiehlicka>
In-Reply-To: <Za-H8NNW9bL-I4gj@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 23 Jan 2024 05:58:05 -0800
Message-ID: <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, yuzhao@google.com, 
	yangyifei03@kuaishou.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:33=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Sun 21-01-24 21:44:12, T.J. Mercier wrote:
> > This reverts commit 0388536ac29104a478c79b3869541524caec28eb.
> >
> > Proactive reclaim on the root cgroup is 10x slower after this patch whe=
n
> > MGLRU is enabled, and completion times for proactive reclaim on much
> > smaller non-root cgroups take ~30% longer (with or without MGLRU).
>
> What is the reclaim target in these pro-active reclaim requests?

Two targets:
1) /sys/fs/cgroup/memory.reclaim
2) /sys/fs/cgroup/uid_0/memory.reclaim (a bunch of Android system services)

Note that lru_gen_shrink_node is used for 1, but shrink_node_memcgs is
used for 2.

The 10x comes from the rate of reclaim (~70k pages/sec vs ~6.6k
pages/sec) for 1. After this revert the root reclaim took only about
10 seconds. Before the revert it's still running after about 3 minutes
using a core at 100% the whole time, and I'm too impatient to wait
longer to record times for comparison.

The 30% comes from the average of a few runs for 2:
Before revert:
$ adb wait-for-device && sleep 120 && adb root && adb shell -t 'time
echo "" > /sys/fs/cgroup/uid_0/memory.reclaim'
restarting adbd as root
    0m09.69s real     0m00.00s user     0m09.19s system

After revert:
$ adb wait-for-device && sleep 120 && adb root && adb shell -t 'time
echo "" > /sys/fs/cgroup/uid_0/memory.reclaim'
    0m07.31s real     0m00.00s user     0m06.44s system


It's actually a bigger difference for smaller reclaim amounts:
Before revert:
$ adb wait-for-device && sleep 120 && adb root && adb shell -t 'time
echo "3G" > /sys/fs/cgroup/uid_0/memory.reclaim'
    0m12.04s real     0m00.00s user     0m11.48s system

After revert:
$ adb wait-for-device && sleep 120 && adb root && adb shell -t 'time
echo "3G" > /sys/fs/cgroup/uid_0/memory.reclaim'
    0m06.65s real     0m00.00s user     0m05.91s system

> > With
> > root reclaim before the patch, I observe average reclaim rates of
> > ~70k pages/sec before try_to_free_mem_cgroup_pages starts to fail and
> > the nr_retries counter starts to decrement, eventually ending the
> > proactive reclaim attempt.
>
> Do I understand correctly that the reclaim target is over estimated and
> you expect that the reclaim process breaks out early

Yes. I expect memory_reclaim to fail at some point when it becomes
difficult/impossible to reclaim pages where I specify a large amount
to reclaim. The ask here is, "please reclaim as much as possible from
this cgroup, but don't take all day". But it takes minutes to get
there on the root cgroup, working SWAP_CLUSTER_MAX pages at a time.

> > After the patch the reclaim rate is
> > consistently ~6.6k pages/sec due to the reduced nr_pages value causing
> > scan aborts as soon as SWAP_CLUSTER_MAX pages are reclaimed. The
> > proactive reclaim doesn't complete after several minutes because
> > try_to_free_mem_cgroup_pages is still capable of reclaiming pages in
> > tiny SWAP_CLUSTER_MAX page chunks and nr_retries is never decremented.
>
> I do not understand this part. How does a smaller reclaim target manages
> to have reclaimed > 0 while larger one doesn't?

They both are able to make progress. The main difference is that a
single iteration of try_to_free_mem_cgroup_pages with MGLRU ends soon
after it reclaims nr_to_reclaim, and before it touches all memcgs. So
a single iteration really will reclaim only about SWAP_CLUSTER_MAX-ish
pages with MGLRU. WIthout MGLRU the memcg walk is not aborted
immediately after nr_to_reclaim is reached, so a single call to
try_to_free_mem_cgroup_pages can actually reclaim thousands of pages
even when sc->nr_to_reclaim is 32. (I.E. MGLRU overreclaims less.)
https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/

