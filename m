Return-Path: <cgroups+bounces-15721-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PljCU6SAWrTeQEAu9opvQ
	(envelope-from <cgroups+bounces-15721-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:24:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6BC50A0B9
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6C5303CC2D
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794533B3886;
	Mon, 11 May 2026 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWuCNBKg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC963B9DAC
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487538; cv=none; b=OtJ3OwXpb7lPfiOiyx4hjdwB5vL8npA1OeLDFCnPeK+KQKj+FjnWErrY/X6QoNZxaCDhf/9C3l7SEfNKtV4/mOoxWYMoejp1bBcjtdh7RTQmLJ6xHy+i5wRPk63gsrRXvoF3gmAcHPtKm/tCjqQ+IZhmRCarzMcRbTaA7f00sG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487538; c=relaxed/simple;
	bh=Nx0sQykWEqtrEC53sml2bRH7Cx2uV57dWsIG/5UL9+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NGHkTknpqz33dt8XrQh1OdMdWYOQndYgxR3wWQVJXLNCllgPMGZ16HaS4zwVfY/iD+b6pXsxCBbzq80BWIK/V9L1kvBBxQHaxK8v5ewi4bJRC2Lqj9x6MSeS2nTo1qiFQOgY36yLeRm8XMPqeBw5XIE+7WBDoRs34odqBUZuddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWuCNBKg; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-364f7c42c62so3294659a91.0
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778487527; x=1779092327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/6eqSyVRJ1DRWUO85e98DAUR1Huu+3ED4P9WdAPK+4=;
        b=RWuCNBKgzzhlGp1tyTlIb0VNLyYfK+dn9eBw+VoAyO5EkTcvFpAal6d2K7sDDEsX1E
         61Ae8JLaUmZeEkb/C5j8YvDUMpvnRMhfsApbhbf6F9yaD9rdLgjHmqYek4doafimzlbD
         jWkX2/cYYvxhYUuAcoh/Ly8OHKfhsUkdn/e/K+jjpm4pkUO0FjJ7/C4Z4rN/k++LR9AQ
         kk7rQz+Jp1RJ66rKfDWUBfCDNq6CnjSHWxzsMX0TYaFjtIi1jX77C/VM5NIOqaK6N9JW
         kl+gLTDHKbM695UHCoPdcQdEGMQjrq9hcZGNMHRN7BMHF1pCDMX3nLFbItmYvlirmfrT
         I4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778487527; x=1779092327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/6eqSyVRJ1DRWUO85e98DAUR1Huu+3ED4P9WdAPK+4=;
        b=RSf0c8YyZ6lWHoXS6+PYNSC4/HCL+pgkHL3J2wLtB/3vFIQUbkQ68NakptWh9Giqbc
         pN9yRZGA4SoaNQGWDJ+qtX+iKk62BSw2WVKMRqCgxSZ6ljK/oCQYhJxJZR8CAa8d1Rlq
         w25D9abMO9B2ZJjsJvvjn11dg40gSlK9pYE4w8UlnPEpV3gwfEHOujEPztvAfa1undJc
         SQPEvm7By/ZWKMTrSfFK6UvDv26fRINYrERifj52KrhhQPZag2R5UJzBU8/xwhIZYInv
         nBuhHz65Qz2g1/bhpahMtnV2KpLaRR7XDDAOQ2oXTjFJsesQftk68Krx+RT532a+ZHg5
         sGSA==
X-Gm-Message-State: AOJu0YxOCVztPLZL267f1k595ZluZcWW65V+F38UADqD4f7kTup3ZieM
	+bt6nszMZ9ZZWALNh1d+A6FlxPKGsG2GcpSpYjvk6aAp5xYf92gZeo5X9aeBHxnY779ZAejh
X-Gm-Gg: Acq92OH6W0cnv4zepkhjLtDOU5vPK6tD5LEf0p0w94WtffWMOU/dK97AJxkSb0dkmTp
	IS50xN7drHu5KJl0UYNy0SNa9IIDX4E4ZxLilecTxbE+2GXeiVVB0YoWY0/Gy1OK168ZSCnKWB3
	D6VNRY5T9vqPczqblqNeu3M3Og7xkg9LMhZwkIj3ZBGnL6/QcFSy8H4gQnJ4UEqzx25rv58I3w5
	fgBfa6uzZivILB0g/RP/KMS7umiDwV9Y+PP9GH86Ihve59LW9KXKQTXqaSnhOs0pgtuqyk7nEl6
	xWbWz54uj1XleazjnZwepdW7UaOf3/Bankmqehynw5AsIc+cgnjDRjYeIPBAc8OpWwuqnWA5C5A
	YMmYy0D0ICrPofbnPGsAnSlc1RBCTmQ7f3fhYAkrmAYyFPx6d3UUZ64G8jvSTepj9ZcnFX1wnOV
	JiuNvwd9HL3y3vXK7zNFUchTkEKJtmcWxCaDraQw==
X-Received: by 2002:a17:90b:3883:b0:368:6998:b49e with SMTP id 98e67ed59e1d1-3686998bc7emr2157344a91.9.1778487527270;
        Mon, 11 May 2026 01:18:47 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367beac5b48sm2631245a91.11.2026.05.11.01.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:18:46 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
X-Google-Original-From: Wandun Chen <chenwandun@lixiang.com>
To: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cgroup/cpuset: skip hardwall ancestor scan in cpuset v2 in cpuset_current_node_allowed()
Date: Mon, 11 May 2026 16:18:38 +0800
Message-ID: <20260511081838.862889-1-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A6BC50A0B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15721-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenwandun1@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Action: no action

From: Chen Wandun <chenwandun@lixiang.com>

Cgroup v2 doesn't have the concept of memory hardwall, only top_cpuset
has CS_MEM_EXCLUSIVE/CS_MEM_HARDWALL flags, nearest_hardwall_ancestor
always returns top_cpuset with all nodes set, so no need to acquire
callback_lock and scan up cpuset.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Chen Wandun <chenwandun@lixiang.com>

---
v1 --> v2:
use cpuset_v2 instead of is_in_v2_mode, suggested by Tejun.
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a48901a0416a..cbd9e7fc800e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4231,6 +4231,9 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
 		return false;
 
+	if (cpuset_v2())
+		return true;
+
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
 
-- 
2.43.0


