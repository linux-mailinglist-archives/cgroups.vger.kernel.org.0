Return-Path: <cgroups+bounces-5355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DF9B8304
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 20:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA5C1F229B8
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872DF1C9DFC;
	Thu, 31 Oct 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNvtUg4c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2C80BF8;
	Thu, 31 Oct 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401432; cv=none; b=LaOVD8+rzhImT8iKtFRa46OwlGQ2adJ6hGxIZJHf0oxUrj90NLrUgCNdDirRxAU8dyJXdrT3QCAyrYbSt7VCWw01le/BjdPzMpFmwUmaNJ015iu8sSjkhZFsfe6RoGBlToYnXNiV9+OVTHVMQG8cs8Nft2IokhKaCYtp/9RY7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401432; c=relaxed/simple;
	bh=uZESYCwSy02piR+29ifqwWC+ET5V5TOOXfN7NXL/460=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANyzSGnhcCdAAqFSoVhTK+C15EgHAqVlKeIp9T7h8Ija9Jck8YHRAbTKuzK5VCWr6lJfIKdS6fI77cDGnv3NkslKe4bpuLBy8Rfus4kjhn5cNWNNVfg+V3Z2zAOBzGZ8OPsNoRgegNhLqYsYZW8BkX/wqW+6JxXCQJs683Y6yj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNvtUg4c; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so1673957a12.2;
        Thu, 31 Oct 2024 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730401428; x=1731006228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZESYCwSy02piR+29ifqwWC+ET5V5TOOXfN7NXL/460=;
        b=RNvtUg4cXEsaH/wvEbZ/V9m472OJ/YniYkFDGCixHMXYOidIff1ZxrNYbytkCTn+H1
         vSs43DTIFmLBQw5Rev40DBldL+jNsZB4jsVQWgP+S5wBt8Gxre3tMVBg8SvIzu5CFGdG
         4fVs+4n53T0m+7Y/FSGGYT3d/vZNUyAn6h7LGkMohlH9r3qFKBj97xCj6hdIPzXGUuMi
         cMy1SGG8q1D9+DgNQQNXfQ7Gwvl3um1H7PwuJ/XG6MzIEFRCvjCqTc0aW9ebKvZbsqDp
         Srzya2d0WSIksMrIAPon1nCLfRdjElmLtTYYpnpLFJUHjfDLoij790q+2Ono4Wvmiocq
         AHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401428; x=1731006228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZESYCwSy02piR+29ifqwWC+ET5V5TOOXfN7NXL/460=;
        b=w8GN85WcjM/EU6Oi08pPWZ+9DP+c4Ui4CkL/q3x/HMs6Ezi2+mXQ4XNPXr8suXgq2w
         l91BPPw3xMjNWs/AtBEGkkNmE5QZ5D950EJriFVHXlvgG7hcGZpscLy+cDsWV/TpgOn+
         rYrWYL+xciy4xh+Ho8f9hnSPiUcr/QUdSZYFtpZkn2NdmpNm+v5x1wajfcNSyoKk/sme
         yH/JvGBhRjdQI4+BDf9pl+QndIyE2GQ49gkapGMzE72OufZ0auuck89hQvv6fBcvlsyO
         fzgJbQNCJr9Ruo2lrdKa0GzHYCPR6T65tvYXA17x4hLlUBmQWJ6i5kg/DaK3esFoTK6+
         nYjg==
X-Forwarded-Encrypted: i=1; AJvYcCV9fjfNCPzQ60v6Yg4LeOTKWmIRyjCGmjx8OwgD5SUPgGgl7gPYuoMBZaj5Ipan6PES6eUZmfpA@vger.kernel.org, AJvYcCVNu78HFgAMF4kg+mciBDO0pIgj7fcMBhpI2B2X7OEqre0hS7foBHt7Y4INXretbQT8sFYMVodAuIcsGEbP@vger.kernel.org, AJvYcCVYLe1ay78FQ0QyHl3IvQ9Qrsqm+JO2KuTbuEDv4OP1czduvP96+H1n4ekS9x6r282v4WJKT+8D2L8b@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1s7vcYBwLvXdeNMAMEQhoX+oRewOF6UM2VfA71wQywYkEwsv
	Z1BK+dSaJmiTPILdiZA/VjRuGndFem+0tTYSAHw1NCrv4q/wqTfqTJGQkWh0YHGn1ZV7Zo69deC
	Sa1O3Su5VjGenvoC7TUFoAKecYsw=
X-Google-Smtp-Source: AGHT+IFrpwGE0LJQq69tNQQsCndtpIAHUJ6FP3dpoTvWpaJX4mOBqsgxY7fkpk4UaRiczuaoWI/jB/OMed7/7+JLSic=
X-Received: by 2002:a05:6402:354f:b0:5c9:4a35:7a20 with SMTP id
 4fb4d7f45d1cf-5cea967920amr3734778a12.14.1730401428267; Thu, 31 Oct 2024
 12:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka> <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka> <20241030183044.GA706387@cmpxchg.org>
 <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com> <ZyM7_i1HFnFfUmIR@tiehlicka>
In-Reply-To: <ZyM7_i1HFnFfUmIR@tiehlicka>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Thu, 31 Oct 2024 15:03:34 -0400
Message-ID: <CAN+CAwMioguv6itTSYVUO9__kQVv6HZO2-i0NWt10-x7f6JVSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Thu, Oct 31, 2024 at 4:12=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> I would also add the following
>
> The global counter is added because vmstats is the preferred framework
> for cgroup stats. It makes stat items consistent between global and
> cgroup. It provides a per-node breakdown as well which is useful. It
> avoids proliferating cgroup-specific hooks in generic MM code.
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
> --
> Michal Hocko
> SUSE Labs

Thank you for your feedback and review. I think this makes sense,
I will add a new paragraph to the implementation details section!

Andrew -- I am sorry to ask again, but do you think you can replace
the 3rd section in the patch (3. Implementation Details) with the
following paragraphs? Thank you so much!

In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
regardless of whether memcg accounts hugetlb. mem_cgroup_commit_charge
which is called from alloc_hugetlb_folio will set memcg for the folio
only if the CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING cgroup mount option is
used, so lruvec_stat_mod_folio accounts per-memcg hugetlb counters
only if the feature is enabled. Regardless of whether memcg accounts
for hugetlb, the newly added global counter is updated and shown
in /proc/vmstat.

The global counter is added because vmstats is the preferred framework
for cgroup stats. It makes stat items consistent between global and
cgroups. It also provides a per-node breakdown, which is useful.
Because it does not use cgroup-specific hooks, we also keep generic
MM code separate from memcg code.

Thank you Johannes & Michal for your continued feedback and interest
in my work, and thank you Andrew for reviewing and allowing me to
fix the patch messages.

I hope you all have a great rest of your day!
Joshua

