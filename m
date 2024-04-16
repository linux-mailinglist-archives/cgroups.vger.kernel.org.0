Return-Path: <cgroups+bounces-2533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350568A70E6
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52182826B6
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D302131E43;
	Tue, 16 Apr 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhagbXCz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBB131BDD;
	Tue, 16 Apr 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283698; cv=none; b=pKs1uaCPXKo1KT8arOStVkgAG8Gzi9RF0apur6gf+BWWi2+rRsLyjJp9z7ZzVUcwWo2mVeQ+fesvqlLIinBSTC/G1NgjCElWukW1ARaRO5TJ9ecJaI5ZnLClV4HWCHGxCHnOY8MeqvMh5vMBeZnIqnPqvUMAWwqBHc6sBveQzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283698; c=relaxed/simple;
	bh=PJLq0XrYaYRd1MzbPb6vsiMs5P9JGkJsSUES+EWF2Zk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gi68ldA9SSAJ/IJHNUa8XW31ZXEknhcJMPA4f5B7/XPdIB0qwmknIOMRsbIadowsNFRBW7uUuex+FR53qA5I5cL7cdSwGFGL1Enp0yvhihSiEAZqu2X/5ccMJJ+5NUPcj0VUOpIifDK8AN0SfX29iGQWvGdwzL+wQMDgCzoS13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhagbXCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB10C2BD10;
	Tue, 16 Apr 2024 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713283698;
	bh=PJLq0XrYaYRd1MzbPb6vsiMs5P9JGkJsSUES+EWF2Zk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YhagbXCzAAb0dUE+MfDqKwLdPD1ZZQ457WK2mIuOXV1Ik877b0d1CIfrMCwS4u/Ni
	 pOg1frN0H/vxiyd5viVvXCkJCymWh27XGRmgHRcbzjGyeo9QYZAMQ+nOpcaJ9HbdHh
	 0YU8qwkMcjIhKPSMwyomBKCEJOtlBi2qNZBMEFXFDO8o7cwe5Q8zTi+V4eTZk6SgWT
	 TKbXrmlGXmUFCMYhkndBU1gUHmD+MXmNNwyYhn4wmwZ0/FTf3qhbLY7gUqN/ZeKz4i
	 Pc3TDlVyg4+iEye8mHNEft95wmTLXVDMyhsjBbegIxROISKssKLBva51i0M6vYo1D6
	 UlnEH2GeZyRwQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Apr 2024 19:08:11 +0300
Message-Id: <D0LODQCRSTRA.2KSPCDB0FLK0X@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org>
 <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
 <op.2mbs1m05wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mbs1m05wjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Tue Apr 16, 2024 at 5:54 PM EEST, Haitao Huang wrote:
> I did declare the configs in the config file but I missed it in my patch =
=20
> as stated earlier. IIUC, that would not cause this error though.
>
> Maybe I should exit with the skip code if no CGROUP_MISC (no more =20
> CGROUP_SGX_EPC) is configured?

OK, so I wanted to do a distro kernel test here, and used the default
OpenSUSE kernel config. I need to check if it has CGROUP_MISC set.

> tools/testing/selftests$ find . -name README
> ./futex/README
> ./tc-testing/README
> ./net/forwarding/README
> ./powerpc/nx-gzip/README
> ./ftrace/README
> ./arm64/signal/README
> ./arm64/fp/README
> ./arm64/README
> ./zram/README
> ./livepatch/README
> ./resctrl/README

So is there a README because of override timeout parameter? Maybe it
should be just set to a high enough value?

BR, Jarkko

