Return-Path: <cgroups+bounces-11959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA1C5E1C3
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21185423CAA
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7232C33B;
	Fri, 14 Nov 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY3CIVMv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16308325727
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135586; cv=none; b=TR9JdWWkSOkk07hG9UTD0v69jkq7uobR5KWSuDMyyym7g6YH1EL+OnNo8OnL/jglxScoh1Vtn8F7vPulUB6eZlmp6KuN+QodfON0KmA7ZGatoaeFowWNXWL5us7fbuN+v6tio4+XUJykFu/IKlN5mWZvjuPxaReqc2pIN0Th2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135586; c=relaxed/simple;
	bh=psOTZhZgTYwxqtZWM/FnOeE8exu8SAYjW8uXyALaIEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLnPyHRGbV48akdcuhH2Lxli77uBP6kzrjjXwZYtNIFMLtoybyEAsSC5QNacRktckGuN6L4mpd5AXN30iSo3zhzp1KOkBVPKoyjf2ALwA+9cx+c9Dg8zyPjrrv5Ul2vSUHk1bYRErQAZ8xdO+gwujHpMKE9KmxgwSB7Vkp2EnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY3CIVMv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b727f452fffso526533566b.1
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 07:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763135582; x=1763740382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VlPRoWA1WNWSkQNV6PSFUUa4QpcAdRo/Ff/t9LGw90=;
        b=TY3CIVMvcu+JRjhk/ux7m9U5Qjoq1hexft2AwOjYPeyCGIFd8KNG6s+fGwq5OfE24y
         0aMCUSrmQfex5cV7t0QlOqWw7JmSnSLZ0Mg9KZwhTHV3dewUhcYmvMYn3YE+nIwAJaqM
         ODbTlXZqVR0udgFhFBsMo8uIldYqCOLhun15YqZNT1JFghB/+KVbjjVMV2o4BcbN/VlO
         6cQIg2XUPtuFRPeKnFvx4HIfzEpIWytN83hFnJG4xm9Sz0QAxExLZwrTb1+PvnsAoIie
         +x/rdu6lhgJpm6QBW34K+0CZ7L//kxzZ2oUl1KaJegfDODtsE30DR2UGGntF5RDQH+WO
         TA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135582; x=1763740382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VlPRoWA1WNWSkQNV6PSFUUa4QpcAdRo/Ff/t9LGw90=;
        b=MH2M0+ZR0Ce4m9+LTdgK8FsEegFHZ1AtPmVcB+vYAaycHEMc8JczkMIeSTmhbLUTH3
         MgRUWUEnFOGx7NY3q0l+fPqa1hv/uxjrwUN3XSVWC/0sANCUURaAawboJNW/x6KTRsLD
         Vk08Q3D8gNatB+P6CQG1N/qFXgHlqgYuVeY6ALBLgmuhlkddZ56xUmOdFiwNxjQvz6XT
         tH2kQ8nZmUqtJxsAr3rnaEZDbLVWFOuz04P6CLvLU3YuZ3bR709ewQO6n69Dn70FAqfi
         uHBEMTe2By1p4WDzFfMlLxz/W7knS/z2FZ8RyDAwLBiilvFM392BK8ZmQCTzpdmzLlHZ
         T88g==
X-Forwarded-Encrypted: i=1; AJvYcCVGZv5nR+57pYzQ1gENVkAQWusEr+L0e0/adQNPjB+80IZD6AVMYLhqpaK5IO2AS6xaaVUROQKi@vger.kernel.org
X-Gm-Message-State: AOJu0YykyCUgbVlrdzo3lfrdd8HBnuxsnv6dLrnG7t9D4utUdLv4Rzr/
	+xv0Lc1ZQ3dgvHOluyfU9nn8VgHm4PJII1rzho2GCugR7MEgiwu2/yo7tM3azuIQlHZ3bj0lcQD
	rimgxBZzL7Sr4NRw7UXc6bPjIObgCAro=
X-Gm-Gg: ASbGnctXJqWDQ87Zg9wCgtDpQoNXIInofIqz+XArTVb+Lv6q9iiAxIQC4emIQulQzG/
	3BX+s49Z709M7FrqiNwuuwFgFWiy4kUAQNXHg3Urlte1JGGLhC3CF8rbWiFVlC8D+dqHBin3o8d
	3/5b9m3VZterqzf5kNGLpxM/rsLYsW2erhDi6QSJKz1SdMcBUocvPAStaUszFg45MqMokdp7s2b
	gZuO2XoTTLH2NZcuHs36sKuRUsoNrLO7rRFIm27gYQ8k+2/cqmtrdJAKlnbF2s+STRxFZyVg9v8
	YrUnve8d4LWSyUcygEwlAA==
X-Google-Smtp-Source: AGHT+IH+RgS5OmU/N9XmPnLjJ8PJCZ14oqdXi+3jpdUfxqJElWrDxu4B4etnV+rhcTnlU8pk1OFJ4Dj5jFS0Uqbawvw=
X-Received: by 2002:a17:907:6d06:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b7365749f00mr442504766b.7.1763135582162; Fri, 14 Nov 2025
 07:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109124947.1101520-1-youngjun.park@lge.com>
 <20251109124947.1101520-2-youngjun.park@lge.com> <CAMgjq7AomHkGAtpvEt_ZrGK6fLUkWgg0vDGZ0B570QU_oNwRGA@mail.gmail.com>
 <aRXE0ppned4Kprnz@yjaykim-PowerEdge-T330> <aRaAW5G7NDWDu5/D@MiWiFi-R3L-srv>
In-Reply-To: <aRaAW5G7NDWDu5/D@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 14 Nov 2025 23:52:25 +0800
X-Gm-Features: AWmQ_bmvZlTCVtzzPNeqsxwnox4kcDfBHrvuVSpoFgKS95_ykKsOjuSCZG1n81w
Message-ID: <CAMgjq7D=eULiSQzUo6AQ16DUMtL_EQaRSOXGRhMJrUzakvj5Jg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, swap: change back to use each swap device's
 percpu cluster
To: Baoquan He <bhe@redhat.com>, YoungJun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrisl@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:05=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
> On 11/13/25 at 08:45pm, YoungJun Park wrote:
> > On Thu, Nov 13, 2025 at 02:07:59PM +0800, Kairui Song wrote:
> > > On Sun, Nov 9, 2025 at 8:54 PM Youngjun Park <youngjun.park@lge.com> =
wrote:
> > > >
> > > > This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
> > > > allocation fast path").
> > > >
> > > > Because in the newly introduced swap tiers, the global percpu clust=
er
> > > > will cause two issues:
> > > > 1) it will cause caching oscillation in the same order of different=
 si
> > > >    if two different memcg can only be allowed to access different s=
i and
> > > >    both of them are swapping out.
> > > > 2) It can cause priority inversion on swap devices. Imagine a case =
where
> > > >    there are two memcg, say memcg1 and memcg2. Memcg1 can access si=
 A, B
> > > >    and A is higher priority device. While memcg2 can only access si=
 B.
> > > >    Then memcg 2 could write the global percpu cluster with si B, th=
en
> > > >    memcg1 take si B in fast path even though si A is not exhausted.
> > > >
> > > > Hence in order to support swap tier, revert commit 1b7e90020eb7 to =
use
> > > > each swap device's percpu cluster.
> > > >
> > > > Co-developed-by: Baoquan He <bhe@redhat.com>
> > > > Suggested-by: Kairui Song <kasong@tencent.com>
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> > >
> > > Hi Youngjun, Baoquan, Thanks for the work on the percpu cluster thing=
.
> >
> > Hello Kairui,

...

> >
> > Yeah... The rotation rule has indeed changed. I remember the
> > discussion about rotation behavior:
> > https://lore.kernel.org/linux-mm/aPc3lmbJEVTXoV6h@yjaykim-PowerEdge-T33=
0/
> >
> > After that discussion, I've been thinking about the rotation.
> > Currently, the requeue happens after every priority list traversal, and=
 this logic
> > is easily affected by changes.
> > The rotation logic change behavior change is not not mentioned somtimes=
.
> > (as you mentioned in commit 1b7e90020eb7).
> >
> > I'd like to share some ideas and hear your thoughts:
> >
> > 1. Getting rid of the same priority requeue rule
> >    - same priority devices get priority - 1 or + 1 after requeue
> >      (more add or remove as needed to handle any overlapping priority a=
ppropriately)
> >
> > 2. Requeue only when a new cluster is allocated
> >    - Instead of requeueing after every priority list traversal, we
> >      requeue only when a cluster is fully used
> >    - This might have some performance impact, but the rotation behavior
> >      would be similar to the existing one (though slightly different du=
e
> >      to synchronization and logic processing changes)
>
> 2) sounds better to me, and the logic and code change is simpler.
>
> Removing requeue may change behaviour. Swap devices of the same priority
> should be round robin to take.

I agree. We definitely need balancing between devices of the same
priority, cluster based rotation seems good enough.

And I'm thinking if we can have a better rotation mechanism? Maybe
plist isn't the best way to do rotation if we want to minimize the
cost of rotation.

