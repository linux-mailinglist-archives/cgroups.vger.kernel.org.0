Return-Path: <cgroups+bounces-2250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84A892AB2
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF9E1F21AEE
	for <lists+cgroups@lfdr.de>; Sat, 30 Mar 2024 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3762BB16;
	Sat, 30 Mar 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apaAHR1y"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCCBE6F;
	Sat, 30 Mar 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797445; cv=none; b=fct72kDm4ronWCziIe8hvaSAdoRSsbQtJZKxk5oVcGNsl5jRm+psyuabMvQiN7yBYQX2U+2E+iOgfpQvjwML6zbsE7xWYP/E9XERhUd4l0vJ0TeADCWybTWYfJhrNDKsLTFqqE/5Nc9KNHg8tIDDQWY8Zl9qq9cpNSjtDqEq93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797445; c=relaxed/simple;
	bh=v25wJ1abwo8Rn1NPDoiQOpEQWDXtAWSeVOs+cquO+/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HRGuwl8IwckJuDCFqT/x6uxsq0kRnm/7AOKThL37tdqc5dg3yED5riP8YaYbQhZnNAcntKGaOuoJvltYIVoJ0t+aCZsGcoDyar2PTcz7YW8NK4IHMzyPuPitW6Yz9rzmqOsjZ2l6KaDgxQBE9EcIaMPNCOAfsfOShS0R3T2gVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apaAHR1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8E3C433F1;
	Sat, 30 Mar 2024 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711797444;
	bh=v25wJ1abwo8Rn1NPDoiQOpEQWDXtAWSeVOs+cquO+/8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=apaAHR1yF8Stl9mdkYSTboDVvu4RQKIvMDDjL58QOBzk+yy63F0fOn0RlZw9RexhQ
	 PcfTYB1tO5BN6sUlfQG7pRyhuxfGh0B4DbBTlzplq736SzQRqXe1d3PpDvCDNJMoUo
	 q4cpzPWSqPdm2/FVnlBWp+lv6bHgk6nrRn0w6Ui+eJi+hDuLdfynt1sCMOM1RmbDGh
	 zfXhqpsyXIV/RC0WnyCPsd3VRpI3XVMzXcvXiOZIJFxkWIdJApqLKX52JnX3aYTo1V
	 IliQ3XHa2aTY6+SrttcM8VFvKKa0E522nm0zxurKHxm8E8mnElswz829yEYmnBJ8E4
	 +d2PQlfo5rrlg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Mar 2024 13:17:18 +0200
Message-Id: <D071JQZYBH2W.399N43JS6GY6Z@kernel.org>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
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
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-6-haitao.huang@linux.intel.com>
 <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>
In-Reply-To: <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>

On Thu Mar 28, 2024 at 2:53 PM EET, Huang, Kai wrote:
>
> > --- /dev/null
> > +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright(c) 2022 Intel Corporation.
>
> It's 2024 now.
>
> And looks you need to use C style comment for /* Copyright ... */, after =
looking
> at some other C files.

To be fair, this happens *all the time* to everyone :-)

I've proposed this few times in SGX context and going to say it now.
Given the nature of Git copyrights would anyway need to be sorted by
the Git log not possibly incorrect copyright platters in the header
and source files.

BR, Jarkko

