Return-Path: <cgroups+bounces-5648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B29D3200
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 03:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C252F283EC1
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 02:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20041E86E;
	Wed, 20 Nov 2024 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jY0VaqoR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561DBA4B
	for <cgroups@vger.kernel.org>; Wed, 20 Nov 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068365; cv=none; b=SoXzGguKQYVX/CyW5hoONLSz3MKmLzpgZ9u1bE+J1RD/T3TBMeV40QGphJbpIsUDXVkufJ+9F9KTdutMl1Lv05weMcZhyTr/OK6c1jh+QqMfBVBMFvIM5gANHHllGyMCo2NGEmZVQgGM3odlWbq9tuf6Wlf1T//ZWbwKhFIFE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068365; c=relaxed/simple;
	bh=NrXZS7z6piojoTKtIuFW8W4hz5WtNP/lPOiq5PK25Rk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k9nCKkZT0CK1PGpjIfmGYnv7UxCiYgD30jcbvY2xZUQAnTGutfa/cXCQj4ad1/y8rm7v+RNhGjrC+SkVB0chPQwoZvg4lggRAq+0tRFlGuP4gBsqNDpokaoV/qpiFILFwC3AkFAAtLrl1TJuW+XWxTq3DlnqaixrsqVxSl+067k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jY0VaqoR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21116b187c4so28362715ad.3
        for <cgroups@vger.kernel.org>; Tue, 19 Nov 2024 18:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732068363; x=1732673163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os1la1Kb6FjtkBbLXARGU7KzNa7W0YtNDjjutSJCWzU=;
        b=jY0VaqoRPSqUGNUNs5D8+Zf17bM2hDDRZSunMFl1dElHwD+grbHpW8ccVNzcRO4aJB
         4YpwmKJ3neIcgzp5WHS6xuDhjM+dkgFVfvk2rqwPj73Hulb+6Xgywssh+dHOnXN9aWPa
         Li7y1zDFUJnZgUhqMeY4CyBsL1e7EIDv1qEoc3a2NapxLIbjY2qNwlWXppTaraAMPKYN
         LJZzgF+Un5PhrXV1mvxIpRHeEYK8QIoJKb0l9gexmrGfToLxeytaAVEph8cwMWsee3VL
         a5jk7qIZy+4OQHFpeg63E39V6qNyNfTue8geaS3jnNhBuNg1gL97GYWTaFL5m6e+SBbS
         zcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068363; x=1732673163;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os1la1Kb6FjtkBbLXARGU7KzNa7W0YtNDjjutSJCWzU=;
        b=XJZsKjiWJiB95ByKiNSPJzEAjx8jsnmAfQp/wrASrO3QF7ydsQanATFE1J2I8qr3Wk
         LqP9JCUhPIrpeFElAVLRlBovbohBEGvlufXTpxDtylbibQdPfnjF8QlN3Wt3IhT6e7pU
         VyCEAb26ZURu//ktCO57nhM+6tUqCEhGpYfMhj288q6FlO3hOG9Zkyl01G2RcEJriTpp
         BQ93zP5xIZSBl09hLXxgpUAcosxXqlh55L+7Eg/lF/wOPGva+n21xf28xnawGYHBgl9O
         23d8EJVnQy9Sp7K9hHgcCWYdpLqyWqITGzjs4mYjIjPGycj+oPUazlJ/U8QdpumHMrXU
         uYsA==
X-Forwarded-Encrypted: i=1; AJvYcCW062mx1cdTgIRB7kBFvVVspvdqsugL0OUBEn7CySP9Johe3cyAdVv85bywM0VWBmiA0N0F+kjM@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWv2plySh1rZAXcVi5KBYbSNnK0Ohu+LfRpD76CRFXfKrKDw3
	PNQxmmUbkytr843UubrwD8+XUHokX1Lrl9eNQ3Z9eJkhnfUVxa9F1jYXkjfqEoE=
X-Google-Smtp-Source: AGHT+IExO5AA2SJHZ0fyOFEFuJdgfrqhsLfJNIIGUa5+Wrgez4ddbtnOOHd/GLgTucKNdDTsUxnhtQ==
X-Received: by 2002:a17:902:dac7:b0:212:40e0:9553 with SMTP id d9443c01a7336-2126a41ad3emr14887915ad.32.1732068363103;
        Tue, 19 Nov 2024 18:06:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0311078sm120983a91.8.2024.11.19.18.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:06:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai3@huawei.com, tj@kernel.org, josef@toxicpanda.com, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zach Wade <zachwade.k@gmail.com>
Cc: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20241119153410.2546-1-zachwade.k@gmail.com>
References: <20241119153410.2546-1-zachwade.k@gmail.com>
Subject: Re: [PATCH] Revert "block, bfq: merge bfq_release_process_ref()
 into bfq_put_cooperator()"
Message-Id: <173206836183.183392.14838257909819889976.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 19:06:01 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 23:34:10 +0800, Zach Wade wrote:
> This reverts commit bc3b1e9e7c50e1de0f573eea3871db61dd4787de.
> 
> The bic is associated with sync_bfqq, and bfq_release_process_ref cannot
> be put into bfq_put_cooperator.
> 
> kasan report:
> [  400.347277] ==================================================================
> [  400.347287] BUG: KASAN: slab-use-after-free in bic_set_bfqq+0x200/0x230
> [  400.347420] Read of size 8 at addr ffff88881cab7d60 by task dockerd/5800
> [  400.347430]
> [  400.347436] CPU: 24 UID: 0 PID: 5800 Comm: dockerd Kdump: loaded Tainted: G E 6.12.0 #32
> [  400.347450] Tainted: [E]=UNSIGNED_MODULE
> [  400.347454] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.20192059.B64.2207280713 07/28/2022
> [  400.347460] Call Trace:
> [  400.347464]  <TASK>
> [  400.347468]  dump_stack_lvl+0x5d/0x80
> [  400.347490]  print_report+0x174/0x505
> [  400.347521]  kasan_report+0xe0/0x160
> [  400.347541]  bic_set_bfqq+0x200/0x230
> [  400.347549]  bfq_bic_update_cgroup+0x419/0x740
> [  400.347560]  bfq_bio_merge+0x133/0x320
> [  400.347584]  blk_mq_submit_bio+0x1761/0x1e20
> [  400.347625]  __submit_bio+0x28b/0x7b0
> [  400.347664]  submit_bio_noacct_nocheck+0x6b2/0xd30
> [  400.347690]  iomap_readahead+0x50c/0x680
> [  400.347731]  read_pages+0x17f/0x9c0
> [  400.347785]  page_cache_ra_unbounded+0x366/0x4a0
> [  400.347795]  filemap_fault+0x83d/0x2340
> [  400.347819]  __xfs_filemap_fault+0x11a/0x7d0 [xfs]
> [  400.349256]  __do_fault+0xf1/0x610
> [  400.349270]  do_fault+0x977/0x11a0
> [  400.349281]  __handle_mm_fault+0x5d1/0x850
> [  400.349314]  handle_mm_fault+0x1f8/0x560
> [  400.349324]  do_user_addr_fault+0x324/0x970
> [  400.349337]  exc_page_fault+0x76/0xf0
> [  400.349350]  asm_exc_page_fault+0x26/0x30
> [  400.349360] RIP: 0033:0x55a480d77375
> [  400.349384] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 49 3b 66 10 0f 86 ae 02 00 00 55 48 89 e5 48 83 ec 58 48 8b 10 <83> 7a 10 00 0f 84 27 02 00 00 44 0f b6 42 28 44 0f b6 4a 29 41 80
> [  400.349392] RSP: 002b:00007f18c37fd8b8 EFLAGS: 00010216
> [  400.349401] RAX: 00007f18c37fd9d0 RBX: 0000000000000000 RCX: 0000000000000000
> [  400.349407] RDX: 000055a484407d38 RSI: 000000c000e8b0c0 RDI: 0000000000000000
> [  400.349412] RBP: 00007f18c37fd910 R08: 000055a484017f60 R09: 000055a484066f80
> [  400.349417] R10: 0000000000194000 R11: 0000000000000005 R12: 0000000000000008
> [  400.349422] R13: 0000000000000000 R14: 000000c000476a80 R15: 0000000000000000
> [  400.349430]  </TASK>
> [  400.349452]
> [  400.349454] Allocated by task 5800:
> [  400.349459]  kasan_save_stack+0x30/0x50
> [  400.349469]  kasan_save_track+0x14/0x30
> [  400.349475]  __kasan_slab_alloc+0x89/0x90
> [  400.349482]  kmem_cache_alloc_node_noprof+0xdc/0x2a0
> [  400.349492]  bfq_get_queue+0x1ef/0x1100
> [  400.349502]  __bfq_get_bfqq_handle_split+0x11a/0x510
> [  400.349511]  bfq_insert_requests+0xf55/0x9030
> [  400.349519]  blk_mq_flush_plug_list+0x446/0x14c0
> [  400.349527]  __blk_flush_plug+0x27c/0x4e0
> [  400.349534]  blk_finish_plug+0x52/0xa0
> [  400.349540]  _xfs_buf_ioapply+0x739/0xc30 [xfs]
> [  400.350246]  __xfs_buf_submit+0x1b2/0x640 [xfs]
> [  400.350967]  xfs_buf_read_map+0x306/0xa20 [xfs]
> [  400.351672]  xfs_trans_read_buf_map+0x285/0x7d0 [xfs]
> [  400.352386]  xfs_imap_to_bp+0x107/0x270 [xfs]
> [  400.353077]  xfs_iget+0x70d/0x1eb0 [xfs]
> [  400.353786]  xfs_lookup+0x2ca/0x3a0 [xfs]
> [  400.354506]  xfs_vn_lookup+0x14e/0x1a0 [xfs]
> [  400.355197]  __lookup_slow+0x19c/0x340
> [  400.355204]  lookup_one_unlocked+0xfc/0x120
> [  400.355211]  ovl_lookup_single+0x1b3/0xcf0 [overlay]
> [  400.355255]  ovl_lookup_layer+0x316/0x490 [overlay]
> [  400.355295]  ovl_lookup+0x844/0x1fd0 [overlay]
> [  400.355351]  lookup_one_qstr_excl+0xef/0x150
> [  400.355357]  do_unlinkat+0x22a/0x620
> [  400.355366]  __x64_sys_unlinkat+0x109/0x1e0
> [  400.355375]  do_syscall_64+0x82/0x160
> [  400.355384]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  400.355393]
> [  400.355395] Freed by task 5800:
> [  400.355400]  kasan_save_stack+0x30/0x50
> [  400.355407]  kasan_save_track+0x14/0x30
> [  400.355413]  kasan_save_free_info+0x3b/0x70
> [  400.355422]  __kasan_slab_free+0x4f/0x70
> [  400.355429]  kmem_cache_free+0x176/0x520
> [  400.355438]  bfq_put_queue+0x67e/0x980
> [  400.355447]  bfq_bic_update_cgroup+0x407/0x740
> [  400.355454]  bfq_bio_merge+0x133/0x320
> [  400.355460]  blk_mq_submit_bio+0x1761/0x1e20
> [  400.355467]  __submit_bio+0x28b/0x7b0
> [  400.355473]  submit_bio_noacct_nocheck+0x6b2/0xd30
> [  400.355480]  iomap_readahead+0x50c/0x680
> [  400.355490]  read_pages+0x17f/0x9c0
> [  400.355498]  page_cache_ra_unbounded+0x366/0x4a0
> [  400.355505]  filemap_fault+0x83d/0x2340
> [  400.355514]  __xfs_filemap_fault+0x11a/0x7d0 [xfs]
> [  400.356204]  __do_fault+0xf1/0x610
> [  400.356213]  do_fault+0x977/0x11a0
> [  400.356221]  __handle_mm_fault+0x5d1/0x850
> [  400.356230]  handle_mm_fault+0x1f8/0x560
> [  400.356238]  do_user_addr_fault+0x324/0x970
> [  400.356248]  exc_page_fault+0x76/0xf0
> [  400.356258]  asm_exc_page_fault+0x26/0x30
> [  400.356266]
> [  400.356269] The buggy address belongs to the object at ffff88881cab7bc0
>                 which belongs to the cache bfq_queue of size 576
> [  400.356276] The buggy address is located 416 bytes inside of
>                 freed 576-byte region [ffff88881cab7bc0, ffff88881cab7e00)
> [  400.356285]
> [  400.356287] The buggy address belongs to the physical page:
> [  400.356292] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88881cab0b00 pfn:0x81cab0
> [  400.356300] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  400.356323] flags: 0x50000000000040(head|node=1|zone=2)
> [  400.356331] page_type: f5(slab)
> [  400.356340] raw: 0050000000000040 ffff88880a00c280 dead000000000122 0000000000000000
> [  400.356347] raw: ffff88881cab0b00 00000000802e0025 00000001f5000000 0000000000000000
> [  400.356354] head: 0050000000000040 ffff88880a00c280 dead000000000122 0000000000000000
> [  400.356359] head: ffff88881cab0b00 00000000802e0025 00000001f5000000 0000000000000000
> [  400.356365] head: 0050000000000003 ffffea002072ac01 ffffffffffffffff 0000000000000000
> [  400.356370] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> [  400.356378] page dumped because: kasan: bad access detected
> [  400.356381]
> [  400.356383] Memory state around the buggy address:
> [  400.356387]  ffff88881cab7c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356392]  ffff88881cab7c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356397] >ffff88881cab7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356400]                                                        ^
> [  400.356405]  ffff88881cab7d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356409]  ffff88881cab7e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  400.356413] ==================================================================
> 
> [...]

Applied, thanks!

[1/1] Revert "block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()"
      commit: cf5a60d971c7b59efb89927919404be655a9e35a

Best regards,
-- 
Jens Axboe




