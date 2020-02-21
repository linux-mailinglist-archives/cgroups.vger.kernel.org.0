Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31201168478
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2020 18:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBURKe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Feb 2020 12:10:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:38514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBURKe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 21 Feb 2020 12:10:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2D534ABBD;
        Fri, 21 Feb 2020 17:10:31 +0000 (UTC)
Date:   Fri, 21 Feb 2020 18:10:24 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] mm: memcontrol: clean up and document effective
 low/min calculations
Message-ID: <20200221171024.GA23476@blackbody.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20191219200718.15696-3-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 03:07:17PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> The effective protection of any given cgroup is a somewhat complicated
> construct that depends on the ancestor's configuration, siblings'
> configurations, as well as current memory utilization in all these
> groups.
I agree with that. It makes it a bit hard to determine the equilibrium
in advance.


> + *    Consider the following example tree:
>   *
> + *        A      A/memory.low = 2G, A/memory.current = 6G
> + *       //\\
> + *      BC  DE   B/memory.low = 3G  B/memory.current = 2G
> + *               C/memory.low = 1G  C/memory.current = 2G
> + *               D/memory.low = 0   D/memory.current = 2G
> + *               E/memory.low = 10G E/memory.current = 0
>   *
> + *    and memory pressure is applied, the following memory
> + *    distribution is expected (approximately*):
>   *
> + *      A/memory.current = 2G
> + *      B/memory.current = 1.3G
> + *      C/memory.current = 0.6G
> + *      D/memory.current = 0
> + *      E/memory.current = 0
>   *
> + *    *assuming equal allocation rate and reclaimability
I think the assumptions for this example don't hold (anymore).
Because reclaim rate depends on the usage above protection, the siblings
won't be reclaimed equally and so the low_usage proportionality will
change over time and the equilibrium distribution is IMO different (I'm
attaching an Octave script to calculate it).

As it depends on the initial usage, I don't think there can be given
such a general example (for overcommit).


> @@ -6272,12 +6262,63 @@ struct cgroup_subsys memory_cgrp_subsys = {
>   * for next usage. This part is intentionally racy, but it's ok,
>   * as memory.low is a best-effort mechanism.
Although it's a different issue but since this updates the docs I'm
mentioning it -- we treat memory.min the same, i.e. it's subject to the
same race, however, it's not meant to be best effort. I didn't look into
outcomes of potential misaccounting but the comment seems to miss impact
on memory.min protection.

> @@ -6292,52 +6333,29 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
> [...]
> +	if (parent == root) {
> +		memcg->memory.emin = memcg->memory.min;
> +		memcg->memory.elow = memcg->memory.low;
> +		goto out;
>  	}
Shouldn't this condition be 'if (parent == root_mem_cgroup)'? (I.e. 1st
level takes direct input, but 2nd and further levels redistribute only
what they really got from parent.)


Michal


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=script
Content-Transfer-Encoding: quoted-printable

% run as: octave-cli script
%
% Input configurations
% -------------------
% E parent effective protection
% n nominal protection of siblings set at the givel level
% c current consumption -,,-

% example from effective_protection 3.
E =3D 2;
n =3D [3 1 0 10];
c =3D [2 2 2 0];  % this converges to      [1.16 0.84 0 0]
% c =3D [6 2 2 0];  % keeps ratio          [1.5 0.5 0 0]
% c =3D [5 2 2 0];  % mixed ratio          [1.45 0.55 0 0]
% c =3D [8 2 2 0];  % mixed ratio          [1.53 0.47 0 0]

% example from effective_protection 5.
%E =3D 2;
%n =3D [1 0];
%c =3D [2 1];  % coming from close to equilibrium  -> [1.50 0.50]
%c =3D [100 100];  % coming from "infinity"        -> [1.50 0.50]
%c =3D [2 2];   % coming from uniformity            -> [1.33 0.67]

% example of recursion by default
%E =3D 2;
%n =3D [0 0];
%c =3D [2 1];  % coming from disbalance            -> [1.33 0.67]
%c =3D [100 100];  % coming from "infinity"        -> [1.00 1.00]
%c =3D [2 2];   % coming from uniformity           -> [1.00 1.00]

% example by using infinities (_without_ recursive protection)
%E =3D 2;
%n =3D [1e7 1e7];
%c =3D [2 1];  % coming from disbalance            -> [1.33 0.67]
%c =3D [100 100];  % coming from "infinity"        -> [1.00 1.00]
%c =3D [2 2];   % coming from uniformity           -> [1.00 1.00]

% Reclaim parameters
% ------------------

% Minimal reclaim amount (GB)
cluster =3D 4e-6;

% Reclaim coefficient (think as 0.5^sc->priority)
alpha =3D .1

% Simulation parameters
% ---------------------
epsilon =3D 1e-7;
timeout =3D 1000;

% Simulation loop
% ---------------------
% Simulation assumes siblings consumed the initial amount of memory (w/out
% reclaim) and then the reclaim starts, all memory is reclaimable, i.e. tre=
ated
% same. It simulates only non-low reclaim and assumes all memory.min =3D 0.

ch =3D [];
eh =3D [];
rh =3D [];

for t =3D 1:timeout
	% low_usage
	u =3D min(c, n);
	siblings =3D sum(u);

	% effective_protection()
	protected =3D min(n, c);                % start with nominal
	e =3D protected * min(1, E / siblings); % normalize overcommit

	% recursive protection
	unclaimed =3D max(0, E - siblings);
	parent_overuse =3D sum(c) - siblings;
	if (unclaimed > 0 && parent_overuse > 0)
		overuse =3D max(0, c - protected);
		e +=3D unclaimed * (overuse / parent_overuse);
	endif

	% get_scan_count()
	r =3D alpha * c;             % assume all memory is in a single LRU list

	% 1bc63fb1272b ("mm, memcg: make scan aggression always exclude protection=
")
	sz =3D max(e, c);
	r .*=3D (1 - (e+epsilon) ./ (sz+epsilon));

	% uncomment to debug prints
	e, c, r
=09
	% nothing to reclaim, reached equilibrium
	if max(r) < epsilon
		break;
	endif

	% SWAP_CLUSTER_MAX
	r =3D max(r, (r > epsilon) .* cluster);
	c =3D max(c - r, 0);
=09
	ch =3D [ch ; c];
	eh =3D [eh ; e];
	rh =3D [rh ; r];
endfor

t
c, e
plot([ch, eh])
pause()

--8P1HSweYDcXXzwPJ--
