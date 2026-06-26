Return-Path: <cgroups+bounces-17330-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C9KTMgV0Pmp5GQkAu9opvQ
	(envelope-from <cgroups+bounces-17330-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 14:43:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAB6CD189
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 14:43:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="fKX/UsqN";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17330-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17330-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E8F5300E337
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C23F58C3;
	Fri, 26 Jun 2026 12:43:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B93CE0AE;
	Fri, 26 Jun 2026 12:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477811; cv=none; b=qz+j8kCr86iurY7o6jJ0cFf68uKhVXQxOd7c4fClu/zMnN8NoTYLcttOID/UHDcpliQkikPtM+HGfvYoIWOaFMF42Ozn+PQsfiz7u+7O8pNkQvXTJ+YOkYL/zsW9OUjWRQRl3D4zSXl2Ds4mkX34NIlW8cw7EgwT1yTC+QRyKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477811; c=relaxed/simple;
	bh=TA0Rd2ZjkVKCe2puqV8Hx8ZyVS5qHu93hA0Ef1x/rJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jus44wxHqPwjtWFALcDMU1aBdqOzUVWuUgxld1mgpo/aHTLV17Q7VIW3qlQFMdzW7z3jjlde0UvnGEYmkhH5AF6why84W4nfRAtukbKWwMkr7spxBnAFrhCYrRLWHAZMf9ZrgKZfyKH+7wyBURUPZ4eu0YUImiKO4OoU/lUY3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fKX/UsqN; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=LFehXIpnlAu03PJtDtW2qnYLqBakhJsXo9kxZSgtjTM=; b=fKX/UsqNQ6nMqZeZILWxRmcRBU
	WIMEUIkkkHx0fSyaGXaCkcvQpoOCMIKMVUhhhPuMoHBwPQnmh1j3tQJYD9h7k0T9KDqBzVB4rqhyG
	voPH+WIaazkBt8wktvWloNJZCMXpvzl8oV4nqkykiYPrDd9LkmNnkc5zbRl7/zoul0uHgqI9WVq+q
	TwdnT1NJGF77hHca+e+7RQx9v0Ax2QNK82BjvF3hW8vAUJRPAX+PN+tgZllorYHuvvYYzTadXgUg7
	UZXl8ynWJDSzDDrFYd8WtdR5GGbmt3JiPDdwepBr0UmlCGSETRo2Es4zghq9lhvuIrbyFRa2LdP62
	tfb+UNew==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd5tr-003yQV-0w;
	Fri, 26 Jun 2026 12:43:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 05:43:02 -0700
Subject: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare() stub
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
X-B4-Tracking: v=1; b=H4sIANVzPmoC/x3MQQqDMBAF0KsMf+2AjW3EXEW6kGRiB5tEkrYUx
 LsX+g7wDjSpKg2ODlT5aNOS4ejSEfxjyauwBjiC6Y3trbGcJPmVS0n8zpr1xc/iNwl8Ez9OIcb
 rMFl0hL1K1O9/nu/n+QM4Z5buaQAAAA==
X-Change-ID: 20260626-memcg-oom-uninit-locked-5ec79dff4396
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=leitao@debian.org;
 h=from:subject:message-id; bh=TA0Rd2ZjkVKCe2puqV8Hx8ZyVS5qHu93hA0Ef1x/rJo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPnPdMiNdj8Aq4cZwwmjfA6oz+iDQ4r12lOoi0
 SDtEabzzG2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj5z3QAKCRA1o5Of/Hh3
 bc8OD/44h+JH0trsSrMtwAxqLnmU2Dox724W+6lkQXsZkjA8VTyTHRLwsMNfUWS5BlfUuyhmASR
 CrcCCiZvvDS6mNl9b9JG8+N9yrgdXJVUPWgQkllyG3MjESZ1iFxb49An6dK9nVgTmAy3NdimsnP
 BVAeUAyY0iR3wTVYIOAuHC5wk6Lo07qjFzDdZ4NpqEkWdBSw1xb79uniGPbLaMA76xCqtgBlmrw
 BLTcvj0VVJjpCuvNUZZVhAbURSNpdGmV7VPXTP7h2jDUhPgV3jQXWBZt32+e2i60nk2rcWbvchw
 /mj0yQNGHdjCd03ssT5VBOOCHSgIkqNlfitHxBjqVi39vIDvMq9m2h1Y2B/NI8JOkBX0zySxAvv
 7Kk67mcOG98Km5KEkDlzYijy7zZ4WaRQJ4ezlFweb5KItqfNM81ZXZf60UUnDKXrlNN6BRVSav8
 /NYC+CQpPt+07QnuP4zaj3mu3zfKo1Jdn4heQkg5bmeVDEY84ququEc0Rt6nx5XukUy1BqOt3lU
 XDhMQsuTMJVYuJulL+upwwK3JhvA1dkPGIgP53MPoyTaL4ngehHCg6tSjbNwYUpUPe/4+uEP3Gc
 94AJlSSYQPzbtno6BoQLELmlAHpr/kzXUCO1f4E/S6fm2Whl7MqIasISB0TKqMgsrOEMIGi4FNC
 8kWKKL7vZoISKLQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mhocko@suse.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,m:leitao@debian.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-17330-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1AAB6CD189

mem_cgroup_oom() passes an uninitialized "locked" to memcg1_oom_prepare()
and reads it back in memcg1_oom_finish():

	bool locked, ret;
	...
	if (!memcg1_oom_prepare(memcg, &locked))
		return false;
	ret = mem_cgroup_out_of_memory(memcg, mask, order);
	memcg1_oom_finish(memcg, locked);

This relies on memcg1_oom_prepare() setting *locked whenever it returns
true.  The CONFIG_MEMCG_V1=y version does, but the stub used when
CONFIG_MEMCG_V1=n returns true without touching *locked, so
memcg1_oom_finish() consumes an uninitialized value.  On a memcg OOM this
is reported by UBSAN:

  UBSAN: invalid-load in mm/memcontrol.c:1932:27
  load of value 0 is not a valid value for type 'bool' (aka '_Bool')

Initialize *locked to false in the stub; with cgroup v1 compiled out
there is no OOM lock to take.

Fixes: e93d4166b40a ("mm: memcg: put cgroup v1-specific code under a config option")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memcontrol-v1.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index f92f81108d5ed..4fa6e2bc8413f 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -107,7 +107,11 @@ static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
 static inline void memcg1_css_offline(struct mem_cgroup *memcg) {}
 
-static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) { return true; }
+static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked)
+{
+	*locked = false;
+	return true;
+}
 static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
 static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
 

---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260626-memcg-oom-uninit-locked-5ec79dff4396

Best regards,
-- 
Breno Leitao <leitao@debian.org>


