Return-Path: <cgroups+bounces-2267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57602894CBC
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 09:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B16280F30
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B9D3BBC3;
	Tue,  2 Apr 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+MXyVQi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565438DFC;
	Tue,  2 Apr 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043443; cv=none; b=D+M64flo6/OInlH974iqB0dpLOe4iuVRH2GAGdM8jaHXK9qj4C5ZhE+trfG+GZ/zeN+T+9R5SVOnljrd0aauDOSF0J4UtjT5ppgkfdRySMkri91WukoMJC2SddB1yDqRmmGw9xRk9Fdv6VakWfzzE35D2ntyXgaaNQxlXgjhGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043443; c=relaxed/simple;
	bh=cH+r679GLg7sc3w++DZ/mMD0Uay9boc3WR6bkpgvMkI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GlMVRwNmBJEnNPOabD8WhP9t0rayTe5sl7dVywC5W+06qNR6tMWB4AKdA346csGoVht6vNRmwbSMgYp27vq+eIv1ghQYpa/y3O11qduMjU90JkyXwdsFOXZMwL4aBIJ0+DoAl4j4Vk3fag46TTdDSzAcKAhfT1UWVY8twktoo8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+MXyVQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83778C43390;
	Tue,  2 Apr 2024 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712043443;
	bh=cH+r679GLg7sc3w++DZ/mMD0Uay9boc3WR6bkpgvMkI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=i+MXyVQi5q4SpByi/8aZTmrvtlUfV2LRzv0Mv4BqzTeE5SYvxZPgE/mluTtq/MRaT
	 Iu/aIvj6yv1AAxHOTxaxRRp09DQ02ikbHXR+XUlxHBjvw3zl3rOwWtC1ajKLtYmBlG
	 eeyegtNehG8qXFHFebXKWATvSdmEcvOkQtYSZ2QT/5Rcl2F/rF6u5hWpIHdQjSdm8Y
	 Hr7AJxEVJAVT8tvVe6sUJwyzEOuZic/VFaWN6+Xb9k6WizS++Fx453oazLA9DJFWGr
	 f8UEmXZmyb71xtG6Uq543QyoaGCcYy0cj2mVxdQG9zlj0rN8QU3KukToaZKyju1fum
	 SjTvtnVSep81Q==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Apr 2024 10:37:16 +0300
Message-Id: <D09GQWZOJDCJ.1NTCEQPH0H5ZJ@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>
Cc: <anakrish@microsoft.com>, <bp@alien8.de>, <cgroups@vger.kernel.org>,
 <chrisyan@microsoft.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
 <kai.huang@intel.com>, <kristen@linux.intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <mikko.ylinen@linux.intel.com>, <mingo@redhat.com>, <mkoutny@suse.com>,
 <seanjc@google.com>, <sohil.mehta@intel.com>, <tglx@linutronix.de>,
 <tim.c.chen@linux.intel.com>, <tj@kernel.org>, <x86@kernel.org>,
 <yangjie@microsoft.com>, <zhanb@microsoft.com>, <zhiquan1.li@intel.com>
Subject: Re: [PATCH] selftests/sgx: Improve cgroup test scripts
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <D071SWVSOJLN.2C9H7NTS4PHGI@kernel.org>
 <20240331174442.51019-1-haitao.huang@linux.intel.com>
 <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
 <op.2lkm90y3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lkm90y3wjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Tue Apr 2, 2024 at 1:55 AM EEST, Haitao Huang wrote:
> On Mon, 01 Apr 2024 09:22:21 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Sun Mar 31, 2024 at 8:44 PM EEST, Haitao Huang wrote:
> >> Make cgroup test scripts ash compatible.
> >> Remove cg-tools dependency.
> >> Add documentation for functions.
> >>
> >> Tested with busybox on Ubuntu.
> >>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >
> > I'll run this next week on good old NUC7. Thank you.
> >
> > I really wish that either (hopefully both) Intel or AMD would bring up
> > for developers home use meant platform to develop on TDX and SNP. It is
> > a shame that the latest and greatest is from 2018.
> >
> > BR, Jarkko
> >
>
> Argh, missed a few changes for v2 cgroup:
>
> --- a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> @@ -15,6 +15,8 @@ CG_MEM_ROOT=3D/sys/fs/cgroup
>   CG_V1=3D0
>   if [ ! -d "/sys/fs/cgroup/misc" ]; then
>       echo "# cgroup V2 is in use."
> +    echo "+misc" >  $CG_MISC_ROOT/cgroup.subtree_control
> +    echo "+memory" > $CG_MEM_ROOT/cgroup.subtree_control
>   else
>       echo "# cgroup V1 is in use."
>       CG_MISC_ROOT=3D/sys/fs/cgroup/misc
> @@ -26,6 +28,11 @@ mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB2
>   mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB3
>   mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB4
>
> +if [ $CG_V1 -eq 0 ]; then
> +echo "+misc" >  $CG_MISC_ROOT/$TEST_ROOT_CG/cgroup.subtree_control
> +echo "+misc" >  $CG_MISC_ROOT/$TEST_CG_SUB1/cgroup.subtree_control
> +fi

Maybe it would be most convenient just to +1 the kselftest patch?

Alternatively you could point out to a Git branch with the series
and the updated patch.

BR, Jarkko

