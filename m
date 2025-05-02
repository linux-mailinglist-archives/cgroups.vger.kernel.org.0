Return-Path: <cgroups+bounces-7990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6F9AA78A5
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 19:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D96D179E2E
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC8256C8B;
	Fri,  2 May 2025 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1lcqp3G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E04A32;
	Fri,  2 May 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206786; cv=none; b=unQY/X6By+JeSn7ii6Iv4f/FL0Qne3VZOYgXy6GOsp02bwK2y0GJmoBQa1QOkLvKPUsS20xdyd3Q/rW/vsx/upEicUtr8UKbSnpI+j1EW/OSlmPQHSvPUzaOKGa317BdCJJ+y4SMFmygIvgPvCfm7QLfz5ggCJzm6XPs2tzQyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206786; c=relaxed/simple;
	bh=hbcahI7wFdZDBZyC5w9sU4ssdyxYtjLb0rj/djnehC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5ycO+noioP7y7vfDyOuGfRMCgW/EPeoZXNc3wYb62EC1g/IPshB4YNAbTC43KXbv2nNJaMLCbFWCZpX6aWJLxJcafjNjH9XaQFbt7g93GN3xS24CIxqXh5ZBR+R49t5iIyvWWrsEEKR38b1/Z9Z3QBiLZHSAGGJ32tFT4WvulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1lcqp3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5517C4CEE9;
	Fri,  2 May 2025 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746206785;
	bh=hbcahI7wFdZDBZyC5w9sU4ssdyxYtjLb0rj/djnehC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D1lcqp3Gjvt6sCLzWAy20Mo5aGxNqjqqb+AjVH8aalQIuRKYDg2SOfCZua7xayTzh
	 fbNx3aK2btW8eS4fMZruEPdeKjxZNUl5FKlLPO1TRvbegIu9myO7oX+hmmNM4VEbZq
	 5N7kgVU29bn8kIWa006Lz/+erbBN2e10xyq/O3p0Rkt9cCCoFbFBdQlSbcCc2C7lp+
	 Jt5e/0rDLbM4Ufvf0exiRrRKzAWXBn/xax5bbscyO9oCXkE/cGOINaiO4D49GfHDxR
	 0p+btKYjifTXixVRazK8TdBq4C+p2tNiBf6Ild1+DYb6BxH80K3q2JxAtz+sIyPI+r
	 aZqgwhcoRr49w==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f7019422so24533686d6.1;
        Fri, 02 May 2025 10:26:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlDhF6xqQ3psLlMplx+DiDhfdae3w2u0wgGL54aEje7ohRzOdFTw+M8YOiC0nW2GhhoBHDiPkY8w==@vger.kernel.org, AJvYcCWPmsj6AaGqWwwdeocC5wp8aTtpqiD+vuJrQXFDn9EGxUBaXKAt7Zy8cASS1/gXqodPSdk=@vger.kernel.org, AJvYcCXlf6eQer7ixS5tQweTxFhqDrQ5V+gTr54MiFs4bJeuyzhuKFruNyY+Z4w8dAmqdOvnFsN+4YwQtsX2sIx5@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5PPmhtyAhLdZI/u0CmsHnaTEQC/+ZeQCAqJCpvF/RMti0tJk
	8HHb1A/Ipk1YTA64NBAA736I++VdTo/jNTzghEw1dk5ReC9jsx0k4/pqE5pPj7uDfpmlDz3dInP
	RGH0/17QMKnHfPC/VPo0O6ga+e70=
X-Google-Smtp-Source: AGHT+IEhZx5zD8yvmvEs2lwLC7jhdDHIub8F3jphQG6t+/Qcqbn4ET6dyyzb12UcrVhVjjlh/VUhyhTnZS1toMBam58=
X-Received: by 2002:a05:6214:19c5:b0:6e8:c713:321f with SMTP id
 6a1803df08f44-6f515619481mr67835656d6.35.1746206784870; Fri, 02 May 2025
 10:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <aA9bu7UJOCTQGk6L@google.com> <aA-5xX10nXE2C2Dn@google.com> <CAP01T76Wv+swbT9xuQ-YhQ=-qOFggw6u1RziJNGjJBiNO233OQ@mail.gmail.com>
In-Reply-To: <CAP01T76Wv+swbT9xuQ-YhQ=-qOFggw6u1RziJNGjJBiNO233OQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 2 May 2025 10:26:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6rh=L6uz7sA8iCyRnqxJj8Eok4rqhQRXqFw=4tuqae+A@mail.gmail.com>
X-Gm-Features: ATxdqUFRV-jbWynKud--5JYm-b1VhDwA684cpaHQle-nRCzMtQq6Bv3ULYdoS7s
Message-ID: <CAPhsuW6rh=L6uz7sA8iCyRnqxJj8Eok4rqhQRXqFw=4tuqae+A@mail.gmail.com>
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Matt Bobrowski <mattbobrowski@google.com>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 6:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
[...]
> >
> > It's certainly an option and I thought about it. I don't think we need =
a bunch
> > of hooks though. This patchset adds 2 and they belong to completely dif=
ferent
> > subsystems (mm and sched/psi), so Idk how well they can be gathered
> > into a single struct ops. But maybe it's fine.
> >
> > The only potentially new hook I can envision now is one to customize
> > the oom reporting.
> >
>
> If you're considering scoping it down to a particular cgroup (as you
> allude to in the TODO), or building a hierarchical interface, using
> struct_ops will be much better than fmod_ret etc., which is global in
> nature. Even if you don't support it now. I don't think a struct_ops
> is warranted only when you have more than a few callbacks. As an
> illustration, sched_ext started out without supporting hierarchical
> attachment, but will piggy-back on the struct_ops interface to do so
> in the near future.

+1 for using struct_ops, which is the best way to enable BPF in
existing use cases.

Song

