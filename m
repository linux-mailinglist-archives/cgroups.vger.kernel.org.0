Return-Path: <cgroups+bounces-1511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6748536BC
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 18:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357E22871ED
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D815FBBF;
	Tue, 13 Feb 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zioZcQgq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B55DF18
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843726; cv=none; b=HIo5wmFaKAmibJWGpGNqi3z2MpKTzDasaWIyZvCm2l3oIr0XED6yi3aC/tSUxVZD3gjitUtj6F0Ox5cv6jtwKinJQznruF32yjlRNJNSfILFb8kTH5CvT086rpuHgMIH5La5DcB6vxlj6hmfAz5SZ2yIQypQYkiB/nbxqKDvB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843726; c=relaxed/simple;
	bh=kFEBmVzCDcc62ul2nmKiFx/x08WUXookmiLkT3RdZO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIzsKKTT6vM4p0kwZc3n6Uw8Nlpyg+ZLbwg+P4mgE7OuEU1Um7NDILuB3PEhn5wV0sTATa5auayy1eTDjZ2cyVpeixTWuftzQmp0b1qiR79kDsZhGqcWYLVJGsmN7v2FbIpYqE4RebXbMs5t7F1J3Ru3IYIcBSNKcElVGtIM6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zioZcQgq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d93b982761so198675ad.0
        for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707843722; x=1708448522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFEBmVzCDcc62ul2nmKiFx/x08WUXookmiLkT3RdZO0=;
        b=zioZcQgq7/WCb6Z/hQB31I/sflRJ/ulSI1vmWzT1VBEJF5MOUay+zZ7jQB8bJkjkMk
         p4IcdQE6x5dOZt9LbGEcGS1kK1Il2t0r5PWpxvLVX3pTKojOWfsIDetMNM6WvS+zB/sa
         /LFfXdkqqFmMtWN5v68nGMXP1RWapNMaVzefWWDeAa/S9585RbPc/W2NDqF8RuQUXiNY
         eOZMnqLgx0Fcex0VZAxZE9oc7lXh1wAE/PbwjEm8sc9EEZ31NrvjkaRMl8b2NRatJdUY
         /d025YhQ/oQp9HiMmDkGtbx9Dq4IdaeYhqmPsxW8yLLzWH2jrvD2/av52h+fn71wCOuj
         cq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843722; x=1708448522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFEBmVzCDcc62ul2nmKiFx/x08WUXookmiLkT3RdZO0=;
        b=GYMIcBE0yY5gwR6taxUjhteo+U18oVovL/0gA6TeUM5v466o4DWhXcQlP1sPpO+EQ/
         nquewPO92XyJ1utrCGxAYS52kJTrfIhoBb764ISIJ0O5U7viCy0hhov3IQNjwL3n2BBG
         TIi7Ou0+POm4FCwKveCu3cETCPtipXzKbcLHaGuFImNCPvcTtmGO1ucA8Avl0lnLRuJP
         mPYkxB4vMoIZwA8Hfx/aBnrKbv+8ELIR9Y2QL97ceId+h/Wpmt/zZ7W9coJ6RA2OsmTV
         EGhdF6ERfq3rtHmz+L2v7KRp0kuzuHxBzVvXdnVeqTuvJIvNR9pEp2cV5p5fQlofUPR6
         BSSA==
X-Forwarded-Encrypted: i=1; AJvYcCWwV3u0EuE+CT0WBWnS3ROhBXw0Ms5ZjFWUqLeINa9Q7rW/0qPcwZFy74cb75NAX0rtG+XQe3G/GyRvK7vbIE1/OJSglBGp6Q==
X-Gm-Message-State: AOJu0Yz39KEhdfUYI3+lGwqtubptC/nmQqLmjEHi3pFhWrA6zyoL/4h0
	OBOWHKANt2dzQMWGn8iYN2ih6Zn+F79nZXYwPnc0Z8Jix5yfDReCjOfsBPqc5/YAp2MN0QX8N7O
	bzJxLDMLzMnKuv/4O4OgQidHBS0GoV3aS/h+2
X-Google-Smtp-Source: AGHT+IFgCqv/XRtoQtQ4/r0rGFzG9aCmFONaMnDDOPnOxPjhaUUFtNH2qle/Tw8GsuonJ5SI6Oo7o2+2OwCK/Zu/4Dc=
X-Received: by 2002:a17:903:33c7:b0:1d8:d90d:c9ae with SMTP id
 kc7-20020a17090333c700b001d8d90dc9aemr20118plb.1.1707843722210; Tue, 13 Feb
 2024 09:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213081634.3652326-1-hannes@cmpxchg.org>
In-Reply-To: <20240213081634.3652326-1-hannes@cmpxchg.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 13 Feb 2024 09:01:48 -0800
Message-ID: <CALvZod7wqfy63cis_v_D_9gpOS=3A2cS5J-LHq0WUrhVQOum8Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: clarify swapaccount=0 deprecation warning
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Jonas_Sch=C3=A4fer?= <jonas@wielicki.name>, 
	Narcis Garcia <debianlists@actiu.net>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:16=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> The swapaccount deprecation warning is throwing false positives. Since
> we deprecated the knob and defaulted to enabling, the only reports
> we've been getting are from folks that set swapaccount=3D1. While this
> is a nice affirmation that always-enabling was the right choice, we
> certainly don't want to warn when users request the supported mode.
>
> Only warn when disabling is requested, and clarify the warning.
>
> Fixes: b25806dcd3d5 ("mm: memcontrol: deprecate swapaccounting=3D0 mode")
> Cc: stable@vger.kernel.org
> Reported-by: "Jonas Sch=C3=A4fer" <jonas@wielicki.name>
> Reported-by: Narcis Garcia <debianlists@actiu.net>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

