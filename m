Return-Path: <cgroups+bounces-13435-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IuQM8+fdmmOTAEAu9opvQ
	(envelope-from <cgroups+bounces-13435-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:57:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAEE82F88
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60D34309B23E
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96BE311C30;
	Sun, 25 Jan 2026 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct+/Hpif"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC330DD1A;
	Sun, 25 Jan 2026 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381380; cv=none; b=qnSzJoSxET4RX2mFm2ndxwI+d0lDKEQj5Q98wJ+pVAaKuIowG0BmBU2VQZiKCfk1u2unAQnHl5O8NztfXaIcD/z0WHKkehVzqYC8g9+dr7kFaLjp/TZFJ6Q35k1SyEVJQm61pmyIpDKvcOtPxsNrEqDSJtNWYICewrSHMNPSoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381380; c=relaxed/simple;
	bh=txAoH54KyHKbuey5FYwPXMe7a123Tyjq6wOFllqOg9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8Na8v2E3BpOjSyNJLC9Y+X6xhGntINCKR6+c9ZHSZHz9IWhuNDRyh0NESfAk4zGXfn5Pce/ZoEqHBpwmB/t5AhFF1yz2Ax8H+2c8MFM69EOHSYatIjSDwLeLrZweRFVXjuOJIPFeof3ZiGTSKkAzVR/3mGXlu8Gbo7RQ5P0ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct+/Hpif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3229EC4CEF1;
	Sun, 25 Jan 2026 22:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381380;
	bh=txAoH54KyHKbuey5FYwPXMe7a123Tyjq6wOFllqOg9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ct+/Hpif4Fc82u2iven2KRFCFhW56c3/+0FaStQzwSlTMN2Gippl3VCDYfCTDGlsH
	 grRUbkAjXxFz8QNUB32ATVc6ffl7ouZv2PQIqbvN0EmXZclBnjEpbADbXDw8OYIS6i
	 RYSxBDD9lok+I+KvwO2sO129c1HXWc4DfBbJmfGbA7lLTnLjszzo8qkICZAnGRGmF7
	 SmjCO4HNh4E+cJw7qaQN1zg4efuWoM6ocDBuEXWoktF2g9cEtNKKAozJwfn+fhoVY0
	 zUgi+HoSWTvagYHbpkikZfHRj1znB0oDpDKy9Bc2PDCxrGkPfYZQsaq7Fpj4bCfnKa
	 ds8venZCqWWkQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 28/33] sched: Switch the fallback task allowed cpumask to HK_TYPE_DOMAIN
Date: Sun, 25 Jan 2026 23:45:35 +0100
Message-ID: <20260125224541.50226-29-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260125224541.50226-1-frederic@kernel.org>
References: <20260125224541.50226-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,vger.kernel.org,lists.infradead.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13435-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.964];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FAEE82F88
X-Rspamd-Action: no action

Tasks that have all their allowed CPUs offline don't want their affinity
to fallback on either nohz_full CPUs or on domain isolated CPUs. And
since nohz_full implies domain isolation, checking the latter is enough
to verify both.

Therefore exclude domain isolation from fallback task affinity.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
---
 include/linux/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index ac01dc4eb2ce..ed3dd0f3fe19 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -24,7 +24,7 @@ static inline void leave_mm(void) { }
 #ifndef task_cpu_possible_mask
 # define task_cpu_possible_mask(p)	cpu_possible_mask
 # define task_cpu_possible(cpu, p)	true
-# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
+# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_DOMAIN)
 #else
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
-- 
2.51.1


