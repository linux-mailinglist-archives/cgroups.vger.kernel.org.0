Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6579E3E6
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 11:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjIMJjQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbjIMJjQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 05:39:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD1196;
        Wed, 13 Sep 2023 02:39:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB3BC433C7;
        Wed, 13 Sep 2023 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694597951;
        bh=dSg3FHeMAumbmUvzWNHW95nSf89/Wz3zP7aimaIkbxI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ZXzWXrwu9RC5kdgvyD4Ye5Agb5QzVO02jBJEW0mnHaQpEFqlkH9MjuSEVgXaUrJmq
         EfQzJwDD9BBpXXvndNj+eIkUmIlhnnrBnsgfdmO/sFI5PRoHRFwjrU0y6hxj6aL84H
         I/1JlDKdOO1LKXWPAMI7ktI9zNLjuHZKAgw7jpbATlCAQIIfwwhGBcxlYjrAwHRiWN
         2hlxUuKCUSaDDKSY2Qy6K2Eom2p4u9TlGy9UGMjX9bItwj7Dnlyod7p1U3kbdl/FiD
         Wu/LBlqhgtKWx1dvr4RG1Rdjsr2CT7nXCgU1y7jqToY0rPbmBIx4XdymwLrsZa4tpi
         czcohdodFxFCA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 12:39:06 +0300
Message-Id: <CVHOU5G1SCUT.RCBVZ3W8G2NJ@suppilovahvero>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
Subject: Re: [PATCH v4 01/18] cgroup/misc: Add per resource callbacks for
 CSS events
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
X-Mailer: aerc 0.14.0
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-2-haitao.huang@linux.intel.com>
In-Reply-To: <20230913040635.28815-2-haitao.huang@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed Sep 13, 2023 at 7:06 AM EEST, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> Consumers of the misc cgroup controller might need to perform separate
> actions for Cgroups Subsystem State(CSS) events: cgroup alloc and free.

nit: s/State(CSS)/State (CSS)/

"cgroup alloc" and "cgroup free" mean absolutely nothing.


> In addition, writes to the max value may also need separate action. Add

What "the max value"?

> the ability to allow downstream users to setup callbacks for these
> operations, and call the corresponding per-resource-type callback when
> appropriate.

Who are "the downstream users" and what sort of callbacks they setup?

>
> This code will be utilized by the SGX driver in a future patch.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V4:
> - Moved this to the front of the series.
> - Applies on cgroup/for-6.6 with the overflow fix for misc.
>
> V3:
> - Removed the released() callback
> ---
>  include/linux/misc_cgroup.h |  5 +++++
>  kernel/cgroup/misc.c        | 32 +++++++++++++++++++++++++++++---
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index e799b1f8d05b..e1bcd176c2de 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -37,6 +37,11 @@ struct misc_res {
>  	u64 max;
>  	atomic64_t usage;
>  	atomic64_t events;
> +
> +	/* per resource callback ops */
> +	int (*misc_cg_alloc)(struct misc_cg *cg);
> +	void (*misc_cg_free)(struct misc_cg *cg);
> +	void (*misc_cg_max_write)(struct misc_cg *cg);
>  };
> =20
>  /**
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 79a3717a5803..e0092170d0dd 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -276,10 +276,13 @@ static ssize_t misc_cg_max_write(struct kernfs_open=
_file *of, char *buf,
> =20
>  	cg =3D css_misc(of_css(of));
> =20
> -	if (READ_ONCE(misc_res_capacity[type]))
> +	if (READ_ONCE(misc_res_capacity[type])) {
>  		WRITE_ONCE(cg->res[type].max, max);
> -	else
> +		if (cg->res[type].misc_cg_max_write)
> +			cg->res[type].misc_cg_max_write(cg);
> +	} else {
>  		ret =3D -EINVAL;
> +	}
> =20
>  	return ret ? ret : nbytes;
>  }
> @@ -383,23 +386,39 @@ static struct cftype misc_cg_files[] =3D {
>  static struct cgroup_subsys_state *
>  misc_cg_alloc(struct cgroup_subsys_state *parent_css)
>  {
> +	struct misc_cg *parent_cg;
>  	enum misc_res_type i;
>  	struct misc_cg *cg;
> +	int ret;
> =20
>  	if (!parent_css) {
>  		cg =3D &root_cg;
> +		parent_cg =3D &root_cg;
>  	} else {
>  		cg =3D kzalloc(sizeof(*cg), GFP_KERNEL);
>  		if (!cg)
>  			return ERR_PTR(-ENOMEM);
> +		parent_cg =3D css_misc(parent_css);
>  	}
> =20
>  	for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
>  		WRITE_ONCE(cg->res[i].max, MAX_NUM);
>  		atomic64_set(&cg->res[i].usage, 0);
> +		if (parent_cg->res[i].misc_cg_alloc) {
> +			ret =3D parent_cg->res[i].misc_cg_alloc(cg);
> +			if (ret)
> +				goto alloc_err;
> +		}
>  	}
> =20
>  	return &cg->css;
> +
> +alloc_err:
> +	for (i =3D 0; i < MISC_CG_RES_TYPES; i++)
> +		if (parent_cg->res[i].misc_cg_free)
> +			cg->res[i].misc_cg_free(cg);
> +	kfree(cg);
> +	return ERR_PTR(ret);
>  }
> =20
>  /**
> @@ -410,7 +429,14 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css=
)
>   */
>  static void misc_cg_free(struct cgroup_subsys_state *css)
>  {
> -	kfree(css_misc(css));
> +	struct misc_cg *cg =3D css_misc(css);
> +	enum misc_res_type i;
> +
> +	for (i =3D 0; i < MISC_CG_RES_TYPES; i++)
> +		if (cg->res[i].misc_cg_free)
> +			cg->res[i].misc_cg_free(cg);
> +
> +	kfree(cg);
>  }
> =20
>  /* Cgroup controller callbacks */
> --=20
> 2.25.1

BR, Jarkko
