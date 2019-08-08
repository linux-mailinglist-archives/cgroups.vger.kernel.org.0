Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4D867D5
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2019 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404241AbfHHRTw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Aug 2019 13:19:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:54646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404098AbfHHRTw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Aug 2019 13:19:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86A76AE48;
        Thu,  8 Aug 2019 17:19:50 +0000 (UTC)
Date:   Thu, 8 Aug 2019 19:19:49 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Alessio Balsini <balsini@android.com>,
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
        VincentGuittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v13 1/6] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190808171948.GF8617@blackbody.suse.cz>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
 <20190802090853.4810-2-patrick.bellasi@arm.com>
 <20190806161133.GA18532@blackbody.suse.cz>
 <87imr74sfh.fsf@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <87imr74sfh.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 04:10:21PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Not sure to get what you mean here: I'm currently exposing uclamp to
> both v1 and v2 hierarchies.
cpu controller has different API for v1 and v2 hierarchies. My question
reworded is -- are the new knobs exposed in the legacy API
intentionally/for a reason?

Michal

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl1MWbQACgkQia1+riC5
qSheLA/+K7nnjU6jLvL7D5MExUa3wdqwsunab8LGEYk4LMYktDs1F5j/xYnmae/Q
iKPCSZhH+F4JDs3KlFhc4i7iroFAIdZXU7IArLa9vcTONhCYzt1EbmStW0QkjIQw
92w4FH3iPYIveSqDGwsU7zJsiwYHKjLQBSbeIrUM3ylvk0cfioap1WdZNS7/GEKR
XcAgoyT2by2VArF0cxF38q1NCtre+Ash2T2r/3zM59arQb5OuR7uaXjloGeBAHox
LQR539L9WsYPUx7qxNGeQxBPjzIbEHpApxmW2zwpV7It3qbiQaCOdf0KBjweaRri
uIzCCq3PlwPqI+2klp57SNFEffrVYAS8MaBfz5eKD5MPIFw0r8/CO3pFSaGtZIUB
Bbkl9ditoSPcaVYgcVuxgEwQbRanoS1jy6QTKoL2HGQ0ag3ThQYdxx7YQBsv3BV3
kjr988xDEi8dP15NEk83/eqrnUu5tbo2tOiN2THbhKlpFew6a/aYb7TIBzGUhKJN
NouRmmvfp0fSo1lCsNuOjgp9rImU3jHgbhOUBavBPlt0GCGXk7CNtsuMCzjLw954
9kmjP0lSh4k8Nmm0vsODdmKbI6JPj8tAwM/LPCPBGgY+wKlAfD84Dgx6STN5tlmv
uXyjHfelyL0velgb7yHnwVW7sxvN9/q52X9dwe5TbCzWwB4g5ak=
=qSBD
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
