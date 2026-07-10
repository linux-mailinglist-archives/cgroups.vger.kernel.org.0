Return-Path: <cgroups+bounces-17648-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v6OTEb7EUGo14wIAu9opvQ
	(envelope-from <cgroups+bounces-17648-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 12:09:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DE273977F
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 12:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=readmodwrite-com.20251104.gappssmtp.com header.s=20251104 header.b=KwDOg6Lq;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17648-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17648-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF45303527B
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3793FFFA5;
	Fri, 10 Jul 2026 10:04:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133043FD946
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 10:04:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677887; cv=none; b=r9Tdgp8MxPZZDyB7os7CF7UGNTi8sm/T0AIliQPZl0p46ZVak1B50eKh7IS26+UaSdYMdpt8m42fsMZxQ1AeqNfHb2OuLUXuz2EZjPM17UODEmoE17Tf+DFWcrgvviXPue1pWI59PC+zFAyWNH5KkiJs6y8/rsF/8o/8D4Gq4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677887; c=relaxed/simple;
	bh=1/T6l30OSc/13ghkKigE/EraxxH+hq6Pkoy8zdnQBWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWcgGWSDl1bcLK9xfeoCaqJtPM/qyjhhOcuEy98AqxR3/VniNe31SrfpQmSOku+ZjfhHBV5zPUhhwsjtjQblWhOUyeQHn0bV3tJGwH6k6+dWBOfq0tjTaQWdRBrA6acpUkQVy6Tm6fEoa3e6k6dAaBMuq8sOemeUU2ryT10KJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=KwDOg6Lq; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47d70879764so481766f8f.2
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783677884; x=1784282684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0MN3kTnck8FKiznnDeMfk/kad4KxVs02NYEcU7mySM=;
        b=KwDOg6Lq6D6ZMsa1RWoi4iNK3kqvN2UGxtVHBimdK0ovU1diolJz46vRludQn2xiJE
         wZDRfsznI8fREUL+dMvsWZGAvOe7zVFYfJi9Jj62+OwS7x6po4A/tPjV4vLgR7HmqlNG
         NVT/YUicG0S4Ua6hMoaKLSUPbptI35uyfyROb1mmpeOu3H1zjGVhziU58oi+KU2YyDGt
         UHHoo7yuTJea6BmU7TFJ/XNbBH5F2ysHG5Agw5qni3DgI7yNOWPDHzqTfCT1raO61AIz
         BAiF86x3RFqZXe2bfDk76HiMfONQA7MVxVotJrw8z6pMRNoOMyUp+Q8Tl+qYEWAzSr/x
         gX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677884; x=1784282684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0MN3kTnck8FKiznnDeMfk/kad4KxVs02NYEcU7mySM=;
        b=bU4lRg1/UE5fOyM4YKA0+z/UR78vi639PZS7JEhwmZRVmMxxEfhtE332BYZSy3hMpO
         5dVQ9p8k1bPa3u9t40C/aXJdvGXyARz6VEo4P3JLY7RhkydvOtN3HGZWyX9Gs7GGZ8AT
         v70onazDMEww3DQQged/YBJ7w3T/bExPdOmhbBmGSs8V7l7tUshOFDUXJ9WTAkjCXds+
         fYB+p4qNr5vt23kdJqq3YVjDUYXV9Np64tEnH/7gnYZ/gnCRfvTCQfYLPLe0HVIFTpci
         RcWUR5JYsM7IMwRfLkAbs/FfZFlqkOGZ7v9hNzYon02YejQF57cp4O5XInEU/56KIh5N
         sdCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWVKzAFx/nxvjdcybjauQR4iSZmAbb3HJ1L0Mxr5QmQeVbDEDvsQI086H2eFGZfS1zQ3Jo/g0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yyij/Z72kG5dIAHWJQZrGiS/u2mqARDoqqBHWUcNZRRr7XyO5fV
	zrcLl4JCrtbszXDKHv6yzC/oUAdqVOaGj4cc404sCUF+wTYV5ghJ5vyHgR90plFnSQ8=
X-Gm-Gg: AfdE7ckNMUJ9DQ+KqRTzYQtG5+tpct8258fDO0nSihabH9GN5qeaogMfzSRO3UaWx6H
	7I1vs4hP22WC7Q3ZkWs7xW8xI8sbZEKnqJ2S7lrx4QNyZ/VPJ2NAaWnqu1VU3vvMrJha5oIXFrX
	QZCBwsn8X2q563Wb+RW4D3MsN0tWtvdzpRE+vscilFSb1ntXCM3E4sxRmVjs3a6TfZLWZmHlWco
	grld/WYs45LW89qztX2QnPQH+Bx7RErsi5yCyZzas0DPN8pCUUIdghlX6ObmvNtlSXHYxcKTMdQ
	rXTIlEaP+gCHQ/jIvrFxXNFeVVvCZNT7olu0CoTYnx6160Dx+QJab5YAdwsC8zyL2Xe0VRzk4Sh
	JsWeWL1vDfO8EIhGt8uamk9LaxVqP0kK9NwPl3kvRnoO7/rwT/ZTm4YTZcsqgoystZqtX9V/kq3
	zr+w8EZX+NyNBEPIc=
X-Received: by 2002:a05:6000:402a:b0:46e:98a7:232b with SMTP id ffacd0b85a97d-47df07a8676mr12628273f8f.10.1783677884305;
        Fri, 10 Jul 2026 03:04:44 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26a0::3d9:1e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm61261033f8f.21.2026.07.10.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:04:43 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] sched_ext: Fix deadlock with PSI trigger creation
Date: Fri, 10 Jul 2026 11:04:41 +0100
Message-ID: <20260710100441.2653477-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17648-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,m:mfleming@cloudflare.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[manifault.com,nvidia.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,lists.linux.dev,vger.kernel.org,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matt@readmodwrite.com,cgroups@vger.kernel.org];
	DMARC_NA(0.00)[readmodwrite.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,readmodwrite-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73DE273977F

From: Matt Fleming <mfleming@cloudflare.com>

scx_root_enable_workfn() currently takes scx_fork_rwsem for writing
before acquiring cgroup_mutex. Since commit a5b98009f16d ("sched/psi:
fix race between file release and pressure write"), pressure_write()
holds cgroup_mutex across psi_trigger_create(), which may call
kthread_create() for the psimon kthread. kthreadd's fork then enters
scx_pre_fork() and waits for the read side of scx_fork_rwsem.

This results in a deadlock. The enable worker holds scx_fork_rwsem and
waits for cgroup_mutex, while the PSI writer holds cgroup_mutex and
waits for psimon creation to complete. Any concurrent fork blocks on
scx_pre_fork() behind the enable worker.

The hung-task detector captured all three sides of the deadlock:

  scx_enable_help:
    __mutex_lock
    scx_enable_workfn
    kthread_worker_fn

  systemd:
    wait_for_completion_killable
    __kthread_create_on_node
    kthread_create_on_node
    psi_trigger_create
    pressure_write
    kernfs_fop_write_iter

  python3:
    percpu_rwsem_wait
    __percpu_down_read
    scx_pre_fork
    sched_fork
    copy_process
    kernel_clone

It also identified systemd as the likely owner of the mutex on which
scx_enable_help was blocked.

We reproduced this on a 128-CPU AMD EPYC 7713 by enabling scx_lavd
concurrently with writes to cgroup PSI trigger files. Unrelated tasks
piled up in scx_pre_fork() and process creation on the box stopped.

Fix the inversion by acquiring cgroup_mutex before scx_fork_rwsem in
scx_root_enable_workfn() and releasing them in reverse order, while
preserving the existing exclusion around cgroup and task initialisation.

Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/sched/ext/ext.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f64..ba89eafe7964 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7193,7 +7193,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
+	 * cgroup_mutex must nest outside scx_fork_rwsem because cgroup file
+	 * operations may create kthreads while holding cgroup_mutex.
 	 */
+	scx_cgroup_lock();
 	percpu_down_write(&scx_fork_rwsem);
 
 	WARN_ON_ONCE(scx_init_task_enabled);
@@ -7216,7 +7219,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 * while tasks are being initialized so that scx_cgroup_can_attach()
 	 * never sees uninitialized tasks.
 	 */
-	scx_cgroup_lock();
 	set_cgroup_sched(sch_cgroup(sch), sch);
 	ret = scx_cgroup_init(sch);
 	if (ret)
@@ -7283,8 +7285,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
-	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_cgroup_unlock();
 
 	/*
 	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
@@ -7369,8 +7371,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	return;
 
 err_disable_unlock_all:
-	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_cgroup_unlock();
 	/* we'll soon enter disable path, keep bypass on */
 err_disable:
 	mutex_unlock(&scx_enable_mutex);
-- 
2.43.0


