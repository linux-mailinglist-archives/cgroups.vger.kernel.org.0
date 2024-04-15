Return-Path: <cgroups+bounces-2489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF468A5A63
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5621F21D0A
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E16155A32;
	Mon, 15 Apr 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6noDhvl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2851552E6;
	Mon, 15 Apr 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208233; cv=none; b=qa58Wy7PJ8D3DL65Jk5KmbrEndG5m2Kxc2A7F4lx90zDnvDhLTtjHIt06k/LRJZO9WncIphDHNkUi2FEhU2BqwdZzTMLWn45+mclQ/nqT4f3470b73uvcKNenbHzD6Eu4YXYhsAPwGzKft4CRDPl4E586Va0cNdonti4RCur0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208233; c=relaxed/simple;
	bh=HUpQB8WmbJVcz6ErhPD+Z94qHt56c9cYzzzfG99zS0Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=gDEqZnwzmj07hcK3gHUVomxq4TQjlvkuEtPanCHUcvKNAdfxD4VGIecsaLGcsRzOQ/2GtYoHPTDw8RjpLAnsdxW5Otc4WovZ0LOIlPhl6vqPpPC6tNZlJuyH8oHdWCz1FbbJpSFgDQn8XU85p5DjMmau6WJuTaOr+vh1rjKscUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6noDhvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E09C113CC;
	Mon, 15 Apr 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713208233;
	bh=HUpQB8WmbJVcz6ErhPD+Z94qHt56c9cYzzzfG99zS0Q=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=s6noDhvlrWfpLhB3lMGrwhSlSPFeaOJleRQkFE8/WE65rvf+ZIDE+NjwiaKtg+hsV
	 27o4hEbEC1hLglCNyf3jYrD0tjmkvN9cJ7lthftIDEr493xlJVz3YIRFuXua02wkYM
	 PE2ChLlcHuGd42cvXap/CrKv6i97zfho23hC6diX3P8cI2nn8YozgnF11CXLhzs4yF
	 eRLDnb+j82b3nM455rQvM0GOoMTAPfQfBzP9QGIIxEu9JEKVnN664fkrpzhMyeFLvy
	 A7lBGpst8rsuU9BAZ54+n5UNiczXGcEkdBK87jxH0HTFyG7HwTOzcZw1uh1NmsMdgM
	 FLAok0UAm57Qg==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:10:27 +0300
Message-Id: <D0KXMQBISTRX.1Z4KDCLJP7NZV@kernel.org>
Subject: Re: [PATCH v11 01/14] x86/sgx: Replace boolean parameters with
 enums
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Huang, Kai" <kai.huang@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
 <haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
X-Mailer: aerc 0.17.0
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
 <20240410182558.41467-2-haitao.huang@linux.intel.com>
 <a912d401461662987e6e55b6a12518da17a3d25e.camel@intel.com>
In-Reply-To: <a912d401461662987e6e55b6a12518da17a3d25e.camel@intel.com>

On Mon Apr 15, 2024 at 4:22 PM EEST, Huang, Kai wrote:
> On Wed, 2024-04-10 at 11:25 -0700, Haitao Huang wrote:
> > Replace boolean parameters for 'reclaim' in the function
> > sgx_alloc_epc_page() and its callers with an enum.
> >=20
> > Also opportunistically remove non-static declaration of
> > __sgx_alloc_epc_page() and a typo
> >=20
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> >=20
>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Hmm... missing my reviewed-by so:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

