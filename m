Return-Path: <cgroups+bounces-13002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD5D06948
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE43F3032725
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 23:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48612333451;
	Thu,  8 Jan 2026 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGDMX8+x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF533D4F0
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767916616; cv=none; b=EuDrQnc8gxyQSoiQs7foXD9fuog6/A21WGqGFAhIszNkYuDHe+plEg/bx8F4jx7SKuoW4ShQX8nfFusQQhtPrplg+c728MNfxaiFroCTmLF5vonkM/pTV1OhO497bgSNtVC6rRx2B37ZBGoaywR4HSeSLdcbvcGGc35ptS6Z8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767916616; c=relaxed/simple;
	bh=QdvBsXcTMSFYXeRyAgwj4tkZSNx8DHnpfF/P7K0Hz2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj7jG4uHhd9AgaO5UgYfSwS+Iy5p2xEhEUJtD929T+Algu2C5N7OYZQOBWYcy/ms7rdstqT5oahM1yzpHVd2CqNl/CJvceHCtNiegDJYKxhyKW1fuqWnUC69RSqzjws++i664YaNeX2ICD67sU3c3MKgd9wa1lid0hv3+1JbTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGDMX8+x; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-598f59996aaso4858627e87.1
        for <cgroups@vger.kernel.org>; Thu, 08 Jan 2026 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767916613; x=1768521413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oetB2ZjZly87qGWpok8TVoMCIey7xYuJUMfCqDD2fNY=;
        b=LGDMX8+xIX3pV7OAjRJMv4BzF11LC/sBef7CnnB2a4wpq3+say7/+LEHjwbRYUn6bB
         MUv1AXg/tF+BeR3/2LWQQeADWdcmUDeHCdbLp5JQOtr3A4U7oF2H/+VDcVFyAi3NmeJl
         AEbNoZTS6mDA3c8KjFTuccWOK45usU1IpXDYx7DB+PXxXyCk9bQ/sQGkt8Wmnb1SuDwP
         NDvdgFfxx1ZfulIGnOoI+FtaJLCGbeiTGWWO5DHe0cxol13NlcQ8eTBh8J82b9yonUu4
         nsa9VTQ4wjc8ccj+NqAMM11nhw5Klf+eZe9iqs2nxpal421jcwGss+Ev9VfKp3rDl6x0
         QMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767916613; x=1768521413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oetB2ZjZly87qGWpok8TVoMCIey7xYuJUMfCqDD2fNY=;
        b=OL3ij2tGOpLqnZACsZBa5RHuS3ib+7BnMDCrSs6jY52/XKI4n4C30ZeFvRiAYmoxkk
         8w61BzdhFsW4m/PybKxBGZ6+eJ3f3Vfd3aX4VW5KcV+mqr8f9Y3S/AiN5ittOCHqwKKQ
         BYprLWyWkBiwvC/8+QtmFrQZJzBHLdo2uQnbuz5y8qEVTe7T8uAYLjkR1mpJe8pF7JqP
         M2IoQyhGT0ZctuqSYwJU07pNeZxb5i0eobUcJakDu7JqrrvfrCsBAR6VLmLuy+bFleqU
         XBytGW8KEsMPwwIZoGWL4TUKCqWv+xhGoa3MzkqFyxP9KfgrRDojfjS7R+5Yiu4y4D0Y
         2ojg==
X-Forwarded-Encrypted: i=1; AJvYcCV/112bTCR0q+HYQT/75G3lYUW71yjBkzhLilSY4hY78+HlOy/aVcBsGgTPdsD45LsPWhU3DK8p@vger.kernel.org
X-Gm-Message-State: AOJu0YwmRbxpmSsCxcCXq452HFsf8pFTU2p4OgW9WO2siv+UiWWw3rpG
	mqiZBpYQUEanM9y7Gr8q8utWfSyKo7o616sZi7UKi1rrfYMKm4GfeKZZjDil+ZYv/hhqBwVJIQ9
	YDzzrzkZjJa+QuVk+pxGFvd2YkJzIAUA=
X-Gm-Gg: AY/fxX7n8GvZMo48hhUmlF91G0OXPK/dM0FkDiqSBUQQ49VW8OvV4aQkNAgyIduLmQ7
	1GcvUeSpx6zsZCVlbbbO0yUY+ze2b9M9UcBBjUFKrpoiOCNBCpwXl8AZGfNYmm4VAM5QbpsPMTf
	40OjJLQK4xG6mNDMUJ/ppUhvaMp7FmcNSHY/8AEdF+tmRKx+Z2mhs+AuVc/MK6zWUUVn/poywc+
	lDTZFRxKp9/b5WU2yDsifsi6Afr0NxKM/h5kgnddjw4JU6QtLKpNu+JvfkL9fajz+WkUA==
X-Google-Smtp-Source: AGHT+IFP6gxzx4CPGFwxToZxuM2DROL1oBRTahs81L4pZ76zZtEYBWrqyFW5M/PbRCzfXuiYZqxKnCkIdCKnpvz6V+A=
X-Received: by 2002:a05:6512:a88:b0:595:7854:af77 with SMTP id
 2adb3069b0e04-59b6f02b59amr2699853e87.22.1767916612487; Thu, 08 Jan 2026
 15:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108093741.212333-1-jianyuew@nvidia.com> <20260108111027.172f19a9a86667e8e0142042@linux-foundation.org>
 <7ia45x9bhg8c.fsf@castle.c.googlers.com>
In-Reply-To: <7ia45x9bhg8c.fsf@castle.c.googlers.com>
From: Jiany Wu <wujianyue000@gmail.com>
Date: Fri, 9 Jan 2026 07:56:40 +0800
X-Gm-Features: AZwV_QiaPNCRA8R_jWlbf3lk669pBieo3LIJ3Cr1QuxRdFzz5FJKFoyFeNJPA_M
Message-ID: <CAJxJ_jioPFeTL3og-5qO+Xu4UE7ohcGUSQuodNSfYuX32Xj=EQ@mail.gmail.com>
Subject: Re: [PATCH] mm: optimize stat output for 11% sys time reduce
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, jianyuew@nvidia.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just checked the BPF kfuncs patch, nice, speed so much, I think better
use bpf to read, instead of normal read.
The workload normally is read about every 2s, but there could be
several different services needing polling this.
Yes, previously the indent was hacked manually:)

On Fri, Jan 9, 2026 at 6:50=E2=80=AFAM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
>
> > On Thu,  8 Jan 2026 17:37:29 +0800 Jianyue Wu <wujianyue000@gmail.com> =
wrote:
> >
> >> From: Jianyue Wu <wujianyue000@gmail.com>
> >>
> >> Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
> >> printf parsing in memcg stats output.
> >>
> >> Key changes:
> >> - Add memcg_seq_put_name_val() for seq_file "name value\n" formatting
> >> - Add memcg_seq_buf_put_name_val() for seq_buf "name value\n" formatti=
ng
> >> - Update __memory_events_show(), swap_events_show(),
> >>   memory_stat_format(), memory_numa_stat_show(), and related helpers
> >>
> >> Performance:
> >> - 1M reads of memory.stat+memory.numa_stat
> >> - Before: real 0m9.663s, user 0m4.840s, sys 0m4.823s
> >> - After:  real 0m9.051s, user 0m4.775s, sys 0m4.275s (~11.4% sys drop)
> >>
> >> Tests:
> >> - Script:
> >>   for ((i=3D1; i<=3D1000000; i++)); do
> >>       : > /dev/null < /sys/fs/cgroup/memory.stat
> >>       : > /dev/null < /sys/fs/cgroup/memory.numa_stat
> >>   done
> >>
> >
> > I suspect there are workloads which read these files frequently.
> >
> > I'd be interested in learning "how frequently".  Perhaps
> > ascii-through-sysfs simply isn't an appropriate API for this data?
>
> We just got a bpf interface for this data merged, exactly to speed
> things up: commit 99430ab8b804 ("mm: introduce BPF kfuncs to access
> memcg statistics and events") in bpf-next.

