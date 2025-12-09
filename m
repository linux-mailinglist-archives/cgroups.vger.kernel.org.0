Return-Path: <cgroups+bounces-12304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D8CAEA86
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 02:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 832E13010610
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225EE3009FC;
	Tue,  9 Dec 2025 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xi2n69Nh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A679222580
	for <cgroups@vger.kernel.org>; Tue,  9 Dec 2025 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765245029; cv=none; b=sYw2n+2ghUdlFQ8GA9VhC9Fr9FGP6CTk/SOw4Y72qVCB0tjJtq2UH8w7RpLVyHdKPztLn9mkc36+0vrF9A9MSBjCQVb4NSNcBbrO5vYVnyVL6MysEsou95NoKb7hz6PmxeM49kN674rOMh6G1MPhX0HoRLQq9kyOAuopq/h01g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765245029; c=relaxed/simple;
	bh=kxfMIuOKyfe8bmObUhS5t43dMnDHqQLX9eXqaAzAfm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpddwloEx1r2rcpVOV8YKP4f6XZKdA5ujZ/Laz+iSju+00Vy5GNa766fOFsxRueb9JhBg6saiF1qfir/QOimggn4nMGuywGqWVKOAWveF9+lHFvzvcz9kYtur1/PGw8r0Hb1p3rmcHhlpqVzeDV1ME62qV/V89431nZDfuQrfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xi2n69Nh; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765245016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxfMIuOKyfe8bmObUhS5t43dMnDHqQLX9eXqaAzAfm4=;
	b=xi2n69NhA9UUpc69ygoXYVKF83VuBUmVTPKU3Yp4M00JtdFEZBtQP2alKZOjckFkjX106J
	2g2gQp7o7exkpimIsJzGs61RKtYjg+HdvdP6wxRjlhVI9m8fCBo+26EY6PnU6INl3ocnm9
	YXxlgfy6p/LkmEa9rJ8VqKmWUNuyvvA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: hui.zhu@linux.dev
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  "Alexei Starovoitov" <ast@kernel.org>,
  "Suren Baghdasaryan" <surenb@google.com>,  "Michal Hocko"
 <mhocko@kernel.org>,  "Shakeel Butt" <shakeel.butt@linux.dev>,  "Johannes
 Weiner" <hannes@cmpxchg.org>,  "Andrii Nakryiko" <andrii@kernel.org>,  "JP
 Kobryn" <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  "Martin KaFai Lau"
 <martin.lau@kernel.org>,  "Song Liu" <song@kernel.org>,  "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>,  "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH v2 21/23] sched: psi: implement bpf_psi_create_trigger()
  kfunc
In-Reply-To: <1d9a162605a3f32ac215430131f7745488deaa34@linux.dev> (hui zhu's
	message of "Mon, 08 Dec 2025 08:49:34 +0000")
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
	<20251027232206.473085-11-roman.gushchin@linux.dev>
	<1d9a162605a3f32ac215430131f7745488deaa34@linux.dev>
Date: Mon, 08 Dec 2025 17:49:22 -0800
Message-ID: <87cy4otof1.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

hui.zhu@linux.dev writes:

> 2025=E5=B9=B410=E6=9C=8828=E6=97=A5 07:22, "Roman Gushchin" <roman.gushch=
in@linux.dev
> mailto:roman.gushchin@linux.dev?to=3D%22Roman%20Gushchin%22%20%3Croman.gu=
shchin%40linux.dev%3E
>> =E5=86=99=E5=88=B0:
>
>
>>=20
>> Implement a new bpf_psi_create_trigger() BPF kfunc, which allows
>> to create new PSI triggers and attach them to cgroups or be
>> system-wide.
>>=20
>> Created triggers will exist until the struct ops is loaded and
>> if they are attached to a cgroup until the cgroup exists.
>>=20
>> Due to a limitation of 5 arguments, the resource type and the "full"
>> bit are squeezed into a single u32.
>>=20
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Hi Roman,
>
> I wrote an eBPF program attempting to use bpf_psi struct ops and
> bpf_psi_create_trigger to continuously receive memory-related PSI
> events, but I only received one event.
>
> Looking at the code implementation, when an event occurs:
> if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
>
> However, in eBPF there appears to be no way to call the equivalent
> of this code from psi_trigger_poll:
> if (cmpxchg(&t->event, 1, 0) =3D=3D 1)
> to reset the event back to 0.
>
> Would it be possible to add an additional BPF helper function to
> handle this? Without a way to acknowledge/reset the event flag,
> the trigger only fires once and cannot be reused for continuous
> monitoring.

Hi Hui,

Good point. I'll add something in v3, which I'm working on, if I'm going
to preserve the bpf psi infrastructure in the current form. An
alternative approach suggested by Tejun was to use a simple tracepoint
and implement the rest in BPF - something I'm exploring right now.

Thanks!

