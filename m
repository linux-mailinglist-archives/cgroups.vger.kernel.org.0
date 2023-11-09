Return-Path: <cgroups+bounces-301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5A7E7531
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 00:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4442BB20BDB
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30238FAF;
	Thu,  9 Nov 2023 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpPhi9jb"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7B1DA3F;
	Thu,  9 Nov 2023 23:35:28 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C74482;
	Thu,  9 Nov 2023 15:35:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d9d8284abso852130f8f.3;
        Thu, 09 Nov 2023 15:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699572926; x=1700177726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHWMe1o0RlJBL8J/x2rpkF16/HliGuSo/KIazqpBt9Y=;
        b=BpPhi9jbYgxjMtIfMFKnKwNyL9CJ6hrKBFCy5yxbPooYa3yKLXiCWzKYN7rqX8rsAH
         cveJ0pnpTg95ydcL9DP7h3yqoS+R++4duWLmErej2KSy+YBu9g8rOw6VP0Jn+lN8n9ls
         9z19kvbfqPEBSQ0uMAK+zd09W+5XdyvE/Hu66lonu9aWNherFPOBN5GL0dENv7BD4QyV
         4IveEY3MnFwm1NIw46eUdlLA3ItPJUhlSBbjqY+7ysHzbrlSUf38L1QsqmjMFeNtUpeO
         HOg5nwtoo/3GpcDpIpetlI93ZAiRFLLXWzTUXvhX4nzrFgC6iowgGwGLUOLebdvdYEj1
         7BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572926; x=1700177726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHWMe1o0RlJBL8J/x2rpkF16/HliGuSo/KIazqpBt9Y=;
        b=XWvBD36riZdncApXMGiOtMFKjjH3bnI4MUaHAL6Ey/oU5h7dKDWFnVcW7akwJWMW5E
         vjnsBkFuX9laKBZlYejVDGqj6rCYYRya/vsuOuDQZHPPPXrMNb1DoxkQNogRm8JUZE2I
         ShTrlAEfhPAsi7PqY0pzAmP4cPa3jEggy0DJpTm/f16Ugh5xwxn/brbz9vNmqAhSK/qU
         mpINuJ59muvkeh0HwmLENvlAe3/yGfA0HnVWltUzU75zLphfioAWUVuHS1J7k1dWUOj0
         H5nlFxMZaPshODIMhW4kdIjCI4nd8YOnTJ7egmrL8F3XmcQGbGYjnrNYvTOjroF4N2n6
         Ew7g==
X-Gm-Message-State: AOJu0YxYe9HqO/DN3dg5PImP12NnwBiyHIzKW+5UFBzya3n4AqGzhSYP
	DuSipHDn/Jm/Y6nfCy0LvkF8YWLgGgfpbEeTEK4=
X-Google-Smtp-Source: AGHT+IGs1kUoTOmshD4HbsEYnwd4q7Y4N+JVr7XaCSOMCBQuNFqqR8KEhsPUzSR9gxkm7EMTxDay8gSWtLpsod6Q97Y=
X-Received: by 2002:adf:d1c7:0:b0:32c:d0e0:3e70 with SMTP id
 b7-20020adfd1c7000000b0032cd0e03e70mr5391048wrd.56.1699572926074; Thu, 09 Nov
 2023 15:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-1-laoar.shao@gmail.com> <ZU1rLOMUJQOGXti5@slm.duckdns.org>
In-Reply-To: <ZU1rLOMUJQOGXti5@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 15:35:15 -0800
Message-ID: <CAADnVQJfEWkMhyqt5msd-GsuuEFONQPnhHjB7s2zKw0eAWv4sg@mail.gmail.com>
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

On Thu, Nov 9, 2023 at 3:28=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> Applied 1-5 to cgroup/for-6.8-bpf. The last patch is updated to use
> irqsave/restore. Will post the updated version as a reply to the original
> patch.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.8-bpf
>
> Alexei, please feel free to pull from the branch. It's stable and will al=
so
> be included as a part of cgroup/for-6.8.

Perfect. Thanks.
Will probably pull it either tomorrow or on Monday/Tuesday.

