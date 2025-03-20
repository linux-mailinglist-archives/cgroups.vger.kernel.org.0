Return-Path: <cgroups+bounces-7194-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF8A6A1A0
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 09:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9ED188B008
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5620121421F;
	Thu, 20 Mar 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpvpIiFn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8631519BE;
	Thu, 20 Mar 2025 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460204; cv=none; b=eVQJGqV4dyZNkIKGjjh7LBK/SOrCpYxyUEEavPdyW0WI4w/J6zXYWL6m15jIgT+fy5QMG0aF+alZ7CaStIfQYN42tGL0SVWTkl2exGA4la74/B3MP7MYkj7C9CfcsYy/XS4e6pAEmUdYHpT37xVlJb28xGFWmA+EHKwCMXffgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460204; c=relaxed/simple;
	bh=auCKqpQgTEZjYmDBzeXDZr3Bd1AyoaM2TLGs9oim0hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwb1hKE+ECrIHQeAOPBLk20B8zIagXYG19TtwxuKjV3SVcgXO0Dogv9+tVEYnseQAONbsWdfE2ixEIW96BDyYDoF24/rVU0jViDsBy4IXuADFycqC+/QA9fxNMMiMPdlvojz+8ffxxsxX1Ih3RmsEl3v28+Xw/a1eYNlufNC9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpvpIiFn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso653234a91.3;
        Thu, 20 Mar 2025 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742460202; x=1743065002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RGOMxcHFVZ0m1mCzI9ZhAVlgLqcK8VzJh6hs5TAEKyQ=;
        b=QpvpIiFnTb3IQBc/Rzga7oP7DEh0sn3kYLtxVL2hPq6AOWpnEEEMxBVPbBRo02PqiY
         p9IMgWGe8TeGcmSkkfwy7UrpTq9tNoT8lhSqiLbgCTaWwJKO/quCPjfLOo4PQijWUc1p
         ZVw7VbtRjG4Mg7jA4mHVC/Fj+TbbP1zQ+IjD16F6OOqGxxJnhldfzZ7SOkfe31YvZWzP
         Udx7hxyUkHSabhxVE9FKNBMQe5xXMwpbmRBSA+UkXYgdWFOUDir0I/DZnJzFFHD8UOjw
         rbqOWHMyUFrS2YolNjn5lbOQlxnx8NFtIncWeNumg0E2NmW0Ji4Ua/ej3tNC/lEFTkw3
         QUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460202; x=1743065002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGOMxcHFVZ0m1mCzI9ZhAVlgLqcK8VzJh6hs5TAEKyQ=;
        b=j/pgXZbVh0ZpTsNLmK8AR4AUOHvGIlj2kkXuCKo0Xy+KABITwHEfe0bdeW9gljiD1t
         SWDV7S9EjX8OHJvooH/jeqq48xPEp4FNheOeQVvSyCFfOjqI636w5QNlfSUijgbyMOJk
         ufsaKuEjlKMTld0LlkARjm6U3N5Kf+pXfiJVsVIjDx0b9E2deUfrjU308++lbZBzo0UT
         pB1T/dRyR6Sn8ii+sW1FhkZiqVpMlKTLsfRfKdH/5cD2RZDResWg2jcm7xVgZakWyJbQ
         MwCzaUR9KB30Pd/IROhQaHeMJ736nVIOENWm/ofeX1DTx0r0gYN4E8XM/U1c+Qc+OzIB
         Z9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUD+UYhxc9UqG09MRQeQZmwy7Rqa+Qskv4b4z3LKzueqLsFWghtvk0HSi1PtHJvKMfXx80sd651BNApb/zb@vger.kernel.org, AJvYcCUfYnNTRTrsApjp7OPVF8pXsT8Q5eiTjKhLkwM/YQEvYnW91jiSGZEJBnp7sB3/WMGPhr2YCYYH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5xSKYM0Iko48moiALwM3UAANk19WfIQcblx5lgAccYe0QAYhB
	niw3aCgdNNfNjpYm1ZoT3EWRaPZFP/3mTD+UEexR+G08JnepvxjyGLWQaMQws9/CRW9DKsogM7I
	ztAZKo/T8z2gGDuCIj2stey4/tkr9cGHB2cs=
X-Gm-Gg: ASbGncu1DXimP/pS5747G4JBr7vkZ5ZrLPcsg1NuEudExqojpDvx16ug9P76FYa2AFe
	Av/AR4y4tz6+8KxALrylwIB3HTUr1KrXVVZ0d+/Fdo35ys6vKdmRo8iXgNqNaFE7GtSys9HdQa1
	GJyDwXviHPtOeh5wlthWeeyOdR7Q==
X-Google-Smtp-Source: AGHT+IEp2PMi9orU8cRBnyIS1/V13B3RTRbIyDXX3S5REe0hQwbDtQFE/YPAsGXwKKq6TxlnHrx9eR9ZKtnG837JNE8=
X-Received: by 2002:a17:90b:4a82:b0:301:1d9f:4ba2 with SMTP id
 98e67ed59e1d1-301be201e7emr7442082a91.28.1742460201953; Thu, 20 Mar 2025
 01:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com> <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com>
In-Reply-To: <7ia4tt7ovekj.fsf@castle.c.googlers.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 20 Mar 2025 16:43:09 +0800
X-Gm-Features: AQ5f1JoO66jRwNs-W1b_FzIjxiMjARlC3RUOD-o5yAETPWyRbolxMcMwFWY_nVI
Message-ID: <CAJqJ8ijPFpFf8EWqBjbQtjr67LXRodx2F+_0tU85zp4wDdgmpQ@mail.gmail.com>
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account on dfl
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Jingxiang Zeng <linuszeng@tencent.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	muchun.song@linux.dev, kasong@tencent.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 06:32, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Shakeel Butt <shakeel.butt@linux.dev> writes:
>
> > On Wed, Mar 19, 2025 at 02:41:45PM +0800, Jingxiang Zeng wrote:
> >> From: Zeng Jingxiang <linuszeng@tencent.com>
> >>
> >> Added cgroup.memsw_account_on_dfl startup parameter, which
> >> is off by default. When enabled in cgroupv2 mode, the memory
> >> accounting mode of swap will be reverted to cgroupv1 mode.
> >>
> >> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> >> ---
> >>  include/linux/memcontrol.h |  4 +++-
> >>  mm/memcontrol.c            | 11 +++++++++++
> >>  2 files changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> >> index dcb087ee6e8d..96f2fad1c351 100644
> >> --- a/include/linux/memcontrol.h
> >> +++ b/include/linux/memcontrol.h
> >> @@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
> >>
> >>  #ifdef CONFIG_MEMCG
> >>
> >> +DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> >>  /* Whether enable memory+swap account in cgroupv2 */
> >>  static inline bool do_memsw_account_on_dfl(void)
> >>  {
> >> -    return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
> >> +    return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
> >> +                            || static_branch_unlikely(&memsw_account_on_dfl);
> >
> > Why || in above condition? Shouldn't it be && ?
> >
> >>  }
> >>
> >>  #define MEM_CGROUP_ID_SHIFT 16
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 768d6b15dbfa..c1171fb2bfd6 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
> >>  subsys_initcall(mem_cgroup_swap_init);
> >>
> >>  #endif /* CONFIG_SWAP */
> >> +
> >> +DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> >> +static int __init memsw_account_on_dfl_setup(char *s)
> >> +{
> >> +    if (!strcmp(s, "1"))
> >> +            static_branch_enable(&memsw_account_on_dfl);
> >> +    else if (!strcmp(s, "0"))
> >> +            static_branch_disable(&memsw_account_on_dfl);
> >> +    return 1;
> >> +}
> >> +__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);
> >
> > Please keep the above in memcontrol-v1.c
>
> Hm, I'm not sure about this. This feature might be actually useful with
> cgroup v2, as some companies are dependent on the old cgroup v1
> semantics here but otherwise would prefer to move to v2.
> In other words, I see it as a cgroup v2 feature, not as a cgroup v1.
> So there is no reason to move it into the cgroup v1 code.

Yes, this is mainly intended for use with v2.
>
> I think it deserves a separate config option (if we're really concerned
> about the memory overhead in struct mem_cgroup) or IMO better a
> boot/mount time option.
>
> Thanks!
>

