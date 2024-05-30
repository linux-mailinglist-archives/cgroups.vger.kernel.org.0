Return-Path: <cgroups+bounces-3042-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568378D4E49
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137762836FE
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7E17D891;
	Thu, 30 May 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYQ+PDl8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B217C237
	for <cgroups@vger.kernel.org>; Thu, 30 May 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080422; cv=none; b=fDoEVu3dxQkNvM0JMf2EDR2HXwPau5M//1L4yyPcdNvW8bZ44RdPOUOAWIMaFFRdIIOPLJQn5ggjkCwuRwiiUXIQqCMUULUeL2rG5gtinOnfAR5Y6ZtDiHkkKbDr6o8rtKe7mudjeXpkQLPGEUkkT0DwiRMmGTaWQonZ5ZCE4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080422; c=relaxed/simple;
	bh=PKGD7n9IHlCmuoHyMmsNI3hO3fv1iDnzWTZNDrREJw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fgi0EoIBfpBGrMM1zZXais9utKG6dPliybnshEeIrPmD8VNo7+/jrBLFnknX+T2mwot2t+vO8pmxJ24VyC6et/6l4tygbFluq3OQ0nnb9cy3Tr2u5a2hDhTBuohPxZVkJrohvDlS++9SZEeaBzK5O/6Ck/IjgavKE69xSES+K/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYQ+PDl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA88C32789
	for <cgroups@vger.kernel.org>; Thu, 30 May 2024 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080422;
	bh=PKGD7n9IHlCmuoHyMmsNI3hO3fv1iDnzWTZNDrREJw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NYQ+PDl8PjsPJ6T3kXrSirK19nblB/O2P9nGNWClObJICQ6ZucZVQ9K8FiDjhRO12
	 IU73UPIFQSxBODUkmv4rqfQanr8/ctuSbOMtbGiuvnoYNfq4FkzzDDBuztEPmnbvoG
	 bST0CFkRpEnl5f8mopf7iXK9PdsdOvWKW4OYjo2yEftklLu5GKY+N8lPQlTmtZemtm
	 p7js5w8tPExTFiqZh9rzE1Futac3gF+Pg4TnNv7W5cqElpzMDTq6baNxQRCgaxZf1l
	 nTON2DpvvF/xEfs5rxcFYFBtD6ktPhKHrNMbCCcr/10yoi9lGCAJz0l0Fp7J5F7eDE
	 pQVKHzNox4HnA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so963886a12.2
        for <cgroups@vger.kernel.org>; Thu, 30 May 2024 07:47:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4139szdbWKLHycybiZxrFWrJv72EraSB4wi2/tx6vqWyRd4NgpJPe3iXB4MyCBGjkX6YV3/G60ZA7SjO8RZNfrF6f8sXbNQ==
X-Gm-Message-State: AOJu0YwuJhfASQ29iXdHCu1pvXo0UxHINjWNsLgDLj4M/J5PKDzEz0TX
	0J330dBG+IdDSoDxXdTNyiGBsTU0f+h7CMMel2+myxi3zpA8V7ID9RM9I8ylChMKNG506lDN/t9
	LUuwlq3ph2VDTPYEViiTdTHr5I2E=
X-Google-Smtp-Source: AGHT+IENmn6mtzTr1APrCtX5mi2KjfYAkYH8yBjU8IgbS1wGLME84pJdqa9AB/cpTTqoXMZn1W5nvwPnDcPfqsJqOjU=
X-Received: by 2002:a17:906:b49:b0:a63:3170:14ae with SMTP id
 a640c23a62f3a-a65e8e321eemr164026966b.9.1717080420648; Thu, 30 May 2024
 07:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405271606.DYMCKs25-lkp@intel.com> <ZlY1gDDPi_mNrwJ1@slm.duckdns.org>
 <0eed02905b2b4554b429b080a7c88b35c9bba30b.camel@xry111.site>
In-Reply-To: <0eed02905b2b4554b429b080a7c88b35c9bba30b.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 30 May 2024 22:46:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ZbDZ12VbXo1+kHHLjxGO-=DvHU9mchg3e9RH1zGCZWA@mail.gmail.com>
Message-ID: <CAAhV-H5ZbDZ12VbXo1+kHHLjxGO-=DvHU9mchg3e9RH1zGCZWA@mail.gmail.com>
Subject: Re: [tj-cgroup:for-next] BUILD REGRESSION a8d55ff5f3acf52e6380976fb5d0a9172032dcb0
To: Xi Ruoyao <xry111@xry111.site>
Cc: Tejun Heo <tj@kernel.org>, kernel test robot <lkp@intel.com>, cgroups@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 8:28=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Tue, 2024-05-28 at 09:50 -1000, Tejun Heo wrote:
> > (cc'ing loongarch folks)
> >
> > On Mon, May 27, 2024 at 04:14:10PM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgrou=
p.git for-next
> > > branch HEAD: a8d55ff5f3acf52e6380976fb5d0a9172032dcb0  kernel/cgroup:=
 cleanup cgroup_base_files when fail to add cgroup_psi_files
> > >
> > > Error/Warning reports:
> > >
> > > https://lore.kernel.org/oe-kbuild-all/202405270728.d1SabzhU-lkp@intel=
.com
> > >
> > > Error/Warning: (recently discovered and may have been fixed)
> > >
> > > kernel/cgroup/pids.o: warning: objtool: __jump_table+0x0: special: ca=
n't find orig instruction
> > >
> > > Error/Warning ids grouped by kconfigs:
> > >
> > > gcc_recent_errors
> > > `-- loongarch-defconfig
> > >     `-- kernel-cgroup-pids.o:warning:objtool:__jump_table:special:can=
-t-find-orig-instruction
> >
> > I don't know what to make of this build warning. I can't reproduce the
> > problem on x86 and the referenced commit doesn't have anything special.=
 It
> > *looks* like it could be something specific to loongarch. Can you guys
> > please take a look?
>
> For now on LoongArch objtool does not work well with jump tables.  We
> already have:
>
> ifdef CONFIG_OBJTOOL
> KBUILD_CFLAGS           +=3D -fno-jump-tables
> endif
>
> So why this doesn't stop GCC from producing a jump table?
We cannot produce this warning, but currently objtool indeed cannot
work with -jump-table, and we are investigate to solve it, which may
take some time.

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

