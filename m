Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58874D52
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbfGYLlK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 07:41:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404095AbfGYLlK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 25 Jul 2019 07:41:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E920FAC7F;
        Thu, 25 Jul 2019 11:41:08 +0000 (UTC)
Date:   Thu, 25 Jul 2019 13:41:04 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     cgroups@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Paul Turner <pjt@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v12 1/6] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190725114104.GA32159@blackbody.suse.cz>
References: <20190718181748.28446-1-patrick.bellasi@arm.com>
 <20190718181748.28446-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20190718181748.28446-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2019 at 07:17:43PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> +static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
> +				    char *buf, size_t nbytes,
> +				    loff_t off)
> +{
> [...]
> +static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
> +				    char *buf, size_t nbytes,
> +				    loff_t off)
> +{
> [...]
These two functions are almost identical yet not trivial. I think it
wouldn be better to have the code at one place only and distinguish by
the passed clamp_id.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAl05lUYACgkQK2l36XSZ
9y7Meg//XYuI6RtgY7nvoy6nONBJMrQ19r8x3sSKeZuiaQkV0dd3+evkOvB/kLMl
AYIj6JzQIYeRl1D+4ga4YDu1Fr70P/JsGuKzE4TZGACpvbNUD34QnN6ft/iUFr/5
1p2AmCZ7JUGoJk8yLrGIswDkKzemiws0p2umjXix0znDoHdqmsxe+Sr3RllrfP+K
OoyGgZ1vT9/4sWNdeGSPsYu95PnYAc7d63Vxeb3zjsGtvoBRaBS92TS66lbY3GaJ
Lu9KK1n+56nH4EY+su8FTN6jXTdRmp3KV41aLP4oTyfHEhF7VKGR3i0CXVvz7jbk
f2xdK4OZfA48I30IIXUMUycGKG3X2g3Y/eKpXbfDs1XgXm2AXYhIgVocrAJUf2pN
I8eslVJJjHe9yH9wNsTpLKTgsadqc4iMVs9mAuxW8ZiiDxyVqeOKdSwiYnX8fhMQ
47T1HCoSVzNoK214fLwxv3zE2WQUychjydtw2zDY3lByp9EMK5E5fUYTKU38NWnI
x7uvoiFsbOIr++i+ZIEzi2jvUqlIeUwRefoGqqVKo/i8/op7qZ/I5seN2Zlpa/Rn
kcDZ9WBNPwrLrnR6p5gOEspt3SHruC5i8i9fNptbdv3PFi7OLcIsLy/UGqlrGShj
AvPsECBKiM7gzqXeZojJWGq4nrFbFq0VZeHC7nnp5WHfWGKGbZs=
=NrKU
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
