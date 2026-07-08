Return-Path: <cgroups+bounces-17588-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m3v9JiSgTmrzQwIAu9opvQ
	(envelope-from <cgroups+bounces-17588-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 21:08:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD32729CAA
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 21:08:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JX1w5xxl;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17588-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17588-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99798300F781
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 19:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6133CC7D3;
	Wed,  8 Jul 2026 19:08:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD4379C3E
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 19:08:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537694; cv=none; b=pZxRpZDCSSac9HsLYUO6zoblPeaBgAWqi6nyEfW5tdDwWtK0dVZdlHNDy+evitGySPz5Uu9iLo4CkO+Rn4Q0+XK73XnjjB8IxC3MnSh5Ksw681vP+YGPfdPVOrBVkzTe0rnY7qvircu0Y0Q3iklNeO4vu+xozjG0llk4hJ31o9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537694; c=relaxed/simple;
	bh=yiBkA9xQHooEcgjjRAQRu3aK1yHlnq/UeMyE5vEXoEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vpad8HI0fTDzfelMYaaTNgVcYdauw+XB8f36SQIHiUhncePNYJf3Q6Bcqb3mxgYe+hbn954kQd/3dxOdLKsW2HPwNKTT17tlZUavce8E7ZecpaJkdR+UHmixA6CpSDp9Gv7GWGCEBtyPKdGLQjfDLM387rKAxZ9rWY28xVZzpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX1w5xxl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C391F00ACA
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537693;
	bh=yiBkA9xQHooEcgjjRAQRu3aK1yHlnq/UeMyE5vEXoEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JX1w5xxlZ7d0rlN3bIaPU9Yb1jxSFKZfedoZtGcsE+sngcvCXrnoGwvc6MLooVNXE
	 4lA6rIFmchXAe7hNCyBX8Q5pkx1k4Nfaf1+47IOHiUfIvJl+FlMRueQE3BgIddpBXR
	 LiJn90bD6okxSyv2Sss453Tad72ouC/YgBsBIMGAYNhI9ZFC2jmFEZkjY8nZMoH1VY
	 OekxpQz7JVsB95w2OJHIuUxinRS8BEEGD2hr2FQ8StOUHpJGvJRg1zt/F0dkPpkHge
	 K1yY/II+hKH8H8S905VbpHaHmTCtKTFlhoIr+CIzH/VFfsRfzDldCEexOA4S485F9v
	 9b1fy5gC18gbQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69532288224so221810a12.0
        for <cgroups@vger.kernel.org>; Wed, 08 Jul 2026 12:08:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqrpcWUioYjscn83shLGDBgBL67MNJsVIfkOyyMNWJugBOD+B2Nt41gFalOLU+fmpiy9d+EEhUd@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNbU1vrOzVcNpsYgOMeM4iOlEK5awrtc74JvyL7xtT0PF0rKp
	2e+SGu69fVGQ2Bh+BfWm1IEpV4baFmzMNqp2Rf/gm11UQjIZvtfP8ckY6/yOWz66YxZWWzlAeOG
	eoiQn2XJJOfh87WiHXuTblmFejcPAJTo=
X-Received: by 2002:a17:906:c14a:b0:c05:b9db:68cc with SMTP id
 a640c23a62f3a-c15cdc8ac7amr170635966b.0.1783537692118; Wed, 08 Jul 2026
 12:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
 <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com>
 <CAKEwX=MMXdq7KTzcEgXfNt2L-eTmAVa+nijdyiujVOAhXQsHSg@mail.gmail.com>
 <CAO9r8zO-nAys0PJfXVRwLgAzwJLa9KxpMXKQKXJR7cnYKgmhRQ@mail.gmail.com>
 <CAKEwX=M7axSs2FJDq0KF3GBDpd6G0J=gP_2boUJraNf8M2n3Bw@mail.gmail.com>
 <CAO9r8zM8qk9g6+B6GiCV3oytjViMTEhbr0KjrccU+bF4+PMfTA@mail.gmail.com> <ak6c2TaOlcGxZ2Ih@localhost.localdomain>
In-Reply-To: <ak6c2TaOlcGxZ2Ih@localhost.localdomain>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 8 Jul 2026 12:08:00 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPiOyri2wVxRvB0bwEXf9bCKoPsQmRzOpj01XozA8hqUw@mail.gmail.com>
X-Gm-Features: AVVi8Ce2aMsGuquiDYnmvYMN9gnK32qIskLfiFxzN_JVMoIyoVCs7MHxGrMZ-QE
Message-ID: <CAO9r8zPiOyri2wVxRvB0bwEXf9bCKoPsQmRzOpj01XozA8hqUw@mail.gmail.com>
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	tj@kernel.org, Shuah Khan <shuah@kernel.org>, mhocko@kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17588-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kvack.org,vger.kernel.org,cmpxchg.org,kernel.org,linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:nphamcs@gmail.com,m:zenghui.yu@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AD32729CAA

On Wed, Jul 8, 2026 at 12:00=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Jul 07, 2026 at 02:49:56PM -0700, Yosry Ahmed <yosry@kernel.org> =
wrote:
> > I would honestly rather use more memory. I think there might be cases
> > where the flusher is delayed. The flush being slightly delayed is not
> > technically a bug that we want to see a failure for, but if a large
> > stats change is not visible that's a user-noticeable behavior that we
> > want a failure for.
> >
> > WDYT?
>
> There's already the (recent) page size-based scaling, so the idea with
> nr_cpus scaling could make the selftest useful on wider range of setups
> (even page size can be considered as a slight implementation detail
> leak, thus the justification of nr_cpus dependency).
>
> Also, I still think that internally the threshold should be changed to
> the "harmonic" formula [1] but the selftest can go with the linear
> dependency for more pronounced effects.

Yeah I agree the threshold formula can be improved, but we need to
make sure performance doesn't regress.

