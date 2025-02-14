Return-Path: <cgroups+bounces-6554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096FAA35B9A
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 11:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0703ABFA0
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E6212D67;
	Fri, 14 Feb 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTTaWTZH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B2204F6E;
	Fri, 14 Feb 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529254; cv=none; b=QI1W1C6kXuCY7/X4PgQJwYwJJn9Bi/wKih48TGquveMclFSbcI+c0ioWTcVmfzMLQU7bwh+L9qtC1QhtY9gQIZj2XXxpvhv0ksSXo6EjSahlyADMFxk25Q22tLgW+e/IYVQRgLWS7eOmjL0DuPt7vHT8MDFSn6M94bArMfEZAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529254; c=relaxed/simple;
	bh=UYaQoR2eZwOXTzWUJHT9U+xmWhzsViwOtBTtbarFxv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edxm07AUZIXG8AkDskl53boXiL6rUlHxP2/3FK9KVjgOxLP806iuvPahnJsjY/aw+p8te9iDEd9fATLRgbKhbLWbPH8xXim6qxBkTprDR5hWoUblf1wEoWpuNT/7qdbPPeCXazWnYqf91WRzd74aTyY5fy4PwP5E05aorsTWHCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTTaWTZH; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-868e368ec74so1190481241.1;
        Fri, 14 Feb 2025 02:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739529252; x=1740134052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYu+TyY7tw77ZtKQFcPGSSlhzeFNYv2jaHPdnFMQUKg=;
        b=QTTaWTZHTV3n4wkUh4o/yI7/P01AtGKs47DsUlE/M9WBtlqzeMHupGLopXUiAB+j0N
         cHRX+nNJWEBo5c/0wqf5U1xGvGrzzr1fqcI4qetVxB7A7Gpz9/V1ck9vPiwcMkhKEGr7
         v51x8wmx7PL3n0DvbgH7CCq9iEA2VG28RyzP7rio7hn1QvC+ScmNFxmff8xcvwkcW2ub
         WL6iiN1wyZnEB/Kcdagr+fUIg3JqQ8j6WFXr4L6PinI2M/0pwmAwNNNkRJ29Ab4uiLMG
         NLGetOwSY0pZwhkGYsSCTUhT5XWMdekRBnGuHSAJckzTEVekWldKM3Pjkfoz9ilzv97o
         C4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739529252; x=1740134052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYu+TyY7tw77ZtKQFcPGSSlhzeFNYv2jaHPdnFMQUKg=;
        b=tfHLgUQcpSDkf97c76Fkn/edTktu97FmquaOxJjCjPO+XhFE3/ZprEG14JDIaq/mBx
         S/ltIAsD06kXqM90mclLrj8055uRereqBRLRtgtUUXkSRyVRv3KawGewWTpM5Vr0Xkcq
         p1M+o8JK1J7CPYvPYDBnW0y5GZnUtkbdESwF+Dcm7ApKBMHkaZQTHg8yHcTAZUyNbY7/
         4U8jp+eEHg4GxUe7YYOakUmKnXL6G/svVgYhitHSqLlMBxtCaBp5Z0uJN6OinfQbQPZ2
         JUfheQ3RzrZi4750tDut9n/AicI6EO6u+tRXnK+0obNGtrr4D73bHNPb6/upCTomGP7Z
         vF/g==
X-Forwarded-Encrypted: i=1; AJvYcCWFxhFvrOpOQr6BFB/AUB1sfFPdoyBMNMghPnvX0xHmA/FDkoXdA3nk6ibA+nE+voKCNQkEchiTi8/vh/nd@vger.kernel.org, AJvYcCX/TV5b6L5Tk05JO/dfdVlbnj30atJ7mOq7WI67oZqCxnlQqQkYASJR+Gbz6JZsnYh5MfzJpJiG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RllPGwU2NnhTvTUbsYfCjcMV46wQOC01H2X/VtB+oBsFN9DA
	aePNr5KUssxBGRsXAGRUDB65dO/dcbuoHwkF9IZ0CA31p3PE5DfEQkVBER9KmWCtUJB5rwveuOO
	CoAsO3gkHJ+Ji4ZNT+Go7MyRr/uYQVlGG9HpbrDS9
X-Gm-Gg: ASbGncu84dI5qh5GRNUP1JzhNsMxzH9azlVpKsU27bbZuAwzSRO+BT8+sOFeRAenQT/
	IR8mabk1wrYfX79Bq8rpBW4eacoezb3ElZDat16WonXoJtffR9E/XJOkdSRBWnY2kXiC9y1o3PQ
	==
X-Google-Smtp-Source: AGHT+IEpYl66M2qVXVyPe+T/b95gbf807eCtOJIC/kgNY3U09rjpT1vLGMt6WSIRkJGbWRchgtERYADWzRDnp3sKKLQ=
X-Received: by 2002:a05:6102:2ad1:b0:4bb:d394:46d7 with SMTP id
 ada2fe7eead31-4bbf20c47c0mr9342650137.6.1739529251957; Fri, 14 Feb 2025
 02:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com> <006c1475-b45f-4339-ab53-0e7be51514af@redhat.com>
In-Reply-To: <006c1475-b45f-4339-ab53-0e7be51514af@redhat.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Fri, 14 Feb 2025 18:34:00 +0800
X-Gm-Features: AWEUYZnBxiWHRvhqqfii8R8iwkMUhBKeL5P_4nVybJY3PRk9p3BgVjHJIdnyIlg
Message-ID: <CA+B+MYQPQ_oD+Kmss1DeBdQ3Qpd4B=wFF1ngEz-aas46oWK4sg@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
To: Waiman Long <llong@redhat.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 11:38=E2=80=AFPM Waiman Long <llong@redhat.com> wro=
te:
>
> On 1/15/25 12:05 AM, Jin Guojie wrote:
> > When running LTP's cpuset_memory_pressure program, the following error =
occurs:
> >
> > (1) Create a cgroup, enable cpuset subsystem, set memory limit, and
> > then set cpuset_memory_pressure to 1
> > (2) In this cgroup, create a process to allocate a large amount of
> > memory and generate pressure counts
> > (3) Set cpuset_memory_pressure to 0
> > (4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
> > current kernel returns a value of 1, so LTP determines it as FAIL
> >
> > V2:
> > * call fmeter_init() when writing 0 to the memory_pressure_enabled
> >
> > Compared with patch v1 [1], this version implements clearer logic.
> >
> > [1] https://lore.kernel.org/cgroups/CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5U=
xGguKep36ZHe6HMQ@mail.gmail.com/T/#u
> >
> > Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > Suggested-by: Waiman Long <longman@redhat.com>
> > ---
> >   kernel/cgroup/cpuset-v1.c | 4 +++-
> >   kernel/cgroup/cpuset.c    | 2 ++
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> > index 25c1d7b77e2f..7520eb31598a 100644
> > --- a/kernel/cgroup/cpuset-v1.c
> > +++ b/kernel/cgroup/cpuset-v1.c
> > @@ -66,7 +66,6 @@ void fmeter_init(struct fmeter *fmp)
> >          fmp->cnt =3D 0;
> >          fmp->val =3D 0;
> >          fmp->time =3D 0;
> > -       spin_lock_init(&fmp->lock);
> >   }
> >
> >   /* Internal meter update - process cnt events and update value */
> > @@ -437,6 +436,9 @@ static int cpuset_write_u64(struct
> > cgroup_subsys_state *css, struct cftype *cft,
> >                  break;
> >          case FILE_MEMORY_PRESSURE_ENABLED:
> >                  cpuset_memory_pressure_enabled =3D !!val;
> > +               if (cpuset_memory_pressure_enabled =3D=3D 0) {
> > +                       fmeter_init(&cs->fmeter);
> > +               }
> Nit: you don't need parentheses when there is only one statement
> underneath "if".
> >                  break;
> >          case FILE_SPREAD_PAGE:
> >                  retval =3D cpuset_update_flag(CS_SPREAD_PAGE, cs, val)=
;
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 0f910c828973..3583c898ff77 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3378,6 +3378,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *pare=
nt_css)
> >
> >          __set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
> >          fmeter_init(&cs->fmeter);
> > +       spin_lock_init(&cs->fmeter.lock);
> >          cs->relax_domain_level =3D -1;
> >          INIT_LIST_HEAD(&cs->remote_sibling);
> >
> > @@ -3650,6 +3651,7 @@ int __init cpuset_init(void)
> >          nodes_setall(top_cpuset.effective_mems);
> >
> >          fmeter_init(&top_cpuset.fmeter);
> > +       spin_lock_init(&top_cpuset.fmeter.lock);
> >          INIT_LIST_HEAD(&remote_children);
> >
> >          BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
> > --
> > 2.34.1
> >
> I just realize that cpuset.memory_pressure_enabled is on root cgroup
> only and affect a global flag that impact the behavior of all the
> existing cpusets. Your current patch will clear the memory pressure data
> in the root cgroup only. The other child cpusets will not be affected
> and will still show existing data. This inconsistency isn't good.
>
> OTOH, I also don't think iterating the whole cpuset hierarchy and
> clearing all the fmeter data is worth the effort given that cgroup v1 is
> in maintenance mode. Perhaps just a simple check to return 0 if
> cpuset.memory_pressure_enabled isn't set like in the v1 patch. I also
> don't think we need to clear the fmeter data in that case as it will
> lead to data clearing only on cpusets where cpuset.memory_pressure is
> read while cpuset.memory_pressure_enabled has been cleared.
>
> Cheers,
> Longman

Hi Waiman,

I understand that your meaning is to avoid clearing the fmeter data.
Based on this idea, I made some modifications based on patch v1.

Instead of writing 0 to the member variables of fmeter, we only need
to return 0 in fmeter_getrate(). The update logic for fmeter data is kept
unchanged, which minimizes the impact on the kernel's current behavior.

The whole patch is greatly simplified as follows.
Please see if this idea is correct, thanks!

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f..14564e91e2b3 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -108,7 +108,7 @@ static int fmeter_getrate(struct fmeter *fmp)
        fmeter_update(fmp);
        val =3D fmp->val;
        spin_unlock(&fmp->lock);
-       return val;
+       return cpuset_memory_pressure_enabled ? val : 0;
}



Jin

