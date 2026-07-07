Return-Path: <cgroups+bounces-17554-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AM2IHHTJTGobpwEAu9opvQ
	(envelope-from <cgroups+bounces-17554-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 11:40:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40505719E68
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 11:40:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=oTcK4EVx;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17554-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17554-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCE8C3010D28
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453073B892D;
	Tue,  7 Jul 2026 09:38:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FA3B637A
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 09:38:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417131; cv=none; b=NNMDLC7C0cLZcATeB2N3cGeBWjxPM9M33c8JNjQx+YiC0/2YhzTnueNJoPMXogw1m7cLsCU4nDlcTxNFWqAKtxYbiTdEIxGreZco2pprRirqAmuqhHu03eDrbHfdXkzH3+CFZsaROG8EuC1VqDAIC4mFqQZHp6/5eWCDywBT0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417131; c=relaxed/simple;
	bh=H/XYDskgizUKUqTNKg3AUKDlLp6hMCBUIi21GzcLaB8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=XQCGNSLkxiHKOnh51EOH3GVmotWqUMWsAGETSOE6ciQfuG+f31jHTA6qvWVAVtMOHevVXl29ISH0uHZ3lbJ/vrZ9scl3z+8bk2c/1OeUJI8gb/F5zcRIDddwjXXmNG2Wxl7T9/f443qqk51gwLIBYYBEj5lffEUe0p8duiHSCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oTcK4EVx; arc=none smtp.client-ip=91.218.175.186
Message-ID: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783417110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=81JSG6w2tPh5xLW4dgWvCCuTi+vlHxWAgKmbEEuJMmI=;
	b=oTcK4EVx2B8Ljv/pIfP+FxJpn76Oi0kUf3J23SeIOMhzRT3149x1fiJ51nZ/X39c5ViT/j
	eAAZqMFSbGlvr82wJ/GBtyVd86/HH99DRyhRcFwWvgEDx4d2RjIOEF3A4eJA8zA3c3uQsL
	gICmKcQwZKkcUPNad2N2MuofNU4E3Wk=
Date: Tue, 7 Jul 2026 17:38:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
To: linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: cgroup/test_zswap failed with "zswpout does not increase after test
 program"
Cc: hannes@cmpxchg.org, yosry@kernel.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, tj@kernel.org, mkoutny@suse.com,
 Shuah Khan <shuah@kernel.org>, mhocko@kernel.org,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17554-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghui.yu@linux.dev,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,gmail.com,linux.dev,suse.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghui.yu@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40505719E68

Hi,

Running cgroup/test_zswap on my arm64 box failed immediately with:

  [root@localhost cgroup]# ./test_zswap 
  TAP version 13
  1..8
  # zswpout does not increase after test program
  not ok 1 test_zswap_usage
  [...]

I'm sure that pages are successfully written into zswap by checking the
count_memcg_events(.., idx=ZSWPOUT, ..) trace events. But "zswpout_after"
in test_zswap_usage() is 0 and results in this failure.

I guess the problem is that (in this particular case) the memcg stats has
not been flushed when userspace reads it.

 memcg_stat_format()
   mem_cgroup_flush_stats()
     __mem_cgroup_flush_stats(.., force=false)
       needs_flush = memcg_vmstats_needs_flush();

 static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 {
 	return atomic_long_read(&vmstats->stats_updates) >
 		MEMCG_CHARGE_BATCH * num_online_cpus();
 }

I can image that memcg_vmstats_needs_flush() will return false because I'm
testing a 16k-page-size kernel on a box with 96 cpus..

As we have a periodic flusher flushed all the stats every 2 seconds, I use
the following diff to wait the flusher to expose the accurate stats to
userspace.

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 3ce134509041..9596f294da0b 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -95,6 +95,8 @@ int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
 
+	sleep(2);
+
 	ret = read_text(path, buf, len);
 	return ret >= 0 ? 0 : ret;
 }

I have no idea how to "fix" it properly. Please have a look!

Thanks,
Zenghui

