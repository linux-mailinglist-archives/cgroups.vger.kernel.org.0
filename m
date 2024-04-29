Return-Path: <cgroups+bounces-2719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB428B5F4A
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7FE1C213F1
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95385C4E;
	Mon, 29 Apr 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCohTSKX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2184FDB;
	Mon, 29 Apr 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408992; cv=none; b=l+K+NJnoAu2I5GInODWG5aqPm+xGN3XycZqY1TeZ79O55IQ6x1QggL2+PDQjPD8FjnyyN06Y0PIj04KqcwwvkfOOkXABTnmrXHCSp/ss6H1sApzL09FzSckbHEafksSHWrsvumRpreh39kkgAzseD+S4Te4fHbSLiyVPVIfsqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408992; c=relaxed/simple;
	bh=q/1QRQoyEhR6GEBHvBAQqcf2WKQozplDb6iCZ4SM6zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=me+cZR1rpBejycER8CDgw/7qglnW7GlVniaONkxG7yIhmFhpxWtnZtuLd6Zj06AEnTYkdP8l5nm2Rsss9izqXJ4+Zkmlm8LkFvaCfBt9fhswvcEQSXYb2qV0kUcTIvID1wzIXJv/hPk0/BK0tCuCXmbJzehxQbsjUGu5VKclJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCohTSKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7106AC113CD;
	Mon, 29 Apr 2024 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408992;
	bh=q/1QRQoyEhR6GEBHvBAQqcf2WKQozplDb6iCZ4SM6zc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eCohTSKXbTUQ1mr84Gs3u02SxVL1vp05+WpEDbIzrb6Tc9htO0Sf0c/uOvAdCRAuQ
	 fpm8DSmSBZbOiL6RcUJ47YqcEiYJ+KMCF2AcA8fHYR4Y1eCE5kbkix0LuBG55IbGjc
	 1ttsijw+Cv6IO5mKYKXTwfiE64aqNTluyDSgzy6oxYXm+qn3Glj117MuiRPx49PmMN
	 abyPNf2nJQnq+viVYE06vdu839vsgqyt1Zv9nHuur9cULQZwVLPo1NUXt8HBGGBs43
	 iU7nIIFrIFJolbLJsL77ZesTFA8l5tJlnbIMehYQ3mYJpj7q4+LPdkffszhegXf6GT
	 QjiDEqKU+z+Gg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 19:43:05 +0300
Message-Id: <D0WR9J2AICDK.GM1G85DEHDDF@kernel.org>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>, "Dave Hansen"
 <dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>
X-Mailer: aerc 0.17.0
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>
 <D0LLZTSVG3BC.8WIRM39WC7UU@kernel.org>
 <f62c29ec-f893-4320-8097-f6b3a372267a@intel.com>
 <D0W3G5GVNMMW.3OCGUH8AYNORY@kernel.org>
 <op.2mzzkowowjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mzzkowowjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Mon Apr 29, 2024 at 7:18 PM EEST, Haitao Huang wrote:
> Hi Jarkko
>
> On Sun, 28 Apr 2024 17:03:17 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Fri Apr 26, 2024 at 5:28 PM EEST, Dave Hansen wrote:
> >> On 4/16/24 07:15, Jarkko Sakkinen wrote:
> >> > On Tue Apr 16, 2024 at 8:42 AM EEST, Huang, Kai wrote:
> >> > Yes, exactly. I'd take one week break and cycle the kselftest part
> >> > internally a bit as I said my previous response. I'm sure that there
> >> > is experise inside Intel how to implement it properly. I.e. take som=
e
> >> > time to find the right person, and wait as long as that person has a
> >> > bit of bandwidth to go through the test and suggest modifications.
> >>
> >> Folks, I worry that this series is getting bogged down in the selftest=
s.
> >>  Yes, selftests are important.  But getting _some_ tests in the kernel
> >> is substantially more important than getting perfect tests.
> >>
> >> I don't think Haitao needs to "cycle" this back inside Intel.
> >
> > The problem with the tests was that they are hard to run anything else
> > than Ubuntu (and perhaps Debian). It is hopefully now taken care of.
> > Selftests do not have to be perfect but at minimum they need to be
> > runnable.
> >
> > I need ret-test the latest series because it is possible that I did not
> > have right flags (I was travelling few days thus have not done it yet).
> >
> > BR, Jarkko
> >
>
> Let me know if you want me to send v13 before testing or you can just use=
 =20
> the sgx_cg_upstream_v12_plus branch in my repo.
>
> Also thanks for the "Reviewed-by" tags for other patches. But I've not go=
t =20
> "Reviewed-by" from you for patches #8-12 (not sure I missed). Could you g=
o =20
> through those alsoe when you get chance?

So, I compiled v12 branch. Was the only difference in selftests?

I can just copy them to the device.

BR, Jarkko

