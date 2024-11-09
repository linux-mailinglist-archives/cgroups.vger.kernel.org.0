Return-Path: <cgroups+bounces-5498-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF89C2F31
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 19:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4126F1C20C6B
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850319D090;
	Sat,  9 Nov 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkNA1m9a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67604086A;
	Sat,  9 Nov 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177706; cv=none; b=M1Hx8f018ojWTTWEUR539D9GBR3UFfsfWhd9Phq6z1hK7l4ULGQfWRcsrny4ba75bBaHwh5RkyFkF6alD0mO6BcfTUMr5CVv7TLhyq/qBTtOY/fGTjeDY9HQ44T+OS59vF9KN6zpn2cqxuR7qhgg2HpCekQUs2pFho5U/OavuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177706; c=relaxed/simple;
	bh=BskC1hCEB3dwT/bHGHUlA9aiPdbYfQueURpzVZyrXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=takUqnEVWnA+A8XQMHUCKjHl2UXRvURMWCG/HYaZ0QU6wM979Ej5nQSG57xsyC/DpvElhzIRYXNvrnXehsSCrjLKQmf/Pg/QW6zz77yfX7PF3kFbteyMlkiKKxge1WSwBRLqbUpkr7YFWPYMsaeXo61qfnEOFcops1HbRGGEfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkNA1m9a; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso4009458a12.0;
        Sat, 09 Nov 2024 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731177703; x=1731782503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNlXSM/mRvwEpqZlLvbPIkMJUyRK/yTk4ej4kNdJ7Cc=;
        b=gkNA1m9axUiIaXKTU23NgRkvv6yC+dnzmuKMiMxJW07ok+xMJzUQ32PNjoLlWR8bwp
         kEYMRohW5KVTM3rwPWUg0aIMjht5LRvY6cuvtgc3+HTwR8CMfBlzdm039+9DdL4aVNCI
         fYTGschkUXWwUlFI2/JGuN62OdVqgNwY9/kj6n0MLslIIaD9iGy5jO0WtCTk9AjTYDgR
         2sXCK8A+HkGRWMvZPl+zozu+pgNCpjg9j5N20YZ/Ow/WH1iBDz+AmArG0hF2p0gD8hMt
         VzsIqk55+1CYPlgXQqqAEAlGErFcql7t1xmtAEqeDqQ2nqsFTbOjnFO0dw1U0C4sNAME
         aKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731177703; x=1731782503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNlXSM/mRvwEpqZlLvbPIkMJUyRK/yTk4ej4kNdJ7Cc=;
        b=kW8ZM25Uc4yXwFnaTNms7o53vdAqpL4jSHCclb+k0JI/kemRzD2xnvWH0KMhRI+Yb2
         9kMwSnyBWodqbW9CUu8oizaEoZ7bbZsSADZppnZwRFi0BiDwjIOkGxigKC1eMshavuAc
         xbng4rsFj/58vGe5EPO4RIMl5VFUXS/fvjMkhLF6MCQ/F6BnI1011Vh2eY8yAGrwrEQ+
         4WB87j6wSVhug8xyhjs+esgBlf22TsFa2Uv1dcNUxfuX26rIuwOkllQPTzQPsZkYJb4L
         v6o7k1PUESUx2lii1syzzto0zJe396zZFFcpWUPAFKizDpP7ZF5BoymxGSbRu8g58rSG
         fmVg==
X-Forwarded-Encrypted: i=1; AJvYcCVUBHSOazGOnU1GjhcqhcMD5duEJHOYu0fL0ZfBw3yVw3HMCyoxtB1laUttwNXKiYpMISnIngRbwClnOt9p@vger.kernel.org, AJvYcCWLfvN3froyzmGJnFOiIwwcfXjmCUHWGSb2zBICqtDa8aI2Gzt+WINbP7KIbxtFqcgojysDAVd0@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrNl1zX0XcoEewY4R/SHdZ/1qgL95TCoC6LT9Xc3nS9L6fql8
	IuMLk4rGcIEX8iCsEzCdaDHV0B7eaKcS2tv78IPoGCliLsQbv2ISTVz14KkCx0djWhy8H+dOMTq
	GJ4q6/5gdwHSjKZbQflrcQ2iB1WQ=
X-Google-Smtp-Source: AGHT+IGUPPpq4g+KUdJ23PuFE9NGdwVNeGGNVd8Dky9lJQwYQN1flJ5XUVtiBdxwY5t0Y/KgdMBfHn7l62BjSzzhGSk=
X-Received: by 2002:a05:6402:1ed1:b0:5ce:b9f9:f5c5 with SMTP id
 4fb4d7f45d1cf-5cf0a4417fcmr6325621a12.25.1731177702793; Sat, 09 Nov 2024
 10:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108212946.2642085-3-joshua.hahnjy@gmail.com> <20241109010307.74840-1-sj@kernel.org>
In-Reply-To: <20241109010307.74840-1-sj@kernel.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Sat, 9 Nov 2024 13:41:31 -0500
Message-ID: <CAN+CAwPEMNN_0HH-XvzenK4+k1a0cHdwTksrGTtjaEc2mvCjhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
To: SeongJae Park <sj@kernel.org>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello SJ, thank you for reviewing my patch!

On Fri, Nov 8, 2024 at 8:03=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Joshua,
>
> On Fri, 8 Nov 2024 13:29:45 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> w=
rote:
>
> > This patch introduces mem_cgroup_charge_hugetlb, which combines the
> > logic of mem_cgroup{try,commit}_hugetlb. This reduces the footprint of
>
> Nit.  Seems the regular expression is not technically correct?

I see, I will change it expand it out to include both. What I meant to
say is that it combines the functionality of both the functions, but
I think there was a typo there. I will just expand it out so that it is
more clear to readers!

> > +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
>
> Can we add a kernel-doc comment for this function?  Maybe that for
> mem_cgroup_hugetlb_try_charge() can be stolen with only small updates?

Yes, I can definitely add a kernel-doc for this function. Would
you mind expanding on the "stolen only with small updates" part?
Do you mean that instead of writing a completely new section
in the kernel-doc, I can just change the name of the section
and modify small parts of the description?

> Thanks,
> SJ

Thank you for your time! I hope you have a good weekend!
Joshua

