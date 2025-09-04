Return-Path: <cgroups+bounces-9691-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661AFB42FBD
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 04:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DBA56755B
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 02:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CB1F131A;
	Thu,  4 Sep 2025 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpWelHUx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FE1F0E26
	for <cgroups@vger.kernel.org>; Thu,  4 Sep 2025 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952749; cv=none; b=kZT0elqRZreiQ1w0NeY2YIjWuIp7mLmZsg4gv9HQRv/6fUie5ADjxDX9/hgdgI6/zC9FUltqmu4apLQM00HaSFpGxW8WXGCTEIGg6psPIs03eGVx0UrbLmeo1HlxVv9oyr6p9hvKxwt6gxu4Nb6EO7tJ6APgIIfkUNvHZEBcvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952749; c=relaxed/simple;
	bh=5z4OrOFPS4XvH0NP/EnUCmmw7Fx9k8M6erkBwOpY+u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNy6pibWbeJA0ND5erMyeMTTzv5m+EV6hVZzRjUi9Wi1/nwSWirkFH3Y132uxwnB6Ar4rEMFaaADUvu0N1SdN3rI8xyTeSV4dB3qyjfZElXZxmC44VIVCH7FucaXmW0RsxnwkahBqu8emwl8p+EMvYF9EoBCrBQ+80+5MbgCduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpWelHUx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0449b1b56eso80937766b.1
        for <cgroups@vger.kernel.org>; Wed, 03 Sep 2025 19:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952746; x=1757557546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z4OrOFPS4XvH0NP/EnUCmmw7Fx9k8M6erkBwOpY+u4=;
        b=NpWelHUx0WoMR6GpKZilksPh2FgCCzqnN8RujUsaOUk8zzezcZTI9IQe/uwSoCo3zW
         1xUO+SmJ3OhhNFdnGXbLsZ+exW7LhHcw+QijEjdTYj/qRJsaczvfhoPkDlJICloK0OuN
         Uev+2HEKGVOfLz8pyuGfzLYVVD/ixtGyIDu1WjGr5JW5Yg+Nn3jSTSPFdhOHcsGwlR6P
         wmei/mLqKdEhkiLOSC7xxqK6QHs9L/aHvKAO3tt0jnJFsYuYifXWrwUYfvTOVfY4d2SG
         w3tI53ifTPN7A9q0XLwtIcK4ih79zHwAPspa2rW7M6KMwuDzGgzZmnNhAx+I+5D7M4Jd
         NbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952746; x=1757557546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z4OrOFPS4XvH0NP/EnUCmmw7Fx9k8M6erkBwOpY+u4=;
        b=G3DgiHsq8PT/usA35/V69TZkU1TZ5O9OxJenAnDFLRie+mvQp4VAjnaT4yzD5UvTfT
         UWe6YN6lmOJMVJ/RY5rjIWWbxczWU9ht/WgBqPMTnb4dEFDvkxTjtFHJeuRzhFhj5XE+
         r/M9ZvqdrSbnENXCHLHAED6jI5x2tbgB2yL4BP1zJymmZYwEyrA3PBWl+j0LcaxcrWex
         FuefHoDTze54JfZJlvKwXLFR4/KJerfwV3TTOTJ/SF4IDwTdLBUVshBp57+cXOIg9QiT
         4FDUtNYtPI5vWElC/FA2248AeXbLskYA3QYX0foyhELB0kjbiaGBfNzFqzOkgnE111IC
         nPBA==
X-Forwarded-Encrypted: i=1; AJvYcCXokC/vZUklJ9LOppw86eIG8prqcJvaD95yd4FPmlSxhEA7UtgyREegrrXdoEqcALd4hqmdaG/5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/qpEl+NlA5dytjQBttoB65swnE+83KFNrzFL7ELBcdtijKSa
	2h2NyLNnaXufjEfsvYCSYQ9BB6IXL0T5/ha0T3MCCoGdUzk20u2RUNeK5wy8IvtLf7jVmLXNduP
	DwHj8u1B44yMIsp9JVvP3C1eS9R+GmMc=
X-Gm-Gg: ASbGncv0BilaixzuGVqJTJmDPsgApzU7brErBE6ZosS6D+UaeuVCtcubTSWpydaiB/O
	svRdvAS26ZEsA9Cex7nkqiU86S3hkxg0TRLyXA044lWYh6wubgJeIvq4PbC8pxi7087XA9QxJyv
	hpIlXUt+pBRziRgNs62771tHCisgmSUGQuABXGsvYGDnWlQXAAc++se8381IE4X8oINnJ1W+HJK
	Lr7IAXZamqu+aEp
X-Google-Smtp-Source: AGHT+IFx/wB9FI1f3hFOOW57VGYOPL/Ls9PSyOMGNhTPLoupuVBZJC6+YLHC+db4jbrQbCWw8xGbfXuY8N9qEY2kC5Y=
X-Received: by 2002:a17:906:c10e:b0:b04:2b28:223d with SMTP id
 a640c23a62f3a-b042b283383mr1401131466b.20.1756952746428; Wed, 03 Sep 2025
 19:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902041024.2040450-1-airlied@gmail.com> <20250902041024.2040450-12-airlied@gmail.com>
 <4e462912-64de-461c-8c4b-204e6f58dde8@amd.com>
In-Reply-To: <4e462912-64de-461c-8c4b-204e6f58dde8@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 4 Sep 2025 12:25:35 +1000
X-Gm-Features: Ac12FXzIOcCeJd-fn4RCBlScfspfWtoHuRwY0FIRBUcuRJSbmxFdrkK2CB8rqLU
Message-ID: <CAPM=9txiApDK8riR3TH3gM2V0pVwGBD5WobbXv2_bfoH+wsgSw@mail.gmail.com>
Subject: Re: [PATCH 11/15] ttm/pool: enable memcg tracking and shrinker. (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Sept 2025 at 00:23, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 02.09.25 06:06, Dave Airlie wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This enables all the backend code to use the list lru in memcg mode,
> > and set the shrinker to be memcg aware.
> >
> > It adds the loop case for when pooled pages end up being reparented
> > to a higher memcg group, that newer memcg can search for them there
> > and take them back.
>
> I can only repeat that as far as I can see that makes no sense at all.
>
> This just enables stealing pages from the page pool per cgroup and won't =
give them back if another cgroup runs into a low memery situation.
>
> Maybe Thomas and the XE guys have an use case for that, but as far as I c=
an see that behavior is not something we would ever want.

This is what I'd want for a desktop use case at least, if we have a
top level cgroup then logged in user cgroups, each user will own their
own uncached pages pool and not cause side effects to other users. If
they finish running their pool will get give to the parent.

Any new pool will get pages from the parent, and manage them itself.

This is also what cgroup developers have said makes the most sense for
containerisation here, one cgroup allocator should not be able to
cause shrink work for another cgroup unnecessarily.

Dave.

