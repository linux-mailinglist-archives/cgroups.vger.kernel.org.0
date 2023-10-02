Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEE7B5D4A
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 00:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjJBWrq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 18:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJBWrq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 18:47:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819E93;
        Mon,  2 Oct 2023 15:47:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF62C433C7;
        Mon,  2 Oct 2023 22:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696286863;
        bh=28kekbe9MiZUa316MRCxUdXRzkm3hMRvIjbqD7/s5i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+iHZLhJB3/4FRAtEYCyZESHh0hPip6cxNlaTyjXlB6JYTzF8XN6GnvnEk+sPOnSm
         EgcYdfR98TPQmwnGiIBHyR7rHh0pum6Pz3DEk2uRauB6/NXkm9eGn2HUU8eWoJyhBS
         OqGCwnfoEIiynY5pYtO+ox5GojUkfifjoel/vsx0voArid8oyFQOIeOgAXNnXrbfeP
         FQhd0vD8qdpeo/X3D3MPmGaNwDGjCI/XQCO7uPlE+fwDZWzfqZYq1dJJ+LZeYC+o9E
         YCLtoYK6YxY9E2PXxUP3Mbrne+8OEO66b7EzCl75bFVE3amH0ZgCY5bAK/gRx88PWC
         7SBTDwOmNOtAw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 03 Oct 2023 01:47:34 +0300
Message-Id: <CVYBI76N4PTF.38BQ9KIBIOGEH@seitikki>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for
 CSS events
X-Mailer: aerc 0.14.0
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
 <CVS5XFKKTTUZ.XRMYK1ADHSPG@suppilovahvero>
 <op.2buytfetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CVSVH3ARQBRC.1QUTEQE3YNN5T@qgv27q77ld-mac>
 <CVSVJ8DYAME8.SMTH7VYG7ER@qgv27q77ld-mac>
 <op.2bwqct0rwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2bwqct0rwjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 27, 2023 at 4:56 AM EEST, Haitao Huang wrote:
> On Tue, 26 Sep 2023 08:13:18 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> ...
> >> > >>  /**
> >> > >> @@ -410,7 +429,14 @@ misc_cg_alloc(struct cgroup_subsys_state
> >> > >> *parent_css)
> >> > >>   */
> >> > >>  static void misc_cg_free(struct cgroup_subsys_state *css)
> >> > >>  {
> >> > >> -	kfree(css_misc(css));
> >> > >> +	struct misc_cg *cg =3D css_misc(css);
> >> > >> +	enum misc_res_type i;
> >> > >> +
> >> > >> +	for (i =3D 0; i < MISC_CG_RES_TYPES; i++)
> >> > >> +		if (cg->res[i].free)
> >> > >> +			cg->res[i].free(cg);
> >> > >> +
> >> > >> +	kfree(cg);
> >> > >>  }
> >> > >>
> >> > >>  /* Cgroup controller callbacks */
> >> > >> --
> >> > >> 2.25.1
> >> > >
> >> > > Since the only existing client feature requires all callbacks, =20
> >> should
> >> > > this not have that as an invariant?
> >> > >
> >> > > I.e. it might be better to fail unless *all* ops are non-nil (e.g.=
 =20
> >> to
> >> > > catch issues in the kernel code).
> >> > >
> >> >
> >> > These callbacks are chained from cgroup_subsys, and they are defined
> >> > separately so it'd be better follow the same pattern.  Or change =20
> >> together
> >> > with cgroup_subsys if we want to do that. Reasonable?
> >>
> >> I noticed this one later:
> >>
> >> It would better to create a separate ops struct and declare the instan=
ce
> >> as const at minimum.
> >>
> >> Then there is no need for dynamic assigment of ops and all that is in
> >> rodata. This is improves both security and also allows static analysis
> >> bit better.
> >>
> >> Now you have to dynamically trace the struct instance, e.g. in case of
> >> a bug. If this one done, it would be already in the vmlinux.
> >I.e. then in the driver you can have static const struct declaration
> > with *all* pointers pre-assigned.
> >
> > Not sure if cgroups follows this or not but it is *objectively*
> > better. Previous work is not always best possible work...
> >
>
> IIUC, like vm_ops field in vma structs. Although function pointers in =20
> vm_ops are assigned statically, but you still need dynamically assign =20
> vm_ops for each instance of vma.
>
> So the code will look like this:
>
> if (parent_cg->res[i].misc_ops && parent_cg->res[i].misc_ops->alloc)
> {
> ...
> }
>
> I don't see this is the pattern used in cgroups and no strong opinion =20
> either way.
>
> TJ, do you have preference on this?

I do have strong opinion on this. In the client side we want as much
things declared statically as we can because it gives more tools for
statical analysis.

I don't want to see dynamic assignments in the SGX driver, when they
are not actually needed, no matter things are done in cgroups.

> Thanks
> Haitao

BR, Jarkko
