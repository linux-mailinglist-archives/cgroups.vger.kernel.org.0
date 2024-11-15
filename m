Return-Path: <cgroups+bounces-5588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203E9CFB60
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 00:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E4C1F247D3
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8DC1CEE91;
	Fri, 15 Nov 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2Zj4AtC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A801B85C5
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715084; cv=none; b=BIOC4qmb6Q7mUrXOB84uhH+0oM7eTGp4Rx0VOiiRfe/3G7mk29ROASLiskTb4M5PZ+3RlkJL6BCYFrcygmj94+ZkFyLq1/cS3PSazbCD/eIBiyzxM0YbcOfxoaGwlgQ5hjwNRGnYfpXuVoc03CIBWvHV4xA7oetBlGT0Y7/nmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715084; c=relaxed/simple;
	bh=aP9KdYcSoNMdOUbsyZNNuuKycbYgRNHovCSpVZzhg2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQrcwZXBwy8jlDS/1+0Lwzqw2n5eo6kbU23rdAVVRpBVtMDxH3Hf7DmBWUDd5c+56ai2BV6hZxWu7nZNV298XaGh7an/nU9LxlWxf0vBjWHMpzqpgIk34TkvR4DF9MVjbHemNEnjTtCAaYI/PFVPh39fD9uOHMprt9aiThNHkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2Zj4AtC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e86e9so22653247b3.2
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 15:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731715082; x=1732319882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrEBNSRkiEojOqX+4gfP8RZsafc+q1NaKoMa79m2RXU=;
        b=D2Zj4AtCb6dY8/k3/pIhW1LX2c6hDVNX7sHTsb318hb+1GMrULOZOfqaGON0fCkFCB
         9jFf9WLr8oGE5RUgfdXhm5bwRKBVuwOKs1/N100GfpbYyEA2rfEziCFXv/Gr1Nq6NoiU
         62T3ytB+WiDlWeyhORJAKWyvSXw0OE+zcjfFi0jbFD0l7pW2i6aiqtGn6YpHsU4S+gJc
         Afvpoj62oO5yTc4vaCfWT3942OGeNn4POKowR6YJwCF+zVcB3s8UT3ZwB3X23UdD/l3S
         Xwe50Noeavgvn2kHJr0tjwNk/nxoaby4Ka/FYtpFSj/WzDKi2ao2LpEbD0ftvO0f1Y7A
         o4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715082; x=1732319882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrEBNSRkiEojOqX+4gfP8RZsafc+q1NaKoMa79m2RXU=;
        b=FebvRkMnuo8VLshu17DcYCRCBzoLgqk6J1+k8dyDfFufhiCUz7sr2DRkDG8rsuLhOR
         qjNsr1yEGlPYfmCVE53inRYuimrebqvo3ybQhJ6aV4dpyD1Dvpuz2SDeBDskU6mwuB9Z
         kHbVT7AJDZzUVm65nkxGz266LKV2wBQkiqjCBNAQ4XOd/SxAM6HV1fUlIBkdGgd2kJWA
         NkI9thHBOOpkjt3DAleoJQ0O59ir7GJ6lMvoHgJ/+wIfWAR4y7ToPT88yEyGRv5M6Ozy
         WrDQsuSRnoxRKelgYU/P5BpwjFKPXG9wjwkyRMCLQDwBbqEBforjviytOGrjjyzgQYQs
         wQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiUYAZIw2V9Pl9dCP6PflHwGV2lMhlMTC0yr60k589wPTS4o6qdTf3UAtE8If+ATG9wmEhAiG6@vger.kernel.org
X-Gm-Message-State: AOJu0Yycx7Y/2wvLQX6xKweUQX/VcnWmhygqLK+4wMn6AKO/pPEWnCYN
	AEmuvq72H0m/LpCtRVltBcuuO319oIFoKUySWgIy64y92sHwMNSdvDiXHucu8Zc/laalwAGxZNQ
	Dg3ZTDEacag==
X-Google-Smtp-Source: AGHT+IEj4KClsgSqXktbEj+ARf/VjHaKN8ZOK6NA9iO0b53n0H+SstnU5eqFIIEUIzmZZO9P0LaXRT13p0uoWw==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:f2d6:8e6c:5a90:ef1e])
 (user=kerensun job=sendgmr) by 2002:a25:b001:0:b0:e33:104c:fac8 with SMTP id
 3f1490d57ef6-e38263b7b7emr3194276.7.1731715082063; Fri, 15 Nov 2024 15:58:02
 -0800 (PST)
Date: Fri, 15 Nov 2024 15:57:43 -0800
In-Reply-To: <20241115235744.1419580-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241115235744.1419580-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115235744.1419580-3-kerensun@google.com>
Subject: [PATCH 2/3] mm: remove unnecessary whitespace before a quoted newline
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove whitespaces before newlines for strings in pr_warn_once()

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 465201ef40b7..4cbbced0c8a1 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1043,13 +1043,13 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	} else if (!strcmp(name, "memory.oom_control")) {
 		pr_warn_once("oom_control is deprecated and will be removed. "
 			     "Please report your usecase to linux-mm-@kvack.org"
-			     " if you depend on this functionality. \n");
+			     " if you depend on this functionality.\n");
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
 	} else if (!strcmp(name, "memory.pressure_level")) {
 		pr_warn_once("pressure_level is deprecated and will be removed. "
 			     "Please report your usecase to linux-mm-@kvack.org "
-			     "if you depend on this functionality. \n");
+			     "if you depend on this functionality.\n");
 		event->register_event = vmpressure_register_event;
 		event->unregister_event = vmpressure_unregister_event;
 	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
@@ -1895,7 +1895,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 
 	pr_warn_once("oom_control is deprecated and will be removed. "
 		     "Please report your usecase to linux-mm-@kvack.org if you "
-		     "depend on this functionality. \n");
+		     "depend on this functionality.\n");
 
 	/* cannot set to root cgroup and only 0 and 1 are allowed */
 	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
-- 
2.47.0.338.g60cca15819-goog


