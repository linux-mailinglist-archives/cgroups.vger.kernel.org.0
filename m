Return-Path: <cgroups+bounces-3034-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB668D2832
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 00:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2EF1C24317
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0112613E057;
	Tue, 28 May 2024 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weW/IfQD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CA4437A
	for <cgroups@vger.kernel.org>; Tue, 28 May 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936366; cv=none; b=OdheDOpZZHunNts2gms7tg9PmTE7CcxbOa0g8BbC/CKxWbYou/eyKQXLs0U0jNrHZwporCfXHB6FRdmNDhFXHF4/y+ZQ0b10TAwtmbl4+JGA69WaQ8oKBxX2FLdSm0CNcFt+twF81Q1FdcSoxHyHfe5l9Njuvq4Tw9fz2lZcnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936366; c=relaxed/simple;
	bh=x3eO+xsLGvYH6hdnnKdPPHQw9PwgGh+IMJx8r3KsF7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKCwggcOe+dNL5zkMapUWHQhq5amE3eIc/1k4x/thSvkttpeuPjA+D3R4Vo42uazrHnj8dn3zzEMfzRxsXKH62c3NKO6oFq7K+/a5RYSjPm5+w6PCQLJbE7oZGKQfhkc4b3+FdKvBwA9mjRhUQ8nF7rHuzxOlsEVAZLudJ963Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weW/IfQD; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62a0849f8e5so13667367b3.2
        for <cgroups@vger.kernel.org>; Tue, 28 May 2024 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716936364; x=1717541164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3eO+xsLGvYH6hdnnKdPPHQw9PwgGh+IMJx8r3KsF7A=;
        b=weW/IfQD1s+dFJvVDhmmiKx356BZ1PmgxYYQpLMch8nyUAw3LhU6y3bKpc1MjgeEgI
         oY/iedTHWQTn4P35NJR0ZR/tMDhA3wEeU3ezSyzwyh68xcQ2NxMI6vNNTCmwkwoMq62d
         M+8U6uzATkTNqz+YfNBnpd8KFvoEl3B0Ukg65kknmByUQrG/IBOUyz1rpW4P0vEx6rsw
         2buwlLTAOT5p+6lbqt0E24YtQiBqce4siE9ZIlemuRglje5Y4dZufgdR1JkHNgNNEPAB
         GF4p8Tfd2NhhuUpQAAgyOHi3ZfCDA2ASb3z+joJUYEwhMoeRaty7uyelKerelnJXKlQe
         VVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716936364; x=1717541164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3eO+xsLGvYH6hdnnKdPPHQw9PwgGh+IMJx8r3KsF7A=;
        b=WsdAHXJY/9irxRsLFXRp5Pb7/VYEU09Y/AyWbdzVP4mQl9ha2996YnLNldiY1MWYW4
         o6n10vnTX7+bdeLjyuUylW/6ctRRzjllZeQS+cXfEHddcOsQPmGL75HB8pDBvxwhVGs6
         yzQ/1xOicq9mvpMyb1Ctn6g4N8sltZtcvAoE8FboXI8w/ZGMDjzEAeiCdHIp810JXz07
         qgPA1395j7xr/gaVO/arjl40VUmZzjqrfMcoUXgPQTJsXgZZBvWj5nc7arf3moL1DIu/
         iScM00w7rKUx7bDPWTHnJ9TasdfX/cPY2l591W+MoqtzjO6Vd/Kqq++MqlYI41NoRrvp
         7I4g==
X-Forwarded-Encrypted: i=1; AJvYcCW6LYDzpamOv90lD7g7opquBOctS1bIXBm9U4Ie1rX/OU5o6WdCs+EkmOTtbqUD1bJiLMdoQRk7vsKD/6nwcMDEO1AEdg6ppw==
X-Gm-Message-State: AOJu0Yz7JHeTV7BO7f7I5dxqY01n6o9czC6uAic9Sga8AOcTuP5xGBTA
	4lavmFFegh7pXoy+CipHvSWsEVKD7YbrdsINCIzmKj4IbsK2GQws+gevDjo0A6tt0XWkz6ceg2a
	8gPQIu08p7OLKZGAmz4g34VWsjaO8AS1qVqz5
X-Google-Smtp-Source: AGHT+IG3bkluE1gQLzQW/yXE5rXTcQ0ni1+AICIdU5G38blbecC6K/RPr2rHoicqTJdRS6GN/1aRMHyTcoQS1CrT868=
X-Received: by 2002:a81:6dd0:0:b0:627:dd68:7278 with SMTP id
 00721157ae682-62a08d86f59mr136358967b3.19.1716936364259; Tue, 28 May 2024
 15:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org> <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
 <CABdmKX2vmpFS=j_FoFOadHRVVWaWUsReJYv+dJNHosk1uE_Dvw@mail.gmail.com> <ZlZd2EsF7KOqPx7a@slm.duckdns.org>
In-Reply-To: <ZlZd2EsF7KOqPx7a@slm.duckdns.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 28 May 2024 15:45:52 -0700
Message-ID: <CABdmKX0+rRAHVDmv-A549OxBsyaLcTERYeM52_1ZhiL0-gvTyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:42=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, May 28, 2024 at 03:38:01PM -0700, T.J. Mercier wrote:
> > > > I think it would make sense to introduce something in a similar
> > > > fashion. Can't think of a good name off the top of my head but add =
a
> > > > cgroup. file which lists the controllers in the subtree along with =
the
> > > > number of css's.
> > >
> > > BTW, there is the 'debug' subsys that has (almost) exactly that:
> > > 'debug.csses' -- it's in v1 fashion though so it won't show hierarchi=
cal
> > > sums.
>
> Yeah, something like that but hierarchical and built into cgroup2 interfa=
ce.
> Would that work for your use case?
>
I think so, I'm checking this out now. debug as v1-only and non-stable
interface files doesn't work, but the same sort of thing with a stable
interface on v2 seems like it would.

> Thanks.
>
> --
> tejun

