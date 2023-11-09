Return-Path: <cgroups+bounces-298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CA7E74EC
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 00:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF2281764
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7A374EC;
	Thu,  9 Nov 2023 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/4753Un"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A138DC3;
	Thu,  9 Nov 2023 23:06:33 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A4125;
	Thu,  9 Nov 2023 15:06:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32fb1c35fe0so766575f8f.1;
        Thu, 09 Nov 2023 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699571191; x=1700175991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zofQ/9yNBgfYfGTp+H4jcSd8sqrYUupSTXaCh4BKr8Q=;
        b=K/4753Un1pq1mhrxBWb0zG01JGZmWTGGvm3lh/1X3yUYTDzeZ4hy61KaOgOEKXzCfY
         lYtlfBT6gQXJ7HfrZvCzuJrnOfijf4/NFt07CHliXGyycrJ+sY5ltFVGNNv+AB8vGSLf
         l7sxCCwg84sYXmwmwMZ8u35Yx6UbYnR0icZVWQH5os6qpztWTHyXt2Urtf5iF5SXXir1
         gpOuzPbgaiaeazSPw+74WGHxJoSvvBXihbm2OWCAgI0FfSMUiW6ay0pHP4Fbq3v+RMK5
         +dh9DwmmV+9ciakdkl6KC5V+thPD137vtnKajnR3RHK8ylGRMjpQfB4BqFNsCmlD89gt
         bIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699571191; x=1700175991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zofQ/9yNBgfYfGTp+H4jcSd8sqrYUupSTXaCh4BKr8Q=;
        b=Gs9zogdkYbcPSSeVbLg0uL5uj9l2oawMFTsIRRPWbeX2i8SabURq7rAS/HAEkrEXC2
         AQkZw3nLJv+RLnvMKKK3wpUVntjbekcUDKd0m+v02CME4gjE94fUlQJ4ftDP/uIxZVmD
         RZ++LeL+PEzxi08YUVW4i6xQ+2zbcRh8Gm7+P/++ZoxD2lyx9YfxcSMWEhGUhQW0H0cH
         ZO42IXMrm+65fQ6JVqWlnQOo5I3sD9v9pkZmQqRhv9lb449AGOBglea8ktuuQAoX6QRY
         N7M3JRXsLHTjcQPlYknr8LEZ8pko/YS6JZrMISatUnemZOXZwG1OcqdBDHYqUd0a9lND
         tlMA==
X-Gm-Message-State: AOJu0Yxl36H8DdntPNXk+2Idhc63VRK+BQpGk1V+MF7CkhqUyZxgDiEG
	Z20Poi9b72CKwgHyu7xYew1fMNKtlWXFZWjddGU=
X-Google-Smtp-Source: AGHT+IF806Iryhd6FxW911TzdPClUkqIG6BqNHRL3h31qeDV24YdU3cR5TVaPypv2rbEre2ZI3ODt+xsNNu/6LgkOTo=
X-Received: by 2002:adf:fa4b:0:b0:32f:88d1:218c with SMTP id
 y11-20020adffa4b000000b0032f88d1218cmr4863081wrr.35.1699571191050; Thu, 09
 Nov 2023 15:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-1-laoar.shao@gmail.com> <ZU1Q2CEGwbGNxJNy@slm.duckdns.org>
In-Reply-To: <ZU1Q2CEGwbGNxJNy@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 15:06:19 -0800
Message-ID: <CAADnVQL8qg=jKtR9BE2QgNxYNPVh8XyNLYatZhpik1uFFCUcow@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/11] bpf, cgroup: Add BPF support for
 cgroup1 hierarchy
To: Tejun Heo <tj@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
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

On Thu, Nov 9, 2023 at 1:36=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sun, Oct 29, 2023 at 06:14:27AM +0000, Yafang Shao wrote:
> > - [bpf_]task_get_cgroup1
> >   Acquires the associated cgroup of a task within a specific cgroup1
> >   hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.
> >
> > This new kfunc enables the tracing of tasks within a designated contain=
er
> > or its ancestor cgroup directory in BPF programs. Additionally, it is
> > capable of operating on named cgroups, providing valuable utility for
> > hybrid cgroup mode scenarios.
>
> Sans minor nits, the whole series looks good to me. I can take the cgroup
> prep patches through cgroup tree but it's also fine to route them through
> the bpf tree with the rest of the series. Please let me know how folks wa=
nt
> to route the series once the minor issues are addressed.

Do you think there could be conflicts between cgroup and bpf trees ?
If so, maybe you can push the cgroup patches into the stable branch and pul=
l it
into the main cgroup branch and we'll pull the same branch into bpf-next.
This way all shas will remain and no conflicts during the merge window.

