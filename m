Return-Path: <cgroups+bounces-2301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82A1897596
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635FD28E205
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882A1514CC;
	Wed,  3 Apr 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4SwTRHj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813DC1E520;
	Wed,  3 Apr 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162783; cv=none; b=nTvu22szWk0GasX4wUpfWcSnlR4b4o1IJ5l3nFKFmSkKKw1tSPuGgkPX9vYBRrvHMtBxA4AwipLk1u9K/0qoWrrY2xI3f3vXnT0Wwyt1YkgBA3kNL9DomRtsYie2UYTbN/nK+SGQiasEzXQeuvw+8IF3odNOQoylyLH5UPYjkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162783; c=relaxed/simple;
	bh=B/9drZEy5S7WaOtGfUFnN3ljHMB28vjUwWZEPvQmAzs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pxjf9gjmBTR+EV1PEeoSaZiH8xNn9xcTUA23q5ITvk2rF32JuLySrPMtPOSqANRoKJOTiLkmE1nihc5OWfHUI8OG8P1cTM3/ye1k7c5o7hCSZqPhrV+Mkz7vlHLMEoJc9MHmQcGgTarytZLi8nS6H4lVJwYG4k/IrRKtMmk5fUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4SwTRHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D15C433C7;
	Wed,  3 Apr 2024 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712162783;
	bh=B/9drZEy5S7WaOtGfUFnN3ljHMB28vjUwWZEPvQmAzs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=L4SwTRHjmdR1/Qm+gnsbFIb+8kkfUzw6rTiDJKE7UPZPxH4gNNm+3sU0kcBkpsx5Z
	 EQNr5evYNvWZ8XDpgCLbsHVpyM07Gwems6ZXP1on/v99RFs7Ra0FLnbo0nTkCohCJc
	 Mi4mIzn7YOoQpadDZ4PCRjHpXpU/0Ar9tFzGm6hQfW9s58dC94hPzojlL3flT6GwAb
	 RIrbkgq9EAVotXFnjJQyInDO+7tggRGZF0erEspN+E1D2wTjRspk7XLF4PKbOUsvzh
	 SX4xMOPMJIS53qRuSqsOwcOOCeN4JvC2PSP9A0BQXHQwsYjc05Fp1eXhE6mmIitsFR
	 4IDS8uXbgnTQA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 19:46:16 +0300
Message-Id: <D0AN1T7IQCB6.3L1IV1UFGMBV1@kernel.org>
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
To: =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, "Haitao Huang"
 <haitao.huang@linux.intel.com>
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
 <yjremy4leipriqfd547wvjd6jt3r6t4tgz36eazy3slfuew4mc@v4iye7sm7yqn>
In-Reply-To: <yjremy4leipriqfd547wvjd6jt3r6t4tgz36eazy3slfuew4mc@v4iye7sm7yqn>

On Tue Apr 2, 2024 at 8:40 PM EEST, Michal Koutn=C3=BD wrote:
> On Tue, Apr 02, 2024 at 11:20:21AM -0500, Haitao Huang <haitao.huang@linu=
x.intel.com> wrote:
> > Do we really want to have it implemented in c?
>
> I only pointed to the available C boilerplate.
>
> > There are much fewer lines of
> > code in shell scripts. Note we are not really testing basic cgroup stuf=
f.
> > All we needed were creating/deleting cgroups and set limits which I thi=
nk
> > have been demonstrated feasible in the ash scripts now.
>
> I assume you refer to
> Message-Id: <20240331174442.51019-1-haitao.huang@linux.intel.com>
> right?
>
> Could it be even simpler if you didn't stick to cgtools APIs and v1
> compatibility?
>
> Reducing ash_cgexec.sh to something like
> 	echo 0 >$R/$1/cgroup.procs
> 	shift
> 	exec "$@"
> (with some small builerplate for $R and previous mkdirs)

I already asked about necessity of v1 in some response, and fully
support this idea. Then cgexec can simply be a function wrapping
along the lines what you proposed.

BR, Jarkko

