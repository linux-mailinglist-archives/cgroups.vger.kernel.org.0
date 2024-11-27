Return-Path: <cgroups+bounces-5701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF959DAE53
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 21:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C241165DEB
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF6620127F;
	Wed, 27 Nov 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2YGRm9g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3314A604
	for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738222; cv=none; b=dzi0oNHc60eBx8XajdlrRkm9msc6IViI6ouA60q+yacZH51fD+CBUddNOkzuOYuMJx3tLwqp21BHRX2mwxOlorMUZvv840IoMLqTMjo4EEI9b2ym61O3FOQcIWcG/pN4SwpICWnG0kmunLfPg8y5Hc3omr3Kp0muzylKfxClJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738222; c=relaxed/simple;
	bh=hUBcNXvuvLbYXhYdraBI3VWzdlKOrSFOIJZwTLRZEZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd1d4qlxb600IFANnSviNfX9o+WJWjKHXpxYJQN13qm7yMejICM9db2n8zJHnHsYp5PcNV2TbRakyE8WISLV0Nk7YWyHXh4NrE/kQNs1S5VJN3KLksm5Tu1IQrInkfFYEHMdHre7ThK4bVUTkWa4vQm0gk8JoiyqVi8qv2vkaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2YGRm9g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so4335e9.1
        for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732738219; x=1733343019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUBcNXvuvLbYXhYdraBI3VWzdlKOrSFOIJZwTLRZEZw=;
        b=l2YGRm9gPz0ZsEhi8TnCA9kznf2WGM+FRitcXjQA40wZNRpg1+GHIc7J+bJq0UmgW+
         +997SmxG7Ei1vpqfjjvPPN4bDgi/ARVac/AeyZmG9Y+jTv8Na+EcXUMK53rjXqJVIDuz
         /81AHUDLGMxxftFghEmcELMiyM/XkJDuRVV4/Qrb3wlR7mYqOeLAA98y3BfkHO5dT7TG
         ufPRfEi/V+NX/GAxTnNOW2XFSSqpDlqVgLZqSepsz1jPqD6CLr3LDwGNIwlhwrl+tMiR
         qTQI/ffoUpOKYI1Yl3RJYcJj2lHBibtQ8hgaIMEVkJxGrpbgTZdQ+aIkWkgaB4hLPcmS
         F+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732738219; x=1733343019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUBcNXvuvLbYXhYdraBI3VWzdlKOrSFOIJZwTLRZEZw=;
        b=utlIZhXD/wwmtJ0AoehCgRKSWGOYQyWStB5PH7oebn6Gp4xki4beqyFrI1lrq1k8Ky
         E/bwERZ+d9UNVmfv7hVEoRYVNifb2sEFK5wus0amydHJP34pLa4KUnJ9UIHwljjiZ41Z
         1wckJ7wg2EZuxlDW0xdf7WPD+FpV0vL5xGcEpHwitkRd3iW8sJoJidor4BtuRQ/by9P0
         /4EWL30HaPJpwW+6+5XX835y7cFN8JIcliXbSshtbHQP9af5eCbBV9ugW8JwcWyMMZv6
         XFakS9xtSsyRZs1GzIyLqb+rK5RZ/NwvShdhi4qwlZYVJ/ZWpaDyoeoDyz93MyggyG3e
         imag==
X-Forwarded-Encrypted: i=1; AJvYcCWu+cpQryaN7hTzZw9oX89HEq+eQr61LUQ4SjIK/Eo/JQyNwQ1TRMi/oGPPzQXSIyp6PPZ1viN+@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAvYgdXRwuQ1Mkgeu8nKg1KcXqWt63bIwyQDx6THx0eBk+UKR
	i54jIvgFuzPSaNePxfBrGV5lQBX4HC1WEyqGaqgYGHogZUgPDcF8mXtxpzF43XfVDSFZEKFvlOC
	skOZhboOQKp0I1qBVASbR0680r7nV+iSw+YK0
X-Gm-Gg: ASbGncuv2D3tfmIobbZH9WykcdNXUjqfjHzhO4dhBIbtohH8uzvmBmC34Zu7zCku5hw
	DN1R6AVsMIIqMaZ6cmz2vJZ7ocZjrNlz+JYf+m1ibR6/SWDvBT3rW40NP9bg=
X-Google-Smtp-Source: AGHT+IG+kehlB4s0M5dWyJKGLHeYyY36EY44ty+lp0Mvoe5e9HkKe9gEegCulaT0+L4A1Oxd2n33hHXL6WkpLXJ43p4=
X-Received: by 2002:a05:600c:3b28:b0:42b:8ff7:bee2 with SMTP id
 5b1f17b1804b1-434b066ec64mr85985e9.5.1732738218634; Wed, 27 Nov 2024 12:10:18
 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125171617.113892-1-shakeel.butt@linux.dev> <Z0Yhivws5XSeme68@google.com>
In-Reply-To: <Z0Yhivws5XSeme68@google.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Wed, 27 Nov 2024 12:09:42 -0800
Message-ID: <CAJHvVcg_mHiGvMpaM5XX8F7cvsxxGc9oOdCsy4zjMJAd9kX8-A@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mmap_lock: optimize mmap_lock tracepoints
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No objections. :)

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>


On Tue, Nov 26, 2024 at 11:29=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Mon, Nov 25, 2024 at 09:16:17AM -0800, Shakeel Butt wrote:
> > We are starting to deploy mmap_lock tracepoint monitoring across our
> > fleet and the early results showed that these tracepoints are consuming
> > significant amount of CPUs in kernfs_path_from_node when enabled.
> >
> > It seems like the kernel is trying to resolve the cgroup path in the
> > fast path of the locking code path when the tracepoints are enabled. In
> > addition for some application their metrics are regressing when
> > monitoring is enabled.
> >
> > The cgroup path resolution can be slow and should not be done in the
> > fast path. Most userspace tools, like bpftrace, provides functionality
> > to get the cgroup path from cgroup id, so let's just trace the cgroup
> > id and the users can use better tools to get the path in the slow path.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Thanks!

