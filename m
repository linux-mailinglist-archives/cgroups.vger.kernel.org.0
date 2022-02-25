Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645244C4A2B
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 17:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiBYQKm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 11:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiBYQKm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 11:10:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B830A1C2321
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:Date:Cc:To:From:
        Subject:Message-ID:Content-Transfer-Encoding:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=MOPpvdNhNU2RpS1RZ3R8uWYUUQon8ir3K7hmN0BpFk4=; t=1645805409; x=1647015009; 
        b=RGad7qr6QXLvY8o51al/BrrhLX/N9sLXuCopOGqt3kzY75ye0OQO6FTzll/iDZUKtTcYNRk21K9
        R1tlDulf5oi/DLuJQyX3gF+NCqRqUS9Anv2/sH6qwbFzwuqgJ31CqjPhBnIH13bNG39erPwDQ0MCP
        UJtDRQLfYZwjTlTfock/O+jZk1uSjlllG/Pcy9sBlN6Xp3hjsX/ECR01aFqO6VTiIbULG2/dtL/+i
        ZaTRvqFlEtybY8sXE8x7lO5grGYvLyAA0V9HqrK67zjlxvRyCVEBgClQ3el5OcSYQ3RdakbbPvcoe
        FrUn/9iQpeULkzY+Ob4fTMJ004olJ0YIQFrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1nNdAV-005hEh-3l;
        Fri, 25 Feb 2022 17:10:07 +0100
Message-ID: <12f7d0bef9340035b82a007cc37bd09c48d86c3f.camel@sipsolutions.net>
Subject: Explanation for difference between memcg swap accounting and
 smaps_rollup
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Anita Zhang <the.anitazha@gmail.com>
Date:   Fri, 25 Feb 2022 17:10:05 +0100
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JS88UdKRWg/hWx/X89Sq"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--=-JS88UdKRWg/hWx/X89Sq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am seeing memory.swap.current usages for the gnome-shell cgroup that
seem high if I compare them to smaps_rollup for the contained
processes. As I don't have an explanation, I thought I would ask here
(shared memory?).

What I am seeing is (see below, after a tail /dev/zero):

memory.swap.current:
  686MiB
"Swap" lines from /proc/$pid/smaps_rollup added up:
  435MiB

We should be moving launched applications out of the shell cgroup
before doing execve(), so I think we can rule out that as a possible
explanation.

I am mostly curious as we currently do swap based kills using systemd-
oomd. So if swap accounting for GNOME Shell is high, then it makes it a
more likely target unfortunately.

Am I missing something obvious?

Benjamin

$ uname -r
5.16.8-200.fc35.x86_64
$ grep -H . org.gnome.Shell@wayland.service/memory.swap.current; for p in $=
( cat org.gnome.Shell@wayland.service/cgroup.procs ); do ls -l /proc/$p/exe=
; grep Swap /proc/$p/smaps_rollup; done
org.gnome.Shell@wayland.service/memory.swap.current:712396800
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:00 /proc/2521/exe -> '/usr/bin/=
gnome-shell (deleted)'
Swap:             294528 kB
SwapPss:          244060 kB
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:01 /proc/3853/exe -> /usr/bin/X=
wayland
Swap:              55580 kB
SwapPss:           46628 kB
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:01 /proc/3884/exe -> /usr/bin/i=
bus-daemon
Swap:               4104 kB
SwapPss:            4104 kB
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:01 /proc/3891/exe -> /usr/libex=
ec/ibus-dconf
Swap:                800 kB
SwapPss:             796 kB
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:01 /proc/3892/exe -> /usr/libex=
ec/ibus-extension-gtk3
Swap:              13020 kB
SwapPss:           11864 kB
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:01 /proc/3894/exe -> /usr/libex=
ec/ibus-x11
Swap:              16284 kB
SwapPss:           16284 kB
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:01 /proc/3931/exe -> /usr/libex=
ec/ibus-engine-simple
Swap:                312 kB
SwapPss:             312 kB
lrwxrwxrwx. 1 benjamin benjamin 0 Feb 25 16:01 /proc/4086/exe -> /usr/bin/p=
ython3.10
Swap:              50640 kB
SwapPss:           49476 kB

--=-JS88UdKRWg/hWx/X89Sq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmIY/10ACgkQq6ZWhpmF
Y3BZeQ/9FzHHT2frvGoELarNQeuI2JbdvRK5XJWFut/xJZTLxuxxcdfTXo3dR/3A
puYHwUcfKgxzrG42o1+665BNoU1MUiTPJXQF6P94UG31Y38SB53sPZ2EI21wr6W9
3GfnA5BB37ILVZOF32NcqLo9AAmBRRJqWicO4tyZzfv5nJ6KhJa/2YNSGAoEtQgY
SvDr1u2c2RJsqh5vU9wDNtTxK+gOhI2Yn2QJhzjrjrbb55Xw02JyYqR4zq7wspF+
depqwLXdoGuagoQLnULRw+KF9mca3oX1WLBs/6XEp4Wm8roT5zFVpVY2w3K7vnp3
7uqm0M1VYWy4eRWueVTjwup9JA5pPgKmqb5Slb1NBDPy/7eEuiLq6wfC8ACwbG8W
BCsoF4aGXj0uVanmaf7V6+fKhl10fFpJhf224oXKf35jWb2YBV7hDkh1CJy4Ws8A
74VoQk+sqHebzaE54zZLH8erKqkfx+5hyu3SIt7jrIgjPcFfw8DasddCg+JWaZrH
1Ii5kpuv18RC8avFjrNrJCJQ5J220BKzywy6/hH7PGmNE+p3Nw/NVogLDRMUPZmI
oQZxxa5hSgtD+ZRwagGC7tc27h1CEs1PZ6vxs/KcOm9KfKLwukFP2B9fweQ+Rsed
xHI+ZtEGhWZ4m4GAMGQu9BLSXramF8jz4uzefa8LRWf+KNjP6yg=
=cuTS
-----END PGP SIGNATURE-----

--=-JS88UdKRWg/hWx/X89Sq--
