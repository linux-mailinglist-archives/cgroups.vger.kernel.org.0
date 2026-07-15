Return-Path: <cgroups+bounces-17843-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LgY1HZhdV2rfKQEAu9opvQ
	(envelope-from <cgroups+bounces-17843-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:14:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0575CD47
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jdrxhmen;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17843-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17843-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4192E30C70E3
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24043C7D9;
	Wed, 15 Jul 2026 10:11:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8943DA56;
	Wed, 15 Jul 2026 10:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110280; cv=none; b=m3d5eqWJQ0b8pcd4lsRuoRnUymt2k+yNBYmJRVU4WFe6dK7+D9VFHoVn75KngIEMIAAnxE4FM3ENOTPUy9a8hGn56Yw1p1YMOppYV636pp2rY7NAraViWbqOM6v0VYbfY4AVGGfdYVWkBYKOftuCEOdIfozSINIHOrql+6AXdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110280; c=relaxed/simple;
	bh=Mxf3aQzzm1ZlIgi0DL+4j9W5p2xB6gAnyg59IfYqc3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reXHuoslmRmc6yIBE1pmHcV0WxEHJzxw3PWy6FlkSXye0B1BYUH4QAO1PC5FqzINRcj3kJ0U7D2hsotI6G5/yA+8fPjCl2k4mJEJKAA8jQKawoslByVxTAjc5V3x3yGW9g9IZH1DUVMdGK/Opqkl9ZwfA1vVqxYi/BHUvdyYyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdrxhmen; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E2D1F00A3A;
	Wed, 15 Jul 2026 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784110278;
	bh=B2kW+nJ77Mj5M53RnXhGqydD3hqQWm7pjmVwGgIrn1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jdrxhmenWOsGlFcFe34zNIcdL7yScchP+BGEXwVOT4VENtyhZdFST8n9qyp6/L4Yp
	 SWFYyCccxOp3weHr3MOPD+5gneEjf5ugtTQL+LgQOryTgr1mAnLlydiRjoqmwR4TYu
	 +Bpzf045bXGHBWADEZiVvUV2JsqNsXcQlm0/YrEgD6O34cGoIO6UrbfWpQRH0giKWs
	 CF3htpkQHU4rW8ss6v/x9sreGGx95uCcmruWcL01MlduUv/6CNnJRhuHkrKnSIVCa4
	 462mibkP9u12I9xjfmgn+Zf4E0JAtqA23X+lHwr3La55OrIyWgykAuBm0rq7nq2Hwl
	 5jFoqHW+fSK5w==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 15 Jul 2026 12:10:50 +0200
Subject: [PATCH RFC 10/12] mm/slab: reduce slabobj_ext memory with
 allocation profiling disabled
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b4-objext_split-v1-10-9a49c4ccf4c3@kernel.org>
References: <20260715-b4-objext_split-v1-0-9a49c4ccf4c3@kernel.org>
In-Reply-To: <20260715-b4-objext_split-v1-0-9a49c4ccf4c3@kernel.org>
To: Harry Yoo <harry@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Cc: Hao Li <hao.li@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:surenb@google.com,m:hao.li@linux.dev,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:akpm@linux-foundation.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17843-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCC0575CD47

When memory allocation profiling is compiled in but permanently disabled
on boot with (implicit or explicit) "never" parameter, stop allocating
(wasting) memory for the codetag_ref parts of slabobj_ext metadata.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index dcca86799fc9..a50347c9dbe3 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -587,7 +587,7 @@ static inline size_t static_obj_ext_size(void)
 	if (IS_ENABLED(CONFIG_MEMCG))
 		sz += 1;
 
-	if (IS_ENABLED(CONFIG_MEM_ALLOC_PROFILING))
+	if (slab_obj_ext_has_codetag())
 		sz += 1;
 
 	return sizeof(struct slabobj_ext) * sz;

-- 
2.55.0


