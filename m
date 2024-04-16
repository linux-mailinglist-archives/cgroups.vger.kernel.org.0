Return-Path: <cgroups+bounces-2519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B076A8A6DC9
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18EE1C20D9D
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24B12EBE3;
	Tue, 16 Apr 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukcy8ujr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2712C534;
	Tue, 16 Apr 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276966; cv=none; b=Faw7LPCcqJhjkbuD1lqlC26FCBRWJbvcw33gs1MHM1RIo/tOVU0d8XHBIs/AZzOcQ/xpHpHTdzzm8gZqpf38uAuNio+nYfsK0hq9Lqu4YFnpJS7bbDOQD0RUoY8a6UT3RpKMbVfKdhACIGDumjhWLn/dUy7mDIc521S6B0Cxtkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276966; c=relaxed/simple;
	bh=sO5QJlCa2KzxD9mza+Do+HtQ6W6lgeVJrYewsyMsFVQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uICW11Mh4YcxCTUJNtpVmPtZf0nfRrwKpZdHDQRXlfcY5jtyJ6bXJGO1Lx03ts9fM01CFhgEcH/c8wuvec3pemOnzrRct6a8z2ZQaRmH1L+ybrADKni6z6PxEJpCEtRlYKzzu+K8wczRc/xoY+fNCofWSzh7/M2C9k9wEitk42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukcy8ujr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD001C113CE;
	Tue, 16 Apr 2024 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276966;
	bh=sO5QJlCa2KzxD9mza+Do+HtQ6W6lgeVJrYewsyMsFVQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Ukcy8ujrBWNYqmc9aHZJGCHFrSuejzu88Y9AWEC/3BbU/Nm8h0gsKrXGZQSu0IlUs
	 1XrhvLdAqXR+IuouKFGZhAj97ffE80++XIJUSdM3wXjU0qlMq0wWewboqw/YoFhFAn
	 IxNOrKRLURH6AuXt6u0PpzvsUMuvZMhFXryKqlH2M8RTiev0qMXhqd46J33vOe5gWf
	 iZOErJEi2Us/pVfBd0Fcq1hFKWBLTlzKpBckJ8RoVgR47hpF0dd6DO+BN7eDMkS25n
	 l9nnpvq9B0jHuzEICBMaCzHwwReAqZppHbRFfAcdgJj3d5DTlxBUtp1zTcPpxgcDE7
	 sBxJIlGM6S/Zg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Apr 2024 17:15:59 +0300
Message-Id: <D0LLZTSVG3BC.8WIRM39WC7UU@kernel.org>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Huang, Kai" <kai.huang@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
 <haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>
In-Reply-To: <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>

On Tue Apr 16, 2024 at 8:42 AM EEST, Huang, Kai wrote:
> >=20
> > I'll send a fixup for this patch or another version of the series if mo=
re =20
> > changes are needed.
>
> Hi Haitao,
>
> I don't like to say but in general I think you are sending too frequently=
.  The
> last version was sent April, 11th (my time), so considering the weekend i=
t has
> only been 3 or at most 4 days. =C2=A0
>
> Please slow down a little bit to give people more time.
>
> More information please also see:
>
> https://www.kernel.org/doc/html/next/process/submitting-patches.html#rese=
nd-reminders

+1

Yes, exactly. I'd take one week break and cycle the kselftest part
internally a bit as I said my previous response. I'm sure that there
is experise inside Intel how to implement it properly. I.e. take some
time to find the right person, and wait as long as that person has a
bit of bandwidth to go through the test and suggest modifications.

Cannot blame, as I've done the same mistake a few times in past but
yeah this would be the best possible corrective action to take.

BR, Jarkko

