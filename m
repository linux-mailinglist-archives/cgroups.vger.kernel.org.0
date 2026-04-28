Return-Path: <cgroups+bounces-15522-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GJDJF5l8GmoSwEAu9opvQ
	(envelope-from <cgroups+bounces-15522-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:44:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 031DC47F23D
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DA94315ECC5
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8684C3E2765;
	Tue, 28 Apr 2026 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2rNhabJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB53D412D
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360979; cv=none; b=BsdlHyUAVIftex7pQ6ClEhdKGW7kc1xFeW6qVOif39TTQ4ZaZLTk5ooSn7V3USne+5QRcU5C0BDixAkk86yWF9sjmOVwzklLNV/wrymsB9tj+aohFUm3TZ1REQ2z0LZ6qf5rEB5EdZ3LFpDvSzJdcUBsfLoH+86tXebFhDmeiAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360979; c=relaxed/simple;
	bh=nQ0l0v8QwkAEUHIVGi1F3XLMUl9VbcGD5+44pIincio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcjNGSwXmkJrGoBWsRtNS5MI142WC7LfPZAYesOKtuYtYfAK6dc2uVgEG1en7IGzVJObUqwd1wk0AB64FIjmkV4oox+7kKezVi2o92WV015q8AWA+UbaRCb2+iabirMaaXL1wVS7/FTAQVC0bJh+voigAvCmuhDa8WEbS7EDhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2rNhabJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so3832842a12.0
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360977; x=1777965777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61aubxBpXGNItnK0rmG7NJew4PyO0rQkGOgFEHhhdGI=;
        b=b2rNhabJz3/XP0re4pSsJXxl2zLgrpFWVpcs+3fSvQZixTocnCoITXRpjy3JgvSkmf
         TbVdZQjwXMlNGRAqoK9PBybWcgbkCknVMrjHfpl0s+ASlh/QGx8HQ8XdvjUjxWLX5qAc
         pFyac84VOK3c3bodgi5L2NFOCS6metrF8Ai2dy5AGaoFhPvKfxk1vYsxNwPcPNOiougU
         PKveAp7Pz2Wccbwccsdlf3NH2MaAJ1SRJwuQvqOUyU/7UDErkXn6se/xYn2vmsbjOmHI
         nSEeBlfdxNyamVaF9aFAi1W7PmmY0czpV4s4+1lF+SgRpJ7DSnZg0+fO0k0IXibku+9+
         XfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360977; x=1777965777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61aubxBpXGNItnK0rmG7NJew4PyO0rQkGOgFEHhhdGI=;
        b=RrM7lcgTtk16doGNyJDw5eib/QZB7R2QaCVvqoLLLZapZFrHe8fZQrX92tmIy3KK0M
         zfyNKAYPt/UkoIipChwbHV21cyZhg4TQsguTWSkbqnjJflsn897FSY7AS0jgYEe3MDfg
         fRCwWOmW5pS7o94Dw70v+Ri/8SzwoxmpcSjNVYq45hqsuj5I0zVkgW0a9FLaDp5HngK4
         u9QAxC3gNb2iqSVLWo8JO/Ba5NqyqMGWuWY+JArGGEMNxC8HTbMcxROplUuyloMBWNLp
         zBY9BiS7s5DxkdCRoP4R/bGhJVAeJWbOx6uXa95e+d3YvnYOYQPjuTrTrAkEER6OCw1s
         riCg==
X-Forwarded-Encrypted: i=1; AFNElJ+fuUmUMt/r9wnH7JH8+YNmlKenzKooAivmSalJdPZQLmsGyiKhYth65uoggdtBkknk0Ku4saHi@vger.kernel.org
X-Gm-Message-State: AOJu0YzApEF7A5xCKnA8Q+S+sJ6X3RFzTMcr//lhcXLRkocfv7KjDhmC
	nl9qg0D903UmNEqZ2Z954Z5rIF62XP1Gkp3R6RjsY+gDOAfYipS+00Ya
X-Gm-Gg: AeBDieusn+mHQK/Vd+q27QdRqg7iPd181nWAuWKqmUy15K3tiy04N7kbax4N50yN0Sh
	iUGrOZYE4Xiq5eN+FO9VA9rIC37oWhBFD50l9wQVDSv2nTY6FmF4COC+JV9ErXNv/fCoqPBmv2U
	tjuHx44bD4mfCzaC+ZPO0akY6FwgQn7GNIOla9ca2g7hhoThT4ISBH9zqg40y++3sLApYZcvNFc
	b1pdmVojzkpkq64tbFCGDwTC0EEOGMDlTE0Nlb6bCvu6LFhSg7iW/1PKVZVdNV4OSZ0PzBig2S6
	e1klfBeb4+sWgiM1L3QbjVzx6weXz2kRPpS3ytct9e6qf59fUdgwAVbB1s2GlxNga2atmtIZj3B
	LqWKXkIisegIsrPFD8N2zSYXERdeoREueuVnwAVcGSfSd+aOgVcwuwhBp9l+0LCmQLkTV+Vt1rk
	kGL+CUYEgFAEXyGhMI0M4QMCxx7tFc1+COiH4yRll1E24I9rwKfc0AecYqb0A=
X-Received: by 2002:a05:6a20:728f:b0:39b:dea7:5624 with SMTP id adf61e73a8af0-3a39c2c0199mr2413857637.47.1777360977326;
        Tue, 28 Apr 2026 00:22:57 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc299f3d1sm1386025a12.4.2026.04.28.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:22:56 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: corbet@lwn.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: roman.gushchin@linux.dev,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH] Documentation/cgroup-v2: warn about cgroup.kill / cgroup.freeze delegation
Date: Tue, 28 Apr 2026 15:22:51 +0800
Message-Id: <20260428072251.2464314-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ftvtv7lv6gh6tfzabant74ncmtqjuljr3xfjxn5evaehwzhy56@kuf4jiwchuie>
References: <ftvtv7lv6gh6tfzabant74ncmtqjuljr3xfjxn5evaehwzhy56@kuf4jiwchuie>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 031DC47F23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15522-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,cgroups@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,ntu.edu.sg:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

cgroup.kill and cgroup.freeze act on every process in the cgroup
or its descendants without checking the writer's signal authority
over those processes. Delegating either file (by chown, or by
passing an open file descriptor) therefore grants the recipient
unconditional kill or freeze authority over whatever ends up in the
subtree.

This works as intended: the files are deliberate "delegated control"
knobs, and the standard signal-permission rules of kill(2) and
SIGSTOP do not apply. The current text in
Documentation/admin-guide/cgroup-v2.rst describes the behaviour of
cgroup.kill and cgroup.freeze in functional terms but does not flag
the delegation footgun, which makes it easy for runtime authors to
hand the files to a less-privileged user without realising the
implications.

Add a paragraph to each section explicitly calling out the
delegation contract and the open-FD equivalence, so runtime authors
have a single place to read the rule before deciding whether to
chown or pass FDs to these files.

No code change.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 91beaa679..6013e2d1d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1048,6 +1048,15 @@ All cgroup core files are prefixed with "cgroup."
 	it's possible to delete a frozen (and empty) cgroup, as well as
 	create new sub-cgroups.
 
+	A write to cgroup.freeze affects every process currently in the
+	cgroup or its descendants regardless of the writer's signal
+	authority over those processes. The file therefore acts as a
+	delegated stop knob: chowning it, or passing an open file
+	descriptor to it, grants the recipient unconditional freeze
+	authority over whatever lands in the subtree. Runtime authors
+	should not delegate cgroup.freeze outside of the trust boundary
+	of the cgroup itself.
+
   cgroup.kill
 	A write-only single value file which exists in non-root cgroups.
 	The only allowed value is "1".
@@ -1063,6 +1072,15 @@ All cgroup core files are prefixed with "cgroup."
 	killing cgroups is a process directed operation, i.e. it affects
 	the whole thread-group.
 
+	A write to cgroup.kill sends SIGKILL to every process currently
+	in the cgroup or its descendants regardless of the writer's
+	signal authority over those processes. The file therefore acts
+	as a delegated kill knob: chowning it, or passing an open file
+	descriptor to it, grants the recipient unconditional kill
+	authority over whatever lands in the subtree. Runtime authors
+	should not delegate cgroup.kill outside of the trust boundary
+	of the cgroup itself.
+
   cgroup.pressure
 	A read-write single value file that allowed values are "0" and "1".
 	The default is "1".
-- 
2.34.1


