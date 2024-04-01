Return-Path: <cgroups+bounces-2261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09956893C36
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 16:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8D8282438
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAF441E22;
	Mon,  1 Apr 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSAsAvvr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6310A03;
	Mon,  1 Apr 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981814; cv=none; b=qXFf1lIrlRdV3CEKGYLAJPdsfGKmXOn/TarOfsoFrVpDzHGStA2nN2oItES/q5VYDiAmUBH+KlZJ2MFBkQILbjWR8zaqqGF43CxlmgaADES2jVlMK/ZBc87WZWee3cb1I+jaRrbw61zyJs8HM2yBYw6hnAYHutWBE4X+rlSYvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981814; c=relaxed/simple;
	bh=rUtbKhJd42W49mcH+PWZ7Hn3kLbojDapBlOE3UUUjqg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c8FdvD4aOm0EPTNCAJyef2CRqoZHkWcBnojy8ey1ZPwXd3hn7aNEUCpTVwHke4rdYWK8SAWMBNhNjMmiBg4D2tKbUvfT1qO4zYnL7kD6vSoSxaLFsnyWt3Ec3qEOSzkxjhZ2pky+k6UTsrgo37Ct8bKaFPsDOg6x7BnGFZoT9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSAsAvvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68741C433F1;
	Mon,  1 Apr 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711981814;
	bh=rUtbKhJd42W49mcH+PWZ7Hn3kLbojDapBlOE3UUUjqg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nSAsAvvrPavW1PfN4Fkbep2/goAmTke8164aFwdRKMyR3xw6D6s3Gwq390kOGo+PP
	 EHhifHhLUn7xfjwnbBUEtxQl/gEd7nELO+z/xZyFcQh9KgNwQdWkML3quMpEEP7Qju
	 46QgINKC8vwrM1ZYL/uJ7AeykQ2qn2KjdBC9r7RF9NCKIvdkb1r9l4ly8l1u2JvlIC
	 MzgaNHG2FjN8zxZj5lZcZW88Gb5qGCbpbKwJQrSvFE5EowVoROxCgr7429wmjaWkyy
	 HDTBo/ZnG/5PtJz7sqfKO7fBNvABvuXIFcn4mPph/KQfkVCVJyxjGjc8+Kdc0zP6UA
	 4rN7b0QvM50WA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 17:30:07 +0300
Message-Id: <D08UWGYDKS6D.2J34TCDQ836RF@kernel.org>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Huang, Kai" <kai.huang@intel.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "haitao.huang@linux.intel.com"
 <haitao.huang@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "bp@alien8.de" <bp@alien8.de>
X-Mailer: aerc 0.17.0
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-6-haitao.huang@linux.intel.com>
 <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>
 <D071JQZYBH2W.399N43JS6GY6Z@kernel.org>
 <5a5dee86713a2852fc2c1ebef28ae08927d2c95f.camel@intel.com>
In-Reply-To: <5a5dee86713a2852fc2c1ebef28ae08927d2c95f.camel@intel.com>

On Mon Apr 1, 2024 at 12:29 PM EEST, Huang, Kai wrote:
> On Sat, 2024-03-30 at 13:17 +0200, Jarkko Sakkinen wrote:
> > On Thu Mar 28, 2024 at 2:53 PM EET, Huang, Kai wrote:
> > >=20
> > > > --- /dev/null
> > > > +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> > > > @@ -0,0 +1,74 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +// Copyright(c) 2022 Intel Corporation.
> > >=20
> > > It's 2024 now.
> > >=20
> > > And looks you need to use C style comment for /* Copyright ... */, af=
ter looking
> > > at some other C files.
> >=20
> > To be fair, this happens *all the time* to everyone :-)
> >=20
> > I've proposed this few times in SGX context and going to say it now.
> > Given the nature of Git copyrights would anyway need to be sorted by
> > the Git log not possibly incorrect copyright platters in the header
> > and source files.
> >=20
>
> Sure fine to me either way.  Thanks for pointing out.
>
> I have some vague memory that we should update the year but I guess I was=
 wrong.

I think updating year makes sense!

I'd be fine not having copyright platter at all since the commit is from
Intel domain anyway but if it is kept then the year needs to be
corrected.

I mean Git commit stores all the data, including exact date.

BR, Jarkko


