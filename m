Return-Path: <cgroups+bounces-5318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC069B54AE
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 22:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592821C2272C
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 21:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347BF20401D;
	Tue, 29 Oct 2024 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEbZh5xe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74343207;
	Tue, 29 Oct 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235882; cv=none; b=auRUzze63mLlLur7j4cVlOsy6w8g+F9q4TLI/gUwj4QhPuUG7zKFhbE7SkKW25zTPo4T+QpIDwTm+FivbunfCywMlob7Q84vanaQn3ElYOYcN03liDcboksKA792ABtv9wnmnoDv4KXhCT1Jl7ZGV3VEeBJLqYWB/Nch1gP1MmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235882; c=relaxed/simple;
	bh=LFzZjhfZfngdF1t+EG9Hy271pddMX0WmfCPy6v/0RRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKANfJ4ug/eozr7B7s4CK4df3JNQDBYzxlfNb3aAbITaSSlC7VkM4vGYHsSrQC+wnhXURlF9RL3L35rN7gdEQcms7XPj04MapYJ4kaVmJs4dVxL39ieTdFUVQxD1vaQ/qrchmNMUKsbs/WaSAv6gWnin26yXuGlU+dbzQ076WOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEbZh5xe; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbce16d151so33738216d6.2;
        Tue, 29 Oct 2024 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730235879; x=1730840679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWF4JMlMslw/GFDtipOIiN9c4I6myuF71ODQ5wMy07o=;
        b=mEbZh5xePhJ3lbb6weA6PfUXSDX2GOdwEWsODdl1aMShRy58qWiGBXV9YlhHFjJrRa
         XEzsjoJqQu1zlhPiWPmkQF6BPJo4GlGsPKIyEpOUU780CGp6ZUMPuy0tXKvmkdPeDyJ/
         BLvbJKOeb65hRgVhrDHTbz4qriOW8NMXNxtKNhAo6JY5ER+TMmaTPcj55kMj/NCpA3Fk
         2eRo/SNZkQJSrBKt5jihZw4XjpdNPN4ZT8VhJaOwUEeSfaghRJpaoElypifDV9L3YqGC
         9m5frpcrohRdEz6VJziHAflEufUwnShsDUJeBl+/irm0jJg4O1fa1gk9xK5L5vy4YZSK
         2FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235879; x=1730840679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWF4JMlMslw/GFDtipOIiN9c4I6myuF71ODQ5wMy07o=;
        b=qjvbsphf+o8WXPFQYso1iifm4pCk1e3kCd5T8c3R+FFwDoZIoyqY1KeQYTs8bJy5Ii
         ArS9aFbYkm4aonPCKy6IWTzF9Mur4tJ7kD1RJtnZhm3gHWrSb9dPbmvH64LoSkRBAAaM
         //ViDDJwQNbQ9jwh3CayZ9bhhKfRevStC1T2OGot46dYJW9M4VXU7NAxaDQ0u2R0BeNz
         BJ8DIvKxmn2Jfm0c7EjbNQf/dgDgSl8IyjaGIRGffAUuaOuX0qqYvpPWIdbt1PJcyPDi
         s96wpUAUrq+5jLSCBOWzW7ZVdFvoildpV8/qKsxJev7PpYSaMy7J+lQh0VZmGnm8dO3T
         nvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+aqu//zHo02hQpY1W8rC0DSQZVuwRoPRLtJOkJYFnBUnXrFS8tKV1oG9nIg/CjWmkuhzr7ReVBd5Q@vger.kernel.org, AJvYcCVK9UGc28spfnTKW+py5jQeFzmOvULNjIjO6nupjyqwJPXKv95+LG/g/+8W70JUBVKJLZuT80/e@vger.kernel.org, AJvYcCWBr7LY4CtdK9EiMNDuni7/buyeYRwIotZsJxmyShcej7kJpjZoBB2YkWX9fsXQN/dGaXi3XEZ6fGJNQIpF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xkX3UtNOOSvQFOnGPFG7hWrc20ORH3tTd1prWjtQ+ndt2ZIe
	t0wxZJAcS+ufAy4v2TmsiRsOI2YU7cMKGoeyDOu4IzVIC+3xP1wlT4zUbu1w4//34sLmnVDNBvL
	kOPMqXe+Fy7tm35GbC9mzLbieFrY=
X-Google-Smtp-Source: AGHT+IGYEoKUfjapXifSa0HhvXycaqStroq848S5VfperkjE7/QZ6rz9oqVgiXSzkVHcWlH65oViCPKZR8cx3Soq7gk=
X-Received: by 2002:a05:6214:3d11:b0:6cb:f6de:3d11 with SMTP id
 6a1803df08f44-6d18584fcfbmr213619256d6.41.1730235878766; Tue, 29 Oct 2024
 14:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 29 Oct 2024 14:04:27 -0700
Message-ID: <CAKEwX=NO3CPSVtYRsYhxMawqV-6L1nr-6v+Wkc3cBGiCBajRaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:05=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> This patch introduces a new counter to memory.stat that tracks hugeTLB
> usage, only if hugeTLB accounting is done to memory.current. This
> feature is enabled the same way hugeTLB accounting is enabled, via
> the memory_hugetlb_accounting mount flag for cgroupsv2.
>
> 1. Why is this patch necessary?
> Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
> hugeTLB usage to memory.current. However, the metric is not reported in
> memory.stat. Given that users often interpret memory.stat as a breakdown
> of the value reported in memory.current, the disparity between the two
> reports can be confusing. This patch solves this problem by including
> the metric in memory.stat as well, but only if it is also reported in
> memory.current (it would also be confusing if the value was reported in
> memory.stat, but not in memory.current)
>
> Aside from the consistency between the two files, we also see benefits
> in observability. Userspace might be interested in the hugeTLB footprint
> of cgroups for many reasons. For instance, system admins might want to
> verify that hugeTLB usage is distributed as expected across tasks: i.e.
> memory-intensive tasks are using more hugeTLB pages than tasks that
> don't consume a lot of memory, or are seen to fault frequently. Note that
> this is separate from wanting to inspect the distribution for limiting
> purposes (in which case, hugeTLB controller makes more sense).
>
> 2. We already have a hugeTLB controller. Why not use that?
> It is true that hugeTLB tracks the exact value that we want. In fact, by
> enabling the hugeTLB controller, we get all of the observability
> benefits that I mentioned above, and users can check the total hugeTLB
> usage, verify if it is distributed as expected, etc.
>
> With this said, there are 2 problems:
> (a) They are still not reported in memory.stat, which means the
>     disparity between the memcg reports are still there.
> (b) We cannot reasonably expect users to enable the hugeTLB controller
>     just for the sake of hugeTLB usage reporting, especially since
>     they don't have any use for hugeTLB usage enforcing [2].
>
> [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com=
/
> [2] Of course, we can't make a new patch for every feature that can be
>     duplicated. However, since the existing solution of enabling the
>     hugeTLB controller is an imperfect solution that still leaves a
>     discrepancy between memory.stat and memory.curent, I think that it
>     is reasonable to isolate the feature in this case.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>

I'll take it ;)

> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

