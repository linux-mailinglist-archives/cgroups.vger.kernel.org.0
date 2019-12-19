Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C682125994
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 03:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLSC1V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Dec 2019 21:27:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52658 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSC1V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Dec 2019 21:27:21 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihlX3-0007Xu-Sp; Thu, 19 Dec 2019 02:27:18 +0000
Date:   Thu, 19 Dec 2019 03:27:17 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org
Subject: cgroups: WARN_ON_ONCE(css && percpu_ref_is_dying(&css->refcnt))
 triggerable running stress tests cgroups
Message-ID: <20191219022716.o7vxxia6o67tyfmf@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey,

While working on CLONE_INTO_CGROUP I was running the stress tests in the
following loop:

for i in `seq 1 100`; do ./test_stress.sh; done

This quickly led to the WARN_ON_ONCE() in the subject line being
triggered in cgroup_apply_control_enable() and
cgroup_apply_control_disable().

This was reproducible on v5.5-rc2 (cf. [1]) and on v5.4 (cf. [2]).

Christian

[1]:
[  169.086951] WARNING: CPU: 2 PID: 14214 at kernel/cgroup/cgroup.c:3054 cgroup_apply_control_enable+0x1ec/0xb40
[  169.086952] Modules linked in: veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bridge stp llc md4 cmac nls_utf8 cifs libarc4 fscache libdes binfmt_misc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common ppdev kvm_intel kvm irqbypass parport_pc input_leds joydev parport serio_raw qemu_fw_cfg sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel virtio_net net_failover crypto_simd psmouse cryptd failover glue_helper i2c_piix4 pata_acpi floppy
[  169.086994] CPU: 2 PID: 14214 Comm: test_core Not tainted 5.5.0-rc2-brauner-clone3-cgroup #746
[  169.086996] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  169.087002] RIP: 0010:cgroup_apply_control_enable+0x1ec/0xb40
[  169.087004] Code: e4 06 00 00 4d 8b 75 00 4d 85 f6 74 1f 49 8d 7e 18 48 89 fa 48 c1 ea 03 42 80 3c 22 00 0f 85 ac 06 00 00 41 f6 46 18 02 74 02 <0f> 0b 48 8b 4d d0 80 39 00 0f 85 79 06 00 00 4d 8b 8f e8 00 00 00
[  169.087005] RSP: 0018:ffff888108f47bc8 EFLAGS: 00010202
[  169.087007] RAX: 0000000000000000 RBX: ffffffffa9396e80 RCX: 1ffff110211e8f77
[  169.087008] RDX: 1ffff11020d31703 RSI: ffff888101945000 RDI: ffff88810698b818
[  169.087009] RBP: ffff888108f47c40 R08: ffffffffa939dc20 R09: ffffed10211e8f6a
[  169.087010] R10: 0000000000000001 R11: ffffffffa9396e80 R12: dffffc0000000000
[  169.087011] R13: ffff8881019451a0 R14: ffff88810698b800 R15: ffff888101945000
[  169.087013] FS:  00007fc9fb404740(0000) GS:ffff88810c900000(0000) knlGS:0000000000000000
[  169.087014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  169.087015] CR2: 00007fbf05b952b0 CR3: 0000000107ed4006 CR4: 0000000000360ee0
[  169.087018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  169.087019] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  169.087020] Call Trace:
[  169.087023]  ? css_next_descendant_pre+0xf0/0xf0
[  169.087025]  ? css_next_descendant_pre+0xab/0xf0
[  169.087028]  cgroup_apply_control+0x1a/0x30
[  169.087030]  cgroup_type_write+0x31f/0x520
[  169.087033]  cgroup_file_write+0x26d/0x960
[  169.087035]  ? __kasan_check_write+0x14/0x20
[  169.087038]  ? kernfs_get_active+0xdd/0x140
[  169.087040]  ? cgroup_file_poll+0xd0/0xd0
[  169.087042]  ? __kasan_check_write+0x14/0x20
[  169.087043]  ? cgroup_file_poll+0xd0/0xd0
[  169.087045]  kernfs_fop_write+0x296/0x420
[  169.087048]  __vfs_write+0x66/0x110
[  169.087050]  ? _cond_resched+0x19/0x30
[  169.087052]  vfs_write+0x155/0x4a0
[  169.087054]  ksys_write+0x164/0x250
[  169.087056]  ? do_sys_open+0x18e/0x3a0
[  169.087058]  ? __ia32_sys_read+0xb0/0xb0
[  169.087061]  ? fpregs_mark_activate+0x150/0x150
[  169.087063]  __x64_sys_write+0x73/0xb0
[  169.087065]  ? fpregs_assert_state_consistent+0x22/0xa0
[  169.087071]  do_syscall_64+0x9f/0x3b0
[  169.087074]  ? prepare_exit_to_usermode+0xfe/0x1b0
[  169.087076]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  169.087081] RIP: 0033:0x7fc9fb60c247
[  169.087083] Code: 75 05 48 83 c4 58 c3 e8 d7 34 ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  169.087084] RSP: 002b:00007fff63573ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  169.087086] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc9fb60c247
[  169.087087] RDX: 0000000000000008 RSI: 0000558d5a82b181 RDI: 0000000000000003
[  169.087088] RBP: 00007fff63573ee0 R08: 00000000ffffffff R09: 00007fff63573d80
[  169.087089] R10: 0000000000000000 R11: 0000000000000246 R12: 0000558d5a8274a0
[  169.087090] R13: 00007fff63576090 R14: 0000000000000000 R15: 0000000000000000
[  169.087093] ---[ end trace 0389c6ed5e251ab6 ]---
[  169.087103] ------------[ cut here ]------------
[  169.087106] WARNING: CPU: 2 PID: 14214 at kernel/cgroup/cgroup.c:3100 cgroup_apply_control_disable+0x15b/0x3e0
[  169.087107] Modules linked in: veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bridge stp llc md4 cmac nls_utf8 cifs libarc4 fscache libdes binfmt_misc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common ppdev kvm_intel kvm irqbypass parport_pc input_leds joydev parport serio_raw qemu_fw_cfg sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel virtio_net net_failover crypto_simd psmouse cryptd failover glue_helper i2c_piix4 pata_acpi floppy
[  169.087133] CPU: 2 PID: 14214 Comm: test_core Tainted: G        W         5.5.0-rc2-brauner-clone3-cgroup #746
[  169.087134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  169.087136] RIP: 0010:cgroup_apply_control_disable+0x15b/0x3e0
[  169.087137] Code: 24 24 4d 85 e4 0f 84 7b ff ff ff 49 8d 7c 24 18 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 4f 02 00 00 41 f6 44 24 18 02 74 02 <0f> 0b 49 8d bc 24 e8 00 00 00 48 89 f8 48 c1 e8 03 42 80 3c 38 00
[  169.087138] RSP: 0018:ffff888108f47c08 EFLAGS: 00010202
[  169.087140] RAX: 1ffff11020d31703 RBX: ffffffffa939dc20 RCX: 1ffff1102076525e
[  169.087141] RDX: 1ffff11020328a34 RSI: ffff888101945000 RDI: ffff88810698b818
[  169.087142] RBP: ffff888108f47c58 R08: 0000000000000004 R09: ffffed10211e8f50
[  169.087143] R10: ffff888108f47c50 R11: 0000000000000000 R12: ffff88810698b800
[  169.087144] R13: ffffffffa9396e80 R14: ffff888101945000 R15: dffffc0000000000
[  169.087145] FS:  00007fc9fb404740(0000) GS:ffff88810c900000(0000) knlGS:0000000000000000
[  169.087146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  169.087147] CR2: 00007fbf05b952b0 CR3: 0000000107ed4006 CR4: 0000000000360ee0
[  169.087150] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  169.087151] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  169.087151] Call Trace:
[  169.087154]  cgroup_type_write+0x365/0x520
[  169.087156]  cgroup_file_write+0x26d/0x960
[  169.087158]  ? __kasan_check_write+0x14/0x20
[  169.087160]  ? kernfs_get_active+0xdd/0x140
[  169.087162]  ? cgroup_file_poll+0xd0/0xd0
[  169.087164]  ? __kasan_check_write+0x14/0x20
[  169.087165]  ? cgroup_file_poll+0xd0/0xd0
[  169.087167]  kernfs_fop_write+0x296/0x420
[  169.087169]  __vfs_write+0x66/0x110
[  169.087170]  ? _cond_resched+0x19/0x30
[  169.087172]  vfs_write+0x155/0x4a0
[  169.087175]  ksys_write+0x164/0x250
[  169.087176]  ? do_sys_open+0x18e/0x3a0
[  169.087178]  ? __ia32_sys_read+0xb0/0xb0
[  169.087180]  ? fpregs_mark_activate+0x150/0x150
[  169.087185]  __x64_sys_write+0x73/0xb0
[  169.087187]  ? fpregs_assert_state_consistent+0x22/0xa0
[  169.087190]  do_syscall_64+0x9f/0x3b0
[  169.087192]  ? prepare_exit_to_usermode+0xfe/0x1b0
[  169.087194]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  169.087195] RIP: 0033:0x7fc9fb60c247
[  169.087197] Code: 75 05 48 83 c4 58 c3 e8 d7 34 ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  169.087198] RSP: 002b:00007fff63573ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  169.087199] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc9fb60c247
[  169.087200] RDX: 0000000000000008 RSI: 0000558d5a82b181 RDI: 0000000000000003
[  169.087201] RBP: 00007fff63573ee0 R08: 00000000ffffffff R09: 00007fff63573d80
[  169.087202] R10: 0000000000000000 R11: 0000000000000246 R12: 0000558d5a8274a0
[  169.087203] R13: 00007fff63576090 R14: 0000000000000000 R15: 0000000000000000
[  169.087205] ---[ end trace 0389c6ed5e251ab7 ]---

[2]:
[  112.726986] WARNING: CPU: 0 PID: 19450 at kernel/cgroup/cgroup.c:3113 cgroup_apply_control_enable+0xe0/0x300
[  112.726987] Modules linked in: veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter bridge stp llc md4 nls_utf8 cifs libarc4 fscache libdes binfmt_misc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common kvm_intel kvm ppdev irqbypass joydev input_leds mac_hid serio_raw parport_pc parport qemu_fw_cfg sch_fq_codel ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear crct10dif_pclmul crc32_pclmul ghash_clmulni_intel bochs_drm drm_vram_helper ttm drm_kms_helper syscopyarea aesni_intel crypto_simd sysfillrect sysimgblt fb_sys_fops cryptd glue_helper psmouse drm virtio_net net_failover failover i2c_piix4 pata_acpi floppy
[  112.727047] CPU: 0 PID: 19450 Comm: test_core Not tainted 5.4.0-4-generic #5
[  112.727048] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  112.727050] RIP: 0010:cgroup_apply_control_enable+0xe0/0x300
[  112.727056] Code: 4d 89 f4 48 63 93 94 00 00 00 48 85 db 74 0e 48 63 c2 49 8d 84 c6 a0 01 00 00 4c 8b 20 4d 85 e4 74 0a 41 f6 44 24 18 02 74 02 <0f> 0b 4d 8b 8e e8 00 00 00 4d 85 c9 0f 85 72 ff ff ff 49 8b 86 08
[  112.727057] RSP: 0018:ffffb4d400fc3d70 EFLAGS: 00010202
[  112.727059] RAX: ffff8da4325111a0 RBX: ffffffffb46c2940 RCX: ffff8da531254740
[  112.727060] RDX: 0000000000000000 RSI: ffff8da432511000 RDI: ffff8da432511000
[  112.727061] RBP: ffffb4d400fc3dc8 R08: 0000000000000000 R09: 0000000000000000
[  112.727062] R10: ffff8da53ba173c8 R11: 0000000000000000 R12: ffff8da432ea6800
[  112.727063] R13: ffff8da432511000 R14: ffff8da432511000 R15: ffffffffb46c0a60
[  112.727065] FS:  00007f50c56ae740(0000) GS:ffff8da53ba00000(0000) knlGS:0000000000000000
[  112.727066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.727067] CR2: 00007f50c570f6c0 CR3: 0000000032e58006 CR4: 0000000000360ef0
[  112.727071] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  112.727071] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  112.727072] Call Trace:
[  112.727088]  cgroup_apply_control+0x1b/0x30
[  112.727090]  cgroup_type_write+0x12f/0x180
[  112.727094]  cgroup_file_write+0x91/0x160
[  112.727098]  ? __check_object_size+0x13f/0x150
[  112.727101]  kernfs_fop_write+0x11e/0x1a0
[  112.727104]  __vfs_write+0x1b/0x40
[  112.727106]  vfs_write+0xb9/0x1a0
[  112.727109]  ksys_write+0x67/0xe0
[  112.727111]  __x64_sys_write+0x1a/0x20
[  112.727115]  do_syscall_64+0x57/0x190
[  112.727120]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  112.727125] RIP: 0033:0x7f50c58b6247
[  112.727127] Code: 75 05 48 83 c4 58 c3 e8 d7 34 ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  112.727128] RSP: 002b:00007ffeade035d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  112.727130] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f50c58b6247
[  112.727131] RDX: 0000000000000008 RSI: 0000559bdea66181 RDI: 0000000000000003
[  112.727132] RBP: 00007ffeade03610 R08: 00000000ffffffff R09: 00007ffeade034b0
[  112.727132] R10: 0000000000000000 R11: 0000000000000246 R12: 0000559bdea62520
[  112.727133] R13: 00007ffeade057c0 R14: 0000000000000000 R15: 0000000000000000
[  112.727135] ---[ end trace 35b5801867268681 ]---
[  112.729872] ------------[ cut here ]------------
[  112.729880] WARNING: CPU: 2 PID: 19450 at kernel/cgroup/cgroup.c:3159 cgroup_apply_control_disable+0xcf/0x150
[  112.729881] Modules linked in: veth ip6table_nat ip6table_filter ip6_tables xt_MASQUERADE xt_CHECKSUM xt_comment xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_filter bpfilter bridge stp llc md4 nls_utf8 cifs libarc4 fscache libdes binfmt_misc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua intel_rapl_msr intel_rapl_common kvm_intel kvm ppdev irqbypass joydev input_leds mac_hid serio_raw parport_pc parport qemu_fw_cfg sch_fq_codel ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear crct10dif_pclmul crc32_pclmul ghash_clmulni_intel bochs_drm drm_vram_helper ttm drm_kms_helper syscopyarea aesni_intel crypto_simd sysfillrect sysimgblt fb_sys_fops cryptd glue_helper psmouse drm virtio_net net_failover failover i2c_piix4 pata_acpi floppy
[  112.729926] CPU: 2 PID: 19450 Comm: test_core Tainted: G        W         5.4.0-4-generic #5
[  112.729927] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  112.729930] RIP: 0010:cgroup_apply_control_disable+0xcf/0x150
[  112.729932] Code: 4c 8b 33 4d 89 fc 4d 85 f6 74 12 49 63 86 94 00 00 00 49 8d 84 c7 a0 01 00 00 4c 8b 20 4d 85 e4 74 ce 41 f6 44 24 18 02 74 02 <0f> 0b 49 83 bc 24 e8 00 00 00 00 74 a7 49 8b 87 e8 00 00 00 48 85
[  112.729933] RSP: 0018:ffffb4d400fc3d98 EFLAGS: 00010202
[  112.729934] RAX: ffff8da4325111a0 RBX: ffffffffb46c0a60 RCX: ffff8da432511058
[  112.729945] RDX: 0000000000000000 RSI: ffff8da432511000 RDI: ffff8da432514000
[  112.729946] RBP: ffffb4d400fc3dc8 R08: ffff8da432511000 R09: 0000000000000000
[  112.729947] R10: 000000000000c7f8 R11: 0000000000000000 R12: ffff8da432ea6800
[  112.729948] R13: ffff8da432511000 R14: ffffffffb46c2940 R15: ffff8da432511000
[  112.729950] FS:  00007f50c56ae740(0000) GS:ffff8da53bb00000(0000) knlGS:0000000000000000
[  112.729951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.729952] CR2: 00007f7691290620 CR3: 0000000032e58005 CR4: 0000000000360ee0
[  112.729956] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  112.729956] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  112.729957] Call Trace:
[  112.729963]  cgroup_finalize_control+0x1a/0x80
[  112.729964]  cgroup_type_write+0x148/0x180
[  112.729968]  cgroup_file_write+0x91/0x160
[  112.729972]  ? __check_object_size+0x13f/0x150
[  112.729975]  kernfs_fop_write+0x11e/0x1a0
[  112.729977]  __vfs_write+0x1b/0x40
[  112.729979]  vfs_write+0xb9/0x1a0
[  112.729982]  ksys_write+0x67/0xe0
[  112.729985]  __x64_sys_write+0x1a/0x20
[  112.729988]  do_syscall_64+0x57/0x190
[  112.729992]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  112.729994] RIP: 0033:0x7f50c58b6247
[  112.729997] Code: 75 05 48 83 c4 58 c3 e8 d7 34 ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  112.729998] RSP: 002b:00007ffeade035d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  112.729999] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f50c58b6247
[  112.730000] RDX: 0000000000000008 RSI: 0000559bdea66181 RDI: 0000000000000003
[  112.730001] RBP: 00007ffeade03610 R08: 00000000ffffffff R09: 00007ffeade034b0
[  112.730002] R10: 0000000000000000 R11: 0000000000000246 R12: 0000559bdea62520
[  112.730003] R13: 00007ffeade057c0 R14: 0000000000000000 R15: 0000000000000000
[  112.730005] ---[ end trace 35b5801867268682 ]---
