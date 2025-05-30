Return-Path: <cgroups+bounces-8398-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A7AC9407
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7205C16F448
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EE235065;
	Fri, 30 May 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0NRt8jr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F571494A8;
	Fri, 30 May 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624107; cv=none; b=Q5qvMe3bbGwcjUI8+RgndaGqmL18eqGJkT13oLKQy3h7/stjDiwuF8oUElq2PLBzhOdEueofVSVOK529SdQgMtladbU9Acxc6XasRrCux5VLPv+pljrt+Gdo23uYK6ROxWCS69jaQzm2kK4gIqd6wnHewM19FqGh55P6EYG9O2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624107; c=relaxed/simple;
	bh=lT4WagMserRkyjQNSVKjtLAVFBHdB+FXM5/nESH6yO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh5LhFD9olAbCg8ZSgsWC0KalpbMilmEd/Y0OSwQj/TDm51Mz+LFAU/4kZm/Rxb+Cu/xbRGTYke+N7FlSMds+Rp1wgq4TlfLrH6BpIM+iuHiam/Xcn/UkjdnSrRdsSNQ3qYXmEPV2oHhmzCC+ZlRIgYGZuSXUhHqh8TwkunZVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0NRt8jr; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4067bab37a1so696826b6e.1;
        Fri, 30 May 2025 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748624105; x=1749228905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqt2OZU765DZ4rzjJVIwHCfM6JfixmePMf24eq1pAoU=;
        b=Y0NRt8jrml2j/ZPI3jo/xcd9fXkz2gPSslulwq/f9B+QbUK+4yG4fFXs6AOoDfkPAy
         9WaFtxLDMehuUKecDcQgiFk17qs2gQ9ufa9mbSaR0xadqwi+saPS+Sw18SivSlnUkk7K
         6uFCynlRNiA17tDXqJ4cWqfSJHjSR7PwedhhGrY4tJSJRjI4FJPIvvTQWXGHdCDkKvp+
         hEngWvZjaNDVr8ECjxV6AeFEUW+NzYPyoZlk8OVhbxfjR/brK7Uvoe9/+qFZvWsWSdn8
         UdAkOeVDAG/qrDJnusH3I0ETwFrj2gXGQAOwqku8huM+7/Li9MkNUAKzxxZJUWqq+TZh
         P6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748624105; x=1749228905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqt2OZU765DZ4rzjJVIwHCfM6JfixmePMf24eq1pAoU=;
        b=NqrTtptPSkPR+koI6fOi0GY0C1pczFnV/nUJLuh+0c6utYadMCyI9PO+Ppnj6rKyOU
         ozrUAIxxaW7OB9t2IdLKhaHeb6fXC4XYd4CsulIDk0LFwvwzZp/oolUhObxNAQGHE/1P
         f7AZA+M+MNBWeNRwajX+7gHuesv77XrJf6OlZbFpbNEsz7yiEDEJhWK+Viz307Ca1JRF
         6tqEdIQrvcuepdoQ5UD7wd+iIe85ZrIXF03AgKhlYJhRnhRruv5AOjYgbTWXjabJMdUB
         efexMeAYVt5FQDv7GsbTYZ0V3Ju6ECO3wAfi7crI3Dxd69BojguLG6TfSq5W0HMN6Mse
         ofxw==
X-Forwarded-Encrypted: i=1; AJvYcCUteEznM29bNPMX6TGb7Dz+oYkP9nahXE/4i+KfUXlrO+43VLdWV/ae94necMGD8hDiZ8RBjpuWRxY=@vger.kernel.org, AJvYcCWjqkCv5W44xlc/HmrXwy8fcWrYxUizHsM/jN3L8S2lj8rnHJyMtqhEJiuQ/8+fF9nsFTU9NhIo@vger.kernel.org, AJvYcCXbEnukP1DolY98vyYpk97jW6BxbaPABA5HBmP7UCV9C7eujBPKHrKYS/+QLP9GNYMyQ7HcTts/xunPrJi7@vger.kernel.org
X-Gm-Message-State: AOJu0YzxY6ry8+Mv8QxPKx/+JCDIkViVEWE/VP3VRmwsbm/ipYImNw0B
	HOqRNtdP2OtqxWEJsLhX8Y4OP6Qto9fMDc0ddL1d+9gmTQGxKwNKSzRBLGa5SQJa+UYH19vncAQ
	mfG3sjTLS0aYPeOwf/9hJAEbecTKJzg4frowj
X-Gm-Gg: ASbGncscHOm1sps/qOSzfMFG0ExkHhbl2K2EUqsCYz1ExxkoqBHXO9EIXnIHrIh94+k
	6tXZRAwh4xptYJa2B+PFv5JLpm7rETAwjao/IynUdyCPUcPN3DjeVH0sHY92DrsoMjoOfQvKfmC
	wUjHqStyWClj6x+R4SfxsK/yV9C1pmEf0Bog2oAb0WA+Mo
X-Google-Smtp-Source: AGHT+IHB0e8ZcQXlRKbX6QjqNRoTic5+x0faxw9bYJUhQp/G7HvCR9DNNLXqmpwx/q9vbFD33Zly4TA6kqaRhd5hL6I=
X-Received: by 2002:ad4:5de9:0:b0:6e8:9e9c:d20f with SMTP id
 6a1803df08f44-6faceba7f22mr65787346d6.21.1748624094334; Fri, 30 May 2025
 09:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429233848.3093350-1-nphamcs@gmail.com> <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
In-Reply-To: <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 30 May 2025 09:54:43 -0700
X-Gm-Features: AX0GCFvuULRfRySClBlmZxkqSsY-BA5dnNbFR6m80KNAo7UsLs27pGm5GgleJLM
Message-ID: <CAKEwX=NUD7w1CD30FY-_FdxQ6u1sUOAyvKhg-mDr6BUOkfFq_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu, pavel@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, gunho.lee@lge.com, 
	taejoon.song@lge.com, iamjoonsoo.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 9:52=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, May 29, 2025 at 11:47=E2=80=AFPM YoungJun Park <youngjun.park@lge=
.com> wrote:
> >
> > On Tue, Apr 29, 2025 at 04:38:28PM -0700, Nhat Pham wrote:
> > > Changelog:
> > > * v2:
> > >       * Use a single atomic type (swap_refs) for reference counting
> > >         purpose. This brings the size of the swap descriptor from 64 =
KB
> > >         down to 48 KB (25% reduction). Suggested by Yosry Ahmed.
> > >       * Zeromap bitmap is removed in the virtual swap implementation.
> > >         This saves one bit per phyiscal swapfile slot.
> > >       * Rearrange the patches and the code change to make things more
> > >         reviewable. Suggested by Johannes Weiner.
> > >       * Update the cover letter a bit.
> >
> > Hi Nhat,
> >
> > Thank you for sharing this patch series.
> > I=E2=80=99ve read through it with great interest.
> >
> > I=E2=80=99m part of a kernel team working on features related to multi-=
tier swapping,
> > and this patch set appears quite relevant
> > to our ongoing discussions and early-stage implementation.
>
> May I ask - what's the use case you're thinking of here? Remote swapping?
>
> >
> > I had a couple of questions regarding the future direction.
> >
> > > * Multi-tier swapping (as mentioned in [5]), with transparent
> > >   transferring (promotion/demotion) of pages across tiers (see [8] an=
d
> > >   [9]). Similar to swapoff, with the old design we would need to
> > >   perform the expensive page table walk.
> >
> > Based on the discussion in [5], it seems there was some exploration
> > around enabling per-cgroup selection of multiple tiers.
> > Do you envision the current design evolving in a similar direction
> > to those past discussions, or is there a different direction you're aim=
ing for?

To be extra clear, I don't have an issue with a cgroup-based interface
for swap tiering like that.

I think the only objections at the time is we do not really have a use
case in mind?

>
> IIRC, that past design focused on the interface aspect of the problem,
> but never actually touched the mechanism to implement a multi-tier
> swapping solution.
>
> The simple reason is it's impossible, or at least highly inefficient
> to do it in the current design, i.e without virtualizing swap. Storing
> the physical swap location in PTEs means that changing the swap
> backend requires a full page table walk to update all the PTEs that
> refer to the old physical swap location. So you have to pick your
> poison - either:
>
> 1. Pick your backend at swap out time, and never change it. You might
> not have sufficient information to decide at that time. It prevents
> you from adapting to the change in workload dynamics and working set -
> the access frequency of pages might change, so their physical location
> should change accordingly.
>
> 2. Reserve the space in every tier, and associate them with the same
> handle. This is kinda what zswap is doing. It is space efficient, and
> create a lot of operational issues in production.

s/efficient/inefficient

>

