Return-Path: <cgroups+bounces-14725-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNOJB75zr2lPZgIAu9opvQ
	(envelope-from <cgroups+bounces-14725-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 02:28:30 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93397243964
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 02:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283A9304F223
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB7A2C0285;
	Tue, 10 Mar 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmcfVpHN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404525C802
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106048; cv=pass; b=hs4hIebDMsVvjBSb0p2nMc1ys1SWiMCozrp9Q3FtiYFbrYTcIYbRO13gsGpPYPT1+Cjet7ZwoQdpZXFMZEuZ9jKU9SXSIZ+DSYETy3hjkPzYVajPo5edXI/rwoHeh9YB7tiTrWaqcUWoZP14zviKpJIpWc6j+0MQjhNsfFGZ2M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106048; c=relaxed/simple;
	bh=1rmvcRevz0F/V74FKEfRsgxWw4Ps6+E7f3yjwH3CaTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umXT0wJiBnZt5SmgilNr5K16UTp8uD+Hai+3tWyUymVEnhkPy25mV750D9Ux4Alp9Cab5599RK3m5cx/ilmqP5d5bxsw90GNMGiLMWZLI6+Lx/i3jq4Euz1vWQQV2qpnArS5WkbzFgPX0VZtIMray3/MS4zx/ls5bhv7gPD5Rb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmcfVpHN; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852af55981so38965e9.0
        for <cgroups@vger.kernel.org>; Mon, 09 Mar 2026 18:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773106045; cv=none;
        d=google.com; s=arc-20240605;
        b=CxPRoVWjv8YqltbUz3GtByK3EMIxmdd/HuQ5ariUArDXS/iLBu/ZpHfRJ4LTM8JdsS
         b1fFKtORzc+Px5hBflu3O0xuS/j8faTITQt3/z4qZENrasQE0bSRJiH9Euj4QXPOn8pU
         iH9QpNdh41Tc0ClDvW7QVFgTacZ2CH6phfXD9SDZqdTM7iy9fNsbETLvpNkrTfznaOeL
         l+ULv/zPvmUp+9zf2mzlrkW+SBFxI/5wzI0G3ZipOA9ZL9YnbgAk+l14xB3sAhhT8Hm7
         RVVt7LCuIZ1bzZWRTskapzyccbnDjUL6Pj0ALKvm2HeeP5W63NW4LNdDhDCmVpRzofWY
         WHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1rmvcRevz0F/V74FKEfRsgxWw4Ps6+E7f3yjwH3CaTE=;
        fh=csmlSyi7QQMBiHNLyqk92Stytdkao9scOgX3sRMgb6E=;
        b=CIsxfOuDsurzpF73LpSTuUmzsyN1+s456Mm0b1E+Ot4vzsddiXTUnLZQOxJl/Lf/FJ
         wBgeVY3Rd10DkXGYXb4WHxCVZ370ORtQKidevwZzawC3VhB15j1sHCER6f0qHs1bxUkp
         dNnb+iVi2PHM5E/lbaRnEOyxjwQ0kVRtY6rj+C4K6tiiF8gST0CEGxwwbl3802uZ1A+v
         FU9wwHzHYulsLu4A6DED+oTzPPBPJS+/2hFGF8mH9aZrYB9J+b2yNVdxsVZrwB9PEtP7
         vzw0cj/TjqOwVkXxW2CosbcWJkDCWsk9ApoaaNQWQVG+tveP5oVE24xy+y3ryS8friU4
         8Rig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773106045; x=1773710845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rmvcRevz0F/V74FKEfRsgxWw4Ps6+E7f3yjwH3CaTE=;
        b=xmcfVpHNwTPEElCS9w8X6ByqmepWtx43QSJMukBCBOR/s7AbUT9VWsAl6EsEo35uK8
         Rn+oHhoUZ1CBQdBSpiw5ORVCjB7bM2Mf4huUgRYpEU8sg3uB4SiM9CWBFGEFO5TOpIhM
         BMJOKZk9fEKxAzJdmuxc0s60yxJiRSnh4RzQqUjo+jJfA2XjtVmTA/JFIJxTUf5dWc3P
         8wTRrIAY4vGbEFE5l9OUQTbForebQMMbYAGhuO5u9l+dSoYeAHozoGEl02DtglgPYYmm
         xuXKtb5K6k2lY6U2ZS7yyipNpIivt/Fky/aoBnigb9OspWqWU83kV4H4uDvuBTw2Ipp4
         zGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773106045; x=1773710845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1rmvcRevz0F/V74FKEfRsgxWw4Ps6+E7f3yjwH3CaTE=;
        b=VR+emEg9t7RW72vKX0W2W09w+gIIfhgxkDuXlNs16nSQw6E9L4tob/swFeRoNOitic
         ZzkKb7bpqqaSO3uVLJOl/x8c1WsVjwH7BkHiXuTfHsnLfODhbAF+MFZMqSkBXlsFBoWb
         MjFjKb6TMO/xqmCFo+7oH4aDZtJ4wBCk4ZRuzb+2o42Bmkc+Ips5xc2LUPLb7LCG5NjH
         +uSvnCiPCENQqZrFlKGPsUCDL8NM76gTEtKHaefUO8Ixl5pa/pMei3jMNUeqDnBe56xN
         Bi4vJTizzvMNWe9TXLWnlwAYAEgBQZxE3aNv+Zf0B3bgk2viVx3z5ZoH0h9pHTF6edTq
         PIjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgMw2vv+RcC4SjxHdKtU3EizMzd2q5I4rNPo3Xs+WLeHAg80G9IVD5maaW+oJVjMcRqYhlRX4K@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiowCclGNuHJM9xGf0V1cVNs4DEoqo0CJl4aD+7AZZaQSM7x+
	Z5yu0rS+7gdK6vVdos2mceoeB8wt6KTcqSKXKfK0IwB6ih01MRZwTg+1yb7Z9GTZALNNz1y8GHn
	6y/RO4qLsiXyh8/I7/PWgR5mlkXW7FP09+wdC2pG9
X-Gm-Gg: ATEYQzy3vgIuf0sueEka6gbvWrEN3arIXB1GhOowzXIWTLEuC6/Oq70YZ3oo+0xwhVD
	lpj4CyL79NS82KNln45XSlEKlLk38KtpaosjjrED2AXSDp/LxJCNSSOoq6RcIaHEK2uVJvh3VPB
	JSHMsZAFbo3+NVDnHOYcC3WNZNWkRV7VqamjtCipTnqDtF3DWqH9kH9VpMw9Y+RZxuYuhpfHqfk
	UbtgybNvi0O9vBTc2Lz51gM0I0it5S+BKRM5MYPyFaj03KwFcvGWupg7phPazXBSKjuVo4bYGda
	Xo8Jyzdn9aiS3Pfuhl2aDvBHQfALgD++dJHVUA==
X-Received: by 2002:a05:600c:13c8:b0:477:2f6f:44db with SMTP id
 5b1f17b1804b1-4854368d6femr153705e9.5.1773106045104; Mon, 09 Mar 2026
 18:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224020854.791201-1-airlied@gmail.com> <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com> <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
 <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com> <aaWuoe_CQwbtcxEY@linux.dev>
 <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com> <CABdmKX0=xPiwXgOHskGkE9Umj5=NrC=7OtngJjrm=mtOZmyzvA@mail.gmail.com>
 <CAPM=9tycvBguhM6r5ytm9S7D608iZDthHgfY=hxUvSjXLqsZAA@mail.gmail.com>
In-Reply-To: <CAPM=9tycvBguhM6r5ytm9S7D608iZDthHgfY=hxUvSjXLqsZAA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 9 Mar 2026 18:27:13 -0700
X-Gm-Features: AaiRm51xuqeNyPrj5mGzN2VQM1J4cEY6yKs6zyCliUqXeYhrDfMad-qcie1Nw4s
Message-ID: <CABdmKX30DEuGnT+zQQCAG2qqdU4wp0MOaDQ-qwR5jg5t5oWXnw@mail.gmail.com>
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: Dave Airlie <airlied@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 93397243964
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14725-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 7:20=E2=80=AFPM Dave Airlie <airlied@gmail.com> wrot=
e:
>
> > Independent of all of that, memcg doesn't really work well for this
> > because it's shared memory that can only be attributed to a single
> > memcg, and the most common allocator (gralloc) is in a separate
> > process and memcg than the processes using the buffers (camera,
> > YouTube, etc.). I had a few patches that transferred the ownership of
> > buffers to a new memcg when they were sent via Binder, but this used
> > the memcg v1 charge moving functionality which is now gone because it
> > was so complicated. But that only works if there is one user that
> > should be charged for the buffer anyway. What if it is shared by
> > multiple applications and services?
> >
>
> Usually there is a user intent behind the action that causes the
> memory allocation, i.e. user opens camera app, user runs instagram
> which opens camera, and uses GPU filters etc.
>
> The charge should be to the application or cgroup that causes the
> intent, if multiple applications/services are sharing a buffer, what
> is the intent behind how that happens, is there a limit on how to make
> more of those shared buffers get allocated, what drives that etc.
>
> If there are truly internal memory allocations like evictions or
> underlying shared pages tables then maybe we don't have to account
> those to a specific application, but we really want to make sure a
> user intentionally cannot cause an application to consume more memory,
> so at least for Android I'd try and tie it to user actions and account
> to that process.

Hi Dave,

Yeah this is why I pursued charge transfer. Most of the time I think
we'd be ok just charging the initial allocating application, but a
separate allocator process in a different memcg actually performs the
allocation ioctl, so the allocator process, not the application, gets
charged for it. Without charge transfer functionality in memcg, all
the charge ends up in gralloc's memcg and that doesn't work for
applying limits to applications.

There are some kernel-driven allocations, which I'm only aware of in
drivers. These are by far the minority, so I don't think accounting
them separately or not at all creates a significant gap.

> On desktop Linux, I would say firefox or gtk apps are the intended
> users of any compositor allocated buffers (not that we really have
> those now I don't think).
>
> if there are caches of allocations that should also be tied into
> cgroups, so memory pressure can reclaim them.
>
> Dave.

