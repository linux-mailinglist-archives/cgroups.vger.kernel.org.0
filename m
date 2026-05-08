Return-Path: <cgroups+bounces-15679-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H7dxNeqC/WlcfQAAu9opvQ
	(envelope-from <cgroups+bounces-15679-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 08:30:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE4B4F277D
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 08:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623153035B73
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 06:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2460374190;
	Fri,  8 May 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TScFM5ED"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44C36F434
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221795; cv=none; b=co4sxJ3imBHjsb1TV9kXywM5C45mk8j8vVVBvavYsTkFusMwF49tqo4iVjhMTy8wm4rflbWObd106+VIgdIGHknxeADk/tnZbLodESi+b/K9PTktJV5f70rK1i2Z3JyhAr3aHYjBqxtVWaZy8ZycvYrZ5iJj53CzgJEbNelGB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221795; c=relaxed/simple;
	bh=fW8gVB+EI6oZInFtMBuIDxuRFomnUCWVVIGa7SUwdDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HnclEGsij6Ry3JijCmQuUqeDLSuu/eScEKgDRbj0wnsExDM2xGrPAtVMQa+c9CCQyRXsWjnu92e8tvOVbd31l2AiXwGXiFX4JKOa9OmIuJX1kaJ3zb+D2/GPxQRq7+bOXxdDiykuYX/c1qi9nbzeexbI8Gr6b7xq10Kk99MlSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TScFM5ED; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2bab82d75fdso9333605ad.2
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221789; x=1778826589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9iTSiJD2169qOZHi6IKi+RhDhn4JEkgsKVNNe0KaB0=;
        b=TScFM5EDHHslmuivSg+05yjAw/QlMsWM5XCstRV+P/8N4ZLiHXX7Gu0jeptipvkEzp
         HzncI9UqGsWLUcoa5FZx9VYgOji7r0xVxl4p+BlrqsPmVOUyWodk4XY7MbdMqF7zHmZ+
         gVvkgrfVV4YOo6RkK+u/J+5hZKrFXdDV5QDO857z0bNA1IH62n1AKiDHOTKKK5c3iCXY
         4hoASJFDhqKZx2a94WXWLboEvyGJ4Q6c3YdzsnPpCrsA8QfCYjrqz5p46FypK2DUycNM
         u+ZB50PYsmAootdPjrFjqOCZ1zBfdKK9EFIk/BRzCYQzwrNSnli+uNRjmkMMpLqOBCUS
         F9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221789; x=1778826589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9iTSiJD2169qOZHi6IKi+RhDhn4JEkgsKVNNe0KaB0=;
        b=Jx0juvvqfOLEdckq0qSYvIwzbj2Ngt0gkL+yevrH58sjqjYZ2AALTqKuc45Iq6j8jb
         cX9DcmxHmzYBa1kaum9/pvSOY8oHaJoPCtmGVUSn4hiO3KK3RhJ3q6EPAi5hLe3EVg6a
         oHBpn8I46TvaSd8wGGtYmZBrHg2PPGSmDZm7QOgOq6Sm6m+x9w6elvcfDQn+yXAGxO1Q
         0XVmKwg3V2RGFMz6BaxAQpMN9vah9oQzEt1zIUhVgWAmA3zePsWXwRndZY8Qfh5NrI7A
         VVJBOZ0atWJLbBrZ0gWTDet3QSvd7U01AYqNAaOL4ZwZOIVOfbOhtQ50B6NeVTnN3mKa
         VhgA==
X-Gm-Message-State: AOJu0Yx7tXW2SLUTl17qSEAk7IeCTy/+egHohAoPdecv5wyOpizaLVkO
	H4LYpkKW9rk8A4H1Qt9d+azFMpmu0CeZHAuCp06SmLRS7grW+DEHa5L5rKmF98/hMIrslCdr
X-Gm-Gg: Acq92OH/46mtG1AtsViiUa9b8c2Grq5qLJ+E5PS8rVuPT/U/vTbVRgpL1Vh/J5U1Tqo
	697lS+mv5AEULyMBurbjW8uVe7Cty04OpSpWCSqLpaWvj2ooxpLOftH3nfttMxYhtn9SZQ9g6tP
	V2R+TvlIvM1oRkQ23venFELyvc/JOYC4S0tQ0/3LDSTJQCHt29plh3D3n26rq3FX9YQnmfvcrv4
	a8/UOOpIRWqlwx0fsMbB16EA2ifpePZ/NtBmHfvK/4U5pJvrhDd48Mtj1cj79CeHWZRIEd3eAhO
	5yoBkKuNiZbDdRUccUH7o2o+Uk3Th6l7qosaFPeBhYbM9oKO2b0MfknLaXPCl89WVf1ZgOLnxYR
	RUb+NdBeIvohY0Yj8IZaLa5YxJg6XDV/q3NNntr1E4DYAnNzGgZaNV+5CFGY2S3YXrtMBI48LiN
	YHH6J7ovMn9Kv8jZxz/o3p4fzHBKG6U9fqtlP21Q==
X-Received: by 2002:a17:903:187:b0:2b2:be01:5532 with SMTP id d9443c01a7336-2ba799d4662mr128880265ad.35.1778221788937;
        Thu, 07 May 2026 23:29:48 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3fee3sm8983975ad.18.2026.05.07.23.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:29:48 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/cpuset: skip hardwall ancestor scan in v2 mode in cpuset_current_node_allowed()
Date: Fri,  8 May 2026 14:29:39 +0800
Message-ID: <20260508062940.4094652-1-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2FE4B4F277D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15679-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenwandun1@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lixiang.com:email,lixiang.com:mid,suse.com:email]
X-Rspamd-Action: no action

In cgroup v2, the non-hardwall fallthrough path in
cpuset_current_node_allowed() always ends up allowing the allocation:

  - CS_MEM_EXCLUSIVE and CS_MEM_HARDWALL are v1-only flags, toggled
    only via the cpuset.mem_exclusive / cpuset.mem_hardwall files
    which do not exist in v2.  Neither flag is ever set on any cpuset
    (including top_cpuset) in pure v2 mode.
  - As a result, nearest_hardwall_ancestor() always walks up to
    top_cpuset.
  - top_cpuset.mems_allowed is set to node_possible_map in v2 mode,
    so node_isset() on it is always true for any valid node.

The whole scan therefore boils down to taking callback_lock, walking
to the root and returning true.  Short-circuit it by returning true
directly when is_in_v2_mode() holds, sparing the callback_lock
acquisition and the pointless walk.

Place the short-circuit after the __GFP_HARDWALL check so that the
generic hardwall enforcement for GFP_USER allocations remains in
effect: __GFP_HARDWALL requests still return false when the node is
outside mems_allowed, preserving cpuset.mems constraints for
__alloc_pages() callers (which prepare_alloc_pages() marks
__GFP_HARDWALL unconditionally when cpusets are enabled).

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a48901a0416a..b539f5b4d21e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4231,6 +4231,9 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
 		return false;
 
+	if (is_in_v2_mode())
+		return true;
+
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
 
-- 
2.43.0


