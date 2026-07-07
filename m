Return-Path: <cgroups+bounces-17568-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NeiqHmxxTWqN0AEAu9opvQ
	(envelope-from <cgroups+bounces-17568-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 23:36:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FA71FCC3
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 23:36:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mJsOeSIE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17568-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17568-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC9BC3014859
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B9430301;
	Tue,  7 Jul 2026 21:36:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FC4252C0
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 21:36:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460199; cv=none; b=IFPaQvJwiCfZSjNjsobMZB6OwlM/LJGE28wWvwRUR22VOfhvJ0jd5BF+GYC6nkfAWZLqOwkjKoIkcGAqEp5euwMTHNtDSJBhmvz71SeFri9rl5RpZCIVnOlMPLFByBI91XVj+DF7xTqC28+n00080aaYXzBI01n7KqEHJjDM8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460199; c=relaxed/simple;
	bh=mfvgbak40ISEAt+FEvvSkwOEo6xkg00TCiXxZ1jMDFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiQHtr6r9WyiUB51ArlNoa7zWMbYaRE8XRPBZmhYCwj8aNZ//OXNa1JNLH0sg6rWeRaNyaFMWfMhqclDoxMtX66vT7OtpuAOw9NqHFldDPjkZH6GydUQPVttvJUDLH1+SRE5FnyyDR3twDfwviA6Q8/3yW77+J2d5P/TWBISk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJsOeSIE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7921F000E9
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783460198;
	bh=mfvgbak40ISEAt+FEvvSkwOEo6xkg00TCiXxZ1jMDFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mJsOeSIEeV2UmBonPeaqEf7COTUt8n6mdPtwegRTmR9V2CL8iymV36hqlrv6mNFwV
	 DjFSroarFd/XqCvyDJtZih2xiXGOPgvmgcSfadydp96b6gvyMEXxGG0qTYdlgJNnsj
	 DdctrHdmyO2thFrusKyz3daNq38RorUr7vPlYVA6NcBPo7b9ehUDZrTps/KzYb/BnL
	 4zyc+9xsXk1ZSHdbhON+t/oOjEkpQoAJs8n9WNOkWb3s5ccjyM6dwaUL1jtqgkF9gR
	 4LhvOxSkw2qomni5RTLX5BJJ/XkBRsVdQpaoHuynohTlfqq4QOGuAvk/uqEq+98j2N
	 LQEqBwDx6TT5Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15b75c9e48so128658366b.1
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2026 14:36:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpKxCrT8vu59zCZICe5jq2fy4+czcsQ/RXOnlGBCx1bFicHT1Xe470TPDYcUI5BmuBg6ji2FpsC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49YtVJsvCAiB8jRrzoBVKvLMnJWY8Iv8R0d0FzkSvDXhqaR+T
	xrkV/yrhFoEDKArh8WuWYgkP+ZalU6FjxiLkJiyXELqw9s6GZSf6C01YYKCn5ocZG9BeOYQIVxy
	clU80ttxHDV9Y4P8LyTDMtlaGPFvkK00=
X-Received: by 2002:a17:907:bf06:b0:c12:36ff:6ebb with SMTP id
 a640c23a62f3a-c15a692b12dmr348765966b.44.1783460197298; Tue, 07 Jul 2026
 14:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
 <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com> <CAKEwX=MMXdq7KTzcEgXfNt2L-eTmAVa+nijdyiujVOAhXQsHSg@mail.gmail.com>
In-Reply-To: <CAKEwX=MMXdq7KTzcEgXfNt2L-eTmAVa+nijdyiujVOAhXQsHSg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 7 Jul 2026 14:36:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO-nAys0PJfXVRwLgAzwJLa9KxpMXKQKXJR7cnYKgmhRQ@mail.gmail.com>
X-Gm-Features: AVVi8Cda2GhPqDSknVsY53Q6TlEfuCwJntD2kTQUNKYn1iwv3Wq_3XPV_UqjD2Q
Message-ID: <CAO9r8zO-nAys0PJfXVRwLgAzwJLa9KxpMXKQKXJR7cnYKgmhRQ@mail.gmail.com>
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
To: Nhat Pham <nphamcs@gmail.com>
Cc: Zenghui Yu <zenghui.yu@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hannes@cmpxchg.org, chengming.zhou@linux.dev, tj@kernel.org, mkoutny@suse.com, 
	Shuah Khan <shuah@kernel.org>, mhocko@kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:zenghui.yu@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17568-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD6FA71FCC3

On Tue, Jul 7, 2026 at 2:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Tue, Jul 7, 2026 at 11:25=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Tue, Jul 7, 2026 at 2:38=E2=80=AFAM Zenghui Yu <zenghui.yu@linux.dev=
> wrote:
> >
> > We were discussing a way for userspace to explicitly trigger a flush
> > before, which would come in handy for testing. However, we decided not
> > to expose flushing as a concept to userspace.
> >
> > Unfortunately I think the only way to "fix" the test is to allocate
> > more memory, enough to trigger a flush on most interesting setups.
> > Perhaps we should scale the amount of memory with the number of CPUs
> > so that we don't have to keep playing whack-a-mole.
>
> I don't have a good idea for writeback, but for zswap out, would
> MADV_PAGEOUT work here?

I don't think the reclaim mechanism is the problem, but the fact that
we don't have enough pending updates to flush the stats. Am I missing
something?

