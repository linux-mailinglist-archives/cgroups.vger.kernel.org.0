Return-Path: <cgroups+bounces-5433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4209BC0E6
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 23:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCA41C21F95
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 22:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA41FE0EB;
	Mon,  4 Nov 2024 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtp3rzdW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72B1FDFBB
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759291; cv=none; b=C1cFNf4GqzYlOq8pZPntStp7miFfam7egZjzw6Lu1fDwDPmI+0a+JLwraHE2YC3M7DaBYxq3no5GImIARKhhOhw46r6cFeZcwibQcv4X5GIWx240McvHvqp8YhqGAxw7FtfVsnGnDGsTw3a2nQRbB626dh+GO8N7z8b+0GCN16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759291; c=relaxed/simple;
	bh=2ulKgS1WJ4dbuBnCKxnqeyIGe4MyeNcFUS3/7Qh/Yto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hL36ekdnf2PKed74fdhNgmGPOfXEBY5SLIuWCRKXyLn5NHDDqGRQ/ZwLlXHwa/LxnFD0AaLNKsXDv+ACwpLeBlBA24JaRSGLZMDt3u4hmkhoLpU8hSk3TAD2zrZHQTiBVcKYGYOcgOAqaYVA2aKsyaZT7bR+oiIl9/s1KlFNIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtp3rzdW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea7c5805ccso42506787b3.0
        for <cgroups@vger.kernel.org>; Mon, 04 Nov 2024 14:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730759288; x=1731364088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=15O9ca4pVZTESzuvBdGrLRHe530YHW6qwFu9Oe4DO8I=;
        b=vtp3rzdWidZf3C/8B8T5T36g2m2yAh4UzT7nJvtEPnSY1lLbPDQXkifhZRVSCgupIH
         +V0Ow/e0ohARg8vr9kBTLgTxvul/BQv3PsFkszxG8bMmS2K3mQiayERZZrKqunanQnOK
         jxhw+p1VBXc50MpOscDDSWYYyaYIQGhtLIy6vG1ylJRf1bk8aZJ1fcYTJRguMZCBIlHx
         NJwSrmEyHnO9UDgAwG56Sl5nW0p1+cjXpQ3HIgacTKHM6kHi9tvE7mfJoy8jOmoUDo0W
         JufZVYykULhG6q0SEB1+X8UbgRWcB7pUE08DSO/uYU7hjKhRRiKkwyPlfzBaxC9jCM2H
         bDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759288; x=1731364088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15O9ca4pVZTESzuvBdGrLRHe530YHW6qwFu9Oe4DO8I=;
        b=xTbrPkAQdwCF4+IdS82mZ1cHxlAjYnnql16KXXkinKA5O3O06O+XLERsWUIT31AkKZ
         oqRvv4KhGblV6/Yd0VyevVqOZVJC0YMFQy5fnTdAsmoQoSRI1QRj7gnV4bhI+z2UfYTo
         kr5txp4XVoddagb1AurCZub6Y0Ry8g55knMubfIDhMMSUc7uUNoQUKuC0enbuO0hjWEz
         Itah0fvwh7CXkFv4QtLmNd81cS7ZP7ZP/pyfLivW1XISUlKsLmo+EkhuJyiLIygntl9N
         JmLuLK3QeSH9T46+uiY1D+yt6QBA4vIIpL8FRBjC528SEvQpqY35WmnbzpQvpdaqLncZ
         /o5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPd87Lz/r2GFN1jfSARwgcvBXKJIeP/ea6BbapaDqjCJbdGQ+2OuIrFOWB6tfClWoocu4JT1N4@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpM/r/vPgS3OMxAz1/be5pMQsfqaXbFfwd4siSahStx0/0//O
	bpJudr509YL7C7shlfhGQJlKOmgNuNof/2GQgUq25qrw0+23vgEsyjETnwWFP+Mqac+HjzO6Ji+
	D1JSEp5mPbg==
X-Google-Smtp-Source: AGHT+IEpn3Ozfl3bEakiUcys3vke1g1CcEk4jHzka3T3PWfF9UiVOWvD6xNRzVdmFNyJHcOxgC4N0YzCvE4knA==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:2520:b863:90ba:85bc])
 (user=kerensun job=sendgmr) by 2002:a25:b411:0:b0:e2b:da82:f695 with SMTP id
 3f1490d57ef6-e30e5b0f56amr10735276.6.1730759288333; Mon, 04 Nov 2024 14:28:08
 -0800 (PST)
Date: Mon,  4 Nov 2024 14:27:35 -0800
In-Reply-To: <20241104222737.298130-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104222737.298130-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104222737.298130-3-kerensun@google.com>
Subject: [PATCH 2/4] mm: Fix minor formatting issues for mm control
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a line after declaration as it's missing after DEFINE_WAIT(),
replace the spaces with tabs for indent, and remove the non-useful else
after a break in a if statement.

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 3951538bd73f..5f9d3d6d443c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -460,6 +460,7 @@ bool memcg1_wait_acct_move(struct mem_cgroup *memcg)
 	if (mc.moving_task && current != mc.moving_task) {
 		if (mem_cgroup_under_move(memcg)) {
 			DEFINE_WAIT(wait);
+
 			prepare_to_wait(&mc.waitq, &wait, TASK_INTERRUPTIBLE);
 			/* moving charge context might have finished. */
 			if (mc.moving_task)
@@ -490,7 +491,7 @@ void folio_memcg_lock(struct folio *folio)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
@@ -2096,8 +2097,8 @@ static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
 			failed = iter;
 			mem_cgroup_iter_break(memcg, iter);
 			break;
-		} else
-			iter->oom_lock = true;
+		}
+		iter->oom_lock = true;
 	}
 
 	if (failed) {
-- 
2.47.0.163.g1226f6d8fa-goog


