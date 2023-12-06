Return-Path: <cgroups+bounces-838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15759806541
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 03:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A3528229A
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 02:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFB1C11;
	Wed,  6 Dec 2023 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4DbNyf5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB18129;
	Tue,  5 Dec 2023 18:47:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3332f1512e8so249168f8f.2;
        Tue, 05 Dec 2023 18:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701830835; x=1702435635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDOPnlvTXdrIxLdriKyS17DeqnShqjvBefuV/BT+57c=;
        b=h4DbNyf5oQ2yHFnD1r0i4HxfNvnefzG5yWkrQ3RMnovRJ6jBNVxR0HIKikPycbRMOa
         MOsj+LuChDHhrjMkGEvHV/WVWNoKBsrwR4hIm23nDNafLRzfQEmiaVhs1KtoTelSGEft
         pTFRNBa03Fd94qr3brcHpzlFx/tIJkNB+PKq8olXZwZpVprCjp9NxfK3Fpc5WgAz9sr8
         xyYdVPAbLE5Ihz7zR1o7O4NztRqfos6C4OlwBF8EjrsFXmS1bjWpw5ncsPneObuS0bnE
         TP68S63yRZPakiZ52hhquQqZAo124446PZPlDp5Wkgbr4Ded6LcPbg4Q8FJP05UTGcF4
         Sw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701830835; x=1702435635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDOPnlvTXdrIxLdriKyS17DeqnShqjvBefuV/BT+57c=;
        b=p9Rc7X8lqOeU+xPuHTL+jUVA2OsFeVGf2KTE5+W40gVxGbdZMv2HrCosiD3bmspihf
         AyvTA4Tx/Q86X4UKg48AAoJ4bMwiMCBW6c2tavjbNhnPC2WhTIShOQyJdwTg4YaGv2/H
         yC5hwNKixNLSOeYf01lBPE7JWEOEhhn3AmUj4AqLZGb2xWUxY3KCTzgOPgC6hB+jRGNr
         yH7nkWSpSoMOa+2wyAzhh+ZbXvX2QrgqNeE44H0runivbODuC3Jg7hzEVCHuCWcnmbAL
         rlB3NJFbhOzXPikO7X09jhFcMiaW7mM520VhtN4YDoirf5ggJnxizTLsRiRXjV5h/HT7
         uo4A==
X-Gm-Message-State: AOJu0YxMl0eKI95b404vIk9iRTukvxzzRwpdHtJXDQjgHVIQ8hH8IODS
	5lhHJm4iVRhDK4Eg0q2pnRa7QZfl5EyHDnN0RUxr6nFe
X-Google-Smtp-Source: AGHT+IEZVIWWyBnJBMjUZe+Aq3VEIaAX4Y19maRc+pFR8oHgv3LP8I2irP7IWJ/8yvbn8wisn//UpPyqvaxZZQgZzcY=
X-Received: by 2002:a05:6000:104c:b0:333:381d:6a26 with SMTP id
 c12-20020a056000104c00b00333381d6a26mr61809wrx.135.1701830834558; Tue, 05 Dec
 2023 18:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205143725.4224-1-laoar.shao@gmail.com> <ZW9aw52vXIQTgq9A@slm.duckdns.org>
In-Reply-To: <ZW9aw52vXIQTgq9A@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Dec 2023 18:47:02 -0800
Message-ID: <CAADnVQKNFVnY4QUiuFvb2X+zuFSDiyGUHjfLsxvj8CxYR83JGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Expand bpf_cgrp_storage to support
 cgroup1 non-attach case
To: Tejun Heo <tj@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 9:15=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Dec 05, 2023 at 02:37:22PM +0000, Yafang Shao wrote:
> > In the current cgroup1 environment, associating operations between a cg=
roup
> > and applications in a BPF program requires storing a mapping of cgroup_=
id
> > to application either in a hash map or maintaining it in userspace.
> > However, by enabling bpf_cgrp_storage for cgroup1, it becomes possible =
to
> > conveniently store application-specific information in cgroup-local sto=
rage
> > and utilize it within BPF programs. Furthermore, enabling this feature =
for
> > cgroup1 involves minor modifications for the non-attach case, streamlin=
ing
> > the process.
> >
> > However, when it comes to enabling this functionality for the cgroup1
> > attach case, it presents challenges. Therefore, the decision is to focu=
s on
> > enabling it solely for the cgroup1 non-attach case at present. If
> > attempting to attach to a cgroup1 fd, the operation will simply fail wi=
th
> > the error code -EBADF.
> >
> > Yafang Shao (3):
> >   bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
> >   selftests/bpf: Add a new cgroup helper open_classid()
> >   selftests/bpf: Add selftests for cgroup1 local storage
>
> Acked-by: Tejun Heo <tj@kernel.org>


Yafang,
please resubmit without RFC tag, so it can get tested by BPF CI.

