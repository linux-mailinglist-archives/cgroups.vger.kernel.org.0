Return-Path: <cgroups+bounces-7324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FFA79FCE
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 11:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC88F1891229
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253C1F12F2;
	Thu,  3 Apr 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+9V5rZy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0F2CA6;
	Thu,  3 Apr 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671818; cv=none; b=PcEoA7fTjAtDT6C8zHY5Yla8jFi6xN5ma2s1e1ghnnWYSuQZM+iNv7DKlErfNwRHA5TEkn0OzD1yrc8CiHkLgyw7dOKsX3GfT0gRdqXInCD+qJBGOIB6dBPd5wb5MGPovjDi3dmWr5n+RfaG4qlYfYGb/Z1seAcYadcOIxMBgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671818; c=relaxed/simple;
	bh=sl4RKGtIF3Wx8smkosZ2Z9mqMxRoYVSserc8AMAHE/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/3sUjEUdGIEB8Ae9lFk1fyN4Z20VgA58bkewXqzX7efFMuGWWeZqoEa8cp5R/2Jd2M0U25sR3b2gBEO/XHUOAnzZZ3HWlLDW8eWs1cm+FXbrnKrdkTyKTmkZE+PtsR6TISxx2VSw2KQPJWzS7WrLm9ryK7wOqBZG2+tVcSul2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+9V5rZy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30549dacd53so537791a91.1;
        Thu, 03 Apr 2025 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743671817; x=1744276617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sl4RKGtIF3Wx8smkosZ2Z9mqMxRoYVSserc8AMAHE/I=;
        b=S+9V5rZypd92g1eyDtDzAUooqmZfwMk3ELKVX5lncKts+nT2AcJHgv1z+lv+y376hY
         4USnFL9cFdYTnTU5Q4tenVRu3Kwhu0wMUf+B1hFna9mj6AQXPSGtiXuutoo2IPHu0f+9
         AWV41u5wZMpmRgextuSLzjHasmi0cOuTuIPxHKhkXtrpzL3fuG5y/MeeNya5tbddk0Ku
         h4RXcK7UHSYJCERKP7ev+oy50R/meCNq1UDdT/uY1DoH49hA2Wwhkb5m3Ha+dd4QEago
         IfdLKg6KLXclYdABZnYVsLo9K48kMdGSG1p8fAqDQETVy+t1sbF36ARmGeKQVhkEnRHl
         s0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743671817; x=1744276617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl4RKGtIF3Wx8smkosZ2Z9mqMxRoYVSserc8AMAHE/I=;
        b=EtGiXDQ6XhKvqSnstie1GgB5Ka22amEKRXcvdrf5y7vnwUYUNZKKxXX54iLuJK4h3g
         n1Q/wVTFHhUi5XSkUPw01HbuOztoohFiF5tDqoQaPm22bUUc05bdd3wtj0P+NPa9dPpi
         PxwsmNwH5z8q+/gYVKxQG8ud2/nUiWt6gUudO40XBUp+lfGQG5KyKITDMabBz8LiICyZ
         zFQagsSqVaokvyfGaKSCMk0uMoMKX5RwMnZobbBWAnZssCe7WLJp8yWZv5+nccr4aRG4
         W1To1/5v+Mt0QCWccNmzpg8pOSHzMvLtxo1HHlSbZOnPrmgYNICbnTHQksyBoHZMJHYZ
         irxg==
X-Forwarded-Encrypted: i=1; AJvYcCV+P0QIwmF8Tk6dlJewoKXPKItzFLmLNW8a7F/3PubU0BMpp4b+mnINOJI3sCyQ+rsEJd8cB3Uz@vger.kernel.org, AJvYcCW0tP4LozN27ERMvm2B/blomgTMJYB/yQVDny8byBEuZySam1gIgNBfyICGUeVAzL/YsOZx3IRsyymgHhdk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuc9aU2MSR5B4EwhWLoEzsLGb7ndbrrTM45QVYfl6EtkhL0h+s
	vq6mmVCEctAzL1wcJVPkey0Go1QAhygS4/ucAVv5GfSmC6Rohgqf39K5vg+6lmIHEB7XKTldh1r
	Is+pXl8FTNeyCDyy7MM06hiTAxxE=
X-Gm-Gg: ASbGnctvXoALFTbT+mrYLkq118/uKVWDiyKRwrDobegWDzN9F9wJGVVa2FsWE7vKKcJ
	JpEOTvc1izbz1x4Uh6cZ2fsyo4A2JM/oSzfF3YllBiHTWTevbhG0z3wxDnSXEOKTRrn8xyakeof
	9WNDHX8dbYmnApyDGiDLcgUKR8VA==
X-Google-Smtp-Source: AGHT+IHW3xtLpmtp+xLHdFxtdp1Io+v/9JTxu9DwE0nf+jF7/zRfoCM4JVQSGsMmAW+XG4LYtfDNfSFt0Mo0wX+8quw=
X-Received: by 2002:a17:90a:f944:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-3057a5ebbb1mr3748649a91.10.1743671816572; Thu, 03 Apr 2025
 02:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com> <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com> <20250320142846.GG1876369@cmpxchg.org>
 <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p>
 <4lygax4lgpkkmtmpxif6psl7broial2h74lel37faelc3dlsx3@s56hfvqiazgc> <CACSyD1NisD-ZggRz0BaxUdJ9so4j-sKPZi361HJAum3+bHO+tQ@mail.gmail.com>
In-Reply-To: <CACSyD1NisD-ZggRz0BaxUdJ9so4j-sKPZi361HJAum3+bHO+tQ@mail.gmail.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 3 Apr 2025 17:16:45 +0800
X-Gm-Features: AQ5f1Jq4gJ4BRiU4bC5rIWpMztSzrk2KsAJ8ThKe-zAr_EtKDSxBPe0BrSwDPHA
Message-ID: <CAJqJ8ihLfcDROuCjMfoNzOtRRZhVDWEx04ik6cS9NO6hVua0xA@mail.gmail.com>
Subject: Re: [External] Re: [RFC 2/5] memcontrol: add boot option to enable
 memsw account on dfl
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jingxiang Zeng <linuszeng@tencent.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@kernel.org, muchun.song@linux.dev, 
	kasong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 at 15:47, Zhongkun He <hezhongkun.hzk@bytedance.com> wro=
te:
>
> On Wed, Apr 2, 2025 at 9:42=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
> >
> > On Thu, Mar 20, 2025 at 08:33:09AM -0700, Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > However I want us to discuss and decide the semantics of
> > > memsw from scratch rather than adopting v1 semantics.
> >
> > +1
> >
> > > Also we should discuss how memsw and swap limits would interact and
> > > what would be the appropriate default.
> >
> > Besides more complicated implementation, merged memsw won't represent a=
n
> > actual resource.
> >
> > So I'd be interested in use cases (other than "used to it from v1") tha=
t
> > cannot be controlled with separate memory. and swap. limits.
> >
>
> Hi Michal
>
> We encountered an issue, which is also a real use case. With memory offlo=
ading,
> we can move some cold pages to swap. Suppose an application=E2=80=99s pea=
k memory
> usage at certain times is 10GB, while at other times, it exists in a
> combination of
> memory and swap. If we set limits on memory or swap separately, it would =
lack
> flexibility=E2=80=94sometimes it needs 1GB memory + 9GB swap, sometimes 5=
GB
> memory + 5GB swap, or even 10GB memory + 0GB swap. Therefore, we strongly
> hope to use the mem+swap charging method in cgroupv2
>
> >
> > 0.02=E2=82=AC,
> > Michal

Yes, in the container scenario, if swap is enabled on the server and
the customer's
container requires 10GB of memory, we only need to set
memory.memsw.limit_in_bytes=3D10GB, and the kernel can automatically swap o=
ut
part of the business container's memory to swap according to the server's m=
emory
pressure, and it can be fully guaranteed that the customer's container
will not use
more memory because swap is enabled on the server.
>

