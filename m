Return-Path: <cgroups+bounces-7040-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E062BA5FCD6
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA91188F5F6
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7991155382;
	Thu, 13 Mar 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHQdVYU2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFD15747D
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885224; cv=none; b=qolfEkmbXUH/WjjrFcpLFAvYbO8ra5vlh6C3h6lZCIW4rtiXnnNb3aVD/iVy+D93ZEd+qeCgDyw0FVXsRQhXSAKsY6dxilmztT9ZOHTeFh+cidZzZg2DjxZuaJOKiHUlCGBZ8VSj52fBDhP1qw3HaWMH9WgTQNHGSyOvzpNVe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885224; c=relaxed/simple;
	bh=hPgfIteAKRae6Xb9DtmO3KzHb+o6HvFeO+EvqotCUBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqAAfxXrhQJxtgYp5fIjzPqKQYBoUxF99KWYMR92WLP4F8oK1kUGKGEpPkZUGv230z48QeSWWvINj+lYErG7EaycXPygjLuDC0IQkZHRbE41R+rISP9qAHPabqvG+EtcRNibMvg6ysXu118GT2+TijhIE3m3TO54eTPFijPZzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHQdVYU2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8YjG5ItqH/53cxab3vJ+AAYA8I/sog4WfKqtRusAYQ=;
	b=UHQdVYU2HSTRVWz4Y0NUctcJlJxYde96LUWoQgMwYJh1epkTMwiIPef9/MIpGo2zd6zhvF
	XaJ5sf7Au5rt7NPyTvfvA9iXRQ45PX3REMKPEMa1t87XkiWJJD0wjrqTfoztBMeiLPoVfy
	X96HF0VonvJ94NaE3uPqfm3Vxw0c2Do=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-J39TLX8JPDqR0mSCCwvdbw-1; Thu, 13 Mar 2025 13:00:17 -0400
X-MC-Unique: J39TLX8JPDqR0mSCCwvdbw-1
X-Mimecast-MFC-AGG-ID: J39TLX8JPDqR0mSCCwvdbw_1741885217
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913b2d355fso513948f8f.1
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885217; x=1742490017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8YjG5ItqH/53cxab3vJ+AAYA8I/sog4WfKqtRusAYQ=;
        b=iBgXXBUGBAiYhW0Ith+5V11NnJcROlHV6IhWyh4KeWasLekZPrCrwovWrkZvTGXP9b
         SjEiFNvqpY4XO/h/yN5KgvenaOhnJFRCMMg0hiR58tdw2BUy7T6VsngnYt7s+AuKI876
         dJFnqXUKt5gcS6GbO4+ZwQRl2Oe8M6l8FkfGv/4EA5Zuh95eEgGIwtH0+muVo4zU0fLg
         YNCQ0wY947ZdCPNv0wrhcb7IFqOlPFEPIVQPDLgSpFB50Yvg9P6D8SAhO7g4WSbqek0t
         dEf/9h5aVVSedYe5ynDUCEU65EbTFO77y0qWcFgE9I3tzfeARwEBSyJNlD5cNevBun8E
         QMlg==
X-Forwarded-Encrypted: i=1; AJvYcCVSrZJKicfYkOp2oc8IICUcjIdu+Xge6QSP/WqaKDnFZPCpVTwKDXgKt/nc2VMEjvc8NJU/RA9e@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7gOaikQrGInzTarIZE72zR+wgLtS07qYSOEfVE0mgXsHPC6y
	kZ2hfKLDPmui3/Mk9wQMUDP9plg+8pjdXJvrUg1O8M/yGJzw+oS+jyJhbtabpDUSO8cdA37CmME
	Lns25r9ROPG+iOdFoCgFBSPyvKJMdlcyzJFBafXhxfmXmeUw3IczFqJA=
X-Gm-Gg: ASbGncsOtt2/FHDRlJGe3Iy/I1mKK5O6RcFZ5w3fNiSADv8AFn4zXbd4zD2irQAZfvL
	hmEQWmxRoeBYQ+h4gDpzTjfzmKs3ZmVlBnGN73fv+Z2dIFrcJW+kirmFjEEQMKQYmJmlqfTxg76
	jG/VkpLz9o7UjEnnZSpU9RUNbXo6A+dCNZuS/L2V9WocB5Cl7KOM2YptQTrVVD7Vojqi3PAZ+eT
	53Pf+Pe453MPP0M45RktiyEWWXQIq2gNVn0fH0Yy3l8YNmwQ2Gwmea3Gn19zZQDfFYr+Hw6FCV6
	2psOWaxzJ8fgAO929xAGDlqkH/9A2PlFWF3EXEPk2W4=
X-Received: by 2002:a05:6000:23c2:b0:391:122c:8ab with SMTP id ffacd0b85a97d-396c1c207bcmr188037f8f.22.1741885216747;
        Thu, 13 Mar 2025 10:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkUvqQ4kZQgkVidzMwhKp3X0BWVh24OqT8ruMci31YdZKf7dZODGUNpYgkn2DkAYcJwNHbWw==
X-Received: by 2002:a05:6000:23c2:b0:391:122c:8ab with SMTP id ffacd0b85a97d-396c1c207bcmr188002f8f.22.1741885216374;
        Thu, 13 Mar 2025 10:00:16 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2aaa6sm25912475e9.25.2025.03.13.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:00:16 -0700 (PDT)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 1/8] sched/deadline: Ignore special tasks when rebuilding domains
Date: Thu, 13 Mar 2025 18:00:04 +0100
Message-ID: <20250313170011.357208-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
make sure sleeping and priority inheritance 'work', but it is ignored
for runtime enforcement and admission control.

Be consistent with it also when rebuilding root domains.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff4df16b5186..1a041c1fc0d1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2956,7 +2956,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct dl_bw *dl_b;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (!dl_task(p)) {
+	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		return;
 	}
-- 
2.48.1


