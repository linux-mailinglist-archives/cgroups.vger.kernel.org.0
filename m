Return-Path: <cgroups+bounces-326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA47E7DF9
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1E81C20A95
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92691DFE5;
	Fri, 10 Nov 2023 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJh01of8"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E763B4;
	Fri, 10 Nov 2023 17:05:25 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B17431C1;
	Fri, 10 Nov 2023 09:05:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so1435462f8f.0;
        Fri, 10 Nov 2023 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699635922; x=1700240722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF4hfRre5ZLXHPViGMBkoodu/q24AHzQL/CZl8uDkxs=;
        b=ZJh01of8yTyws9wOYMLY1SEWHL4XCFNpgVXipXIwZ3wMmW7IRGLj0K1SRMVxQgd9cn
         mHGgLZew1RkzrjzF48QIupzAk49rtZ1peNOu/pSfhmT6iSzMl+9uwOtgFDyAVAausP17
         YvkT/S6bi5JKFShKTs/bHEsyHb6etmXsH6+zcb76p2op/KAh5qFvQ247R5XCVKaD5sOb
         nQJi2J+nr8+PXdmnx7L4fzFvVnpEdSc3fziUHLyB/t32k0gqbfRL6BWoqR6E1VF6YMXB
         Thu6zKKJIMvGeZOc9F/JBka/cIcl6l6oOHWW8RcsM+aeLE5nG2LuSmYVUpdzMszXKUwi
         nNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635922; x=1700240722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF4hfRre5ZLXHPViGMBkoodu/q24AHzQL/CZl8uDkxs=;
        b=EotoJjjrgz/5ZR7Chpu/2NCTA/fPsRt9TJ0WOh2mYzkfpvQ3CxqPKfOG+ck3ZJinxR
         DKlU2vBy531colzlMZRot6UDqqdZDoCyb6Fh2ELlUQa1CWHwBFzsl/cihtJ/hJ74tp0h
         HgeXz469QkO6Adsg0kJveIUSxSvRf/Xo+Cxx2+bpzY/rdsujBUGGgqHsRLqTBR55kY5v
         wsjzIN2TYiVf+2W12/++rxJdXtBwFcaHtISou5HUPLVrnCosRKV2GGLglDbaUKk4ru8N
         MKZy0MgTC1hUmgqnYHbQY7idFEtIdQRlMo1rCOV6P6acpVnwj90s6ZYtVEbnnSr78opG
         Qg4Q==
X-Gm-Message-State: AOJu0YyE87K+ZhNUhOFqYxRM6Z0OtGQE4wMjsJK0vAQQQAJaudKh1RDx
	jE7zS4aAUhLc8oonhsbylZsRYz3ug1NxBv94gnc=
X-Google-Smtp-Source: AGHT+IF58EG5oeO+Wg2hVcP53XwK5+M7sDO8HQW3FB+J3l4kL2Q08XmjVsuV5TY+0AjcroYDlM+5j7d044XkWVv1T3I=
X-Received: by 2002:adf:e589:0:b0:32d:bae7:6ab4 with SMTP id
 l9-20020adfe589000000b0032dbae76ab4mr6023630wrm.64.1699635921681; Fri, 10 Nov
 2023 09:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-1-laoar.shao@gmail.com> <ZU1rLOMUJQOGXti5@slm.duckdns.org>
 <CAADnVQJfEWkMhyqt5msd-GsuuEFONQPnhHjB7s2zKw0eAWv4sg@mail.gmail.com> <CALOAHbAM86EaU=7FeKJ+B1vGxGX7oXMm4fDUgEVTAePKFDTrTg@mail.gmail.com>
In-Reply-To: <CALOAHbAM86EaU=7FeKJ+B1vGxGX7oXMm4fDUgEVTAePKFDTrTg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Nov 2023 09:05:10 -0800
Message-ID: <CAADnVQ+vJU=21yQ15W-o0R1zxCURXenKP7F1PMcKdLSh_kaxtg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/11] bpf, cgroup: Add BPF support for
 cgroup1 hierarchy
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Waiman Long <longman@redhat.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 10:05=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Fri, Nov 10, 2023 at 7:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 3:28=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > Applied 1-5 to cgroup/for-6.8-bpf. The last patch is updated to use
> > > irqsave/restore. Will post the updated version as a reply to the orig=
inal
> > > patch.
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.8=
-bpf
> > >
> > > Alexei, please feel free to pull from the branch. It's stable and wil=
l also
> > > be included as a part of cgroup/for-6.8.
> >
> > Perfect. Thanks.
> > Will probably pull it either tomorrow or on Monday/Tuesday.
>
> will send a new version for the other parts after you pull it.

Pulled into bpf-next.

