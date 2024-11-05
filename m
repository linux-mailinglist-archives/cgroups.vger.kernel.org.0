Return-Path: <cgroups+bounces-5439-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731729BC374
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 03:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279C61F22C70
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 02:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF655E53;
	Tue,  5 Nov 2024 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i+u88lgg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77651C4A
	for <cgroups@vger.kernel.org>; Tue,  5 Nov 2024 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775452; cv=none; b=Mt1wBjSLZfmwwRmzMPGOc1xLC+2Sv+EmHPsnMk/cTbJt6amboRNCn3uCjxRM/Fg95MnrqmWR4vAfsBr9q5USpBnZYt1ytC7HHVIfg5BYLpBoScwYFhdztm3cgrOBUIVF40+L0LewggGYw0RWkdJty4aRn4Ryu4VbnQnM1BYT5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775452; c=relaxed/simple;
	bh=sS3CMf4Kq9jd/bpACivyVDfVteTLNEOFDKp07YdmOz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn2bDVyQs+o+Fhl3oYNR6WOz0vL8MgP2rn7OOCvp9TK0z1In+XWyz4csraSFEowbMf6CBTIYjM2F9QI0CjQRHmcpH5fA8Da7NKjLpUkIwJ2XXtwwr74q/YvZ4TZh25Daij796105KqcoDklCOqA7BIzwyKH2A9AqxbDW6BGRBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i+u88lgg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431688d5127so39268805e9.0
        for <cgroups@vger.kernel.org>; Mon, 04 Nov 2024 18:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730775448; x=1731380248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS3CMf4Kq9jd/bpACivyVDfVteTLNEOFDKp07YdmOz4=;
        b=i+u88lggyD0FUx0Aw5YdC6FlMWIwKmjTz0CQAxZC09na69k+FV6jfYDGctcR7pnDOQ
         ugnh5cidsyOLNlca5iy4TGzmf9Xi1ffqLnpmvXcchggBNiEGWJnUquv3LxyfigdxIpHN
         t7nx4MEgqDNzKbS4h+d8e1PqAF6yULFgUKdda3AJgWTP3lN8HNsp7BIr9tGveYHXpYaV
         tBSPqfXcqtY+pmovM9RtUBW/FmEzGg0wtJB8DJYPpy7o6F8cX1b0NiK8/GQ3L9jGoBXI
         81hICY1uJk2yzz6h4QVyexrXGeP48lSEtxLzkP62geCb8VD/2o/5jE/gAEbxf/9t3YYp
         M7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775448; x=1731380248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS3CMf4Kq9jd/bpACivyVDfVteTLNEOFDKp07YdmOz4=;
        b=w4SzvWY9UoA7tsjTQSjmu1Qdx/MxUhlhf+7Ob6GP9Q/NauaRs45b5cit/S/svBUbhJ
         3LD9hQMrp2JdXfA+cQOn8ImGPYAEBO+n0XbwZhUBOppNQVjm/zBNtd0GlJHdtn0cDVbr
         xxkcWnm3ROzLtIUGzkrADK/Bxa0UGx9UY3Nh+shRA6qGlRyAcZecbgzn+yB1qP+DAMF+
         7Ay1NSWWBS8ZYjbWMb4CvnBMsFSGf8GInL135xpEubUauHFJ4KsAMHt4CDSqFFEe3GvW
         npKWdnopx6H7XWaYF4j0eSjGpAyhO0y0lpeLzlhQrt7egGl7lGHw+GqWxg94FpwVv2aA
         GtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSvAKwnjDD8GMtwQNVFdEOYizyXSa+EAog/CgGejQhzHwWisznPOwP7sDqRtNj7NoqaCk0DnOO@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOY5dQiyyUKTN2Hwx6ATMBqg8VGGLHkizerjqKzQRCEBdMrX/
	YCxB04n/aEWgNPm084FYSYnvMR5iYRkoBin91n/+qpExH8WGO1DHQp55nETZxjj65NYB++GQ6HS
	Wcy4sJ34YdjCvLiEEZc2aeXSOSqlYpdkUr8FrXQ==
X-Google-Smtp-Source: AGHT+IEUgmRA9k4E2NWll724MZRF5057DH3TEbo3DZCREWtQaiV9UgzAwBetdTmsALt49U8N8vIwu8RkJxjhSFYYVzg=
X-Received: by 2002:a05:600c:4691:b0:431:4e25:fe42 with SMTP id
 5b1f17b1804b1-4319ad24a5cmr303575495e9.32.1730775448507; Mon, 04 Nov 2024
 18:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101095409.56794-1-songmuchun@bytedance.com> <ZykOfDWLjEB5Sc8G@slm.duckdns.org>
In-Reply-To: <ZykOfDWLjEB5Sc8G@slm.duckdns.org>
From: Muchun Song <songmuchun@bytedance.com>
Date: Tue, 5 Nov 2024 10:56:52 +0800
Message-ID: <CAMZfGtU3sN5y7DmYz=e5DtUk5ApvUsA9qJh1k__zpMYagZ0JbQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] MAINTAINERS: remove Zefan Li
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zefan Li <lizf.kern@gmail.com>, Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 2:12=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Nov 01, 2024 at 05:54:09PM +0800, Muchun Song wrote:
> > From: Zefan Li <lizf.kern@gmail.com>
> >
> > Not active for a long time, so remove myself from MAINTAINERS.
> >
> > Cc: Zefan Li <lizefan.x@bytedance.com>
> > Signed-off-by: Zefan Li <lizf.kern@gmail.com>
>
> As Zefan hasn't been active for a while, removing makes sense. However, t=
he
> S-O-B chain above doesn't work - if the original patch is from Zefan and
> Muchun is forwarding it, it should also have Muchun's S-O-B at the end. C=
an
> Zefan send the patch himself?

Hi Tejun,

Thanks for your reminder. I'll help Zefan resend this with my own SOB becau=
se
of inconvenience of him.

Thanks,
Muchun.

>
> Thanks.
>
> --
> tejun

