Return-Path: <cgroups+bounces-2296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D5897411
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACDB1F21DA9
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D2E14A0A5;
	Wed,  3 Apr 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKSKP8k9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4633139D17;
	Wed,  3 Apr 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158407; cv=none; b=pqQfDb88T6QGp87PRGVRWr6KvXUfGh732vtKix05rcvvUEGl3bQ5TGpYtlQmjxjUcp1cJahGZAi2P5B+MV1OU4OOtonaUlw89wq9hv6TsJQr3gyxgNrxCveBp0jOHOLqUfi1g+goa5LaKbf80jrJu72eYJE08/t48T9pOfvnQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158407; c=relaxed/simple;
	bh=HyRVKVZLib2Qi5jNnjsMMZBqiCB0TsCEtOsioaftDFM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jBg4H25Q6UuKs7hxbvV65aqGDtKKp90LOUEB9V8aA3we0wzBcrfQ2VLFzG96mIaaz0pFFd5KHZflZ/FP3UXEE6u9ulbdCoDrWSYLDska9QAznWhYC6hMJpJMq3wGmGsBxb6+3jBs8nf5IyqRluS+dlGs4n+UymI9R2XSqOKMAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKSKP8k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1356CC433C7;
	Wed,  3 Apr 2024 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712158406;
	bh=HyRVKVZLib2Qi5jNnjsMMZBqiCB0TsCEtOsioaftDFM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QKSKP8k9E0RIb0YQFAOClleU8yl67e7l5fuoahSVZklTWnFKmag6DeIELlvJS3XF2
	 1SPFgMK7KkrFGiKOYqtM0WuAHzgJOUJJfJYwe+dCFMizkP0+Hm827qe3ORTst70SEF
	 jf2/6sRiK691LLVhH7qIKlGPvSqWxSfQymBddtCSbxlkw0hu2ma9JFYru2Do+5efqt
	 +U0Cbs+P7n44HUL+9JU1j3hqkiciTgRerfYT7ZpYd3ieMHMcrURaf6sWjnomY2WCNH
	 0lqwX2bgfZVW3ks8w2q0FrHhbtm/ll2FLLE93UuPF93P+xRZ9w8wrvInsMo46Wtrj6
	 6ewpXop4JyptA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 18:33:20 +0300
Message-Id: <D0ALHYK53O0Z.31OREWUI3J9N2@kernel.org>
Cc: <dave.hansen@linux.intel.com>, <tj@kernel.org>,
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
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailer: aerc 0.17.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org>
 <D071QIHLW7MP.UM9R3VYETIOK@kernel.org>
 <htiz5jgsby5v262saphhomcsxtixb2u7ot6jcghpfhvgz65ht6@qlz3gpdwapaa>
 <D09MB26IPFFW.3UBD7M0S17SG6@kernel.org>
 <op.2llzn7wgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2llzn7wgwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Tue Apr 2, 2024 at 7:20 PM EEST, Haitao Huang wrote:
> On Tue, 02 Apr 2024 06:58:40 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Tue Apr 2, 2024 at 2:23 PM EEST, Michal Koutn=C3=BD wrote:
> >> Hello.
> >>
> >> On Sat, Mar 30, 2024 at 01:26:08PM +0200, Jarkko Sakkinen =20
> >> <jarkko@kernel.org> wrote:
> >> > > > It'd be more complicated and less readable to do all the stuff =
=20
> >> without the
> >> > > > cgroup-tools, esp cgexec. I checked dependency, cgroup-tools onl=
y =20
> >> depends
> >> > > > on libc so I hope this would not cause too much inconvenience.
> >> > >
> >> > > As per cgroup-tools, please prove this. It makes the job for more
> >> > > complicated *for you* and you are making the job more  complicated
> >> > > to every possible person in the planet running any kernel QA.
> >> > >
> >> > > I weight the latter more than the former. And it is exactly the
> >> > > reason why we did custom user space kselftest in the first place.
> >> > > Let's keep the tradition. All I can say is that kselftest is
> >> > > unfinished in its current form.
> >> > >
> >> > > What is "esp cgexec"?
> >> >
> >> > Also in kselftest we don't drive ultimate simplicity, we drive
> >> > efficient CI/QA. By open coding something like subset of
> >> > cgroup-tools needed to run the test you also help us later
> >> > on to backtrack the kernel changes. With cgroups-tools you
> >> > would have to use strace to get the same info.
> >>
> >> FWIW, see also functions in
> >> tools/testing/selftests/cgroup/cgroup_util.{h,c}.
> >> They likely cover what you need already -- if the tests are in C.
> >>
> >> (I admit that stuff in tools/testing/selftests/cgroup/ is best
> >> understood with strace.)
> >
> > Thanks!
> >
> > My conclusions are that:
> >
> > 1. We probably cannot move the test part of cgroup test itself
> >    given the enclave payload dependency.
> > 2. I think it makes sense to still follow the same pattern as
> >    other cgroups test and re-use cgroup_util.[ch] functionaltiy.
> >
> > So yeah I guess we need two test programs instead of one.
> >
> > Something along the lines:
> >
> > 1. main.[ch] -> test_sgx.[ch]
> > 2. introduce test_sgx_cgroup.c
> >
> > And test_sgx_cgroup.c would be implement similar test as the shell
> > script and would follow the structure of existing cgroups tests.
> >
> >>
> >> HTH,
> >> Michal
> >
> > BR, Jarkko
> >
> Do we really want to have it implemented in c? There are much fewer lines=
 =20
> of code in shell scripts. Note we are not really testing basic cgroup =20
> stuff. All we needed were creating/deleting cgroups and set limits which =
I =20
> think have been demonstrated feasible in the ash scripts now.
>
> Given Dave's comments, and test scripts being working and cover the cases=
 =20
> needed IMHO, I don't see much need to move to c code. I can add more case=
s =20
> if needed and fall back a c implementation later  if any case can't be =
=20
> implemented in scripts. How about that?

We can settle to: ash + no dependencies. I guess you have for that
all the work done already.

BR, Jarkko

