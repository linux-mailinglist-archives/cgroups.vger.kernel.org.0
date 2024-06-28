Return-Path: <cgroups+bounces-3458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CD591C8FB
	for <lists+cgroups@lfdr.de>; Sat, 29 Jun 2024 00:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01C11C21DE3
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 22:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1A7CF16;
	Fri, 28 Jun 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cq3jLC09"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C95381A
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612940; cv=none; b=paIVrvngYIAOXy60/A/sltMD2UvbcAlkPHPGOHnM5khJa7FvcfWZpQGeHYIC3MFO4U15oAdrQrx2jMS8L+2mMVt5IHhHbX5gcVB8JbEydm2k79+JhTw6ijUBz0mxuCcvyr4sO7+QeZnv34gbVn0dM+PkRrOh/VvYGSKsiUNmiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612940; c=relaxed/simple;
	bh=+FljSmn4Grrsg7NrcyiPVuMjCR2+pSwHRt+HFRG+zT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC5DuYoUCa20seDDDeRuj1psEPP6haUW5S1ZGkXq4xo926DpqPxPJEaX3F7FxHoAXkEGcOfQS5/hhLtefpqZbOoFTXFzAyMoNUOFrBuvR7BrT7u3hHWWviKR0WjGRrwrDsmc4G8GwUelYMqPhpTDbHHmyFttNrD4wItWmizkeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cq3jLC09; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424acfff613so10983855e9.0
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719612937; x=1720217737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnG8rg72r8ffPCSx11YhZAxAKEur5ua59dSNQgnuQfA=;
        b=Cq3jLC09UtyKLnGcVX4c53Ue6g8SoQHXBHCkQvybiarAlvmwimL4Ug4wCRoVrDZ0gS
         xP6iMpvY0z7b4CACMLQ/4om+feeFZIm1Vl7x4X5pYZSBIfGc3c/54sqwKvqDbo6RNvF3
         KoAs1MLZHZdZzrN3Wf6c6sGwAzAx87JjDLPOlzoTTncjFcnmjG+kSQcxcqiPjV777H86
         re1GpyUZACSEwFGO784mAnK/TQ21vkqilwy2vf9B3vIcfGue69T0/A1vjAUvcb1Gek4T
         Nh03HtKhqN/fAZMym48VsmiSG7y4UZ+PqQEZpK3iAudDw2gkYNvjKkUHsQW7vix2Sq7c
         Dwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719612937; x=1720217737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnG8rg72r8ffPCSx11YhZAxAKEur5ua59dSNQgnuQfA=;
        b=FKVLiQvhShDczwbcYSblPJMKEAg7ZNlnEchXNwL3WNl24usvkIqeoUA+xRQyaedCjB
         uhE197/z7RWqSrwvl2wH4qItXZEjpR7I3sNnRYd2Uonfp0QKzmf49aOzb/ZDTwQpMpxu
         uDnOLob8OCpM/tFU/WHD24DGz3s16qvskr3rfNSFgZHjMtm2A+znJVOTdhFH23Wtd5tw
         F8mxSND6IJrEPSCcMA7vm0fZKO5qDMLFkOZzxotsaWHnNv1Y0tJMHhfxj8C8ZCIy2KOR
         ZLFO7lWdIhWzU+X8dUONvWa1F8TVwUbARGJONV6PD33+DvwDOZSu453eds9BgtNchALV
         wdNA==
X-Forwarded-Encrypted: i=1; AJvYcCUnenUzDkxoDa4IewbmKUnQhMprHTDMHXy0bboqtMmsUtgLDvUA9OsX3VEZ/NrVXszd3fLACeYQ/XVYfeO1rtvgNU2+NDN3LA==
X-Gm-Message-State: AOJu0YxBc1LSZpZ8dhQm3Xvhjp7r2jAIy5HnVle6lSsKZYMX1cZMAPoH
	1JjxnR5NbVyCF4uDrTB1+vDEOM+aytqpUOXJsfBVwpGA/8y6z3gtzkbu/zR1cB/KU7q8otGOhkm
	F0gSj3HmAvlLnf6BiLm0mp1UlM1/DpzuId4vo
X-Google-Smtp-Source: AGHT+IECZerCUyDd0NywEbdAnhdWpLjgakOOtsegyVbF35KWlN7IkS8C++spqmKiKCk2AqXQhz4EyJIPc8mgKKGXDw8=
X-Received: by 2002:adf:b1d1:0:b0:362:ff67:272f with SMTP id
 ffacd0b85a97d-366e94db3e5mr14589349f8f.41.1719612936743; Fri, 28 Jun 2024
 15:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75> <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org>
In-Reply-To: <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 28 Jun 2024 15:15:00 -0700
Message-ID: <CAJD7tkaybPFoM697dtp0CiEJ2zmSYiH2+0yL+KG_LD=ZiscOJA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> >> +    /* Obtained lock, record this cgrp as the ongoing flusher */
> >> +    if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> >
> > Can the above condition will ever be false?
> >
>
> Yes, I think so, because I realized that cgroup_rstat_flush_locked() can
> release/"yield" the lock.  Thus, other CPUs/threads have a chance to
> call cgroup_rstat_flush, and try to become the "ongoing-flusher".

Right, there may actually be multiple ongoing flushers. I am now
wondering if it would be better if we drop cgrp_rstat_ongoing_flusher
completely, add a per-cgroup under_flush boolean/flag, and have the
cgroup iterate its parents here to check if any of them is under_flush
and wait for it instead.

Yes, we have to add parent iteration here, but I think it may be fine
because the flush path is already expensive. This will allow us to
detect if any ongoing flush is overlapping with us, not just the one
that happened to update cgrp_rstat_ongoing_flusher first.

WDYT?

