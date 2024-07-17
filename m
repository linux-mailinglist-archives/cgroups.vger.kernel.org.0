Return-Path: <cgroups+bounces-3740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417A9340D7
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33CA2841DB
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8EF1822D8;
	Wed, 17 Jul 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPSgql4I"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A817F39B;
	Wed, 17 Jul 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235350; cv=none; b=nx1yXADfmdkH7PLsz7OhtQgCCwM+kqVjs7P5fe8fxQ/pfMFPmNJgOpqq4EOwgZl/70HgERs+RLEiZ4lYNsCw2AXeGiynRC5c6ZUb4OnOCgxgQyUSXwwCxAKt5tBlxpo6GH6e9lYx7tJ2wWGrQh3iND4faODsmcjOQjQ0tiJ2DaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235350; c=relaxed/simple;
	bh=OMKDrp/asr1LQFTLOo46Z1gdnD0fhU2xBx0AsoHdoM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUClbf/7xTvJ6Xz9wBGy4bOPQ5nBLt27mryzUad78Ou1fH9WCj7aqW3bzKPKimxL4dPofeiCdFAZ5LwftIc1Em4DQ2qA66t3wSIuRARbSFuBjxiLhdMF2fF1GOoR5h2JojNHQP20X5XUHRosqJ/2bzUYfvK5Z86cYtmRYCijlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPSgql4I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc5549788eso5136165ad.1;
        Wed, 17 Jul 2024 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721235348; x=1721840148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68LWjL5/SKjz0tO65i0BltVGGa8T/WWLEoQAHGMQU/Q=;
        b=bPSgql4IZhW9Didboyc9a1e3GYBVIkqHHy+eaMB/g8bARWNhlzw0BkBjpzVlbWuGAV
         Q7JeW8D0Gl25YL56smDrIZ+UQs08kBVYpo2yqz4UIyymQVi1nCtTy2bi4+ONtQDl6+CL
         NSLTNLyw0pjMDe+Vmke89Uq2k6/86asP3+HtO837ZUasVuAwo5zQQLwAFFf4X62zWm0o
         au23U8aBqI1VOK31ySETNiHoXS7l5jY02ptYCdE97ZXYOELgJMI63NOfZdThOhH1i2Y2
         /MrSJ39Pa0QIp7/Qhm0De+EjMhLx0bKQqM+TLEsbYFWRfq4MOidFVDa8NLJ0BFJRJFIa
         CCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235348; x=1721840148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68LWjL5/SKjz0tO65i0BltVGGa8T/WWLEoQAHGMQU/Q=;
        b=ubsRie6xYaOi7rSRP8MyALchnh2b9L/0NW/BytQrxjlGoffK0sj68VTbfMZilU8jWi
         qbpNlfb3mudjHvCr+C1n5uduSg1po75la504O8wr8He0z/1UquKgld8wLe7coZ9ZpxIu
         urzChe5Qj0tZhZHYuqY+LjcPHrJ8QCaVF97KBWerAaOjwEVJALoeEcmKdtict6bMcKBV
         iH/kJFHr4kqOU8qlxq903sY36J6qXZfcpE20HbzrAozXYmvo5jaDR1cTZ8CCwK349Aic
         0ycP46Vh3MJDDrFdJ0V1pgvVCz/ZFHIp0EQuLKCIhCBXXOdRn/k4pnSlKZKRrZKJ9ySR
         WhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMS5l0NlUd0QicuPamQjjFgElAiyrtIYzxGcLq7Z8IDkFQYvXobhPUR7rmv47nhjrE1srXfPjb1ALmJA3rlLbzMOXxRNq+QvcthgrNz8Na50CgmMoQp0/4gQsi4d7JH19/cIueMej2IrqMWO2TeltGIsloCXZs7dz0OHDh7E39lm2f
X-Gm-Message-State: AOJu0YzEsL+dELT5UUFvrRFOy5aK7Y9DJMdbIvAoJ2hyLzdLIH3LwIQ+
	0Mto00B8GSqN58Wgy1JmRA/2g1zFUqw8s2Efot5/gVlQkomJLbAuV95BRQ==
X-Google-Smtp-Source: AGHT+IEh/cgX/fwSr/Qf+rkCnE+FwhUG7QRMVZIlEKOXguTlAFPyDJHm9nWwN1jNvQkd90th0Ikb6Q==
X-Received: by 2002:a17:903:234d:b0:1fb:67ee:6de7 with SMTP id d9443c01a7336-1fc4e131d9fmr23895775ad.23.1721235348035;
        Wed, 17 Jul 2024 09:55:48 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc384ecsm77469445ad.208.2024.07.17.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:55:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jul 2024 06:55:46 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
Message-ID: <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
 <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>

Hello,

Does something like the following work for you?

Thanks.

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..ec1d191f5c83 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -329,7 +329,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
 #endif
 
-	u64_stats_init(&blkg->iostat.sync);
 	for_each_possible_cpu(cpu) {
 		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
 		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
@@ -632,24 +631,26 @@ static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
 static void __blkg_clear_stat(struct blkg_iostat_set *bis)
 {
 	struct blkg_iostat cur = {0};
-	unsigned long flags;
 
-	flags = u64_stats_update_begin_irqsave(&bis->sync);
 	blkg_iostat_set(&bis->cur, &cur);
 	blkg_iostat_set(&bis->last, &cur);
-	u64_stats_update_end_irqrestore(&bis->sync, flags);
 }
 
 static void blkg_clear_stat(struct blkcg_gq *blkg)
 {
+	unsigned long flags;
 	int cpu;
 
+	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
+
 	for_each_possible_cpu(cpu) {
 		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
 
 		__blkg_clear_stat(s);
 	}
 	__blkg_clear_stat(&blkg->iostat);
+
+	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
 }
 
 static int blkcg_reset_stats(struct cgroup_subsys_state *css,
@@ -998,12 +999,10 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
 	unsigned long flags;
 
 	/* propagate percpu delta to global */
-	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
 	blkg_iostat_set(&delta, cur);
 	blkg_iostat_sub(&delta, last);
 	blkg_iostat_add(&blkg->iostat.cur, &delta);
 	blkg_iostat_add(last, &delta);
-	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 }
 
 static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
@@ -1134,9 +1133,9 @@ static void blkcg_fill_root_iostats(void)
 				cpu_dkstats->sectors[STAT_DISCARD] << 9;
 		}
 
-		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
+		raw_spin_lock_irqsave(&blkg_stat_lock, flags);
 		blkg_iostat_set(&blkg->iostat.cur, &tmp);
-		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
+		raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
 	}
 }
 
@@ -1145,7 +1144,6 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	struct blkg_iostat_set *bis = &blkg->iostat;
 	u64 rbytes, wbytes, rios, wios, dbytes, dios;
 	const char *dname;
-	unsigned seq;
 	int i;
 
 	if (!blkg->online)
@@ -1157,16 +1155,14 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 
 	seq_printf(s, "%s ", dname);
 
-	do {
-		seq = u64_stats_fetch_begin(&bis->sync);
-
-		rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
-		wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
-		dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
-		rios = bis->cur.ios[BLKG_IOSTAT_READ];
-		wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
-		dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
-	} while (u64_stats_fetch_retry(&bis->sync, seq));
+	raw_spin_lock_irq(&blkg_stat_lock);
+	rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
+	wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
+	dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
+	rios = bis->cur.ios[BLKG_IOSTAT_READ];
+	wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
+	dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
+	raw_spin_unlock_irq(&blkg_stat_lock, flags);
 
 	if (rbytes || wbytes || rios || wios) {
 		seq_printf(s, "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",

