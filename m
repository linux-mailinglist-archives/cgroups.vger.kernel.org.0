Return-Path: <cgroups+bounces-15469-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G8rBjrt6Wm2nAIAu9opvQ
	(envelope-from <cgroups+bounces-15469-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 11:58:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74B4501CF
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06D63044A5C
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823533E6DD0;
	Thu, 23 Apr 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b="pSy83f+I"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9F3E5ED7
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937711; cv=pass; b=OUnXiuugZILQ87upJIS9N2rvtuzmIEhlsqRH1ZuFoGWKPSizsTIZmymNO3qZjjWuOA2EqpA3KiHOgJCbFvDTpF/Ab4bnp1d32eIUiYl1VPeixhEW3oNW4zRW/sCO8rIbqmKWSeg0/R4XiOTrr3UP9iPp07idPEmp8UUod+P+d9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937711; c=relaxed/simple;
	bh=DTtD8X6sVggh5VIcIMDoba9mIX+BbkSQ6InYBtaF2i4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaC8vwyTKiWSn3z/is4zW5o98QsJ1PqXENTaW+WkAoeuuPEr98zq/ijcR6nWFBhIa3Y9D6bGP7qIqA2clNqGBUkdnJ1F3V6RKXCdvMoz3VxFizfqCaexyMroLYA4LmlK/sPvKuaa9RhFG4/s7s9WyWUQVfBgGov/UnmXXpV/iIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b=pSy83f+I; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56d8d479149so2174041e0c.2
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 02:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776937708; cv=none;
        d=google.com; s=arc-20240605;
        b=h37Ray1ACRg3Dg0bNfj3XRDEAwoQW9PBHL8FTPg5iwqP4aURec55twoW28hSh7LEHS
         8IZotuIb5RUWZsbXTSCH4U8SVNbh98LEni6gSRYKGlF/vK1wUspyCvfSjNQpFFlXasVu
         +1qRujDSB0ybh3yAm2pnU0KyHTsqWLBnRGWPSXElVWTMzuk6sbO6U8eUb61hizabWo/2
         3/d5f8jqrIQg0rqiD2wUbUj67H9T/DQs3wtmb92kBRNkbRncReeKkLaJCPe9hdpHxloH
         4ltvi3DmCtlwri6KfLDoDUreXXxrYAM9K9mGkNObbqwFzCMKmIHAHzhblDi2iQggG73z
         vC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Jn+R0+gHDrnFW+3S27qowqdIYlMNWUhnGTDF4eYSta0=;
        fh=JXicV0gJ9suSKGEfX89+Vg3T/sMWy3CY4UnXqixp7dg=;
        b=k60YUg7Esu/AVtsw3w2Q6CYfpE4oJfgOvisIuTSbw0DY/JyQEaLJEsGxs7DD0ylSKS
         CSbOaASyOiolRkWhOYXr0Ys1drWetYr1anduZNsac19vBiwTGxgqPZl+dVltr/nrbHVp
         EY+livhftAO4TxkEJDCkd0KQKnZt+VBQQkgldKmorJhpfTF3Og56LffMSDgyD08w+5Wz
         by3n/uRGfuMHmEIr6A5OsBKiyUlz/TEwSnQiZxVsPpEjBUXWmoi/pwtTys4kcOy6wryG
         w0Ne1YbCFVWzzkduBIc+73Spiy/CsfsPo75Vyoqr7Ck5VFOihk9mu71U29+sNtUpZ0iN
         zrdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20251104.gappssmtp.com; s=20251104; t=1776937708; x=1777542508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn+R0+gHDrnFW+3S27qowqdIYlMNWUhnGTDF4eYSta0=;
        b=pSy83f+I2t76ZEDY6k36tEVO70pkL0ZJSAnIwI69MtnOueB7mp1aK7MyznCfIpcqZo
         iE28arZlL3teqggw8nu4KF8cR+i8zgkp7kL1no0NbAiWzcANO1Mi187/KTFD8fy8sjgW
         uG02xj/6nkwoEwtlcEtegQBjDoA8KisErt6PY5Ae72/GCGcSDnV/AraKHB0pSLazIH7o
         zX2rfDJHmQ2NEfa3pokjScW2Yz6G2VDp4O1Zd86oZhk3jcETxrSvm0FVHdqZvLXPm0+/
         EHmHwW+xTwXxV1xAclPr2hKesBI2HwtFgDYwGW0PwHcdEpdOMYHp8IRHb5fjAhavPU4+
         TADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776937708; x=1777542508;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn+R0+gHDrnFW+3S27qowqdIYlMNWUhnGTDF4eYSta0=;
        b=S0vGvO+7sj31afoRzuSxgVRj7QtItxBlDACX+cHPWwg1b86VxZWD4UFtIUAUUMdkAi
         4Vmji6B4peuimS9HkMMnwxJdA2XrWJFsPY0FCIkHel18tiM5IiiYHQnj3mf8ezrmsWln
         KJohZ7H8280KbGV53KASB/E2sNUyzONtByj40cEitYe+9gB5J4FqPtazSPzXGrSclxHP
         PVFAYD2F6jwNQHf3m6zwdeme82OgS/TgAxVnRqBjlzQQgmCeFD3osONo/zJ4nwqbzrJS
         +DXnKD+DklfCA1T45vSxA1jcN2Ni//v+NVovhFhTTrwNwvS1mCQN3IJAPewvu+iPzzMd
         BIrQ==
X-Gm-Message-State: AOJu0YyWNTgTf83AhjAdJJ4Vo/hyMZoaw7rLULnj4iCSrzU1A2vf2AYg
	QQWI3J0IY6PMPSeJTYClZXR6o0bXQi2ALl8ChG/7FrHFY9ToZWFeq5jA9a2WteC064344S+8kvb
	G25sVLmaHfkUdrl4AjDIjc4qA6E/A2x4+6tSL7/9EDF9IbnJJnrA=
X-Gm-Gg: AeBDieupln6QnMpYLqc4qR1tvHteEMVHgp5pnESdSaVRWBGhgfottdgxyAzPQsNrDkc
	cxZFGq44VSGRupOhN/PulJFJuEYTdoObDfVJagLkbEIht7Y0+2FA0JbGdHsO3adUXJ36YWQqd+t
	00UCtSWq8rfiacpQYBInUselIrJ8vt7GCGFALyclD5S6cLsualQxRceju/+n/F/kdqZlDoHRei7
	NTynCtwhxKZkyPGEwsUk2wFZtfGEfcFxgEpDxSjxZTBsmx/jPJntil7xo5BRAySMMXUGfoxRJbv
	cgbN4Wq5oN+6Cu8hnQ==
X-Received: by 2002:a05:6122:913:b0:56e:e68e:9fc2 with SMTP id
 71dfb90a1353d-56fa5953401mr12089977e0c.10.1776937707870; Thu, 23 Apr 2026
 02:48:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Apr 2026 04:48:26 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Apr 2026 04:48:26 -0500
From: Petr Malat <oss@malat.biz>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <32f69d774f9aaac90d588567e1fcd880@kernel.org>
References: <32f69d774f9aaac90d588567e1fcd880@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Apr 2026 04:48:26 -0500
X-Gm-Features: AQROBzCJaUfJdsPTxx4U7QRfusM9ZVl9n9EcyBiAYwVxKHccKO9_QV6Em7uhpuA
Message-ID: <CANMuvJmf7On+qRnkkBpqzDe2HqX0axWKKPdtfAdjSdN4i1f0qA@mail.gmail.com>
Subject: [PATCH v2] cgroup: Increment nr_dying_subsys_* from rmdir context
To: cgroups@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[malat-biz.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[malat.biz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,malat-biz.20251104.gappssmtp.com:dkim,malat.biz:email];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@malat.biz,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15469-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[malat-biz.20251104.gappssmtp.com:+]
X-Rspamd-Queue-Id: 2B74B4501CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Incrementing nr_dying_subsys_* in offline_css(), which is executed by
cgroup_offline_wq worker, leads to a race where user can see the value
to be 0 if he reads cgroup.stat after calling rmdir and before the worker
executes. This makes the user wrongly expect resources released by the
removed cgroup to be available for a new assignment.

Increment nr_dying_subsys_* from kill_css(), which is called from the
cgroup_rmdir() context.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 kernel/cgroup/cgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3243c2087ee3..c928dea9dea6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5724,16 +5724,6 @@ static void offline_css(struct cgroup_subsys_state *css)
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);

 	wake_up_all(&css->cgroup->offline_waitq);
-
-	css->cgroup->nr_dying_subsys[ss->id]++;
-	/*
-	 * Parent css and cgroup cannot be freed until after the freeing
-	 * of child css, see css_free_rwork_fn().
-	 */
-	while ((css = css->parent)) {
-		css->nr_descendants--;
-		css->cgroup->nr_dying_subsys[ss->id]++;
-	}
 }

 /**
@@ -6045,6 +6035,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
  */
 static void kill_css(struct cgroup_subsys_state *css)
 {
+	struct cgroup_subsys *ss = css->ss;
+
 	lockdep_assert_held(&cgroup_mutex);

 	if (css->flags & CSS_DYING)
@@ -6081,6 +6073,16 @@ static void kill_css(struct cgroup_subsys_state *css)
 	 * css is confirmed to be seen as killed on all CPUs.
 	 */
 	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
+
+	css->cgroup->nr_dying_subsys[ss->id]++;
+	/*
+	 * Parent css and cgroup cannot be freed until after the freeing
+	 * of child css, see css_free_rwork_fn().
+	 */
+	while ((css = css->parent)) {
+		css->nr_descendants--;
+		css->cgroup->nr_dying_subsys[ss->id]++;
+	}
 }

 /**
-- 
2.47.3

