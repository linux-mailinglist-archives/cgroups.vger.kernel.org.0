Return-Path: <cgroups+bounces-3931-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B49393F6D4
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B216EB21321
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976F314A095;
	Mon, 29 Jul 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="FlpIE8aw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230EC149015
	for <cgroups@vger.kernel.org>; Mon, 29 Jul 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260270; cv=none; b=ndybd81EYwi9Jn8hbJvQOvmMLryfYYQ/zNrdkgi3Id9iNypjyswCjoHFAOGZYxug3wD7NzKihV5Ct07N3P17CjuN/kJuVR4aRJft2NY1nWRJYz7yEIfqF6sq84w07iqC4gPAZicPuBoQYokQe1lxAQPGqTUjErjK28U7ozuwsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260270; c=relaxed/simple;
	bh=yG95b8+bC4kOE+uaI8opD8vDKWLRODfkFzlGoBvrT+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QB3n3MYZhHFtr868psjk82iFx79j/UXIu+tU0KY7FnxVJxLe2qN3bfFfpyWhmisaLtEFUhdkikvqwZyDv8aDS12GesK9XzLpbXgE8Iml2CGcNEZjYZXpEVceHnBbvEkkzfJexSSB8ulh2o188yr7BIiX4RXxEFpXWfPBqLPnNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=FlpIE8aw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d162eef54so2068056b3a.3
        for <cgroups@vger.kernel.org>; Mon, 29 Jul 2024 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722260268; x=1722865068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVlA1fdRbUzGUAt+y6uU46luMcytNgyhT35LNSCEVFI=;
        b=FlpIE8awr0cTwKExXUN4iBYmqWqHwMJfgkTsUPn3rZoChr+1ZTfybqcEcHMBBgNrCA
         UfWYShJ/dKI+3SfRhH/KQmuM1Xfluw/U7s0AJnZNA54MrNVGCaBVHb4C8RZkebG4agNB
         1Sp2VyRup8IFSC9jKmYyAii/ykANZ72Are/I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722260268; x=1722865068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVlA1fdRbUzGUAt+y6uU46luMcytNgyhT35LNSCEVFI=;
        b=LtGdMC9l6KSE9ROnwSabhXjN+gNfmD7Y+Nt6Pg2xKFOiFSb6QNEEgkQiI4kJO0NTmM
         7qhhPe+tfJpwO5yoPK4hb4BG33ST7Rrv+anW8HilMo71aSOJNuJRt/UzlMtzSuEq5vYt
         JiONjhJN7hsYASLGa5iXJLuk3z66GeOyDCMVyLI3nz6/GKwsvOgtI4k+O6qbTfP2S/Bp
         hFYMcfI+7Q3aENp2cJ19icphAPH/NuAQ5sXU4Q7Yy4MWwwPEKz4/bsac5p3xhNhatCsr
         PEoHPrKe+8DaD6MznhaYWmHo8MFdJz9sWXfPIAyb4Oa9YDZliNlVlKY4QOACKo3W/ORl
         l8HA==
X-Forwarded-Encrypted: i=1; AJvYcCVm9JAZ2VlwolwDVpkYoW0mvWPTCj1pf4P8YqfGIS/9/mSHExisrNVlvwJ8vsIeu3SeqjI+5mtkTmws+Iq0zm3duQteZ2FoCA==
X-Gm-Message-State: AOJu0YzWmK7rDyI1wLp2X3CWPnxkMInN0KNf+pWEhQEt6/tHi3sytIPv
	TR/Qj+aUJIxjq9yuAhNR5Ho7cVeyuyzKtWuXMmnWGqX+RBZhilWFu+AAibLAoN36qPT+5sbL9UA
	NM8mP3fdVoqslhp1yTaKUsbQD1I+3jiMv6SvxpA==
X-Google-Smtp-Source: AGHT+IF61PUOxYopexvONqf7EeqGxcofDSZYfNicSgd0cvdI1gdvPurED0XAgonezp6ozKF6WcHIo+B+gfQ7euXDvTg=
X-Received: by 2002:aa7:88c5:0:b0:70d:262e:7279 with SMTP id
 d2e1a72fcca58-70ecea01412mr6938042b3a.3.1722260268207; Mon, 29 Jul 2024
 06:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723233149.3226636-1-davidf@vimeo.com> <20240723233149.3226636-2-davidf@vimeo.com>
 <ZqQFaz07jIg4ZKib@slm.duckdns.org>
In-Reply-To: <ZqQFaz07jIg4ZKib@slm.duckdns.org>
From: David Finkel <davidf@vimeo.com>
Date: Mon, 29 Jul 2024 09:37:37 -0400
Message-ID: <CAFUnj5Op_SZ0sx7wCii=EWgx-nXycpMe1=961Z8ayOeAFSb2yA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Tejun Heo <tj@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Fri, Jul 26, 2024 at 4:22=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, David.
>
> On Tue, Jul 23, 2024 at 07:31:48PM -0400, David Finkel wrote:
> ...
> > +     A write of the string "reset" to this file resets it to the
> > +     current memory usage for subsequent reads through the same
> > +     file descriptor.
> > +     Attempts to write any other non-empty string will return EINVAL
> > +     (modulo leading and trailing whitespace).
>
> Let's just please do any write. We don't want to add complex write semant=
ics
> to these files. Writing anything to reset these files is an established
> pattern and I don't think we gain anything by making this more complicate=
d.

I still think something more limited is right here, but it seems that
there's consensus
that accepting all non-empty writes is the right option here, so I've
removed the check.
The next patchset will accept any (non-empty) write.

>
> Thanks.
>
> --
> tejun


Thanks,
--=20
David Finkel
Senior Principal Software Engineer, Core Services

