Return-Path: <cgroups+bounces-4308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D374953AA2
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 21:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269C22879C7
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC876026;
	Thu, 15 Aug 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SopMylcT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC77BB15;
	Thu, 15 Aug 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749046; cv=none; b=EX1ogY3Xqy9nsolgH5dxrjbILUKNVX0G34ooYYSjue0mmVwCi2+lXlB8I6Dul7qwtZkQqOjlxKMQDtWB1XzCmsK7qpHpGbmyjXq49cldRUvT0+RdMQNudgT88rS/lLtqgLrdyC1Bw/WUgxZOEgUxo1B/2o7RNmWzy0EbNnE5O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749046; c=relaxed/simple;
	bh=KYbELk/F92PHFY22ler6peEP4IJNSzHROlwfBPKIP00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvmy8tl3K/P0UMPNhq+MpUY0Pjeq5E6YHVsDp9F5OLuyMlJcQMTBUgMjdaVGfFLvATJ4/JbYIGI23EsfoskjTFIqxJYoY/tq4yNHPaCxWtNhm6GQGqQBe43fZ6665WQS+qmhdBuo2egEPLTDjlgzOVIjJDgdSuZWfwCUyPi5PrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SopMylcT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a3574acafeso79610985a.1;
        Thu, 15 Aug 2024 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723749043; x=1724353843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYbELk/F92PHFY22ler6peEP4IJNSzHROlwfBPKIP00=;
        b=SopMylcTmvF2ekCxWK5zbptjkghSYDlF6/l7UDWDcot9UIi1KaNQdR7+PV5x8Eubtc
         GpP+t0Cb3T/yF8ENV5MfsLo90e6gP4KdlL7iDrxe8SGKGgMg+zZ0NdygGmO9fSVwzBa6
         QLykCF4Og6hZMsOGm1maI7WMeKZMKse2GAq4TlXwRvaFRwhR/6ZSmNpBUnO3acjZ2MDr
         IseP/abVMxzs3eoYk3cl3r72l00MCDJtBHwGZHn3ydDUHM90CWLZgu/Y+yLi02oWPn31
         NZLYxjHf/P+PuncHZIs8zF9qD/A/s9nLIwd7idsTZj3skaKeO2ajrR4N/Ut7vMn3eD1i
         WNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749043; x=1724353843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYbELk/F92PHFY22ler6peEP4IJNSzHROlwfBPKIP00=;
        b=UILI8pmuBbprBIrrZqFZfDO/LSkeoYOJk5F4O0F/RF+mco+r13xXY2r1tQJbTGisqq
         NEDXESDy3rPGLUws7CHMWIL4Ey5sCpDwPtLZ52IJmaSw0ZVph/LoQmoPzQ33JrYoh8Jo
         o78EGj4MCz1Be2AHetecHVntaALXp9ubjY0Rq1vwDBWgXNx0vFv1eXLdR2zePDm6JZfz
         a1cqn0OnKLW14/2eFuEDC0EXQdPfS0tmZNKH/IZt7pBaEhzvc9mv58CVpWg/zQNNVds4
         4PHD2uA19XxCjdlJ5sCv4YhcRQUpUKwQb4QncHDykyZOmWKDl9H4gKf/tWQzM3S73CgY
         rHxw==
X-Forwarded-Encrypted: i=1; AJvYcCXUE83jc2lBJ9p6vslHJhargZiapF6hiUa2kBNrHphCWR5Yv+aG+yxW1MaiBwWXa0ViYElK0swW/rn38plvqLd+0eP4NnoH8g==
X-Gm-Message-State: AOJu0YwM3knDuE+Vkffu7fSeG0HrmZFzFXz7dTUCsYUWqIeHiRd6Nurs
	VL9hr+8X9D9/IPFgMQiAQ+BLzHAt/eL6NoEgDlqhhAmh86PDro4bFxKcQiXkPqkndetRMWoyTX2
	RcuVaBcunOhvKr0TcprbGKYcVNj8=
X-Google-Smtp-Source: AGHT+IHR6k+0SJl+XjlCTGHstri4RK7G8QeyukUh+tTzLApuvYlVzTB91g01iHvyh3h4eOpe01ALllGEnxKPZ+vCbvc=
X-Received: by 2002:a05:6214:460d:b0:6b5:468e:d417 with SMTP id
 6a1803df08f44-6bf7cdc65bbmr5565096d6.23.1723749043111; Thu, 15 Aug 2024
 12:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAKEwX=Nbp40S2o_3gy9K84eWG4bnOxGm9AuAL4aEey22dpibLQ@mail.gmail.com> <5a671a9fca4534e499976bbc2b0a380ec496b4c4.camel@yhndnzj.com>
In-Reply-To: <5a671a9fca4534e499976bbc2b0a380ec496b4c4.camel@yhndnzj.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 15 Aug 2024 12:10:31 -0700
Message-ID: <CAKEwX=Ok3g0Cm7dDgGJPpMBGWukTHFy2389Yc5_2WqzNd4Nmag@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:39=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
>
>
> Hmm, I tried to, but the test_zswap_writeback_enabled and
> test_zswap_writeback_disabled tests in the current tree already
> fail for me... Should I still add new test cases under this
> circumstance?

Hmm interesting. We need to fix it - could you forward me the details
of the failure mode?

But yeah, for now let's skip the selftest. Could you send a fixlet or
a follow up patch to update the documentation :)

