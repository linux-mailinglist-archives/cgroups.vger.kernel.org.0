Return-Path: <cgroups+bounces-14523-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBGzB+jmpWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14523-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:37:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295E1DEE01
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5673051842
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F447D95E;
	Mon,  2 Mar 2026 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBnxZ3/r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F247D943
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480152; cv=pass; b=fRqOBQ27G+i+jQObkcyF+z/khYsaKFdObHe0gLuCQAxUDvJEIK+lOmO43ca3j39YMEoNbi0v8rp7jqqxfpJmFBsogpKgL79GB4xTCKBtD0E3Wo2e+HC5jPcXlPcrbeto+AvHXOG4JFI3ohEd1sa/Ww4iie8Ujv6bk40VZUyQ0qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480152; c=relaxed/simple;
	bh=BY6y+PcOr2weOd72FiZeoQi95+Yc0oAk8sWZFR4JOsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1GQ8sb9VutGJw3RQeVeTYkam36I7pI7lizb09Swz3TWffQ4fcWwNAqzX7nkvaagrYQS7SI4jiodJOrpma0wHp0ATatwnTzTf8cC/xvn7acsgqXmG77JX16XgQtMrDdT50ofDjg8ov01NDVl/chGp2SVi/WGnkSNRiTnRTTqgFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBnxZ3/r; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48318d08ec2so9225e9.1
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:35:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772480149; cv=none;
        d=google.com; s=arc-20240605;
        b=OZc7SExlU0sswrBpC9JwHO1xKsfkvI2ysB+8CDIMWi0m58chaW5/c6GoHDZUMKKzpG
         nh4yKyn+9AKn+IYBZkoHFfIJzntBJIvaclcBz7AzzJLEckxG+OxyZrMUZd6OmgZzzenU
         7k5wSdxrM9eepvJOofyKBxAirj0b5FXuMAFtLHrqoh15EwSfxxxMMvQGpDCou6oLwymU
         AuZ6mS4TLu9XlkPb0ovZtMdTPTCjkgxqPqZm8/FpRVqPE1rN0psoGVZGBkGMclzYk6WQ
         9bUXn9Kpf9dPyW6mbE0bTV41eT3nNNdy5Y3gcKsng/s6dbmgdsLGUqA1PYw0wHx8Hnjo
         U72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BY6y+PcOr2weOd72FiZeoQi95+Yc0oAk8sWZFR4JOsM=;
        fh=LcJYM4DaKceNEuuNsO1GFUGGGIImGO7ZVMKurU/4WhM=;
        b=g7ZJ1ctwcEJyUyW1TEeO02IAkMJWcZ5z+slndCix5CyDFawolEo7mt8RZIvwzTn7ED
         giHZun0PELeicuvY3OKiq5b2kzSFCoKyNeAvoirBmS+6PYf9ynoWR5anYS3Zy7sUQned
         D1eiPjodBv5y8Qb9+PQ+GUlGaKUfgh5p/cX9rJYaycngv2J+nbv7TM22EXBvxem+07/R
         xANu7h7wEP1fv2Yva15JAA1E+ALoqvQq2hBDZPj2fMsOUdO6DVjGwBPb7BEyVuoiDaRR
         gQ3u6fbTqU/1JPOAeD6QxQLYLXKDra1FzM6jOf0NeLn+D02ChRaCOsFU4X5X900slXIy
         1ebw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772480149; x=1773084949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY6y+PcOr2weOd72FiZeoQi95+Yc0oAk8sWZFR4JOsM=;
        b=DBnxZ3/rFaSfL/lCffy7wWaryju2XtGti5UX/XDHGy2wqkNO20JfPhpQVb6s379uDv
         sr44uP81NBJK+Vz5IiAMbSkw0xdjwAwlDVQHj86YjWi6G6coZRo0CQ8N41cmbwyIKKQx
         NZ3OotGscn+aH83VGtVmTKsv1I5sNENIFVrxIPU65N6wt68WztzL6wyJI+hZweQNMfdj
         Y1DVpwgBzJ3IuviICoPn1nMCKO3LKPRY4+hT1R2ZT5X35bEz5ER7h3qOkeeLnDXIYosw
         CNUlO4GZeCnr+YmUb/09Uyi3OmitBH/oLRWApCxlr/14EhoswdaAZOiJ3Y0a46B+nMK/
         n+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480149; x=1773084949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BY6y+PcOr2weOd72FiZeoQi95+Yc0oAk8sWZFR4JOsM=;
        b=CUGJbyWnDBw2b26GbstaiKLvPNYU02X4KiAx5LJRL+812F31Lc+QahTC5924n/PpTZ
         MzxcxEsIHUv88cSv++u27Da5MqwnzNrYAtpvOLcE99yiVP1Qjl98+XBQJHALgaBzMK1Y
         l/Q0pgIFCKy5dfKkNAJJI4ErQoWUyQ+Z9fV0Fqb7A7MxPcurLzqwjbTkdcuzGrLfNtg+
         jvHmjYYA9ZU32ZMhHSZ8POVZ9C6o4LzwH7rfVPj9hcHNTOuGDsGvTlGlzutFRqTYVgli
         7z0sC0aUBJdvTU9uzAX/yj4vh9R7eIOWHaqirTWoUwjcHLSyriqAqwbm450wAxKwQtg6
         nGLw==
X-Forwarded-Encrypted: i=1; AJvYcCVD7BKyUxrbb/8E5FrG11c6Byn+jSb4/DpQ0aUCvECr6RbmEGadFZAe81JhK3ACJob8iN3u4vAQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYowc4XMzt8FQuYL8MBt2VP/MkM2+fxgZ3zel09HRqlBOhZQp
	2261EfT2Jt69hQcNwwTDY0jbB2i3vvrJOrto8zVBmo0sLXoqMelHrPPb86MRVNG5R4WK5kyBjVF
	LiOpZlmyRM5gRBzWl5cXNLSmyMaDmTeTJVkI4MosW
X-Gm-Gg: ATEYQzyYw2IaSXn/IIxvQBtS9x7zU+MjyiUd6avpIY1DCEueF9vO1SXRj23XAPwb92v
	C9JsY/iJREeQTed+pWcR3LAuZ/rZxocIeGwdsE21FcZWwT0mxUsRK9A7B5/+aMyH3z0ANwN22CG
	cOjAXr4je2Y+olHOVO7EtwnhCOGAseMTwK2BwD4CMrq9xADhgW5c6lVSEtBJYC5PEf3qm1flfcY
	2HWpxuKGQd4aCIlX5ruxXndzdy8f1gRwrp2UUNU6bWgmADHTC3q+xlH0FOjjXm0pfOluKALA4HH
	hLj6iDBPd+fifaDhAWiGFSxuhuWHKTRDY9NCMg==
X-Received: by 2002:a05:600c:b4d:b0:47b:deb9:15ca with SMTP id
 5b1f17b1804b1-483d0606017mr1472655e9.3.1772480148894; Mon, 02 Mar 2026
 11:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224020854.791201-1-airlied@gmail.com> <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com> <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
 <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com> <aaWuoe_CQwbtcxEY@linux.dev> <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com>
In-Reply-To: <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 2 Mar 2026 11:35:36 -0800
X-Gm-Features: AaiRm51KCL2nDutxmU7MXZZE-iw_Km39J2t5ovf3bUQsdBZPTuZ8g_DowZvUqgk
Message-ID: <CABdmKX0=xPiwXgOHskGkE9Umj5=NrC=7OtngJjrm=mtOZmyzvA@mail.gmail.com>
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Dave Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9295E1DEE01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14523-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,lists.freedesktop.org,kernel.org,cmpxchg.org,vger.kernel.org,fromorbit.com,redhat.com,ffwll.ch,google.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[android.com:url,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 7:51=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 3/2/26 16:40, Shakeel Butt wrote:
> > +TJ
> >
> > On Mon, Mar 02, 2026 at 03:37:37PM +0100, Christian K=C3=B6nig wrote:
> >> On 3/2/26 15:15, Shakeel Butt wrote:
> >>> On Wed, Feb 25, 2026 at 10:09:55AM +0100, Christian K=C3=B6nig wrote:
> >>>> On 2/24/26 20:28, Dave Airlie wrote:
> >>> [...]
> >>>>
> >>>>> This has been a pain in the ass for desktop for years, and I'd like=
 to
> >>>>> fix it, the HPC use case if purely a driver for me doing the work.
> >>>>
> >>>> Wait a second. How does accounting to cgroups help with that in any =
way?
> >>>>
> >>>> The last time I looked into this problem the OOM killer worked based=
 on the per task_struct stats which couldn't be influenced this way.
> >>>>
> >>>
> >>> It depends on the context of the oom-killer. If the oom-killer is tri=
ggered due
> >>> to memcg limits then only the processes in the scope of the memcg wil=
l be
> >>> targetted by the oom-killer. With the specific setting, the oom-kille=
r can kill
> >>> all the processes in the target memcg.
> >>>
> >>> However nowadays the userspace oom-killer is preferred over the kerne=
l
> >>> oom-killer due to flexibility and configurability. Userspace oom-kill=
ers like
> >>> systmd-oomd, Android's LMKD or fb-oomd are being used in containerize=
d
> >>> environments. Such oom-killers looks at memcg stats and hiding someth=
ing
> >>> something from memcg i.e. not charging to memcg will hide such usage =
from these
> >>> oom-killers.
> >>
> >> Well exactly that's the problem. Android's oom killer is *not* using m=
emcg exactly because of this inflexibility.
> >
> > Are you sure Android's oom killer is not using memcg? From what I see i=
n the
> > documentation [1], it requires memcg.

LMKD used to use memcg v1 for memory.pressure_level, but that has been
replaced by PSI which is now the default configuration. I deprecated
all configurations with memcg v1 dependencies in January. We plan to
remove the memcg v1 support from LMKD when the 5.10 and 5.15 kernels
reach EOL.

> My bad, I should have been wording that better.
>
> The Android OOM killer is not using memcg for tracking GPU memory allocat=
ions, because memcg doesn't have proper support for tracking shared buffers=
.
>
> In other words GPU memory allocations are shared by design and it is the =
norm that the process which is using it is not the process which has alloca=
ted it.
>
> What we would need (as a start) to handle all of this with memcg would be=
 to accounted the resources to the process which referenced it and not the =
one which allocated it.
>
> I can give a full list of requirements which would be needed by cgroups t=
o cover all the different use cases, but it basically means tons of extra c=
omplexity.

Yeah this is right. We usually prioritize fast kills rather than
picking the biggest offender though. Application state (foreground /
background) is the primary selector, however LMKD does have a mode
(kill_heaviest_task) where it will pick the largest task within a
group of apps sharing the same application state. For this it uses RSS
from /proc/<pid>/statm, and (prepare to avert your eyes) a new and out
of tree interface in procfs for accounting dmabufs used by a process.
It tracks FD references and map references as they come and go, and
only counts any buffer once for a process regardless of the number and
type of references a process has to the same buffer. I dislike it
greatly.

My original intention was to use the dmabuf BPF iterator we added to
scan maps and FDs of a process for dmabufs on demand. Very simple and
pretty fast in BPF. This wouldn't support high watermark tracking, so
I was forced into doing something else for per-process accounting. To
be fair, the HWM tracking has detected a few application bugs where
4GB of system memory was inadvertently consumed by dmabufs.

The BPF iterator is currently used to support accounting of buffers
not visible in userspace (dmabuf_dump / libdmabufinfo) and it's a nice
improvement for that over the old sysfs interface. I hope to replace
the slow scanning of procfs for dmabufs in libdmabufinfo with BPF
programs that use the dmabuf iterator, but that's not a priority for
this year.

Independent of all of that, memcg doesn't really work well for this
because it's shared memory that can only be attributed to a single
memcg, and the most common allocator (gralloc) is in a separate
process and memcg than the processes using the buffers (camera,
YouTube, etc.). I had a few patches that transferred the ownership of
buffers to a new memcg when they were sent via Binder, but this used
the memcg v1 charge moving functionality which is now gone because it
was so complicated. But that only works if there is one user that
should be charged for the buffer anyway. What if it is shared by
multiple applications and services?

> Regards,
> Christian.
>
> >
> > [1] https://source.android.com/docs/core/perf/lmkd
> >
> >>
> >> See the multiple iterations we already had on that topic. Even includi=
ng reverting already upstream uAPI.
> >>
> >> The latest incarnation is that BPF is used for this task on Android.
> >>
> >> Regards,
> >> Christian.
>

