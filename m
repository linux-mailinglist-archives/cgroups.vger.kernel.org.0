Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A38017A323
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgCEKbf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 05:31:35 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59740 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCEKbf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 05:31:35 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1j9nmv-000mJW-Bd; Thu, 05 Mar 2020 11:31:33 +0100
Message-ID: <71515f7a143937ab9ab11625485659bb7288f024.camel@sipsolutions.net>
Subject: Re: [BUG] NULL pointer de-ref when setting io.cost.qos on LUKS
 devices
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org
Date:   Thu, 05 Mar 2020 11:31:29 +0100
In-Reply-To: <20200304164205.GH189690@mtj.thefacebook.com> (sfid-20200304_174209_151624_50E7536A)
References: <1dbdcbb0c8db70a08aac467311a80abcf7779575.camel@sipsolutions.net>
         <20200303141902.GB189690@mtj.thefacebook.com>
         <24bd31cdaa3ea945908bc11cea05d6aae6929240.camel@sipsolutions.net>
         <20200304164205.GH189690@mtj.thefacebook.com>
         (sfid-20200304_174209_151624_50E7536A)
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mcjR0yXznIKw1TEhCYUl"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--=-mcjR0yXznIKw1TEhCYUl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-04 at 11:42 -0500, Tejun Heo wrote:
> [SNIP]
>=20
> Right now, the situation isn't great with dm. When pagecache
> writebacks go through dm, in some cases including dm-crypt, the cgroup
> ownership information is completely lost and all writes end up being
> issued as the root cgroup, so it breaks down when dm is in use.

Fair enough.

> In the longer term, what we wanna do is controlling at physical
> devices (sda here) and then updating dm so that it can maintain and
> propagate the ownership correctly but we aren't there yet.

Perfect, so what I am seeing is really just a small systemd bug. Thansk
for confirming, I'll submit a patch to fix it.

Benjamin

--=-mcjR0yXznIKw1TEhCYUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl5g1QEACgkQq6ZWhpmF
Y3DEqg//VPcO2qUEZ7XODL8iSVDhK1pGXv5KSILnsiTyDXo4wHPND3tNcpOAceU+
l1fufTA2LMbXtH1BMPmlEL/lMQK27IUss0J3PyihPBWjdC31KTpxixCr/61mERo6
zQSnGGUYoNsVwyMP8kl5DcNFscY42fOcnx5Ot5GdfYrw35Lqniv7OctQyCXU5vAD
MeEbW2jE7J8vusMMr4Bn68fIUuXYLE1Thx0FIn4HtH9mpyQsfyXFDGqq/92AHbsS
SpP3H+iVjOf0v5oAV+0NZMu6HE5o+g36HpvS4UzODdLynfYkmFPcwoxpfUQ9bDT/
Yrv7uAUvlikRekvPNo3TBg3Yh8oIuri+tVvTZzgdnldyDPU8RhQjd6q11XR7OASb
tFONjiI5w2xzLmuY96R7KHac31O0zEmNDpYSGOx56HCLu7gx4mkU4usdDB0IqRbZ
iawu0jvpwRhneDW3p5mQDm2DMRcAuAAX9NviezqktvRkzfwgJyeyeQzhwEy24a2J
cgVAT6f5KVi+JE0NWaCS17GIL2vPmRB/pbbE6KIi9+5ZFRtby6ppU6W8QLXb5c8d
jzcgIMuL2HB/YWCqvMR4ZQukPD/TnaCvLiA8zof1PboGXh7vPxMPfoladjCUEFS7
IPA2B4YjF3TZtr8AIqgmi5qrg+BCJVtaKp0shvrpJzA1v5SDsqU=
=PIRG
-----END PGP SIGNATURE-----

--=-mcjR0yXznIKw1TEhCYUl--

