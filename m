Return-Path: <cgroups+bounces-1142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B4D82CEAE
	for <lists+cgroups@lfdr.de>; Sat, 13 Jan 2024 22:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA98C283ABC
	for <lists+cgroups@lfdr.de>; Sat, 13 Jan 2024 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66210796;
	Sat, 13 Jan 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYV8Ky+6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D180107A6;
	Sat, 13 Jan 2024 21:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86632C433C7;
	Sat, 13 Jan 2024 21:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705179900;
	bh=ux54uZJWkkoZPaHx5sQX6OQDNhSpfNHWw1t1XFJcD8w=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=rYV8Ky+6NziqG3w22urj/CYOfZu/nLd+f3GZpyP+b35d4r+ZbLzAbY+zmq9BM7gd9
	 mIFtAAaRQ+j/xDVLJXr7OfT6W21TKrbUM6AFG1bffoOPCNzbeFFHwc63J0hGnWXNUN
	 YrnhEF0Mt6Nk36cqXS01+6x5mD/XIzcZOXUflI6VbRqZ9LzWcecWP0DJKxPNC1zOUl
	 YiwL+bMUooPZqwLoNX4OlVfJrCHIhM0JYX48nhRbPV78iuMjI0PFZwG2zaXLCA/TK6
	 TgSsq2EfvmWclH++2bZpaHe0UhKDyTHbpA5pWWoR+d//iyJmU5pKBp4hg3wjW+Yar9
	 scLX6fY1SYfiA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 23:04:54 +0200
Message-Id: <CYDVTPABVUJK.1BTJY8YUF9WPI@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
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
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
In-Reply-To: <op.2hf1t7sywjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Fri Jan 12, 2024 at 7:07 PM EET, Haitao Huang wrote:
> On Sun, 17 Dec 2023 19:44:56 -0600, Huang, Kai <kai.huang@intel.com> wrot=
e:
>
> >
> >> >
> >> > The point is, with or w/o this patch, you can only reclaim 16 EPC =
=20
> >> pages
> >> > in one
> >> > function call (as you have said you are going to remove
> >> > SGX_NR_TO_SCAN_MAX,
> >> > which is a cipher to both of us).  The only difference I can see is,
> >> > with this
> >> > patch, you can have multiple calls of "isolate" and then call the
> >> > "do_reclaim"
> >> > once.
> >> >
> >> > But what's the good of having the "isolate" if the "do_reclaim" can =
=20
> >> only
> >> > reclaim
> >> > 16 pages anyway?
> >> >
> >> > Back to my last reply, are you afraid of any LRU has less than 16 =
=20
> >> pages
> >> > to
> >> > "isolate", therefore you need to loop LRUs of descendants to get 16?
> >> > Cause I
> >> > really cannot think of any other reason why you are doing this.
> >> >
> >> >
> >>
> >> I think I see your point. By capping pages reclaimed per cycle to 16,
> >> there is not much difference even if those 16 pages are spread in =20
> >> separate
> >> LRUs . The difference is only significant when we ever raise that cap.=
 =20
> >> To
> >> preserve the current behavior of ewb loops independent on number of LR=
Us
> >> to loop through for each reclaiming cycle, regardless of the exact val=
ue
> >> of the page cap, I would still think current approach in the patch is
> >> reasonable choice.  What do you think?
> >
> > To me I won't bother to do that.  Having less than 16 pages in one LRU =
is
> > *extremely rare* that should never happen in practice.  It's pointless =
=20
> > to make
> > such code adjustment at this stage.
> >
> > Let's focus on enabling functionality first.  When you have some real
> > performance issue that is related to this, we can come back then.
> >
>
> I have done some rethinking about this and realize this does save quite =
=20
> some significant work: without breaking out isolation part from =20
> sgx_reclaim_pages(), I can remove the changes to use a list for isolated =
=20
> pages, and no need to introduce "state" such as RECLAIM_IN_PROGRESS. Abou=
t =20
> 1/3 of changes for per-cgroup reclamation will be gone.
>
> So I think I'll go this route now. The only downside may be performance i=
f =20
> a enclave spreads its pages in different cgroups and even that is minimum=
 =20
> impact as we limit reclamation to 16 pages a time. Let me know if someone=
 =20
> feel strongly we need dealt with that and see some other potential issues=
 =20
> I may have missed.

We could deal with possible performance regression later on (if there
is need). I mean there should we a workload first that would so that
sort stimulus...

> Thanks
>
> Haitao

BR, Jarkko

