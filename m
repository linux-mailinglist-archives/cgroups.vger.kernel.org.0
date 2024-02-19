Return-Path: <cgroups+bounces-1706-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA0685AF2B
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 23:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56AD1F22F9E
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE05789A;
	Mon, 19 Feb 2024 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK6d5FuW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4A57877;
	Mon, 19 Feb 2024 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382598; cv=none; b=kQigZGeSsSLWi6SaEeEfTvDKgOGCZueD/Mv9UwOdIcwDUvd2u8HIl1KTBeg+/dLiutTfI29OveA5ajxbacb9O6EPYwmBdmldKp5x/woVQSqm7+i0HLXV4E1R6Jm8HCqp3dI5DPE6a2bTBKBMEj24Eww+KJ5WGpMPvi0I/bRSmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382598; c=relaxed/simple;
	bh=niaSERqhJ4QxtZz9++F8YWQyqPA5MyjhNIr1Dtj9Ezw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lcZRiPmUqOoLGPk+/9/HLwqfzvB9sKlWg/P6loXI6h7ssGKKtZl7PA5FjaRVfTIqCR+jyiVhFeRYrBm/nCt6g1hQ4JSBAp1NkLYiCMR3aaQ8j0QENh+KXvpeKK0GkwpzHy+MneJYdL/VANPG2/tUwdQ6GhzGpbFnK5swsTjhtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK6d5FuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184FAC433F1;
	Mon, 19 Feb 2024 22:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708382597;
	bh=niaSERqhJ4QxtZz9++F8YWQyqPA5MyjhNIr1Dtj9Ezw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UK6d5FuWDhJk9UDsNB7j3xrH1V85geOu+OMlOGXTgrZUm7lLu304mUNtu8RbTH4lg
	 qzuhNqCgjRshzJq7qtOvGTVKrYUoLVseWKct64v498/H7Dg80b6JoTUPbgCIHvkxsH
	 lh8cdyVTRrph1l9340WQwjFqHG1joSPtvasDwFppuvUkOiq3rQ2sYXSx/+138h3a7S
	 aJCBYuSHtZX/XwN/gl+i7CPvUqaj+422wr1GX/VWgtqadY+XgI4z/nWrFVfxdY11uR
	 IrP/buZ1h4Vl+trLwz5I8XJsFXfRNcJYYJsYxKt0Kn30HnTHd5uRID5g/7BXRXfadJ
	 Nn6eRSUfKyExA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 22:43:10 +0000
Message-Id: <CZ9F33MWM7CO.2W1QSM24ZN6RM@seitikki>
Subject: Re: [RFC PATCH] x86/sgx: Remove 'reclaim' boolean parameters
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>, "Dave Hansen"
 <dave.hansen@intel.com>
Cc: <anakrish@microsoft.com>, <bp@alien8.de>, <cgroups@vger.kernel.org>,
 <chrisyan@microsoft.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
 <kristen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <mikko.ylinen@linux.intel.com>,
 <mingo@redhat.com>, <mkoutny@suse.com>, <seanjc@google.com>,
 <sohil.mehta@intel.com>, <tglx@linutronix.de>,
 <tim.c.chen@linux.intel.com>, <tj@kernel.org>, <x86@kernel.org>,
 <yangjie@microsoft.com>, <zhanb@microsoft.com>, <zhiquan1.li@intel.com>
X-Mailer: aerc 0.15.2
References: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
 <20240219153957.9957-1-haitao.huang@linux.intel.com>
 <40f95b90-8698-42dd-89d7-cd73d1e311b1@intel.com>
 <CZ9CIP97661C.2WUZJNNCQUHE8@seitikki>
 <op.2jetwkvkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2jetwkvkwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Mon Feb 19, 2024 at 10:25 PM UTC, Haitao Huang wrote:
> On Mon, 19 Feb 2024 14:42:29 -0600, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Mon Feb 19, 2024 at 3:56 PM UTC, Dave Hansen wrote:
> >> On 2/19/24 07:39, Haitao Huang wrote:
> >> > Remove all boolean parameters for 'reclaim' from the function
> >> > sgx_alloc_epc_page() and its callers by making two versions of each
> >> > function.
> >> >
> >> > Also opportunistically remove non-static declaration of
> >> > __sgx_alloc_epc_page() and a typo
> >> >
> >> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> >> > ---
> >> >  arch/x86/kernel/cpu/sgx/encl.c  | 56 +++++++++++++++++++++------
> >> >  arch/x86/kernel/cpu/sgx/encl.h  |  6 ++-
> >> >  arch/x86/kernel/cpu/sgx/ioctl.c | 23 ++++++++---
> >> >  arch/x86/kernel/cpu/sgx/main.c  | 68 =20
> >> ++++++++++++++++++++++-----------
> >> >  arch/x86/kernel/cpu/sgx/sgx.h   |  4 +-
> >> >  arch/x86/kernel/cpu/sgx/virt.c  |  2 +-
> >> >  6 files changed, 115 insertions(+), 44 deletions(-)
> >>
> >> Jarkko, did this turn out how you expected?
> >>
> >> I think passing around a function pointer to *only* communicate 1 bit =
of
> >> information is a _bit_ overkill here.
> >>
> >> Simply replacing the bool with:
> >>
> >> enum sgx_reclaim {
> >> 	SGX_NO_RECLAIM,
> >> 	SGX_DO_RECLAIM
> >> };
> >>
> >> would do the same thing.  Right?
> >>
> >> Are you sure you want a function pointer for this?
> >
> > To look this in context I drafted quickly two branches representing
> > imaginary next version of the patch set.
> >
> > I guess this would simpler and totally sufficient approach.
> >
> > With this approach I'd then change also:
> >
> > [PATCH v9 04/15] x86/sgx: Implement basic EPC misc cgroup functionality
> >
> > And add the enum-parameter already in that patch with just "no reclaim"
> > enum. I.e. then 10/15 will add only "do reclaim" and the new
> > functionality.
> >
> > BR, Jarkko
> >
>
> Thanks. My understanding is:
>
> 1) For this patch, replace the boolean with the enum as Dave suggested. N=
o =20
> two versions of the same functions. And this is a prerequisite for the =
=20
> cgroup series, positioned before [PATCH v9 04/15]
>
> 2) For [PATCH v9 04/15], pass a hard coded SGX_NO_RECLAIM to =20
> sgx_epc_cg_try_charge() from sgx_alloc_epc_page().

Yup, this will make the whole patch set also a bit leaner as the API
does not change in the middle.

>
> 3) For [PATCH v9 10/15], remove the hard coded value, pass the reclaim =
=20
> enum parameter value from sgx_alloc_epc_page() to  sgx_epc_cg_try_charge(=
) =20
> and add the reclaim logic.
>
> I'll send patches soon. But please let me know if I misunderstood.


BR, Jarkko

