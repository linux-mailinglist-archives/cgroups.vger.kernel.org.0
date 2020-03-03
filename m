Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95A8177889
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 15:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCCONS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 09:13:18 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55948 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCONR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 09:13:17 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1j98IN-00CtWj-Hr
        for cgroups@vger.kernel.org; Tue, 03 Mar 2020 15:13:15 +0100
Message-ID: <1dbdcbb0c8db70a08aac467311a80abcf7779575.camel@sipsolutions.net>
Subject: [BUG] NULL pointer de-ref when setting io.cost.qos on LUKS devices
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     cgroups@vger.kernel.org
Date:   Tue, 03 Mar 2020 15:13:10 +0100
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-soCyNtdWgZyimQ0qG1eD"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--=-soCyNtdWgZyimQ0qG1eD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

so, I tried to set io.latency for some cgroups for the root device,
which is ext4 inside LVM inside LUKS.

I tried doing so with systemd (it has the IODeviceLatencyTargetSec
option). What was interesting is that it selects the LUKS device if I
ask it to set the latency for the root partition. i.e. setting:

  IODeviceLatencyTargetSec=3D/usr/bin 20ms

results in io.latency:

  253:0 target=3D20000

and 253:0 corresponds to the LUKS device. 253:1 would be the root
partition itself, 8:2 the partition on disk and 8:0 the disk. I am not
sure the systemd selection works as intended. And I wonder which device
systemd should select in this scenario.


Anyway, I then thought I might need to enable the QOS controller in
io.cost.qos before it will take effect. Unfortunately, trying to do so
reliably results in an oops on my system, i.e.:

  # echo 253:1 enable=3D1 >io.cost.qos
or
  # echo 253:0 enable=3D1 >io.cost.qos

results in the below oops. A similar setup on a different machine
without LUKS seems to work fine.

The kernel version was 5.5.6-201.fc31.x86_64

Benjamin


Mar 02 15:06:31 ben-x1 kernel: BUG: kernel NULL pointer dereference, addres=
s: 0000000000000138
Mar 02 15:06:31 ben-x1 kernel: #PF: supervisor read access in kernel mode
Mar 02 15:06:31 ben-x1 kernel: #PF: error_code(0x0000) - not-present page
Mar 02 15:06:31 ben-x1 kernel: PGD 0 P4D 0=20
Mar 02 15:06:31 ben-x1 kernel: Oops: 0000 [#1] SMP PTI
Mar 02 15:06:31 ben-x1 kernel: CPU: 3 PID: 3413 Comm: bash Tainted: G      =
     OE     5.5.6-201.fc31.x86_64 #1
Mar 02 15:06:31 ben-x1 kernel: Hardware name: LENOVO 20FCS0RV0G/20FCS0RV0G,=
 BIOS N1FET36W (1.10 ) 03/09/2016
Mar 02 15:06:31 ben-x1 kernel: RIP: 0010:ioc_pd_init+0x126/0x190
Mar 02 15:06:31 ben-x1 kernel: Code: 48 8b 45 28 48 8b 00 8b 80 f8 00 00 00=
 41 89 84 24 38 01 00 00 48 85 ed 74 28 48 63 0d d3 40 25 01 48 83 c1 1c 48=
 8b 44 cd 08 <48> 63 90 38 01 00 00 49 89 84 d4 40 01 00 00 48 8b 6d 38 48 =
85 ed
Mar 02 15:06:31 ben-x1 kernel: RSP: 0018:ffffb0c3880ffcd8 EFLAGS: 00010086
Mar 02 15:06:31 ben-x1 kernel: RAX: 0000000000000000 RBX: ffff89609be87e00 =
RCX: 000000000000001e
Mar 02 15:06:31 ben-x1 kernel: RDX: 0000000000000003 RSI: 0000000000000001 =
RDI: ffff89609b8e0d28
Mar 02 15:06:31 ben-x1 kernel: RBP: ffff896099e2be00 R08: ffff8960c21b0140 =
R09: ffff89609b8e0000
Mar 02 15:06:31 ben-x1 kernel: R10: ffff8960c1002e00 R11: ffff896083bdc000 =
R12: ffff89609b8e0c00
Mar 02 15:06:31 ben-x1 kernel: R13: 0000000000000000 R14: 0000000000000000 =
R15: ffffffff8a745e40
Mar 02 15:06:31 ben-x1 kernel: FS:  00007fba669b4740(0000) GS:ffff8960c2180=
000(0000) knlGS:0000000000000000
Mar 02 15:06:31 ben-x1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Mar 02 15:06:31 ben-x1 kernel: CR2: 0000000000000138 CR3: 000000021a52c003 =
CR4: 00000000003606e0
Mar 02 15:06:31 ben-x1 kernel: Call Trace:
Mar 02 15:06:31 ben-x1 kernel:  blkcg_activate_policy+0x11d/0x2b0
Mar 02 15:06:31 ben-x1 kernel:  blk_iocost_init+0x15c/0x1e0
Mar 02 15:06:31 ben-x1 kernel:  ioc_qos_write+0x2d1/0x3e0
Mar 02 15:06:31 ben-x1 kernel:  ? do_filp_open+0xa5/0x100
Mar 02 15:06:31 ben-x1 kernel:  cgroup_file_write+0x8a/0x150
Mar 02 15:06:31 ben-x1 kernel:  ? __check_object_size+0x136/0x147
Mar 02 15:06:31 ben-x1 kernel:  kernfs_fop_write+0xce/0x1b0
Mar 02 15:06:31 ben-x1 kernel:  vfs_write+0xb6/0x1a0
Mar 02 15:06:31 ben-x1 kernel:  ksys_write+0x5f/0xe0
Mar 02 15:06:31 ben-x1 kernel:  do_syscall_64+0x5b/0x1c0
Mar 02 15:06:31 ben-x1 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Mar 02 15:06:31 ben-x1 kernel: RIP: 0033:0x7fba66aa94b7
Mar 02 15:06:31 ben-x1 kernel: Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f=
 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00=
 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 =
74 24
Mar 02 15:06:31 ben-x1 kernel: RSP: 002b:00007ffc71074178 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000001
Mar 02 15:06:31 ben-x1 kernel: RAX: ffffffffffffffda RBX: 000000000000000f =
RCX: 00007fba66aa94b7
Mar 02 15:06:31 ben-x1 kernel: RDX: 000000000000000f RSI: 00005612c8793640 =
RDI: 0000000000000001
Mar 02 15:06:31 ben-x1 kernel: RBP: 00005612c8793640 R08: 000000000000000a =
R09: 0000000000000008
Mar 02 15:06:31 ben-x1 kernel: R10: 00005612c90f56b0 R11: 0000000000000246 =
R12: 000000000000000f
Mar 02 15:06:31 ben-x1 kernel: R13: 00007fba66b7a500 R14: 000000000000000f =
R15: 00007fba66b7a700
Mar 02 15:06:31 ben-x1 kernel: Modules linked in: uinput ccm xt_CHECKSUM xt=
_MASQUERADE nf_nat_tftp nf_conntrack_tftp rfcomm tun bridge stp llc nf_conn=
track_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJECT nf_reject_ipv6 ip=
6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ebtab>
Mar 02 15:06:31 ben-x1 kernel:  snd_hda_codec_hdmi mc snd_hda_codec_conexan=
t snd_hda_codec_generic snd_compress ac97_bus snd_pcm_dmaengine cfg80211 sn=
d_hda_intel ecdh_generic ecc snd_intel_dspcfg snd_hda_codec snd_hda_core sn=
d_hwdep irqbypass intel_cstate snd_seq intel_uncore snd_>
Mar 02 15:06:31 ben-x1 kernel: CR2: 0000000000000138
Mar 02 15:06:31 ben-x1 kernel: ---[ end trace d1bdee4e9a482594 ]---

--=-soCyNtdWgZyimQ0qG1eD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl5eZfYACgkQq6ZWhpmF
Y3Be8RAAmeWkZbtMxZL78FT4Dt/bj6w9xNhzE6/XMhz4bqg/i1WDU25embrgWFeS
5WgUaCD+1a23MmHPqvgkDToT1xaWTQGHwK+G2EbQGQYLNlHfk9wsHMSe1DOfuAdQ
a5TMA3YMXr3kkbhAicgNvO9nXcMvF2iVwd3CjVimfWPMc+zFELYjpmfDuVf3bOl+
d8WXeyTazIxLa7K/zg7XiSrobDkM9JnZ9Pg+UuvyEkh61qmK8xVFtTofwfoo5tQU
cEUaRXgxP4zPkdl2E/h5SItZavKRp3EpyEHH1ELdTlEVZIzgoISR/fKVGblC0LMc
ZFtOFJu8FEmwqgcXPZesWYGQSVYzcGK02Wjfnad7qnK7syn1egaLBU0354Qeutgh
LEPUJ0jQ26EANBWJ78bP9CzWWdJkOYh/btrW7cC0JyY4GJAKRMVxnQN7XMk+47NO
O8sUI3NzQWG98sk58kssk6zP1tt20uJoc9ZGs0xUbXlWG41JFI+Xey4hmwJ8+4Al
3x2TG7OdF+eRqIsMFxDA+ehhdCqP7wq/lrVpjrBNu+vz73COrKIvIMjKbOE8PVsD
bmq5DDU5tZKxgHlpXWSMLFHc+6LCwr77IROnBd1o9Z9c9wH0xXzOBSChkcws/Bm6
0WzTU5w9wceugHjQHKF1WA4yv16dkzuUn87TRyNooJhSTcxok8k=
=Bh6o
-----END PGP SIGNATURE-----

--=-soCyNtdWgZyimQ0qG1eD--

