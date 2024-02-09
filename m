Return-Path: <cgroups+bounces-1404-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0FF84EEDB
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 03:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192321F28497
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 02:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7CE1C27;
	Fri,  9 Feb 2024 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="GvOYDXud"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEC184D
	for <cgroups@vger.kernel.org>; Fri,  9 Feb 2024 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707445900; cv=none; b=bsmLR89B4c3a+7x0IT5PxZ9QLowUwjzmMk5tnmHh96cU6yadTa/9LHuiQT8oF6xWhVRzcRskwEjdwGlhcoIAL/fAIhxDSL/pvCQmHm5QnHewoul/6mwBXtttuyONK5SukFxDGbECu6wqFuZXnML2H8NKUghxJc/NXC934BJJ128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707445900; c=relaxed/simple;
	bh=wEBkxV4dn3FcotLbXuFIW/s6Cn5y/4XzLr3yAofl6uE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tCATFVqo8mrOJdq9LVu7m7b1G7JqO897GgELn+8DmmKl8w94zfF0+/0N4/W4U71uclctx+PPKMz8nNuClz/K/o0lG6FFftSK56JjVVTDRJH/QA6EAh2gSi+oDSz03wsm4k5wtZ8og4f+3Keafb97uHR30tDxM5SblkNB41y22cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=GvOYDXud; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-410475afeddso3735175e9.2
        for <cgroups@vger.kernel.org>; Thu, 08 Feb 2024 18:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1707445897; x=1708050697; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MlJk4a+ACUd7zc2tyVc4R+Cusd9XX87Ftg32HapFTY=;
        b=GvOYDXudRwvT81tRQ3mlGbqA0L997txxSl+kRx4zKDolUwONIWg5fSSknhZXQWx/aw
         eNdnumTg7cc0dW/+mBQMD8Ety6CUSJzjIW1rVm3F11LXzuGNJMtZbI27JauzmS4LQiCH
         smjvrPCTfi9Dz3XgHsmlrO6mm5iJ6JRkmHoug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707445897; x=1708050697;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MlJk4a+ACUd7zc2tyVc4R+Cusd9XX87Ftg32HapFTY=;
        b=lj8soh5zoiLv1kUfUeNIOdqh4jrmJI6duKnXw36VBSVCiroDP0CHoegoTcosfbcSbg
         j1Kxf4nKgirLfZ0n5xY1oz8ahtzgl0Oy2x58YDzNRePUg/BTYKoR4UiK8BNXSFQE/6DC
         xE3NWi7012boWiGCXCff7UNHqQvZwX0m9ukAsC0M8UWKNv2tjo51FHDx/Ze//2tJnZX6
         ZURJ2POHYjutJdldb+vPMpb+lUdb3xhcDaoRNAdBnJzvXIlcYV49uIKz37S/9iSN1Nsn
         Z1xvkt+itq1MzrYSZosEmrOKz2vYQ9btYkJMUgwjrt6frtAIbH9CyeYb9IRHYRRXaj/L
         9x2Q==
X-Gm-Message-State: AOJu0YxuFEL7s6KsKcjONQBp+YecO7tJonXWITwHVkLRQfwTtvPG0iCU
	Lqr7GxC/kkmLs1o7ojGdgRR26uvesr8xmJZaKBWsI+ZSrdlWJ4YwWUv3vttLeac=
X-Google-Smtp-Source: AGHT+IFGD6CCwF3dUnWu7TcoZqtOrRS9SOm0ra5hH2MasIfjHAO3fyGCUZ0Iur4YNANfLYFf5Tx5Pg==
X-Received: by 2002:a05:600c:4f13:b0:410:5876:63bf with SMTP id l19-20020a05600c4f1300b00410587663bfmr112973wmq.17.1707445896386;
        Thu, 08 Feb 2024 18:31:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2GGD974d9AiB3cRsdIOSmFYa/arZhxt8Xb/7r/BBmbbHjtsDFQXsQzAnJViS5YIOEtMkKH/ITq75WJk4sdENI5wAM6KO3Qd3FaNq9WVrEByG9U/7lWlO7Aw3+NZc5+I1x8vjewMR79e6o7Jqpcubyw4snGnCw6XEQoPuExFXLpGfkjw==
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0040ff583e17csm1044254wmq.9.2024.02.08.18.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:31:35 -0800 (PST)
Date: Fri, 9 Feb 2024 02:31:35 +0000
From: Chris Down <chris@chrisdown.name>
To: Yu Zhao <yuzhao@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@fb.com,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: MGLRU premature memcg OOM on slow writes
Message-ID: <ZcWOh9u3uqZjNFMa@chrisdown.name>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Yu,

When running with MGLRU I'm encountering premature OOMs when transferring files 
to a slow disk.

On non-MGLRU setups, writeback flushers are awakened and get to work. But on 
MGLRU, one can see OOM killer outputs like the following when doing an rsync 
with a memory.max of 32M:

---

     % systemd-run --user -t -p MemoryMax=32M -- rsync -rv ... /mnt/usb
     Running as unit: run-u640.service
     Press ^] three times within 1s to disconnect TTY.
     sending incremental file list
     ...
     rsync error: received SIGINT, SIGTERM, or SIGHUP (code 20) at rsync.c(713) [generator=3.2.7]

---

     [41368.535735] Memory cgroup out of memory: Killed process 128824 (rsync) total-vm:14008kB, anon-rss:256kB, file-rss:5504kB, shmem-rss:0kB, UID:1000 pgtables:64kB oom_score_adj:200
     [41369.847965] rsync invoked oom-killer: gfp_mask=0x408d40(GFP_NOFS|__GFP_NOFAIL|__GFP_ZERO|__GFP_ACCOUNT), order=0, oom_score_adj=200
     [41369.847972] CPU: 1 PID: 128826 Comm: rsync Tainted: G S         OE      6.7.4-arch1-1 #1 20d30c48b78a04be2046f4b305b40455f0b5b38b
     [41369.847975] Hardware name: LENOVO 20WNS23A0G/20WNS23A0G, BIOS N35ET53W (1.53 ) 03/22/2023
     [41369.847977] Call Trace:
     [41369.847978]  <TASK>
     [41369.847980]  dump_stack_lvl+0x47/0x60
     [41369.847985]  dump_header+0x45/0x1b0
     [41369.847988]  oom_kill_process+0xfa/0x200
     [41369.847990]  out_of_memory+0x244/0x590
     [41369.847992]  mem_cgroup_out_of_memory+0x134/0x150
     [41369.847995]  try_charge_memcg+0x76d/0x870
     [41369.847998]  ? try_charge_memcg+0xcd/0x870
     [41369.848000]  obj_cgroup_charge+0xb8/0x1b0
     [41369.848002]  kmem_cache_alloc+0xaa/0x310
     [41369.848005]  ? alloc_buffer_head+0x1e/0x80
     [41369.848007]  alloc_buffer_head+0x1e/0x80
     [41369.848009]  folio_alloc_buffers+0xab/0x180
     [41369.848012]  ? __pfx_fat_get_block+0x10/0x10 [fat 0a109de409393851f8a884f020fb5682aab8dcd1]
     [41369.848021]  create_empty_buffers+0x1d/0xb0
     [41369.848023]  __block_write_begin_int+0x524/0x600
     [41369.848026]  ? __pfx_fat_get_block+0x10/0x10 [fat 0a109de409393851f8a884f020fb5682aab8dcd1]
     [41369.848031]  ? __filemap_get_folio+0x168/0x2e0
     [41369.848033]  ? __pfx_fat_get_block+0x10/0x10 [fat 0a109de409393851f8a884f020fb5682aab8dcd1]
     [41369.848038]  block_write_begin+0x52/0x120
     [41369.848040]  fat_write_begin+0x34/0x80 [fat 0a109de409393851f8a884f020fb5682aab8dcd1]
     [41369.848046]  ? __pfx_fat_get_block+0x10/0x10 [fat 0a109de409393851f8a884f020fb5682aab8dcd1]
     [41369.848051]  generic_perform_write+0xd6/0x240
     [41369.848054]  generic_file_write_iter+0x65/0xd0
     [41369.848056]  vfs_write+0x23a/0x400
     [41369.848060]  ksys_write+0x6f/0xf0
     [41369.848063]  do_syscall_64+0x61/0xe0
     [41369.848065]  ? do_user_addr_fault+0x304/0x670
     [41369.848069]  ? exc_page_fault+0x7f/0x180
     [41369.848071]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
     [41369.848074] RIP: 0033:0x7965df71a184
     [41369.848116] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 3e 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
     [41369.848117] RSP: 002b:00007fffee661738 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
     [41369.848119] RAX: ffffffffffffffda RBX: 0000570f66343bb0 RCX: 00007965df71a184
     [41369.848121] RDX: 0000000000040000 RSI: 0000570f66343bb0 RDI: 0000000000000003
     [41369.848122] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000570f66343b20
     [41369.848122] R10: 0000000000000008 R11: 0000000000000202 R12: 0000000000000649
     [41369.848123] R13: 0000570f651f8b40 R14: 0000000000008000 R15: 0000570f6633bba0
     [41369.848125]  </TASK>
     [41369.848126] memory: usage 32768kB, limit 32768kB, failcnt 21239
     [41369.848126] swap: usage 2112kB, limit 9007199254740988kB, failcnt 0
     [41369.848127] Memory cgroup stats for /user.slice/user-1000.slice/user@1000.service/app.slice/run-u640.service:
     [41369.848174] anon 0
     [41369.848175] file 26927104
     [41369.848176] kernel 6615040
     [41369.848176] kernel_stack 32768
     [41369.848177] pagetables 122880
     [41369.848177] sec_pagetables 0
     [41369.848177] percpu 480
     [41369.848178] sock 0
     [41369.848178] vmalloc 0
     [41369.848178] shmem 0
     [41369.848179] zswap 312451
     [41369.848179] zswapped 1458176
     [41369.848179] file_mapped 0
     [41369.848180] file_dirty 26923008
     [41369.848180] file_writeback 0
     [41369.848180] swapcached 12288
     [41369.848181] anon_thp 0
     [41369.848181] file_thp 0
     [41369.848181] shmem_thp 0
     [41369.848182] inactive_anon 0
     [41369.848182] active_anon 12288
     [41369.848182] inactive_file 15908864
     [41369.848183] active_file 11014144
     [41369.848183] unevictable 0
     [41369.848183] slab_reclaimable 5963640
     [41369.848184] slab_unreclaimable 89048
     [41369.848184] slab 6052688
     [41369.848185] workingset_refault_anon 4031
     [41369.848185] workingset_refault_file 9236
     [41369.848185] workingset_activate_anon 691
     [41369.848186] workingset_activate_file 2553
     [41369.848186] workingset_restore_anon 691
     [41369.848186] workingset_restore_file 0
     [41369.848187] workingset_nodereclaim 0
     [41369.848187] pgscan 40473
     [41369.848187] pgsteal 20881
     [41369.848188] pgscan_kswapd 0
     [41369.848188] pgscan_direct 40473
     [41369.848188] pgscan_khugepaged 0
     [41369.848189] pgsteal_kswapd 0
     [41369.848189] pgsteal_direct 20881
     [41369.848190] pgsteal_khugepaged 0
     [41369.848190] pgfault 6019
     [41369.848190] pgmajfault 4033
     [41369.848191] pgrefill 30578988
     [41369.848191] pgactivate 2925
     [41369.848191] pgdeactivate 0
     [41369.848192] pglazyfree 0
     [41369.848192] pglazyfreed 0
     [41369.848192] zswpin 1520
     [41369.848193] zswpout 1141
     [41369.848193] thp_fault_alloc 0
     [41369.848193] thp_collapse_alloc 0
     [41369.848194] thp_swpout 0
     [41369.848194] thp_swpout_fallback 0
     [41369.848194] Tasks state (memory values in pages):
     [41369.848195] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
     [41369.848195] [ 128825]  1000 128825     3449      864    65536      192           200 rsync
     [41369.848198] [ 128826]  1000 128826     3523      288    57344      288           200 rsync
     [41369.848199] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/user.slice/user-1000.slice/user@1000.service/app.slice/run-u640.service,task_memcg=/user.slice/user-1000.slice/user@1000.service/app.slice/run-u640.service,task=rsync,pid=128825,uid=1000
     [41369.848207] Memory cgroup out of memory: Killed process 128825 (rsync) total-vm:13796kB, anon-rss:0kB, file-rss:3456kB, shmem-rss:0kB, UID:1000 pgtables:64kB oom_score_adj:200

---

Importantly, note that there appears to be no attempt to write back before 
declaring OOM -- file_writeback is 0 when file_dirty is 26923008. The issue is 
consistently reproducible (and thanks Johannes for looking at this with me).

On non-MGLRU, flushers are active and are making forward progress in preventing 
OOM.

This is writing to a slow disk with about ~10MiB/s available write speed, so 
the CPU and read speed is far faster than the write speed the disk 
can take.

Is this a known problem in MGLRU? If not, could you point me to where MGLRU 
tries to handle flusher wakeup on slow I/O? I didn't immediately find it.

Thanks,

Chris

