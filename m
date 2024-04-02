Return-Path: <cgroups+bounces-2271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493889523F
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 13:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24542824B4
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E76996F;
	Tue,  2 Apr 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7I6yrQd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72D5A4C7;
	Tue,  2 Apr 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059127; cv=none; b=m4mMh/alJCIg1xdYS46MAuhJn9mWRW53oRFaLjtRno3m5WUUwmUm5XIxrTttTcCrsWC6FBr4pW8pKBdSlFRVry/gAifpH5E148K3yV16FuEk9mQAijYFkaPfnqFpZUAvbgInsoGlWsaXUNvnRP+MLRSgTByKDlTdqa0zYM9KYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059127; c=relaxed/simple;
	bh=DY/Q/EiQtNhm8+8sgNFGHo2U1UZo69cenu2M0qwUy4E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pQPx19Av3CyhEmcOZF216O4ZGA3rq9DVCqBU06QaSbJBtYtKcqYQz4PDcuTcpWbuEJtJCZjpWDf39y41OWV8bb9yWoxkqoh8qYdqrxarOWNeYrAOZcPwcE/vV2c/gkwuZyEwIKqT5pj9yOmlttE89wqnA8Tyg1lLDzbbNa5IgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7I6yrQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8790FC433C7;
	Tue,  2 Apr 2024 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712059126;
	bh=DY/Q/EiQtNhm8+8sgNFGHo2U1UZo69cenu2M0qwUy4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7I6yrQdxowtdndTnB+j9jV3eTIiBbOcXzK1nyoOfp2DdZQoDCAcwG4h72t+6kCib
	 OrdXSrcFLDAvQ9ipGp3a+/NYka+UxZvk5CLssrqTYYvuxJ6UqKsJzfeu3ftp4HykC7
	 SdCxFdLw03TYZ42N1NvWc7bsNbCouE+patdQDdKJpVVN+pqFMq77IlXr/5Ru+pFefc
	 U3oVIEv3TzGlRFGcFGh/h5MKOCgqecTjln4Fv3Cqd4ue37u2wVm5jaCoSz05Tho/H1
	 LeT8g7v/JI3DNByUqaw5NMrzv2kMtAs2+44UgtlfD2K98MsDT96ofwWLU7yl/rNBiA
	 oCX2q8VHpTLLQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Apr 2024 14:58:40 +0300
Message-Id: <D09MB26IPFFW.3UBD7M0S17SG6@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>,
 <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
X-Mailer: aerc 0.17.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org>
 <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
 <htiz5jgsby5v262saphhomcsxtixb2u7ot6jcghpfhvgz65ht6@qlz3gpdwapaa>
In-Reply-To: <htiz5jgsby5v262saphhomcsxtixb2u7ot6jcghpfhvgz65ht6@qlz3gpdwapaa>

On Tue Apr 2, 2024 at 2:23 PM EEST, Michal Koutn=C3=BD wrote:
> Hello.
>
> On Sat, Mar 30, 2024 at 01:26:08PM +0200, Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > > > It'd be more complicated and less readable to do all the stuff with=
out the =20
> > > > cgroup-tools, esp cgexec. I checked dependency, cgroup-tools only d=
epends =20
> > > > on libc so I hope this would not cause too much inconvenience.
> > >
> > > As per cgroup-tools, please prove this. It makes the job for more
> > > complicated *for you* and you are making the job more  complicated
> > > to every possible person in the planet running any kernel QA.
> > >
> > > I weight the latter more than the former. And it is exactly the
> > > reason why we did custom user space kselftest in the first place.
> > > Let's keep the tradition. All I can say is that kselftest is=20
> > > unfinished in its current form.
> > >
> > > What is "esp cgexec"?
> >=20
> > Also in kselftest we don't drive ultimate simplicity, we drive
> > efficient CI/QA. By open coding something like subset of
> > cgroup-tools needed to run the test you also help us later
> > on to backtrack the kernel changes. With cgroups-tools you
> > would have to use strace to get the same info.
>
> FWIW, see also functions in
> tools/testing/selftests/cgroup/cgroup_util.{h,c}.
> They likely cover what you need already -- if the tests are in C.
>
> (I admit that stuff in tools/testing/selftests/cgroup/ is best
> understood with strace.)

Thanks!

My conclusions are that:

1. We probably cannot move the test part of cgroup test itself
   given the enclave payload dependency.
2. I think it makes sense to still follow the same pattern as
   other cgroups test and re-use cgroup_util.[ch] functionaltiy.

So yeah I guess we need two test programs instead of one.

Something along the lines:

1. main.[ch] -> test_sgx.[ch]
2. introduce test_sgx_cgroup.c

And test_sgx_cgroup.c would be implement similar test as the shell
script and would follow the structure of existing cgroups tests.

>
> HTH,
> Michal

BR, Jarkko

