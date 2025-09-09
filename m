Return-Path: <cgroups+bounces-9831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BE4B4AA9C
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C223E34337C
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A03191C4;
	Tue,  9 Sep 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXVPMuQY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE02C0F60
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413600; cv=none; b=KL7ACA53bhhcj3Dwj8I2eWSC407cgLzlJgB3BeDQdvDY3r8b3qWlsFPplND78ZorE9/Lk0N8W2orD2HiUvYxM9LwOZ9yypIKSwmksG1RW8uuhgjEb5qk0uzKhxMVt8qb+y7GG29l9SgfcqlIrI8Ar1mQSa/WwHTb8YKM9La+gbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413600; c=relaxed/simple;
	bh=K6u0fUFF//SvAFGmtzWkez3KolPH7k/HuAtkFfvBTUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwFeW9o+QgI6jolZ2a0LjfOBwuY3dpkR0NrV2f366ppfigEYXMraWJrqG0GrUNipRffS7bTWIF2Osjz3xTyG25W0wBO4yQr1z6Z9/9mY5gddMzmoHNUiFUXSGD3o30MmBmU54ZyunSJfULYLGnogeO2bHMgYfeT0Zv7CE04iJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXVPMuQY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso5587565e87.1
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757413596; x=1758018396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFqaqhtG5wCIiVa2BTrN+ftZjPVISTQRT/cZc7Siw0s=;
        b=dXVPMuQYCzdvVf/1b/qdeViWziTuKKEepwJZawLc2ShG4lwLHR9xOO7+5ChlYMiTxZ
         C2a5w4z/Ow1YnS+Z1DdyZu8adXMIfsU010Ai0aBQ9PUf9lSP9I3pme34WoFWBjKeZQZE
         5A++NlCEjPXm1OQw8LwiJDtyvrjc14nVvWLs91Pmp/J9aFq3vkih6N6Pf6Esg6pL11V9
         xbJJeAc5ErfEZDvxTnYkxtN6ezaUFzanMsIGiLLze//bkJNygBMzDqJ+W8saRqGCG7vV
         g6nm3TqhGHqyuD7JcyAPODloE2/qkYf1X8eVdckXMLrcc8W6p1iUangNYqiRkIpjo2k3
         GKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413596; x=1758018396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFqaqhtG5wCIiVa2BTrN+ftZjPVISTQRT/cZc7Siw0s=;
        b=C/OkNv3tL9WFZ45m09k1XfE6GHQ0J3Sh0xAGiuX0bhy7CbxDzbP1QPQBk1flQTX9b6
         c0nHiBTS7m951TdDadrmgusiO6xpbemXTSzF6xAZD9XsnLw/OhnHrKtNjoVe6xMBjJhm
         92S/jYtQvcTXNwl7x+JJIv5xkI4aL9lG1N5PJg9i/NnV2ROkqapaZYf2B0igJ+9Ryjpk
         s6bsUcRL7fyEu7/xDsiTpiEoNYn3OUGIZzXeDzLk5RGUVyO+s9nhzg3/F4Cg1ssXcbiK
         FJgk7ikGOB6MgSEi/X/gqhuyuvBSTzce4UeHQIhaI1yTraS5NDqJyfqct0EGuZeNnV2O
         Yg/w==
X-Forwarded-Encrypted: i=1; AJvYcCV25i9cKKJ5X/cK+YGVEJ2mlApAOUqf3JsXypb5BP3FzWWKoUyTFbDacQryda8rSvMVuaSEbIQr@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuEMadTkD7Yvr3PevU3AzngYA+ZWXfnCWBHhDqabgTZa9oqm6
	YxVB0vPOO7E5G9htGtak+AwBqvrjv4vVYcuOUlmO/bk0DghKvLVbVY2W0oxOCQgYA8bVK4AHyap
	8b7yM8E2mI9EhwOWuyfZZPZkY07qjPSSkiu1coR2jGw==
X-Gm-Gg: ASbGncse92M6AEbhT18BsFKGTG6LntDZRagO03LJ4EtmFg9P3hFDyuCH0Sxa3Go6rRl
	dAcGIzvsik72laoQaKQrmgUdhkQBIsGO2BFLfkfTdmCP4dR5STEw4BEY1isoEW54J0QtYm+X2Jt
	BI1JgvRT/3LvOno9+c8GYYR+UKgIww2Dai2GioX6fg1P5penhKgRf+GhnJZ9UU1oXysW63DLOwu
	VncxWtAUtGeg1pCkfzOgNqhKrbUD1AuTGUQ9d6022hTPsLfHF8YRYdiSEAQyQ==
X-Google-Smtp-Source: AGHT+IEIlgP6WJ+l/2b+hOt1ThB2keF29D4lVkLENQbI3An4Y5kJhCuJdkyEWlD4semvJCVerqpc6HGzOCIXOONPLa4=
X-Received: by 2002:a05:6512:3089:b0:55f:6cd0:296b with SMTP id
 2adb3069b0e04-562636d5bfamr3429517e87.49.1757413595663; Tue, 09 Sep 2025
 03:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905085436.95863-1-marco.crivellari@suse.com> <aLsSnKz1WcYSwReG@slm.duckdns.org>
In-Reply-To: <aLsSnKz1WcYSwReG@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:26:24 +0200
X-Gm-Features: Ac12FXwauGyHosDpZYps4rTVqW4xzZiNW4zO0M9zKSVMbGv_zoWndkzkbB081o8
Message-ID: <CAAofZF4-1KypKg_ix642beh-GweMkEiRndrS3mifnUHZG7T0UQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cgroup: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:41=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Sep 05, 2025 at 10:54:34AM +0200, Marco Crivellari wrote:
> ...
> > Marco Crivellari (2):
> >   cgroup: replace use of system_wq with system_percpu_wq
> >   cgroup: WQ_PERCPU added to alloc_workqueue users
>
> Applied to cgroup/for-6.18 with dup para removed from the description of =
the
> second patch.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

