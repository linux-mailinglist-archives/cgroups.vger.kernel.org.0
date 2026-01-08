Return-Path: <cgroups+bounces-12981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FED02F96
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 14:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 461153075638
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30E484A01;
	Thu,  8 Jan 2026 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4276iPd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ1hpCOg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D64849E2
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873788; cv=none; b=Bz/1RAXyKrq0geSBfo5pZDuoJjS3OeIZGr51g7vnH2xtyJTuNjZMS+sZ2GjZYEXqmu/1lOXVEmgjF5UJC3hj6OXLFsRRNvIPQeneErba2VSQSG4RyopBOXaD0VvwBk+STqLP8H5dlwZDMLakGdOEXTFgvqyeKTF/w+HiD88ywaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873788; c=relaxed/simple;
	bh=Ft6IaxtNn+XM9JZ59qCi3oMXTOLMLxu8V4O99hCUreU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/Be8xImBjozNSEwvhkdbjH5+Lns/3NNrY2QUrhr0uhBjjeA98Y69a9QFHM0jYMwF3xp5+7LcDnagj9YJ/2nUX2oEjEpTYBXyuSB6sxS9iFcj4pURH+7yNZ1z5mp3NL/PBpqMY/me6UqtVl+GLNqAsXJfvvSTqM0gfWs4yO9+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4276iPd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQ1hpCOg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767873783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWiqnQM4u7bBU0NjlMhI++W2c7bl/GxvK/WxiHwrBV8=;
	b=a4276iPdY8Ge6Uh63vtIyY7aNfk60yaJWeE1VTsJsvzZLyB+A6E72NmSPVzYID5Ve/Zcqd
	bnyIVgttTgOW5z4bHW8zuFX56jAcAA7ZDGj1J/5RX+KEcj4kB4jUIO9mjRo9L2iFU1xJZO
	re69S1+iXZCYzeuVXwg35fhnsnVJORw=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-xuvFd_jaPoeBdcmLIpfBOQ-1; Thu, 08 Jan 2026 07:03:02 -0500
X-MC-Unique: xuvFd_jaPoeBdcmLIpfBOQ-1
X-Mimecast-MFC-AGG-ID: xuvFd_jaPoeBdcmLIpfBOQ_1767873781
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ae51ce0642so2270493eec.0
        for <cgroups@vger.kernel.org>; Thu, 08 Jan 2026 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767873781; x=1768478581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWiqnQM4u7bBU0NjlMhI++W2c7bl/GxvK/WxiHwrBV8=;
        b=gQ1hpCOg1m4Bv3IevZSbSmInzyiebtTWzYjt+5mfpYFOqgfp1+Eoafkn46Iofknvu7
         46TAMor8Kso5fxAsbzs4tK7eKunH34x/Ava3BxtF/a8DXQuHXamwlWtpPHU23Km10TEO
         0K4IMR7sCd2lSr8z55niu3B0/HzASsQHigJRP0ZVVjw5lyUw/tIYnLyNBv+bAB2Ox11e
         AdmyXzuITHcvDX68aq/lkF9ivuXEk8/WsA2bzWCYYjaC8hjZIquGzyNwW8+WI4I4k476
         Gkj80rN2dgm6vWG0JOfq/9uGGZPUr5dz8hnGpQjhFOY4bUWSXH7u69wDF7UhwX3eH2Si
         Roxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767873781; x=1768478581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWiqnQM4u7bBU0NjlMhI++W2c7bl/GxvK/WxiHwrBV8=;
        b=V2GJDSPTZuWStNmPTv0w9ZJmAJmKCAErlx8cXogXHujzlzRo7e/s1Udn/r1mBZHlp8
         Irm0h9SyScRUp7P9QAz4L/yV4P1MhYh68j/q/tlEGy7JU2/5taget5sLI7H6zN2ZkIVp
         sd/MPJRLZjD2gdMD+WSf/jHZLtnX8wbe80xwJzAt24ikyMiQp2gp2cW54ZawUi5a6guk
         i0JlIMgnBLYh1jYoGhDZ4ZWtzoW+sULDCEXDwWtAbTktvVOsA8X6x7tjVV873CSxLs6B
         kXgZMHSxQh3+ymB4OFC58b/F8o1xZzyMFt4EMI4m/NP6aCTTtN70ifq4ev9NpT8id7pP
         YS6g==
X-Forwarded-Encrypted: i=1; AJvYcCWcUKZo5ZsQTtlKk0kRF32NWYtvhlOksYYiufNuENdFQU4FrsoG5Yx/1/1flJYFVaVvSJv9Z0ZC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyhh5l717A43T8w/a1Bzwld0zb2dedtf/QqzjnrcAHdK9nIg9y
	CfGOXtRAkqaJBM3mFAS3t783VE06MXjA9VXKVU5Ei/k/0t0i594BPjFwd8YHU5GmTnaiJE5+yss
	86l5rOgCzAjM00ijHXgYqUJjudi7pRmbb5Vo1Nyx7NmkJKtP9ONGKoELbccpDppznOKLSBtYKi1
	YgVQ+kBwX5nvENBfQPq2OX4bKe4JY95S8gYw==
X-Gm-Gg: AY/fxX7R/aCH2ig7IueeHOlGTKoqtfptXfe9m5yXjJ6JqRL0Hr1QHv29+BnFPuJRlTm
	dScEZWW0i/geQ7fAivwVdgOO8HLD0q3OiNZHwTq5UgO6bMnQjRMLs/DbtgEu+dr/76ZtNLZb8Bl
	7KSsj6iYf3tm6fNB6Mp1JlYWraYMLI/0ZuGBeE8Ozz8aALP0CokQ/aEDILvtAWd2vNwO0=
X-Received: by 2002:a05:7301:3e18:b0:2ae:56d7:b02 with SMTP id 5a478bee46e88-2b17d2396abmr5052920eec.9.1767873781378;
        Thu, 08 Jan 2026 04:03:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkFHw9flA6BK+qKsLKF9oA/yJ+6dN9Q/gF1ciKzvoDMZ9FSBH10p/ZBwqBXyijiYeLIJde+JlZOPtX67/Ubc8=
X-Received: by 2002:a05:7301:3e18:b0:2ae:56d7:b02 with SMTP id
 5a478bee46e88-2b17d2396abmr5052886eec.9.1767873780935; Thu, 08 Jan 2026
 04:03:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119095525.12019-3-piliu@redhat.com> <20251125032630.8746-1-piliu@redhat.com>
 <aSVlX5Rk1y2FuThP@jlelli-thinkpadt14gen4.remote.csb> <9deefb73-fb3a-4bb0-a808-88c478ea3240@redhat.com>
 <20260108114205.GJ272712@noisy.programming.kicks-ass.net>
In-Reply-To: <20260108114205.GJ272712@noisy.programming.kicks-ass.net>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 8 Jan 2026 20:02:48 +0800
X-Gm-Features: AQt7F2q4cRpSEoOMyYvMjZnUSS7JthMu1IhofZri1__Qq6DnXgOSGUdl8ZbGb_A
Message-ID: <CAF+s44TLpaK_xWsfv9B7jQtW0stSjJnk2GgaftpAJG+Epkp-7w@mail.gmail.com>
Subject: Re: [PATCHv2 0/2] sched/deadline: Fix potential race in dl_add_task_root_domain()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 7:42=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Jan 07, 2026 at 02:57:00PM -0500, Waiman Long wrote:
> >
> > On 11/25/25 3:14 AM, Juri Lelli wrote:
> > > Hi,
> > >
> > > On 25/11/25 11:26, Pingfan Liu wrote:
> > > > These two patches address the issue reported by Juri [1] (thanks!).
> > > >
> > > > The first removes an unnecessary comment, the second is the actual =
fix.
> > > >
> > > > @Tejun, while these could be squashed together, I kept them separat=
e to
> > > > maintain the one-patch-one-purpose rule. let me know if you'd like =
me to
> > > > resend these in a different format, or feel free to adjust as neede=
d.
> > > >
> > > > [1]: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt=
14gen4.remote.csb
> > > >
> > > > Pingfan Liu (2):
> > > >    sched/deadline: Remove unnecessary comment in
> > > >      dl_add_task_root_domain()
> > > >    sched/deadline: Fix potential race in dl_add_task_root_domain()
> > > >
> > > >   kernel/sched/deadline.c | 12 ++----------
> > > >   1 file changed, 2 insertions(+), 10 deletions(-)
> > > For both
> > >
> > > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> >
> > Peter,
> >
> > Are these 2 patches eligible to be merged into the the scheduler branch=
 of
> > the tip tree? These are bug fixes to the deadline scheduler code.
>
> Thanks for the ping -- just to double check, I need to take the v2
> patches, that are posted inside the v7 thread?
>

Sorry for the confusion. The two fixes in v2 are actually intended to
address the issue in patch [2/2] of v7.

> I mean; I absolutely detest posting new series in the same thread as an
> older series and then you go and do non-linear versioning just to make
> it absolutely impossible to tell what's what. :-(
>

I will use reference format in future. Again, sorry for the confusion.

Best Regards,

Pingfan


