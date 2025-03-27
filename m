Return-Path: <cgroups+bounces-7247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC8DA73E07
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 19:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E7B179BC2
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E688215F56;
	Thu, 27 Mar 2025 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ygaDaSyp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB5F4F1
	for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743100056; cv=none; b=qHYabnsSuQuUQIlx+wlzJDbJnZY8qja8uaIrmQd00/FeCoPli9Z4h48z094xqpXW5Vzwo5WLoFWBzdg/McuJ9NRK3CDFl8Ts5eiNUXgUvQ6d/zGG/KrpmIlzO31nySTMayUqtsBEscjg27KkK7RnT4SZl7EK8wX7XOTQxMiIPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743100056; c=relaxed/simple;
	bh=H4SQq9c3BG+BGZJq2PWQ9+OGqdEw1bMbKxYbAWHmA4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cyk8qxuGRmcxZgHrGHHf3m+9y0XoER9cMJVyg4ty+S4re4CWn7H9P/fBAkf5mwKevKg/AOiCQ2G2VgWd0DJ43joZ1/BIKpS4GqTgDG2vNrpyWR2LJbaX0QzfxJLZe50FmutPLNcwMbh9wRpKEpbnvMsaW05HadHNRpFRxR9qdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ygaDaSyp; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fed0620395so12911487b3.3
        for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743100053; x=1743704853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1T0t+yj48XDj+5N7Hw5aN1g6zWRep2KUB4u7M34BaQ=;
        b=ygaDaSyphWrgV9ZgaBaidTyOsALtv0f19PaseZzJpqNOhTNCae0WMunumzlZLFNN+4
         agvcaf4ECu7QYgIVcow3d4t3+mbe7KfdEG0cm64qJuXmHmxzbE0yM1uodNa26UEMukN6
         d57UPCcWAmUg8uO1wxpqOWP/XT3K9Bb4qj1OcGV7C4l/bSET9G6MX7nX9G8HFraubn4m
         g2TL9jCYWyh3IA+8TJcw3iIsdWvTIHtq/vAM8OsFU4LMCpqSPnUZpe7EC2pQpRV/MjZj
         ZGh08tdAR6OwSuQH3WU/N5UhRfb767liMWztu/cCX63rCoAxGS6NTxZ3WJ+tPTrSUhaT
         Fayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743100053; x=1743704853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1T0t+yj48XDj+5N7Hw5aN1g6zWRep2KUB4u7M34BaQ=;
        b=aAaqhZmuKtSufJJ9xH8/LaVFI6pJRqN/3rrg56HjKnC7p/wVzl7UyCJM3BNxb2nvbZ
         CohPd1JSJBr+Ho0rIqOxsG2dP+2Ml2ufFCs0eLkJzcgPliJXwJv5Z95hPGrilTsdKp42
         t7iFyiNHkQ2IdL/XJ+OkzbtDzFolJoZda2CY3TTVhdPpbs7drZ0CXe7PKZRZvOZLm8zA
         NUVA4CGSJJB9iJylJBp1tgsF+kFkX/MRXsS1yC2eZ274ova7G1BrzetXI+jMlBxu+0g5
         I0CIHWg7xnKQH6y56iCx7XhbJ4w9j+qnS1iLZNy30esnIoKR7iVY9QIghYY/Ugshr/ul
         ZMIg==
X-Forwarded-Encrypted: i=1; AJvYcCVnPoEUgrbHbHKBuhrnWj3PmG74+xwIujvEk+Sufb5k7Ji5LsiZ/qh5DE0LwemhquwLGHbinj7i@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE/ZcF7omyStp4XXcgudo5GF9mSdNGOG3Py33KsWlw5l3hwvv
	0ItAtYteSGbelIboHazEQYxF858ZVDYMxcEZBKr0tFwaQaM8LIXcNTXXIjTWf4pl5rcWcuz7O4v
	dYU6bOOSfX2hrDMKydgm/Jo0TTPruDJZBG6Du
X-Gm-Gg: ASbGncsB4ZY4yCO65Oww/B7ncHoSvenzOgFB7v4NOjZKWbuYrbubpUdFXOMnZMFZupv
	XHQZeqPArn+M2/at0N45C81MExLB6qytJEaiAOw3UcKeOuFradf6tTzZHcCmiA9MhDj0kxUxvel
	eNFttEFEfVtHnSd1+RS9wmSmaX2trdKx2ns0mBXWWKXpWGTn13HsDZD9CY
X-Google-Smtp-Source: AGHT+IF9r5WJAzdfDcQntbLZwhD5EGz+o+pnNk64HYaUbkhC9xRE3GDrX1KAucYtv+JfqlvbFLsjF4WRjfPT9DtRnoM=
X-Received: by 2002:a05:690c:6f92:b0:6f7:55a2:4cf5 with SMTP id
 00721157ae682-70224efddf4mr69462527b3.2.1743100053279; Thu, 27 Mar 2025
 11:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327012350.1135621-1-jthoughton@google.com> <20250327012350.1135621-6-jthoughton@google.com>
In-Reply-To: <20250327012350.1135621-6-jthoughton@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 27 Mar 2025 11:26:57 -0700
X-Gm-Features: AQ5f1Jqui55DD7gnN51tyeqg8zK6HJAcKnkL3KKDypvtSprHeM9DbaOlKdOqBZo
Message-ID: <CADrL8HXEb0r8sRie_q48ry8r30LpBZqAs4a1iN8N9BZ09FZzUw@mail.gmail.com>
Subject: Re: [PATCH 5/5] KVM: selftests: access_tracking_perf_test: Use MGLRU
 for access tracking
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yu Zhao <yuzhao@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 6:25=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/to=
ols/testing/selftests/kvm/access_tracking_perf_test.c
> index 0e594883ec13e..1c8e43e18e4c6 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -318,6 +415,15 @@ static void run_test(enum vm_guest_mode mode, void *=
arg)
>         pr_info("\n");
>         access_memory(vm, nr_vcpus, ACCESS_WRITE, "Populating memory");
>
> +       if (use_lru_gen) {
> +               struct memcg_stats stats;
> +
> +               /* Do an initial page table scan */

This comment is wrong, sorry. I'll just drop it.

I initially had a lru_gen_do_aging() here to verify that everything
was tracked in the lru_gen debugfs, but everything is already tracked
anyway. Doing an aging pass here means that the "control" write after
this is writing to idle memory, so it ceases to be a control.

> +               lru_gen_read_memcg_stats(&stats, TEST_MEMCG_NAME);
> +               TEST_ASSERT(lru_gen_sum_memcg_stats(&stats) >=3D total_pa=
ges,
> +                           "Not all pages accounted for. Was the memcg s=
et up correctly?");
> +       }
> +
>         /* As a control, read and write to the populated memory first. */
>         access_memory(vm, nr_vcpus, ACCESS_WRITE, "Writing to populated m=
emory");
>         access_memory(vm, nr_vcpus, ACCESS_READ, "Reading from populated =
memory");

