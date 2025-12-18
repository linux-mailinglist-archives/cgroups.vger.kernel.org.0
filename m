Return-Path: <cgroups+bounces-12490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB6CCB3B0
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C66301C97D
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E52F069E;
	Thu, 18 Dec 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNK3f89R"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685A78F29
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050939; cv=none; b=BeE/JKX3ygh4AMGaLEcbSDBUMpxnI31NYVPVDb/zA7V26DFlHAeasq2RQUCSR6EESeNSe/62Nh9Po2uq4vo8OnmFkO8LAhAERfMcJ8eIPZZbdt1Or3406ixK+EjgeHMzOrqQ+MasAq03XxbTp//IPGif+/J2U9+lhnJ6P+BSZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050939; c=relaxed/simple;
	bh=ntX+xKNQ/ShCZa+vAJTz5dA3J9J/B6Pym/vNM7E7ZSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOSavUaiKe/EGWvkX9K1k2Ipe9tL2rfM3wqdod87H7PWVQEiwBgA+sJuacfsDRZkqMzU3TKU3jB+ClCnFT4GjIUD5awQ3Wd/v/kINbwDFpogoNQ/JG7YO1iZtyhVXbb1D3DdXXvDc4Tr4KMRZzcijrwfSLT/4WmETMb/MtjNUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNK3f89R; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d67f1877so5022885ad.2
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 01:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766050935; x=1766655735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zyo5FBRjmX0cgj/AjxXB/1SEjsw5dqsFUWfHJVTAo8=;
        b=ZNK3f89RJI9nBljO1IQ0wrUHNsx/WP67ArfabV4S0/TyJEegGC+o2dq7me85KvLOKa
         QkINoncg25Mlrm4/ckuhFG5Cr9u/asY15lb54WBBNS6HCRj05Z7jXLRvOWizYwEmYzxT
         4qBKqsha1CLnIDsXv67xfdBrbqRotJ7yGcvW8FP2/Grytj2bF6M1A869HHoixE72qqRd
         p1AoU7plgkUTkHGDSe8V7dpLCbzLkiMq1pFlqwxTga+G+6jQcnxU7w7otDQF5SXubemN
         fKUyUzyZijTFAz/5lidJo52l2ds832GgXDvteoH2H4gbqZe0Sa5JtRm5920TvzG3gCsf
         wjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766050935; x=1766655735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3zyo5FBRjmX0cgj/AjxXB/1SEjsw5dqsFUWfHJVTAo8=;
        b=oBFVep4DWdIqD9kbTtf553m5wzvKJxddFmloW1288OnQE9A6OiM7hbw5tw6ekCHAZ9
         4/Y4x6+tbZgeE6oidmYY9VlmC3sfKmypUWTpuS2Ysd/v+k9vnFrNJUY6sUgExJVfNTUQ
         RR6ouzNe+7j6coua4Fx/kM+18izhs3qHzdUfoJZBTvfVIQBKgcGI6Q32EdDl0x0PRcVs
         i7vaHpD5Kj7iT4bqi19mmsZRmvQ7Qjcv7EH053xaAqf+lk+SJzdOj5AFTTu0S70jCD1R
         os6uC34w2c+JPW/EWTJkGuXDUOemIh8joo+GyVYWHqToMr9f5Wxr9zKIP5QRBvoYoUDL
         ju5A==
X-Forwarded-Encrypted: i=1; AJvYcCWEsQiUosdeRgVNo8lmgFwiZfzYnrkpbGEroptv8P+mFAGiZSnwgzOk3MxDDWcWPxKV0mNO9EY8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2VubNgK8ccFN5Wm4rvExxZpLF7Bl0iLQju9XHynw8GkTSlvO
	q1Lng40lR3q/uXVYS3dzn5eUNpNb/iRfcKRuDbkK7ZNnaXReZ7tUo7TQ
X-Gm-Gg: AY/fxX45CiNT4zSyHUdfiMSExO66MIlmScv1MX5J421ojbjy4XMomaV/xh1VG2VR4s9
	b8F2sqYhWAVaQ6m/SoiVehAgMOfungMI0c8v0R/59R1Qudgk+pqZ5Aj8+cy4Wma8K8eRCgcaMy6
	iYXTVcCCznjBJFVhYM6SFStiCqdS6Wvnz+AR5hO7dneAjJTaLaVbdqoRPat1Nx7tLrIRsqEzYrK
	+H9aRAcE4FywC7qeQgd/K4f3LJ+q4RMoz+adMzfkJPf5hnE3xC9Ks+Z2/+o5GIGbhUdQHnRfSfy
	hR5qwa+FR4aWJKzq9ImWsnA8EgOscBAeV/nvsMXCMDFKk77/ia67vqhVAV2UJHm1gaOA5KClT3R
	nYI+CpTP/pbT/Q0ZJPhox3bx+fAeED0+qS/DYJR9fyD8KPder5T8POAXCMvlbECJcfKEMnFAgft
	ikI/+wLPGv
X-Google-Smtp-Source: AGHT+IGIAa/ktrtJoKDE/1BSOuKnkeTQnuLiTcncTkK7hIpss5LZMIRg5O7nwBgo8EodPRErlsiQgg==
X-Received: by 2002:a17:903:943:b0:29e:9c82:a91e with SMTP id d9443c01a7336-29f23b1406dmr191420375ad.7.1766050934919;
        Thu, 18 Dec 2025 01:42:14 -0800 (PST)
Received: from ubuntu.. ([103.163.65.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c741sm19431235ad.8.2025.12.18.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:42:14 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: shakeel.butt@linux.dev
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	kdipendra88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Subject: 
Date: Thu, 18 Dec 2025 09:42:08 +0000
Message-ID: <20251218094208.1369-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gktuqmvopl7pgbcaw3rwiq77vb2zguae3jfdxmwfgtetf3twu4@gcb5bubhxq64>
References: <gktuqmvopl7pgbcaw3rwiq77vb2zguae3jfdxmwfgtetf3twu4@gcb5bubhxq64>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Re: [PATCH] mm/memcg: reorder retry checks for clarity in try_charge_memcg
From: Dipendra Khadka <kdipendra88@gmail.com>

Hi Shakeel,

This response is not generated by AI.

I have applied following changes in try_charge_memcg() and
please find the respective logs below which shows that after
sigkill, its doing unnecessary full reclaim attempts.

On rest, I agree with you.Hence, I think this patch makes
sense.

Change:

if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
        {
                pr_info("Dipendra MEMCG_RECLAIM: Reclaim successful, reclaimed 
%lu pages\n",
                                nr_reclaimed);
                goto retry;
        }

        pr_info("Dipendra MEMCG_RECLAIM: Reclaimed %lu pages but still 
insufficient\n", nr_reclaimed);
        if (!drained) {
                drain_all_stock(mem_over_limit);
                drained = true;
                goto retry;
        }

        if (gfp_mask & __GFP_NORETRY)
                goto nomem;
        pr_info("Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting 
reclaim\n");
        pr_info("Dipendra MEMCG_RECLAIM: Target=%lu pages, memcg=%s\n",
                        nr_pages, memcg->css.cgroup->kn->name);
        /*
         * Even though the limit is exceeded at this point, reclaim
         * may have been able to free some pages.  Retry the charge
         * before killing the task.
         *
         * Only for regular pages, though: huge pages are rather
         * unlikely to succeed so close to the limit, and we fall back
         * to regular pages anyway in case of failure.
         */
        if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
                goto retry;

        if (passed_oom && task_is_dying()) {
                pr_info("Dipendra MEMCG: retry while dying!\n");
                pr_info(" pid=%d comm=%s nr_retries=%d gfp=0x%x\n", 
current->pid, current->comm, nr_retries, gfp_mask);
                dump_stack();
        }

        if (nr_retries--)
        {
                pr_info("Dipendra: nr_retires =%d\n",nr_retries);
                goto retry;
        }

        if (gfp_mask & __GFP_RETRY_MAYFAIL)
                goto nomem;

        /* Avoid endless loop for tasks bypassed by the oom killer */
        if (passed_oom && task_is_dying())
        {
                pr_info("Dipendra : I am dying already.....\n");
                goto nomem;
        }

        /*
         * keep retrying as long as the memcg oom killer is able to make
         * a forward progress or bypass the charge if the oom killer
         * couldn't make any progress.
         */
        pr_info("Dipendra %s:%d:%s(): calling mem_cgroup_oom\n", __FILE__, 
__LINE__, __func__);
        if (mem_cgroup_oom(mem_over_limit, gfp_mask,
                           get_order(nr_pages * PAGE_SIZE))) {
                passed_oom = true;
                pr_info("Dipendra MEMCG_RECLAIM: Reclaim failed after OOM, 
reclaimed only %lu pages\n",nr_reclaimed);
                pr_info("Dipendra MEMCG_CHARGE: Failing charge request\n");
                nr_retries = MAX_RECLAIM_RETRIES;
                goto retry;
        }


Logs:=============================================================Logs

[   56.419230] Dipendra MEMCG_CHARGE: Charge failed (ENOMEM) :
[   56.419231] Dipendra MEMCG_CHARGE: Usage=131072, Limit=131072
[   56.419244] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419257] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419257] Dipendra MEMCG_CHARGE: Charge failed (ENOMEM) :
[   56.419257] Dipendra MEMCG_CHARGE: Usage=131072, Limit=131072
[   56.419270] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419283] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419283] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419284] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419284] Dipendra: nr_retires =15
[   56.419297] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419297] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419298] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419298] Dipendra: nr_retires =14
[   56.419311] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419311] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419312] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419312] Dipendra: nr_retires =13
[   56.419325] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419325] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419325] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419326] Dipendra: nr_retires =12
[   56.419338] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419339] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419339] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419339] Dipendra: nr_retires =11
[   56.419352] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419352] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419353] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419353] Dipendra: nr_retires =10
[   56.419366] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419367] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419367] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419368] Dipendra: nr_retires =9
[   56.419380] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419381] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419381] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419382] Dipendra: nr_retires =8
[   56.419394] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419395] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419395] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419395] Dipendra: nr_retires =7
[   56.419408] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419408] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419409] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419409] Dipendra: nr_retires =6
[   56.419421] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419422] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419422] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419423] Dipendra: nr_retires =5
[   56.419435] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419436] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419436] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419437] Dipendra: nr_retires =4
[   56.419450] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419450] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419450] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419451] Dipendra: nr_retires =3
[   56.419463] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419464] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419464] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419465] Dipendra: nr_retires =2
[   56.419477] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419478] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419478] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419479] Dipendra: nr_retires =1
[   56.419491] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419492] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419492] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419493] Dipendra: nr_retires =0
[   56.419505] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419506] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419506] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419507] Dipendra mm/memcontrol.c:2480:try_charge_memcg(): calling 
mem_cgroup_oom
[   56.419508] Dipendra mm/memcontrol.c:1722:mem_cgroup_oom(): calling 
mem_cgrup_out_of_memory
[   56.419509]  Dipendra MEMCG_OOM: ===== MEMCG OOM TRIGGERED =====
[   56.419509] Dipendra MEMCG_OOM: memcg=test512mb (id=78)
[   56.419510] Dipendra MEMCG_OOM: gfp_mask=0x100cca, order=0
[   56.419511] Dipendra MEMCG_OOM: memory.max=131072, memory.current=131072
[   56.419511] Dipendra MEMCG_OOM: swap.max=0, swap.current=0
[   56.419512] Dipendra MEMCG_OOM: Acquired oom_lock, calling out_of_memory()
[   56.419513] Dipendra mm/oom_kill.c:1159:out_of_memory(): enter
[   56.419514] Dipendra OOM: ===== OUT_OF_MEMORY INVOKED =====
[   56.419515] Dipendra OOM: gfp_mask=0x100cca, order=0
[   56.419515] Dipendra OOM: nodemask=(null)
[   56.419517] Dipendra OOM: memcg=0000000009ac44a2 (memcg OOM)
[   56.419520] Dipendra OOM: Selecting victim to kill...
[   56.419520] Dipendra mm/oom_kill.c:380:select_bad_process(): enter
[   56.419521] Dipendra OOM_SELECT: ===== STARTING VICTIM SELECTION =====
[   56.419522] Dipendra mm/oom_kill.c:384:select_bad_process(): calling 
mem_cgroup_scan_tasks
[   56.419522] Dipendra OOM_SELECT: Memcg OOM - iterating memcg tasks
[   56.419522] Dipendra mm/memcontrol.c:1158:mem_cgroup_scan_tasks(): enter
[   56.419525] Dipendra OOM_EVAL: Task badness score=377 (current 
best=-9223372036854775808)
[   56.419526] Dipendra OOM_EVAL: Task badness score=131122 (current best=377)
[   56.419527] Dipendra OOM_EVAL: Replacing previous victim, new score=131122 > 
prev=377
[   56.419527] Dipendra OOM_SELECT: Selected victim: stress (pid=1122, 
score=131122)
[   56.419528] Dipendra OOM_KILL_PROCESS: Preparing to kill process
[   56.419529] Dipendra OOM_KILL_PROCESS: Chosen victim: stress (pid=1122)
[   56.419529] Dipendra OOM_KILL_PROCESS: Victim is not exiting, proceeding 
with kill
[   56.419530] stress invoked oom-killer: 
gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
[   56.419536] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419539] Call trace:
[   56.419540]  show_stack+0x24/0x50 (C)
[   56.419549]  dump_stack_lvl+0x80/0x140
[   56.419555]  dump_stack+0x1c/0x38
[   56.419557]  dump_header+0x48/0x228
[   56.419560]  oom_kill_process+0x160/0x3d0
[   56.419561]  out_of_memory+0x214/0x6f8
[   56.419562]  mem_cgroup_out_of_memory+0x170/0x1e0
[   56.419565]  try_charge_memcg+0x554/0x798
[   56.419567]  charge_memcg+0x50/0xa0
[   56.419568]  __mem_cgroup_charge+0x44/0x180
[   56.419570]  filemap_add_folio+0x74/0x2c8
[   56.419573]  __filemap_get_folio_mpol+0x240/0x478
[   56.419575]  filemap_fault+0x130/0xbe0
[   56.419577]  __do_fault+0x48/0x260
[   56.419580]  do_fault+0x344/0x600
[   56.419582]  __handle_mm_fault+0x3a8/0xb78
[   56.419584]  handle_mm_fault+0x19c/0x308
[   56.419586]  do_page_fault+0x120/0x7c8
[   56.419589]  do_translation_fault+0x7c/0xd0
[   56.419590]  do_mem_abort+0x50/0xd0
[   56.419592]  el0_ia+0x70/0x218
[   56.419594]  el0t_64_sync_handler+0x100/0x108
[   56.419595]  el0t_64_sync+0x1b8/0x1c0
[   56.419596] memory: usage 524288kB, limit 524288kB, failcnt 69
[   56.419598] swap: usage 0kB, limit 0kB, failcnt 0
[   56.419599] Memory cgroup stats for /test512mb:
[   56.419619] anon 535658496
[   56.419620] file 0
[   56.419621] kernel 1212416
[   56.419621] kernel_stack 16384
[   56.419622] pagetables 0
[   56.419622] sec_pagetables 0
[   56.419622] percpu 320
[   56.419623] sock 0
[   56.419623] vmalloc 0
[   56.419624] shmem 0
[   56.419624] zswap 0
[   56.419624] zswapped 0
[   56.419625] file_mapped 0
[   56.419625] file_dirty 0
[   56.419626] file_writeback 0
[   56.419626] swapcached 0
[   56.419626] anon_thp 0
[   56.419627] file_thp 0
[   56.419627] shmem_thp 0
[   56.419627] inactive_anon 535146496
[   56.419628] active_anon 503808
[   56.419628] inactive_file 0
[   56.419629] active_file 0
[   56.419629] unevictable 0
[   56.419629] slab_reclaimable 2544
[   56.419630] slab_unreclaimable 31272
[   56.419630] slab 33816
[   56.419631] workingset_refault_anon 0
[   56.419631] workingset_refault_file 21
[   56.419631] workingset_activate_anon 0
[   56.419632] workingset_activate_file 10
[   56.419632] workingset_restore_anon 0
[   56.419633] workingset_restore_file 8
[   56.419633] workingset_nodereclaim 0
[   56.419633] pgdemote_kswapd 0
[   56.419634] pgdemote_direct 0
[   56.419634] pgdemote_khugepaged 0
[   56.419635] pgdemote_proactive 0
[   56.419635] pgpromote_success 0
[   56.419635] pgscan 170
[   56.419636] pgsteal 38
[   56.419636] pswpin 0
[   56.419637] pswpout 0
[   56.419637] pgscan_kswapd 0
[   56.419637] pgscan_direct 170
[   56.419638] pgscan_khugepaged 0
[   56.419638] pgscan_proactive 0
[   56.419638] pgsteal_kswapd 0
[   56.419639] pgsteal_direct 38
[   56.419639] pgsteal_khugepaged 0
[   56.419640] pgsteal_proactive 0
[   56.419640] pgfault 130839
[   56.419640] pgmajfault 8
[   56.419641] pgrefill 0
[   56.419641] pgactivate 14
[   56.419641] pgdeactivate 0
[   56.419642] pglazyfree 0
[   56.419642] pglazyfreed 0
[   56.419643] swpin_zero 0
[   56.419643] swpout_zero 0
[   56.419643] zswpin 0
[   56.419644] zswpout 0
[   56.419644] zswpwb 0
[   56.419644] thp_fault_alloc 0
[   56.419645] thp_collapse_alloc 0
[   56.419645] thp_swpout 0
[   56.419646] thp_swpout_fallback 0
[   56.419646] numa_pages_migrated 0
[   56.419646] numa_pte_updates 0
[   56.419647] numa_hint_faults 0
[   56.419647] Memory cgroup min protection 0kB -- low protection 0kB
[   56.419648] Tasks state (memory values in pages):
[   56.419649] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file 
rss_shmem pgtables_bytes swapents oom_score_ad
j name
[   56.419649] Dipendra mm/memcontrol.c:1158:mem_cgroup_scan_tasks(): enter
[   56.419651] [   1121]     0  1121      734      366        0      366        
 0    45056        0             0 stre
ss
[   56.419653] [   1122]     0  1122   179935   130854   130720      134        
 0  1097728        0             0 stre
ss
[   56.419654] 
oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom
_memcg=/test512mb,task_m
emcg=/test512mb,task=stress,pid=1122,uid=0
[   56.419662] OOM_KILL: Sent SIGKILL to victim
[   56.419663] Memory cgroup out of memory: Killed process 1122 (stress) 
total-vm:719740kB, anon-rss:522880kB, file-rss
:536kB, shmem-rss:0kB, UID:0 pgtables:1072kB oom_score_adj:0
[   56.419722] Dipendra MEMCG_OOM: OOM killer successfully killed a task
[   56.419723] Dipendra MEMCG_OOM: Released oom_lock
[   56.419723] Dipendra MEMCG_RECLAIM: Reclaim failed after OOM, reclaimed only 
0 pages
[   56.419724] Dipendra MEMCG_CHARGE: Failing charge request
[   56.419730] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419731] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419731] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419731] Dipendra MEMCG: retry while dying!
[   56.419732]  pid=1122 comm=stress nr_retries=16 gfp=0x100cca
[   56.419733] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419734] Call trace:
[   56.419734]  show_stack+0x24/0x50 (C)
[   56.419736]  dump_stack_lvl+0x80/0x140
[   56.419738]  dump_stack+0x1c/0x38
[   56.419741]  try_charge_memcg+0x4c4/0x798
[   56.419743]  charge_memcg+0x50/0xa0
[   56.419744]  __mem_cgroup_charge+0x44/0x180
[   56.419746]  filemap_add_folio+0x74/0x2c8
[   56.419748]  __filemap_get_folio_mpol+0x240/0x478
[   56.419750]  filemap_fault+0x130/0xbe0
[   56.419752]  __do_fault+0x48/0x260
[   56.419754]  do_fault+0x344/0x600
[   56.419755]  __handle_mm_fault+0x3a8/0xb78
[   56.419757]  handle_mm_fault+0x19c/0x308
[   56.419759]  do_page_fault+0x120/0x7c8
[   56.419761]  do_translation_fault+0x7c/0xd0
[   56.419762]  do_mem_abort+0x50/0xd0
[   56.419763]  el0_ia+0x70/0x218
[   56.419764]  el0t_64_sync_handler+0x100/0x108
[   56.419765]  el0t_64_sync+0x1b8/0x1c0
[   56.419766] Dipendra: nr_retires =15
[   56.419772] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419772] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419772] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419773] Dipendra MEMCG: retry while dying!
[   56.419773]  pid=1122 comm=stress nr_retries=15 gfp=0x100cca
[   56.419774] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419775] Call trace:
[   56.419775]  show_stack+0x24/0x50 (C)
[   56.419776]  dump_stack_lvl+0x80/0x140
[   56.419778]  dump_stack+0x1c/0x38
[   56.419780]  try_charge_memcg+0x4c4/0x798
[   56.419782]  charge_memcg+0x50/0xa0
[   56.419784]  __mem_cgroup_charge+0x44/0x180
[   56.419786]  filemap_add_folio+0x74/0x2c8
[   56.419788]  __filemap_get_folio_mpol+0x240/0x478
[   56.419790]  filemap_fault+0x130/0xbe0
[   56.419791]  __do_fault+0x48/0x260
[   56.419793]  do_fault+0x344/0x600
[   56.419795]  __handle_mm_fault+0x3a8/0xb78
[   56.419797]  handle_mm_fault+0x19c/0x308
[   56.419799]  do_page_fault+0x120/0x7c8
[   56.419800]  do_translation_fault+0x7c/0xd0
[   56.419801]  do_mem_abort+0x50/0xd0
[   56.419802]  el0_ia+0x70/0x218
[   56.419803]  el0t_64_sync_handler+0x100/0x108
[   56.419804]  el0t_64_sync+0x1b8/0x1c0
[   56.419805] Dipendra: nr_retires =14
[   56.419810] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419811] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419811] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419812] Dipendra MEMCG: retry while dying!
[   56.419812]  pid=1122 comm=stress nr_retries=14 gfp=0x100cca
[   56.419813] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419813] Call trace:
[   56.419814]  show_stack+0x24/0x50 (C)
[   56.419815]  dump_stack_lvl+0x80/0x140
[   56.419817]  dump_stack+0x1c/0x38
[   56.419819]  try_charge_memcg+0x4c4/0x798
[   56.419821]  charge_memcg+0x50/0xa0
[   56.419823]  __mem_cgroup_charge+0x44/0x180
[   56.419824]  filemap_add_folio+0x74/0x2c8
[   56.419826]  __filemap_get_folio_mpol+0x240/0x478
[   56.419828]  filemap_fault+0x130/0xbe0
[   56.419830]  __do_fault+0x48/0x260
[   56.419832]  do_fault+0x344/0x600
[   56.419833]  __handle_mm_fault+0x3a8/0xb78
[   56.419835]  handle_mm_fault+0x19c/0x308
[   56.419837]  do_page_fault+0x120/0x7c8
[   56.419839]  do_translation_fault+0x7c/0xd0
[   56.419840]  do_mem_abort+0x50/0xd0
[   56.419841]  el0_ia+0x70/0x218
[   56.419842]  el0t_64_sync_handler+0x100/0x108
[   56.419843]  el0t_64_sync+0x1b8/0x1c0
[   56.419843] Dipendra: nr_retires =13
[   56.419849] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419849] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419850] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419850] Dipendra MEMCG: retry while dying!
[   56.419850]  pid=1122 comm=stress nr_retries=13 gfp=0x100cca
[   56.419851] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419852] Call trace:
[   56.419852]  show_stack+0x24/0x50 (C)
[   56.419853]  dump_stack_lvl+0x80/0x140
[   56.419855]  dump_stack+0x1c/0x38
[   56.419857]  try_charge_memcg+0x4c4/0x798
[   56.419859]  charge_memcg+0x50/0xa0
[   56.419861]  __mem_cgroup_charge+0x44/0x180
[   56.419863]  filemap_add_folio+0x74/0x2c8
[   56.419865]  __filemap_get_folio_mpol+0x240/0x478
[   56.419867]  filemap_fault+0x130/0xbe0
[   56.419869]  __do_fault+0x48/0x260
[   56.419870]  do_fault+0x344/0x600
[   56.419872]  __handle_mm_fault+0x3a8/0xb78
[   56.419874]  handle_mm_fault+0x19c/0x308
[   56.419876]  do_page_fault+0x120/0x7c8
[   56.419877]  do_translation_fault+0x7c/0xd0
[   56.419878]  do_mem_abort+0x50/0xd0
[   56.419879]  el0_ia+0x70/0x218
[   56.419880]  el0t_64_sync_handler+0x100/0x108
[   56.419881]  el0t_64_sync+0x1b8/0x1c0
[   56.419882] Dipendra: nr_retires =12
[   56.419887] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419888] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419888] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419889] Dipendra MEMCG: retry while dying!
[   56.419889]  pid=1122 comm=stress nr_retries=12 gfp=0x100cca
[   56.419890] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419890] Call trace:
[   56.419890]  show_stack+0x24/0x50 (C)
[   56.419892]  dump_stack_lvl+0x80/0x140
[   56.419894]  dump_stack+0x1c/0x38
[   56.419896]  try_charge_memcg+0x4c4/0x798
[   56.419898]  charge_memcg+0x50/0xa0
[   56.419899]  __mem_cgroup_charge+0x44/0x180
[   56.419901]  filemap_add_folio+0x74/0x2c8
[   56.419903]  __filemap_get_folio_mpol+0x240/0x478
[   56.419905]  filemap_fault+0x130/0xbe0
[   56.419907]  __do_fault+0x48/0x260
[   56.419908]  do_fault+0x344/0x600
[   56.419910]  __handle_mm_fault+0x3a8/0xb78
[   56.419912]  handle_mm_fault+0x19c/0x308
[   56.419914]  do_page_fault+0x120/0x7c8
[   56.419915]  do_translation_fault+0x7c/0xd0
[   56.419917]  do_mem_abort+0x50/0xd0
[   56.419917]  el0_ia+0x70/0x218
[   56.419918]  el0t_64_sync_handler+0x100/0x108
[   56.419919]  el0t_64_sync+0x1b8/0x1c0
[   56.419920] Dipendra: nr_retires =11
[   56.419926] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419926] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419926] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419927] Dipendra MEMCG: retry while dying!
[   56.419927]  pid=1122 comm=stress nr_retries=11 gfp=0x100cca
[   56.419928] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419928] Call trace:
[   56.419929]  show_stack+0x24/0x50 (C)
[   56.419930]  dump_stack_lvl+0x80/0x140
[   56.419932]  dump_stack+0x1c/0x38
[   56.419934]  try_charge_memcg+0x4c4/0x798
[   56.419936]  charge_memcg+0x50/0xa0
[   56.419937]  __mem_cgroup_charge+0x44/0x180
[   56.419939]  filemap_add_folio+0x74/0x2c8
[   56.419941]  __filemap_get_folio_mpol+0x240/0x478
[   56.419943]  filemap_fault+0x130/0xbe0
[   56.419945]  __do_fault+0x48/0x260
[   56.419947]  do_fault+0x344/0x600
[   56.419948]  __handle_mm_fault+0x3a8/0xb78
[   56.419950]  handle_mm_fault+0x19c/0x308
[   56.419952]  do_page_fault+0x120/0x7c8
[   56.419953]  do_translation_fault+0x7c/0xd0
[   56.419955]  do_mem_abort+0x50/0xd0
[   56.419956]  el0_ia+0x70/0x218
[   56.419956]  el0t_64_sync_handler+0x100/0x108
[   56.419957]  el0t_64_sync+0x1b8/0x1c0
[   56.419958] Dipendra: nr_retires =10
[   56.419964] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.419964] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.419964] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.419965] Dipendra MEMCG: retry while dying!
[   56.419965]  pid=1122 comm=stress nr_retries=10 gfp=0x100cca
[   56.419966] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.419967] Call trace:
[   56.419967]  show_stack+0x24/0x50 (C)
[   56.419968]  dump_stack_lvl+0x80/0x140
[   56.419970]  dump_stack+0x1c/0x38
[   56.419972]  try_charge_memcg+0x4c4/0x798
[   56.419974]  charge_memcg+0x50/0xa0
[   56.419976]  __mem_cgroup_charge+0x44/0x180
[   56.419978]  filemap_add_folio+0x74/0x2c8
[   56.419979]  __filemap_get_folio_mpol+0x240/0x478
[   56.419981]  filemap_fault+0x130/0xbe0
[   56.419983]  __do_fault+0x48/0x260
[   56.419985]  do_fault+0x344/0x600
[   56.419986]  __handle_mm_fault+0x3a8/0xb78
[   56.419988]  handle_mm_fault+0x19c/0x308
[   56.419990]  do_page_fault+0x120/0x7c8
[   56.419992]  do_translation_fault+0x7c/0xd0
[   56.419993]  do_mem_abort+0x50/0xd0
[   56.419994]  el0_ia+0x70/0x218
[   56.419995]  el0t_64_sync_handler+0x100/0x108
[   56.419996]  el0t_64_sync+0x1b8/0x1c0
[   56.419996] Dipendra: nr_retires =9
[   56.420002] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420002] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420003] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420003] Dipendra MEMCG: retry while dying!
[   56.420003]  pid=1122 comm=stress nr_retries=9 gfp=0x100cca
[   56.420004] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420005] Call trace:
[   56.420005]  show_stack+0x24/0x50 (C)
[   56.420006]  dump_stack_lvl+0x80/0x140
[   56.420008]  dump_stack+0x1c/0x38
[   56.420010]  try_charge_memcg+0x4c4/0x798
[   56.420012]  charge_memcg+0x50/0xa0
[   56.420014]  __mem_cgroup_charge+0x44/0x180
[   56.420016]  filemap_add_folio+0x74/0x2c8
[   56.420018]  __filemap_get_folio_mpol+0x240/0x478
[   56.420019]  filemap_fault+0x130/0xbe0
[   56.420021]  __do_fault+0x48/0x260
[   56.420023]  do_fault+0x344/0x600
[   56.420025]  __handle_mm_fault+0x3a8/0xb78
[   56.420027]  handle_mm_fault+0x19c/0x308
[   56.420028]  do_page_fault+0x120/0x7c8
[   56.420030]  do_translation_fault+0x7c/0xd0
[   56.420031]  do_mem_abort+0x50/0xd0
[   56.420032]  el0_ia+0x70/0x218
[   56.420033]  el0t_64_sync_handler+0x100/0x108
[   56.420034]  el0t_64_sync+0x1b8/0x1c0
[   56.420035] Dipendra: nr_retires =8
[   56.420040] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420040] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420041] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420041] Dipendra MEMCG: retry while dying!
[   56.420042]  pid=1122 comm=stress nr_retries=8 gfp=0x100cca
[   56.420042] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420043] Call trace:
[   56.420043]  show_stack+0x24/0x50 (C)
[   56.420044]  dump_stack_lvl+0x80/0x140
[   56.420046]  dump_stack+0x1c/0x38
[   56.420048]  try_charge_memcg+0x4c4/0x798
[   56.420050]  charge_memcg+0x50/0xa0
[   56.420052]  __mem_cgroup_charge+0x44/0x180
[   56.420054]  filemap_add_folio+0x74/0x2c8
[   56.420056]  __filemap_get_folio_mpol+0x240/0x478
[   56.420058]  filemap_fault+0x130/0xbe0
[   56.420059]  __do_fault+0x48/0x260
[   56.420061]  do_fault+0x344/0x600
[   56.420063]  __handle_mm_fault+0x3a8/0xb78
[   56.420065]  handle_mm_fault+0x19c/0x308
[   56.420067]  do_page_fault+0x120/0x7c8
[   56.420068]  do_translation_fault+0x7c/0xd0
[   56.420069]  do_mem_abort+0x50/0xd0
[   56.420070]  el0_ia+0x70/0x218
[   56.420071]  el0t_64_sync_handler+0x100/0x108
[   56.420072]  el0t_64_sync+0x1b8/0x1c0
[   56.420073] Dipendra: nr_retires =7
[   56.420078] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420078] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420079] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420079] Dipendra MEMCG: retry while dying!
[   56.420080]  pid=1122 comm=stress nr_retries=7 gfp=0x100cca
[   56.420080] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420081] Call trace:
[   56.420081]  show_stack+0x24/0x50 (C)
[   56.420082]  dump_stack_lvl+0x80/0x140
[   56.420084]  dump_stack+0x1c/0x38
[   56.420086]  try_charge_memcg+0x4c4/0x798
[   56.420088]  charge_memcg+0x50/0xa0
[   56.420090]  __mem_cgroup_charge+0x44/0x180
[   56.420092]  filemap_add_folio+0x74/0x2c8
[   56.420094]  __filemap_get_folio_mpol+0x240/0x478
[   56.420096]  filemap_fault+0x130/0xbe0
[   56.420097]  __do_fault+0x48/0x260
[   56.420105]  do_fault+0x344/0x600
[   56.420107]  __handle_mm_fault+0x3a8/0xb78
[   56.420109]  handle_mm_fault+0x19c/0x308
[   56.420111]  do_page_fault+0x120/0x7c8
[   56.420112]  do_translation_fault+0x7c/0xd0
[   56.420113]  do_mem_abort+0x50/0xd0
[   56.420114]  el0_ia+0x70/0x218
[   56.420115]  el0t_64_sync_handler+0x100/0x108
[   56.420116]  el0t_64_sync+0x1b8/0x1c0
[   56.420138] Dipendra: nr_retires =6
[   56.420143] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420144] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420144] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420144] Dipendra MEMCG: retry while dying!
[   56.420145]  pid=1122 comm=stress nr_retries=6 gfp=0x100cca
[   56.420145] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420146] Call trace:
[   56.420146]  show_stack+0x24/0x50 (C)
[   56.420148]  dump_stack_lvl+0x80/0x140
[   56.420150]  dump_stack+0x1c/0x38
[   56.420152]  try_charge_memcg+0x4c4/0x798
[   56.420154]  charge_memcg+0x50/0xa0
[   56.420156]  __mem_cgroup_charge+0x44/0x180
[   56.420158]  filemap_add_folio+0x74/0x2c8
[   56.420159]  __filemap_get_folio_mpol+0x240/0x478
[   56.420161]  filemap_fault+0x130/0xbe0
[   56.420163]  __do_fault+0x48/0x260
[   56.420165]  do_fault+0x344/0x600
[   56.420167]  __handle_mm_fault+0x3a8/0xb78
[   56.420169]  handle_mm_fault+0x19c/0x308
[   56.420171]  do_page_fault+0x120/0x7c8
[   56.420172]  do_translation_fault+0x7c/0xd0
[   56.420173]  do_mem_abort+0x50/0xd0
[   56.420174]  el0_ia+0x70/0x218
[   56.420175]  el0t_64_sync_handler+0x100/0x108
[   56.420176]  el0t_64_sync+0x1b8/0x1c0
[   56.420177] Dipendra: nr_retires =5
[   56.420183] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420183] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420184] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420184] Dipendra MEMCG: retry while dying!
[   56.420185]  pid=1122 comm=stress nr_retries=5 gfp=0x100cca
[   56.420185] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420186] Call trace:
[   56.420186]  show_stack+0x24/0x50 (C)
[   56.420188]  dump_stack_lvl+0x80/0x140
[   56.420190]  dump_stack+0x1c/0x38
[   56.420192]  try_charge_memcg+0x4c4/0x798
[   56.420194]  charge_memcg+0x50/0xa0
[   56.420195]  __mem_cgroup_charge+0x44/0x180
[   56.420197]  filemap_add_folio+0x74/0x2c8
[   56.420199]  __filemap_get_folio_mpol+0x240/0x478
[   56.420201]  filemap_fault+0x130/0xbe0
[   56.420203]  __do_fault+0x48/0x260
[   56.420205]  do_fault+0x344/0x600
[   56.420207]  __handle_mm_fault+0x3a8/0xb78
[   56.420209]  handle_mm_fault+0x19c/0x308
[   56.420210]  do_page_fault+0x120/0x7c8
[   56.420212]  do_translation_fault+0x7c/0xd0
[   56.420213]  do_mem_abort+0x50/0xd0
[   56.420214]  el0_ia+0x70/0x218
[   56.420215]  el0t_64_sync_handler+0x100/0x108
[   56.420216]  el0t_64_sync+0x1b8/0x1c0
[   56.420217] Dipendra: nr_retires =4
[   56.420222] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420222] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420223] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420223] Dipendra MEMCG: retry while dying!
[   56.420223]  pid=1122 comm=stress nr_retries=4 gfp=0x100cca
[   56.420224] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420225] Call trace:
[   56.420225]  show_stack+0x24/0x50 (C)
[   56.420226]  dump_stack_lvl+0x80/0x140
[   56.420228]  dump_stack+0x1c/0x38
[   56.420230]  try_charge_memcg+0x4c4/0x798
[   56.420232]  charge_memcg+0x50/0xa0
[   56.420234]  __mem_cgroup_charge+0x44/0x180
[   56.420236]  filemap_add_folio+0x74/0x2c8
[   56.420238]  __filemap_get_folio_mpol+0x240/0x478
[   56.420239]  filemap_fault+0x130/0xbe0
[   56.420241]  __do_fault+0x48/0x260
[   56.420243]  do_fault+0x344/0x600
[   56.420245]  __handle_mm_fault+0x3a8/0xb78
[   56.420247]  handle_mm_fault+0x19c/0x308
[   56.420249]  do_page_fault+0x120/0x7c8
[   56.420250]  do_translation_fault+0x7c/0xd0
[   56.420251]  do_mem_abort+0x50/0xd0
[   56.420252]  el0_ia+0x70/0x218
[   56.420253]  el0t_64_sync_handler+0x100/0x108
[   56.420254]  el0t_64_sync+0x1b8/0x1c0
[   56.420255] Dipendra: nr_retires =3
[   56.420260] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420261] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420261] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420261] Dipendra MEMCG: retry while dying!
[   56.420262]  pid=1122 comm=stress nr_retries=3 gfp=0x100cca
[   56.420262] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420263] Call trace:
[   56.420263]  show_stack+0x24/0x50 (C)
[   56.420264]  dump_stack_lvl+0x80/0x140
[   56.420267]  dump_stack+0x1c/0x38
[   56.420269]  try_charge_memcg+0x4c4/0x798
[   56.420270]  charge_memcg+0x50/0xa0
[   56.420272]  __mem_cgroup_charge+0x44/0x180
[   56.420274]  filemap_add_folio+0x74/0x2c8
[   56.420276]  __filemap_get_folio_mpol+0x240/0x478
[   56.420278]  filemap_fault+0x130/0xbe0
[   56.420279]  __do_fault+0x48/0x260
[   56.420281]  do_fault+0x344/0x600
[   56.420283]  __handle_mm_fault+0x3a8/0xb78
[   56.420285]  handle_mm_fault+0x19c/0x308
[   56.420287]  do_page_fault+0x120/0x7c8
[   56.420288]  do_translation_fault+0x7c/0xd0
[   56.420289]  do_mem_abort+0x50/0xd0
[   56.420290]  el0_ia+0x70/0x218
[   56.420291]  el0t_64_sync_handler+0x100/0x108
[   56.420292]  el0t_64_sync+0x1b8/0x1c0
[   56.420293] Dipendra: nr_retires =2
[   56.420298] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420299] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420299] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420299] Dipendra MEMCG: retry while dying!
[   56.420300]  pid=1122 comm=stress nr_retries=2 gfp=0x100cca
[   56.420300] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420301] Call trace:
[   56.420301]  show_stack+0x24/0x50 (C)
[   56.420302]  dump_stack_lvl+0x80/0x140
[   56.420305]  dump_stack+0x1c/0x38
[   56.420307]  try_charge_memcg+0x4c4/0x798
[   56.420308]  charge_memcg+0x50/0xa0
[   56.420310]  __mem_cgroup_charge+0x44/0x180
[   56.420312]  filemap_add_folio+0x74/0x2c8
[   56.420314]  __filemap_get_folio_mpol+0x240/0x478
[   56.420316]  filemap_fault+0x130/0xbe0
[   56.420318]  __do_fault+0x48/0x260
[   56.420319]  do_fault+0x344/0x600
[   56.420321]  __handle_mm_fault+0x3a8/0xb78
[   56.420323]  handle_mm_fault+0x19c/0x308
[   56.420325]  do_page_fault+0x120/0x7c8
[   56.420326]  do_translation_fault+0x7c/0xd0
[   56.420327]  do_mem_abort+0x50/0xd0
[   56.420328]  el0_ia+0x70/0x218
[   56.420329]  el0t_64_sync_handler+0x100/0x108
[   56.420330]  el0t_64_sync+0x1b8/0x1c0
[   56.420331] Dipendra: nr_retires =1
[   56.420336] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420337] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420337] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420338] Dipendra MEMCG: retry while dying!
[   56.420338]  pid=1122 comm=stress nr_retries=1 gfp=0x100cca
[   56.420339] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420339] Call trace:
[   56.420340]  show_stack+0x24/0x50 (C)
[   56.420341]  dump_stack_lvl+0x80/0x140
[   56.420343]  dump_stack+0x1c/0x38
[   56.420345]  try_charge_memcg+0x4c4/0x798
[   56.420347]  charge_memcg+0x50/0xa0
[   56.420349]  __mem_cgroup_charge+0x44/0x180
[   56.420351]  filemap_add_folio+0x74/0x2c8
[   56.420353]  __filemap_get_folio_mpol+0x240/0x478
[   56.420355]  filemap_fault+0x130/0xbe0
[   56.420357]  __do_fault+0x48/0x260
[   56.420358]  do_fault+0x344/0x600
[   56.420360]  __handle_mm_fault+0x3a8/0xb78
[   56.420362]  handle_mm_fault+0x19c/0x308
[   56.420364]  do_page_fault+0x120/0x7c8
[   56.420365]  do_translation_fault+0x7c/0xd0
[   56.420367]  do_mem_abort+0x50/0xd0
[   56.420367]  el0_ia+0x70/0x218
[   56.420368]  el0t_64_sync_handler+0x100/0x108
[   56.420369]  el0t_64_sync+0x1b8/0x1c0
[   56.420370] Dipendra: nr_retires =0
[   56.420376] Dipendra MEMCG_RECLAIM: Reclaimed 0 pages but still insufficient
[   56.420376] Dipendra MEMCG_RECLAIM: Memory limit exceeded, attempting reclaim
[   56.420376] Dipendra MEMCG_RECLAIM: Target=1 pages, memcg=test512mb
[   56.420377] Dipendra MEMCG: retry while dying!
[   56.420377]  pid=1122 comm=stress nr_retries=0 gfp=0x100cca
[   56.420378] CPU: 5 UID: 0 PID: 1122 Comm: stress Not tainted 6.18.0+ #26 
PREEMPT(voluntary)
[   56.420378] Call trace:
[   56.420379]  show_stack+0x24/0x50 (C)
[   56.420380]  dump_stack_lvl+0x80/0x140
[   56.420382]  dump_stack+0x1c/0x38
[   56.420384]  try_charge_memcg+0x4c4/0x798
[   56.420386]  charge_memcg+0x50/0xa0
[   56.420387]  __mem_cgroup_charge+0x44/0x180
[   56.420389]  filemap_add_folio+0x74/0x2c8
[   56.420391]  __filemap_get_folio_mpol+0x240/0x478
[   56.420393]  filemap_fault+0x130/0xbe0
[   56.420395]  __do_fault+0x48/0x260
[   56.420397]  do_fault+0x344/0x600
[   56.420398]  __handle_mm_fault+0x3a8/0xb78
[   56.420400]  handle_mm_fault+0x19c/0x308
[   56.420402]  do_page_fault+0x120/0x7c8
[   56.420403]  do_translation_fault+0x7c/0xd0
[   56.420405]  do_mem_abort+0x50/0xd0
[   56.420406]  el0_ia+0x70/0x218
[   56.420406]  el0t_64_sync_handler+0x100/0x108
[   56.420407]  el0t_64_sync+0x1b8/0x1c0
[   56.420408] Dipendra : I am dying already.....
[   56.420410] Dipendra MEMCG_CHARGE: Charge failed (ENOMEM) :
[   56.420410] Dipendra MEMCG_CHARGE: Usage=131072, Limit=131072

