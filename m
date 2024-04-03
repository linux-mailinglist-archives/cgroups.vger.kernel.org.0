Return-Path: <cgroups+bounces-2295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D028973D6
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A811F27217
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441B814C5AC;
	Wed,  3 Apr 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm0Ybv9G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59426292;
	Wed,  3 Apr 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157376; cv=none; b=LFdBtmH2Aasco3G8YtTRb1bNNKJ7ewBS8MuE9kVQDpGbJhwJUp0S78sRtxh/QaHVsfcbXN1SePd2Hoss4V5ur2hogNxqw4435MwJlh63Jbs5KfrwMnrjW8faY266B51vX62oYnDlqtiXk0szczfLnucQgryzQLU7hw1sIF+0Zt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157376; c=relaxed/simple;
	bh=z3lQD5lgMachfwYyNrVW8WJbO2hEjtLyQulbSy5ojU0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=DYlKycI1y45RrXS7BT6oeGRRJoVB6yMRWA9YObiPIPSZZgwcFXB4AdBLM/6DnN+2QsMvm3GHBtcpfk7wjp5wPyeDAKNzP7nDN9PT3wZ2Yg/UQgEIDnv435OHGfnOVT9LYJNknLM0HHecTwhLapArQX+YzQFcSnoXHX91BaQk+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm0Ybv9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF34C433C7;
	Wed,  3 Apr 2024 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712157375;
	bh=z3lQD5lgMachfwYyNrVW8WJbO2hEjtLyQulbSy5ojU0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Nm0Ybv9GSWZkkgEyiuULaleJd2ST6xA9OgSewczf9SKZakwdUVS3HboknHyllu8MF
	 kFWTjqejWXJP5RVnNMHDah5KRw5glDItlYj6dxIHJhrAPxzGUfV5hFZ2wROKzcXdco
	 /6V6VTQqeYAtpQsjsbW8/rZd8ucVXgjwUEleGnhAVreBRcNBT9XjaB8W+JCwh1lC57
	 ndzmd97Xo/T2tZ3OwqWvn24On1MYKNGFXjQTzcu3PLTEk3fq2W7ZuZFSwGUuevTZQs
	 RZLLShcGwPfNq+Cm1oXQSmPikS9CYW6NsME3Kl7vUXUlIMa2oB+D6Jq+hpAWgSt6T1
	 CYBrKO5DCVIjA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 18:16:09 +0300
Message-Id: <D0AL4STCYS9S.2F0HJSH4E3M3B@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>, "Haitao Huang"
 <haitao.huang@linux.intel.com>, <dave.hansen@linux.intel.com>,
 <tj@kernel.org>, <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
 <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
 <op.2lbjl0oawjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D071OAFZ80O6.XEDXJ8AF4PK9@kernel.org>
 <18e84d04-0b75-4188-a94d-6b033f4edbf0@intel.com>
In-Reply-To: <18e84d04-0b75-4188-a94d-6b033f4edbf0@intel.com>

On Tue Apr 2, 2024 at 6:42 PM EEST, Dave Hansen wrote:
> On 3/30/24 04:23, Jarkko Sakkinen wrote:
> >>> I also wonder is cgroup-tools dependency absolutely required or could
> >>> you just have a function that would interact with sysfs?
> >> I should have checked email before hit the send button for v10 =F0=9F=
=99=82.
> >>
> >> It'd be more complicated and less readable to do all the stuff without=
 the =20
> >> cgroup-tools, esp cgexec. I checked dependency, cgroup-tools only depe=
nds =20
> >> on libc so I hope this would not cause too much inconvenience.
> > As per cgroup-tools, please prove this. It makes the job for more
> > complicated *for you* and you are making the job more  complicated
> > to every possible person in the planet running any kernel QA.
>
> I don't see any other use of cgroup-tools in testing/selftests.
>
> I *DO* see a ton of /bin/bash use though.  I wouldn't go to much trouble
> to make the thing ash-compatible.
>
> That said, the most important thing is to get some selftests in place.
> If using cgroup-tools means we get actual, runnable tests in place,
> that's a heck of a lot more important than making them perfect.
> Remember, almost nobody uses SGX.  It's available on *VERY* few systems
> from one CPU vendor and only in very specific hardware configurations.

Ash-compatible is good enough for me, so let's draw the line there.

Ash-compatibility does not cause any major hurdle as can we seen from
Haitao's patch. Earlier version was not even POSIX-compatible, given
that it used hard-coded path.

Most of the added stuff come open coding the tools but in the test
code that is not the big deal, and helps with debugging in the future.
Even right now it helps reviewing kernel patches because it documents
exactly how the feature is seen from user space.

BR, Jarkko

