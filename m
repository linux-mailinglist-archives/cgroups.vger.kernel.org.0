Return-Path: <cgroups+bounces-3037-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4938D296C
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 02:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB21F24F08
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 00:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1560814EC51;
	Wed, 29 May 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="GSonjAsk"
X-Original-To: cgroups@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7D14EC4B
	for <cgroups@vger.kernel.org>; Wed, 29 May 2024 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716942511; cv=none; b=dgZNgpDnhF7r4ZUryB+zfa+vvNBqt3uhWMgt8kaZGPxqcofMGX3fjHlUU7kdVeIFtME0JMC3uFUwOCTBhoVghgqHgLEVctHf3WnMqDYWdTDyTuvaRe9LxU4HOgyZoLRdWeA9wsbAfkr32CFp/i21TDpoIrR2YVFPnSjMSh2Akzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716942511; c=relaxed/simple;
	bh=mWKYaLBCgloBtsKyJpIKSnQfAIG3izItf/nuVca2yjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnccLJ4NRhXcpJddve/AtS4XwEmzdAyebOYIcJ35CSqYVhUBHbfFWowRMNgeVqrbW19nhT+0n77KGrFU17bvoJK6LsXe3JbS5NulhPBpkHd1XMVyYI3WY27a43MW4YaZmXcA4miVel9oyoVmaVv0fJvuwmJiqyTv8QD5u87G+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=GSonjAsk; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1716942509;
	bh=mWKYaLBCgloBtsKyJpIKSnQfAIG3izItf/nuVca2yjg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GSonjAsk+0Ic66n0qTJseDdGfqRlb5+Daz7/COtlDmYg/PFYEIoY8MAN9iO+MOAt6
	 0wSX5YFebEEpbXzBDZilMLNR4GcjIlWykh6i6jiRO+Q2o2+nz4X1Qk9UTzXOTCX1DJ
	 iZbNCkIpaEsFoynK9mBC/KsR12K9a9lzGcUpPyyY=
Received: from [IPv6:240e:358:1124:5500:dc73:854d:832e:5] (unknown [IPv6:240e:358:1124:5500:dc73:854d:832e:5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E3D5E676C9;
	Tue, 28 May 2024 20:28:26 -0400 (EDT)
Message-ID: <0eed02905b2b4554b429b080a7c88b35c9bba30b.camel@xry111.site>
Subject: Re: [tj-cgroup:for-next] BUILD REGRESSION
 a8d55ff5f3acf52e6380976fb5d0a9172032dcb0
From: Xi Ruoyao <xry111@xry111.site>
To: Tejun Heo <tj@kernel.org>, kernel test robot <lkp@intel.com>
Cc: cgroups@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Date: Wed, 29 May 2024 08:28:23 +0800
In-Reply-To: <ZlY1gDDPi_mNrwJ1@slm.duckdns.org>
References: <202405271606.DYMCKs25-lkp@intel.com>
	 <ZlY1gDDPi_mNrwJ1@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 09:50 -1000, Tejun Heo wrote:
> (cc'ing loongarch folks)
>=20
> On Mon, May 27, 2024 at 04:14:10PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.=
git=C2=A0for-next
> > branch HEAD: a8d55ff5f3acf52e6380976fb5d0a9172032dcb0=C2=A0 kernel/cgro=
up: cleanup cgroup_base_files when fail to add cgroup_psi_files
> >=20
> > Error/Warning reports:
> >=20
> > https://lore.kernel.org/oe-kbuild-all/202405270728.d1SabzhU-lkp@intel.c=
om
> >=20
> > Error/Warning: (recently discovered and may have been fixed)
> >=20
> > kernel/cgroup/pids.o: warning: objtool: __jump_table+0x0: special: can'=
t find orig instruction
> >=20
> > Error/Warning ids grouped by kconfigs:
> >=20
> > gcc_recent_errors
> > `-- loongarch-defconfig
> > =C2=A0=C2=A0=C2=A0 `-- kernel-cgroup-pids.o:warning:objtool:__jump_tabl=
e:special:can-t-find-orig-instruction
>=20
> I don't know what to make of this build warning. I can't reproduce the
> problem on x86 and the referenced commit doesn't have anything special. I=
t
> *looks* like it could be something specific to loongarch. Can you guys
> please take a look?

For now on LoongArch objtool does not work well with jump tables.  We
already have:

ifdef CONFIG_OBJTOOL
KBUILD_CFLAGS           +=3D -fno-jump-tables
endif

So why this doesn't stop GCC from producing a jump table?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

