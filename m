Return-Path: <cgroups+bounces-15634-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGkNKkkt+2npXAMAu9opvQ
	(envelope-from <cgroups+bounces-15634-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:00:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C434D9EA3
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC4A930234D5
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559B543E4AE;
	Wed,  6 May 2026 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sLy1RwEV"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013C42849F;
	Wed,  6 May 2026 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068805; cv=none; b=Id4sKGNIy0+/EGlXKD5L6VcHgXxKfzVWLeCPy/MRUT5unhAW8qphM6j+w4zzeKELS4vY7a1F3V7mYEIo+tX97NC1YZkmom1gG385P8K+NZGLazmdlclGA2ZAg1MUZSmuGKJUVnp1v2NQp3QAVNFMTAHwwVlYv2CPyVWaEPzJCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068805; c=relaxed/simple;
	bh=/UJiNBPfhQ7ZoiwH2t7bGR4vZrqMEBp2BNrrv8IlOn8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kmu0g30/XlCxkbdWq0CBOAbi0B0t7ZlU3EBmltT6lDXMq+Nv/01IBkiOmenzOk7DVWO57FWOohWR9qKpKX+ft34BE2lfEFLbMDRNdWwUfCwMgmCchM9ULLxF3OiV5djO8O3vmppmSOp8QxGed3gckkLuLxoU6Vl9I4qwVlpChtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sLy1RwEV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MAx5G3WSi0kn9ozTKXHHjJK+xQtPpNgVE01pyUEzytU=; b=sLy1RwEVyh+Up45cOede75X0BY
	Vg/Hck2X1D5mnV3o4sM7dwPt0DX+j48Jhgbhth2lR3Il/K6IKrrqlsYzsYDIbqWnn6QSdVo/sDyMJ
	KaLFEfuhgC1kead3PAhLt9BZAo31HyJtSFh4qk9x0UG3f7lPFeYz+9yRcHU2YA9xgHuQK8onDQiF6
	1BCDWpXlh1BNcGm5HzBB9em2GVlXOuMbIBzgYbtDHFAo2BHfC+dMPPOlHKN3dG6QFstqZdzJuLNxK
	sWn+Ti2u8XjwTYFi7jaLxRZiaNJfWIOpJaooY+KDmi3n/ZbN8IqlihtXJn5UEYFNPSfk0CDIBCcmM
	bBkYCi3Q==;
Received: from 179-125-92-238-dinamico.pombonet.net.br ([179.125.92.238] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wKaux-006sxt-VE; Wed, 06 May 2026 13:59:55 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 0/2] cgroup/dmem: introduce a peak file
Date: Wed, 06 May 2026 08:58:23 -0300
Message-Id: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAs+2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3ZTc1Nz4gtTEbF3jxKRkw6RUS1MDcyMloPqCotS0zAqwWdGxtbU
 AI5qMh1sAAAA=
X-Change-ID: 20260409-dmem_peak-3abc1be95072
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
X-Rspamd-Queue-Id: D8C434D9EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15634-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]

Just like we have memory.peak, introduce a dmem.peak, which uses the
page_counter support for that.

It can be written to in order to reset the peak, but different from
memory.peak, which expects any write, dmem.peak expects the region name to
be written to it. That region peak is the one that is reset.

That requires ofp_peak to carry a pointer to the pool that was reset.

Writing a different region name will reset the different region and make
the original region peak get back to its non-reset value.

While at it, we reuse a helper from memcontrol, which we moved to
kernel/cgroup/cgroup.c.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Thadeu Lima de Souza Cascardo (2):
      mm/page_counter: decouple peak_reset from peak_write
      cgroup/dmem: introduce a peak file

 Documentation/admin-guide/cgroup-v2.rst |  10 +++
 include/linux/cgroup-defs.h             |   7 ++
 kernel/cgroup/cgroup.c                  |  32 ++++++++
 kernel/cgroup/dmem.c                    | 132 ++++++++++++++++++++++++++++++--
 mm/memcontrol.c                         |  42 ++--------
 5 files changed, 183 insertions(+), 40 deletions(-)
---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260409-dmem_peak-3abc1be95072

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


