Return-Path: <cgroups+bounces-13621-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFUNJntlgWlMGAMAu9opvQ
	(envelope-from <cgroups+bounces-13621-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 04:03:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62AD3F7A
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 04:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 502D13006D55
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 03:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778FD22D795;
	Tue,  3 Feb 2026 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et9Agve4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD513DBA0
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087799; cv=none; b=g067uEDuTorVfgkvqdcmJ0UkJfFzH0CprisUOqXIp1fUD2kFDDBSdxadpqaQgvhrMk8aJuWzmLiK/LPw8njvzEor0iw9DkOfHW7Ec9T+6StZ6X0CHzOEFKeW12Y48BNiu9J/9na6KnXlbKzx7raP5UudY7iGyJcpZs5wDeOA5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087799; c=relaxed/simple;
	bh=qxtCPipVDr+RKM3sJBs6cRaK84ZyHIu2vKgQKn3Jryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzahOWoCymrz4XIqatjDbaPgn5IWaEmvWjIUFWBfrPHnphsh8uWSD83EEXILm8BAnxbZXtaW9TrjJJ8pk1EDYxqlnS0JGcv5hFfNJ8T0GB0TVyRwJD3PhxRAmFq2t2PSa2dVdAQ5dmWaA67OCR+Av9PI8j8jMEzMuL0pHgKTsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=et9Agve4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770087797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeAmQVy00RD7jeYCsWOxBUsTUuPFNsMvQMA6zTsXuxo=;
	b=et9Agve4PvCD+uSe/zDr2wZtShXmJ3Ongp/Wl/Cxh4qroFYHVtnPJpXOwDjk8a/aorIXBd
	ZBPrHg0KBEadmHP2kEB/IuJLV4+IjrtK+zrqxKBjPAmcim138y+tP9LobNZyo3EVDNDZgC
	Di+HMnBuoZ6agsBhjftP/KUS5Pj6l64=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-T5xMpRwZNK2pBEaLjLFP6w-1; Mon,
 02 Feb 2026 22:03:13 -0500
X-MC-Unique: T5xMpRwZNK2pBEaLjLFP6w-1
X-Mimecast-MFC-AGG-ID: T5xMpRwZNK2pBEaLjLFP6w_1770087792
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD569180034F;
	Tue,  3 Feb 2026 03:03:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BAB930001A7;
	Tue,  3 Feb 2026 03:03:06 +0000 (UTC)
Date: Tue, 3 Feb 2026 11:03:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <aYFlZf9p4cY0rIbc@fedora>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13621-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.lei@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF62AD3F7A
X-Rspamd-Action: no action

Hello,

On Mon, Feb 02, 2026 at 02:19:07PM +0800, 李龙兴 wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. KASAN:
> slab-use-after-free Read in __blkcg_rstat_flush. Details are as
> follows.
> 
> Kernel commit: v6.18.2
> Kernel config: see attachment
> report: see attachment
> 
> We are currently analyzing the root cause and  working on a
> reproducible PoC. We will provide further updates in this thread as
> soon as we have more information.
> 
> Best regards,
> Longxing Li
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in
> __blkcg_rstat_flush.isra.0+0x73c/0x800 block/blk-cgroup.c:1069
> Read of size 8 at addr ffff88810a8ba830 by task pool_workqueue_/3
> 
> CPU: 1 UID: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.18.2 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcd/0x630 mm/kasan/report.c:482
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  __blkcg_rstat_flush.isra.0+0x73c/0x800 block/blk-cgroup.c:1069
>  __blkg_release+0x1a6/0x2d0 block/blk-cgroup.c:179
>  rcu_do_batch kernel/rcu/tree.c:2605 [inline]

Can you try the following patch?


diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3cffb68ba5d8..dc0cccfdca68 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -160,6 +160,20 @@ static void blkg_free(struct blkcg_gq *blkg)
 	schedule_work(&blkg->free_work);
 }
 
+/*
+ * RCU callback to free blkg after an additional grace period.
+ * This ensures any concurrent __blkcg_rstat_flush() that might have
+ * removed our iostat entries via llist_del_all() has completed.
+ */
+static void __blkg_release_free_rcu(struct rcu_head *rcu)
+{
+	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
+
+	/* release the blkcg and parent blkg refs this blkg has been holding */
+	css_put(&blkg->blkcg->css);
+	blkg_free(blkg);
+}
+
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
@@ -178,9 +192,14 @@ static void __blkg_release(struct rcu_head *rcu)
 	for_each_possible_cpu(cpu)
 		__blkcg_rstat_flush(blkcg, cpu);
 
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
-	blkg_free(blkg);
+	/*
+	 * Defer freeing via another call_rcu() to ensure any concurrent
+	 * __blkcg_rstat_flush() (under rcu_read_lock) that might have removed
+	 * our iostat entries via llist_del_all() has completed its iteration.
+	 * The second grace period guarantees those RCU read-side critical
+	 * sections have finished.
+	 */
+	call_rcu(&blkg->rcu_head, __blkg_release_free_rcu);
 }
 
 /*


thanks,
Ming


