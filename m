Return-Path: <cgroups+bounces-305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C47E779C
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 03:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F712817DC
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 02:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435707EB;
	Fri, 10 Nov 2023 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXyWUrQ1"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8915A8;
	Fri, 10 Nov 2023 02:37:53 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412062715;
	Thu,  9 Nov 2023 18:37:53 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d134a019cso10224136d6.3;
        Thu, 09 Nov 2023 18:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699583872; x=1700188672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtsyDPNjJDmvA4PUfzNmZv/BEK8N+SaVMjw+0eu5eSE=;
        b=IXyWUrQ1J6Bv/FCme4vGrhn+X4zS+xkAQU5S/BTyxQUklqD/SeUmWmrcUI/E6BS5Tq
         2WPgSbmU9Y7m9sqdNyOahNIZE6kpL2aDqc/4aNrqPejUAzX0GIz1+c9D/1yxBpGVsiJq
         I4lvfXgHDkVuF40bisJ09ZbG9uyQ4R6ZHKX7mKkFfBpF65WrscxhsVWBjc5lAuXMMcOM
         JWdD3RCEjBNKLthYvuVoYhmfY9G8CdONXXoG0Lj7aLiHQ7vCsSV8BG10x4FlhewTjaiT
         IfNMsDccWRabu6HIep76mTouiNTjQ/dE6wre+m8NT1nbsqWqEMpZ+m6Nq3xK2KNe6kXQ
         rWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583872; x=1700188672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtsyDPNjJDmvA4PUfzNmZv/BEK8N+SaVMjw+0eu5eSE=;
        b=r6WlxXWsdy/P8fdi2KU70+9+lD26ho/DCRuG5HH45gYwRdl+3P1HQHtEB+eSA5ZPZ1
         f42XkpOyBta4wePrIQTS3cfJ4OCE+/1s6RstwLHVzN6XWbl0oFhUnQFfY6Jg8T0fzBDv
         Tgio8coYvQ9EogMolmJwmKpo6lJzbCPyrbad7wNvxzYVBfj7EaZ7hUfzScTmalAJRUOV
         iEiWEu2dxnu0gDSOQX931shmm8/BiHDE8U1ggOtPEan3qvU2Cn12IMwLPZw5uXPrepOK
         /ZssaQhcVSHmPOd1qe1tJjWHR9Q3rOjiFb7KCSEntLspUMdWBew2Bw1HeCr+oIX9fxaQ
         EUDg==
X-Gm-Message-State: AOJu0Yz8LSt9T/RQzTcTLwmFEmTLZDAuH6DVJ2PXHNynht4JFHy09b+I
	WCKD1YUxVzBaO5x4XXGVF5ARH/w3/FCWXHENi38=
X-Google-Smtp-Source: AGHT+IHvga2Fw/5Wax2pZ3UKXDwyoQhotsko3+vT+BLRejWfaAQquJATJ8a78VEMQbsYYmneVd6QAlihJHsLwl2HAkg=
X-Received: by 2002:ad4:5ae7:0:b0:66d:3f8b:fd93 with SMTP id
 c7-20020ad45ae7000000b0066d3f8bfd93mr9589296qvh.2.1699583872339; Thu, 09 Nov
 2023 18:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-1-laoar.shao@gmail.com> <20231029061438.4215-6-laoar.shao@gmail.com>
 <ZU1riY0lCI3YkAqg@slm.duckdns.org>
In-Reply-To: <ZU1riY0lCI3YkAqg@slm.duckdns.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 10 Nov 2023 10:37:16 +0800
Message-ID: <CALOAHbCVp5d=DZn-=F_JXpr9UE_Kp1OJxVY2xaOd-OfXgK7R6A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] cgroup: Add a new helper for cgroup1 hierarchy
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com, 
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 7:30=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> The following is the version updated to use irqsave/restore applied to
> cgroup/for-6.8-bpf.
>

Thanks for your update and also thanks for the suggestion from Hou.

> [...]

--=20
Regards
Yafang

