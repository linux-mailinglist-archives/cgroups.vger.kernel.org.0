Return-Path: <cgroups+bounces-4867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B352E9770EC
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 20:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760502814C3
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E41B654F;
	Thu, 12 Sep 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLhn2ytt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE312BAE3
	for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167066; cv=none; b=X0fip/7rgfyfUILoof5GQU0NN9lC3eKlemwk8SIRHwRlp/4JHWCDdLD+SFTyTJyriFegMO19vaFkdliwtSL5E1MrkVnouBOozWmeYkAZqzh+Y6ccfSpbAln+hEmkkFUU692ZCc8Qj7WYfi0+5ezgwwjAV2U/nSJgEaRFYLz2/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167066; c=relaxed/simple;
	bh=2A/QfAynXKpV+8FU25VEKx2tUcXyN85QQTyRvY+ivQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwcyePmm36Du8YjNc2EBJxOMyCMuwpCx1c3M0pPNXczOTYuW6hSdmXvYMYo6f1fWUtg2CAVxQYT2JW1wQJQTwUb42rGcCR0eSzJx/gx9W5Jzh/YgKDjm6hkCY+UT9KNDpdxRsMUaV/mjuA0oSPB/7TGzxDwdV+mQ6wPjwh7uJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLhn2ytt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so1831888e87.0
        for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167063; x=1726771863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7bWKO38Qf894pq8zFNg+EuWT5DdQohpoosxwSmJBDM=;
        b=FLhn2ytt/EJ6sGiJf2ZdZ54z850+eY3AsQMYNg2bOexynzA5ppZ/6VdEVHFvVtFRe/
         cyqd/k1o7kX1FMtiVwanSRi6m+yGuaoMEYoznUCBh4vON7mjPpBueOfus1pAU21WCZBR
         GRxEPZxsBEEaPN/hTJ/9pyQMUXPAgkxZG5CKKps+Wf1LneLikPJfjLd2sZLVUHY7SUMt
         HZy3twS4hDRTRjN02axBCttku8sDbhpAlq/2AoLS1qt0jgGJ3lFZlyzZEI4Xk60kGkgh
         tpQyFFXRks8I7tOdWJaPvjzXuaJxbkFm9PTKXZs4xVvWXuCG6/GLp3WXblMgqIGkjrM2
         TVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167063; x=1726771863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7bWKO38Qf894pq8zFNg+EuWT5DdQohpoosxwSmJBDM=;
        b=ESCLlM7+mKHJxCBhmwQgPKT3qmdJGYzbdGsqKFdsjL2J/jZsnewkNAky9Snm850X45
         NAjkAvopOlzWQZJB+w37t5fXsAczHn1eO5bwMCotmVviuI5a2q3lbzb9LX0A8mmzfvxH
         AMrbexzig+e0yymdWWJBtjiB6MCXWrhXC4+WNwgKS/6djp5wIexiHP6t3/zUXCkaxoiM
         5F9EflPRG+cuLJ3D9DrmoN2rlqRVOVuSefbtsy1R6wfvkveGSwVrFEEfYk66R85t8OsK
         MXwOWIQ0TNsXmEtaANKNRz4E1kCLcedqB48CXJRgYKGU2YdRWoXZrlvQOeo0yghLUPoG
         dPJA==
X-Forwarded-Encrypted: i=1; AJvYcCUizEu6lah/oqEn29RNHiXifJAnrFuh5cMnx1yYdA9cgSD8RjMbQjF1wlthKFTf48MMSdr4PeeT@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlcSJMBq8HqADSSMvkRBV1yQoTVGLkKvs3HD8VM6U2GR6GsUd
	yyH2cmPNkAVy6apu2dwFgz6NdreiB7F0Gz2LL/OQNyoctEKR7oyXsqBpkkpJv7xwbdP9JYJwfGW
	UNFbnr6LeNgXslvxcJn7spPqZq6+ymFQJL3FA
X-Google-Smtp-Source: AGHT+IGbsQyMnaE2mOrQPBKLZNE9IHxt090oc8KlhsXnAdhsVXdMcywgStpHdkAnRMuzThus9L/uQOrGK/gKgUNwOw8=
X-Received: by 2002:a05:6512:b23:b0:52e:f99e:5dd1 with SMTP id
 2adb3069b0e04-53678feb480mr2327014e87.47.1726167062504; Thu, 12 Sep 2024
 11:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org> <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
 <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org> <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
 <CAKEwX=PTA0OxisvY12Wa95s5KqzvQTXe1rZ7nw29nP+wR2dxkA@mail.gmail.com>
 <CAJD7tkbMph337XbBTbWfF8kp_fStP3-rN77vfR5tcn2+wYfJPQ@mail.gmail.com> <CAKEwX=PcK=kJG-yxaoTYvJGNwQ=eTGo1m=ZraqYy1SyLDs9Asw@mail.gmail.com>
In-Reply-To: <CAKEwX=PcK=kJG-yxaoTYvJGNwQ=eTGo1m=ZraqYy1SyLDs9Asw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Sep 2024 11:50:26 -0700
Message-ID: <CAJD7tkYhOphYbNnwkZfJykii7kAR6PRvZ0pv7R=zhG0vCjxh4A@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Nhat Pham <nphamcs@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mfleming@cloudflare.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:25=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Thu, Sep 12, 2024 at 10:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > >
> > > I'm not, but Joshua from my team is working on it :)
> >
> > Great, thanks for letting me know!
>
> FWIW, I think the zswap_shrinker_count() path is fairly trivial to
> take care of :)  We only need the stats itself, and you don't even
> need any tree traversal tbh - technically it is most accurate to track
> zswap memory usage of the memcg itself - one atomic counter per
> zswap_lruvec_struct should suffice.

Do you mean per-lruvec or per-memcg?

>
> obj_cgroup_may_zswap() could be more troublesome - we need the entire
> subtree data to make the decision, at each level :) How about this:
>
> 1. Add a per-memcg counter to track zswap memory usage.
>
> 2. At obj_cgroup_may_zswap() time, the logic is unchanged - we
> traverse the tree from current memcg to root memcg, grabbing the
> memcg's counter and check for usage.
>
> 3. At obj_cgroup_charge_zswap() time, we have to perform another
> upward traversal again, to increment the counters. Would this be too
> expensive?
>
> We still need the whole obj_cgroup charging spiel, for memory usage
> purposes, but this should allow us to remove the MEMCG_ZSWAP_B.
> Similarly, another set of counters can be introduced to remove
> MEMCG_ZSWAPPED...
>
> Yosry, Joshua, how do you feel about this design? Step 3 is the part
> where I'm least certain about, but it's the only way I can think of
> that would avoid any flushing action. You have to pay the price of
> stat updates at *some* point :)

In (2) obj_cgroup_may_zswap, the upward flush should get cheaper
because we avoid the stats flush, we just read an atomic counter
instead.

In (3) obj_cgroup_charge_zswap(), we will do an upward traversal and
atomic update. In a lot of cases this can be cheaper than the flush we
avoid, but we'd need to measure it with different hierarchies to be
sure. Keep in mind that if we consume_obj_stock() is not successful
and we fallback to obj_cgroup_charge_pages(), and we already do an
upward traversal. So it may be just fine to do the upward traversal.

So I think the plan sounds good. We just need some perf testing to
make sure (3) does not introduce regressions.

