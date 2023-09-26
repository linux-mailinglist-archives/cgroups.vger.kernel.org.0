Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400857AEDCF
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjIZNNc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNNb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 09:13:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC01F3;
        Tue, 26 Sep 2023 06:13:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E27C433C7;
        Tue, 26 Sep 2023 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695734004;
        bh=vjOeXtIHqXffBP35xpftmPrN/668KBUpvIaJoM0J6cc=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=MKb9vZvU/hjsLPftWfzS/YkYEdoCgh3gm5x6Sx6bszhopiWlVQ+bRlNhY40lDkBDb
         ffu6LG/6Ne3LTJ4NgsEwppFVISSTKLeaUR9RJFG7xS2rQOH7NvpXaUUYrUHgTCLj8b
         x+mSTtAklURfVjQI867VlAlwmV6pf5adiH+y/3xmgfVP71vxChN4ZGbytAiL5q4Nai
         tU9CwliuCmK1WTU9jZ3XL64bFD5znu8ax53FMj2Cb51cJwGQ8LdQ4qNMKZgqLub5HR
         zyQrPr6C5qhsqAdMwiuRusQuZs2VlVQiV7w8DpXGaDSeehUjLXuMfJ6Kvh0ZxBt89r
         m6a2Dqjz51xVw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 26 Sep 2023 16:13:18 +0300
Message-Id: <CVSVJ8DYAME8.SMTH7VYG7ER@qgv27q77ld-mac>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for
 CSS events
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.15.2
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
 <CVS5XFKKTTUZ.XRMYK1ADHSPG@suppilovahvero>
 <op.2buytfetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CVSVH3ARQBRC.1QUTEQE3YNN5T@qgv27q77ld-mac>
In-Reply-To: <CVSVH3ARQBRC.1QUTEQE3YNN5T@qgv27q77ld-mac>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue Sep 26, 2023 at 4:10 PM EEST, Jarkko Sakkinen wrote:
> On Tue Sep 26, 2023 at 6:04 AM EEST, Haitao Huang wrote:
> > Hi Jarkko
> >
> > On Mon, 25 Sep 2023 12:09:21 -0500, Jarkko Sakkinen <jarkko@kernel.org>=
 =20
> > wrote:
> >
> > > On Sat Sep 23, 2023 at 6:06 AM EEST, Haitao Huang wrote:
> > >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> > >>
> > >> The misc cgroup controller (subsystem) currently does not perform
> > >> resource type specific action for Cgroups Subsystem State (CSS) even=
ts:
> > >> the 'css_alloc' event when a cgroup is created and the 'css_free' ev=
ent
> > >> when a cgroup is destroyed, or in event of user writing the max valu=
e to
> > >> the misc.max file to set the usage limit of a specific resource
> > >> [admin-guide/cgroup-v2.rst, 5-9. Misc].
> > >>
> > >> Define callbacks for those events and allow resource providers to
> > >> register the callbacks per resource type as needed. This will be
> > >> utilized later by the EPC misc cgroup support implemented in the SGX
> > >> driver:
> > >> - On css_alloc, allocate and initialize necessary structures for EPC
> > >> reclaiming, e.g., LRU list, work queue, etc.
> > >> - On css_free, cleanup and free those structures created in alloc.
> > >> - On max_write, trigger EPC reclaiming if the new limit is at or bel=
ow
> > >> current usage.
> > >>
> > >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > >> ---
> > >> V5:
> > >> - Remove prefixes from the callback names (tj)
> > >> - Update commit message (Jarkko)
> > >>
> > >> V4:
> > >> - Moved this to the front of the series.
> > >> - Applies on cgroup/for-6.6 with the overflow fix for misc.
> > >>
> > >> V3:
> > >> - Removed the released() callback
> > >> ---
> > >>  include/linux/misc_cgroup.h |  5 +++++
> > >>  kernel/cgroup/misc.c        | 32 +++++++++++++++++++++++++++++---
> > >>  2 files changed, 34 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup=
.h
> > >> index e799b1f8d05b..96a88822815a 100644
> > >> --- a/include/linux/misc_cgroup.h
> > >> +++ b/include/linux/misc_cgroup.h
> > >> @@ -37,6 +37,11 @@ struct misc_res {
> > >>  	u64 max;
> > >>  	atomic64_t usage;
> > >>  	atomic64_t events;
> > >> +
> > >> +	/* per resource callback ops */
> > >> +	int (*alloc)(struct misc_cg *cg);
> > >> +	void (*free)(struct misc_cg *cg);
> > >> +	void (*max_write)(struct misc_cg *cg);
> > >>  };
> > >>
> > >>  /**
> > >> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> > >> index 79a3717a5803..62c9198dee21 100644
> > >> --- a/kernel/cgroup/misc.c
> > >> +++ b/kernel/cgroup/misc.c
> > >> @@ -276,10 +276,13 @@ static ssize_t misc_cg_max_write(struct =20
> > >> kernfs_open_file *of, char *buf,
> > >>
> > >>  	cg =3D css_misc(of_css(of));
> > >>
> > >> -	if (READ_ONCE(misc_res_capacity[type]))
> > >> +	if (READ_ONCE(misc_res_capacity[type])) {
> > >>  		WRITE_ONCE(cg->res[type].max, max);
> > >> -	else
> > >> +		if (cg->res[type].max_write)
> > >> +			cg->res[type].max_write(cg);
> > >> +	} else {
> > >>  		ret =3D -EINVAL;
> > >> +	}
> > >>
> > >>  	return ret ? ret : nbytes;
> > >>  }
> > >> @@ -383,23 +386,39 @@ static struct cftype misc_cg_files[] =3D {
> > >>  static struct cgroup_subsys_state *
> > >>  misc_cg_alloc(struct cgroup_subsys_state *parent_css)
> > >>  {
> > >> +	struct misc_cg *parent_cg;
> > >>  	enum misc_res_type i;
> > >>  	struct misc_cg *cg;
> > >> +	int ret;
> > >>
> > >>  	if (!parent_css) {
> > >>  		cg =3D &root_cg;
> > >> +		parent_cg =3D &root_cg;
> > >>  	} else {
> > >>  		cg =3D kzalloc(sizeof(*cg), GFP_KERNEL);
> > >>  		if (!cg)
> > >>  			return ERR_PTR(-ENOMEM);
> > >> +		parent_cg =3D css_misc(parent_css);
> > >>  	}
> > >>
> > >>  	for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
> > >>  		WRITE_ONCE(cg->res[i].max, MAX_NUM);
> > >>  		atomic64_set(&cg->res[i].usage, 0);
> > >> +		if (parent_cg->res[i].alloc) {
> > >> +			ret =3D parent_cg->res[i].alloc(cg);
> > >> +			if (ret)
> > >> +				goto alloc_err;
> > >> +		}
> > >>  	}
> > >>
> > >>  	return &cg->css;
> > >> +
> > >> +alloc_err:
> > >> +	for (i =3D 0; i < MISC_CG_RES_TYPES; i++)
> > >> +		if (parent_cg->res[i].free)
> > >> +			cg->res[i].free(cg);
> > >> +	kfree(cg);
> > >> +	return ERR_PTR(ret);
> > >>  }
> > >>
> > >>  /**
> > >> @@ -410,7 +429,14 @@ misc_cg_alloc(struct cgroup_subsys_state =20
> > >> *parent_css)
> > >>   */
> > >>  static void misc_cg_free(struct cgroup_subsys_state *css)
> > >>  {
> > >> -	kfree(css_misc(css));
> > >> +	struct misc_cg *cg =3D css_misc(css);
> > >> +	enum misc_res_type i;
> > >> +
> > >> +	for (i =3D 0; i < MISC_CG_RES_TYPES; i++)
> > >> +		if (cg->res[i].free)
> > >> +			cg->res[i].free(cg);
> > >> +
> > >> +	kfree(cg);
> > >>  }
> > >>
> > >>  /* Cgroup controller callbacks */
> > >> --
> > >> 2.25.1
> > >
> > > Since the only existing client feature requires all callbacks, should
> > > this not have that as an invariant?
> > >
> > > I.e. it might be better to fail unless *all* ops are non-nil (e.g. to
> > > catch issues in the kernel code).
> > >
> >
> > These callbacks are chained from cgroup_subsys, and they are defined =
=20
> > separately so it'd be better follow the same pattern.  Or change togeth=
er =20
> > with cgroup_subsys if we want to do that. Reasonable?
>
> I noticed this one later:
>
> It would better to create a separate ops struct and declare the instance
> as const at minimum.
>
> Then there is no need for dynamic assigment of ops and all that is in
> rodata. This is improves both security and also allows static analysis
> bit better.
>
> Now you have to dynamically trace the struct instance, e.g. in case of
> a bug. If this one done, it would be already in the vmlinux.

I.e. then in the driver you can have static const struct declaration
with *all* pointers pre-assigned.

Not sure if cgroups follows this or not but it is *objectively*
better. Previous work is not always best possible work...

BR, Jarkko
