Return-Path: <cgroups+bounces-14733-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK1CCqsDsGkWegIAu9opvQ
	(envelope-from <cgroups+bounces-14733-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 12:42:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F224B5E9
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 12:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31224313AF9F
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A5389116;
	Tue, 10 Mar 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JPg4yHxS"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39643C07A;
	Tue, 10 Mar 2026 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142754; cv=none; b=p1/V6w/VqJgWL07Un1raFCTx4GWN1rj8u/jFBTjT66uN4KqSnFdo2BP6SPF+58jE7IiFwoZ6km+cuq3h8bIoHdOBXNGQw44X67VkWF/pepWb9UOyt2MydbXY3QXTNQ2CHqYmjIuOYi1l+OCFNASvSd+Dm80IhuslfQResX+8pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142754; c=relaxed/simple;
	bh=3/aixo0lVFgWCzZziINgDCu6r9kFdh/SQnLrlKhfSm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6TmILABddiVY/KqIDSrlsjIT3dF5NkLT+OQ9Yz0iGwVn0OIdvKv1v2nzx2o0ZfgqKXawXUeMF7csHbyan1YJIwsTG+3DZj1Xu6C+5/e9nBnDBaNUXavUxpLVvlSOEWFtuqc2Fbjka50VGhTi1Ti6UBqe0DsrUxb9Nav3e3uT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JPg4yHxS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Dl
	bppZcw7Bols0n34L6K8JFTRaNL701/JTjAGVZvn6I=; b=JPg4yHxSqT21AGjjiV
	YtSDD1/8otWOhrKofO9Onrj6ieTCiINPkoUnNRQHo2K7x0CoJuBVY0UV4PbelBhh
	imAeLne7foQZpOWlkc5PcEVRM4wWD1PefHCN+NbLOYfrIX/2rcAx7lryKYwoioHg
	G6A5mg52fwON4rczkt/ymRncg=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXvQ+eArBpwhXAAA--.11763S2;
	Tue, 10 Mar 2026 19:38:07 +0800 (CST)
From: ranxiaokai627@163.com
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	harry.yoo@oracle.com,
	hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH 0/2] fix kmem over-charging for embedded obj_exts array
Date: Tue, 10 Mar 2026 11:38:02 +0000
Message-ID: <20260310113804.245647-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXvQ+eArBpwhXAAA--.11763S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry8KFyfJFW3Jw4fur15Arb_yoWkKFg_ZF
	Z2qas8Xr4UGFyDGa47CF4UJFy3Ja13Jr4rGF17JrsrCF97KwnrArnxX3yxZ34kZF4rCwn8
	J3y5Wr1Fvr1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMjjqJUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxh8uemmwAp9lNgAA3a
X-Rspamd-Queue-Id: 689F224B5E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,zte.com.cn,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14733-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zte.com.cn:email]
X-Rspamd-Action: no action

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since commit a77d6d338685 ("mm/slab: place slabobj_ext metadata
in unused space within s->size"), the struct slabobj_ext array can
use slab leftover space or be embedded into the slub object to save
memory. In these cases, no extra kmalloc space is allocated for the
obj_exts array.

However, obj_full_size() always returns extra sizeof(struct obj_cgroup *)
bytes for every object, which leads to over-charging for slabs with
embedded obj_exts.

This series optimizes obj_full_size() to check whether obj_exts uses
slab leftover space or is embedded in the object. If so, only the object
size is charged. Otherwise, the extra obj_cgroup pointer space is also
charged.

Patch1 moves obj_exts_in_slab() definition to slab.h so it can be
       called from memcontrol.c.
Patch2 updates obj_full_size() to avoid over-charging.

Ran Xiaokai (2):
  mm/slab: move obj_exts_in_slab() definition to slab.h
  memcg: fix kmem over-charging for embedded obj_exts array

 mm/memcontrol.c | 19 ++++++++++++++-----
 mm/slab.h       | 19 +++++++++++++++++++
 mm/slub.c       | 19 -------------------
 3 files changed, 33 insertions(+), 24 deletions(-)

-- 
2.25.1



