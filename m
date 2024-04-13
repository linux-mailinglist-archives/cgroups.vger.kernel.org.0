Return-Path: <cgroups+bounces-2471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0A88A3E8D
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B849B2814AE
	for <lists+cgroups@lfdr.de>; Sat, 13 Apr 2024 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4053E3B;
	Sat, 13 Apr 2024 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLA6zCxA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232F3FF4;
	Sat, 13 Apr 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713041807; cv=none; b=EPXuKOpoO1lMhCztNF5ABi3pq1a6LrqCbPjARsIKueYkhoc3IQZo4fSC4Jw71joHiRJhBhAIQ1t3fnCjsUg9wVc3+aLBqQTrI61sytSFUSidnch3HkIOMBWZouAN0rI+I9vHQhHTbRR6dQ5T6Q+PyNyi0X9WhOIL03O5pBrRVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713041807; c=relaxed/simple;
	bh=j6SPsFOqCMJ2cexdWS6A1CoYES7H/ZCka9uTlYN0nGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OwptOwF8zQocyzFDarTe9ibAKNGCJI0mcVcIQj/J/JBXJrtyhQtsjeczNLG0phPnEhc0Z0+Rn7iVpbQ1eu7YKhW3r0rEjVGNuG3zBRG9QyaC8PAdmw3wrzSfKS8XR2V8lVviPrwRK49uoAzAdSfZ8b5yYsyXMMontGE/bcfD9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLA6zCxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB8C113CD;
	Sat, 13 Apr 2024 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713041806;
	bh=j6SPsFOqCMJ2cexdWS6A1CoYES7H/ZCka9uTlYN0nGw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=oLA6zCxAvYFwl6Zc67W9UlBsuofL84TItfzvWvZC+srQ2cYuTJo4hDcOw4kBEMrjw
	 fFY3cSjqj20Z7EvBJWTJdcLns6o9++IALyTWoKwq2vRgSGmqMbya17JpavOSbmg0fv
	 OWYO1FINy1RwOgqwdtfWhhBBUHLYbaxe74Xfm/njE/fsoLHp5b4tv/2gPFlxB4ikhY
	 wfbNZRmwVLv1m/zNf4onr4rR+jx/BBxlYaJB4TG3XSZuG8g149XFbNVdpkISMtukYO
	 T1FFI89SsrIraaBY2M3Kuvg2979AqUMfDtb2k9hiJI2St9FCL3HFkRxYfPdAK031bW
	 c/9LqCkkqpmQg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Apr 2024 23:56:40 +0300
Message-Id: <D0JAMYT1JE4V.77DDGSKD7AL1@kernel.org>
To: "Huang, Kai" <kai.huang@intel.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "haitao.huang@linux.intel.com"
 <haitao.huang@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-9-haitao.huang@linux.intel.com>
 <e616e520b021e2e7ac385b5b1c41febb781706de.camel@intel.com>
 <op.2lpq2mtswjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <0e406b207c7769359d45ba4e4594174e64ec3faa.camel@intel.com>
In-Reply-To: <0e406b207c7769359d45ba4e4594174e64ec3faa.camel@intel.com>

On Fri Apr 5, 2024 at 6:07 AM EEST, Huang, Kai wrote:
> On Thu, 2024-04-04 at 12:05 -0500, Haitao Huang wrote:
> > > > -static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg)
> > > > +static inline int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg,=
=C2=A0=20
> > > > enum sgx_reclaim r)
> > >=20
> > > Is the @r here intentional for shorter typing?
> > >=20
> >=20
> > yes :-)
> > Will speel out to make it consistent if that's the concern.
>
> I kinda prefer the full name to match the CONFIG_CGROUP_SGX_EPC on case. =
 You
> can put the 'enum sgx_reclaim reclaim' parameter into the new line if nee=
ded:

Why don't cgroups for SGX get always enabled when SGX and
cgroups support are enabled?

BR, Jarkko

