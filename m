Return-Path: <cgroups+bounces-3719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3965933415
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 00:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8C7283197
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B513D502;
	Tue, 16 Jul 2024 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="iFYn1rCP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9A1860
	for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167590; cv=none; b=m0mH3JVJIKsKzC6NMST3HNNkKpjgC+jmmC7FGQXh5YdCgGNyjpr2xIhjiPqkgjDo1b+UMWKBw62mFL0KJkMdqaD5jgsKbVMDHQGVSC11OwEUvMclenbAQItWeaCKXtUit6tFwqwqoYWYWDftoJpB8HVA9CnOCXRHc0C4Rert3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167590; c=relaxed/simple;
	bh=w2aJTmvDOMvn6K+ayRVj7cPeNTzCuJAPOw72W6PM9lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Osq+N6Cqxj6iRmAAKXUXGbl7ZYP1pOigteDMiKMTRe4npoj0HmZbEH22UK+nEPhmlMknRGxQy93xgtsc+lC2dUIZJV1uFCWx+Jmu8WUWwJWF70463KRR+uyJEQG+/9Hi6t6pPh/nM7Li4V84/HOfcYiUScgLWjUQoN6XG9nxCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=iFYn1rCP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b0bc1ef81so4069763b3a.1
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721167588; x=1721772388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2aJTmvDOMvn6K+ayRVj7cPeNTzCuJAPOw72W6PM9lM=;
        b=iFYn1rCPz8Yjz2EqLEmXGiJwH/zAtHBURGmwCoilfR2SeKKpx4O0cDZlR2kk31aShx
         GFn72ubRuT+2Rp7ns/omxxe3uiBjun9JBL+Kb5/ElpuqkjlY3ZCKKl+6zkcLC43yvdq6
         vgenCo2lVDOAIw1tMNUvFiaHR6sKyHFJ/LcgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167588; x=1721772388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2aJTmvDOMvn6K+ayRVj7cPeNTzCuJAPOw72W6PM9lM=;
        b=W682JDASY2pH2kR+2qTkQwz5NIGkLvyQoFrWrcO7XaEQ91AHdYkpn0ATWBtKaaRORh
         CIuc4Jw5/Y8tumRszbhJ2IK9PZC7C5aIzP2yOo6F1gscHNlEN1dCOHeqsMCGQAPcZE8+
         hUfGJCLVq3/TXy+uBC4P2JhXg/6ZwD/mmkdt9ulLy9L+T3GVRyniEm0g0qm4TvyjapPs
         op67YYa2KKMf8FJstQslnclj+OQjipi9vc45cQ/03o+I+Pa//eSSnovAsFd2jxfejDO7
         2Cn35Mk77jxRxRDtnFjP7CJPUSfErTRGTfq7jLxrthU1wmjF5YzqlVncylW5yfrjOges
         yQww==
X-Forwarded-Encrypted: i=1; AJvYcCXZqygVT8ZKNXi3PFbo2x+jJF/mmvhT48k8QOl0R/oe9SMyPo4piR1wPCpwvrR1PVi+aPJHU204okpD/f2L7MtCGCi6XeO0Bw==
X-Gm-Message-State: AOJu0YyOMCLfHIXsw7XmWDmhtPaJAXZfITZ86WSLuQa7WnQ69kxhJXz9
	XeD7rL05XrAbDK83aJrktmmexvAUKSeQTYw97p016tb+ZFTqIp+ml9pXoFg8WvUMMm2aztmYagz
	/uEJh80EEvuaugT5KtZZE4JDkktNzkpR19mZ+YA==
X-Google-Smtp-Source: AGHT+IHa4OUEBjwkyORdqOTlwB6SwJ3UGLm7iossoLCCGBgQW/WBnp341S1YhpWMm7wMFcfIxWpuIGR1HiBOvvInuxU=
X-Received: by 2002:a05:6a20:a123:b0:1c0:7ec3:c7ae with SMTP id
 adf61e73a8af0-1c3f12ac92dmr4304824637.47.1721167588247; Tue, 16 Jul 2024
 15:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka> <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
In-Reply-To: <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 16 Jul 2024 18:06:17 -0400
Message-ID: <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:00=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 16, 2024 at 08:00:52PM +0200, Michal Hocko wrote:
> ...
> > > If we want to allow peak measurement of time periods, I wonder whethe=
r we
> > > could do something similar to pressure triggers - ie. let users regis=
ter
> > > watchers so that each user can define their own watch periods. This i=
s more
> > > involved but more useful and less error-inducing than adding reset to=
 a
> > > single counter.
> >
> > I would rather not get back to that unless we have many more users that
> > really need that. Absolute value of the memory consumption is a long
> > living concept that doesn't make much sense most of the time. People
> > just tend to still use it because it is much simpler to compare two dif=
ferent
> > values rather than something as dynamic as PSI similar metrics.
>
> The initial justification for adding memory.peak was that it's mostly to
> monitor short lived cgroups. Adding reset would make it used more widely,
> which isn't necessarily a bad thing and people most likely will find ways=
 to
> use it creatively. I'm mostly worried that that's going to create a mess
> down the road. Yeah, so, it's not widely useful now but adding reset make=
s
> it more useful and in a way which can potentially paint us into a corner.

This is a pretty low-overhead feature as-is, but we can reduce it further b=
y
changing it so instead of resetting the watermark on any non-empty string,
we reset only on one particular string.

I'm thinking of something like "global_reset\n", so if we do something like=
 the
PSI interface later, users can write "fd_local_reset\n", and get that
nicer behavior.

This also has the benefit of allowing "echo global_reset >
/sys/fs/cgroup/.../memory.peak" to do the right thing.
(better names welcome)

>
> But then again, maybe this is really niche, future usages will still rema=
in
> very restricted, and adding something more akin to PSI triggers is way
> over-engineering it.

Yeah, I think this is niche enough that it isn't worth over-engineering.
There is some value to keeping broad compatibility for things moving
from cgroups v1, too.

>
> Thanks.
>
> --
> tejun


Thanks again,
--=20
David Finkel
Senior Principal Software Engineer, Core Services

