Return-Path: <cgroups+bounces-3841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80DE9391A0
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 17:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15ACF1C21554
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFD16DEDB;
	Mon, 22 Jul 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="GFMYAJJL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EE16D9AD
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661541; cv=none; b=lbTyjmVIVVrMCI9DZrfNbwWLGnMiStU/Df/hCDbxwoXbVg6B3kSZbifKhfUKzKwaue0cYrWxZVKpxypF7wyNILIJJCD7TF0QERe56AhKXeREkeawTgpUBfeKp6HLsw7r4IcFS7yym20SOxuN0meE8j0CnhIaqHG1+/S2gWqdZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661541; c=relaxed/simple;
	bh=tKK9/3I13MvhyzlrlIeNEK5w1H/w6SfkKGofIH4mavE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkXpmstFnJO4pRSOnW00VGH4adn3y8XI99wBLWBKJurNEGE3qwjTm7jIyUPZPYuPIUtnDUKJg6pLnJfAx9HdP/4sn8K6DmDHXdfqVirX7fKHlcG4GmKjxMCt10LQIy/9Bo9SDdLDOYH6HnehBu7mSnvEvhINe+ZoC3OmNgSRKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=GFMYAJJL; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25d634c5907so2106380fac.2
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721661538; x=1722266338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKK9/3I13MvhyzlrlIeNEK5w1H/w6SfkKGofIH4mavE=;
        b=GFMYAJJLKx1eyRTdfIm/1R0tSHAaQCvQ6HNwwKm+0gbeaCYa56vrIVm2bh6X0nmPzY
         MaR3kLjNepI6MXD3ONsPhE/bZyLrYxCeEkf2MJ1yOe3ZRkwTQnKyy3I4atydNdhTfdDZ
         aWKNv5LZWcxV/gC8Z/5+GksMiIBlI8KiY/Y5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721661539; x=1722266339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKK9/3I13MvhyzlrlIeNEK5w1H/w6SfkKGofIH4mavE=;
        b=XM5QIkmhdqUclUIQSL+F99NWdbne2bfvVn9DPwegCYACZySf7Z+jbgsUvLD+7WyCM/
         /zISvS4h+6tzDO4bI4RXSr9G9G56L/m39IsuTaOboqReaBAMj1AfayyO/dlfbjveyf2O
         /XxbCwZJdhjzutpgxkKEIaWD+6YPUABvKahRlp+yG912xEyIXHbHnz5GvJ4+C2ZcVrzp
         qPGB337ra/wMXkm2ffN5wnwPz/4a4ZafAmAen7E056x7RuJ9Fwtk7yB/egMSslbE5TYr
         5e3xk0brQvKr6l920fpjbF4YsLFuL8UEZ6FyMYvtVAqax3RpDsH3PP5iq9WLvB/f0PDy
         tN9A==
X-Forwarded-Encrypted: i=1; AJvYcCVdWFQ4BzyA77LQX/eK7Zh2Dvg+9seM1Qd4f7ZMd/J7w69oxhXIWpSkL3PElTD0Y52EpZNdq1mErDnu6bVu68vgJsevJg+4eQ==
X-Gm-Message-State: AOJu0Yw9VmKmCpkpPE0C69lJpPm5WJopTqr/AvIXJSRh9N09Gk8HtVNy
	wnpxYnuGVf8Qj5T6Mt6EY+Bxdj80dnNbWlCpAgpscL/Mp4Y/67RKYivr4gxf+wDrsOMLuXCsaZK
	U5OBVsdL/HWSAzHS9//ThXrPeNrLKWy75nODfiw==
X-Google-Smtp-Source: AGHT+IH5LDxowoDamLUYoLl291IngnNdCcTq6/3wHFVuWdTaH42FkypxLhePVVQznXZrboSlC/zmNdEhr4+x0rPlRJ0=
X-Received: by 2002:a05:6870:1715:b0:25e:1ced:744 with SMTP id
 586e51a60fabf-263c7612bb6mr6127529fac.47.1721661538646; Mon, 22 Jul 2024
 08:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <20240717170408.GC1321673@cmpxchg.org> <CAFUnj5OkHp3fYjByCnXJQ51rog93DsimSoc1qxcU7UyKw-nFrw@mail.gmail.com>
 <fcb8f0ec-59ff-4f79-82dd-7eaf2530aef3@redhat.com>
In-Reply-To: <fcb8f0ec-59ff-4f79-82dd-7eaf2530aef3@redhat.com>
From: David Finkel <davidf@vimeo.com>
Date: Mon, 22 Jul 2024 11:18:47 -0400
Message-ID: <CAFUnj5MsGdswXbvy6neGzDsD=9=CuTCcezrkz0ofFsJedydUag@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:23=E2=80=AFPM Waiman Long <longman@redhat.com> w=
rote:
>
>
> On 7/18/24 17:49, David Finkel wrote:
> > I spent some time today attempting to implement this.
> > Here's a branch on github that compiles, and I think is close to what y=
ou
> > described, but is definitely still a WIP:
> >
> > https://github.com/torvalds/linux/compare/master...dfinkel:linux:memcg2=
_memory_peak_fd_session
> >
> > Since there seems to be significant agreement that this approach is bet=
ter
> > long-term as a kernel interface, if that continues, I can factor out so=
me of
> > the changes so it supports both memory.peak and memory.swap.peak,
> > fix the tests, and clean up any style issues tomorrow.
> >
> > Also, If there are opinions on whether the cgroup_lock is a reasonable =
way
> > of handling this synchronization, or if I should add a more appropriate=
 spinlock
> > or mutex onto either the pagecounter or the memcg, I'm all ears.
>
> cgroup_lock() should only be used by the cgroup core code, though there
> are exceptions.
>
> You may or may not need lock protection depending on what data you want
> to protect and if there is any chance that concurrent race may screw
> thing up. If lock protection is really needed, add your own lock to
> protect the data. Since your critical sections seem to be pretty short,
> a regular spinlock will be enough.

Thanks, using cgroup_lock() created a deadlock, and using a spinlock
resolved that.

>
> Cheers,
> Longman
>


--=20
David Finkel
Senior Principal Software Engineer, Core Services

