Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05C536B529
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhDZOn3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 10:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:58160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZOn3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 10:43:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619448166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fv7fFJfffmnznWz0ShWmcyRuQV5/j5m0wpfbC4qng4s=;
        b=bq85JjIiOgDZ02mjWaswsUw3P93a0eWI8bfyosta+YvU8LQkeYvUEWliWg7VqJYC6xMT/a
        1oX5V0nxdEXdXQ7f0xt5VC0esdqPc9aMIYUNEyB7FMiYCVv85W2vFPs6lj5B80sh/H3VEu
        y0tjTTJtXUPVyaMwr25gpxTwboPWIz4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A360DABB1;
        Mon, 26 Apr 2021 14:42:46 +0000 (UTC)
Date:   Mon, 26 Apr 2021 16:42:45 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YIbRZeWIl8i6soSN@blackbook>
References: <20210423171351.3614430-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qrDmmfUlDdo2CPmx"
Content-Disposition: inline
In-Reply-To: <20210423171351.3614430-1-brauner@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qrDmmfUlDdo2CPmx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian,
I have some questions to understand the motivation here.

On Fri, Apr 23, 2021 at 07:13:51PM +0200, Christian Brauner <brauner@kernel.org> wrote:
> - Signals are specified by writing the signal number into cgroup.signal.
>   An alternative would be to allow writing the signal name but I don't
>   think that's worth it. Callers like systemd can easily do a snprintf()
>   with the signal's define/enum.
> - Since signaling is a one-time event and we're holding cgroup_mutex()
>   as we do for freezer we don't need to worry about tasks joining the
>   cgroup while we're signaling the cgroup. Freezer needed to care about
>   this because a task could join or leave frozen/non-frozen cgroups.
>   Since we only support SIGKILL currently and SIGKILL works for frozen
>   tasks there's also not significant interaction with frozen cgroups.
> - Since signaling leads to an event and not a state change the
>   cgroup.signal file is write-only.
Have you considered accepting a cgroup fd to pidfd_send_signal and
realize this operation through this syscall? (Just asking as it may
prevent some of these consequences whereas bring other unclarities.)


> - Since we currently only support SIGKILL we don't need to generate a
>   separate notification and can rely on the unpopulated notification
>   meachnism. If we support more signals we can introduce a separate
>   notification in cgroup.events.
What kind of notification do you have in mind here?

> - Freezer doesn't care about tasks in different pid namespaces, i.e. if
>   you have two tasks in different pid namespaces the cgroup would still
>   be frozen.
>   The cgroup.signal mechanism should consequently behave the same way,
>   i.e.  signal all processes and ignore in which pid namespace they
>   exist. This would obviously mean that if you e.g. had a task from an
>   ancestor pid namespace join a delegated cgroup of a container in a
>   child pid namespace the container can kill that task. But I think this
>   is fine and actually the semantics we want since the cgroup has been
>   delegated.
What do you mean by a delegated cgroup in this context?

> - We're holding the read-side of tasklist lock while we're signaling
>   tasks. That seems fine since kill(-1, SIGKILL) holds the read-side
>   of tasklist lock walking all processes and is a way for unprivileged
>   users to trigger tasklist lock being held for a long time. In contrast
>   it would require a delegated cgroup with lots of processes and a deep
>   hierarchy to allow for something similar with this interface.
I'd better not proliferate tasklist_lock users if it's avoidable (such
as freezer does).

> Fwiw, in addition to the system manager and container use-cases I think
> this has the potential to be picked up by the "kill" tool. In the future
> I'd hope we can do: kill -9 --cgroup /sys/fs/cgroup/delegated
(OT: FTR, there's `systemctl kill` already ;-))

Michal

--qrDmmfUlDdo2CPmx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmCG0WQACgkQia1+riC5
qSjqQw//eblx3JpSs9H+U2TrWvN2FqgxsXKBf6Idm2ECqRMZbGAbf3bkbngpGIUC
Hvqnq9uIbz5xwNd4eHVRxwGU4XpZ/WIXhKCKCY6pi2U7amOaMJuDr7K8jfTk2Xl+
KkFk8roye5WmBltsHR5prK1CuY8DiKSQ5dEdaBPZrLK1AhVEJPyzT3I/wuBiv7DF
EpqOm+gZatQpYegIXdaBCm+BIrRdnQP14PY8Ja+b5Ggp5E+gPAQIKrwRkDBDvQj0
EAYLMuL+0M7CffQ/jiWcPAKgtVhab0vMfCwzDRu9899YO5GeVcpaGCw6pezSWfbr
yUwRjxMpTWRWNKXSl/hFUZxkBtaWxnzqGfk7KQy/guO+eCCZBLBqY6Qr3zf2mXri
R/mjDafPFGYN/gyGzcHleRSj7zrNV8Y5+nGEyiQuRDR9+CPRflGYV7vNCqcxK8Zf
gRPDE+s/bZ7ENU1etlgU1b+3bCro8tmjBeSYobM6bt/dj226MniNmvCLuQqbef2c
LBLk/qMWXs7oJcOG6aJfc7oUrAllRqDAghWkYxflLrQ/78WqhIhFbbOy047hgegV
kxwZAAw+pP5Tw0DlyfGhl2g779cRL983L5M+u0LgIacPXsGEKJ1bttNIRKWwOw11
udWKhlhfvbVTx53W4ji7vp0ogt0XugECeqd0T7CsJfNAd9ADTNc=
=6D53
-----END PGP SIGNATURE-----

--qrDmmfUlDdo2CPmx--
