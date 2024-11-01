Return-Path: <cgroups+bounces-5384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5D9B9799
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A02837D4
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE84B1CDFBD;
	Fri,  1 Nov 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+KFgwT+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26611A0BE7;
	Fri,  1 Nov 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486031; cv=none; b=FlUIwquv0yqEZgZSSaQ6YG3JxMRVxD9cTaeX1NXWME2abtix8Czf+yjtNh8xqv5/jriLjEKyivF7/BHc1ChgHrQVe25++P93H3U7VMQEkMcdN0LX00w25qxuzEvJgSgrfRrX4Tl/CkHP2Y0V8Y9Uj9Tf/nBdrBL9NNkRDsVd2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486031; c=relaxed/simple;
	bh=tROKjePuUSAmKwGZuyxzGjNzAUwcXQRit98mObk0JPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxpFnQN+jHYl4Y/GUudaJzAbjACyXeSYiG3HjyQCPLzXc5poCY4Mvwnp/ptetYmiC6kxP/JWY6Pf8yqheOUtQWD9xZygtjOO1FTu8nnc8Ek34WpyfcxHyINqyJsYPpd2FXchec+Dj571x9tZK08FS/Prtj7O5QtkY3FHyvrPtuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+KFgwT+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so2660012a12.2;
        Fri, 01 Nov 2024 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730486028; x=1731090828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aKXYmYjBAuMzUUIrdg8wG61gEq+XCTqxoCb6g2OWXI=;
        b=L+KFgwT+BpL7LM4O7Bvw4c0Nuaxihtnf4PCxM2npR5IiK093rNZx4Qr5RJ36FivMZH
         uML4oPQ5SuNTpxDsEfET9BspC8iQmCs7wrGuVkqGRyTGGYSbxoA48sEohnmDW/KuZtIS
         7MmPF9p3zP8Mv36ogyTERzS8ZeUd3BhvQPCHn7XRvf/TGtv13RQXMBECVJd9qBFHCtwu
         Ng+fIatSFv0Fiq219koKvGescyrZPsKAH6M+E4cIxkbl6y7Qxsl7MkRi4u2rF+AtfstQ
         0km5ATid7V6timClR9tu8gsFShYFbtgXqKHBeNUyv4YPKd/g6sd4QgfS4GIr+r1d3CaW
         yI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486028; x=1731090828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aKXYmYjBAuMzUUIrdg8wG61gEq+XCTqxoCb6g2OWXI=;
        b=wGYVo+JSBQg2pZXQAR7wW0+fmnr7S/rsS++5LIb5MqMletQeVuKslw12yWBdCZ/mPP
         yI2zH7X7avMq/rl1xn3szUO6+Id6lrcT6Ud3Fh4g0ITEz7avhbZEi9XJYhQD//2Q4quN
         kNLGCN8/LgC639CONILgkR8ELeh7jJAKv/mxjXp/WLbfjBOmxV6Yliu/UACvollBhJTe
         lTSH/JFWbmwwUJnd4rqExGTKQnrbNfI7pzRFvmx51OzZezMHSqu0vKX1rw8Rz/iOKE0+
         fyk8C3yM/VV+EwVzv/78aJWIgPxLkr4DJbRKwVlVjAFXpfiD12DZ0CxacxJWcMP1QLT0
         qkfg==
X-Forwarded-Encrypted: i=1; AJvYcCUkuMPgomzkC6LnbECD2/my6RXZXCgQ2Fns98zQZTOVoO8Id82TBadqYaFKfdkE5hCg+kEzk2q5zW5LPFtx@vger.kernel.org, AJvYcCXQueZlfuOFnyUnq2ioJa5cdMFN7avqQlNSvs53edDjJBCfezrnCAV+lnAGCbqHkyDs5afgGOmKRbEZ@vger.kernel.org, AJvYcCXp49DO3+n5ZreCbdmM50aLghCK0ASY2XoxofbZX2wL2aEWGSPbkt2Dq+snK+PIhpm3E1d/4wV/@vger.kernel.org
X-Gm-Message-State: AOJu0YzaACX0ddcE4FfhLghujWYotKyN5BUYhggMmpT5BhQ90ZmBe8B5
	MPg4wr5ravv4pZbtNcG8bEX37A/SCJPnS6b/uiSOaMz/1+xR9Jt+exlnBQl8NA/XrKSx0FPoQdN
	A87TOcYnx3VoTSoPNombePMlRi0g=
X-Google-Smtp-Source: AGHT+IGir20gPToL50TgOpG3orUvf19xkLLVjvjLOCoU66Vkq4D32IzyCycWQAYpcoMknZ+dUtfXBJc4Jegp+l+59nA=
X-Received: by 2002:a05:6402:2808:b0:5cb:739d:5416 with SMTP id
 4fb4d7f45d1cf-5ceb936b3d3mr3274777a12.31.1730486027898; Fri, 01 Nov 2024
 11:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka> <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka> <20241030183044.GA706387@cmpxchg.org>
 <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
 <ZyM7_i1HFnFfUmIR@tiehlicka> <CAN+CAwMioguv6itTSYVUO9__kQVv6HZO2-i0NWt10-x7f6JVSQ@mail.gmail.com>
 <20241031183413.bb0bc34e8354cc14cdfc3c29@linux-foundation.org>
In-Reply-To: <20241031183413.bb0bc34e8354cc14cdfc3c29@linux-foundation.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Fri, 1 Nov 2024 14:33:36 -0400
Message-ID: <CAN+CAwORE8+P7Td9yebkb0TVT92SZv8oasrypewCspf5om1fYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net, 
	lnyng@meta.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:34=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 31 Oct 2024 15:03:34 -0400 Joshua Hahn <joshua.hahnjy@gmail.com> =
wrote:
>
> > Andrew -- I am sorry to ask again, but do you think you can replace
> > the 3rd section in the patch (3. Implementation Details) with the
> > following paragraphs?
>
> No problem.
> : 3.  Implementation Details:
> : In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
> : regardless of whether memcg accounts hugetlb.  mem_cgroup_commit_charge
> : which is called from alloc_hugetlb_folio will set memcg for the folio
> : only if the CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING cgroup mount option is
> : used, so lruvec_stat_mod_folio accounts per-memcg hugetlb counters only
> : if the feature is enabled.  Regardless of whether memcg accounts for
> : hugetlb, the newly added global counter is updated and shown in
> : /proc/vmstat.
> :
> : The global counter is added because vmstats is the preferred framework
> : for cgroup stats.  It makes stat items consistent between global and
> : cgroups.  It also provides a per-node breakdown, which is useful.
> : Because it does not use cgroup-specific hooks, we also keep generic MM
> : code separate from memcg code.
> :
> : With this said, there are 2 problems:
> : (a) They are still not reported in memory.stat, which means the
> :     disparity between the memcg reports are still there.
> : (b) We cannot reasonably expect users to enable the hugeTLB controller
> :     just for the sake of hugeTLB usage reporting, especially since
> :     they don't have any use for hugeTLB usage enforcing [2].
> :
> : [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.c=
om/
> : [2] Of course, we can't make a new patch for every feature that can be
> :     duplicated. However, since the existing solution of enabling the
> :     hugeTLB controller is an imperfect solution that still leaves a
> :     discrepancy between memory.stat and memory.curent, I think that it
> :     is reasonable to isolate the feature in this case.
>

Hello Andrew,

Thank you for your help as always. I apologize for not being clear in my
original request -- the "With this said, there are 2 problems:" paragraph i=
s
part of the 2nd section (2. We already have a hugeTLB controller...) So the
outline will be:

This patch introduces...

1. Why is this patch necessary?\n
Currently, memcg hugeTLB accounting...

Aside from the consistency between...

2. We already have a hugeTLB controller. Why not use that?\n
It is true that hugeTLB tracks...

With this said, there are 2 problems:\n
  (a) They are still not...
  (b) We cannot reasonably...

3. Implementation Details\n
In the alloc / free hugetlb functions, ...

The global counter is added because...

[1] https://lore.kernel.org/ ...
[2] Of course, we can't make a new patch...

Thank you for your patience. I promise that this is the last change
to the patch message, I apologize for the frequent requests for
modifications. I hope you have a great day!
Joshua

