Return-Path: <cgroups+bounces-5548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0E9C7FB9
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C22837DD
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 01:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C591CCEE9;
	Thu, 14 Nov 2024 01:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOL/h0CW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE711CBEBE;
	Thu, 14 Nov 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546518; cv=none; b=XzJMVdEgHjKKLugCJs2bqtV7Hh2a5jjoT2zB9k+FbLdGWql8pi9Hk7DTOcLXY7wBJPlFUd5wyQgsIo4T1H+q0qRBZTuES4KOrBvEuCW5XMMIBTmvOpzL5hSPLemGSv3nKLilHWeb0Z2hqevfOV5+mVNmSgOjXN029pbcxnRvdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546518; c=relaxed/simple;
	bh=R02m2/PelGWyh4Sv4uylgE9NNrM34+dXsHobBN6dLU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZJD/e2/o7TTiSgg+RkheSxmDPCEZ3FNgW3+xrZsRgN4QKgNTkPIIoD6slHkHnnHn2oTRqC4KxDlgLgBf9RQ99NUQ52fYigdnkC25apxVRMRlvdqhVkFB7A1ct4WbbINRuwDHSxHGwmqdtbAqTZoBgIfuW9EGQhcG2rY54zDJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOL/h0CW; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b35b1eb7e3so19804085a.1;
        Wed, 13 Nov 2024 17:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731546516; x=1732151316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R02m2/PelGWyh4Sv4uylgE9NNrM34+dXsHobBN6dLU0=;
        b=IOL/h0CWoILcGDjQ7NKxTX1tiGbn6pGhQ0nytQLJGHaaphjv18pvH0SBbODHAKtznX
         xbh5rhxqJzJAuTQrw1GDTz4/vl3Hib/SirRkTppRew83rtZnen1J0PNexiUY7N8GHqeV
         mRigM/oZfJPWWifeKNFDp7uxm2SMbSz4EjWERMdYbIlLC4TrZGW2bFedCXf43gjUhPbb
         dOBKuM8kR/NDHoKCgr0M+pt4San2gzhYRCszcX2tVgNaasoMHuPe2aVp61oxzaMpTI6X
         /82mSZMX+fJLBMnpM+6cO+qw+Xgm0OQKBsgu+s9ad4Nk21CLsfvTeI/UlNnTLZQmfRcX
         Isqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731546516; x=1732151316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R02m2/PelGWyh4Sv4uylgE9NNrM34+dXsHobBN6dLU0=;
        b=Mx1ZkBnhEdMKwMmclHQV/mqnsTq+rV+DRnkpU1lWPT2keowiaEe0+HLHCOcxIlVKuZ
         l2QNg411CyCXsh82ws4TgCO2bM+RpGSJlevAOoJKB9TY2kKqJxw/dFW7dS3SbHbsrgL6
         +ek+xhacij/yBIAvxDAFhZpxax3VUOktKV7j5pk4XIW66j59YULgQUG8H5MuMTQjb8mU
         tnDo39ssEUTGINgerf177D5i/Yit2jTqhTYBHqPlG428k4ZiS4qM/B1qqilUYVIx77jx
         3oQ7qBZffEtduOpLBzoXBVQfiudt4X7aVJx72bSS9QdJE1WOlDTfQV3jIilTPC6iWW8T
         JiJw==
X-Forwarded-Encrypted: i=1; AJvYcCUId88PE56pZtWa54IuhzTulhUegsuhRZ15+JyP6iR+SXxhPyw9t3IBVgwFxroGnEA1chyfSzx8YfcPV9qU@vger.kernel.org, AJvYcCULknBoqYRDhGK21RGBiPr/ptw3O1ZYxuSL8yAbU9Q595S91m6NeegFeEetV3X2tIOzZ/TQoTT5m1j0@vger.kernel.org, AJvYcCVvfM3t3OY2kTxWQy+M/o/1gsr3leOofrmgs1S0nEvCnQEFia1ObA/ziTBK7ysdMo6H8wSk3oDL@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjGlLoo2PGYUB4EGivlSfiYmwyfTWkMXaYIqkHQWzEWAiWh5C
	TE9JRo+ysKrpG+fXT11lDHfzc3o27OksDaoXKgRmqxkIrfB8lK2wpQk0HamFfagBhKSLi0nBav2
	v1HAMbHBCujjBoyI/59aEXFGN22I=
X-Google-Smtp-Source: AGHT+IEgPDHGyVD1YssYLJPhmEb1jN0TgpcCBY1/m117XlF1I5wtvBlc9bPf4LG2dSE/qJ16oCn/B+tUy5SyhYIG3UI=
X-Received: by 2002:a05:6214:5d03:b0:6d1:6fae:6451 with SMTP id
 6a1803df08f44-6d3e905d70fmr28857586d6.10.1731546516107; Wed, 13 Nov 2024
 17:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com>
 <72688d81-24db-70ba-e260-bd5c74066d27@google.com> <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com>
 <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com> <c41adcce-473d-c1a7-57a1-0c44ea572679@google.com>
In-Reply-To: <c41adcce-473d-c1a7-57a1-0c44ea572679@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 Nov 2024 17:08:25 -0800
Message-ID: <CAKEwX=NYPoEHKtXG_j_EL8XBkYJbYK_84XUi+JioGN5SnpLg0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
To: David Rientjes <rientjes@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	chris@chrisdown.name, tj@kernel.org, lizefan.x@bytedance.com, 
	mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:42=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Mon, 11 Nov 2024, David Rientjes wrote:
>
> >
> > If broken down into hugetlb_2048kB and hugetlb_1048576kB on x86, for
> > example, users could still do sum of memory.stat, no?>
> >
>
> Friendly ping on this, would there be any objections to splitting the
> memory.stat metrics out to be per hugepage size?

My 2c is that it's extra complexity + overhead (IIUC these stats are
hierarchical and hence would contribute to flushing overhead). So we
should justify them with some concrete use cases if we are to add
them.

From my end, I need hugetlb usage when I want to reason about memory
dynamics. This is because hugetlb is a bit special/weird - it cannot
be swapped out for e.g. So I have subtract hugetlb usage from overall
cgroup's memory usage before making any analysis that involves
swapping. For this use case, I just need to know how much memory is
consumed by hugetlb, regardless of the type (2M or 1G). I assume many
use cases are similar in that sense.

Do you or Google have a concrete use case in mind that requires
hugetlb categorization? :)

