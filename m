Return-Path: <cgroups+bounces-1704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310B85AD59
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 21:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62221C24202
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2438535CD;
	Mon, 19 Feb 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5pUuMn6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3252F98;
	Mon, 19 Feb 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375357; cv=none; b=qs1plX5ZoryiFMVf9e3DgC85dg/QH98/WrRUXXBuLbXmrnBlp0XlfPqkBSfsQtwiB/II6ElMlMF0h97LMG3I0DJwWOtKzJDZENY5ijCI4OSU4EhQ19WNQM/KDHTY71asMVboz0OuNS9zstdr25hTJ5EjrSsASFSsSGwflZ2BFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375357; c=relaxed/simple;
	bh=d17JEQ94N0uoQLFj1CrJnlh4bPeyeziOZO+AvWt/zv4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FEqLzjrViO0dn/8XMPL/suBP39virOurIsxftgQ7so8FtP8cABOx083Uh0CvcN9Z2X3/YW9/GuJCrCJZhl6M6wzvdQQCtgQpq0Dwdfkh4OzZAZ4RaviDVSbBq4LboUqtsrNNU59ubxtwuoRimfnNbTMPT59YkG632Ir2MLoowZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5pUuMn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11862C433F1;
	Mon, 19 Feb 2024 20:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375356;
	bh=d17JEQ94N0uoQLFj1CrJnlh4bPeyeziOZO+AvWt/zv4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k5pUuMn6H9zU70hz/4BM/+jJxWd/6P6s/GlNOpjI4aNHEb3h5QgU2Yt70L+sc8jmV
	 fSkW8AmYGlxnkTmvoyP9Y1aHKonKRM3URipwp05cKQ7ACRaQtkCe7Y4sFsU9EwCL2U
	 2w9s32jXTwzeELjkiU0MV1puiNRbVcJyyr7b00p+jGrTlncA70/aFTfprcWq3NEK3C
	 P+Wk+zTniMfKYvHn72jZ1RDXt4yql2kWAY64zYJgvPNBjgVxeb3YKzcrkRrXO7+8WB
	 DypU8nvqIGMr+zwVR5VT+S65iPgxIMOT0vJ9ERJVx4utYWdCmQ1jtMfEu7L68w4JlN
	 /HmhjwWxzFELw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 20:42:29 +0000
Message-Id: <CZ9CIP97661C.2WUZJNNCQUHE8@seitikki>
Cc: <anakrish@microsoft.com>, <bp@alien8.de>, <cgroups@vger.kernel.org>,
 <chrisyan@microsoft.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
 <kristen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <mikko.ylinen@linux.intel.com>,
 <mingo@redhat.com>, <mkoutny@suse.com>, <seanjc@google.com>,
 <sohil.mehta@intel.com>, <tglx@linutronix.de>,
 <tim.c.chen@linux.intel.com>, <tj@kernel.org>, <x86@kernel.org>,
 <yangjie@microsoft.com>, <zhanb@microsoft.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH] x86/sgx: Remove 'reclaim' boolean parameters
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>, "Haitao Huang"
 <haitao.huang@linux.intel.com>
X-Mailer: aerc 0.15.2
References: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
 <20240219153957.9957-1-haitao.huang@linux.intel.com>
 <40f95b90-8698-42dd-89d7-cd73d1e311b1@intel.com>
In-Reply-To: <40f95b90-8698-42dd-89d7-cd73d1e311b1@intel.com>

On Mon Feb 19, 2024 at 3:56 PM UTC, Dave Hansen wrote:
> On 2/19/24 07:39, Haitao Huang wrote:
> > Remove all boolean parameters for 'reclaim' from the function
> > sgx_alloc_epc_page() and its callers by making two versions of each
> > function.
> >=20
> > Also opportunistically remove non-static declaration of
> > __sgx_alloc_epc_page() and a typo
> >=20
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c  | 56 +++++++++++++++++++++------
> >  arch/x86/kernel/cpu/sgx/encl.h  |  6 ++-
> >  arch/x86/kernel/cpu/sgx/ioctl.c | 23 ++++++++---
> >  arch/x86/kernel/cpu/sgx/main.c  | 68 ++++++++++++++++++++++-----------
> >  arch/x86/kernel/cpu/sgx/sgx.h   |  4 +-
> >  arch/x86/kernel/cpu/sgx/virt.c  |  2 +-
> >  6 files changed, 115 insertions(+), 44 deletions(-)
>
> Jarkko, did this turn out how you expected?
>
> I think passing around a function pointer to *only* communicate 1 bit of
> information is a _bit_ overkill here.
>
> Simply replacing the bool with:
>
> enum sgx_reclaim {
> 	SGX_NO_RECLAIM,
> 	SGX_DO_RECLAIM
> };
>
> would do the same thing.  Right?
>
> Are you sure you want a function pointer for this?

To look this in context I drafted quickly two branches representing
imaginary next version of the patch set.

I guess this would simpler and totally sufficient approach.

With this approach I'd then change also:

[PATCH v9 04/15] x86/sgx: Implement basic EPC misc cgroup functionality

And add the enum-parameter already in that patch with just "no reclaim"
enum. I.e. then 10/15 will add only "do reclaim" and the new
functionality.

BR, Jarkko

