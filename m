Return-Path: <cgroups+bounces-1554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFC854158
	for <lists+cgroups@lfdr.de>; Wed, 14 Feb 2024 02:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4FB1C26983
	for <lists+cgroups@lfdr.de>; Wed, 14 Feb 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F453BE;
	Wed, 14 Feb 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRvM2TND"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583672F25;
	Wed, 14 Feb 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707875552; cv=none; b=njkoY65EusNqE3s+XvUfmBWZXWgI3E0qe5f91lVKEwXl4UPZl3EmPKIf288AV7/WHx9nw6CnfLd2nLbWgHoS6jrx144BJeUMf/tmHsXAYjeNkRZScexBAt8rPVzvIhxhxzHB/ZwPCw2VdED0Dt/xxV260O8dOJF33vx86iusy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707875552; c=relaxed/simple;
	bh=FYO/Ayy7ax+Dum8m03QRKFc/2rimYYWHD0lN8SmIRKI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JdvPHhJ+SNhBLU2lLislYd/El+1jibtZCWotu5rPjWwUhkROyJjPAVe8PZ1qoX73V9TAhUxcX7U/8Ru3/6BCLounmmAO7FCU642Q3jfz7eN24u0whq46tCagzhhytWS3FWSvDmvAcdGaGD4r8XW1IW9zpYyDbotqUKLVrv/3jf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRvM2TND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71571C433F1;
	Wed, 14 Feb 2024 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707875551;
	bh=FYO/Ayy7ax+Dum8m03QRKFc/2rimYYWHD0lN8SmIRKI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MRvM2TNDv764T8sEobYFWJAreh9gPPOG4MDc3/ISbZMeqD/o/ciomSn+OhZYlm7yc
	 j0SltrRFxhL5HaFlj42L/xgenQB/8gdDuJJGRq1NuPNR2QMlSf5or/LCqrkniiRnmV
	 CnZAUl+v3eir/gKYQ2b29MUXo5t2UtguF2JqP8ymPKiSEJeyUWsvMSK89crcaRVvq5
	 gzrfIUHbOrmCtfnlGhJIB23GH72PwRw0kau0qEOWd4ZzBhF5FYVh2WGzpo8Yz0Tavp
	 ODKrCtoFdxK2EjPoPnal5rTfheDNOfRgONRTxRS85QS7dODKUG1HSyuNIWTC1sKW58
	 2PXXpV6o3xsSQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Feb 2024 03:52:25 +0200
Message-Id: <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
X-Mailer: aerc 0.16.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <CZ3D53XFVXAW.25EK0ZBFH3HV2@kernel.org>
 <op.2i1xkgedwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2i1xkgedwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Tue Feb 13, 2024 at 1:15 AM EET, Haitao Huang wrote:
> Hi Jarkko
>
> On Mon, 12 Feb 2024 13:55:46 -0600, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>
> >> When the EPC usage of a cgroup is near its limit, the cgroup needs to
> >> reclaim pages used in the same cgroup to make room for new allocations=
.
> >> This is analogous to the behavior that the global reclaimer is trigger=
ed
> >> when the global usage is close to total available EPC.
> >>
> >> Add a Boolean parameter for sgx_epc_cgroup_try_charge() to indicate
> >> whether synchronous reclaim is allowed or not. And trigger the
> >> synchronous/asynchronous reclamation flow accordingly.
> >>
> >> Note at this point, all reclaimable EPC pages are still tracked in the
> >> global LRU and per-cgroup LRUs are empty. So no per-cgroup reclamation
> >> is activated yet.
> >>
> >> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> ---
> >> V7:
> >> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> >> ---
> >>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 26 ++++++++++++++++++++++++--
> >>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  4 ++--
> >>  arch/x86/kernel/cpu/sgx/main.c       |  2 +-
> >>  3 files changed, 27 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c =20
> >> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> >> index d399fda2b55e..abf74fdb12b4 100644
> >> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> >> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> >> @@ -184,13 +184,35 @@ static void =20
> >> sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
> >>  /**
> >>   * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EP=
C =20
> >> page
> >>   * @epc_cg:	The EPC cgroup to be charged for the page.
> >> + * @reclaim:	Whether or not synchronous reclaim is allowed
> >>   * Return:
> >>   * * %0 - If successfully charged.
> >>   * * -errno - for failures.
> >>   */
> >> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
> >> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool =20
> >> reclaim)
> >>  {
> >> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE=
);
> >> +	for (;;) {
> >> +		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
> >> +					PAGE_SIZE))
> >> +			break;
> >> +
> >> +		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
> >> +			return -ENOMEM;
> >> + +		if (signal_pending(current))
> >> +			return -ERESTARTSYS;
> >> +
> >> +		if (!reclaim) {
> >> +			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
> >> +			return -EBUSY;
> >> +		}
> >> +
> >> +		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
> >> +			/* All pages were too young to reclaim, try again a little later *=
/
> >> +			schedule();
> >
> > This will be total pain to backtrack after a while when something
> > needs to be changed so there definitely should be inline comments
> > addressing each branch condition.
> >
> > I'd rethink this as:
> >
> > 1. Create static __sgx_epc_cgroup_try_charge() for addressing single
> >    iteration with the new "reclaim" parameter.
> > 2. Add a new sgx_epc_group_try_charge_reclaim() function.
> >
> > There's a bit of redundancy with sgx_epc_cgroup_try_charge() and
> > sgx_epc_cgroup_try_charge_reclaim() because both have almost the
> > same loop calling internal __sgx_epc_cgroup_try_charge() with
> > different parameters. That is totally acceptable.
> >
> > Please also add my suggested-by.
> >
> > BR, Jarkko
> >
> > BR, Jarkko
> >
> For #2:
> The only caller of this function, sgx_alloc_epc_page(), has the same =20
> boolean which is passed into this this function.

I know. This would be good opportunity to fix that up. Large patch
sets should try to make the space for its feature best possible and
thus also clean up the code base overally.

> If we separate it into sgx_epc_cgroup_try_charge() and =20
> sgx_epc_cgroup_try_charge_reclaim(), then the caller has to have the =20
> if/else branches. So separation here seems not help?

Of course it does. It makes the code in that location self-documenting
and easier to remember what it does.

BR, Jarkko

