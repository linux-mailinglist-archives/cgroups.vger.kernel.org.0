Return-Path: <cgroups+bounces-11066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0535C03809
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 23:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 742E74EE561
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA086296BD4;
	Thu, 23 Oct 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LApQzoUV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883D254AE4
	for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253938; cv=none; b=IS5kIfan6x8tn0Cu2QnzBJ5o0nL2F4msBBfM71YtedCAXSShlntZTrrcVSFYMtc6TsEIrup33JudXq//gRqJRRci84tXvlilc+oT0yMpbHDC/LFddcblARpmc1ewNiykI0EZOlKYP5rTT4lxAqo2dClXIMQVzkq1RARZ7wYlllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253938; c=relaxed/simple;
	bh=ELtFrjCBV9N4Nbz0iYvi9/WHhUL3pJWyPhQ/w8w3NaE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IAsAIZPja0XfZAXbPGRg18kK2cKMW+dxKi/dzeYnZHGbl+JDLunUFmXLG47pA8uTfkw7ESkHu+vp/Mpn6LjwFTzCO8vFci/cEQ2wp1Z8kxX6dvG02BGhOmAXOdrXVXz7sdSqYBYSM5adnAOUIgVhegwVoAVqiqE5FChn8ExiEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LApQzoUV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781206cce18so1376496b3a.0
        for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761253936; x=1761858736; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRCjgxmNC25rZrLNDyTER70wkWB4aqo3eV4CmHKoZ04=;
        b=LApQzoUVTTn9/EhwZ0cBtJe8nsHfhhIySgcgkyahUFx1EOmisOui5LI+plnTiTMNk5
         zg+RLhzHEywI5ynTWvreQ0YdsbPCZe08uKbVDDzFiiOXo7+w4NuYatu+YzE6Y17RqD86
         Z0fQFtoxduSFt/8eJYT6JK0Gk7onBpRGRUd4W9wNTj+rr1ucfsbncnRMSk5pHhGCouYm
         sisaONtdrCobWRILdate3d0Q58KlDvw4BZinqXor9KMNUNVksUdTE2lZ5/1UzAGd/yxg
         BGrF8qomjm6zEKd2E+YuzC9G1saq8WgcP/IP68CST4NzbQVJe7kdBj6MWllf4xW2S/pH
         aD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253936; x=1761858736;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRCjgxmNC25rZrLNDyTER70wkWB4aqo3eV4CmHKoZ04=;
        b=dlFiR9mNrcgM33liTO3uE7Qj4l5BpcMFX6qZL8HNjfSbTO+PfCKYPu2z1wnXiZRjvc
         edKg+RZo5Ajw3FEr90u7315ItaFmJnyOWbIWWO19ZuBxbIyBUSZopaPTL3IFve4ZOU6K
         KnG+VL3N3iFgWCzKmTtzInQwTekTPodmDH8BPDtmfqwlhE0Y9BE5X/ek8yyXKuBIgreJ
         Pc3eHUvgsoys5O2JqK+ij5EnoE0J7Ky7TN3ib6ffIZXByWYKhs5wGzsvTbDXfWHNEFv1
         TmqoZErbHOUl/Uzunc6Ter1lI0D9d3tsLGApitI4iVHhrJbH/ov0dk2kzg3nuAQRMCFA
         5nHA==
X-Forwarded-Encrypted: i=1; AJvYcCVjTUcBZfBq4UfHIBnyRLiXY7Xrxvdw9AFRW3Bjsc7/oWD4Jkb4DXE+h7902xbpc3zSOnK+FeZ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzzT1b8SfL0Vual/oAf1SkcR2st/WKMU8+rafw94+1suQKs8JVP
	4PQ1YZf+Qe9E4auG1AnqZwzgSJbNcaARdpj3DCNe71QOz0UNCBgqgRbYR77bRU9cw/g=
X-Gm-Gg: ASbGnct40plmsIEy05RWmBIs28qI5ojNSp53Js0YLWnMzltEgmjyn1uyyOmLA3hoYAD
	3mKmFxXhQWifDHXcsVsGN/qLJlVCM/c8LuD6LuNBPdN5IJ6NyRiGtnkR4CCFCaraRbAyr58m1Jb
	Y/NL0u116yzOhRSdQlTRY+Sl0qUOh+lqMbL+TOy//1nsfqBvEmAMB2w8wJ5O6Xi0mMRDU5b2Wxy
	oplxlKdCUw5O1PnDlElk2+c/V2J/IwaXFbUrcqAN9fsacP3wK18Vjs4BYkfUrqtnzG97qZxcb4J
	rmmimj2otZhObRbhER85fg7PWyeXC0LA660RNcg3fsPXlbgVPh9YBsFke4WvIFl5tgouI7me2On
	xjya3wCvJXHxc9WJRNX+UFyQfJImn5vwUoN/P5oOzRI/Ar05dIePPjPK3beOniRShOiHaPL2a1y
	rtZkfJ3ikNXK3qGrXYlxNL+01JzPBxPSmsZzv0ulTgPzuMR5wKThPsl0Ck187+S5d5jPQHJDzcq
	2FVTgGJ9w==
X-Google-Smtp-Source: AGHT+IGEQq/W+6DUb6xVUQlR03GwyH9beM+0mneirLXAhnoMxplSnBAlG1ska4gF0njo+WnFNMe+UQ==
X-Received: by 2002:a05:6a00:1597:b0:7a2:68bf:2592 with SMTP id d2e1a72fcca58-7a284dd5cf6mr334443b3a.12.1761253936202;
        Thu, 23 Oct 2025 14:12:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:18ba:60bd:858e:6985? ([2620:10d:c090:500::6:ccab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274aa183dsm3517101b3a.30.2025.10.23.14.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 14:12:15 -0700 (PDT)
Message-ID: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk>
Date: Thu, 23 Oct 2025 14:12:14 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-block@vger.kernel.org, cgroups@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com,
 lkp@intel.com, oliver.sang@intel.com, Nilay Shroff <nilay@linux.ibm.com>
From: David Wei <dw@davidwei.uk>
Subject: [REPORT] Possible circular locking dependency on 6.18-rc2 in
 blkg_conf_open_bdev_frozen+0x80/0xa0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks, hit this with lockdep on 6.18-rc2:

[   36.862405] ======================================================
[   36.862406] WARNING: possible circular locking dependency detected
[   36.862408] 6.18.0-rc2-gdbafbca31432-dirty #97 Tainted: G S          E
[   36.862409] ------------------------------------------------------
[   36.862410] fb-cgroups-setu/1420 is trying to acquire lock:
[   36.862411] ffff8884035502a8 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open_bdev_frozen+0x80/0xa0
[   36.943164]
                but task is already holding lock:
[   36.954824] ffff8884035500a8 (&q->q_usage_counter(io)#2){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[   36.975183]
                which lock already depends on the new lock.
[   36.991541]
                the existing dependency chain (in reverse order) is:
[   37.006502]
                -> #4 (&q->q_usage_counter(io)#2){++++}-{0:0}:
[   37.020429]        blk_alloc_queue+0x345/0x380
[   37.029315]        blk_mq_alloc_queue+0x51/0xb0
[   37.038376]        __blk_mq_alloc_disk+0x14/0x60
[   37.047612]        nvme_alloc_ns+0xa7/0xbc0
[   37.055976]        nvme_scan_ns+0x25a/0x320
[   37.064339]        async_run_entry_fn+0x28/0x110
[   37.073576]        process_one_work+0x1e1/0x570
[   37.082634]        worker_thread+0x184/0x330
[   37.091170]        kthread+0xe6/0x1e0
[   37.098489]        ret_from_fork+0x20b/0x260
[   37.107026]        ret_from_fork_asm+0x11/0x20
[   37.115912]
                -> #3 (fs_reclaim){+.+.}-{0:0}:
[   37.127232]        fs_reclaim_acquire+0x91/0xd0
[   37.136293]        kmem_cache_alloc_lru_noprof+0x49/0x760
[   37.147090]        __d_alloc+0x30/0x2a0
[   37.154759]        d_alloc_parallel+0x4c/0x760
[   37.163644]        __lookup_slow+0xc3/0x180
[   37.172008]        simple_start_creating+0x57/0xc0
[   37.181590]        debugfs_start_creating.part.0+0x4d/0xe0
[   37.192561]        debugfs_create_dir+0x3e/0x1f0
[   37.201795]        regulator_init+0x24/0x100
[   37.210335]        do_one_initcall+0x46/0x250
[   37.219043]        kernel_init_freeable+0x22c/0x430
[   37.228799]        kernel_init+0x16/0x1b0
[   37.236814]        ret_from_fork+0x20b/0x260
[   37.245351]        ret_from_fork_asm+0x11/0x20
[   37.254235]
                -> #2 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
[   37.268336]        down_write+0x25/0xa0
[   37.276003]        simple_start_creating+0x29/0xc0
[   37.285582]        debugfs_start_creating.part.0+0x4d/0xe0
[   37.296552]        debugfs_create_dir+0x3e/0x1f0
[   37.305782]        blk_register_queue+0x98/0x1c0
[   37.315014]        __add_disk+0x21e/0x3b0
[   37.323030]        add_disk_fwnode+0x75/0x160
[   37.331738]        nvme_alloc_ns+0x395/0xbc0
[   37.340275]        nvme_scan_ns+0x25a/0x320
[   37.348638]        async_run_entry_fn+0x28/0x110
[   37.357870]        process_one_work+0x1e1/0x570
[   37.366929]        worker_thread+0x184/0x330
[   37.375461]        kthread+0xe6/0x1e0
[   37.382779]        ret_from_fork+0x20b/0x260
[   37.391315]        ret_from_fork_asm+0x11/0x20
[   37.400200]
                -> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
[   37.412736]        __mutex_lock+0x83/0x1070
[   37.421100]        rq_qos_add+0xde/0x130
[   37.428942]        wbt_init+0x160/0x200
[   37.436612]        blk_register_queue+0xe9/0x1c0
[   37.445843]        __add_disk+0x21e/0x3b0
[   37.453859]        add_disk_fwnode+0x75/0x160
[   37.462568]        nvme_alloc_ns+0x395/0xbc0
[   37.471105]        nvme_scan_ns+0x25a/0x320
[   37.479469]        async_run_entry_fn+0x28/0x110
[   37.488702]        process_one_work+0x1e1/0x570
[   37.497761]        worker_thread+0x184/0x330
[   37.506296]        kthread+0xe6/0x1e0
[   37.513618]        ret_from_fork+0x20b/0x260
[   37.522154]        ret_from_fork_asm+0x11/0x20
[   37.531038]
                -> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
[   37.543399]        __lock_acquire+0x15fc/0x2730
[   37.552460]        lock_acquire+0xb5/0x2a0
[   37.560647]        __mutex_lock+0x83/0x1070
[   37.569010]        blkg_conf_open_bdev_frozen+0x80/0xa0
[   37.579457]        ioc_qos_write+0x35/0x4a0
[   37.587820]        kernfs_fop_write_iter+0x15c/0x240
[   37.597750]        vfs_write+0x31f/0x4c0
[   37.605590]        ksys_write+0x58/0xd0
[   37.613257]        do_syscall_64+0x6f/0x1120
[   37.621790]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.632932]
                other info that might help us debug this:
[   37.648935] Chain exists of:
                  &q->rq_qos_mutex --> fs_reclaim --> &q->q_usage_counter(io)#2
[   37.671552]  Possible unsafe locking scenario:
[   37.683385]        CPU0                    CPU1
[   37.692438]        ----                    ----
[   37.701489]   lock(&q->q_usage_counter(io)#2);
[   37.710374]                                lock(fs_reclaim);
[   37.721691]                                lock(&q->q_usage_counter(io)#2);
[   37.735615]   lock(&q->rq_qos_mutex);
[   37.742934]
                 *** DEADLOCK ***
[   37.754767] 6 locks held by fb-cgroups-setu/1420:
[   37.764168]  #0: ffff88840ce38e78 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x7a/0xb0
[   37.780179]  #1: ffff88841c292400 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x58/0xd0
[   37.796018]  #2: ffff88840cfdba88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xfd/0x240
[   37.813943]  #3: ffff888404374428 (kn->active#105){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x112/0x240
[   37.832390]  #4: ffff8884035500a8 (&q->q_usage_counter(io)#2){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[   37.853618]  #5: ffff8884035500e0 (&q->q_usage_counter(queue)#2){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[   37.875365]
                stack backtrace:
[   37.884071] CPU: 19 UID: 0 PID: 1420 Comm: fb-cgroups-setu Tainted: G S          E       6.18.0-rc2-gdbafbca31432-dirty #97 NONE
[   37.884075] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
[   37.884075] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/Delta Lake-Class1, BIOS F0E_3A21 06/27/2024
[   37.884077] Call Trace:
[   37.884078]  <TASK>
[   37.884079]  dump_stack_lvl+0x7e/0xc0
[   37.884083]  print_circular_bug+0x2c2/0x400
[   37.884087]  check_noncircular+0x118/0x130
[   37.884090]  ? save_trace+0x46/0x370
[   37.884093]  ? add_lock_to_list+0x2c/0x1a0
[   37.884096]  __lock_acquire+0x15fc/0x2730
[   37.884101]  lock_acquire+0xb5/0x2a0
[   37.884103]  ? blkg_conf_open_bdev_frozen+0x80/0xa0
[   37.884108]  __mutex_lock+0x83/0x1070
[   37.884111]  ? blkg_conf_open_bdev_frozen+0x80/0xa0
[   37.884114]  ? mark_held_locks+0x49/0x70
[   37.884135]  ? blkg_conf_open_bdev_frozen+0x80/0xa0
[   37.884140]  ? blkg_conf_open_bdev_frozen+0x80/0xa0
[   37.884143]  blkg_conf_open_bdev_frozen+0x80/0xa0
[   37.884147]  ioc_qos_write+0x35/0x4a0
[   37.884150]  ? kernfs_root+0x6e/0x160
[   37.884154]  ? kernfs_root+0x73/0x160
[   37.884157]  ? kernfs_root_flags+0xa/0x10
[   37.884160]  ? kn_priv+0x29/0x70
[   37.884164]  ? cgroup_file_write+0x2b/0x260
[   37.884168]  kernfs_fop_write_iter+0x15c/0x240
[   37.884172]  vfs_write+0x31f/0x4c0
[   37.884176]  ksys_write+0x58/0xd0
[   37.884179]  do_syscall_64+0x6f/0x1120
[   37.884182]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   37.884184] RIP: 0033:0x7f4d8171b87d
[   37.884191] Code: e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 c8 b3 f7 ff 41 89 c0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3b 44 89 c7 48 89 45 f8 e8 ff b3 f7 ff 48 8b
[   37.884193] RSP: 002b:00007ffe01969880 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[   37.884195] RAX: ffffffffffffffda RBX: 0000000000000041 RCX: 00007f4d8171b87d
[   37.884196] RDX: 0000000000000041 RSI: 00007f4d7f7aae60 RDI: 0000000000000007
[   37.884197] RBP: 00007ffe019698a0 R08: 0000000000000000 R09: 00007f4d7f7aae60
[   37.884199] R10: 00007f4d8160afd0 R11: 0000000000000293 R12: 0000000000000041
[   37.884200] R13: 0000000000000007 R14: 00007ffe0196a020 R15: 0000000000000000
[   37.884205]  </TASK>

Happens consistently on boot.

Thanks,
David

