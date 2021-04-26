Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F339536B99B
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhDZTDi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 15:03:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:54884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239888AbhDZTDi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 15:03:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619463774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JgFYiqNfj3cgS9d7z1fKDbD59tWZfAUjneJmcgXrnEA=;
        b=O8X/cFFgxilTICoeriXpB8nQMWUfJMku1goVn8+88GSzrvTdKP7EejT6iTBC4Zr1PEOf/d
        vODpfA0slsiD6KVE1h6z3gpc+LkgMFeAu95bo6wX03w9rr6kS0tvmnRPmQl568YJAZdp+0
        DmQMOqCHFrrxm62E/Go3AtNzB6G1zi4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD608AE72;
        Mon, 26 Apr 2021 19:02:54 +0000 (UTC)
Date:   Mon, 26 Apr 2021 21:02:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YIcOXGkEBo10Q1A7@blackbook>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIMZkjzNFypjZao9@carbon.dhcp.thefacebook.com>
 <YIbRP5/w1ZD804DL@blackbook>
 <20210426151514.od5d7bru7fyu24qs@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RbsNFjwTQQFEBlJQ"
Content-Disposition: inline
In-Reply-To: <20210426151514.od5d7bru7fyu24qs@wittgenstein>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--RbsNFjwTQQFEBlJQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Thanks for your explanations in the other thread.)

On Mon, Apr 26, 2021 at 05:15:14PM +0200, Christian Brauner <christian.brau=
ner@ubuntu.com> wrote:
> Since cgroups organize and manage resources and processes killing
> cgroups is arguably a core cgroup feature and in some form was always
> planned. It just hasn't been high-priority.

This holds for v1 as well, actually, cgroup.signal had been considered
[1] (but dropped in favor the freezer IIUC).

> We should very much try to make interfaces simpler to use for
> userspace.

Another way of seeing this is to have one canonical way how to do that
(i.e. with freezing).

> In this specific instance the code comes down from an algorithm to
> recursively kill all cgroups to a single write into a file. Which
> seems like a good win.

I'm considering the SIGKILL-only implementation now, i.e. the recursion
would still be needed for other signals.

> You can kill processes in ancestor or sibling pid namespaces as long
> as they are encompassed in the same cgroup. And other useful things.

This seems like the main differentiating point, the ability to pass
around a suicidal igniter around, that'll blow you up, all your house
including any privileged or invisible visitors in it. (Rewording just
for the fun of the simile.)

So with the restriction to mere SIGKILL of a cgroup and this reasoning,
I'll look at the patch itself (replying directly to original message).

> But really, the simplifcation alone is already quite good.

Yes, let's keep this a simplification :-)

Michal
=20
[1] https://lore.kernel.org/lkml/CALdu-PBLCNXTaZuODyzw_g_FQNyLqK_FsdObC=3DH=
jtEp75vkdFQ@mail.gmail.com/

--RbsNFjwTQQFEBlJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmCHDlYACgkQia1+riC5
qSjuAw//ZNQglsUxw8VYCMmIFgz/l5v4SU2Br2iudkfIG2zWHs3u8G9UTui1N8UO
wDHHkt4ISZT/MckDr9zb8fCNCbTq+/X4UICPIzvMqvXiYQxKrtZa68kQinxDsXjG
aFU4gr5TyJdFbf/jg1EYLLArJmUITvN3w67raLY9OQN0SS7ZGDDIygXLU9TF9st7
JhR/hHz7+qfGw86VjkQiBMQtKSKt8UN40Dn8JqRheE1UPzAdzmwHKuybkDblvEph
YleZTTfAb1Z0tSTP6c8/PCC6Ui5qtRmFunq2A4iUq9Kezt5aS9ruh247J3pP6DT/
2Qrz7eoN3QWF3p7Xwlu+42aUqptmoBR3/f1o+3yDoJrGlXDnbNoOvjuidxMzcmdh
k505jdUFsAaKs1KNql2lovvdUKtWYD2sz1kDiNyjds76hdWBeMAvgK/2fh3HNq4P
qUA8KlC/sgRuIdxIK2JCswwhTP1OV6jb6nPct1gxdu3jPDSnvjlp577Ad3Tyg0Yz
EKPJOMhAkY0qGH0uispQ73PxfDBfm05F/x94+XVCtSE5j5Q0B+mOOUG891w5uroO
jv+/TXkUoFjhuFwrqvknoxJF16RL4FcASxptRsQklY1DjKwajrM8I8REGjS7u9/p
1aeRZeqmEidjqqmGxgk/moeon+WFVeCRURfFb+8Rh4c//nOpneU=
=Y1Oc
-----END PGP SIGNATURE-----

--RbsNFjwTQQFEBlJQ--
