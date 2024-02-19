Return-Path: <cgroups+bounces-1702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06B85AD01
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 21:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C751F2510D
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5352F8C;
	Mon, 19 Feb 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjTtUSkY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EC374DD;
	Mon, 19 Feb 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374018; cv=none; b=B1RHWF9x0nKBwE9cLNSWHRfvzyIscQPWLWtXnV+cdoWXG/y1sUZOMJrBwmU1i8VKn0P7sjUYUvjI0LwCepCbwESZ6hU7hqoHeVEyjjJSRca2tqtpRp3k8pBqVxsy5UMae2W3C/e2gdNHOSjGSq4hLfq8EJP8LtXjlDZUtoBDKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374018; c=relaxed/simple;
	bh=gHOp1QBYiHr0I6TnykCbbaoLqfJQnuRcGvEdxF39TMQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WJkWmlL0WZ3Q86dmGhzkZmLZOk3mia4reHSIQSjNeNPeKcBmkhv8Z787f6iSDaNWN4mSxsIkebczasfDYfD4P1HbZ+W444t5bWTuNGnmKxXKgf8XF2ClAWGUzfU2XhzaVE0gsQ/VX2TAwOOU8PBzjQQyQhdRGsMgrPTZICkQjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjTtUSkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55613C433F1;
	Mon, 19 Feb 2024 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708374017;
	bh=gHOp1QBYiHr0I6TnykCbbaoLqfJQnuRcGvEdxF39TMQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MjTtUSkYwMCnetFVEyU3rTIW7slfhEkNYlnC5PSLvNOkTBn7jVZm5yq4Ko2MmODZJ
	 XmyXQTTl+GD42Oeqq+4x9Vc9QgphUq3WNQd7Rl/0PWY9StAS7vaaMGRZiPQPvO88A0
	 LLduiZBeZlB5rFTsylvnz5ZyithTDB/e2wHsfagzBOnJrXsks6lSyw8j+PIt7JQ0T+
	 CBSTnEjzyavFGMIQpfdsgF5h2CcYbsfWZOeoAx9uFjq6RaZOkYXVFGVtBBOaRMFS6V
	 pqSKP32SRiickys93tIvJgohpV/wE0x1i/1Uhw4JsQptKbxJOV8tkqfPYe3MqRqzFy
	 QwNC4OwnXLClA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 20:20:11 +0000
Message-Id: <CZ9C1M72695Q.1K7JBWXIQNLTL@seitikki>
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
X-Mailer: aerc 0.15.2
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <CZ3D53XFVXAW.25EK0ZBFH3HV2@kernel.org>
 <op.2i1xkgedwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CZ4FCQ633VLC.26Y7HUHGRSFB3@kernel.org>
 <op.2jd9vpf0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2jd9vpf0wjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Mon Feb 19, 2024 at 3:12 PM UTC, Haitao Huang wrote:
> On Tue, 13 Feb 2024 19:52:25 -0600, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Tue Feb 13, 2024 at 1:15 AM EET, Haitao Huang wrote:
> >> Hi Jarkko
> >>
> >> On Mon, 12 Feb 2024 13:55:46 -0600, Jarkko Sakkinen <jarkko@kernel.org=
>
> >> wrote:
> >>
> >> > On Mon Feb 5, 2024 at 11:06 PM EET, Haitao Huang wrote:
> >> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> >>
> >> >> When the EPC usage of a cgroup is near its limit, the cgroup needs =
to
> >> >> reclaim pages used in the same cgroup to make room for new =20
> >> allocations.
> >> >> This is analogous to the behavior that the global reclaimer is =20
> >> triggered
> >> >> when the global usage is close to total available EPC.
> >> >>
> >> >> Add a Boolean parameter for sgx_epc_cgroup_try_charge() to indicate
> >> >> whether synchronous reclaim is allowed or not. And trigger the
> >> >> synchronous/asynchronous reclamation flow accordingly.
> >> >>
> >> >> Note at this point, all reclaimable EPC pages are still tracked in =
=20
> >> the
> >> >> global LRU and per-cgroup LRUs are empty. So no per-cgroup =20
> >> reclamation
> >> >> is activated yet.
> >> >>
> >> >> Co-developed-by: Sean Christopherson =20
> >> <sean.j.christopherson@intel.com>
> >> >> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com=
>
> >> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> >> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> >> ---
> >> >> V7:
> >> >> - Split this out from the big patch, #10 in V6. (Dave, Kai)
> >> >> ---
> >> >>  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 26 ++++++++++++++++++++++++=
--
> >> >>  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  4 ++--
> >> >>  arch/x86/kernel/cpu/sgx/main.c       |  2 +-
> >> >>  3 files changed, 27 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> >> >> b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> >> >> index d399fda2b55e..abf74fdb12b4 100644
> >> >> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> >> >> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> >> >> @@ -184,13 +184,35 @@ static void
> >> >> sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
> >> >>  /**
> >> >>   * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single=
 =20
> >> EPC
> >> >> page
> >> >>   * @epc_cg:	The EPC cgroup to be charged for the page.
> >> >> + * @reclaim:	Whether or not synchronous reclaim is allowed
> >> >>   * Return:
> >> >>   * * %0 - If successfully charged.
> >> >>   * * -errno - for failures.
> >> >>   */
> >> >> -int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
> >> >> +int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool
> >> >> reclaim)
> >> >>  {
> >> >> -	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, =20
> >> PAGE_SIZE);
> >> >> +	for (;;) {
> >> >> +		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
> >> >> +					PAGE_SIZE))
> >> >> +			break;
> >> >> +
> >> >> +		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
> >> >> +			return -ENOMEM;
> >> >> + +		if (signal_pending(current))
> >> >> +			return -ERESTARTSYS;
> >> >> +
> >> >> +		if (!reclaim) {
> >> >> +			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
> >> >> +			return -EBUSY;
> >> >> +		}
> >> >> +
> >> >> +		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
> >> >> +			/* All pages were too young to reclaim, try again a little late=
r =20
> >> */
> >> >> +			schedule();
> >> >
> >> > This will be total pain to backtrack after a while when something
> >> > needs to be changed so there definitely should be inline comments
> >> > addressing each branch condition.
> >> >
> >> > I'd rethink this as:
> >> >
> >> > 1. Create static __sgx_epc_cgroup_try_charge() for addressing single
> >> >    iteration with the new "reclaim" parameter.
> >> > 2. Add a new sgx_epc_group_try_charge_reclaim() function.
> >> >
> >> > There's a bit of redundancy with sgx_epc_cgroup_try_charge() and
> >> > sgx_epc_cgroup_try_charge_reclaim() because both have almost the
> >> > same loop calling internal __sgx_epc_cgroup_try_charge() with
> >> > different parameters. That is totally acceptable.
> >> >
> >> > Please also add my suggested-by.
> >> >
> >> > BR, Jarkko
> >> >
> >> > BR, Jarkko
> >> >
> >> For #2:
> >> The only caller of this function, sgx_alloc_epc_page(), has the same
> >> boolean which is passed into this this function.
> >
> > I know. This would be good opportunity to fix that up. Large patch
> > sets should try to make the space for its feature best possible and
> > thus also clean up the code base overally.
> >
> >> If we separate it into sgx_epc_cgroup_try_charge() and
> >> sgx_epc_cgroup_try_charge_reclaim(), then the caller has to have the
> >> if/else branches. So separation here seems not help?
> >
> > Of course it does. It makes the code in that location self-documenting
> > and easier to remember what it does.
> >
> > BR, Jarkko
> >
>
> Please let me know if this aligns with your suggestion.
>
>
> static int ___sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
> {
>          if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
>                                          PAGE_SIZE))
>                  return 0;
>
>          if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
>                  return -ENOMEM;
>
>          if (signal_pending(current))
>                  return -ERESTARTSYS;
>
>          return -EBUSY;
> }
>
> /**
>   * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single page
>   * @epc_cg:     The EPC cgroup to be charged for the page.
>   *
>   * Try to reclaim pages in the background if the group reaches its limit=
 =20
> and
>   * there are reclaimable pages in the group.
>   * Return:
>   * * %0 - If successfully charged.
>   * * -errno - for failures.
>   */
> int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
> {
>          int ret =3D  ___sgx_epc_cgroup_try_charge(epc_cg);
>
>          if (ret =3D=3D -EBUSY)
>                  queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
>
>          return ret;
> }
>
> /**
>   * sgx_epc_cgroup_try_charge_reclaim() - try to charge cgroup for a sing=
le =20
> page
>   * @epc_cg:     The EPC cgroup to be charged for the page.
>   *
>   * Try to reclaim pages directly if the group reaches its limit and ther=
e =20
> are
>   * reclaimable pages in the group.
>   * Return:
>   * * %0 - If successfully charged.
>   * * -errno - for failures.
>   */
> int sgx_epc_cgroup_try_charge_reclaim(struct sgx_epc_cgroup *epc_cg)
> {
>          int ret;
>
>          for (;;) {
>                  ret =3D  ___sgx_epc_cgroup_try_charge(epc_cg);
>                  if (ret !=3D -EBUSY)
>                          return ret;
>
>                  if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, current->m=
m))
>                          /* All pages were too young to reclaim, try agai=
n =20
> a little later */
>                          schedule();
>          }
>
>          return 0;
> }
>
> It is a little more involved to remove the boolean for =20
> sgx_alloc_epc_page() and its callers like sgx_encl_grow(), =20
> sgx_alloc_va_page(). I'll send a separate patch for comments.

With quick look, it is towards right direction for sure.

BR, Jarkko

