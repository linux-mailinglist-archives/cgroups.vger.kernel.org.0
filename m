Return-Path: <cgroups+bounces-8283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749CEABE9F4
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A95B1BA7F52
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 02:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2567E221D9C;
	Wed, 21 May 2025 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z81FHlM8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927BDDCD
	for <cgroups@vger.kernel.org>; Wed, 21 May 2025 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747794997; cv=none; b=pxp9oGbp/VMYMfkC03eaF1x77n8/hVKQrMfvJf8ruUA3tGgZC1RSK/uE8EH6vAus29dv8f7Cv37ERKofRIpnyzTHXPmf+YOJ7vq2g0Dxhj6ppSa9V2QePNKBOcikfjzCMw4zwB4NrHiDJlK+2HpCn88HUex+cqpsDnmtWyuzKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747794997; c=relaxed/simple;
	bh=3LlIVLVn2XJ3bMks/YIj5H5Gooj2k3xn5/ho7pAcaJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+mVF4f89EvfWRytMnL5jdEaQA9X6EKUhxHatoOD5DoaHmoxmTtKNLJOhn6a/pqwfal7bESGr5nSaFBBS6fu69RQL/IddZYZyFNqrAtNpX1mPeUROrfqoinsTXx2zclvOh1z9qgoGeyXpCekCivpZFiiabOM2SnXYX3AEPlBu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z81FHlM8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-551f0072119so3514865e87.0
        for <cgroups@vger.kernel.org>; Tue, 20 May 2025 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747794993; x=1748399793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM0G5JhOcdolicLe8qE3SREPLKhOhXvUArudMo2s51o=;
        b=Z81FHlM8AL7io41PK5/8o+Wpu+4y+GIEsKMMgfN362nu1It+WN2+J7y1LLw3Z8/7US
         aae/hrGrcYrAlw6uidhsqBtxoVrG9O/WnAfh1MGj/qb9CfEMsDkWFcVfYPsfX4ae8Uzi
         ntPqYWnWeBHnLNOV91NTDEuP7qiHDwFGow3b7maWB6+MdTEkZIu0A5jLq5CK1lv1p0aN
         cLsWno6R8VzmOIEQ71zV5dkZW6pNFABfOuh1NI21tcdB9SsUjvqZuzxpT+RXeYR4vTMK
         xajs+OMiQua98ddphvJ2kWBjqffuzzF9TCvJIYWL9RBzAAvT7d8htSRP6SMw56SCTL+W
         DuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747794993; x=1748399793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM0G5JhOcdolicLe8qE3SREPLKhOhXvUArudMo2s51o=;
        b=iXuKjgNIEUGRmKqWgSfFcKIsWFqRSDrVmy8ljr0PVrCEer9AhPouRccM7tKAHX5cO2
         x6cr7Px8FIXQpjvT/CwM0hNWDtZ/BRhmLFonijJaUlQ8C7EnM9NYgtaW1jItAkBhzYd/
         bKP+5tH2gLyh8vbmnKkTihWVPEoJEveYmEejRDvJZ2Yedv582qf0UBthmFSiiw4va94Z
         1fow6K8pQOtJHBR7WnHUroghSmsvW9zMFmP5Fc/P9amUkFPXOBsMAq0gjUBoA9vMGusX
         NL1rzLMoAgK7DfD/sE79kcY0IDKT4sNpue228jmOtZrrRKC56WWeK+oqW4/9ldPw+ykY
         KQgA==
X-Forwarded-Encrypted: i=1; AJvYcCXnmk61FDuBKK6guEyhjIjkVYlG3OLVLa9hn/gev4toG4IdUfHWfYIoDwIJBw+C+mFiCiUGjqMf@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUbSokhcAQ9jOISllm5gTeP65GlP3sZJzsR5xRierSCYSOa3k
	Dgw/f+bPBb3YGVkUVh5ynDPVO/g/cWxJ53PamcqFY90aMJDBUR7EzVLaPSCGY1kFVI+PSBDXuMs
	wva34L3qx3eApVMN4WzRMhMWaxvQ/Mu4FCFPq9u3hNyvrV3v/SxTxiFA=
X-Gm-Gg: ASbGncvJpDlCUI7EOeNhCrByaJT+BeIsrpdwZvQD/FCKO7w1XrtDxmBE/8cvnOwGen2
	qrbsDj1f+eqiARkeAmFqm2YvizkrDqvO/nZ05C4nKUfZAxjJ6UCjfdvjPUG+U5DQY0I1uHDweUB
	Hzjups0uYgF1gk3ek5l73LJRA9PsDrdSL+VBiZJO1oXYot+Fw=
X-Google-Smtp-Source: AGHT+IFMmXewRgXmjMlS3bxDt2y7GJT60G7EnBYDGZNqy8uaRaWPsxnVln1J9UYx1YxOtQE5xrFUWK1Pch5pIN1ljkA=
X-Received: by 2002:a05:6512:3995:b0:551:eb1b:f41d with SMTP id
 2adb3069b0e04-551eb1bf4c0mr4190306e87.27.1747794993380; Tue, 20 May 2025
 19:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com> <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
In-Reply-To: <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 21 May 2025 10:35:57 +0800
X-Gm-Features: AX0GCFtf0DIpERFZQTx7FOHjO5TPfEvgqV99Xyao4ksnN0_IE5VVyJ-ZpLeiARg
Message-ID: <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: Waiman Long <llong@redhat.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 9:35=E2=80=AFPM Waiman Long <llong@redhat.com> wrot=
e:
>
> On 5/19/25 11:15 PM, Zhongkun He wrote:
> > Setting the cpuset.mems in cgroup v2 can trigger memory
> > migrate in cpuset. This behavior is fine for newly created
> > cgroups but it can cause issues for the existing cgroups.
> > In our scenario, modifying the cpuset.mems setting during
> > peak times frequently leads to noticeable service latency
> > or stuttering.
> >
> > It is important to have a consistent set of behavior for
> > both cpus and memory. But it does cause issues at times,
> > so we would hope to have a flexible option.
> >
> > This idea is from the non-blocking limit setting option in
> > memory control.
> >
> > https://lore.kernel.org/all/20250506232833.3109790-1-shakeel.butt@linux=
.dev/
> >
> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > ---
> >   Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
> >   kernel/cgroup/cpuset.c                  | 11 +++++++++++
> >   2 files changed, 18 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 1a16ce68a4d7..d9e8e2a770af 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -2408,6 +2408,13 @@ Cpuset Interface Files
> >       a need to change "cpuset.mems" with active tasks, it shouldn't
> >       be done frequently.
> >
> > +     If cpuset.mems is opened with O_NONBLOCK then the migration is
> > +     bypassed. This is useful for admin processes that need to adjust
> > +     the cpuset.mems dynamically without blocking. However, there is
> > +     a risk that previously allocated pages are not within the new
> > +     cpuset.mems range, which may be altered by move_pages syscall or
> > +     numa_balance.
> > +
> >     cpuset.mems.effective
> >       A read-only multiple values file which exists on all
> >       cpuset-enabled cgroups.
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 24b70ea3e6ce..2a0867e0c6d2 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3208,7 +3208,18 @@ ssize_t cpuset_write_resmask(struct kernfs_open_=
file *of,
> >               retval =3D update_exclusive_cpumask(cs, trialcs, buf);
> >               break;
> >       case FILE_MEMLIST:
> > +             bool skip_migrate_once =3D false;
> > +
> > +             if ((of->file->f_flags & O_NONBLOCK) &&
> > +                     is_memory_migrate(cs) &&
> > +                     !cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 0))
> > +                     skip_migrate_once =3D true;
> > +
> >               retval =3D update_nodemask(cs, trialcs, buf);
> > +
> > +             /* Restore the migrate flag */
> > +             if (skip_migrate_once)
> > +                     cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 1);
> >               break;
> >       default:
> >               retval =3D -EINVAL;
>
> I would prefer to temporarily make is_memory_migrate() helper return
> false by also checking an internal variable, for example, instead of
> messing with the cpuset flags.
>

Sounds reasonable, thanks for the feedback. I'll give it a try later.

> Cheers,
> Longman
>

