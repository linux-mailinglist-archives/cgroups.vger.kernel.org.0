Return-Path: <cgroups+bounces-3111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D28FDEA1
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 08:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E739B1C24391
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE677104;
	Thu,  6 Jun 2024 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFYPckTw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F23A8CB;
	Thu,  6 Jun 2024 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654823; cv=none; b=bUcyfW44Cd00ms+8L3NSsgDGXdJ4w3Vlc7yIog6bEhPVrTV6ocmkmsOv2wYZafW3E31QAo3eCLnzBJWoesl/yuIpwMF1ZVBsF01kPxvYnIPMkKpnXC6AWNWI7L/h9616XrEwBWjxngK8EACMeHhlP/SgjDsdYmJNlpRIXLFfQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654823; c=relaxed/simple;
	bh=j0MquPfi/vCjoi1SmAsqOpd/5qF8sXpBLh7cch3Ljiw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PBak9+50exSNg+pszKa0jTUK28i+44GZrEmYgDbdC1of1iM1nyNz73VJnS36VSQ/6Rb8fISKKnlYpvOMwBurcjdjIzNq2CLu7qCEFI+dHgYeIAVTCJrvl9UJ/89UtDNMSXkk2J9abXGXzihbRIeARSRhR0J4pOhBwOX1JN8EPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFYPckTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D27C2BD10;
	Thu,  6 Jun 2024 06:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717654823;
	bh=j0MquPfi/vCjoi1SmAsqOpd/5qF8sXpBLh7cch3Ljiw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PFYPckTwPtlU2Q6yc2XxFDj1a4kOn7LPfgUd8jE1iMpKXfHW+p4h38pdWBX7uCPNg
	 ABNcAPIOO/0qVJu7MZE/2Fg8eB6PhV+VWJ9DDYy31koefpByBBW6mWzsjf/aL7Snae
	 e0ryAUwdMnZmWjWQkTJ+XhL/zAFSZjfUF4KuXUo51cHLCQTT2TkaykKB5/vVJRE7gN
	 U3FNRzkxCOu6fdVgBfZHYlI36zCkSRZ3IEu0d2lxSsk1HvZiUu9Z5ugzim4Zfn24al
	 DHI+HTxvuvHFx31ORBKtvNRE2gkE9XmgcLbZwpUPjHwsMwklbqsHetWUUu3Mofarqp
	 c6Nf3X3FhBifA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Jun 2024 09:20:16 +0300
Message-Id: <D1SPTDBBDU6F.2WLRZKYZWWTRB@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Huang, Kai" <kai.huang@intel.com>, "Haitao Huang"
 <haitao.huang@linux.intel.com>, <dave.hansen@linux.intel.com>,
 <tj@kernel.org>, <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.17.0
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7cbf3583-a23e-4437-afc2-1faeb4a1f436@intel.com>
In-Reply-To: <7cbf3583-a23e-4437-afc2-1faeb4a1f436@intel.com>

On Thu Jun 6, 2024 at 1:30 AM EEST, Huang, Kai wrote:
>
> >> Reorg:
> >>
> >> void sgx_cgroup_init(void)
> >> {
> >> =C2=A0=C2=A0=C2=A0=C2=A0struct workqueue_struct *wq;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0/* eagerly allocate the workqueue: */
> >> =C2=A0=C2=A0=C2=A0=C2=A0wq =3D alloc_workqueue("sgx_cg_wq", wq_unbound=
 | wq_freezable,=20
> >> wq_unbound_max_active);
> >> =C2=A0=C2=A0=C2=A0=C2=A0if (!wq) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("sgx_cg_wq creation=
 failed\n");
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > sgx_cgroup_try_charge() expects sgx_cg_wq, so it would break unless we=
=20
> > check and return 0 which was the initially implemented in v12. But then=
=20
> > Kai had some concern on that we expose all the interface files to allow=
=20
> > user to set limits but we don't enforce. To keep it simple we settled=
=20
> > down back to BUG_ON().=20
>
> [...]
>
> > This would only happen rarely and user can add=20
> > command-line to disable SGX if s/he really wants to start kernel in thi=
s=20
> > case, just can't do SGX.
>
> Just to be clear that I don't like BUG_ON() either.  It's inevitable you=
=20
> will get attention because of using it.

Just then plain disable SGX if it fails to start.

Do not take down the whole system.

> This is a compromise that you don't want to reset "capacity" to 0 when=20
> alloc_workqueue() fails.

BUG_ON() is not a "compromise".

> There are existing code where BUG_ON() is used during the kernel early=20
> boot code when memory allocation fails (e.g., see cgroup_init_subsys()),=
=20
> so it might be acceptable to use BUG_ON() here, but it's up to=20
> maintainers to decide whether it is OK.

When it is not possible continue to run the system at all, and only
then.

Here it is possible. Without SGX.

BR, Jarkko

