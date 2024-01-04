Return-Path: <cgroups+bounces-1080-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB38248E6
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 20:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B341282776
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37232C19C;
	Thu,  4 Jan 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhoD7/69"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B22C194;
	Thu,  4 Jan 2024 19:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF910C433CA;
	Thu,  4 Jan 2024 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704395994;
	bh=TzkztMPde2JWtmqHozGMznhfMwCoSJkyBXAFGHMfTXg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AhoD7/69l6FQZ03ugH8x76tNj6z5BNaAk7lpWKN+aBdvls2cstLH8jtMuNjLIlMlf
	 kE2zYzI2YjXFHqE+vktBfPrEViikX31vepZi1H4J1qwx4fOZvjF4W+gHEqFRKEt/9S
	 jTiah/k2OK5ZYnq+YW4m0twe4HLPPxnURjqGZ2ifNyifPGM0tmErJ9Nw7PupW9eVI5
	 FO48Ywt9xnRhqDvqwwGw8FJXCNetljbsBLDWV80oA1QskX50LxW0cp08Izb5NZjGvN
	 nI4JOwT5lSEMJxCOFzuMhSF80DAz7xzFR4V/L6YbTT2VL5mzaMxdvLqoPi6owfOJnL
	 +DQp7ZYTgGcLg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jan 2024 21:19:47 +0200
Message-Id: <CY65YBFIQA5T.3HZ78VUGKCH40@suppilovahvero>
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
To: "Haitao Huang" <haitao.huang@linux.intel.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>, "Dave Hansen" <dave.hansen@intel.com>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
 <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4b28fc01-50cf-469b-8161-7d56b863b42b@intel.com>
 <op.2g1d81fqwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2g1d81fqwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Thu Jan 4, 2024 at 9:11 PM EET, Haitao Huang wrote:
> > The key question here is whether we want the SGX VM to be complex and
> > more like the real VM or simple when a cgroup hits its limit.  Right?
> >
>
> Although it's fair to say the majority of complexity of this series is in=
 =20
> support for reclaiming per cgroup, I think it's manageable and much less =
=20
> than real VM after we removed the enclave killing parts: the only extra =
=20
> effort is to track pages in separate list and reclaim them in separately =
=20
> as opposed to track in on global list and reclaim together. The main =20
> reclaiming loop code is still pretty much the same as before.

I'm not seeing any unmanageable complexity on SGX side, and also
cgroups specific changes are somewhat clean to me at least...

BR, Jarkko

