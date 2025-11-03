Return-Path: <cgroups+bounces-11518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA8C2C1C4
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AF13B6486
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADC270575;
	Mon,  3 Nov 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIfc0l6k"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549526FA4B
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176596; cv=none; b=efeuXDdy4pHW6kbTYi9x4pk7LlFnjAeqLomXfN9AU/fJxHXNpZF/QF1iXUfsLxn3ZDfGbwsY7mM6hyyWRIsnRLjtWpBEy905hoovY61jhhQG4sNh5phOEG4lrTTeR/sE+V7XU/bCqhQ8UOoZBBbO5XRKfAMoN6wwOmfDTIz2GZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176596; c=relaxed/simple;
	bh=3P4uhXaD5ilvYs+a4RtrwVqLA5w/zngN8+yS2F+4lkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJWm1XH5uylpJQ7v33ic9N5ng1XHMD+plirswRINIBx6JFYOHluC1LoprtkBVlSG3nwt4w3NDrEsDJVHDy6H1W6Hr4pI098CB5Q3NomJspfAE9GuR+LR3Llnk50GEAe0zFTgzrePrQouZm7jGySvC7agC813l+NyJB6Vh7ivoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIfc0l6k; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso1611643a12.2
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 05:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176593; x=1762781393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=iIfc0l6k9iNQArxxX2qbTR4pYsdaNIZ+O0bZS+XBE8EwQROeAVrFCu2U6PBIjIhraX
         suZNP2HKkCrkhFRfJVo9pyOplIYGW7dcmUuqnY9c40lEekzqbtTY4i73leXVc8hl4+jE
         ZWGuzBP6tGg8MH0wbbwhE09bM1bGXHolSrhfM1prGDB9cyYHmiQ0l86NMY9N9e22F752
         ccz127Qgm/Zwcw4gYj9gylM3DpNnvguc4OeZElaIjAP9QE6YuQMj3CCTOmjmIvcXW2At
         4esTOikzxDAhxUICWw0ISVF7OFAeqdFTaNPpF0fHIOFA39W8YGD9CwZ0m5QUbAAdpKLC
         f7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176593; x=1762781393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=AoPpZz/eDD33ZeyFFQd1aHKnakDH1XSYBvkB196+aev1jeBjh6CPkfSFZs6ux+1w84
         hb+IFD2z9Q0wb3npaq3QTXCF1iSkuTan4XR1NlpjcS1Trx3fwSTUUV8Laj14oorQ23Sr
         mZ0xPoBFud+9NwlKh5a/4bw/pHwXFf5ZxF/m4tweDTlPF4cU5hQOla0i4dstdwVmqjHK
         Y9uTf69s+I97b4yG8tmU/xMjknExHuJbkwNr9pnMZrVNncKBsc9ycFjcQ7r6IdsDesa1
         7jVnqSKiJP650tE3Y2KsO+Ro7bJDq5ijaK3gkl1acpfZmPwvodAEHAx+6gO2Ee0PglX3
         YNEw==
X-Forwarded-Encrypted: i=1; AJvYcCUg5ut2qmY3GM+SqoXQF81rINFTsujyQpAyz+jG0ifTJncnBzli5KWbR6uqzQBFvo0cBj5R3EuA@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbDa7PnQPMiYib5mL4dSczvwzj3ErS3/D6S4UXjCLuqp7hZz9
	/aXUS34Kng9uWhxgVxPft3kFPxT62/gi4iReTMFDPvaoG5ojKYKFofzONJVBRPWk8MEeqE4k8sy
	rV/hMGdiL0aejmYyS4vK1Ntm2LJinu+4=
X-Gm-Gg: ASbGnctcJ7JODOEM3ZvtaNls4Y4y7tW3aprjGhPyWCcqr3COG6PGfj6u3nn7QhyOcRs
	l5vi9EG1lq1bJzaUOX1dvlQVc1GT1bUb9+2jMmii7KehnCP0IBeVuskUOEI2mkmTN+qN4lk6yOI
	4qGgYu9sxr9tZEZZa2LBGTh6usiZYxkVeJRjNpKMIl9uvMJ6cgxHzr5eSfYFv6EFi15xMPRaHyc
	zDHDoAJP00obD8QHv9ew3Tss598WcbHgx0T1ULB2ZaeCYZEaei+Phvsuvwv50dlWf2Dpd3lcyLd
	Xhsrbn902HIUB9JULn6494NbozM9r5yrBlwJaSQG
X-Google-Smtp-Source: AGHT+IGWyTZduHZ2AUQOMuHAUDSKDxSYh2Boylo//kHY7uALzcMyPCHh3aobLMS0sfZ3SBLE+RqIGbSBBaWJY8VJe/k=
X-Received: by 2002:a05:6402:5108:b0:640:aa67:2933 with SMTP id
 4fb4d7f45d1cf-640aa672a40mr5173930a12.21.1762176592344; Mon, 03 Nov 2025
 05:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Nov 2025 14:29:40 +0100
X-Gm-Features: AWmQ_bmz-aFyM_2e0ocdnrdFR9IUaRm9-CuMDUtbkHwY8CVjQjk6nDFhXg5Zzks
Message-ID: <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] credentials guards: the easy cases
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 12:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This converts all users of override_creds() to rely on credentials
> guards. Leave all those that do the prepare_creds() + modify creds +
> override_creds() dance alone for now. Some of them qualify for their own
> variant.

Nice!

What about with_ovl_creator_cred()/scoped_with_ovl_creator_cred()?
Is there any reason not to do it as well?

I can try to clear some time for this cleanup.

For this series, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (16):
>       cred: add {scoped_}with_creds() guards
>       aio: use credential guards
>       backing-file: use credential guards for reads
>       backing-file: use credential guards for writes
>       backing-file: use credential guards for splice read
>       backing-file: use credential guards for splice write
>       backing-file: use credential guards for mmap
>       binfmt_misc: use credential guards
>       erofs: use credential guards
>       nfs: use credential guards in nfs_local_call_read()
>       nfs: use credential guards in nfs_local_call_write()
>       nfs: use credential guards in nfs_idmap_get_key()
>       smb: use credential guards in cifs_get_spnego_key()
>       act: use credential guards in acct_write_process()
>       cgroup: use credential guards in cgroup_attach_permissions()
>       net/dns_resolver: use credential guards in dns_query()
>
>  fs/aio.c                     |   6 +-
>  fs/backing-file.c            | 147 ++++++++++++++++++++++---------------=
------
>  fs/binfmt_misc.c             |   7 +--
>  fs/erofs/fileio.c            |   6 +-
>  fs/nfs/localio.c             |  59 +++++++++--------
>  fs/nfs/nfs4idmap.c           |   7 +--
>  fs/smb/client/cifs_spnego.c  |   6 +-
>  include/linux/cred.h         |  12 ++--
>  kernel/acct.c                |   6 +-
>  kernel/cgroup/cgroup.c       |  10 ++-
>  net/dns_resolver/dns_query.c |   6 +-
>  11 files changed, 133 insertions(+), 139 deletions(-)
> ---
> base-commit: fea79c89ff947a69a55fed5ce86a70840e6d719c
> change-id: 20251103-work-creds-guards-simple-619ef2200d22
>
>

