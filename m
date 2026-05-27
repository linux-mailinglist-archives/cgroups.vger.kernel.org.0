Return-Path: <cgroups+bounces-16377-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPEMCIOEF2rJHggAu9opvQ
	(envelope-from <cgroups+bounces-16377-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 01:55:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F975EB14A
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 01:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B56033016823
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3B3B1032;
	Wed, 27 May 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzs7Og60"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DB33F5B4
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925976; cv=none; b=oi1I3Oa/o2FzmxJLEoTNsPG5Nci8Todr9UETPsJbrXnL7svIhaW3CZOzOZaFeybmH7psNCBSAmEH6+Mi+votEYBS1nENhedlWx9hrSN/leGbnoBuBSn+lXyoinMFHbhsM1q6zXRE4H8OJdpKUD8YyINySmEqE3Do9EQ6cfeinlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925976; c=relaxed/simple;
	bh=Dpeb5+Pr4zXD8kTIf3HtjyzgFNwk/wcPurI83bssGQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rnnzz0MewvDq9RThHYY/WAEz1M+qj2jDEzrRbrzk0F5MGNjZmdEDrRwG9K7pWAiV91NSoV1iNzR8sDNm5O3NMFVwGW/XiUWZvIe2txliK79tINgCrwsPslyGaS3TkvT1Iv4uQb+ceYlGU8p3BsCS5fl/DVNjUR17ouTM5sChzKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzs7Og60; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF881F00A3F
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925974;
	bh=SeUqDM6kHXI4MJO5NxIZnBVQL7CgctHkwj3f11Zgvb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fzs7Og60UWY5kTdAr0mOQdyMusHW8uYLwojCS/PzybvSQ5RCGkqDXCXe3c9Xth5fp
	 xUyFmmVvwlChpcla9IQrqjsDDKK42e7pvncYG+M+1cBCClbHaS4OPyEWLHPkOuUwWk
	 cz27kd1HGr1bQv2yAnQMMOr7NIvYiNL3Y0mPAGaLttowQItJXrzvu4JiJPO5//XdeX
	 FQ4wv+ghVyAVVpgHmSmNqn0seICehPUIFohz981l6UQo3CkpJiFgC72nbeEmvkeqay
	 TgRnwKyLIBAwnDGcmH1rNb76gQhI5JJI3tohVcNtxL+BssOnEEd/0kyOcRUxUAwCCb
	 Hc9piOSDLaOBg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso2168588566b.1
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 16:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/vTpiB0ctiLq554Gzi1rp1ZMk9XFX1uJCHqPt7z7LDCPt3EVn864rGZ6uVflORPxVXQ76WHn3T@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6k1ylvlJriHWFg60Y7t6F6wumTYI9VZaNJ2t0GgHDYe+iEGxG
	jTVDYQzRrIDRWqbA61fNYvCb7Zkd3hU53fKzjij+Ea+/JUqsadD6LbRzlRjFU2j+YbyD/h/cR51
	uu8BnPN81fOxpFOdRBzL5o5EyaC9D498=
X-Received: by 2002:a17:907:a80c:b0:bdb:c0f7:ed68 with SMTP id
 a640c23a62f3a-bdd268c0eb6mr1575121366b.42.1779925973705; Wed, 27 May 2026
 16:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527062247.3440692-1-youngjun.park@lge.com> <20260527133651.2ce806fa542a82eca5ff66d6@linux-foundation.org>
In-Reply-To: <20260527133651.2ce806fa542a82eca5ff66d6@linux-foundation.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 27 May 2026 16:52:42 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPpXsehvHK+iBgORXKfpKWJBfdH-_3_+PNT+RwzJ+q9pA@mail.gmail.com>
X-Gm-Features: AVHnY4L6f5NybnTdGBEWK83rJj50WfqT7n2xN92NCKzNHLpFzapdUfhgSzX9qRA
Message-ID: <CAO9r8zPpXsehvHK+iBgORXKfpKWJBfdH-_3_+PNT+RwzJ+q9pA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] mm: swap: introduce swap tier infrastructure
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Youngjun Park <youngjun.park@lge.com>, chrisl@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, 
	baver.bae@lge.com, matia.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16377-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lge.com,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 89F975EB14A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:36=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 27 May 2026 15:22:43 +0900 Youngjun Park <youngjun.park@lge.com> =
wrote:
>
> > This is v7 of the swap tier series addressing review feedback.
> > The cover letter has been simplified.
>
> One question from Sashiko.   Minor, but easy to address.
>         https://sashiko.dev/#/patchset/20260527062247.3440692-1-youngjun.=
park@lge.com
>
> I'm reluctant to add a new feature patchset at this time - we have a lot
> already and we're at -rc5.   What do others think?

This adds new user-visible interfaces and I think we didn't reach an
agreement on them. I specifically recall Shakeel (and perhaps other
memcg folks) having questions about the memcg interface, and I don't
see any Acks on that patch. I don't think this should be included.

