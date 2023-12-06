Return-Path: <cgroups+bounces-839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C6806559
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 04:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3C2824BC
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 03:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AFC6ADB;
	Wed,  6 Dec 2023 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5YKpf3q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38081BF;
	Tue,  5 Dec 2023 19:01:41 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a934a5b7eso34269716d6.3;
        Tue, 05 Dec 2023 19:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701831701; x=1702436501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHzp2DvnBzo1sR5UNOw4Ef2PKPIR1c9GArQ4WNUU0zQ=;
        b=i5YKpf3q5dcqTqtvJocGvt2cdeKvTT0SddmsQu1eM3FmZUOhdrOOICmCpCHwUC98V1
         Eb08XRvJYTPmdgHOar4ouDFZS1mlAOc1CzvEdlXvDECLFhg9z6903wcvbOugsTb/0Ech
         FD322DPSjKibsZOP2klHUZZ4CrcvxhJvDOiZBpUvZryZhbHLYl1sJMmU2UkAuQ8TMqtO
         ajq43WTfx3qAO50f94MZ/8MX8wfkWBMi6mDfHbgAjjrqjd7tIY0ZpLn7xIgrTm6o4Ueg
         AW8lc03Al7LlNZP48F8pt3m0DPuKKNvMyrk76TxpMOgWQnqjQfpLPeis3Sr73TPA9dOS
         jJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701831701; x=1702436501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHzp2DvnBzo1sR5UNOw4Ef2PKPIR1c9GArQ4WNUU0zQ=;
        b=aSjfKYyuJEVsb9ylMkEoc8Z0t8Qq0XUe1+n8pKV5SKntNIa1dCsjBq5J41Uq4t1fkw
         JGWat9ylK4VXKK/3FzvPZtlX8BqXJkMUAPTQZficiVtHYEqV7R3OqQjCRl7xzp9Lcg63
         lMfUwTliO5kyHZovAciuvR9l8lS5T1lkYQpeD/WsMI5IiBPUCgeRczRWauxUJIHGNKO5
         ndXqt9mCgOHEgpqgrmFWArhnE69INZ1LkvCUpas98SjWYXMDGG5rlw10cVJcTySWFcjR
         z3xLvkEka2j2YGkRaRnyzBzd8VQpKVn3rzpcHPj+ltS+M9lziDB50uJVifSd628hVyv7
         jLRQ==
X-Gm-Message-State: AOJu0YwhMHF6CJ9dq7bvhL+ij9dUFUAQrHCd9odrEA0tert4cAPhnUfg
	IOenc8IuXJax73GMZRE1ZX1/aAsOVw8xE8wgCo0=
X-Google-Smtp-Source: AGHT+IEidTe70SsTpeeoTasABQ0hjQ3ang/WqR9AKVuyphUDxRd1dXut9lBodjaei425AeOa5ZESMRQbBFPoSh8rbjA=
X-Received: by 2002:ad4:5691:0:b0:67a:a721:785d with SMTP id
 bd17-20020ad45691000000b0067aa721785dmr230585qvb.130.1701831701046; Tue, 05
 Dec 2023 19:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205143725.4224-1-laoar.shao@gmail.com> <ZW9aw52vXIQTgq9A@slm.duckdns.org>
 <CAADnVQKNFVnY4QUiuFvb2X+zuFSDiyGUHjfLsxvj8CxYR83JGg@mail.gmail.com>
In-Reply-To: <CAADnVQKNFVnY4QUiuFvb2X+zuFSDiyGUHjfLsxvj8CxYR83JGg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 6 Dec 2023 11:01:05 +0800
Message-ID: <CALOAHbAUHvNWdEYmsjqHwfgnMn5W1TzLx=0e+-aVfRMNOHdPmw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Expand bpf_cgrp_storage to support
 cgroup1 non-attach case
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 10:47=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 5, 2023 at 9:15=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Tue, Dec 05, 2023 at 02:37:22PM +0000, Yafang Shao wrote:
> > > In the current cgroup1 environment, associating operations between a =
cgroup
> > > and applications in a BPF program requires storing a mapping of cgrou=
p_id
> > > to application either in a hash map or maintaining it in userspace.
> > > However, by enabling bpf_cgrp_storage for cgroup1, it becomes possibl=
e to
> > > conveniently store application-specific information in cgroup-local s=
torage
> > > and utilize it within BPF programs. Furthermore, enabling this featur=
e for
> > > cgroup1 involves minor modifications for the non-attach case, streaml=
ining
> > > the process.
> > >
> > > However, when it comes to enabling this functionality for the cgroup1
> > > attach case, it presents challenges. Therefore, the decision is to fo=
cus on
> > > enabling it solely for the cgroup1 non-attach case at present. If
> > > attempting to attach to a cgroup1 fd, the operation will simply fail =
with
> > > the error code -EBADF.
> > >
> > > Yafang Shao (3):
> > >   bpf: Enable bpf_cgrp_storage for cgroup1 non-attach case
> > >   selftests/bpf: Add a new cgroup helper open_classid()
> > >   selftests/bpf: Add selftests for cgroup1 local storage
> >
> > Acked-by: Tejun Heo <tj@kernel.org>
>
>
> Yafang,
> please resubmit without RFC tag, so it can get tested by BPF CI.

will do it.

--=20
Regards
Yafang

