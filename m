Return-Path: <cgroups+bounces-2565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08DA8A8EF0
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 00:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EDA1C213FF
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253817F47D;
	Wed, 17 Apr 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAquAmT0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2F3B185;
	Wed, 17 Apr 2024 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394006; cv=none; b=byrtP9JliMNSrCIoyrltNsNsk5m2U8vU7jBYaxMWHac929xSHV4MGrI1r3mBpf1Aq9QbSU9f2EfDVLxa0a2fClF4Mz3nnNzKOdOK1EFj4oNQ8xpzkNGVXxQqgQQHAZfEvlF5S9UnjT5RxWHzlUU3MRmpNfiO5Y/gcmgRzYHBM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394006; c=relaxed/simple;
	bh=MIDX0H6Lav5IAFHKwaj/d7Z/C9V/WUYI8QaX/XHSBu8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fkTJfU9kB/hW/+n1GcDlaAafNzFMByXwmViegoZsnv1eKJ3Kkwum0xqBC/SkRUeM/19S4Zj0AkS5mD0CwxKwuMXgqDi/kjHHyrbslyJSLT2gS8JoFdC7FbridjDVLVWT8JIkYnizMm7BnQ0zweTfviCc9OnoAdG7Jv0z/y+QOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAquAmT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9669C072AA;
	Wed, 17 Apr 2024 22:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713394006;
	bh=MIDX0H6Lav5IAFHKwaj/d7Z/C9V/WUYI8QaX/XHSBu8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=hAquAmT0PZYzYuQcF6JfLAJ0IVvORi02bo02Z0S4qYsiI/WAsrP5YnaoGZbHtSbUe
	 POr+NjCknW3l88iQOwPlrqmmK/J601IYplltcWhEPq5CvF4Lm/iJUUF922/P6redwe
	 SpOGzDsN3YcshF+AyZcecLX5pYB7VqFuI9gMX2LZ6AlzkR07Knc2Xj7zR1RoHNVE+M
	 i4qVANmUtxnslz1z9PFMjf/zPKKCZYqEiB+ffx6Vd+xcV9PdCxiSYs1fzgD4S5p+rP
	 2LwTKktm0TymKAqI7IgLLxb7eiTQF0IOnEdF5xQiH54hyFzU0+o7/15SVyTvm5aZxI
	 Etsqs5J9Cvv/Q==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 01:46:39 +0300
Message-Id: <D0MRHD4ZH2L4.1AYKI3TJGO2LV@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org>
 <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
 <op.2mbs1m05wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D0LODQCRSTRA.2KSPCDB0FLK0X@kernel.org>
 <op.2mccxje2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mccxje2wjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Wed Apr 17, 2024 at 1:04 AM EEST, Haitao Huang wrote:
> On Tue, 16 Apr 2024 11:08:11 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Tue Apr 16, 2024 at 5:54 PM EEST, Haitao Huang wrote:
> >> I did declare the configs in the config file but I missed it in my pat=
ch
> >> as stated earlier. IIUC, that would not cause this error though.
> >>
> >> Maybe I should exit with the skip code if no CGROUP_MISC (no more
> >> CGROUP_SGX_EPC) is configured?
> >
> > OK, so I wanted to do a distro kernel test here, and used the default
> > OpenSUSE kernel config. I need to check if it has CGROUP_MISC set.
> >
> >> tools/testing/selftests$ find . -name README
> >> ./futex/README
> >> ./tc-testing/README
> >> ./net/forwarding/README
> >> ./powerpc/nx-gzip/README
> >> ./ftrace/README
> >> ./arm64/signal/README
> >> ./arm64/fp/README
> >> ./arm64/README
> >> ./zram/README
> >> ./livepatch/README
> >> ./resctrl/README
> >
> > So is there a README because of override timeout parameter? Maybe it
> > should be just set to a high enough value?
> >
> > BR, Jarkko
> >
>
>
>  From the docs, I think we are supposed to use override.
> See: https://docs.kernel.org/dev-tools/kselftest.html#timeout-for-selftes=
ts

OK, fair enough :-) I did not know this.

BR, Jarkko

