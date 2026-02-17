Return-Path: <cgroups+bounces-13980-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CHMFx/BlGkwHgIAu9opvQ
	(envelope-from <cgroups+bounces-13980-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:27:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FF14FA24
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BFF93045269
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5F374735;
	Tue, 17 Feb 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZWOGmP3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55F2C326B
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356441; cv=pass; b=MaIO1QsXOobucu81dgyPOevEg4vnT80vxYcN4YMIBIxGG3F7rR+cN5pRmYRKr0IQqsVHul1V84zuxks6a4vGnpMo2oVOkU1TcWUrfZAI54JYZrEuAG9LQmZQz5lSH767Csv1MIR3jkTv6UW5NBrN5oGtnVFsapnoi8c9cdwW3WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356441; c=relaxed/simple;
	bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIQtiLJGgbb43u+W/TAluR041J4kKrKwue1C8Iej+IqbHGKRj0xArakxUhLUWo/6uasl18cIyedtUCZ56kbXq5pTBuWdtDPBWFyhuQjs4fSAmIhc2TfHRyJRWhR18XzVktaMtEY3Q2Wkvzz82rCpB+pkiKshV5Orjqk2D7obyp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZWOGmP3; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so10295e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 11:27:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356439; cv=none;
        d=google.com; s=arc-20240605;
        b=Ic7boM16BFaIE5t94EjT6VoWSuaSXyVIGg5Mfiw6WbGkkYuHlhqatSv41M2ZM0iCRd
         SkdzZV8bjoBOW+cnRKCyECn6iUkkNDoiuDeI21MnrPX+s9MxxLxVSuPk3SqdaUr3CbbK
         K9PoazAUq9LtNDW68JnilNRxTyOTFzdmPfO+R7BmExA8GbEsM6a/0qxjjKvpv4WGteNS
         mSQveaucZaQDLUdyzH0AgQKMQdkO3V1cIY2pkzA8RbFmQMXx2L0yyCi4kK7HpNRTZ5xc
         zVod1Et4LavptrhfNYn/eEdCG7DxsQ/pOpcXAx1PuWc4X68wXEpWj3++LkDCGIzV0OXI
         VxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
        fh=s3AqUdX18RY2QJY1MFMc8Rv553DuRMoa4dc3kvq02i4=;
        b=fiEEL7pyyIgSWhm61mmtVzRJeJLhWNsJZSUv0JAztO3LxVAZipHZxzZ4nZMl4gww0C
         BlfzZdSunz5zUJkKkRBGu6MlFkNbmCFA39S6+IEFg8Xpx9UXdZZR/hM9t/NFg+beYiba
         vdkHoh2hTZC882HBjKi2qgTjxE4o5WrbtSU3xZK44YZE1yXU+9MZ9LEPnS3HUhaMuc6N
         UyMCNTsw5t+uVFYLCwv8i3am3HSedq12Kqp9rG+9euQi0FvlKg516uT/DdN6JYumoJR3
         YmAjPqyW/G1+p/LK+spGd/ULh8fUbGbqmjI5rl1m95/j/DZOUnJ++x7hcQIGRAw38hUk
         DKdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771356439; x=1771961239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
        b=2ZWOGmP3Lks6UZsCdh+O+V8lVRxDhQpbLt6FhmKX4Vox7lhbzmE/f0e5knQY11MGnr
         McXwwPJf0Bz8n+ocHbfniiksJHF5I0MYkpQu5Tq0YXLdlE41Bn7/NabFQrucua+ua5SD
         nfn37jYWvS7reusTwJMEWRIMFrprr8GP9voIyHJimwmPHT5JUNfViIj+xLV8Er+2M50/
         qWF64ZJR7/VHbzCaK9JruS4li3JI1NFvoADt9viV/z0xCkpUkjbQWYC9chnttXLp/on0
         +I3j0hNqasfMDo2Icmauz1pHc0eDRHLAMgn3GKXurk9CVmnTpqmq+xXkSfP5SuzRGlo2
         KmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356439; x=1771961239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dq9lt5zbMKjIwe07vDjwIvMn4UEVRRKcGgcDEnoQxOM=;
        b=QNXUkLnAfVMJytMinlWSgRFLoRJ5c2aIh6SqDGyi/0GWQ4H3mj1K8wQ9nIHLKK7RNx
         TulZQm7+OmJVtB/Jj6MLTSCxu2w/AagnkhujRrD9KUelMv0BomENEprFpJYaKO7RtPjq
         QgUKWJTRlVmdVsFqCShHI053a4ZWyQdzLZPnfyorXva2JdHlOknScwNQI3Y0TZreoHw2
         q/6ErijpoF4trgcutXMVUwsUYzlIZ2rF+gFwcvCmCEC8oeDgk/DPcFmq6tjzS9jFHKG0
         GOFvdlcse5nv1mM3mmIa8CVDuElDlt+wym+60xypdC0uEnu6Rwot6QpYBQbR+SCecVvv
         YgzA==
X-Forwarded-Encrypted: i=1; AJvYcCXRsHOAvFUlJZ9T/j/af4HUsBxrd+wU9x6hfVGw6x/1KFCwVkqcLWw3scySvmV4wwgi4VRssIjU@vger.kernel.org
X-Gm-Message-State: AOJu0YzClLVz+M2mP+p45wHmRtKAdyqLZFzrpF0kiwIJXqO8Vkf4l/05
	PB/vrA/I8VZo/Pmg082g9SObBmprFIEKe/YAuwUdgHrfymH/BYPjt20ECq/vvh0frsGVleVd4LW
	rj/chQww4vIFAa+YrWnOL7feqNCOwHOjo3Qq7+0Mo
X-Gm-Gg: AZuq6aJh6S/kRa55/SNloCQBPEH+EQ7efGRLasOXYe5mhCOEazNRovNsAf/IFHCCyp/
	r/o4kvHMTwXmHLZokIjlGt/mjFBEzzbe2lh0bAoaYA8/BCCAJR1NqR7mVSK84KCA61ZKFompiVF
	5iB+0cZPvbsQj8dbh1i+QUujNB7KxlVtoZLgzqjUTtDSp9TDLfpUeyKzowO4YsSbBeMhEN2+uxv
	mVPZZ3mnwzgZiKE5ViWXHPAOW/+pGowkIzZEhDShmw0gXErK7/MPGlGbp4o0YPYlCX7PJcmV22B
	D90irR0dBCqIhtoG3wlRL/JQ/1Hcnv4UoSchQml2UXvOR0juOz9oNPOL8PM0dufmzPnaag==
X-Received: by 2002:a05:600c:4796:b0:477:95a8:3803 with SMTP id
 5b1f17b1804b1-483888567damr911935e9.13.1771356438652; Tue, 17 Feb 2026
 11:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129191034.3181412-1-tjmercier@google.com>
 <CABdmKX3rhV-Kn7fMg689Yo2M3f88xS5BxK+5R6G0-rEx9thBOA@mail.gmail.com> <xlebwk6u4a2uwxzexxwnhwldjtgcd5gl3srtciujayegoucweq@gx5ny36x3pu4>
In-Reply-To: <xlebwk6u4a2uwxzexxwnhwldjtgcd5gl3srtciujayegoucweq@gx5ny36x3pu4>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 11:27:06 -0800
X-Gm-Features: AaiRm53kYc0yFXkgJH_rl_IPVquZJsQt9DvtiwyTxn5fYzJdJ-aJEIuW6kYWF8g
Message-ID: <CABdmKX0zB=AnGBpGZGnHWGr2qHK=JpYoMVVVO2VexDXiBLWoTg@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] cgroup: Fix kernfs_node UAF in css_free_rwork_fn
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: stable@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, hawk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13980-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: D01FF14FA24
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:14=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jan 29, 2026 at 11:11:48AM -0800, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > On Thu, Jan 29, 2026 at 11:10=E2=80=AFAM T.J. Mercier <tjmercier@google=
.com> wrote:
> > >
> > > This fix patch is not upstream, and is applicable only to kernels 6.1=
0
> > > (where the cgroup_rstat_lock tracepoint was added) through 6.15 after
> > > which commit 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> > > subsystem") reordered cgroup_rstat_flush as part of a new feature
> > > addition and inadvertently fixed this UAF.
> >
> > I am proposing we apply this one-off patch to stable rather than
> > backporting 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> > subsystem") and its fixes to 6.12.y.
>
> That's a performance optimization rework, IMO too big for stable.
>
> For the conservative stable-specific fixup:
>
> Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>
>
> Thanks!

I forgot to thank you for your ack. So thanks Michal. :)

-T.J.

