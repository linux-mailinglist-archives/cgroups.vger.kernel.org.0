Return-Path: <cgroups+bounces-8729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DDB04C69
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 01:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C95A1AA13DE
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51FF261574;
	Mon, 14 Jul 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Gj1Gr6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F611A0BFD;
	Mon, 14 Jul 2025 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536252; cv=none; b=e2W+92wglNP+XMDEsMoCcWOyCpvtEqVCG3/YSMzND70i+Wley3k3qM2TqLN4GtTIsSNSu0npgm7CpO+HPMeno0H0SDytZiStLV1jDPdIv4PV/qWJyra+B5WFlmKy6IGe5NwNyn4lBSHM166/B+6Xl1B7EQ7bZLi3/rb/7V+L6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536252; c=relaxed/simple;
	bh=IZwdSKfJ6LTk7f0w0qRn9qHL2p4rKY1ZvtAiEmdG0MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c/qXeefNaikR6C9hlHQYYlj6qFk4Ky8TU6G3V7stowNFczQaYroJXMU/obr6CkNWlFKxbvkzdAsQnzfWYRyS/+Gvcj2J7A4WT9eeQOFQFm2IBOtwgbB23+3vd8quPfg3glU3lT7AKBV42iN34e/nvzqoE74XLT2/JP2/5tHMqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Gj1Gr6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso2773538b3a.0;
        Mon, 14 Jul 2025 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752536250; x=1753141050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=td6pmDSnLDjGibszlEvG05DOMc+1RCYOlbPz4hs8/fg=;
        b=H0Gj1Gr6i4biOOxbOisMzv7TdmUum3GZ5Kh928M74SIAdrn0I18K4LxiYqzUh6h/fJ
         G4Yhou2roMWw3qHriJvxspgIZh8ySaHJdWfHqVZ7J1rcNgQY5mP+/1AEYmQgymTMQyC7
         OhI3s47UbCBsvBQmIHNp4VIoRhAlU7Ezj9+Q9j/gqpXNTeuo11kKxdcAtD9nfwVCtYwT
         r/rmQFxB0dszCDFSHjRHr676exwM5O3B577AwXVUAzf80LH81F1gF/G/QvZIdzJyR4V/
         gmiQuJOPME6oL5v74oaVMhtlsUlhUIpFcoCYW0x+ItSKrfd8q6AMH63a5VGo8WA0MTrb
         n+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752536250; x=1753141050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=td6pmDSnLDjGibszlEvG05DOMc+1RCYOlbPz4hs8/fg=;
        b=Ze23Keway5xm/BcWuHqiWSi6Lot8y+bvxJRyb+/KMozcs9OF7sK8nshAeUMruGBfKr
         QA21GwZTIrmhrrJsfjTlL8XoljlgvP8n8ZAF0v399GZd6kKfE+8xaweQFNsyPraM4g/E
         OX5Sx7wKD+hOitP/acxxa5WZ/5qr/+QL7mOUETlNrnbNDpTjwPGsYlDG4wnVaP3aVCJ+
         zp/NFckqU50unORKLOd0INLe5bdwxENvquSPiY8qEEHI0MirJz0DCq/cki3ld7gRD9XO
         5YrwIZNTjDe6REq8wiW+NAoQv3u78Z/zRhj+wtg6V8tovksuDo3/htTNOiB7UeLrVkNR
         6yjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWwTDQh5/ZF2SAwt4cORoBsYIP32zjWBjpvuBqfKj0HWl1I8BgzpCbeejBXtQ2RWZHh5qV+mur@vger.kernel.org, AJvYcCXYMwf1n516LoFTdRBxjg0WZGZtdvj42SisQvF0msg3bjn6N+y0l/IFR8OpU/fLmQWBruq6NFXjWwpYUP25@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKhWYx5yUF6kPIqhMm3d6NgwCxEOEJ0m3f39ARyeDSdRiqHtt
	3sk3K7Df2ZljIMuEy8h5mfvAEyD1Xnfygw3xVw4mi0w0tgVQprv7GJdS16XOdQ==
X-Gm-Gg: ASbGnctURDs9yn9kg6wTW1KetP41LlIkc2FmaAKdhtkX4oC+AiAuAfnaT7Xp6L4CCvl
	LgoH+0mmQ4or2HN9VaxUpCNnt5eqcqJbX2Av5rDxG5VTw9mci9uOBWq3zSP8Xm2HbcRaFvzmYS/
	UXxshmnbUp9QUHFwVR/TTaVFfW2YfJDI9lmhN9Qv/XrccxBlHvUpIhiGJkqRcmLyfCsZ+GW9D3b
	hiA7gVmsGN8/D6TAba1wB03bI18LnHgCNAUP5icCOcj6/sxNAHzvguMAuZjI/Tf1YrP0FiXebh1
	DY010P4+PjX49of+0845cgab9yconjpxPWcHkQct2teAfMhVOk0BWzy9fJLoBrCn3msB4dKNZ0X
	b3mLj0Sgfhn6SklUarwplQG3uqP+RXkQ1pKsmC+fGrj7GZeYoPb8SGrWZs2jTjEilwIjs
X-Google-Smtp-Source: AGHT+IGkaDTwMg57TfcWRZco/z/OQ+t6fbmVeRtZiE3+hqQqEc2WWUm90Aha20ec+67Xdw0ljSFIDw==
X-Received: by 2002:a05:6a00:a0c:b0:732:2923:b70f with SMTP id d2e1a72fcca58-74ee2557a68mr22642478b3a.11.1752536250354;
        Mon, 14 Jul 2025 16:37:30 -0700 (PDT)
Received: from [192.168.1.117] (c-67-180-10-175.hsd1.ca.comcast.net. [67.180.10.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd73a6sm10822752b3a.20.2025.07.14.16.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 16:37:29 -0700 (PDT)
Message-ID: <9008807c-58c6-4b2d-b227-545882436ec6@gmail.com>
Date: Mon, 14 Jul 2025 16:37:27 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
To: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
347e9f5043c89695b01e66b3ed111755afcf1911

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..e6c5c998ead6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5669,6 +5669,12 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,

  	init_and_link_css(css, ss, cgrp);

+	err = css_rstat_init(css);
+	if (err) {
+		ss->css_free(css);
+		goto err_out;
+	}
+
  	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
  	if (err)
  		goto err_free_css;
@@ -5678,10 +5684,6 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,
  		goto err_free_css;
  	css->id = err;

-	err = css_rstat_init(css);
-	if (err)
-		goto err_free_css;
-
  	/* @css is ready to be brought online now, make it visible */
  	list_add_tail_rcu(&css->sibling, &parent_css->children);
  	cgroup_idr_replace(&ss->css_idr, css, css->id);
@@ -5697,6 +5699,7 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,
  err_free_css:
  	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
  	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+err_out:
  	return ERR_PTR(err);
  }

On 7/14/25 12:29 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5d5d62298b8b Merge tag 'x86_urgent_for_v6.16_rc6' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dabd82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
> dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c47d4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d2d0d46a0e87/disk-5d5d6229.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0bf6381177a8/vmlinux-5d5d6229.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2f3ae8f165f2/bzImage-5d5d6229.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9 at kernel/cgroup/rstat.c:497 css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
> Modules linked in:
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.16.0-rc5-syzkaller-00276-g5d5d62298b8b #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Workqueue: cgroup_destroy css_free_rwork_fn
> RIP: 0010:css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
> Code: 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 0e 01 00 00 49 c7 85 70 05 00 00 00 00 00 00 e9 00 ff ff ff e8 d9 09 07 00 90 <0f> 0b 90 e9 3e ff ff ff e8 cb 09 07 00 90 0f 0b 90 e9 30 ff ff ff
> RSP: 0018:ffffc900000e7bc0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8881404a4e00 RCX: ffff888124720000
> RDX: ffff88801e298000 RSI: ffffffff81b45507 RDI: ffffffff8df37da0
> RBP: ffff8881404a4e08 R08: 0000000000000005 R09: 0000000000000007
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881404a4e20
> R13: 0000000000000000 R14: 0000000000000003 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888124720000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000034892000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   css_free_rwork_fn+0x80/0x12e0 kernel/cgroup/cgroup.c:5449
>   process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3321 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


