Return-Path: <cgroups+bounces-1143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929D82CEB1
	for <lists+cgroups@lfdr.de>; Sat, 13 Jan 2024 22:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AC91C21151
	for <lists+cgroups@lfdr.de>; Sat, 13 Jan 2024 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FEA10797;
	Sat, 13 Jan 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvJHloTA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D406D39;
	Sat, 13 Jan 2024 21:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C547DC433C7;
	Sat, 13 Jan 2024 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705180114;
	bh=/TNLO2AHSSeY1QxNIwdHcGp50JbrIeyM7eeOvhR2GEA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hvJHloTA1IJhePcatJ6eiLNfNpvj0yzXV5lKofDa1YcDnMtNhwb/iAUKN0vh7x862
	 uff1qyVsKlevQsSjro5hRG6VygRTK8vG7KGpb9e+4rEGwHwCiF01whUXL3zMiiqOVE
	 fxUWTy3lwuTgeaiAvtOqAjojnJzHrsn1GExoI9IxxgCSM/X4ve2yMZc4pNcgZXCfRc
	 s0FSb4NBdzRP+PUXMvbx43FrIf7zmY8kfvMU6DqeBLHMU1XVrVUJUrj4HK6Up53r4t
	 7bgHUpxqHT5Yw1DbheEynG/RtjZZLWsXIvVP0rj1i8bWBKG40YyBiWbfZgoRKjRX3O
	 1tEvN4YuctynA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 23:08:27 +0200
Message-Id: <CYDVWF9BY27K.2MXXROH30QHBT@kernel.org>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Haitao Huang"
 <haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org" <tj@kernel.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "anakrish@microsoft.com" <anakrish@microsoft.com>,
 "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>
X-Mailer: aerc 0.16.0
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
 <op.2hf1t7sywjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CYDVTPABVUJK.1BTJY8YUF9WPI@kernel.org>
In-Reply-To: <CYDVTPABVUJK.1BTJY8YUF9WPI@kernel.org>

On Sat Jan 13, 2024 at 11:04 PM EET, Jarkko Sakkinen wrote:
> On Fri Jan 12, 2024 at 7:07 PM EET, Haitao Huang wrote:
> > On Sun, 17 Dec 2023 19:44:56 -0600, Huang, Kai <kai.huang@intel.com> wr=
ote:
> >
> > >
> > >> >
> > >> > The point is, with or w/o this patch, you can only reclaim 16 EPC =
=20
> > >> pages
> > >> > in one
> > >> > function call (as you have said you are going to remove
> > >> > SGX_NR_TO_SCAN_MAX,
> > >> > which is a cipher to both of us).  The only difference I can see i=
s,
> > >> > with this
> > >> > patch, you can have multiple calls of "isolate" and then call the
> > >> > "do_reclaim"
> > >> > once.
> > >> >
> > >> > But what's the good of having the "isolate" if the "do_reclaim" ca=
n =20
> > >> only
> > >> > reclaim
> > >> > 16 pages anyway?
> > >> >
> > >> > Back to my last reply, are you afraid of any LRU has less than 16 =
=20
> > >> pages
> > >> > to
> > >> > "isolate", therefore you need to loop LRUs of descendants to get 1=
6?
> > >> > Cause I
> > >> > really cannot think of any other reason why you are doing this.
> > >> >
> > >> >
> > >>
> > >> I think I see your point. By capping pages reclaimed per cycle to 16=
,
> > >> there is not much difference even if those 16 pages are spread in =
=20
> > >> separate
> > >> LRUs . The difference is only significant when we ever raise that ca=
p. =20
> > >> To
> > >> preserve the current behavior of ewb loops independent on number of =
LRUs
> > >> to loop through for each reclaiming cycle, regardless of the exact v=
alue
> > >> of the page cap, I would still think current approach in the patch i=
s
> > >> reasonable choice.  What do you think?
> > >
> > > To me I won't bother to do that.  Having less than 16 pages in one LR=
U is
> > > *extremely rare* that should never happen in practice.  It's pointles=
s =20
> > > to make
> > > such code adjustment at this stage.
> > >
> > > Let's focus on enabling functionality first.  When you have some real
> > > performance issue that is related to this, we can come back then.
> > >
> >
> > I have done some rethinking about this and realize this does save quite=
 =20
> > some significant work: without breaking out isolation part from =20
> > sgx_reclaim_pages(), I can remove the changes to use a list for isolate=
d =20
> > pages, and no need to introduce "state" such as RECLAIM_IN_PROGRESS. Ab=
out =20
> > 1/3 of changes for per-cgroup reclamation will be gone.
> >
> > So I think I'll go this route now. The only downside may be performance=
 if =20
> > a enclave spreads its pages in different cgroups and even that is minim=
um =20
> > impact as we limit reclamation to 16 pages a time. Let me know if someo=
ne =20
> > feel strongly we need dealt with that and see some other potential issu=
es =20
> > I may have missed.
>
> We could deal with possible performance regression later on (if there
> is need). I mean there should we a workload first that would so that
> sort stimulus...

I.e. no reason to deal with imaginary workload :-) Go ahead and we'll
go through it.

BR, Jarkko

