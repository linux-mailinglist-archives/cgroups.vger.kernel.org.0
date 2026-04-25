Return-Path: <cgroups+bounces-15510-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHCICxp27GmxYwAAu9opvQ
	(envelope-from <cgroups+bounces-15510-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 25 Apr 2026 10:06:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C204657AB
	for <lists+cgroups@lfdr.de>; Sat, 25 Apr 2026 10:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A7D300EFA9
	for <lists+cgroups@lfdr.de>; Sat, 25 Apr 2026 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D0347500;
	Sat, 25 Apr 2026 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="KfXThExN"
X-Original-To: cgroups@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9701D61BC;
	Sat, 25 Apr 2026 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777104392; cv=none; b=cJ7AbDdb5HfahCJOz91qV3KLKra9iYDLf00PDcyaNYrWxGQfZ2yR6LUZegcJktVHnreqzJP39Zu1mdaLiMToG7eAGwdzqGuxj71VTa7pVS728iiLmNuG+7yGdA1J9pdypLDXI5na79FCIa0zggUEa2stUSq7mcw18IWYQpn5r3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777104392; c=relaxed/simple;
	bh=WukqgEXyzt3lEvecMmA1cVOBTeskplP7LzTy732lSj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEYK4AEo+QJQayBH5dm+pMPV0q9iXqS6bhh0OgXMD/LyAg6jUy2FRm2k6Wt6jLpFSzGaixLFJ+pBLPPRfpJFsA+ZC46UJ+HZVQE18tv6LOZHSOymu3UhyAl7pqhxZu7tFruZxKfpcKYrqVTMLH86KJvY3odDqHcMsfUb95FvgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=KfXThExN; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-2.centrum.cz (localhost [127.0.0.1])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 33B9E201A048;
	Sat, 25 Apr 2026 10:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1777104273; bh=MLBs5mL7Vz8nEHOPOvqGcZ25cUTxaRGFwHJH88tyiEU=;
	h=From:To:Cc:Subject:Date:From;
	b=KfXThExNBaFj7nQyDu5lp7OupOrQHo/3XwwqJc23bYoK2oCQDZyjG3/Sxgb1NQhBT
	 E8sMSUsUQL9YelTNu7DMAm9a8Q3LtRWABBaMzaja/yRbFi7NyaAT1Rod8cvl+jkma7
	 KcjnTPmNi7NT2zEkn45mBwTklBWtnrh3iw02bKyU=
Received: from antispam66.centrum.cz (antispam66.cent [10.30.208.66])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 312822012EDA;
	Sat, 25 Apr 2026 10:04:33 +0200 (CEST)
X-CSE-ConnectionGUID: bj4PH1WsQhmhyRvAEgUAyw==
X-CSE-MsgGUID: wk+wJjPfTDiJ1NjfV8rmTg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2ERAgCcdOxp/03h/y5aHgEBCxIMSYE8C4JXYoF5hFidb?=
 =?us-ascii?q?odVik6Bfw8BAQEBAQEBAQEJUQQBAYUGjTMnNQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQEBCwEBBgEBAQEBAQYGAQKBHYYJU4JiAYQpBAsBRigBDAImAl4BEoMCg?=
 =?us-ascii?q?joBAza2OH8zGgJl3HkCSQVXZIEfAQsUAYEKLohYAYUChjCCDYR9hAqEFIJHI?=
 =?us-ascii?q?gSDHBSPLkiBAhwDWSwBVRMNCgsHBYEzMwMgCgsSEhgVAhQvDwQWMh1wDCcSL?=
 =?us-ascii?q?BczWBsHBYFLhAiBAVaBC4RbeCMaAwsYDUgRLDcGDhsEPQFuB4pLIA+BO3FhL?=
 =?us-ascii?q?YIDx1eEJoROnQoaM5deHwOSagGZBiKkN4RogWoCghIzIjCDIlMZoW4BuFZ2P?=
 =?us-ascii?q?wcCBwILA4JEjy80gUsBAQ?=
IronPort-PHdr: A9a23:7/z9gRZfBmjjqMnMHjDsCdz/LTH51oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wKPBd2QtKgf1KKW6/mmBTdcp87Z8TgrS99laVwssY0uhQsuAcqIWwXQDcXBSGgXO
 voHf3Jeu0+BDE5OBczlbEfTqHDhpRQbGxH4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyL
 BKrpgnNq8Uam4RvJ6gxxxfTvndEZ+tayGF2KV+dnRv3+8O88IJ+/yhKtP8s+cFNXb/mc6gkS
 LBTESgrPX0y6MD3uhbPSheC6GEBWWsMiBpIBAbF7BD+Xpjvtybxq/Rw1iqHM8DoVL44QTus4
 b9kRxPxlioJOCM3/HnYhcJsgq1bpgmhpwFkzI7PfI6VLvt+cbjDct4cWGFMQ9xeVy1FAoO7c
 osPE+8MNvtWooXhu1cDqwa1CBKyD+3z1DBHmn723bU70+s/FwHGwBcgFM8KvHjNsdn5KLseX
 eWzwaLVzzvMculW1C/95obWbB0vvP+CU7F3f8Xe1UYhGBjIjkmTpIH/Iz+YzPgBvmqd4uF9V
 eyvkWknqwRprza12MgslpPJjZ8axV/e8yV83oU1LsC/RUFhe96kE4FftySAOItsWc4tWX1ou
 CIgxb0do5K0YCkLxY0hyhXCZPOJb5KG7Qj/VOaNPzh4nnRldaqjihqu9UWt1PDwW8m63VtWr
 ydInMfAu24C2RLd98WLVOZx81uj1DuSyg3e6OBJLEE1mKfZKpMt3749m5UOvEnCGCL9hUb4j
 LeOe0gr++Wk8frrb7Xmq5OGKYN4lAHzPr4sl8G9Geg0LBUCUmaB9eiiyrHv4Vf1TKtFg/Eqi
 KXUtJHXKMIGraCjGQBVyJws6xOnAjej19QXgGcIIUpeeBKCk4jpI1bOIO3kDfung1SjjjNrx
 /feM73uB5XBN2PDkLL9fbZl9kJQ1BA/wsxB6JJSFrEBOu/zWkrruNPEDx41Kw20w+D5B9Vhz
 o4TVmOCDrWHPK7SsVKE/PwjL/eMaYMPujvwKeAp5/v0gn84nV8dc7Op3ZwSaH2gBPtmOUaZb
 mDpgtgbC2cHpRAxTPDuiFKYSj5ffWq9XqMk6jEhFI2mFZvDRpyqgLGZxii7BJ5WaXpDCl+WC
 3flbJ+LW+sIaC2IOc9tiCALVLm5R487yR6urBP6y6ZgLufM+i0Xr5Tj1N5r6O3Ijhw96Tl0D
 9yS0m6RT2F0kXkERzgs3KBwuUB90EuM0bBkg/xEEtxe/+9JUgUhOJ7f0eN6EdbyVRzFftuTT
 1amWNqmDSkrTt0t298Of1p9G9K6gxDY3CqqA6Ual7qQCZww86Lc2WXxJslzy3bByakhiUQpT
 dFTNW2nga5/8RLfB4nTk0WWj6qqb7gT3DbR9GefymqDpF1XUAlqUareQ38felDbrdD350PEV
 bOuD6ooMhdZxc6YNqRKcsHpjUlBRPr7PdTeYGWxm3qsBRaOxrKBd5Hqe3gG3CrDEkQLjwcT/
 XOeOQgkGiihu37eDCBpFV/3f0zs/vN+qHSmTk8s1AGHdFNh17Wr9R4Pn/CcSO0c3qgCuCg/r
 zV4BlG938jZC9aYvQpuYL1cYc8h4FdAzW/Zsw19Ppq9L6Ftn1IRbgN3sF/12hVpBYVPj9Iqo
 GkpzAVsM6KY1k1OdzeC0ZD3IL3XJTq6wBf6V6PUx1eW8NuRsvMT6tw7pk/lsQXvEVAtpTEv8
 d5V2n2a646CMwcTV5/rGhI3/h58qqryaSwl94jU2jtrK6bi9nfn2tkpDe9t6RG9Y9HKePeBF
 wjvD8sLL9OzM+FskF+sOFZMHudU/bI0NsXuXPyc0qO3dLJrmyisgHhv5J97lESB63w4AtXIw
 p8Fi9KY1w3PAyz/jF6nmsT2n51UazYPGGa21SnjAshWfKIkLqgRDmL7G8Cr3J1AjphOWDYM/
 USgDlYPwuegZR6bdBr2z1sDhgwsvXW7lH7gnHRPmDYzo//ahXSWq9k=
IronPort-Data: A9a23:asQ0Qa8H3M1AWTe0ksMcDrUDbX+TJUtcMsCJ2f8bNWPcYEJGY0x3m
 msfWTuObq7ZN2b9eotzOovg8RwO6pTUxoU1SAE5/yxEQiMRo6IpJzg4wmQcnc+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E3ra+G7xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2LBVOCvT/
 4mpyyHjEAX9gWAsbjhJs/vrRC5H5ZwehhtJ4zTSWtgU5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxH4
 I4U6cHvE1dB0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQSKmw1Tkm8nNu2xbKqcPdFq8seBdj0adZ3VnFIlVk1DN4pRNXYRrnSvIce1zo2mtpTGLDVd
 aL1axIzMlKaPkAJYA1KTs1h9AurriCXnzlwoUiWrK8++UDa0Ah4y/7mIrI5f/TTH5gFwhrF+
 DOuE2LRHRJZK/6d8TS53nOO38nNkx2rQocuG+jtnhJtqBjJroAJMzUfT1iypPCjokeiX9tEb
 UcGkgIupK40+VeDRdzlTxa4rziDpBF0c8ZSO+438geAzuzT+QnxLnMHTjdHQNgnstImSzs30
 FOAg9LuA3poqrL9YXma7L2ZsRu2Ji5TK2IeDQcBTgwY/9/yiJoulR+JRdFmeIa+gcfyBCnr6
 y6FoTJ4hLgJi8MPkaKh8jjvhzOqu4iMQgk+zhvYU3jj7Q5jYoOhIYuy5jDz6fdGMZbcTVSbu
 nUAs9aR4fpIDpyXkiGJBuIXE9mUC+2tbGOa2wMyWcN7qnLypBZPYLxt3d23H28xWu5sRNMjS
 BS7Vd95jHOLAEaXUA==
IronPort-HdrOrdr: A9a23:4EsnkK7+VtpHWJkuhAPXwNnXdLJyesId70hD6qm+c3Bom6uj5q
 WTdZUgpH3JYVkqNk3I9errBEDiewK+yXcW2+gs1N6ZNWGMhILCFu5fBOXZrgEIYxefytJg
X-Talos-CUID: =?us-ascii?q?9a23=3A2o8zDWvltwBS+L79iErFyJr46IsvcCHl7C7vOHa?=
 =?us-ascii?q?4DGZ4cqO8ZFCt0bJ7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AE5c8fw8wc+du1+hPax7S0D+Qf9hroLuMCngDrbk?=
 =?us-ascii?q?HmZCiNyJOay2YsDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,198,1770591600"; 
   d="scan'208";a="125844569"
Received: from unknown (HELO gm-smtp10.centrum.cz) ([46.255.225.77])
  by antispam66.centrum.cz with ESMTP; 25 Apr 2026 10:04:32 +0200
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp10.centrum.cz (Postfix) with ESMTPSA id B996A80891F7;
	Sat, 25 Apr 2026 10:04:32 +0200 (CEST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: cgroup: fix typo 'protetion' -> 'protection'
Date: Sat, 25 Apr 2026 10:03:54 +0200
Message-ID: <20260425080356.14731-1-arkamar@atlas.cz>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5C204657AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[atlas.cz,none];
	R_DKIM_ALLOW(-0.20)[atlas.cz:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[atlas.cz:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15510-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkamar@atlas.cz,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Fix a small typo in the description of the memory_hugetlb_accounting
mount option.

Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8ad0b2781317..6efd0095ed99 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -220,7 +220,7 @@ cgroup v2 currently supports the following mount options.
   memory_hugetlb_accounting
         Count HugeTLB memory usage towards the cgroup's overall
         memory usage for the memory controller (for the purpose of
-        statistics reporting and memory protetion). This is a new
+        statistics reporting and memory protection). This is a new
         behavior that could regress existing setups, so it must be
         explicitly opted in with this mount option.
 
-- 
2.52.0


