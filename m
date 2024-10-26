Return-Path: <cgroups+bounces-5279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAC59B157E
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 08:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41861F236FA
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB9217F2E;
	Sat, 26 Oct 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/YnmKTa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD717DFE0
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924617; cv=none; b=XbvK7nd7Gl/Pg3wBGH7JYB2G7gu1JKKarlAA+BpF3Qb+84cqcX4p208CZre+ZbuodJUWvgRR3eUQWQK/kUPlBlmTFhCHMN0vLS8qom81YFL0d8Fmb0r+vWyosACjlrTAvFdZKh5h0VML9auVq4LdF+DxwljL3iQ4/CgZUR65f88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924617; c=relaxed/simple;
	bh=mtgTBJy4FbMsHO5dHuSvY2OTKdUEAD3tvUr7vHzN7Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMIt+cDu4lh5a9wNdHXKc4RKEnRFFiL9xe9W9854CnlqbiSzEiRmHFqJodeW6lG0caQYf8OrpWisMS16P8dW6k4hIor3LkTnjc7cR+DjFp5K0SzDnSNYLK47H/cgYSLns48JnJdeNcZn5XriKCBtyVrF0hrXEVT3xoZmrTiTGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/YnmKTa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9abe139088so384610566b.1
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 23:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729924614; x=1730529414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+qy2zQX0aaHTR7GxFs5bd2bieBYlh/M2zFjazhitkA=;
        b=p/YnmKTaWnZwwe0pc8jIuxOWpeRoAf2c9rdVOLQS8Yl68LmQsZZ3kuu5cp2wqxiSaa
         vavmGZRksDeIlR0N85+T55CkyOSBQtI8McFM3/jhnvR8zmyyFHi7h5euHb58jwIPlyPH
         J0cjkD5qmEZwlMf4XKx+56VFEuCThBRpSg0eRq2C8cJpkmHOsIrJ5oSnDLZ7xKZ/uhco
         uaQFFoCzG0oVlht+6GxejFulWYANVLt3S0QIvc9mPDkKkm500qOV0Q7ZCKUMjRFrHn/a
         R9jcv3za6lLSFBB55uYDRnwVNepCZehoPbjSDz6qNAlkggIDO1VgEnyfUoIPk2x+fWv0
         RthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729924614; x=1730529414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+qy2zQX0aaHTR7GxFs5bd2bieBYlh/M2zFjazhitkA=;
        b=lGYBlDhTJFhtziD8htaG8WRC3y2hbrOZSi9XZZcLnKXVP6OSJRMHc+tSy5SKxu495o
         oz9M0js8Cx8mYSM6udHLuwBIhtvJLNvrrSUuqdihCfVQ3XhYPV1b7rzdZU6/fnmB0f/M
         h97RmE6L2/Kf0QorCc0hENNWX00H5Too25iC/uqBoOwI/EEOQMGRXNy+qLtPysxY/tw/
         NhDCBqLVXh7ciKuTgVweMdS25pOfp09CRmmHoKEVFa9lOm14De5XFjAO3DhtzoZ7OT44
         U1v0ENvKIEHzhabeWDw7T8C/GxQ7JjrDLi7VjVVaw44HDUZVg1DJuwx/Cx3z4CgpjP+5
         VNLA==
X-Forwarded-Encrypted: i=1; AJvYcCUN7JCJ1F0RRk76OvrlklToeXHdujYaWWhzMMJRZuRcyQpUnXF3uQYRXRfnVnT3OFiytcZp+Nb5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4L4vGla2ch8yCb8AsziGlS5cvzy9cEPj+Wz9+T0HjSofKxTF
	5yNqaZVT6kfRAOLQIP4UrDLKfVlDBFGpHTpT3odFDA8pHouiHoj/dp1NGNXuK7/ccJrQnNuaQFn
	CUUz+7zvMY6sJAugfABfKu/9jqhSxnwZrchzp
X-Google-Smtp-Source: AGHT+IFgD0L5JjUW+CHqidonMlwwHMsl6bGtJqYpaisQi1tq5t2valMcY9r2So4B4VtRTvcEdOebNwVejifKQj3ZazA=
X-Received: by 2002:a17:907:3f9d:b0:a9a:1160:993 with SMTP id
 a640c23a62f3a-a9de5c91c9dmr144210966b.8.1729924613651; Fri, 25 Oct 2024
 23:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026004826.55351-1-inwardvessel@gmail.com>
In-Reply-To: <20241026004826.55351-1-inwardvessel@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 25 Oct 2024 23:36:17 -0700
Message-ID: <CAJD7tkY5mESytBy4bHM7e51ueY+yoiyPf9sqV03G1LoMdgvcqw@mail.gmail.com>
Subject: Re: [PATCH 0/2 v2] memcg: tracepoint for flushing stats
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:48=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> This tracepoint gives visibility on how often the flushing of memcg stats
> occurs and contains info on whether it was forced, skipped, and the value
> of stats updated. It can help with understanding how readers are affected
> by having to perform the flush, and the effectiveness of the flush by
> inspecting the number of stats updated. Paired with the recently added
> tracepoints for tracing rstat updates, it can also help show correlation
> where stats exceed thresholds frequently.
>
> JP Kobryn (2):
>   add memcg flush tracepoint event
>   use memcg flush tracepoint

I think this should be re-arranged. The first patch should have the
refactoring of the flushing code with no functional changes. The
second patch would introduce the tracepoint and use it.

Also, please use more descriptive commit logs. Most of the text in the
cover letter should be in the patch adding the tracepoint. For the
refactoring patch, please describe the refactoring and its purpose,
and mention that it is expected to be functionally a noop.

>
>  include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
>  mm/memcontrol.c              | 22 +++++++++++++---------
>  2 files changed, 38 insertions(+), 9 deletions(-)
>
> --
> 2.47.0
>

