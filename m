Return-Path: <cgroups+bounces-12107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3809C71BE4
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 02:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEC2A4E2907
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 01:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81DB1DE8AE;
	Thu, 20 Nov 2025 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXaUktFV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE0212560;
	Thu, 20 Nov 2025 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603865; cv=none; b=c3zZAKcnf1Wd/UMtG91rzaql/dLMO4CJ2qmOq/Hyi1xKp2VzLwWTcAyZmbWQkGrZEgIOyXE6Kq2/tklcd3sy1FyC5VL9db9FXIbuKcDEiSHNjFKVy+SlaefBAg6Rsf1Kc00/shYPCSgVOIyAXDdXpmh5Q55kU8XiC1+lzOIiOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603865; c=relaxed/simple;
	bh=emvNh39dqdMWGc28WFcwywiBdLMAv+3M234oPctFWtQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nrieR+v4qOzx6l+e9vKp9DkJqRqVy/R13KnTy2wxDhIA5UAtPYuiLeoZCmudk7yWyksMF7QLg1PtYkRfMsgtQdWMwuQ8cZ/+KT4OOpam1ehrI6fO876DoTDAmNK6isiHCVzevPCQ7bjI5c+uhaaSoDe2Fxqh2Fk5vqpwhu9TCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LXaUktFV; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763603857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcMkrulXO7Sxe8rmawaHouDhmls3PgxNDEi2+zBx35A=;
	b=LXaUktFVQQ8v9y7xVbU1PWy4ATwyuWyR1Qo7JNDQqyEolL+fSf7JdPO00fyqTDCsnrwQHy
	v2DG2Jf+oUw6nI1lagl9dbD2c4GVesPUA2MbgwHxxVWnW/uqm5BHB5Gfmn8RLcciV0u6Ds
	D+tRHIzLCdKtihJlUtJYqJy6PPfJgXs=
Date: Thu, 20 Nov 2025 01:57:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <445b0d155b7a3cb84452aa7010669e293e8c37db@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] cgroup: drop preemption_disabled checking
To: "Tejun Heo" <tj@kernel.org>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <aR3paXRgyxdeO4sC@slm.duckdns.org>
References: <20251119111402.153727-1-jiayuan.chen@linux.dev>
 <aR3paXRgyxdeO4sC@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

November 19, 2025 at 23:59, "Tejun Heo" <tj@kernel.org mailto:tj@kernel.o=
rg?to=3D%22Tejun%20Heo%22%20%3Ctj%40kernel.org%3E > wrote:


>=20
>=20Hello,
>=20
>=20On Wed, Nov 19, 2025 at 07:14:01PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> BPF programs do not disable preemption, they only disable migration=
.
> >  Therefore, when running the cgroup_hierarchical_stats selftest, a
> >  warning [1] is generated.
> >=20=20
>=20>  The css_rstat_updated() function is lockless and reentrant, so che=
cking
> >  for disabled preemption is unnecessary (please correct me if I'm wro=
ng).
> >=20
>=20While it won't crash the kernel to schedule while running the functio=
n,
> there are timing considerations here. If the thread which wins the lnod=
e
> competition gets scheduled out, there can be significant unexpected del=
ays
> for others that lost against it. Maybe just update the caller to disabl=
e
> preemption?
>=20
>=20Thanks.
>=20
>=20--=20
>=20tejun
>

Since css_rstat_updated() can be called from BPF where preemption is not
disabled by its framework, we can simply add preempt_disable()/preempt_en=
able()
around the call, like this:

void css_rstat_updated()
{
    preempt_disable();
    __css_rstat_updated();
    preempt_enable();
}

