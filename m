Return-Path: <cgroups+bounces-1423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A05851DED
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2317C28275D
	for <lists+cgroups@lfdr.de>; Mon, 12 Feb 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BAC4655D;
	Mon, 12 Feb 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gidEnOJp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC40547A40;
	Mon, 12 Feb 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766277; cv=none; b=ioHNIYnmyvfi1mx93zZ+wITHLH2cWhB6c3nfNu5gutNHv+/vGcconuD3qsAsDf8YTNWGVtml2nZRdh3c7Ct00Dz8Iat0G0wb8Es1BfVKpUefVCHzhjjE3nqBiIx7jHocy4tZbu3dVK1KR7bu3gV9LkeTr3waHlBACkgCYy9giNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766277; c=relaxed/simple;
	bh=lqtTxODlI6wN7MvPNb4ijKFqQ3MMR+vfaRCRevA/znQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=VaukP8unQnOxVF4OrxR9D0Kvj+JxMUWaDN6I9tUFltBDwlg5psI9IDWOaebIL48iuGe/+N2donrdjqkQ8Zwqq/yaV8Cym2rqXeA0+MUoziiZNvPbFxxfGOWdT12MjYsbRTRCHodQKbEoUW7lJ9zt47Gy2e6PeMIOdWZf+MIRb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gidEnOJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05134C43394;
	Mon, 12 Feb 2024 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707766277;
	bh=lqtTxODlI6wN7MvPNb4ijKFqQ3MMR+vfaRCRevA/znQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gidEnOJp3j3WMy2tty1q8NqQcT6e2BzBs4tyIqvBgkZcmYlZWTO5tElxH32b2mp3V
	 4UP3e+dRV08OoV4zi4DA19+WTo6H9lT3L2F356g3/iEHhRKeRZ3oKM/u94CKG2JQBA
	 auGBgB0mSEmtmoke2TlzdAHvx9P1yoTO5ItUdt/46LVRCVfa83iJ7hxotSPF6FLts0
	 6pEDjqElWDebQF6cKApxEkN5Y7H6Aq6Kw3P2PFNd97NRJfNd3m5oAb/qTlgQpqR+kZ
	 /kvMmluFZYRgL5D9wBmyIMyB1sjGFl37rdhAmTmw2eoS9FTRweGoK/6Pnv4SdN4IXg
	 PF9GgfAR5DZSg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 21:31:10 +0200
Message-Id: <CZ3CM9ZE39Q0.222HRSEUF8RFP@kernel.org>
Subject: Re: [PATCH v8 01/15] cgroup/misc: Add per resource callbacks for
 CSS events
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
X-Mailer: aerc 0.16.0
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-2-haitao.huang@linux.intel.com>
 <CYU4P2CYNVSK.1UECAD4N86P8Z@suppilovahvero>
 <op.2iiwbrjpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2iiwbrjpwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Fri Feb 2, 2024 at 6:34 PM EET, Haitao Huang wrote:
> On Thu, 01 Feb 2024 17:24:40 -0600, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Tue Jan 30, 2024 at 4:09 AM EET, Haitao Huang wrote:
> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>
> >> The misc cgroup controller (subsystem) currently does not perform
> >> resource type specific action for Cgroups Subsystem State (CSS) events=
:
> >> the 'css_alloc' event when a cgroup is created and the 'css_free' even=
t
> >> when a cgroup is destroyed.
> >>
> >> Define callbacks for those events and allow resource providers to
> >> register the callbacks per resource type as needed. This will be
> >> utilized later by the EPC misc cgroup support implemented in the SGX
> >> driver.
> >>
> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> ---
> >> V8:
> >> - Abstract out _misc_cg_res_free() and _misc_cg_res_alloc() (Jarkko)
> >> V7:
> >> - Make ops one per resource type and store them in array (Michal)
> >> - Rename the ops struct to misc_res_ops, and enforce the constraints o=
f =20
> >> required callback
> >> functions (Jarkko)
> >> - Moved addition of priv field to patch 4 where it was used first. =20
> >> (Jarkko)
> >>
> >> V6:
> >> - Create ops struct for per resource callbacks (Jarkko)
> >> - Drop max_write callback (Dave, Michal)
> >> - Style fixes (Kai)
> >
> > This version looks nice and smooth:
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > BR, Jarkko
> >
> Thanks Jarkko!
>
> @tj, I had your Reviewed-by tags previously but dropped it due to some =
=20
> changes for refactoring suggested by other reviewers. Could you take a =
=20
> look at patches 1-2 for MiscController and confirm if I can have your =20
> Reviewed-by tags again?
> Thanks
>
> Haitao

you can add tags

BR, Jarkko

