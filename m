Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874B92441B5
	for <lists+cgroups@lfdr.de>; Fri, 14 Aug 2020 01:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMXZL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMXZK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 19:25:10 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735DBC061757;
        Thu, 13 Aug 2020 16:25:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BSN2m19kFz9sTN;
        Fri, 14 Aug 2020 09:25:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597361105;
        bh=aXgzpd9CFe3IkARlfe+AQV0Aqs2X036V+1GWrROBFIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eWcVOK9z+WZHI2OSKf4O5f3bZCO0P9ZWucX8p2GDqQ2Vac9SxRm9Dz80wNoFDpW4W
         FvaExKdF+vWiy+dZQg24ztR/kYUmE1/QNvApo5z/2DYSLO7MQ8qVAaMZfFxV8QdBhW
         g+hZ2cAIY465Ab2gFdJDbWWwHTxDBK1XZTlvGiptdMOP9QQXauk+wLB/ADwPEFkbV2
         d6290J0NUD7bDtta9hK2/A0E8MZa9yZA8/Yh03fgfQ42Co/zWRU4FEEF6DUq29UUn7
         Etx8KfnLycpcsUULQiVzhwEJ9dpUBMz+MgpjZaONzc0h3xqX9MVSbzi30cnIUd0CTO
         6+Jg0zNuuPZkg==
Date:   Fri, 14 Aug 2020 09:25:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+f96cbc69d9803e663664@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@kernel.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Subject: Re: linux-next boot error: WARNING in mem_cgroup_css_alloc
Message-ID: <20200814092502.34c48995@canb.auug.org.au>
In-Reply-To: <0000000000001c467c05acbf3196@google.com>
References: <0000000000001c467c05acbf3196@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/krubGEnJdNa0L.7SdKkKDu_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--Sig_/krubGEnJdNa0L.7SdKkKDu_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 13 Aug 2020 02:47:26 -0700 syzbot <syzbot+f96cbc69d9803e663664@syzk=
aller.appspotmail.com> wrote:
>
> syzbot found the following issue on:
>=20
> HEAD commit:    e6d113ac Add linux-next specific files for 20200813
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11db9fd6900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2055bd0d83d5e=
e16
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df96cbc69d9803e6=
63664
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f96cbc69d9803e663664@syzkaller.appspotmail.com

#syz fix: mm: memcontrol: fix warning when allocating the root cgroup

--=20
Cheers,
Stephen Rothwell

--Sig_/krubGEnJdNa0L.7SdKkKDu_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl81y84ACgkQAVBC80lX
0Gx3uQf/cE5sU5zeLP79spf/R6yO7PvwNO1YLwQmnE4CA4b4g0MysfpTq8s1a0A1
o21sS9jpRfKECBmfzY6C15EubWYulmjB8IUpBUXIKT1Gy71gucsA9VlNQyeVQ/Wf
DWIQTx5BrVOH1pzTz1BH/cIpg/XHJ2FV9+uKeICmMEAJE/ZbKgH1jF5d8dkKgKjD
e1hZW+PQ9zxqReE5KVYZezq7WDCfz5jtis8mQQg5U2km4T31asNzA1KhV2abTluL
lKinlQ2TiPpsaBJu0DRoiqqO/h/gItgXe9Y5LrzX7JW52AN7SeNo6SeHXyK7UwdB
wAhg3+q30hcai1t3HnYdxru+9aLIcA==
=uE3e
-----END PGP SIGNATURE-----

--Sig_/krubGEnJdNa0L.7SdKkKDu_--
